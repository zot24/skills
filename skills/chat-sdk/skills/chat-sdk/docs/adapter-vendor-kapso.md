> Source: https://chat-sdk.dev/adapters/vendor-official/kapso.md

---
title: Kapso
description: Kapso-first WhatsApp adapter for Chat SDK. Receive Kapso platform webhooks, reply through Chat SDK threads, send cards/buttons and media, and fetch Kapso conversation history.
tagline: WhatsApp adapter for Chat SDK backed by Kapso webhooks, sends, media, reactions, contacts, conversations, and message history.
package: @kapso/chat-adapter
---

# Kapso


## Install

<PackageInstall package="@kapso/chat-adapter chat" />

Install a durable Chat SDK state adapter for production. The examples below use `@chat-adapter/state-memory` for local development.

## Quick start

```typescript title="lib/bot.ts" lineNumbers


/>

### Environment variables

| Variable                | Required    | Description                                                                                            |
| ----------------------- | ----------- | ------------------------------------------------------------------------------------------------------ |
| `KAPSO_API_KEY`         | Yes         | Kapso API key used for sends, history, contacts, conversations, and media.                             |
| `KAPSO_PHONE_NUMBER_ID` | Recommended | WhatsApp phone number ID connected in Kapso. Required for `openDM()` and useful as a webhook fallback. |
| `KAPSO_WEBHOOK_SECRET`  | Recommended | Secret used to verify Kapso `X-Webhook-Signature` webhook deliveries.                                  |
| `KAPSO_BASE_URL`        | No          | Kapso proxy URL. Defaults to `https://api.kapso.ai/meta/whatsapp`.                                     |
| `KAPSO_BOT_USERNAME`    | No          | Bot display name. Defaults to the Chat SDK `userName` after initialization.                            |

## Platform setup

1. Create or use a Kapso integration and copy your **API key**.
2. Copy the WhatsApp **phone number ID** connected in Kapso if the bot will initiate outbound direct messages.
3. Create a webhook secret in Kapso and set the same value as `KAPSO_WEBHOOK_SECRET`.
4. Configure your webhook endpoint URL to the public route that forwards requests to `bot.webhooks.kapso`.
5. Subscribe to `whatsapp.message.received`; add `whatsapp.message.sent` only if your app needs sent-message echoes.

## Webhook route

Kapso sends platform webhooks as `POST` requests. Forward the raw `Request` to Chat SDK:

```typescript title="app/api/webhooks/kapso/route.ts" lineNumbers

export async function POST(request: Request): Promise<Response> {
  return bot.webhooks.kapso(request);
}
```

The adapter verifies Kapso `X-Webhook-Signature` headers by default and returns `401` for invalid signed requests. For unsigned local fixtures only, pass `verifyWebhookSignatures: false`.

## Sending messages

Reply inside an incoming WhatsApp handler:

```typescript
bot.onDirectMessage(async (thread, message) => {
  await thread.post({
    markdown: `Received: **${message.text}**`,
  });
});
```

Start a WhatsApp conversation from your app with `openDM()`:

```typescript

const adapter = bot.getAdapter("kapso") as KapsoAdapter;
const threadId = await adapter.openDM("15551234567");
const thread = bot.thread(threadId);

await thread.post("Hello from Kapso.");
```

## Buttons and cards

Chat SDK card buttons render as WhatsApp reply buttons.

```tsx

await thread.post(
  Card({
    title: "Approve refund?",
    children: [
      Actions([
        Button({ id: "approve", label: "Approve", value: "refund-123" }),
        Button({ id: "reject", label: "Reject", value: "refund-123" }),
      ]),
    ],
  })
);
```

WhatsApp supports up to 3 reply buttons. Button labels must be 1-20 characters, and the adapter throws a validation error instead of silently truncating labels or dropping buttons.

## Media

Send files through Chat SDK:

```typescript

await thread.post({
  markdown: "Here is the receipt.",
  files: [
    {
      filename: "receipt.pdf",
      mimeType: "application/pdf",
      data: await readFile("receipt.pdf"),
    },
  ],
});
```

Inbound media is exposed as Chat SDK attachments. When Kapso includes a mirrored media URL, the attachment has `url`. When a WhatsApp media ID is available, the attachment has lazy `fetchData()`.

## History

With `KAPSO_API_KEY`, history reads from Kapso:

```typescript
const page = await thread.adapter.fetchMessages(thread.id, { limit: 20 });
```

`fetchThread()` enriches metadata with Kapso contact and conversation records when available.

## Thread IDs

Current thread IDs are encoded as:

```text
kapso:<base64url(phoneNumberId)>:<base64url(waId)>[:<base64url(conversationId)>]
```

Use helpers instead of constructing thread IDs manually:

```typescript
const threadId = adapter.encodeThreadId({
  phoneNumberId: "16315558151",
  waId: "15551234567",
});

const decoded = adapter.decodeThreadId(threadId);
```

## Limitations

* Direct Meta webhook setup is a compatibility path; Kapso platform webhooks are preferred.
* Message edit/delete is not supported by WhatsApp/Kapso for recipient devices.
* Raw WhatsApp templates, flows, and catalogs should be sent through `@kapso/whatsapp-cloud-api` directly alongside the Chat SDK adapter.
* Streaming is not supported by WhatsApp/Kapso for recipient devices.

## Links

* [Kapso docs](https://docs.kapso.ai/)
* [GitHub](https://github.com/gokapso/chat-sdk-adapter)
* [npm](https://www.npmjs.com/package/@kapso/chat-adapter)

## Feature support

<FeatureSupport />
