<!-- Source: https://flueframework.com/docs/guide/channels -->

Channels bring provider HTTP events into a Flue application. A channel verifies
the provider request, parses it into typed provider-native data, and calls your
application handler. Your handler can dispatch work to an agent, invoke
application code, or return a provider-specific response.

Channels are intentionally focused on inbound HTTP. They are not universal
clients for Slack, GitHub, Stripe, or another provider. Use the provider’s
established SDK for outbound API calls, then expose only the operations your
application or agents need.

## Add a channel [\#](https://flueframework.com/docs/guide/channels/\#add-a-channel)

Use `flue add` to give your coding agent the integration blueprint for a
first-party channel:

```
flue add channel slack --print | codex
```

The blueprint inspects the project and creates a module such as
`src/channels/slack.ts`. A typical channel module exports:

```
import { createSlackChannel } from '@flue/slack';
import { WebClient } from '@slack/web-api';

export const client = new WebClient(process.env.SLACK_BOT_TOKEN);

export const channel = createSlackChannel({
  signingSecret: process.env.SLACK_SIGNING_SECRET!,

  // Path: /channels/slack/events
  async events({ payload }) {
    if (payload.type !== 'event_callback') return;
    // Handle payload.event using Slack's native types and fields.
  },
});
```

The named `channel` export is the Flue integration. The named `client` export is
ordinary application code initialized with the provider SDK. A channel module
may also export application-owned tools or helper functions.

