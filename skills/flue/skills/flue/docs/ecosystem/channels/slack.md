<!-- Source: https://flueframework.com/docs/ecosystem/channels/slack -->

## Quickstart [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#quickstart)

Add verified HTTP ingress and application-owned Web API behavior to an existing Flue project with the [Slack](https://slack.com/) blueprint. Run the following command in your terminal or coding agent of choice:

```
flue add channel slack
```

## Overview [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#overview)

The Slack blueprint installs `@flue/slack` and Slack’s official `@slack/web-api` SDK, then creates `channels/slack.ts` in the source-root. It also updates the selected agent to bind the generated thread-reply tool to the verified Slack conversation.

```
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

## Configure [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#configure)

| Variable | Purpose |
| --- | --- |
| `SLACK_SIGNING_SECRET` | **Required** — Verifies inbound request bytes. |
| `SLACK_BOT_TOKEN` | **Required** — Authenticates outbound Slack Web API calls. |

The blueprint installs and configures `@flue/slack` for inbound requests, along
with Slack’s official `@slack/web-api` SDK for making outbound API calls. After
running the command, you will have a new `src/channels/slack.ts` channel with
new `/channels/slack/*` webhook routes set up and ready to receive events.

## Supported Webhooks [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#supported-webhooks)

| Slack surface | Webhook path |
| --- | --- |
| [Event Subscriptions](https://docs.slack.dev/apis/events-api/) | `/channels/slack/events` |
| [Interactivity](https://docs.slack.dev/interactivity/handling-user-interaction/) | `/channels/slack/interactions` |
| [Slash commands](https://docs.slack.dev/interactivity/implementing-slash-commands/) | `/channels/slack/commands` |

Add only the Slack surfaces your application handles.

Omitting a callback from `createSlackChannel()` omits its route. Slack URL
verification is answered internally after signature verification.

### Events [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#events)

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

`payload` is Slack’s outer Events API delivery. For `event_callback`,
`payload.event` uses the official `SlackEvent` union from `@slack/types`.
Switching on `payload.event.type` narrows events such as `app_mention`,
`reaction_added`, Assistant events, and `message`. Message subtypes remain
available through `payload.event.subtype`.

The channel does not filter bot messages, message subtypes, or event families.
Your handler decides which authenticated events affect the application.
`app_rate_limited` notifications also reach the callback.

The signing secret authenticates the Slack app. Workspace and enterprise
identity remain in the provider payload so applications can enforce an
allowlist when they need one. The channel does not impose a single-workspace
installation model.

### Interactions [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#interactions)

Enable this surface only when the application handles interactions:

```
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

Interaction payloads preserve Slack’s snake\_case wire fields. `trigger_id`,
`response_url`, and view `response_urls` are short-lived capabilities. Keep
them in immediate trusted request handling, not dispatch input, model context,
logs, or durable session history.

### Commands [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#commands)

Enable this surface only when the application handles slash commands:

```
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

Command payloads preserve Slack’s snake\_case wire fields. `trigger_id` and
`response_url` are also short-lived capabilities and should remain in
immediate trusted request handling.

Returning nothing produces an empty `200`. Return JSON-compatible data for a
JSON response, or use the Hono context for explicit status, headers, and body.
Thrown errors flow through normal Hono error handling. Slack expects prompt
acknowledgements, so admit durable work quickly instead of performing slow
operations before returning.

## Outbound [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#outbound)

Outbound Slack behavior belongs to the exported SDK client:

```
import { WebClient } from '@slack/web-api';

export const client = new WebClient(process.env.SLACK_BOT_TOKEN);
```

## Slack Tools [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#slack-tools)

Use the client to define application-owned tools:

```
import { defineTool } from '@flue/runtime';

export function replyInThread(ref: { channelId: string; threadTs: string }) {
  return defineTool({
    name: 'reply_in_slack_thread',
    description: 'Reply in the Slack thread bound to this agent.',
    parameters: {
      type: 'object',
      properties: { text: { type: 'string', minLength: 1 } },
      required: ['text'],
      additionalProperties: false,
    },
    async execute({ text }) {
      const result = await client.chat.postMessage({
        channel: ref.channelId,
        thread_ts: ref.threadTs,
        text,
      });
      return JSON.stringify({ channel: result.channel, ts: result.ts });
    },
  });
}
```

Bind the destination in trusted code:

```
import { createAgent } from '@flue/runtime';
import { channel, replyInThread } from '../channels/slack.ts';

export default createAgent(({ id }) => ({
  model: 'anthropic/claude-haiku-4-5',
  tools: [replyInThread(channel.parseConversationKey(id))],
}));
```

The model selects message text. It does not select arbitrary workspaces,
channels, credentials, or Web API methods.

## Show Assistant status [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#show-assistant-status)

For Slack Assistant threads, use the SDK directly:

```
await client.assistant.threads.setStatus({
  channel_id: channelId,
  thread_ts: threadTs,
  status: 'is thinking...',
});
```

This is a Slack Web API capability, not behavior implemented by
`@flue/slack`.

## Stream a reply [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#stream-a-reply)

The v8 client exposes `chatStream()` over Slack’s streaming message APIs:

```
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

The example executes `chat.postMessage`,
`assistant.threads.setStatus`, and the start/append/stop streaming sequence
against fake Fetch responses in workerd. No test contacts Slack.

## Handle retries [\#](https://flueframework.com/docs/ecosystem/channels/slack/\#handle-retries)

Slack may retry failed or timed-out Events API deliveries. Read
`x-slack-retry-num` and `x-slack-retry-reason` from `c.req.header(...)`.
Preserve `payload.event_id` for tracing, and claim it in application-owned
durable storage before dispatch when duplicate admission is unacceptable.

OAuth installation storage, workspace authorization, Socket Mode, and token
rotation remain application concerns.

The Fetch-based Slack Web API v8 release candidate runs in Node and in
Cloudflare Workers with Flue’s required `nodejs_compat` setting.

## Docs Navigation

Current page: [Slack](https://flueframework.com/docs/ecosystem/channels/slack/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
