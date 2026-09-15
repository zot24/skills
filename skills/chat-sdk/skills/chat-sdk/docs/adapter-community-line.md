> Source: https://chat-sdk.dev/adapters/community/line.md

---
title: LINE
description: Community LINE Messaging API adapter for Chat SDK with Flex Message cards, inbound media, action postbacks, and typing indicators.
tagline: LINE Messaging API adapter for Chat SDK. Send text and Flex Message cards, receive media and postback actions, and verify signed webhooks.
package: chat-adapter-line
---

# LINE


## Install


## Quick start

```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createLineAdapter } from "chat-adapter-line";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    line: createLineAdapter(),
  },
});

bot.onDirectMessage(async (thread, message) => {
  await thread.post(`You said: ${message.text}`);
});
```

When called with no arguments, `createLineAdapter()` reads `LINE_CHANNEL_ACCESS_TOKEN` and `LINE_CHANNEL_SECRET` from the environment.

## LINE channel setup

1. Create a provider and channel in the [LINE Developers Console](https://developers.line.biz/console/).
2. Enable the Messaging API for the channel.
3. Copy the channel access token and channel secret.
4. Set the webhook URL to a public HTTPS endpoint, such as `https://your-domain.com/api/webhooks/line`.
5. Subscribe to message and postback events.

## Configuration


## Environment variables

| Variable                    | Required | Description                                                      |
| --------------------------- | -------- | ---------------------------------------------------------------- |
| `LINE_CHANNEL_ACCESS_TOKEN` | Yes      | LINE channel access token, unless you pass `channelAccessToken`. |
| `LINE_CHANNEL_SECRET`       | Yes      | LINE channel secret, unless you pass `channelSecret`.            |

## Webhook setup

```typescript title="app/api/webhooks/line/route.ts" lineNumbers
import { bot } from "@/lib/bot";

export async function POST(request: Request): Promise<Response> {
  return bot.webhooks.line(request);
}
```

LINE sends each webhook with an `x-line-signature` header. The adapter computes an HMAC-SHA256 digest with the channel secret and compares it with the header before parsing the body.

## Messages and cards

Text and Markdown output are converted to plain text. Chat SDK cards become LINE Flex Messages: the card title and text become the bubble body, and buttons become postback actions in the footer. Button clicks dispatch to Chat SDK action handlers.

The adapter receives image, video, audio, and file messages as attachments. It doesn't upload outbound files; posting a message with files logs a warning and sends any text or card content.

Streaming is buffered. The adapter sends a text message after it collects more than 500 characters, then sends the remaining text after the stream ends. It sends at most five messages per stream.

## Thread IDs

```text
line:<channelId>:<sourceType>:<sourceId>
```

`sourceType` is `user`, `group`, or `room`. `sourceId` is the LINE user, group, or room ID.

## Feature support


