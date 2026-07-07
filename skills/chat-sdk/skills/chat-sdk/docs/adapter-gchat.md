> Source: https://chat-sdk.dev/adapters/official/gchat.md

---
title: Google Chat
description: Google Chat adapter with service account auth and optional Pub/Sub.
tagline: Integrate with Google Chat spaces for team collaboration and automated workflows.
package: @chat-adapter/gchat
---

# Google Chat


## Install


## Quick start


  The adapter auto-detects `GOOGLE_CHAT_CREDENTIALS` (or `GOOGLE_CHAT_USE_ADC`) from the environment.


```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createGoogleChatAdapter } from "@chat-adapter/gchat";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    gchat: createGoogleChatAdapter(),
  },
});

bot.onNewMention(async (thread, message) => {
  await thread.post("Hello from Google Chat!");
});
```

## Configuration


One of `googleChatProjectNumber`, `pubsubAudience`, or `disableSignatureVerification: true` is required — the constructor throws otherwise. Configure the verifier(s) for each transport you actually receive.

## Authentication

### 1. Create a GCP project

1. Go to [console.cloud.google.com](https://console.cloud.google.com) and create a project.
2. Enable **Google Chat API**, **Google Workspace Events API** (for receiving all messages), and **Cloud Pub/Sub API**.

### 2. Create a service account

1. Open **IAM & Admin** then **Service Accounts** and click **Create Service Account**.
2. After creation, open the account and go to the **Keys** tab.
3. Click **Add Key** then **Create new key** then **JSON**.
4. Copy the JSON to `GOOGLE_CHAT_CREDENTIALS`.


  If your organization has the `iam.disableServiceAccountKeyCreation` constraint enabled, you need to relax it or add a project exception under **IAM & Admin** then **Organization Policies**.


### 3. Configure the Chat app

1. Open the [Chat API configuration](https://console.cloud.google.com/apis/api/chat.googleapis.com/hangouts-chat).
2. Fill in app name, avatar, description.
3. Enable **Receive 1:1 messages** and **Join spaces and group conversations**.
4. Set connection settings to **App URL** with `https://your-domain.com/api/webhooks/gchat`.
5. Set visibility, then save.

### 4. Add the bot to a space

1. Open Google Chat.
2. In a Space, open **Manage apps & integrations** then **Add apps** and find your app.

## Advanced

### Pub/Sub for receiving all messages

By default, Google Chat only sends webhooks for @mentions. To receive all messages in a space, set up Workspace Events with Pub/Sub.

```typescript title="lib/bot.ts" lineNumbers
createGoogleChatAdapter({
  pubsubTopic: process.env.GOOGLE_CHAT_PUBSUB_TOPIC,
  impersonateUser: process.env.GOOGLE_CHAT_IMPERSONATE_USER,
});
```

**Topic & subscription:**

1. Under **Pub/Sub** then **Topics**, create a topic (e.g. `chat-events`) and copy its full name to `GOOGLE_CHAT_PUBSUB_TOPIC`.
2. Add `chat-api-push@system.gserviceaccount.com` as a Pub/Sub Publisher.
3. Create a Push subscription with endpoint `https://your-domain.com/api/webhooks/gchat`.

**Domain-wide delegation:**

Required for Workspace Events subscriptions and initiating DMs.

1. In **IAM & Admin** then **Service Accounts**, edit your service account and check **Enable Google Workspace Domain-wide Delegation**. Copy the numeric **Client ID**.
2. In the [Google Admin Console](https://admin.google.com), go to **Security** then **Access and data control** then **API controls**, then **Manage Domain Wide Delegation**.
3. Add the Client ID with these comma-separated scopes:
   ```
   https://www.googleapis.com/auth/chat.spaces.readonly,
   https://www.googleapis.com/auth/chat.messages.readonly,
   https://www.googleapis.com/auth/chat.spaces,
   https://www.googleapis.com/auth/chat.spaces.create
   ```
4. Set `GOOGLE_CHAT_IMPERSONATE_USER` to an admin email.

### Webhook verification

The two transports share one HTTP endpoint, so each verifier only covers its own request shape:

* **Direct webhooks** — Google Chat sends a signed JWT whose `aud` claim is your GCP project number. Configure with `googleChatProjectNumber`.
* **Pub/Sub push** — Cloud Pub/Sub sends a signed OIDC JWT whose audience is whatever you configured on the push subscription. Configure with `pubsubAudience`.

If you only configure `googleChatProjectNumber`, incoming Pub/Sub-shaped requests are rejected with HTTP 401 — and vice versa. Configure both if you receive both.

### Limitations

* **Typing indicators** — not supported by the Google Chat API.
* **Adding reactions** — the Chat API doesn't allow service-account auth for reactions. With `impersonateUser` configured, the reaction appears as coming from the impersonated user.
* **Message history (`fetchMessages`)** — requires domain-wide delegation with `impersonateUser`.

## Feature support


