> Source: https://chat-sdk.dev/docs/api/transcripts.md

---
title: Transcripts (deprecated)
description: Configuration, methods, and entry shape for the deprecated cross-platform per-user transcript API.
docs_index: /llms.txt
lastUpdated: 2026-10-14
type: reference
related:
  - /docs/history
---

> For an index of all documentation, see [/llms.txt](/llms.txt).

> `bot.transcripts` and the `transcripts` config key are deprecated. Use [`bot.history.user`](/docs/api/history#bothistoryuser) and the `history.user` config key instead. The API surface is identical. `bot.transcripts` will continue to work in the current major version.

`bot.transcripts` provides per-user message persistence keyed by a stable cross-platform identifier. See the [History guide](/docs/history) for setup, usage patterns, and migration steps.

```typescript
import { Chat } from "chat";
```

## Configuration

`history.user` (or the deprecated `transcripts`) requires an identity resolver. Set `history.user.identity` or the deprecated top-level `identity` field. Passing `history.user` without either throws at construction.

### ChatConfig.transcripts (deprecated → history.user)

| Property         | Type                                    | Description                                                                                                                    |
| ---------------- | --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `retention`      | `number \| DurationString \| undefined` | List TTL, refreshed on every append. Accepts milliseconds or a duration string ("45s", "30m", "6h", "7d"). Omit for no expiry. |
| `maxPerUser`     | `number \| false`                       | Hard cap per user. Older entries are evicted on append. Set \`false\` for no cap.                                              |
| `storeFormatted` | `boolean`                               | Persist the mdast \`formatted\` field alongside \`text\`. Off by default to keep storage small.                                |

### ChatConfig.identity

```typescript
identity: (context: IdentityContext) => string | null | Promise<string | null>;
```

Called once per inbound message during dispatch. The result is attached to the `Message` instance as `message.userKey`. Return `null` to skip persistence for an event.

#### IdentityContext

| Property  | Type      | Description                             |
| --------- | --------- | --------------------------------------- |
| `adapter` | `string`  | Adapter name (e.g. "slack", "discord"). |
| `author`  | `Author`  | Message author info.                    |
| `message` | `Message` | The inbound message.                    |

## Methods

Access via `bot.history.user` (preferred) or `bot.transcripts` (deprecated alias). Throws if neither `history.user` nor `transcripts` was configured on the `Chat` instance.

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

| Property            | Type                                | Description                                                                  |
| ------------------- | ----------------------------------- | ---------------------------------------------------------------------------- |
| `role`              | `"user" \| "assistant" \| "system"` | Role tag for the entry.                                                      |
| `text`              | `string`                            | Plain-text body.                                                             |
| `formatted`         | `FormattedContent \| undefined`     | Optional mdast AST. Only stored when \`transcripts.storeFormatted\` is true. |
| `platformMessageId` | `string \| undefined`               | Platform-native message ID, when known.                                      |

#### AppendOptions

| Property  | Type                  | Description                                                                                                  |
| --------- | --------------------- | ------------------------------------------------------------------------------------------------------------ |
| `userKey` | `string \| undefined` | Required when appending an \`AppendInput\` (assistant or system role); ignored when appending a \`Message\`. |

### list

Returns entries in chronological order (oldest first). When `limit` is set, returns the newest `N` entries, still in chronological order.

```typescript
list(query: ListQuery): Promise<TranscriptEntry[]>;
```

#### ListQuery

| Property    | Type                                                 | Description                                                                                                            |
| ----------- | ---------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `userKey`   | `string`                                             | Cross-platform user key.                                                                                               |
| `limit`     | `number`                                             | Maximum entries returned. Cannot exceed the stored entry count. \`maxPerUser\` limits storage unless set to \`false\`. |
| `platforms` | `string[] \| undefined`                              | Filter to a subset of adapter names.                                                                                   |
| `threadId`  | `string \| undefined`                                | Filter to a single thread.                                                                                             |
| `roles`     | `("user" \| "assistant" \| "system")[] \| undefined` | Filter to specific roles.                                                                                              |

### count

```typescript
count(query: CountQuery): Promise<number>;
```

Returns the total number of entries stored under the user key. `CountQuery` has a single field, `userKey: string`.

### delete

```typescript
delete(target: { userKey: string }): Promise<{ deleted: number }>;
```

Wipes every entry stored under the user key. Returns the count that was removed. Single-entry and time-range deletes are not supported, because the underlying `appendToList` primitive can't support them safely under concurrent writes.

## TranscriptEntry

Returned by `append` and `list`.

| Property            | Type                                | Description                                                          |
| ------------------- | ----------------------------------- | -------------------------------------------------------------------- |
| `id`                | `string`                            | UUID assigned by the SDK at append time.                             |
| `userKey`           | `string`                            | Cross-platform user key from the IdentityResolver.                   |
| `role`              | `"user" \| "assistant" \| "system"` | Role tag.                                                            |
| `text`              | `string`                            | Plain-text body. Use this field when building prompts.               |
| `formatted`         | `FormattedContent \| undefined`     | mdast AST. Only present when \`transcripts.storeFormatted\` is true. |
| `platform`          | `string`                            | Originating adapter name.                                            |
| `threadId`          | `string`                            | Originating thread ID.                                               |
| `platformMessageId` | `string \| undefined`               | Platform-native message ID, when known.                              |
| `timestamp`         | `number`                            | Milliseconds since epoch, set at append time on the SDK side.        |

## Storage

Backed by `StateAdapter.appendToList` / `getList` / `delete`. Every built-in state adapter (`memory`, `redis`, `ioredis`, `pg`) supports these primitives.

Entries are stored under `transcripts:user:{userKey}` as a capped list. `appendToList` is atomic, so concurrent inbound messages don't race.

The `retention` value is applied as the list TTL and refreshed on every append. With `retention: "30d"`, a user who hasn't talked to the bot in 30 days has their transcript expire automatically.

## See also

- [History API reference](/docs/api/history): the current API (`bot.history.user`, `bot.history.thread`, `bot.history.channel`)
- [History guide](/docs/history): setup, patterns, and migration

---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
