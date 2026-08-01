> Source: https://flueframework.com/docs/ecosystem/channels/slack

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Slack


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/slack/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/slack" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/slack</a>


## Quickstart

Add verified HTTP ingress and application-owned Web API behavior to an existing Flue project with the [Slack](https://slack.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel slack
```

## Overview

The Slack blueprint installs `@flue/slack` and Slack’s official `@slack/web-api` SDK, then creates `channels/slack.ts` in the source-root. It also updates the selected agent to bind the generated thread-reply tool to the verified Slack conversation.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { dispatch } from &#39;@flue/runtime&#39;;
import { createSlackChannel } from &#39;@flue/slack&#39;;
import { WebClient } from &#39;@slack/web-api&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const client = new WebClient(process.env.SLACK_BOT_TOKEN);

export const channel = createSlackChannel({
  signingSecret: process.env.SLACK_SIGNING_SECRET!,
  async events({ payload }) {
    if (payload.type !== &#39;event_callback&#39;) return;
    if (payload.event.type !== &#39;app_mention&#39;) return;

    const event = payload.event;
    await dispatch(Assistant, {
      id: channel.instanceId({
        teamId: payload.team_id,
        channelId: event.channel,
        threadTs: event.thread_ts ?? event.ts,
      }),
      message: {
        kind: &#39;signal&#39;,
        type: &#39;slack.app_mention&#39;,
        body: event.text,
        attributes: { eventId: payload.event_id },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/slack.ts (abridged)</span></figcaption>
</figure>

The abridged example omits the generated `replyInThread()` tool. The complete blueprint binds that tool in the agent module, so verified app mentions reach a thread-scoped agent instance and replies return to the same thread. Interactivity and slash-command callbacks are optional secondary additions: each callback publishes its corresponding route only when enabled.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as slack } from &#39;./channels/slack.ts&#39;;

app.route(&#39;/channels/slack&#39;, slack.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/slack` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable               | Purpose                                                    |
|------------------------|------------------------------------------------------------|
| `SLACK_SIGNING_SECRET` | **Required** — Verifies inbound request bytes.             |
| `SLACK_BOT_TOKEN`      | **Required** — Authenticates outbound Slack Web API calls. |

The blueprint installs and configures `@flue/slack` for inbound requests, along with Slack’s official `@slack/web-api` SDK for making outbound API calls. After running the command, you will have a new `src/channels/slack.ts` channel whose webhook routes are served wherever `app.ts` mounts `channel.route()` — conventionally `/channels/slack/*`.

## Supported Webhooks

| Slack surface                                                                       | Webhook path                   |
|-------------------------------------------------------------------------------------|--------------------------------|
| [Event Subscriptions](https://docs.slack.dev/apis/events-api/)                      | `/channels/slack/events`       |
| [Interactivity](https://docs.slack.dev/interactivity/handling-user-interaction/)    | `/channels/slack/interactions` |
| [Slash commands](https://docs.slack.dev/interactivity/implementing-slash-commands/) | `/channels/slack/commands`     |

Add only the Slack surfaces your application handles.

Omitting a callback from `createSlackChannel()` omits its route. Slack URL verification is answered internally after signature verification.

### Events

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { dispatch } from &#39;@flue/runtime&#39;;
import { createSlackChannel } from &#39;@flue/slack&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const channel = createSlackChannel({
  signingSecret: process.env.SLACK_SIGNING_SECRET!,

  // Path: /channels/slack/events
  async events({ payload }) {
    if (payload.type !== &#39;event_callback&#39;) return;

    switch (payload.event.type) {
      case &#39;app_mention&#39;: {
        const event = payload.event;
        const thread = {
          teamId: payload.team_id,
          channelId: event.channel,
          threadTs: event.thread_ts ?? event.ts,
        };
        await dispatch(Assistant, {
          id: channel.instanceId(thread),
          // Recorded once when this event creates the instance; ignored after.
          initialData: {
            channelId: thread.channelId,
            threadTs: thread.threadTs,
            startedBy: event.user,
            startedAt: new Date(Number(event.ts) * 1000).toISOString(),
          },
          message: {
            kind: &#39;signal&#39;,
            type: &#39;slack.app_mention&#39;,
            body: event.text,
            attributes: { eventId: payload.event_id },
          },
        });
        return;
      }
      default:
        return;
    }
  },
});</code></pre>
<figcaption><span>src/channels/slack.ts</span></figcaption>
</figure>

`payload` is Slack’s outer Events API delivery. For `event_callback`, `payload.event` uses the official `SlackEvent` union from `@slack/types`. Switching on `payload.event.type` narrows events such as `app_mention`, `reaction_added`, Assistant events, and `message`. Message subtypes remain available through `payload.event.subtype`.

The channel does not filter bot messages, message subtypes, or event families. Your handler decides which authenticated events affect the application. `app_rate_limited` notifications also reach the callback.

The signing secret authenticates the Slack app. Workspace and enterprise identity remain in the provider payload so applications can enforce an allowlist when they need one. The channel does not impose a single-workspace installation model.

### Interactions

Enable this surface only when the application handles interactions:

``` astro-code
export const channel = createSlackChannel({
  signingSecret: process.env.SLACK_SIGNING_SECRET!,

  // Path: /channels/slack/interactions
  async interactions({ payload }) {
    switch (payload.type) {
      case 'block_actions':
        await handleActions(payload.actions);
        return;
      case 'view_submission':
        return {
          response_action: 'errors',
          errors: { email: 'Enter a valid email address.' },
        };
      default:
        return;
    }
  },
});
```

Interaction payloads preserve Slack’s snake_case wire fields. `trigger_id`, `response_url`, and view `response_urls` are short-lived capabilities. Keep them in immediate trusted request handling, not a dispatched message, model context, logs, or durable session history.

### Commands

Enable this surface only when the application handles slash commands:

``` astro-code
export const channel = createSlackChannel({
  signingSecret: process.env.SLACK_SIGNING_SECRET!,

  // Path: /channels/slack/commands
  async commands({ c, payload }) {
    switch (payload.command) {
      case '/triage':
        await startTriage(payload.text);
        return c.json({ response_type: 'ephemeral', text: 'Triage started.' });
      default:
        return c.json({ response_type: 'ephemeral', text: 'Unknown command.' });
    }
  },
});
```

Command payloads preserve Slack’s snake_case wire fields. `trigger_id` and `response_url` are also short-lived capabilities and should remain in immediate trusted request handling.

Returning nothing produces an empty `200`. Return JSON-compatible data for a JSON response, or use the Hono context for explicit status, headers, and body. Thrown errors flow through normal Hono error handling. Slack expects prompt acknowledgements, so admit durable work quickly instead of performing slow operations before returning.

## Outbound

Outbound Slack behavior belongs to the exported SDK client:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { WebClient } from &#39;@slack/web-api&#39;;

export const client = new WebClient(process.env.SLACK_BOT_TOKEN);</code></pre>
<figcaption><span>src/channels/slack.ts</span></figcaption>
</figure>

## Slack Tools

Use the client to define application-owned tools:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { defineTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;

export function replyInThread(ref: { channelId: string; threadTs: string }) {
  return defineTool({
    name: &#39;reply_in_slack_thread&#39;,
    description: &#39;Reply in the Slack thread bound to this agent.&#39;,
    input: v.object({ text: v.pipe(v.string(), v.minLength(1)) }),
    async run({ data: { text } }) {
      const result = await client.chat.postMessage({
        channel: ref.channelId,
        thread_ts: ref.threadTs,
        text,
      });
      return { output: { channel: result.channel ?? null, ts: result.ts ?? null } };
    },
  });
}</code></pre>
<figcaption><span>src/channels/slack.ts</span></figcaption>
</figure>

Bind the destination in trusted code. `data` is the instance’s creation data — recorded once when the dispatch above creates the instance — so the agent reads the structured thread facts with `useInitialData()` instead of parsing them from the instance id:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { replyInThread } from &#39;../channels/slack.ts&#39;;

const initialData = v.object({
  channelId: v.string(),
  threadTs: v.string(),
  startedBy: v.optional(v.string()),
  startedAt: v.pipe(v.string(), v.isoTimestamp()),
});

export function Assistant() {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const data = useInitialData&lt;v.InferOutput&lt;typeof initialData&gt;&gt;();
  if (!data) throw new Error(&#39;This agent is created by the Slack channel dispatch.&#39;);
  useTool(replyInThread(data));
  const startedBy = data.startedBy ? ` by &lt;@${data.startedBy}&gt;` : &#39;&#39;;
  return `Reply in the bound Slack thread when appropriate. This conversation was started${startedBy} at ${data.startedAt}.`;
}

Assistant.initialData = initialData;</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

`channel.parseInstanceId(id)` remains available as an escape hatch for routes that receive only the id without creation data. The model selects message text. It does not select arbitrary workspaces, channels, credentials, or Web API methods.

## Show Assistant status

For Slack Assistant threads, use the SDK directly:

``` astro-code
await client.assistant.threads.setStatus({
  channel_id: channelId,
  thread_ts: threadTs,
  status: 'is thinking...',
});
```

This is a Slack Web API capability, not behavior implemented by `@flue/slack`.

## Stream a reply

The v8 client exposes `chatStream()` over Slack’s streaming message APIs:

``` astro-code
const stream = client.chatStream({
  channel: channelId,
  thread_ts: threadTs,
  recipient_team_id: teamId,
  recipient_user_id: userId,
});

await stream.append({ markdown_text: 'First part' });
await stream.append({ markdown_text: ' and the rest.' });
await stream.stop();
```

The example executes `chat.postMessage`, `assistant.threads.setStatus`, and the start/append/stop streaming sequence against fake Fetch responses in workerd. No test contacts Slack.

## Handle retries

Slack may retry failed or timed-out Events API deliveries. Read `x-slack-retry-num` and `x-slack-retry-reason` from `c.req.header(...)`. Preserve `payload.event_id` for tracing, and claim it in application-owned durable storage before dispatch when duplicate admission is unacceptable.

OAuth installation storage, workspace authorization, Socket Mode, and token rotation remain application concerns.

The Fetch-based Slack Web API v8 release candidate runs in Node and in Cloudflare Workers with Flue’s required `nodejs_compat` setting.


## Docs Navigation

Current page: [Slack](/docs/ecosystem/channels/slack/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


