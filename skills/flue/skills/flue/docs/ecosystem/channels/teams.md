> Source: https://flueframework.com/docs/ecosystem/channels/teams

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Microsoft Teams


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/teams/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/teams" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/teams</a>


## Quickstart

Add authenticated Microsoft Teams Bot Connector activities and project-owned outbound messaging to an existing Flue project with the [Microsoft Teams](https://www.microsoft.com/microsoft-teams) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel teams
```

## Overview

The blueprint installs `@flue/teams`, creates a source-root `lib/teams-client.ts` Fetch client and `channels/teams.ts` channel module, and modifies the selected agent to bind the generated message tool. The Fetch client handles OAuth token exchange and Bot Connector requests without adding Microsoft’s Node-oriented hosting SDKs.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { dispatch } from &#39;@flue/runtime&#39;;
import { createTeamsChannel } from &#39;@flue/teams&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const channel = createTeamsChannel({
  appId: process.env.TEAMS_APP_ID!,
  tenantId: process.env.TEAMS_TENANT_ID!,
  async activities({ activity }) {
    if (activity.type !== &#39;message&#39; || !activity.text) return;
    await dispatch(Assistant, {
      id: channel.instanceId(channel.destination(activity)),
      message: {
        kind: &#39;signal&#39;,
        type: &#39;teams.message&#39;,
        body: activity.text,
        attributes: {
          ...(activity.id === undefined ? {} : { activityId: activity.id }),
          senderId: activity.from.id,
          senderName: activity.from.name,
        },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/teams.ts (abridged)</span></figcaption>
</figure>

The abridged example omits the generated client and message tool. Once configured, a text activity continues the agent instance for its verified Teams conversation, and the bound tool can post a reply to the same Connector service URL and thread. The generated Fetch client runs on Node and Cloudflare Workers.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as teams } from &#39;./channels/teams.ts&#39;;

app.route(&#39;/channels/teams&#39;, teams.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/teams` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable             | Purpose                                               |
|----------------------|-------------------------------------------------------|
| `TEAMS_APP_ID`       | **Required** — Constrains the inbound JWT audience.   |
| `TEAMS_TENANT_ID`    | **Required** — Constrains activity tenant identity.   |
| `TEAMS_APP_PASSWORD` | **Required** — Authenticates outbound OAuth requests. |

It installs `@flue/teams` for authenticated Bot Connector ingress and creates a project-owned Fetch client for outbound messages.

Microsoft’s current JavaScript Agents and Teams SDKs declare Node runtimes and use Node-oriented authentication or hosting packages. The blueprint uses the same documented OAuth client-credentials and Bot Connector REST protocols directly through Fetch so the integration runs on Node and Cloudflare Workers.

Set the Azure Bot messaging endpoint to:

``` astro-code
https://example.com/channels/teams/activities
```

Teams bots receive channel messages when mentioned by default. Configure the appropriate Teams resource-specific consent permissions when the application must receive all channel or group-chat messages.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { defineTool, dispatch } from &#39;@flue/runtime&#39;;
import { createTeamsChannel } from &#39;@flue/teams&#39;;
import * as v from &#39;valibot&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { createTeamsClient, type TeamsMessageRef } from &#39;../lib/teams-client.ts&#39;;

const appId = process.env.TEAMS_APP_ID!;
const tenantId = process.env.TEAMS_TENANT_ID!;

export const client = createTeamsClient({
  appId,
  tenantId,
  appPassword: process.env.TEAMS_APP_PASSWORD!,
});

export const channel = createTeamsChannel({
  appId,
  tenantId,

  // Path: /channels/teams/activities
  async activities({ activity }) {
    switch (activity.type) {
      case &#39;message&#39;: {
        if (!activity.text) return;
        const destination = channel.destination(activity);
        await dispatch(Assistant, {
          id: channel.instanceId(destination),
          // Recorded once when this event creates the instance; ignored after.
          initialData: {
            serviceUrl: destination.serviceUrl,
            conversationId: destination.conversationId,
            botId: destination.botId,
            ...(destination.threadId === undefined ? {} : { threadId: destination.threadId }),
          },
          message: {
            kind: &#39;signal&#39;,
            type: &#39;teams.message&#39;,
            body: activity.text,
            attributes: {
              ...(activity.id === undefined ? {} : { activityId: activity.id }),
              senderId: activity.from.id,
              senderName: activity.from.name,
            },
          },
        });
        return;
      }
      default:
        return;
    }
  },
});

export function postMessage(ref: TeamsMessageRef) {
  return defineTool({
    name: &#39;post_teams_message&#39;,
    description: &#39;Post to the Microsoft Teams conversation bound to this agent.&#39;,
    input: v.object({ text: v.pipe(v.string(), v.minLength(1)) }),
    async run({ data: { text } }) {
      const result = await client.postMessage(ref, text);
      return { output: { activityId: result.id } };
    },
  });
}</code></pre>
<figcaption><span>src/channels/teams.ts</span></figcaption>
</figure>

The generated `lib/teams-client.ts` exchanges the application credentials for a Bot Connector token, caches it until shortly before expiry, and sends message activities through the verified destination’s Connector service URL.

The callback receives the provider-native Bot Framework `Activity`, re-exported from `botframework-schema`. Switch on the native `activity.type` (`message`, `conversationUpdate`, `invoke`, `messageReaction`, and other Bot Framework types) and read Microsoft’s documented field names. Call `channel.destination(activity)` to derive the canonical routing identity when you need to address a reply. Return nothing for an empty `200`, return JSON for a provider body, or use the Hono context for explicit status control.

Azure Bot Service holds the inbound request open with a real response window, so admit durable work quickly — `dispatch(...)` the activity and return, then rely on idempotency rather than blocking the response on long-running work. `invoke` activities expect a JSON acknowledgement body, and the Bot Connector retries on any non-2xx response, so return a 2xx once the work is safely admitted.

## Bind the tool

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { postMessage } from &#39;../channels/teams.ts&#39;;

const initialData = v.object({
  serviceUrl: v.string(),
  conversationId: v.string(),
  botId: v.string(),
  threadId: v.optional(v.string()),
});

export function Assistant() {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const data = useInitialData&lt;v.InferOutput&lt;typeof initialData&gt;&gt;();
  if (!data) throw new Error(&#39;This agent is created by the Microsoft Teams channel dispatch.&#39;);
  useTool(postMessage(data));
  return &#39;Reply concisely in the bound Microsoft Teams conversation.&#39;;
}

Assistant.initialData = initialData;</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

The model selects only message text. Trusted code binds the Connector service URL, conversation, bot account, and channel thread as the instance’s creation data — the agent reads them with `useInitialData()` instead of parsing the instance id.

## Authentication

`@flue/teams` verifies the Bot Connector bearer token before invoking the handler. It checks:

- the Microsoft OpenID signing key and `RS256` signature;
- issuer, application audience, and expiration;
- the signing key’s `msteams` endorsement;
- the activity’s exact `serviceUrl` against the signed token claim;
- the host conversation and channel tenant against `TEAMS_TENANT_ID`.

The defaults target Microsoft’s public cloud. Supported sovereign deployments can provide their documented OpenID metadata URL, token issuer, and OAuth authority.

The package does not deduplicate activity ids. Claim them in application-owned durable storage before dispatch when duplicate admission is unacceptable.

See the [`@flue/teams` README](https://github.com/withastro/flue/tree/main/packages/teams#readme).


## Docs Navigation

Current page: [Microsoft Teams](/docs/ecosystem/channels/teams/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


