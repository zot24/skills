> Source: https://chat-sdk.dev/docs/api/history.md

---
title: History
description: API reference for bot.history, covering the user, thread, and channel scopes.
docs_index: /llms.txt
lastUpdated: 2026-10-14
type: reference
---

> For an index of all documentation, see [/llms.txt](/llms.txt).

`bot.history` provides three namespaced scopes for persisting and querying messages. See the [History guide](/docs/history) for setup and usage patterns.

```typescript
import { Chat } from "chat";
```

## Configuration

History scopes are configured under the `history` key on `ChatConfig`.

### ChatConfig.history

| Property | Type                                                    | Description                                                                                                                                                                                 |
| -------- | ------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `user`   | `UserHistoryConfig \| undefined`                        | Cross-platform per-user message persistence. Requires an \`identity\` resolver. Replaces the legacy \`transcripts\` + \`identity\` top-level fields.                                        |
| `thread` | `{ maxMessages?: number; ttlMs?: number } \| undefined` | Per-thread message history backfill. Used by adapters that set \`persistThreadHistory: true\` (e.g. Telegram, WhatsApp). Replaces the legacy \`threadHistory\` / \`messageHistory\` fields. |

### UserHistoryConfig

Same fields as the deprecated `TranscriptsConfig`, plus an optional `identity` resolver (preferred over the deprecated top-level `ChatConfig.identity`):

| Property         | Type                                                                      | Description                                                                                                                                                                                    |
| ---------------- | ------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `identity`       | `(context: IdentityContext) => string \| null \| Promise<string \| null>` | Resolves a stable cross-platform user key from each inbound message. Return \`null\` to skip persistence for that event. May also be set via the deprecated top-level \`ChatConfig.identity\`. |
| `retention`      | `number \| DurationString \| undefined`                                   | List TTL, refreshed on every append. Accepts milliseconds or a duration string ("45s", "30m", "6h", "7d"). Omit for no expiry.                                                                 |
| `maxPerUser`     | `number \| false`                                                         | Hard cap per user key. Older entries are evicted on append. Set \`false\` for no cap.                                                                                                          |
| `storeFormatted` | `boolean`                                                                 | Persist the mdast \`formatted\` field alongside \`text\`. Off by default to keep storage small.                                                                                                |

#### IdentityContext

| Property  | Type      | Description                             |
| --------- | --------- | --------------------------------------- |
| `adapter` | `string`  | Adapter name (e.g. "slack", "discord"). |
| `author`  | `Author`  | Message author info.                    |
| `message` | `Message` | The inbound message.                    |

***

## bot.history.user

Cross-platform per-user message store. Access via `bot.history.user`. Throws when accessed if `history.user` (or the legacy `transcripts` + `identity`) was not configured on the `Chat` instance.

`UserHistoryApi` is identical in shape to the deprecated `TranscriptsApi`.

### append

Persist a `Message` (typically the inbound user message) or an `AppendInput` (typically a bot reply).

```typescript
append(
  thread: Postable,
  message: Message | AppendInput,
  options?: AppendOptions,
): Promise<HistoryEntry | null>;
```

When `message` is a `Message`, `userKey` is read from the instance (set automatically by the SDK from the `identity` resolver). If it's `undefined` (resolver returned `null`), the call is a no-op and returns `null`. When `message` is an `AppendInput`, `options.userKey` is required.

#### AppendInput

| Property            | Type                                | Description                                                                   |
| ------------------- | ----------------------------------- | ----------------------------------------------------------------------------- |
| `role`              | `"user" \| "assistant" \| "system"` | Role tag for the entry.                                                       |
| `text`              | `string`                            | Plain-text body.                                                              |
| `formatted`         | `FormattedContent \| undefined`     | Optional mdast AST. Only stored when \`history.user.storeFormatted\` is true. |
| `platformMessageId` | `string \| undefined`               | Platform-native message ID, when known.                                       |

#### AppendOptions

| Property  | Type                  | Description                                                                                                  |
| --------- | --------------------- | ------------------------------------------------------------------------------------------------------------ |
| `userKey` | `string \| undefined` | Required when appending an \`AppendInput\` (assistant or system role); ignored when appending a \`Message\`. |

### list

Returns entries in chronological order (oldest first). When `limit` is set, returns the newest `N` entries, still in chronological order.

```typescript
list(query: ListQuery): Promise<HistoryEntry[]>;
```

#### ListQuery

| Property    | Type                                                 | Description                          |
| ----------- | ---------------------------------------------------- | ------------------------------------ |
| `userKey`   | `string`                                             | Cross-platform user key.             |
| `limit`     | `number`                                             | Maximum entries returned.            |
| `platforms` | `string[] \| undefined`                              | Filter to a subset of adapter names. |
| `threadId`  | `string \| undefined`                                | Filter to a single thread.           |
| `roles`     | `("user" \| "assistant" \| "system")[] \| undefined` | Filter to specific roles.            |

### count

```typescript
count(query: { userKey: string }): Promise<number>;
```

Returns the total number of entries stored under the user key.

### delete

```typescript
delete(target: { userKey: string }): Promise<{ deleted: number }>;
```

Wipes every entry stored under the user key. Returns the count that was removed.

***

## bot.history.thread

Per-thread message history. Always available, and delegates to the adapter's `fetchMessages`. For adapters that persist history in the SDK-maintained `ThreadHistoryCache` (`persistThreadHistory: true`, e.g. Telegram, WhatsApp), an empty platform response falls back to that cache. Every method throws when the adapter named in the thread ID prefix is not registered, so a typo'd ID fails loudly instead of reading as an empty thread.

### list

```typescript
list(threadId: string, options?: FetchOptions): Promise<FetchResult>;
```

Fetches messages from a thread. Delegates to `adapter.fetchMessages`. On adapters with `persistThreadHistory: true`, an empty first page is served from the SDK-side cache instead. Continuation pages never fall back: when you pass a `cursor`, you get the adapter's response as-is. The cache honors `direction`: the newest `limit` messages by default, the oldest `limit` with `direction: "forward"`.

#### FetchOptions

| Property    | Type                                   | Description                                                     |
| ----------- | -------------------------------------- | --------------------------------------------------------------- |
| `limit`     | `number \| undefined`                  | Maximum number of messages to return.                           |
| `cursor`    | `string \| undefined`                  | Pagination cursor returned by a prior call.                     |
| `direction` | `"backward" \| "forward" \| undefined` | "backward" (newest first, default) or "forward" (oldest first). |

#### FetchResult

| Property     | Type                  | Description                                                   |
| ------------ | --------------------- | ------------------------------------------------------------- |
| `messages`   | `Message[]`           | Normalized messages for the requested page.                   |
| `nextCursor` | `string \| undefined` | Cursor for the next page. \`undefined\` when no more results. |

### collect

Async generator that pages through all messages in a thread (oldest first). Stops when there are no more pages or the optional `limit` is reached.

```typescript
collect(threadId: string, options?: { limit?: number }): AsyncIterable<Message>;
```

```typescript title="lib/bot.ts" lineNumbers
for await (const msg of bot.history.thread.collect(thread.id, { limit: 50 })) {
  console.log(msg.text);
}
```

### append

```typescript
append(threadId: string, message: Message): Promise<void>;
```

Atomically appends a message to the SDK-side thread cache. Called automatically by the SDK on adapters where `persistThreadHistory` is `true`. You can call it manually to warm the cache, but you normally won't need to.

***

## bot.history.channel

Channel-level history. Always available, and delegates every operation to the adapter named in the channel ID prefix. Individual methods throw when the adapter does not implement the underlying capability.

### listMessages

```typescript
listMessages(channelId: string, options?: FetchOptions): Promise<FetchResult>;
```

Fetches top-level messages in a channel (not thread replies). Delegates to `adapter.fetchChannelMessages`. If the adapter doesn't implement it but persists history in the SDK-side store (`persistThreadHistory: true`), messages are served from the channel-keyed cache. Throws when the adapter supports neither.

### listThreads

```typescript
listThreads(channelId: string, options?: ListThreadsOptions): Promise<ListThreadsResult>;
```

Lists threads in a channel. Delegates to `adapter.listThreads`. Throws if the adapter does not implement `listThreads`.

### listThreadsWithMessages

```typescript
listThreadsWithMessages(
  channelId: string,
  options?: { cursor?: string; messagesPerThread?: number; maxThreads?: number },
): Promise<{ threads: Array<{ threadId: string; messages: Message[] }>; nextCursor?: string }>;
```

Convenience helper: lists up to `maxThreads` (default 5) threads, then fetches `messagesPerThread` messages for each through `history.thread.list`, a few threads at a time to stay inside platform rate limits.

#### ListThreadsOptions

| Property | Type                  | Description                          |
| -------- | --------------------- | ------------------------------------ |
| `limit`  | `number \| undefined` | Maximum number of threads to return. |
| `cursor` | `string \| undefined` | Pagination cursor.                   |

#### ListThreadsResult

| Property     | Type                  | Description                                                   |
| ------------ | --------------------- | ------------------------------------------------------------- |
| `threads`    | `ThreadSummary[]`     | Thread summaries.                                             |
| `nextCursor` | `string \| undefined` | Cursor for the next page. \`undefined\` when no more results. |

***

## HistoryEntry

Returned by `bot.history.user.append` and `bot.history.user.list`. Exported from `chat` as `HistoryEntry` (canonical) and `TranscriptEntry` (deprecated alias).

| Property            | Type                                | Description                                                           |
| ------------------- | ----------------------------------- | --------------------------------------------------------------------- |
| `id`                | `string`                            | UUID assigned by the SDK at append time.                              |
| `userKey`           | `string`                            | Cross-platform user key from the identity resolver.                   |
| `role`              | `"user" \| "assistant" \| "system"` | Role tag.                                                             |
| `text`              | `string`                            | Plain-text body. Use this field when building prompts.                |
| `formatted`         | `FormattedContent \| undefined`     | mdast AST. Only present when \`history.user.storeFormatted\` is true. |
| `platform`          | `string`                            | Originating adapter name.                                             |
| `threadId`          | `string`                            | Originating thread ID.                                                |
| `platformMessageId` | `string \| undefined`               | Platform-native message ID, when known.                               |
| `timestamp`         | `number`                            | Milliseconds since epoch, set at append time on the SDK side.         |

## toPromptEntries

```typescript
import { toPromptEntries, type PromptEntry } from "chat";

