> Source: https://chat-sdk.dev/adapters/vendor-official/lark.md

---
title: Lark / Feishu
description: Chat SDK adapter for Lark / Feishu. WebSocket long-connection event subscription, native cardkit typewriter streaming, interactive cards, and reactions.
tagline: Chat SDK adapter for Lark / Feishu, built on the official @larksuiteoapi/node-sdk. WebSocket long-connection event delivery, native cardkit streaming, interactive cards, and reactions.
package: @larksuite/vercel-chat-adapter
---

# Lark / Feishu


## Install

<PackageInstall package="@larksuite/vercel-chat-adapter" />

## Quick start

```typescript title="lib/bot.ts" lineNumbers


const bot = new Chat({
  userName: "mybot",
  adapters: {
    lark: createLarkAdapter(),
  },
  state: createMemoryState(),
});

bot.onNewMention(async (thread, message) => {
  await thread.subscribe();
  await thread.post(`You said: ${message.text}`);
});

bot.onDirectMessage(async (thread, message) => {
  await thread.post(`Got your DM: ${message.text}`);
});

await bot.initialize();
```

`bot.initialize()` opens the Lark WebSocket connection and keeps it alive until `bot.shutdown()` is called. The process stays alive as long as the WS is open, so no separate server is needed in a long-running environment.

The adapter auto-detects `LARK_APP_ID`, `LARK_APP_SECRET`, and `LARK_BOT_USERNAME` from environment variables when no explicit config is passed.

## Creating a Lark app

### Option A — scan-to-create (recommended)

`registerLarkApp` drives Lark's official scan-to-create flow: the SDK generates a one-time URL, you render it as a QR code, the user scans with the Lark mobile app and approves, and you get back `client_id` / `client_secret` — with the permissions and event subscriptions this adapter needs already configured.

```typescript title="scripts/register-app.ts" lineNumbers
import {
  registerLarkApp,
  createLarkAdapter,
} from "@larksuite/vercel-chat-adapter";
import qrcode from "qrcode-terminal"; // pnpm add -D qrcode-terminal

const { client_id, client_secret } = await registerLarkApp({
  onQRCodeReady: ({ url }) => {
    console.log("Scan this QR with your Lark mobile app:");
    qrcode.generate(url, { small: true });
  },
  onStatusChange: ({ status }) => console.log("status:", status),
});

console.log("LARK_APP_ID=", client_id);
console.log("LARK_APP_SECRET=", client_secret);
```

You only need to run this once. Persist the returned credentials and feed them back via `LARK_APP_ID` / `LARK_APP_SECRET` in subsequent runs.

### Option B — create via developer console

Go to the developer console and create an **Intelligent Agent** app:

* Lark: [open.larksuite.com/app](https://open.larksuite.com/app)
* Feishu: [open.feishu.cn/app](https://open.feishu.cn/app)

Grab the app's `client_id` and `client_secret` and pass them as `appId` / `appSecret` (or set `LARK_APP_ID` / `LARK_APP_SECRET`).

## Configuration

<TypeTable
  type={{
  appId: {
    type: "string",
    description:
      "Lark app ID. Auto-detected from `LARK_APP_ID` when omitted.",
  },
  appSecret: {
    type: "string",
    description:
      "Lark app secret. Auto-detected from `LARK_APP_SECRET` when omitted.",
  },
  userName: {
    type: "string",
    description:
      "Bot display name. Defaults to `LARK_BOT_USERNAME` or `\"bot\"`.",
  },
  logger: {
    type: "Logger",
    description:
      "Chat SDK-compatible logger. Defaults to `ConsoleLogger(\"info\", \"lark\")`.",
  },
}}
/>

### Environment variables

| Variable            | Description                                        |
| ------------------- | -------------------------------------------------- |
| `LARK_APP_ID`       | Lark app ID. Overridden by `config.appId`.         |
| `LARK_APP_SECRET`   | Lark app secret. Overridden by `config.appSecret`. |
| `LARK_BOT_USERNAME` | Bot display name. Overridden by `config.userName`. |

## Transport

WebSocket only. `handleWebhook()` returns HTTP 501. Webhook transport is on the roadmap; for now, Lark's "long-connection" mode is the intended delivery channel and works in production.

This means you can run a Lark bot without exposing an HTTP endpoint — the SDK initiates an outbound WebSocket to Lark's servers and receives events through it. Long-running environments (a Node process, a worker, a VM) are the natural fit. Serverless platforms that recycle the process on every request won't keep the connection alive.

## Streaming

`bot.adapter.stream()` uses Lark's native **cardkit typewriter** API. Chunks emitted from your stream handler are appended directly inside a single card message; no `post + edit` polling is involved.

```typescript
await thread.stream(async (controller) => {
  for await (const chunk of llmStream) {
    controller.write(chunk);
  }
});
```

If the thread has a `rootId`, the streamed reply is posted as a thread reply (via the SDK's `replyTo` parameter).

## ID encoding

Lark thread IDs encode as `lark:{chatId}:{rootId}`:

* `chatId` — `oc_*` for both group and p2p chats; `ou_*` for `openDM()` placeholders before the first message is delivered.
* `rootId` — the message's `root_id` if it is a reply, otherwise its own `message_id` (the message is its own root).

Lark's native `thread_id` (topic containers, `omt_*`) is **not** used as the `rootId` segment — it's a topic container ID, not a message ID, and can't be used as `replyTo` on the send API.

### DM detection

Lark's p2p chat IDs share the `oc_*` prefix with group chats, so `isDM()` relies on a chat-type cache populated by inbound events. The first DM after a process restart may route through `onNewMention` until the cache catches up.

## Message history

`fetchMessages` is implemented on top of `im.v1.messages.list` plus the SDK's `normalize()` — which covers Lark's 23 native message types and produces the same `NormalizedMessage` shape as live events.

`listThreads` is derived client-side by grouping list results on `root_id`. Paginate carefully for very active chats; there is no native server-side list-threads API.

`author.isMe` is resolved consistently for **historical** bot-authored messages, not just live events — the adapter maps the historical entry's `app_id` back to the bot's `open_id` via the SDK's `botIdentity` resolver.

## Safety layer

`LarkChannel`'s built-in safety features (stale-message detection, dedup, per-chat queue, text batch) are **disabled** by the adapter. Chat SDK's per-thread lock plus the state adapter handles message deduplication and subscription consistency — running the SDK's safety on top of Chat SDK's would double-process or drop messages.

## Multi-app / multi-tenant

Single-app only at present. A future version may support `setInstallation()` for multi-tenant fan-out — open an issue if you need it.

## Limitations

The following operations are not supported and throw `NotImplementedError`:

* `handleWebhook` — returns HTTP 501; WebSocket transport only.
* `startTyping` — Lark has no typing-indicator API.
* `postChannelMessage` — Lark requires every message to belong to a chat (no channel-level top-level messages distinct from threads).
* `scheduleMessage`, `openModal`, `postEphemeral` — not yet implemented.

## Feature support

<FeatureSupport />
