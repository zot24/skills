> Source: https://chat-sdk.dev/adapters/official/messenger.md

---
title: Messenger
description: Facebook Messenger adapter using the Messenger Platform API.
tagline: Build bots for Facebook Messenger with templates, buttons, reactions, and postbacks.
package: @chat-adapter/messenger
---

# Messenger


## Install


## Quick start


  The adapter auto-detects `FACEBOOK_APP_SECRET`, `FACEBOOK_PAGE_ACCESS_TOKEN`, `FACEBOOK_VERIFY_TOKEN`, and `FACEBOOK_BOT_USERNAME` from the environment.


```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createMessengerAdapter } from "@chat-adapter/messenger";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    messenger: createMessengerAdapter(),
  },
});

bot.onDirectMessage(async (thread, message) => {
  await thread.post("Hello from Messenger!");
});
```

```typescript title="app/api/webhooks/messenger/route.ts" lineNumbers
import { bot } from "@/lib/bot";

export async function GET(request: Request) {
  return bot.webhooks.messenger(request);
}

export async function POST(request: Request) {
  return bot.webhooks.messenger(request);
}
```

## Configuration


## Authentication

### 1. Create a Meta app

1. Go to [developers.facebook.com/apps](https://developers.facebook.com/apps).
2. Create an app and select **"Engage with customers on Messenger from Meta"**.
3. Under **App Settings** then **Basic**, copy the **App Secret** to `FACEBOOK_APP_SECRET`.

### 2. Create a Facebook Page

Your Messenger bot needs a Facebook Page to send and receive messages. Create one under a Facebook Business profile if you don't already have one — users message the Page to interact with your bot.

### 3. Configure Messenger API

In your Meta app dashboard, open **Use Cases** then **Messenger API Settings**.

**Configure webhooks:**

1. Click **Add Callback URL** and enter `https://your-domain.com/api/webhooks/messenger`.
2. Set a **Verify Token** of your choice — this becomes `FACEBOOK_VERIFY_TOKEN`.
3. Click **Verify and Save**.
4. Add subscriptions: `messages`, `messaging_postbacks`, `messaging_reactions`, `message_deliveries`, `message_reads`.

**Generate a Page Access Token:**

1. Under **Generate access tokens** click **Add or remove Pages** and select your Page.
2. Generate the token and copy it to `FACEBOOK_PAGE_ACCESS_TOKEN`.

## Advanced

### Webhook flow

Messenger uses two webhook mechanisms:

* **Verification handshake** (GET) — Meta sends a `hub.verify_token` challenge that must match your `FACEBOOK_VERIFY_TOKEN`.
* **Event delivery** (POST) — incoming messages, reactions, and postbacks, verified via `X-Hub-Signature-256`.

### Interactive messages

Card elements are automatically converted to Messenger templates:

* **Generic Template** — used when the card has a `title` or `imageUrl`. Up to 3 buttons.
* **Button Template** — used when the card has text content and buttons but no title/image. Max 640 characters.
* **Text Fallback** — used when the card contains unsupported elements (tables, select menus) or exceeds constraints.

Constraints:

* Max 3 buttons per template.
* Button titles limited to 20 characters (truncated with ellipsis).
* Subtitles limited to 80 characters.
* Button Template text limited to 640 characters.

### Thread ID format

```
messenger:{recipientId}
```

Example: `messenger:27161130920158013`.

## Feature support


