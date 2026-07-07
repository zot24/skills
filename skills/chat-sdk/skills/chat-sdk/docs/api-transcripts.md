> Source: https://chat-sdk.dev/docs/api/transcripts.md

---
title: Transcripts
description: Cross-platform per-user transcript persistence — configuration, methods, and entry shape.
type: reference
---

# Transcripts


`bot.transcripts` provides per-user message persistence keyed by a stable cross-platform identifier. See the [Conversation history](/docs/conversation-history) guide for usage patterns.

```typescript
import { Chat } from "chat";
```

## Configuration

`transcripts` and `identity` are configured on `ChatConfig`. Both must be set together — passing `transcripts` without `identity` throws at construction.

### ChatConfig.transcripts


### ChatConfig.identity

```typescript
identity: (context: IdentityContext) => string | null | Promise<string | null>;
```

Called once per inbound message during dispatch. The result is attached to the `Message` instance as `message.userKey`. Return `null` to skip persistence for an event.

#### IdentityContext


## Methods

Access via `bot.transcripts`. Throws if `transcripts` was not configured on the `Chat` instance.

### append

Persist a `Message` (typically the inbound user message) or an `AppendInput` (typically a bot reply you just posted).

```typescript
append(
  thread: Postable,
  message: Message | AppendInput,
  options?: AppendOptions,
): Promise<TranscriptEntry | null>;
```

When `message` is a `Message`, `userKey` is read from the instance. If it's `undefined` (the resolver returned `null`), the call is a no-op and returns `null`. When `message` is an `AppendInput`, `options.userKey` is required.

#### AppendInput


#### AppendOptions


### list

Returns entries in chronological order (oldest first). When `limit` is set, returns the newest `N` entries — still chronologically.

```typescript
list(query: ListQuery): Promise<TranscriptEntry[]>;
```

#### ListQuery


### count

```typescript
count(query: CountQuery): Promise<number>;
```

Returns the total number of entries stored under the user key. `CountQuery` has a single field, `userKey: string`.

### delete

```typescript
delete(target: { userKey: string }): Promise<{ deleted: number }>;
```

Wipes every entry stored under the user key. Returns the count that was removed. Single-entry and time-range deletes are not supported — the underlying `appendToList` primitive can't support them safely under concurrent writes.

## TranscriptEntry

Returned by `append` and `list`.


## Storage

Backed by `StateAdapter.appendToList` / `getList` / `delete`. Every built-in state adapter (`memory`, `redis`, `ioredis`, `pg`) supports these primitives.

Entries are stored under `transcripts:user:{userKey}` as a capped list. `appendToList` is atomic, so concurrent inbound messages don't race.

The `retention` value is applied as the list TTL and refreshed on every append. With `retention: "30d"`, a user who hasn't talked to the bot in 30 days has their transcript expire automatically.
