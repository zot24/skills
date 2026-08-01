> Source: https://chat-sdk.dev/adapters/official/xchat.md

---
title: XChat
description: XChat (encrypted messaging) adapter using the X API v2 chat endpoints and the X Activity API.
tagline: Hold encrypted 1:1 and group conversations on XChat, with all cryptography handled inside the adapter.
package: @chat-adapter/x
---

# XChat


## Install


## Quick start


  The adapter auto-detects `XCHAT_BOT_TOKEN`, `XCHAT_PIN`, and `X_CONSUMER_SECRET` from the environment. The bot's user id and @handle are resolved from `GET /2/users/me` at startup.


```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createXchatAdapter } from "@chat-adapter/x/chat";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    xchat: createXchatAdapter(),
  },
});

bot.onDirectMessage(async (thread, message) => {
  await thread.post(`You said: ${message.text}`);
});

bot.onNewMention(async (thread, message) => {
  await thread.post(`You said: ${message.text}`);
});
```

X sends two kinds of webhook requests: a **CRC challenge** (GET) answered with an HMAC-SHA256 of the token keyed by your app's consumer secret, and **event delivery** (POST) verified by the adapter via the `x-twitter-webhooks-signature` header. Handle the CRC challenge at the route level; it needs no adapter state:

```typescript title="app/api/webhooks/xchat/route.ts" lineNumbers
import { createHmac } from "node:crypto";
import { bot } from "@/lib/bot";

export async function GET(request: Request) {
  const url = new URL(request.url);
  const crcToken = url.searchParams.get("crc_token");
  if (!crcToken) {
    return new Response("Missing crc_token", { status: 400 });
  }
  const hash = createHmac("sha256", process.env.X_CONSUMER_SECRET!)
    .update(crcToken)
    .digest("base64");
  return Response.json({ response_token: `sha256=${hash}` });
}

export async function POST(request: Request) {
  return bot.webhooks.xchat(request);
}
```

## Configuration


## Setup

### 1. Register encryption keys

The bot account needs registered public keys and a Juicebox-backed private-key store before it can participate in encrypted conversations:

1. Generate keypairs with [`chat-xdk`](https://github.com/xdevplatform/chat-xdk) (`generateKeypairs()`).
2. Register them via `POST /2/users/{id}/public_keys`.
3. Store the private keys in Juicebox with a PIN (`chat.setup(pin)`).

The adapter unlocks the keys at startup with the same PIN (`XCHAT_PIN`). Registration is a one-time step per account.

### 2. Create a webhook

Register a webhook URL so the [X Activity API](https://docs.x.com/x-api/activity/introduction) can deliver events:

```bash
curl -X POST "https://api.x.com/2/webhooks" \
  -H "Authorization: Bearer $APP_BEARER_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://your-domain.com/api/webhooks/xchat"}'
```

X validates the URL with a CRC challenge, so the endpoint must be live before you create the webhook. Webhooks and activity subscriptions can also be managed in the [X Developer Portal](https://developer.x.com/en/portal/dashboard).

### 3. Subscribe to chat events

Create [activity subscriptions](https://docs.x.com/x-api/activity/create-x-activity-subscription) for the bot user with the bot's OAuth 2.0 user token:

```bash
curl -X POST "https://api.x.com/2/activity/subscriptions" \
  -H "Authorization: Bearer $BOT_USER_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "event_type": "chat.received",
    "filter": {"user_id": "YOUR_BOT_USER_ID"},
    "tag": "bot-chat-received",
    "webhook_id": "YOUR_WEBHOOK_ID"
  }'
```

Subscribe to `chat.conversation_join` as well if you want the bot to post a welcome message when it is added to a group.

## Environment variables

```bash
XCHAT_BOT_TOKEN=xcbot_...          # OAuth2 user token for the bot account
XCHAT_PIN=...                      # Juicebox PIN for key unlock
X_CONSUMER_SECRET=...              # App secret (CRC + webhook signature verification)
X_BOT_USERNAME=...                 # Optional @handle override; resolved from /2/users/me otherwise
X_VERIFY_SIGNATURES=true           # Optional; set false to accept unverifiable messages
```

## Advanced

### Encryption

Every XChat conversation is encrypted. The adapter handles the full crypto lifecycle transparently: conversation-key extraction and caching, message decryption and signature verification, and encryption + signing on send. Conversation keys arrive via `KeyChange` events and are cached per conversation and key version. Incoming message signatures are verified against participants' signing keys; with `verifySignatures: true` (the default), unverifiable messages are dropped. Media is encrypted separately from message text using streaming encryption.

### Formatting

XChat has no client-side markdown rendering — outgoing markdown appears literally as plain text. URLs and @mentions are detected in outgoing text and rendered as tappable links and mention pills, tables are rendered as ASCII code blocks, and cards degrade to text with URL/mention entities plus a URL preview attachment (the first `x.com/.../status/...` URL in outgoing text auto-attaches as a post card).

### Edits, deletes, and streaming

The adapter can edit and delete only the bot's own messages. The first edit of a fresh message is held until the message is `editSafetyDelayMs` old (default 5000ms), so receiving clients have stored the original before the edit arrives. Deletes are delete-for-all. Streaming works through message edits, but the age gate makes rapid token-by-token updates coarse.

### Mention behavior in groups

`bot.onNewMention(handler)` fires for group messages that mention the bot. A group message counts as a mention when its rich-text mention entities include the bot's @handle or user ID, when it is a swipe-reply to one of the bot's own messages, or when its plain text contains `@handle` (fallback when no entities are present). To reply to every group message instead, register a catch-all `bot.onNewMessage(/.+/, handler)`.

### Open DM

`openDM(userId)` reuses an existing conversation or runs a fresh key exchange so the bot can message first. It requires the recipient to have encrypted chat set up, and the server requires the recipient to trust the bot (e.g. follow it) before the first message is accepted.

### Read receipts and typing

A read receipt is sent for each delivered inbound message before handlers run unless `sendReadReceipts: false`. The typing indicator is re-sent every 3 seconds while a handler runs.

### Thread ID format

```
xchat:{conversationId}
```

* 1:1 conversations: `xchat:1234567890-9876543210` (both participant IDs)
* Group conversations: `xchat:g123456789` (opaque `g`-prefixed ID)

REST paths use the other participant's user ID for 1:1 conversations and the `g...` ID for groups; the adapter converts automatically.

## Feature support