toPromptEntries(entries: HistoryEntry[]): PromptEntry[];
```

Converts `history.user.list()` results into `{ role, content }` entries ready to pass to an LLM as chat history (for example the AI SDK's `messages` input). Entries with empty text are dropped; order is preserved.

```typescript title="lib/bot.ts" lineNumbers
const entries = await bot.history.user.list({ userKey });
const { text } = await generateText({
  model,
  messages: toPromptEntries(entries),
});
```

#### PromptEntry

| Property  | Type                                | Description                                   |
| --------- | ----------------------------------- | --------------------------------------------- |
| `role`    | `"user" \| "assistant" \| "system"` | Role tag carried over from the history entry. |
| `content` | `string`                            | Plain-text body of the entry.                 |

## Storage

| Scope                        | Storage key pattern          | Notes                                            |
| ---------------------------- | ---------------------------- | ------------------------------------------------ |
| `bot.history.user`           | `transcripts:user:{userKey}` | Backed by `StateAdapter.appendToList`            |
| `bot.history.thread` (cache) | `msg-history:{threadId}`     | Only populated when `persistThreadHistory: true` |

Appends are atomic, so concurrent inbound messages on the same key don't race.

## Deprecated aliases

| Old                                                      | New                                                                                                     |
| -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `bot.transcripts`                                        | `bot.history.user`                                                                                      |
| `ChatConfig.transcripts` + `ChatConfig.identity`         | `ChatConfig.history.user` (with `history.user.identity`, or keep top-level `identity` during migration) |
| `TranscriptEntry`                                        | `HistoryEntry` (also exported as `UserHistoryEntry`)                                                    |
| `TranscriptsConfig`                                      | `UserHistoryConfig`                                                                                     |
| `ChatConfig.threadHistory` / `ChatConfig.messageHistory` | `ChatConfig.history.thread`                                                                             |

All deprecated names continue to work and will not be removed in the current major version. See [Migrating from `bot.transcripts`](/docs/history#migrating-from-bottranscripts).

---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
