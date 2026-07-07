> Source: https://chat-sdk.dev/docs/api/message.md

---
title: Message
description: Normalized message format with text, AST, author, and metadata.
type: reference
---

# Message


Incoming messages are normalized across all platforms into a consistent `Message` object.

```typescript
import { Message } from "chat";
```

## Properties


## Author


### How `isMe` works

Each adapter detects whether a message came from the bot itself. Chat SDK filters `isMe: true` messages before handlers run so bot replies do not loop back into `onNewMessage`, `onNewMention`, or subscribed-thread handlers.

`isMe` means "sent by this bot/runtime", not "sent by the authenticated user or account". For adapters backed by a user-owned account, do not blindly map platform fields like `fromMe` to `isMe`. Only set `isMe: true` for messages the adapter sent itself. If the platform echoes sent messages back through the webhook, track sent message IDs and mark only those echoes as `isMe: true`.

The detection logic varies by platform:

| Platform    | Detection method                                                                                                                                                     |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Slack       | Checks `event.user === botUserId` (primary), then `event.bot_id === botId` (for `bot_message` subtypes). Both IDs are fetched during initialization via `auth.test`. |
| Teams       | Checks `activity.from.id === appId` (exact match), then checks if `activity.from.id` ends with `:{appId}` (handles `28:{appId}` format).                             |
| Google Chat | Checks `message.sender.name === botUserId`. The bot user ID is learned dynamically from message annotations when the bot is first @-mentioned.                       |


  All adapters return `false` if the bot ID isn't known yet. This is a safe default that prevents the bot from ignoring messages it should process.


## MessageMetadata


## Attachment


## LinkPreview

Links found in incoming messages are extracted and exposed as `LinkPreview` objects. On platforms that support it (currently Slack), links pointing to other chat messages include a `fetchMessage()` callback to retrieve the full linked message.


  When using [`toAiMessages()`](/docs/ai/to-ai-messages), link metadata is automatically appended to the message content. Embedded message links are labeled as `[Embedded message: ...]` so the AI model understands the context.


### Platform support

| Platform | Link extraction                                       | `fetchMessage()`                                 |
| -------- | ----------------------------------------------------- | ------------------------------------------------ |
| Slack    | URLs from `rich_text` blocks or `<url>` text patterns | Slack message links (`*.slack.com/archives/...`) |
| Others   | Not yet — `links` is always `[]`                      | —                                                |

## MessageSubject

Returned by `message.subject` on platforms with parent resources. See [Message Subject](/docs/subject) for usage.


## Serialization

Messages can be serialized for workflow engines and external systems.

```typescript
// Serialize
const json = message.toJSON();

// Deserialize
const restored = Message.fromJSON(json);
```

The serialized format converts `Date` fields to ISO strings and omits non-serializable fields like `data` buffers and `fetchData` functions. The `fetchMetadata` field is preserved so that adapters can reconstruct `fetchData` when the message is rehydrated from a queue.
