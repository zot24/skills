> Source: https://chat-sdk.dev/docs/api/history.md

---
title: History
description: API reference for bot.history — user, thread, and channel scopes.
type: reference
---

# History


`bot.history` provides three namespaced scopes for persisting and querying messages. See the [History guide](/docs/history) for setup and usage patterns.

```typescript
import { Chat } from "chat";
```

## Configuration

History scopes are configured under the `history` key on `ChatConfig`.

### ChatConfig.history


### UserHistoryConfig

Same fields as the deprecated `TranscriptsConfig`, plus an optional `identity` resolver (preferred over the deprecated top-level `ChatConfig.identity`):


#### IdentityContext


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


#### AppendOptions


### list

Returns entries in chronological order (oldest first). When `limit` is set, returns the newest `N` entries — still chronologically ordered.

```typescript
list(query: ListQuery): Promise<HistoryEntry[]>;
```

#### ListQuery


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

Per-thread message history. Always available — delegates to the adapter's `fetchMessages`. For adapters that persist history in the SDK-maintained `ThreadHistoryCache` (`persistThreadHistory: true`, e.g. Telegram, WhatsApp), an empty platform response falls back to that cache. Every method throws when the adapter named in the thread ID prefix is not registered, so a typo'd ID fails loudly instead of reading as an empty thread.

### list

```typescript
list(threadId: string, options?: FetchOptions): Promise<FetchResult>;
```

Fetches messages from a thread. Delegates to `adapter.fetchMessages`. On adapters with `persistThreadHistory: true`, an empty first page is served from the SDK-side cache instead (never a continuation page — passing a `cursor` always returns the adapter's response as-is). The cache honors `direction`: the newest `limit` messages by default, the oldest `limit` with `direction: "forward"`.

#### FetchOptions


#### FetchResult


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

Atomically appends a message to the SDK-side thread cache. Called automatically by the SDK on adapters where `persistThreadHistory` is `true`. You can call this manually to warm the cache, but under normal circumstances you won't need to.

***

## bot.history.channel

Channel-level history. Always available — delegates all operations to the appropriate adapter resolved from the channel ID prefix. Individual methods throw when the adapter does not implement the underlying capability.

### listMessages

```typescript
listMessages(channelId: string, options?: FetchOptions): Promise<FetchResult>;
```

Fetches top-level messages in a channel (not thread replies). Delegates to `adapter.fetchChannelMessages`. Adapters that persist history in the SDK-side store (`persistThreadHistory: true`) are served from the channel-keyed cache instead. Throws when the adapter supports neither.

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


#### ListThreadsResult


***

## HistoryEntry

Returned by `bot.history.user.append` and `bot.history.user.list`. Exported as `HistoryEntry` (canonical) and `TranscriptEntry` (deprecated alias — both available from `chat`).


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


## Storage

| Scope                        | Storage key pattern          | Notes                                            |
| ---------------------------- | ---------------------------- | ------------------------------------------------ |
| `bot.history.user`           | `transcripts:user:{userKey}` | Backed by `StateAdapter.appendToList`            |
| `bot.history.thread` (cache) | `msg-history:{threadId}`     | Only populated when `persistThreadHistory: true` |

Appends are atomic — concurrent inbound messages on the same key don't race.

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
