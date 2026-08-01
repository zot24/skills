> Source: https://chat-sdk.dev/adapters/community/qq.md

---
title: QQ Bot
description: Community QQ Bot adapter for Chat SDK with WebSocket and webhook modes, multi-scene support (DM, group, text channel), rich media, and Ed25519 signature verification.
tagline: QQ Bot adapter for Chat SDK. Connects to the QQ Bot Gateway over WebSocket or HTTP callback, supporting DM, group, and text-channel scenes with images, video, voice, and files.
package: @agentor/chat-qq
---

# QQ Bot


## Install


## Quick start

### WebSocket mode

Connect directly to the QQ Bot Gateway — no public endpoint required:

```typescript title="lib/bot.ts" lineNumbers
import { createQQBotAdapter } from "@agentor/chat-qq";

const adapter = createQQBotAdapter({
  appId: process.env.QQ_BOT_APP_ID,
  clientSecret: process.env.QQ_BOT_CLIENT_SECRET,
});

await adapter.initialize({
  processMessage: async (_adapter, threadId, factory) => {
    const message = await factory();
    await adapter.postMessage(threadId, message.text);
  },
});
```

### Webhook (callback) mode

Receive events over HTTP with Ed25519 signature verification. Once an HTTPS
callback URL is configured on the bot, WebSocket mode is no longer available —
the two modes are mutually exclusive.

```typescript title="lib/bot.ts" lineNumbers
import { createQQBotAdapter } from "@agentor/chat-qq";

const adapter = createQQBotAdapter({
  mode: "callback",
  appId: process.env.QQ_BOT_APP_ID,
  clientSecret: process.env.QQ_BOT_CLIENT_SECRET,
});
```

## Environment variables

| Variable               | Required | Description            |
| ---------------------- | -------- | ---------------------- |
| `QQ_BOT_APP_ID`        | Yes      | QQ Bot application ID. |
| `QQ_BOT_CLIENT_SECRET` | Yes      | QQ Bot client secret.  |

## Configuration


## Rich media

`postMessage` uploads local files (`FileUpload`) and URL attachments
automatically, then sends them as rich-media messages; unsupported scenarios
fall back to text.

```typescript
// Send a local file
await adapter.postMessage(threadId, {
  text: "Document",
  files: [
    {
      data: buffer,
      filename: "report.xlsx",
      mimeType: "application/vnd.ms-excel",
    },
  ],
});
```

## Scenes

Supports QQ DM (C2C), QQ Group, Text Channel, and Channel DM. File upload in
group chats is not currently available; text channels and channel DMs send
images and videos via `msg_type: 7`.

## Feature support