See the [Ecosystem](https://flueframework.com/docs/ecosystem/#channels) for first-party packages
and provider-specific setup.

## Custom Channel [\#](https://flueframework.com/docs/guide/channels/\#custom-channel)

When Flue does not provide a first-party channel, give `flue add` the provider’s
webhook documentation and select the generic channel blueprint:

```
flue add channel https://provider.example/webhooks --print | codex
```

The blueprint guides your coding agent through creating a discovered
`channels/<provider>.ts` module, verifying requests against the unconsumed body,
preserving provider-native events, and adding the provider’s established SDK for
outbound calls. Review the generated code and test valid and invalid signatures,
protocol handshakes, responses, and the configured Node or Cloudflare target.

See the [generic channel blueprint](https://github.com/withastro/flue/blob/main/blueprints/channel.md)
for the full implementation and verification checklist.

## Understand ownership [\#](https://flueframework.com/docs/guide/channels/\#understand-ownership)

Flue channels own the provider ingress boundary. Your application owns how that
event affects the rest of the system.

| Concern | Owner |
| --- | --- |
| Request authentication and signature verification | Channel package |
| Provider handshakes and automatic protocol responses | Channel package |
| Body limits, parsing, and typed provider payloads | Channel package |
| Discovered routes beneath `/channels/<name>/...` | Flue |
| Provider SDK client and outbound credentials | Application |
| OAuth, installation, token storage, and token rotation | Application |
| Agent tools and authorization policy | Application |
| Delivery deduplication and business persistence | Application |

This boundary keeps each provider’s large outbound API in its established SDK
instead of rebuilding it inside Flue. Provider ecosystem guides can document
useful SDK operations, but those methods remain SDK capabilities rather than
features implemented by the channel package.

## File-based routing [\#](https://flueframework.com/docs/guide/channels/\#file-based-routing)

Each immediate file beneath `channels/` exports one named `channel` binding.
The filename defines its route namespace:

```
src/channels/github.ts -> /channels/github/webhook
src/channels/slack.ts  -> /channels/slack/events
                          /channels/slack/interactions
                          /channels/slack/commands
```

The provider package defines one or more fixed, non-empty suffixes such as
`/webhook`, `/events`, or `/interactions`. The namespace itself, such as
`/channels/slack`, is not an endpoint.

No `app.ts` is required. If an authored application mounts `flue()` beneath a
prefix, discovered channels receive the same prefix as agents and workflows:

```
import { flue } from '@flue/runtime/routing';
import { Hono } from 'hono';

const app = new Hono();
app.route('/api', flue());

export default app;
```

This publishes the Slack Events API route at
`/api/channels/slack/events`. An authored application can prefix all Flue
routes, but it cannot relocate one discovered channel independently.

Use an application-owned Hono route instead when a provider requires a fully
custom URL. See [Routing](https://flueframework.com/docs/guide/routing/).

## Handle verified events [\#](https://flueframework.com/docs/guide/channels/\#handle-verified-events)

Each provider constructor accepts callbacks for its HTTP surfaces. The callback
runs only after the package has performed the applicable request
authentication, parsing, and protocol handling. Handshakes that do not represent
application events are handled before the callback:

```
import { dispatch } from '@flue/runtime';
import { createSlackChannel } from '@flue/slack';
import assistant from '../agents/assistant.ts';

export const channel = createSlackChannel({
  signingSecret: process.env.SLACK_SIGNING_SECRET!,

  // Path: /channels/slack/events
  async events({ payload }) {
    if (payload.type !== 'event_callback') return;

    switch (payload.event.type) {
      case 'app_mention': {
        const event = payload.event;
        await dispatch(assistant, {
          id: channel.conversationKey({
            teamId: payload.team_id,
            channelId: event.channel,
            threadTs: event.thread_ts ?? event.ts,
          }),
          input: {
            type: 'slack.app_mention',
            eventId: payload.event_id,
            text: event.text,
          },
        });
        return;
      }
      default:
        return;
    }
  },
});
```

The callback receives one extensible object containing the authentic Hono
context as `c` and provider-specific typed data such as `payload`, `event`, or
`interaction`. First-party channels prefer authoritative provider-maintained
types and preserve provider field names, nesting, and discriminants. Use a
`switch` to group provider event types that share behavior, and consult the
provider package reference for its exact callback shape.

Some providers expose multiple optional surfaces. Omitting an optional callback
omits its route instead of publishing an empty handler.

## Return provider responses [\#](https://flueframework.com/docs/guide/channels/\#return-provider-responses)

Channel callbacks use ordinary Hono and Fetch responses:

- Return nothing when an empty successful acknowledgement is appropriate.
- Return `c.json(...)`, `c.text(...)`, or another `Response` for explicit
status, headers, or body control.
- When supported by the provider package, return a JSON-compatible value to use
it as the response body.

Provider protocols may narrow the accepted return values. Discord interactions
require a provider response, Slack view submissions can return validation
errors, and Twilio handlers use explicit responses for provider-specific XML or
other bodies. Follow the provider guide and API reference for the exact
contract.

## Deliver events to agents [\#](https://flueframework.com/docs/guide/channels/\#deliver-events-to-agents)

Use `dispatch(...)` when an accepted event should become asynchronous input to
a continuing agent:

```
if (payload.type === 'event_callback' && payload.event.type === 'app_mention') {
  await dispatch(assistant, {
    id: channel.conversationKey(thread),
    input: {
      type: 'slack.app_mention',
      eventId: payload.event_id,
      text: payload.event.text,
    },
  });
}
```

Your application chooses the agent and instance id before dispatch. A provider
thread, issue, ticket, or conversation is often a useful instance boundary
because later events continue the same agent session.

Conversation keys are canonical identifiers, not authorization capabilities.
If a caller can select an agent id through another route, authorize that id
before deriving provider destinations or outbound tools from it.

A dispatched event is an operation inside an agent session. It is not a
workflow run. See [Agents](https://flueframework.com/docs/guide/building-agents/) for continuing agent
state and [Workflows](https://flueframework.com/docs/guide/workflows/) for finite invocations.

## Use provider SDKs [\#](https://flueframework.com/docs/guide/channels/\#use-provider-sdks)

Initialize the provider’s established SDK in application code and export the
client from the channel module:

```
import { defineTool } from '@flue/runtime';
import { Octokit } from '@octokit/rest';
import * as v from 'valibot';

export const client = new Octokit({
  auth: process.env.GITHUB_TOKEN,
});

export function commentOnIssue(ref: { owner: string; repo: string; issueNumber: number }) {
  return defineTool({
    name: 'comment_on_github_issue',
    description: 'Comment on the GitHub issue bound to this agent.',
    parameters: v.object({ body: v.string() }),
    async execute({ body }) {
      await client.rest.issues.createComment({
        owner: ref.owner,
        repo: ref.repo,
        issue_number: ref.issueNumber,
        body,
      });
      return 'Comment posted.';
    },
  });
}
```

Bind credentials and destinations in trusted code. Let the model select message
content or other intentionally variable values, not arbitrary account ids,
URLs, credentials, or provider methods.

There is no universal channel client or generic provider tool collection.
Provider APIs, authorization models, and SDKs are too different for a shared
outbound abstraction to preserve their capabilities well.

## Handle retries and delivery identity [\#](https://flueframework.com/docs/guide/channels/\#handle-retries-and-delivery-identity)

Channel packages are stateless and do not deduplicate provider deliveries.
Providers may retry failed requests, deliver events more than once, or deliver
them out of order.

Preserve the provider delivery or event id in application input when it is
useful for tracing. When duplicate admission is unacceptable, claim that id in
application-owned durable storage before performing external effects or
dispatching work.

Handlers wait for application work such as `dispatch(...)` admission before
acknowledging. Some packages impose a deadline so the provider receives a
response within its protocol window. A timed-out JavaScript operation cannot be
forcibly stopped and may still complete later, so a timeout does not replace
idempotency.

Retry behavior and useful delivery identifiers are provider-specific. See the
corresponding ecosystem guide.

## Protect sensitive provider data [\#](https://flueframework.com/docs/guide/channels/\#protect-sensitive-provider-data)

Keep credentials, raw request bodies, webhook response URLs, interaction
tokens, and other short-lived provider capabilities out of:

- model context;
- dispatched input;
- logs;
- durable agent session history.

Use those values only in immediate trusted application code. Provider identity
such as a workspace id, repository name, or channel id may still be sensitive
and does not by itself authorize an operation.

## Run on Node and Cloudflare [\#](https://flueframework.com/docs/guide/channels/\#run-on-node-and-cloudflare)

First-party channel packages use Fetch and Web Crypto and are tested on Node
and workerd. Flue Cloudflare builds enable `nodejs_compat`.

The outbound client remains application-owned. A client import successfully
bundling for Cloudflare is not proof that every SDK operation works there.
Provider blueprints select a credible cross-runtime client, and examples execute a
representative client operation in workerd without contacting the provider.
Validate any additional SDK paths your application depends on.

Long-lived sockets, polling loops, and provider-managed background transports
are outside the current channel model. Use verified HTTP delivery, or keep that
integration in application-owned infrastructure until Flue supports the
required transport.

## Other integration paths [\#](https://flueframework.com/docs/guide/channels/\#other-integration-paths)

[Chat SDK](https://chat-sdk.dev/docs) is a separate option when its
cross-provider conversation model, adapters, and chat-side state are a better
fit than provider-native first-party channels. In that design, Chat SDK owns
its adapter and state boundary, while application handlers call
`dispatch(...)` to deliver accepted messages to Flue agents.

## Next steps [\#](https://flueframework.com/docs/guide/channels/\#next-steps)

- [Ecosystem](https://flueframework.com/docs/ecosystem/#channels) — choose a first-party provider.
- [Agents](https://flueframework.com/docs/guide/building-agents/) — deliver events into continuing agent
sessions.
- [Routing](https://flueframework.com/docs/guide/routing/) — compose channels with application routes,
middleware, and a shared prefix.

## Docs Navigation

Current page: [Channels](https://flueframework.com/docs/guide/channels/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
