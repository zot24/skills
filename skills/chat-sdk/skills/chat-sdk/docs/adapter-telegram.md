> Source: https://chat-sdk.dev/adapters/official/telegram.md

---
title: Telegram
description: Telegram adapter for Chat SDK with webhook and polling modes.
tagline: Connect to Telegram with support for groups, channels, inline keyboards, and a polling fallback for local development.
package: @chat-adapter/telegram
---

# Telegram


## Install

<PackageInstall package="@chat-adapter/telegram" />

## Quick start

<Callout type="info">
  The adapter auto-detects `TELEGRAM_BOT_TOKEN`, `TELEGRAM_WEBHOOK_SECRET_TOKEN`, and `TELEGRAM_BOT_USERNAME` from the environment.
</Callout>

```typescript title="lib/bot.ts" lineNumbers


const bot = new Chat({
  userName: "mybot",
  adapters: {
    telegram: createTelegramAdapter(),
  },
});

bot.onNewMention(async (thread, message) => {
  await thread.post(`You said: ${message.text}`);
});
```

```typescript title="app/api/webhooks/telegram/route.ts" lineNumbers

export async function POST(request: Request): Promise<Response> {
  return bot.webhooks.telegram(request);
}
```

Configure your bot webhook in BotFather / via the Telegram API:

```bash
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/setWebhook" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://your-domain.com/api/webhooks/telegram",
    "secret_token": "your-secret-token"
  }'
```

## Configuration

<TypeTable
  type={{
  botToken: {
    type: "string",
    description: "Telegram bot token. Auto-detected from `TELEGRAM_BOT_TOKEN`.",
  },
  secretToken: {
    type: "string",
    description:
      "Optional webhook secret. Auto-detected from `TELEGRAM_WEBHOOK_SECRET_TOKEN`.",
  },
  mode: {
    type: '"auto" | "webhook" | "polling"',
    default: '"auto"',
    description:
      "Adapter mode. `auto` uses webhooks on serverless and polling everywhere else.",
  },
  longPolling: {
    type: "LongPollingOptions",
    description:
      "Long polling tuning. Fields: `timeout`, `limit`, `allowedUpdates`, `deleteWebhook`, `dropPendingUpdates`, `retryDelayMs`.",
  },
  userName: {
    type: "string",
    description:
      "Bot username for mention detection. Auto-detected from `TELEGRAM_BOT_USERNAME` or `getMe`.",
  },
  apiUrl: {
    type: "string",
    description:
      "Override the Telegram API base URL. Auto-detected from `TELEGRAM_API_BASE_URL`.",
  },
}}
/>

`botToken` is required — either via config or env var.

## Authentication

Create a bot via [BotFather](https://t.me/BotFather):

1. Send `/newbot` and follow the prompts.
2. Copy the token to `TELEGRAM_BOT_TOKEN`.
3. Optionally pick a username and copy it to `TELEGRAM_BOT_USERNAME`.

## Advanced

### Polling for local development

```typescript title="lib/bot.ts" lineNumbers


const telegram = createTelegramAdapter({
  mode: "polling",
});

const bot = new Chat({
  userName: "mybot",
  adapters: { telegram },
  state: createMemoryState(),
});
```

Polling and webhooks are mutually exclusive in Telegram. `mode: "polling"` deletes the webhook by default before calling `getUpdates`.

### Auto mode

`mode: "auto"` (the default) checks `getWebhookInfo`: if a webhook URL is set, it uses webhook mode; otherwise it falls back to polling on long-running runtimes. If `getWebhookInfo` fails, the adapter stays in webhook mode (safe fallback).

```typescript
const telegram = createTelegramAdapter({ mode: "auto" });
void bot.initialize();
console.log(telegram.runtimeMode); // "webhook" | "polling"
```

### Slash commands

Use `bot.onSlashCommand` to handle Telegram bot commands such as `/status` and `/status@mybot`. Commands addressed to another bot are ignored as slash commands and continue through the normal message path.

### Markdown formatting

On Telegram Bot API 10.1 and newer, explicit `{ markdown }` and `{ ast }` messages use rich messages. Standard markdown gains native headings, lists, tables, task lists, formulas, details, and separate media blocks where supported by Telegram. Private chat streams use rich draft previews and persist the completed response as a rich message.

Plain strings, raw messages, cards, and media captions retain their existing lightweight message paths. Cards and captions use Telegram's `MarkdownV2` parse mode with context-aware escaping. Older or custom Bot API servers automatically fall back to this existing path when rich message methods are unavailable.

Pass `{ raw: "..." }` only if you need to ship a fully pre-escaped MarkdownV2 string.

### Notes

* Telegram does not expose full historical message APIs to bots. `fetchMessages` returns adapter-cached messages from the current process.
* `listThreads` is not available for Telegram chats.
* Telegram callback data is limited to 64 bytes — keep `Button` `id`/`value` payloads short.
* Other rich card elements (images, select menus, radios) render as fallback text.

## Feature support

<FeatureSupport />
