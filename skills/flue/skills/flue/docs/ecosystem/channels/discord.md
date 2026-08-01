> Source: https://flueframework.com/docs/ecosystem/channels/discord

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Discord


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/discord/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/discord" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/discord</a>


## Quickstart

Add verified Discord HTTP interactions and application-owned Discord REST behavior to an existing Flue project with the [Discord](https://discord.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel discord
```

## Overview

The blueprint installs `@flue/discord` and the community-maintained `@discordjs/rest` client. It creates a source-root `channels/discord.ts` module that verifies interactions, dispatches supported commands, exports a project-owned REST client and message tool, and modifies the selected agent to bind that tool to the interaction’s trusted destination.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { REST } from &#39;@discordjs/rest&#39;;
import { createDiscordChannel, type APIInteractionResponse } from &#39;@flue/discord&#39;;
import { dispatch } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const client = new REST({ version: &#39;10&#39; }).setToken(process.env.DISCORD_BOT_TOKEN!);

export const channel = createDiscordChannel({
  publicKey: process.env.DISCORD_PUBLIC_KEY!,
  async interactions({ interaction }) {
    if (interaction.type !== 2 || interaction.data.name !== &#39;ask&#39;) {
      return {
        type: 4,
        data: { content: &#39;Unsupported interaction.&#39;, flags: 64 },
      } satisfies APIInteractionResponse;
    }

    const destination = destinationFromInteraction(interaction);
    if (!destination || destination.type === &#39;private&#39;) {
      return {
        type: 4,
        data: { content: &#39;Unsupported interaction.&#39;, flags: 64 },
      } satisfies APIInteractionResponse;
    }

    // The first string option of the `/ask` chat-input command is the prompt.
    const question =
      interaction.data.type === 1
        ? interaction.data.options?.find((option) =&gt; option.type === 3)?.value
        : undefined;
    await dispatch(Assistant, {
      id: channel.instanceId(destination),
      message: {
        kind: &#39;signal&#39;,
        type: &#39;discord.command.ask&#39;,
        body: question ?? JSON.stringify(interaction.data),
        attributes: { interactionId: interaction.id, commandName: interaction.data.name },
      },
    });
    return {
      type: 4,
      data: { content: &#39;Your request was accepted.&#39;, flags: 64 },
    } satisfies APIInteractionResponse;
  },
});</code></pre>
<figcaption><span>src/channels/discord.ts (abridged)</span></figcaption>
</figure>

The abridged example omits the generated `destinationFromInteraction` helper and message tool. Once configured, an `ask` command continues the agent instance for its Discord destination, acknowledges the interaction, and lets that agent post messages through the bound REST tool. On Cloudflare Workers, the REST package selects its Fetch-based export and uses Flue’s `nodejs_compat` setting.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as discord } from &#39;./channels/discord.ts&#39;;

app.route(&#39;/channels/discord&#39;, discord.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/discord` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable             | Purpose                                                    |
|----------------------|------------------------------------------------------------|
| `DISCORD_PUBLIC_KEY` | **Required** — Verifies inbound interaction request bytes. |
| `DISCORD_BOT_TOKEN`  | **Required** — Authenticates outbound Discord REST calls.  |

The blueprint installs and configures `@flue/discord` for inbound HTTP interactions, along with a project-owned `@discordjs/rest` client for outbound API calls. After running the command, you will have a new source-root `channels/discord.ts` module exporting `channel` and `client`.

Discord does not publish an official JavaScript REST SDK. The blueprint uses the community-maintained `@discordjs/rest` client. Your application owns that client and its outbound API calls; `@flue/discord` handles only verified inbound HTTP interactions.

In the Discord Developer Portal, set the application’s Interactions Endpoint URL to the full public HTTPS route:

``` astro-code
https://example.com/channels/discord/interactions
```

Register only the application commands your project handles. Endpoint and command registration are provider setup owned by the application, not by the channel package.

## Supported HTTP interaction

| Discord surface | Webhook path                     |
|-----------------|----------------------------------|
| Interactions    | `/channels/discord/interactions` |

Discord can deliver [interactions](https://docs.discord.com/developers/interactions/receiving-and-responding) through the Gateway or an outgoing webhook, but not both for the same application. `@flue/discord` implements the verified HTTP path. Discord Gateway is a persistent WebSocket transport and remains outside the channel model.

Signed PING requests are answered with PONG internally before application code runs.

### Interactions

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { type APIInteractionResponse, createDiscordChannel } from &#39;@flue/discord&#39;;

export const channel = createDiscordChannel({
  publicKey: process.env.DISCORD_PUBLIC_KEY!,

  // Path: /channels/discord/interactions
  async interactions({ interaction }) {
    if (interaction.type === 4) {
      return {
        type: 8,
        data: { choices: [] },
      } satisfies APIInteractionResponse;
    }

    if (interaction.type === 2 &amp;&amp; interaction.data.name === &#39;ask&#39;) {
      return {
        type: 4,
        data: { content: &#39;Your request was accepted.&#39;, flags: 64 },
      } satisfies APIInteractionResponse;
    }

    return {
      type: 4,
      data: { content: &#39;Unsupported interaction.&#39;, flags: 64 },
    } satisfies APIInteractionResponse;
  },
});</code></pre>
<figcaption><span>src/channels/discord.ts</span></figcaption>
</figure>

`interaction` is Discord’s provider-native API v10 object. Its numeric `type` discriminant narrows commands, autocomplete requests, message components, and modal submissions while preserving Discord’s snake_case fields and nesting. The package does not filter authenticated interaction families; the handler decides which ones affect the application.

The callback uses the current `APIInteraction` union for strong narrowing. Authenticated future numeric types are still forwarded at runtime, so an exhaustive branch should tolerate an unfamiliar numeric value after a Discord API change.

### Respond within Discord’s deadline

Every non-PING HTTP interaction requires a valid Discord interaction response. Discord invalidates the interaction token if the initial response is not sent within three seconds. The package awaits the application handler and does not impose a separate timeout, so admit durable work promptly and return within that provider deadline.

An immediate message response uses callback type `4`. A deferred response uses type `5` when the application will complete the interaction through Discord’s webhook API. Interaction tokens remain valid for follow-up operations for up to 15 minutes.

`interaction.token` is a short-lived response capability. Use it only in immediate trusted application code. Keep it out of the dispatched message, model context, logs, and durable session history.

See Discord’s [interaction callback documentation](https://docs.discord.com/developers/interactions/receiving-and-responding#interaction-callback) for the response types allowed by each interaction family.

### Choose a conversation destination

Not every interaction represents a durable Discord channel conversation. When an interaction should continue an agent instance, application code can derive a `DiscordDestinationRef` from native `guild_id`, `channel.id`, `channel.type`, and `context` fields. The complete generated example from `flue add channel discord` shows that derivation and dispatches with `channel.instanceId(ref)`.

Some valid interactions, including modal submissions, may omit a channel. Private-channel interactions can be acknowledged through their interaction token, but that capability does not grant the bot arbitrary channel-message access.

Use `channel.instanceId(ref)` when a Discord destination should continue the same agent instance. Instance ids are identifiers, not authorization capabilities. See the shared [Channels guide](/docs/guide/channels/) for dispatch, authorization, and deduplication guidance.

## Outbound REST

Outbound Discord behavior belongs to the exported project-owned client:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { REST } from &#39;@discordjs/rest&#39;;

export const client = new REST({ version: &#39;10&#39; }).setToken(process.env.DISCORD_BOT_TOKEN!);</code></pre>
<figcaption><span>src/channels/discord.ts</span></figcaption>
</figure>

Bot-token messages, application-command registration, and interaction-token follow-ups or edits are Discord REST operations. They are not implemented by `@flue/discord`.

## Discord Tools

Use the client to define an application-owned tool with its destination bound in trusted code:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { defineTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;

export function postMessage(ref: { channelId: string }) {
  return defineTool({
    name: &#39;post_discord_message&#39;,
    description: &#39;Post to the Discord destination bound to this agent.&#39;,
    input: v.object({ content: v.pipe(v.string(), v.minLength(1)) }),
    async run({ data: { content } }) {
      const result = (await client.post(`/channels/${ref.channelId}/messages`, {
        body: { content },
      })) as { id?: string };
      return { output: { messageId: result.id ?? null } };
    },
  });
}</code></pre>
<figcaption><span>src/channels/discord.ts</span></figcaption>
</figure>

`data` is the instance’s creation data, recorded once when the dispatching event creates the instance. Bind it when creating the agent instead of parsing the instance id:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { postMessage } from &#39;../channels/discord.ts&#39;;

const initialData = v.object({ channelId: v.string() });

export function Assistant() {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const data = useInitialData&lt;v.InferOutput&lt;typeof initialData&gt;&gt;();
  if (!data) throw new Error(&#39;This agent is created by the Discord channel dispatch.&#39;);
  useTool(postMessage(data));
  return &#39;Post a concise answer to the bound Discord destination.&#39;;
}

Assistant.initialData = initialData;</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

The model selects message content. It does not select arbitrary Discord channels, credentials, or REST methods. This tool creates an ordinary bot-token channel message, not an interaction follow-up or guaranteed ephemeral response. `parseInstanceId()` remains available as an escape hatch for recovering the destination from the id directly.

## Delivery and runtime behavior

Discord does not document dependable interaction redelivery behavior. The channel rejects signed requests whose timestamp is more than five minutes from the server clock, which bounds how stale a replay can be, but it is otherwise stateless and does not deduplicate interaction ids. Preserve `interaction.id` for tracing, and claim it in application-owned durable storage before dispatch when duplicate admission is unacceptable.

`@flue/discord` runs in Node and Cloudflare Workers with Flue’s required `nodejs_compat` setting. The example executes `@discordjs/rest` channel-message request construction against a fail-closed fake Fetch transport in both runtimes. Validate any additional REST operations your application depends on.


## Docs Navigation

Current page: [Discord](/docs/ecosystem/channels/discord/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


