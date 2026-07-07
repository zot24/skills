> Source: https://flueframework.com/docs/ecosystem/channels/slack

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Slack


Last updated Jun 13, 2026 <a href="/docs/ecosystem/channels/slack/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a> <a href="https://www.npmjs.com/package/@flue/slack" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/slack</a>


## Quickstart

Add verified HTTP ingress and application-owned Web API behavior to an existing Flue project with the [Slack](https://slack.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel slack
```

## Overview

The Slack blueprint installs `@flue/slack` and Slack’s official `@slack/web-api` SDK, then creates `channels/slack.ts` in the source-root. It also updates the selected agent to bind the generated thread-reply tool to the verified Slack conversation.

``` astro-code
import { dispatch } from '@flue/runtime';
import { createSlackChannel } from '@flue/slack';
import { WebClient } from '@slack/web-api';
import assistant from '../agents/assistant.ts';

export const client = new WebClient(process.env.SLACK_BOT_TOKEN);

export const channel = createSlackChannel({
  signingSecret: process.env.SLACK_SIGNING_SECRET!,
  async events({ payload }) {
    if (payload.type !== 'event_callback') return;
    if (payload.event.type !== 'app_mention') return;

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
  },
});
```

The abridged example omits the generated `replyInThread()` tool. The complete blueprint binds that tool in the agent module, so verified app mentions reach a thread-scoped agent instance and replies return to the same thread. Interactivity and slash-command callbacks are optional secondary additions: each callback publishes its corresponding route only when enabled.

## Configure

| Variable               | Purpose                                                    |
|------------------------|------------------------------------------------------------|
| `SLACK_SIGNING_SECRET` | **Required** — Verifies inbound request bytes.             |
| `SLACK_BOT_TOKEN`      | **Required** — Authenticates outbound Slack Web API calls. |

The blueprint installs and configures `@flue/slack` for inbound requests, along with Slack’s official `@slack/web-api` SDK for making outbound API calls. After running the command, you will have a new `src/channels/slack.ts` channel with new `/channels/slack/*` webhook routes set up and ready to receive events.

## Supported Webhooks

| Slack surface                                                                       | Webhook path                   |
|-------------------------------------------------------------------------------------|--------------------------------|
| [Event Subscriptions](https://docs.slack.dev/apis/events-api/)                      | `/channels/slack/events`       |
| [Interactivity](https://docs.slack.dev/interactivity/handling-user-interaction/)    | `/channels/slack/interactions` |
| [Slash commands](https://docs.slack.dev/interactivity/implementing-slash-commands/) | `/channels/slack/commands`     |

Add only the Slack surfaces your application handles.

Omitting a callback from `createSlackChannel()` omits its route. Slack URL verification is answered internally after signature verification.

### Events

``` astro-code
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
        const thread = {
          teamId: payload.team_id,
          channelId: event.channel,
          threadTs: event.thread_ts ?? event.ts,
        };
        await dispatch(assistant, {
          id: channel.conversationKey(thread),
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

Interaction payloads preserve Slack’s snake_case wire fields. `trigger_id`, `response_url`, and view `response_urls` are short-lived capabilities. Keep them in immediate trusted request handling, not dispatch input, model context, logs, or durable session history.

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

``` astro-code
import { WebClient } from '@slack/web-api';

export const client = new WebClient(process.env.SLACK_BOT_TOKEN);
```

## Slack Tools

Use the client to define application-owned tools:

``` astro-code
import { defineTool } from '@flue/runtime';
import * as v from 'valibot';

export function replyInThread(ref: { channelId: string; threadTs: string }) {
  return defineTool({
    name: 'reply_in_slack_thread',
    description: 'Reply in the Slack thread bound to this agent.',
    input: v.object({ text: v.pipe(v.string(), v.minLength(1)) }),
    async run({ input: { text } }) {
      const result = await client.chat.postMessage({
        channel: ref.channelId,
        thread_ts: ref.threadTs,
        text,
      });
      return { channel: result.channel ?? null, ts: result.ts ?? null };
    },
  });
}
```

Bind the destination in trusted code:

``` astro-code
import { defineAgent } from '@flue/runtime';
import { channel, replyInThread } from '../channels/slack.ts';

export default defineAgent(({ id }) => ({
  model: 'anthropic/claude-haiku-4-5',
  tools: [replyInThread(channel.parseConversationKey(id))],
}));
```

The model selects message text. It does not select arbitrary workspaces, channels, credentials, or Web API methods.

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

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


