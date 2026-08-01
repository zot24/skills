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

### Template messages

Outside the 24-hour customer service window, WhatsApp only accepts pre-approved [template messages](https://developers.facebook.com/docs/whatsapp/cloud-api/guides/send-message-templates). Use `sendTemplate` to start business-initiated conversations:

```typescript
const threadId = await adapter.openDM("15551234567");

await adapter.sendTemplate(threadId, {
  name: "appointment_reminder",
  language: "en",
  components: [
    {
      type: "body",
      parameters: [{ type: "text", text: "Tomorrow at 2pm" }],
    },
  ],
});
```

Templates must be created and approved in [WhatsApp Manager](https://business.facebook.com/wa/manage/message-templates/) before they can be sent. Quick reply button taps on a template arrive as button responses and are dispatched to your `onAction` handlers.

### Thread ID format

```
whatsapp:{phoneNumberId}:{userWaId}
```

Example: `whatsapp:1234567890:15551234567`.

### Auto-chunking

Outgoing messages longer than 4096 characters are automatically chunked.

### File uploads

`postMessage` accepts both `files` and `attachments` (typed media with optional `data`, `fetchData`, or a public URL). See the [file uploads guide](/docs/files) for the shared API.

WhatsApp-specific behavior:

* **One media per message** — multiple `files` or `attachments` in a single `post()` are sent as sequential messages (the last message ID is returned).
* **Captions** — markdown (or card fallback text) is attached as a caption on the first media message when supported (max 1024 characters). Text is sent as a separate message first when the caption is too long or when the first media is audio (audio does not support captions).
* **Binary vs link** — buffers are uploaded via the Cloud API `/media` endpoint; `attachments` with only an `url` use HTTPS link passthrough (no upload). URLs must use `https://`.
* **Cards + files** — when the card renders as an interactive message (reply buttons or a list), media is sent first without a caption and the interactive message that follows carries the title, body, and buttons. When the card falls back to plain text (e.g. only link buttons), the fallback text captions the first media. To send a photo with buttons, pass the image via `files` or `attachments` — card-embedded images (`imageUrl` or `<Image>` children) are not sent as native media.

```typescript title="lib/bot.ts" lineNumbers
await thread.post({
  markdown: "Here's the report:",
  files: [
    {
      data: reportBuffer,
      filename: "report.pdf",
      mimeType: "application/pdf",
    },
  ],
});
```

## Feature support


