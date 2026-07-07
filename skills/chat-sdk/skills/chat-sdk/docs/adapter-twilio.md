> Source: https://chat-sdk.dev/adapters/official/twilio.md

---
title: Twilio
description: Twilio SMS and MMS adapter for Chat SDK.
tagline: Build SMS and MMS bots with Twilio Messaging webhooks and the Messages API.
package: @chat-adapter/twilio
---

# Twilio


## Install


## Quick start


  The adapter auto-detects `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`, `TWILIO_PHONE_NUMBER`, and `TWILIO_MESSAGING_SERVICE_SID` from the environment.


```typescript title="lib/bot.ts" lineNumbers
import { createTwilioAdapter } from "@chat-adapter/twilio";
import { Chat } from "chat";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    twilio: createTwilioAdapter(),
  },
});

bot.onDirectMessage(async (thread, message) => {
  await thread.post(`You said: ${message.text}`);
});
```

```typescript title="app/api/webhooks/twilio/route.ts" lineNumbers
import { bot } from "@/lib/bot";

export async function POST(request: Request): Promise<Response> {
  return bot.webhooks.twilio(request);
}
```

Configure your Twilio Messaging webhook URL to:

```text
https://your-domain.com/api/webhooks/twilio
```

## Configuration


## Authentication

1. Create or open a Twilio account.
2. Copy the **Account SID** to `TWILIO_ACCOUNT_SID`.
3. Copy the **Auth Token** to `TWILIO_AUTH_TOKEN`.
4. Copy a sender phone number to `TWILIO_PHONE_NUMBER`, or copy a Messaging Service SID to `TWILIO_MESSAGING_SERVICE_SID`.

## Webhooks

Twilio sends Messaging webhooks as form-encoded requests and signs them with the `X-Twilio-Signature` header. The adapter validates the exact public URL plus the submitted form parameters before dispatching an inbound message.

If your framework rewrites the request URL before it reaches the adapter, pass `webhookUrl` with the public URL configured in Twilio:

```typescript title="lib/bot.ts" lineNumbers
createTwilioAdapter({
  webhookUrl: "https://your-domain.com/api/webhooks/twilio",
});
```

## Media

Inbound MMS media is exposed as message attachments. Twilio media URLs are not treated as public files, so each attachment includes `fetchData()` and `fetchMetadata` for authenticated downloads and queue rehydration.

Outbound media supports attachments that already have a public `url`. Chat SDK cannot upload arbitrary binary files to Twilio for you because the Messages API expects each `MediaUrl` to be reachable by Twilio.

```typescript title="send-photo.ts" lineNumbers
await thread.post({
  markdown: "photo attached",
  attachments: [
    {
      type: "image",
      url: "https://example.com/photo.jpg",
    },
  ],
});
```

## Advanced

### Messaging services

When a thread sender starts with `MG`, outbound messages use `MessagingServiceSid` instead of `From`:

```typescript title="send-with-service.ts" lineNumbers
const threadId = twilio.encodeThreadId({
  sender: "MGXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  recipient: "+15555550100",
});

await bot.adapters.twilio.postMessage(threadId, "hello");
```

### Low-level helpers

The package includes runtime-light subpaths for apps that only need Twilio primitives:

```typescript title="twilio-primitives.ts" lineNumbers
import { sendTwilioMessage } from "@chat-adapter/twilio/api";
import { truncateTwilioText } from "@chat-adapter/twilio/format";
import { gatherSpeechTwilioResponse } from "@chat-adapter/twilio/voice";
import { readTwilioWebhook } from "@chat-adapter/twilio/webhook";
```

These subpaths do not import the full Chat SDK adapter or the `twilio` npm package.

### Voice helpers

Twilio voice calls are exposed as low-level primitives, not routed through the SMS/MMS adapter. Use them when your app owns the voice route and wants reusable TwiML or call-update helpers:

```typescript title="app/api/webhooks/twilio/voice/route.ts" lineNumbers
import {
  gatherSpeechTwilioResponse,
  parseTwilioVoiceCall,
} from "@chat-adapter/twilio/voice";
import { verifyTwilioRequest } from "@chat-adapter/twilio/webhook";

export async function POST(request: Request): Promise<Response> {
  const verified = await verifyTwilioRequest(request);
  const call = parseTwilioVoiceCall(verified.params);

  if (!call) {
    return new Response("Invalid voice webhook", { status: 400 });
  }

  return gatherSpeechTwilioResponse({
    actionUrl: "https://your-domain.com/api/webhooks/twilio/voice/result",
    prompt: "How can I help?",
  });
}
```

Custom voice routes should verify the Twilio signature and apply your own caller allow-list before returning TwiML.

For live calls, `updateTwilioCall()` in `@chat-adapter/twilio/api` can post replacement TwiML or redirect the call to another URL.

### Notes

* Twilio does not support message edits, reactions, modals, or typing indicators for SMS.
* Cards render as plain text fallback. Buttons and select menus are not interactive over SMS.
* `fetchMessages` uses the Messages API and is best for phone-number based threads. Messaging Service history can be less precise because inbound webhooks identify the receiving phone number, not only the Messaging Service SID.

## Feature support


