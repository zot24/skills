> Source: https://chat-sdk.dev/adapters/official/whatsapp.md

---
title: WhatsApp Business Cloud
description: WhatsApp Business Cloud adapter for Chat SDK.
tagline: Connect to WhatsApp Business Cloud for customer messaging and automated conversations.
package: @chat-adapter/whatsapp
---

# WhatsApp Business Cloud


## Install


## Quick start


  The adapter auto-detects `WHATSAPP_ACCESS_TOKEN`, `WHATSAPP_APP_SECRET`, `WHATSAPP_PHONE_NUMBER_ID`, and `WHATSAPP_VERIFY_TOKEN` from the environment.


```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createWhatsAppAdapter } from "@chat-adapter/whatsapp";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    whatsapp: createWhatsAppAdapter(),
  },
});

bot.onNewMention(async (thread, message) => {
  await thread.post("Hello from WhatsApp!");
});
```

```typescript title="app/api/webhooks/whatsapp/route.ts" lineNumbers
import { bot } from "@/lib/bot";

export async function GET(request: Request) {
  return bot.webhooks.whatsapp(request);
}

export async function POST(request: Request) {
  return bot.webhooks.whatsapp(request);
}
```

## Configuration


## Authentication

### 1. Create a Meta app

1. Go to [developers.facebook.com/apps](https://developers.facebook.com/apps) and create a **Business** app.
2. Add the **WhatsApp** product to your app.
3. Open **WhatsApp** then **API Setup** to find your **Phone Number ID** and a temporary **Access Token**.

### 2. Configure webhooks

1. Open **WhatsApp** then **Configuration**.
2. Set the callback URL to `https://your-domain.com/api/webhooks/whatsapp`.
3. Set a **Verify Token** of your choosing — this becomes `WHATSAPP_VERIFY_TOKEN`.
4. Subscribe to the `messages` webhook field.

### 3. Get credentials

From your Meta app dashboard, copy:

* **App Secret** (under **App Settings** then **Basic**) → `WHATSAPP_APP_SECRET`.
* **Access Token** (under **WhatsApp** then **API Setup**) → `WHATSAPP_ACCESS_TOKEN`. For production, generate a permanent **System User Token** instead.
* **Phone Number ID** (under **WhatsApp** then **API Setup**) → `WHATSAPP_PHONE_NUMBER_ID`.

## Advanced

### Webhook flow

WhatsApp uses two webhook mechanisms:

* **Verification handshake** (GET) — Meta sends a `hub.verify_token` challenge that must match your `WHATSAPP_VERIFY_TOKEN`.
* **Event delivery** (POST) — incoming messages, reactions, and interactive responses, verified via `X-Hub-Signature-256`.

### Interactive messages

Card elements are automatically converted to WhatsApp interactive messages:

* **3 or fewer buttons** — rendered as WhatsApp reply buttons (max 20 chars per title).
* **More than 3 buttons** — falls back to formatted text.
* **Max body text** — 1024 characters.

### Thread ID format

```
whatsapp:{phoneNumberId}:{userWaId}
```

Example: `whatsapp:1234567890:15551234567`.

### Auto-chunking

Outgoing messages longer than 4096 characters are automatically chunked.

## Feature support


