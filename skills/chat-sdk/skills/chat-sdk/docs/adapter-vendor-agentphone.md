> Source: https://chat-sdk.dev/adapters/vendor-official/agentphone.md

---
title: AgentPhone
description: Unified SMS, MMS, iMessage, and voice adapter for Chat SDK. Send and receive messages across all channels with a single integration.
tagline: SMS, MMS, iMessage, and voice adapter for Chat SDK. Receive inbound messages and call transcripts via webhooks, send replies, and react to iMessages.
package: @agentphone/chat-sdk-adapter
---

# AgentPhone


## Install


## Quick start

```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { MemoryStateAdapter } from "@chat-adapter/state-memory";
import { createAgentPhoneAdapter } from "@agentphone/chat-sdk-adapter";

const agentphone = createAgentPhoneAdapter({
  // apiKey: "...",          // or set AGENTPHONE_API_KEY
  // agentId: "agent_...",   // or set AGENTPHONE_AGENT_ID
  // webhookSecret: "whsec_...", // or set AGENTPHONE_WEBHOOK_SECRET
});

const chat = new Chat({
  userName: "my-bot",
  adapters: { agentphone },
  state: new MemoryStateAdapter(),
});

// Handles SMS, MMS, iMessage, and voice call transcripts
chat.onNewMention(async (thread, message) => {
  await thread.subscribe();
  await thread.post(`Got your message: ${message.text}`);
});

chat.onSubscribedMessage(async (thread, message) => {
  await thread.post(`Reply: ${message.text}`);
});
```

Point your AgentPhone webhook to your server's webhook endpoint. The adapter verifies HMAC-SHA256 signatures and routes events into the Chat SDK handler pipeline.

## Configuration


### Environment variables

| Variable                    | Description                                                   |
| --------------------------- | ------------------------------------------------------------- |
| `AGENTPHONE_API_KEY`        | AgentPhone API key. Overridden by `config.apiKey`.            |
| `AGENTPHONE_AGENT_ID`       | Agent ID. Overridden by `config.agentId`.                     |
| `AGENTPHONE_WEBHOOK_SECRET` | Webhook signing secret. Overridden by `config.webhookSecret`. |

## Channels

AgentPhone routes four channels through a single adapter:

| Channel  | Send | Receive     | Media | Reactions |
| -------- | ---- | ----------- | ----- | --------- |
| SMS      | Yes  | Yes         | --    | --        |
| MMS      | Yes  | Yes         | Yes   | --        |
| iMessage | Yes  | Yes         | Yes   | Yes       |
| Voice    | --   | Transcripts | --    | --        |

All inbound messages (SMS, MMS, iMessage) arrive as `onNewMention` or `onSubscribedMessage` events. Voice calls arrive as messages containing the full transcript and summary when the call ends.

## iMessage reactions

AgentPhone is the only Chat SDK adapter that supports iMessage tapback reactions:

```typescript
// Send a tapback reaction to a message
await chat.adapters.agentphone.addReaction(threadId, messageId, "love");
```

Supported tapbacks: `love`, `like`, `dislike`, `laugh`, `emphasize`, `question`. Custom emoji reactions (e.g. `🔥`) are supported on newer devices.

Inbound reactions from users fire the `onReaction` handler.

## Voice call transcripts

When a voice call ends, AgentPhone delivers the full transcript as a message:

```typescript
chat.onNewMention(async (thread, message) => {
  if (message.raw.callId) {
    // This is a voice call transcript
    console.log("Call summary:", message.raw.summary);
    console.log("Transcript:", message.raw.transcript);
    console.log("Duration:", message.raw.durationSeconds, "seconds");
  }
});
```

## Webhook events

The adapter handles three event types:

| Event              | Description                          |
| ------------------ | ------------------------------------ |
| `agent.message`    | Inbound SMS, MMS, or iMessage        |
| `agent.call_ended` | Voice call completed with transcript |
| `agent.reaction`   | iMessage tapback reaction            |

All webhooks are signed with HMAC-SHA256 and include replay protection via a 5-minute timestamp window.

## Limitations

SMS and voice have inherent platform constraints:

* `editMessage` / `deleteMessage` -- not supported (SMS is fire-and-forget)
* `removeReaction` -- not supported
* `startTyping` -- no-op (no typing indicators in SMS)
* `streaming` -- not supported

## Links

* [AgentPhone docs](https://docs.agentphone.ai)
* [GitHub](https://github.com/AgentPhone-AI/chat-sdk-adapter)
* [npm](https://www.npmjs.com/package/@agentphone/chat-sdk-adapter)

## Feature support


