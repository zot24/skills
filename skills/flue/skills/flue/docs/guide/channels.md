> Source: https://flueframework.com/docs/guide/channels

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Channels


Last updated Jul 21, 2026<a href="/docs/guide/channels/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


A **channel** connects an external provider — Slack, GitHub, Stripe — to your agents: verified HTTP ingress that authenticates each incoming delivery and hands your code the provider’s native payload to route into agent conversations with [`dispatch(...)`](/docs/guide/building-agents/#dispatch). Channels are inbound-only; outbound provider calls stay in your application, written against the provider’s own SDK. This guide covers adding a channel to a project, the channel module and its mount in `app.ts`, delivering provider events into conversations, reading those deliveries inside the agent, outbound behavior through provider SDKs, and the channel catalog.

## Adding a channel

Every supported provider ships as a [blueprint](/docs/cli/add/) — a Markdown implementation guide your coding agent applies, rather than a package installer:

``` astro-code
flue add channel slack
```

Applying the Slack blueprint installs two packages and wires them into your project:

- `@flue/slack` — the **ingress** package: request verification and the channel’s HTTP routes.
- `@slack/web-api` — Slack’s own SDK, for **outbound** calls your application makes.

The result is one new module, `src/channels/slack.ts`, exporting the configured `channel` and the SDK `client`, plus a mount in `app.ts` and a reply tool bound into the target agent. Every channel follows the same split: Flue owns verified ingress, and outbound behavior stays in your application through the provider’s established SDK ([below](#use-provider-sdks)).

Each provider’s ecosystem page documents its environment variables — for Slack, `SLACK_SIGNING_SECRET` for inbound verification and `SLACK_BOT_TOKEN` for outbound calls. Supply them like any other secret; see [Provider credentials](/docs/guide/models/#provider-credentials).

## The channel module

A channel module configures the provider’s `create*Channel()` factory with a verification secret and one handler per protocol surface. The package verifies each request — signatures checked against the exact raw bytes, replay windows enforced, protocol handshakes such as Slack’s URL verification answered internally — and calls your handler only for authenticated deliveries, passing the provider’s native payload types alongside the Hono context `c`:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { dispatch } from &#39;@flue/runtime&#39;;
import { createSlackChannel } from &#39;@flue/slack&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const channel = createSlackChannel({
  signingSecret: process.env.SLACK_SIGNING_SECRET!,

  // Served at POST /channels/slack/events (with the mount below).
  async events({ payload }) {
    if (payload.type !== &#39;event_callback&#39;) return;
    if (payload.event.type !== &#39;app_mention&#39;) return;

    const event = payload.event;
    const thread = {
      teamId: payload.team_id,
      channelId: event.channel,
      threadTs: event.thread_ts ?? event.ts,
    };

    await dispatch(Assistant, {
      id: channel.instanceId(thread),
      // Slack redelivers events whose acknowledgement was slow or lost; the
      // event id names the delivery, so a retry never runs a second turn.
      idempotencyKey: payload.event_id,
      // Recorded once, when this delivery creates the conversation.
      initialData: {
        channelId: thread.channelId,
        threadTs: thread.threadTs,
        startedBy: event.user,
      },
      message: {
        kind: &#39;signal&#39;,
        type: &#39;slack.app_mention&#39;,
        body: event.text,
        attributes: { eventId: payload.event_id },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/slack.ts</span></figcaption>
</figure>

The handler filters the events the application cares about, chooses the receiving conversation, and dispatches a normalized message. Everything in the `dispatch(...)` call is covered in [Delivering into a conversation](#delivering-into-a-conversation) below, except `idempotencyKey` — that is the redelivery convention, covered next.

The channel packages share a few conventions:

- **Handlers select routes.** Each configured handler publishes its route (`events` → `/events`, `interactions` → `/interactions`, …); omit a handler and its route does not exist. Most providers expose a single `webhook` handler at `/webhook`.
- **Return values become responses.** Returning nothing produces an empty `200`; a JSON-compatible value becomes a JSON response; a `Response` passes through unchanged — for the surfaces (like Slack slash commands or Discord interactions) whose protocol reads the acknowledgement body. See each package’s reference for its exact contract.
- **Acknowledge quickly.** `dispatch(...)` resolves as soon as the message is durably admitted — the agent runs asynchronously. Providers retry slow acknowledgements, so admit the work and return rather than awaiting agent output in the handler.
- **Deliveries can repeat.** Providers retry failed requests and may deliver an event more than once; channel packages are stateless and do not deduplicate. Pass the provider’s redelivery-stable id as the dispatch `idempotencyKey` — `idempotencyKey: payload.event_id` for Slack events — and a redelivered event converges on the original submission instead of running a second turn: same receipt (marked `deduplicated: true`), at most one answer. The key names the delivery, not the outcome, and reusing it with a different payload rejects with a 409 `submission_conflict`. Carrying the id in signal `attributes` as well keeps it visible for tracing.

## Mounting

A channel serves HTTP only where `app.ts` mounts it. The channel object exposes a `route()` factory — a pure, mountable sub-router serving the channel’s declared routes relative to the mount point:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as slack } from &#39;./channels/slack.ts&#39;;

app.route(&#39;/channels/slack&#39;, slack.route());
// Slack&#39;s Events API endpoint is now POST /channels/slack/events</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`/channels/<provider>` is a convention, not a requirement — the suffixes shift with whatever mount you choose, and the URL you register with the provider is the mount plus the suffix. The dispatch-target agent needs no mount of its own: the `'use agent'` directive registers it, and registration is all `dispatch(...)` requires. See [Dispatch-only agents](/docs/guide/routing/#dispatch-only-agents) in the Routing guide for how channel mounts sit alongside the rest of the route map.

Unlike agent mounts, channel routes need no additional authentication middleware for the provider traffic itself — verification against the provider’s secret is the authentication, and it happens inside the channel before your handler runs.

## Delivering into a conversation

The `dispatch(...)` call in a channel handler makes three decisions: which conversation receives the event, what the message says, and what the conversation is about.

### The conversation id

Every delivery dispatched to the same `id` lands in the same durable conversation, so the id determines which events share history. For conversation-shaped providers — a Slack thread, a GitHub issue, a Teams chat — the natural mapping is one agent conversation per provider destination, and those channels expose an `instanceId()` helper that derives a canonical, collision-free id from the destination’s identifying fields:

``` astro-code
channel.instanceId({ teamId, channelId, threadTs }); // "slack:v1:T0123:C0456:1721760000.123456"
```

The id identifies the conversation; it does not authorize access to it — protect mounted conversations as described in [Protecting your agents](/docs/guide/routing/#protecting-your-agents). `parseInstanceId(id)` recovers the destination fields from a canonical id, but it is an escape hatch: prefer passing structured facts through `initialData` (below) over parsing them back out of the id.

Event-feed providers — Stripe, Shopify, Notion, Resend — have no inherent conversation shape, so their channels have no `instanceId()` helper. Choose the id from the event yourself: per customer, per order, per occurrence — the same choice a [schedule](/docs/guide/schedules/) makes.

### Signals

Channel deliveries are dispatched as `kind: 'signal'` messages, not `kind: 'user'`. A Slack thread or GitHub issue is a multi-participant surface the agent joins as one member — a `user` message would present every participant as the agent’s own user, where a signal carries the event with its metadata intact:

- `type` — a namespaced event name you choose (`'slack.app_mention'`, `'github.issue_comment.created'`).
- `body` — the message content, a plain string.
- `attributes` — a string-to-string map of structured facts your verified handler attaches: sender, delivery id, resource identifiers.

Keep short-lived provider capabilities — interaction tokens, `response_url` values — out of the dispatched message: signals enter model context and durable history, and those values belong only in immediate request handling. The full message shape is [`DeliveredMessage`](/docs/reference/agent-api/#deliveredmessage) in the Agent API.

### Creation data

`initialData` is recorded once, when the dispatch creates the conversation, and ignored by every later send. It carries the facts that define what the conversation *is* — the thread, the repository, the ticket — as opposed to what each message *says*. When the agent declares an `initialData` schema static, the value is validated at admission, so a creating dispatch that omits or malforms it fails instead of seeding a broken conversation. See [Passing data to the agent](/docs/guide/agent-hooks/#passing-data-to-the-agent).

## Reading deliveries in the agent

Two hooks read these inputs inside the agent: [`useInitialData()`](/docs/reference/agent-hooks-api/#useinitialdata) returns the creation data, and [`useDelivery()`](/docs/reference/agent-hooks-api/#usedelivery) returns the message currently in front of the model as the same `DeliveredMessage` the channel dispatched:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useDelivery, useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { replyInThread } from &#39;../channels/slack.ts&#39;;

export function Assistant() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);

  const data = useInitialData&lt;v.InferOutput&lt;typeof Assistant.initialData&gt;&gt;();
  useTool(replyInThread(data));

  const delivery = useDelivery();
  const eventId = delivery.kind === &#39;signal&#39; ? delivery.attributes?.eventId : undefined;

  return &#39;You participate in one Slack thread. Reply with the reply_in_slack_thread tool when a response is called for.&#39;;
}

Assistant.initialData = v.object({
  channelId: v.string(),
  threadTs: v.string(),
  startedBy: v.optional(v.string()),
});</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

Because the schema static is required here, a conversation cannot exist without valid creation data, and no `undefined` narrowing is needed. Both hooks give *code* the same access the model has: the thread facts bind the reply tool without the model choosing a destination, and signal `attributes` carry identifiers your tools can trust because verified channel code attached them — the authorization pattern covered in [Protect access](/docs/guide/tools/#protect-access) in the Tools guide.

## Use provider SDKs

Channels are ingress-only: Flue has no outbound messaging API, no reply routing, and no send-message abstraction over providers. Outbound behavior belongs to your application, written against the provider’s own SDK — the blueprint installs one and exports a configured client from the channel module:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { WebClient } from &#39;@slack/web-api&#39;;

export const client = new WebClient(process.env.SLACK_BOT_TOKEN);</code></pre>
<figcaption><span>src/channels/slack.ts</span></figcaption>
</figure>

Application code calls the client directly, with the provider’s full documented surface. OAuth installation flows, token storage, and rotation are likewise application concerns, outside the channel package. To let the *model* act on the provider, wrap exactly the actions the application needs as [tools](/docs/guide/tools/), binding the destination in trusted code:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { defineTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;

export function replyInThread(ref: { channelId: string; threadTs: string }) {
  return defineTool({
    name: &#39;reply_in_slack_thread&#39;,
    description: &#39;Reply in the Slack thread bound to this conversation.&#39;,
    input: v.object({ text: v.pipe(v.string(), v.minLength(1)) }),
    async run({ data }) {
      const result = await client.chat.postMessage({
        channel: ref.channelId,
        thread_ts: ref.threadTs,
        text: data.text,
      });
      return { output: { ts: result.ts ?? null } };
    },
  });
}</code></pre>
<figcaption><span>src/channels/slack.ts</span></figcaption>
</figure>

The model selects the reply text; it cannot select the workspace, the thread, the credential, or the Web API method — those are fixed by the factory argument the agent supplied from its creation data. Avoid generic provider tools that expose arbitrary destinations or API methods unless the application has an explicit authorization design for them.

Because the SDK is the provider’s own, everything it documents is available without waiting for framework support — Slack’s assistant status and streaming-reply APIs, Octokit’s full GitHub surface, Stripe’s typed event handling — from tools, from [event hooks](/docs/guide/agent-hooks/#event-hooks), or from any other application code.

## The channel catalog

Flue publishes ingress packages and blueprints for these providers; each [ecosystem page](/docs/ecosystem/#channels) documents the provider’s routes, payload types, environment variables, and caveats. The packages are built on Fetch and Web Crypto and run on both the Node and Cloudflare targets. Each blueprint installs its provider’s ingress package (`@flue/slack`, `@flue/github`, …), named on the ecosystem page:

| Provider                                                                           | Blueprint                    |
|------------------------------------------------------------------------------------|------------------------------|
| [Slack](/docs/ecosystem/channels/slack/)                                           | `slack`                      |
| [Discord](/docs/ecosystem/channels/discord/)                                       | `discord`                    |
| [Microsoft Teams](/docs/ecosystem/channels/teams/)                                 | `teams`                      |
| [Google Chat](/docs/ecosystem/channels/google-chat/)                               | `google-chat`                |
| [Telegram](/docs/ecosystem/channels/telegram/)                                     | `telegram`                   |
| [WhatsApp](/docs/ecosystem/channels/whatsapp/)                                     | `whatsapp`                   |
| [Facebook Messenger](/docs/ecosystem/channels/messenger/)                          | `messenger`                  |
| [Twilio](/docs/ecosystem/channels/twilio/)                                         | `twilio`                     |
| [GitHub](/docs/ecosystem/channels/github/)                                         | `github`                     |
| [Linear](/docs/ecosystem/channels/linear/)                                         | `linear`                     |
| [Notion](/docs/ecosystem/channels/notion/)                                         | `notion`                     |
| [Intercom](/docs/ecosystem/channels/intercom/)                                     | `intercom`                   |
| [Zendesk](/docs/ecosystem/channels/zendesk/)                                       | `zendesk`                    |
| [Stripe](/docs/ecosystem/channels/stripe/)                                         | `stripe`                     |
| [Shopify](/docs/ecosystem/channels/shopify/)                                       | `shopify`                    |
| [Resend](/docs/ecosystem/channels/resend/)                                         | `resend`                     |
| [Salesforce Marketing Cloud](/docs/ecosystem/channels/salesforce-marketing-cloud/) | `salesforce-marketing-cloud` |

### Providers without a blueprint

For any other provider, pass a documentation URL and the generic channel blueprint guides your coding agent through the same shape — verified ingress as project source, the provider’s SDK for outbound, narrow application-owned tools:

``` astro-code
flue add channel https://developers.provider.example/webhooks
```

A channel is an object with declarative routes, so you can also write one by hand. `createChannelRouter(routes)` from `@flue/runtime` builds the same mountable sub-router the packaged channels’ `route()` returns:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import type { Handler } from &#39;hono&#39;;

const webhook: Handler = async (c) =&gt; {
  const rawBody = await c.req.text();
  // Verify the provider&#39;s signature against the raw bytes before parsing,
  // then dispatch into an agent exactly like a packaged channel.
  return c.body(null, 200);
};

export const channel = {
  routes: [{ method: &#39;POST&#39;, path: &#39;/webhook&#39;, handler: webhook }],
};</code></pre>
<figcaption><span>src/channels/acme.ts</span></figcaption>
</figure>

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createChannelRouter } from &#39;@flue/runtime&#39;;
import { channel as acme } from &#39;./channels/acme.ts&#39;;

app.route(&#39;/channels/acme&#39;, createChannelRouter(acme.routes));</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

Verify signatures against the exact unconsumed request body, keep every route suffix a non-empty path beginning with `/`, and test both valid and invalid signatures along with the provider’s protocol handshakes. Channels model verified HTTP delivery; long-lived sockets, polling loops, and provider-managed background transports stay in application-owned infrastructure.

## Next steps

- [Routing](/docs/guide/routing/) — the `app.ts` route map that channel mounts live in.
- [Agents](/docs/guide/building-agents/#dispatch) — `dispatch(...)`, receipts, and the other ways to reach an agent.
- [Tools](/docs/guide/tools/#protect-access) — binding trusted identifiers so the model can act without selecting destinations.
- [Agent API](/docs/reference/agent-api/) — `useDelivery()`, `useInitialData()`, and the `DeliveredMessage` shape.
- [Slack](/docs/ecosystem/channels/slack/) and the other [ecosystem channel pages](/docs/ecosystem/#channels) — per-provider setup, payloads, and configuration.


## Docs Navigation

Current page: [Channels](/docs/guide/channels/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


