> Source: https://chat-sdk.dev/adapters/official/x.md

---
title: X
description: X (Twitter) adapter using the X API v2 and the X Activity API.
tagline: Reply to public mentions and hold direct message conversations on X.
package: @chat-adapter/x
---

# X


## Install


## Quick start


  The adapter auto-detects `X_CONSUMER_SECRET`, `X_USER_ACCESS_TOKEN`, `X_USER_ID`, and `X_USERNAME` from the environment.


```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createXAdapter } from "@chat-adapter/x";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    x: createXAdapter(),
  },
});

bot.onNewMention(async (thread, message) => {
  await thread.post(`Hi @${message.author.userName}!`);
});

bot.onDirectMessage(async (thread, message) => {
  await thread.post("Hello from X!");
});
```

```typescript title="app/api/webhooks/x/route.ts" lineNumbers
import { bot } from "@/lib/bot";

export async function GET(request: Request) {
  return bot.webhooks.x(request);
}

export async function POST(request: Request) {
  return bot.webhooks.x(request);
}
```

## Configuration


## Authentication

### 1. Create an X app

1. Go to the [X developer portal](https://developer.x.com) and create a Project and App.
2. Under **Keys and tokens**, copy the **API Key Secret** to `X_CONSUMER_SECRET`.
3. Enable **OAuth 2.0** user authentication with the scopes `tweet.read`, `tweet.write`, `users.read`, `dm.read`, `dm.write`, `like.write`, `media.write`, and `offline.access`.
4. Complete the OAuth 2.0 flow for the bot account. Either store the access token as `X_USER_ACCESS_TOKEN`, or store `X_CLIENT_ID` plus `X_REFRESH_TOKEN` to let the adapter manage token refresh.


  X OAuth 2.0 user tokens expire after about two hours. For long-running bots, configure managed refresh (`clientId` + `refreshToken`): the adapter refreshes tokens before expiry and persists the rotated refresh token in the state adapter, encrypted when `encryptionKey` is set.


### 2. Register a webhook and subscriptions

X delivers events through the [X Activity API](https://docs.x.com/x-api/activity/introduction). Set this up once, in the [X developer console](https://console.x.com), which handles the auth for you:

1. Register your webhook URL (`https://your-domain.com/api/webhooks/x`). It must be publicly reachable over HTTPS and cannot include a port. X sends a CRC challenge immediately and revalidates hourly; the adapter answers both automatically.
2. Create subscriptions for the events the adapter consumes: `post.mention.create`, `dm.received`, and `dm.sent`. These are private events, so the bot user must have authorized your app first.


  Subscription and webhook management is one-time setup, not something the adapter does at runtime. If you script it instead of using the console, note the Activity API endpoints are auth-picky and operation-specific (creating a private-event subscription needed OAuth 1.0a user context in testing, while list and delete used the app-only bearer token), and do not fully match the published spec. The console avoids all of this.


## Advanced

### Webhook flow

* **CRC challenge** (GET): X sends a `crc_token`, answered with `sha256=<base64 HMAC>` keyed by the consumer secret.
* **Event delivery** (POST): activity events signed via `x-twitter-webhooks-signature`, verified against the raw request body with timing-safe comparison.

### Streaming

X has no native streaming and public post edits are eligibility-gated, so the adapter buffers the entire stream and posts once on completion instead of using post+edit updates.

### Reply threading

Replies target the most recent mention received in the conversation, and consecutive replies chain under the bot's previous reply. Top-level posts go through `channel.post` on the `x:public` channel.

### Reactions

Likes are the only reaction X exposes. `addReaction` accepts `emoji.heart` or `"like"` and maps to `POST /2/users/:id/likes`; anything else throws a `ValidationError`.

### Media uploads

Attach images by passing `files` (or `attachments`) on the message. The adapter uploads each image (png, jpeg, webp) through X's chunked media endpoints (`initialize` then `append` then `finalize`) and attaches the returned `media_id`s. Posts and DMs accept up to four images, with or without text.

```typescript
await thread.post({
  markdown: "France lead the title race",
  files: [{ data: pngBuffer, filename: "odds.png", mimeType: "image/png" }],
});
```

Media upload requires the `media.write` scope on the OAuth 2.0 token, alongside `tweet.write`; without it uploads fail with a 403.

### Thread ID format

```
x:post:{conversationId}   # public post threads (channel: x:public)
x:dm:{participantUserId}  # direct message with a single user
```

Examples: `x:post:1943467279943467279`, `x:dm:783214`. X DM webhooks carry no conversation id, only participant ids, so DMs are threaded by the other participant's user id: `openDM("783214")` returns `x:dm:783214`, and both replies and inbound events for that conversation share the same thread. Sends route to the by-participant endpoint (`POST /2/dm_conversations/with/{id}/messages`).

### Automation policy

X enforces [automation rules](https://docs.x.com/developer-terms/policy): get explicit consent before automated replies or DMs, honor opt-outs immediately, disclose the bot identity in the account profile, and never send bulk or duplicate automated content.

## Feature support


