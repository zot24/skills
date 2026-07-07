> Source: https://chat-sdk.dev/adapters/community/webex.md

---
title: Webex
description: Community Webex adapter for Chat SDK with support for spaces, threads, adaptive cards, and modals.
tagline: Community Webex adapter for Chat SDK. Supports spaces, threads, adaptive cards (buttons, selects, fields, sections), modals, and webhook signature verification.
package: @bitbasti/chat-adapter-webex
---

# Webex


## Install


## Quick start

```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createWebexAdapter } from "@bitbasti/chat-adapter-webex";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    webex: createWebexAdapter({
      botToken: process.env.WEBEX_BOT_TOKEN,
      webhookSecret: process.env.WEBEX_WEBHOOK_SECRET,
    }),
  },
});

bot.onNewMention(async (thread, message) => {
  await thread.post(`Hello from Webex! You said: ${message.text}`);
});
```

## Environment variables

| Variable               | Required    | Description                                                           |
| ---------------------- | ----------- | --------------------------------------------------------------------- |
| `WEBEX_BOT_TOKEN`      | Yes         | Bot access token from the Webex Developer Portal                      |
| `WEBEX_WEBHOOK_SECRET` | Recommended | Shared secret for webhook signature verification                      |
| `WEBEX_BASE_URL`       | No          | Override the Webex API base URL (default: `https://webexapis.com/v1`) |
| `WEBEX_BOT_USERNAME`   | No          | Override the bot display name                                         |

## Configuration


## Platform setup

1. Go to the [Webex Developer Portal](https://developer.webex.com/) and sign in.
2. Navigate to **My Webex Apps → Create a New App → Create a Bot**.
3. Fill in the bot name, username, and icon, then click **Add Bot**.
4. Copy the **Bot Access Token** — this is your `WEBEX_BOT_TOKEN`. Store it securely; it is only shown once.
5. Create a webhook pointing to your server:
   * **Target URL:** `https://your-domain.com/api/webhooks/webex`
   * **Resource:** `messages` | **Event:** `created`
   * **Resource:** `attachmentActions` | **Event:** `created`
   * **Secret:** a random string — this is your `WEBEX_WEBHOOK_SECRET`
6. Add the bot to a Webex space and mention it to verify the integration.

See the [Webex Webhooks Guide](https://developer.webex.com/messaging/docs/api/guides/webhooks) for details on webhook registration.

## Capabilities

* Mentions and DMs
* Rich text (bold, italic, code, links) via Markdown
* Adaptive Cards — buttons, selects, radio selects, fields, sections
* Modals — form cards with submit/close actions
* File uploads (single file per message)
* Thread support via parent IDs
* Webhook signature verification (HMAC-SHA1)

## Limitations

* **Reactions** are not supported by Webex bot tokens — `addReaction` / `removeReaction` throw `NotImplementedError`.
* **Typing indicators** are not available in the Webex Messaging API.
* Only **one file upload per message** is supported.
* **Cards and file uploads** cannot be combined in the same message.

## Feature support


