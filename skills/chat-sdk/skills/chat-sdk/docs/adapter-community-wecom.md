> Source: https://chat-sdk.dev/adapters/community/wecom.md

---
title: WeCom
description: Community WeCom (企业微信) adapter for Chat SDK covering group webhook bots, smart bots, and apps, with template cards, rich media, and AES-256-CBC encryption.
tagline: WeCom (企业微信) adapter for Chat SDK. Group webhook bots, smart bots (callback or WebSocket), and apps, with template cards and AES encryption.
package: @agentor/chat-wecom
---

# WeCom


## Install


## Quick start

### Webhook (group bot)

One-way message push to a group chat:

```typescript title="lib/bot.ts" lineNumbers
import { createWeComWebhookAdapter } from "@agentor/chat-wecom";

const adapter = createWeComWebhookAdapter({
  key: process.env.WECOM_WEBHOOK_KEY,
});

const threadId = adapter.encodeThreadId({ key: process.env.WECOM_WEBHOOK_KEY });
await adapter.postMessage(threadId, "Hello from @agentor/chat-wecom!");
```

### Smart bot (WebSocket)

```typescript title="lib/bot.ts" lineNumbers
import { createWeComBotAdapter } from "@agentor/chat-wecom";

const adapter = createWeComBotAdapter({
  botId: process.env.WECOM_BOT_WS_BOT_ID,
  secret: process.env.WECOM_BOT_WS_SECRET,
});

await adapter.initialize({
  processMessage: async (_adapter, threadId, factory) => {
    const message = await factory();
    await adapter.postMessage(threadId, message.text);
  },
});
```

### App (application)

```typescript title="lib/bot.ts" lineNumbers
import { createWeComAppAdapter } from "@agentor/chat-wecom";

const adapter = createWeComAppAdapter({
  corpId: process.env.WECOM_APP_CORP_ID,
  corpSecret: process.env.WECOM_APP_CORP_SECRET,
  agentId: Number(process.env.WECOM_APP_AGENT_ID),
});
```

## Configuration


## Template cards

Chat SDK `CardElement` is converted automatically to a WeCom Template Card. The
card type is inferred from the content:

| Card type              | Inferred from                     |
| ---------------------- | --------------------------------- |
| `text_notice`          | Default (text only).              |
| `news_notice`          | Contains an image.                |
| `button_interaction`   | Contains buttons.                 |
| `vote_interaction`     | Contains a single-select.         |
| `multiple_interaction` | Contains multi-select / dropdown. |

Webhook and callback bots only support `text_notice` and `news_notice`;
WebSocket and app adapters support all five card types.

## Encryption

All callback communication uses AES-256-CBC encryption with SHA1 signature
verification.

## Feature support


