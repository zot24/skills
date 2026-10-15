> Source: https://chat-sdk.dev/docs/api/message.md

---
title: Message
description: Normalized message format with text, AST, author, and metadata.
docs_index: /llms.txt
lastUpdated: 2026-10-14
type: reference
related:
  - /docs/handling-events
  - /docs/subject
  - /docs/ai/to-ai-messages
---

> For an index of all documentation, see [/llms.txt](/llms.txt).

Incoming messages are normalized across all platforms into a consistent `Message` object.

```typescript
import { Message } from "chat";
```

## Properties

| Property      | Type                              | Description                                                                                                                                                                                                         |
| ------------- | --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`          | `string`                          | Platform-specific message ID.                                                                                                                                                                                       |
| `threadId`    | `string`                          | Thread ID in adapter:channel:thread format.                                                                                                                                                                         |
| `text`        | `string`                          | Plain text content with all formatting stripped.                                                                                                                                                                    |
| `formatted`   | `Root`                            | mdast AST representation. This is the canonical format for processing.                                                                                                                                              |
| `raw`         | `unknown`                         | Original platform-specific payload (escape hatch).                                                                                                                                                                  |
| `author`      | `Author`                          | Message author info.                                                                                                                                                                                                |
| `metadata`    | `MessageMetadata`                 | Timestamps and edit status.                                                                                                                                                                                         |
| `attachments` | `Attachment[]`                    | File attachments.                                                                                                                                                                                                   |
| `replyTo`     | `Message \| undefined`            | The normalized message this message replies to, when provided by the adapter.                                                                                                                                       |
| `links`       | `LinkPreview[]`                   | Links found in the message, with optional preview metadata.                                                                                                                                                         |
| `isMention`   | `boolean \| undefined`            | The adapter's mention decision. \`true\` and \`false\` are final; \`undefined\` makes Chat SDK match \`@username\` in \`text\`. A direct message with no \`onDirectMessage\` handler registered is always \`true\`. |
| `subject`     | `Promise<MessageSubject \| null>` | Resolves the parent resource (issue, PR, or Notion page) this message is about. Returns null on chat platforms. See \[Message Subject]\(/docs/subject).                                                             |

## Author

| Property   | Type                   | Description                                                                                                                                                                                                            |
| ---------- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `userId`   | `string`               | Platform-specific user ID.                                                                                                                                                                                             |
| `userName` | `string`               | Username/handle for @-mentions.                                                                                                                                                                                        |
| `fullName` | `string`               | Display name.                                                                                                                                                                                                          |
| `email`    | `string \| undefined`  | Email address when provided by the platform. Availability may require additional permissions.                                                                                                                          |
| `isBot`    | `boolean \| "unknown"` | Whether the author is a bot.                                                                                                                                                                                           |
| `isMe`     | `boolean`              | Whether the author is this bot.                                                                                                                                                                                        |
| `isSystem` | `boolean \| undefined` | Whether the message was generated by the chat platform itself (e.g. Slack's reserved \`USLACK\` user for notifications like "@user archived the channel"). Absent means \`false\`. Currently set by the Slack adapter. |

### How `isMe` works

Each adapter detects whether a message came from the bot itself. Chat SDK filters `isMe: true` messages before handlers run so bot replies do not loop back into `onNewMessage`, `onNewMention`, or subscribed-thread handlers.

`isMe` means "sent by this bot/runtime", not "sent by the authenticated user or account". For adapters backed by a user-owned account, do not blindly map platform fields like `fromMe` to `isMe`. Only set `isMe: true` for messages the adapter sent itself. If the platform echoes sent messages back through the webhook, track sent message IDs and mark only those echoes as `isMe: true`.

The detection logic varies by platform:

| Platform    | Detection method                                                                                                                                                     |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Slack       | Checks `event.user === botUserId` (primary), then `event.bot_id === botId` (for `bot_message` subtypes). Both IDs are fetched during initialization via `auth.test`. |
| Teams       | Checks `activity.from.id === appId` (exact match), then checks if `activity.from.id` ends with `:{appId}` (handles `28:{appId}` format).                             |
| Google Chat | Checks `message.sender.name === botUserId`. The bot user ID is learned dynamically from message annotations when the bot is first @-mentioned.                       |

> All adapters return `false` if the bot ID isn't known yet, so the bot doesn't ignore messages it should process.

## MessageMetadata

| Property   | Type                | Description                          |
| ---------- | ------------------- | ------------------------------------ |
| `dateSent` | `Date`              | When the message was sent.           |
| `edited`   | `boolean`           | Whether the message has been edited. |
| `editedAt` | `Date \| undefined` | When the message was last edited.    |

## Attachment

| Property        | Type                                                | Description                                                                                                      |
| --------------- | --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| `type`          | `"image" \| "file" \| "video" \| "audio"`           | Attachment type.                                                                                                 |
| `url`           | `string \| undefined`                               | URL to the file.                                                                                                 |
| `data`          | `Buffer \| Blob \| undefined`                       | Binary data (if already fetched).                                                                                |
| `name`          | `string \| undefined`                               | Filename.                                                                                                        |
| `mimeType`      | `string \| undefined`                               | MIME type.                                                                                                       |
| `size`          | `number \| undefined`                               | File size in bytes.                                                                                              |
| `fetchData()`   | `() => Promise<Buffer \| ArrayBuffer> \| undefined` | Fetch the attachment data. Handles platform auth automatically.                                                  |
| `fetchMetadata` | `Record<string, string> \| undefined`               | Platform-specific IDs for reconstructing fetchData after serialization (e.g. WhatsApp mediaId, Telegram fileId). |

## LinkPreview

Links found in incoming messages are extracted and exposed as `LinkPreview` objects. On platforms that support it (currently Slack), links pointing to other chat messages include a `fetchMessage()` callback to retrieve the full linked message.

| Property         | Type                                  | Description                                                                                                                 |
| ---------------- | ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `url`            | `string`                              | The URL.                                                                                                                    |
| `title`          | `string \| undefined`                 | Title from unfurl metadata (if available).                                                                                  |
| `description`    | `string \| undefined`                 | Description from unfurl metadata (if available).                                                                            |
| `imageUrl`       | `string \| undefined`                 | Preview image URL (if available).                                                                                           |
| `siteName`       | `string \| undefined`                 | Site name, e.g. "Vercel" (if available).                                                                                    |
| `fetchMessage()` | `() => Promise<Message> \| undefined` | Fetch the linked chat message. Available when the URL points to a message on the same platform (e.g. a Slack message link). |

> When using [`toAiMessages()`](/docs/ai/to-ai-messages), link metadata is automatically appended to the message content. Embedded message links are labeled as `[Embedded message: ...]` so the AI model understands the context.

### Platform support

| Platform | Link extraction                                       | `fetchMessage()`                                 |
| -------- | ----------------------------------------------------- | ------------------------------------------------ |
| Slack    | URLs from `rich_text` blocks or `<url>` text patterns | Slack message links (`*.slack.com/archives/...`) |
| Others   | Not supported yet; `links` is always `[]`             | —                                                |

## MessageSubject

Returned by `message.subject` on platforms with parent resources. See [Message Subject](/docs/subject) for usage.

| Property      | Type                                        | Description                                              |
| ------------- | ------------------------------------------- | -------------------------------------------------------- |
| `type`        | `string`                                    | Resource kind, e.g. "issue", "pull\_request", or "page". |
| `id`          | `string`                                    | Resource identifier (e.g. "ENG-123" or "42").            |
| `title`       | `string \| undefined`                       | Resource title.                                          |
| `description` | `string \| undefined`                       | Full description/body in markdown.                       |
| `status`      | `string \| undefined`                       | Current status (e.g. "In Progress", "open").             |
| `url`         | `string \| undefined`                       | Web URL to the resource.                                 |
| `author`      | `{ id: string; name: string } \| undefined` | Resource creator.                                        |
| `assignee`    | `{ id: string; name: string } \| undefined` | Current assignee.                                        |
| `labels`      | `string[] \| undefined`                     | Labels/tags.                                             |
| `raw`         | `unknown`                                   | Full platform API response.                              |

## Serialization

Messages can be serialized for workflow engines and external systems.

```typescript
// Serialize
const json = message.toJSON();

// Deserialize
const restored = Message.fromJSON(json);
```

The serialized format converts `Date` fields to ISO strings and omits non-serializable fields like `data` buffers and `fetchData` functions. The `fetchMetadata` field is preserved so that adapters can reconstruct `fetchData` when the message is rehydrated from a queue.

---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
