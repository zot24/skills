> Source: https://chat-sdk.dev/adapters/community/zaileys.md

---
title: Zaileys (WhatsApp)
description: Community WhatsApp adapter for Chat SDK powered by Zaileys, a batteries-included wrapper around the unofficial WhatsApp Web API. Self-hosted via WebSocket with QR / pairing-code auth, real message history, native buttons from Cards, decrypted poll votes, and scheduled messages.
tagline: WhatsApp adapter powered by Zaileys — real fetchMessages history, Cards rendered as native WhatsApp buttons, natively decrypted poll votes, scheduling, and rich media. Auth, reconnection, and session persistence handled for you.
package: chat-adapter-zaileys
---

# Zaileys (WhatsApp)


  This adapter is powered by Zaileys, which builds on Baileys — a third-party unofficial WhatsApp Web API. It is **not** an official WhatsApp/Meta API and may break when WhatsApp changes internal protocols. WhatsApp may also suspend or ban numbers that use unofficial automation. Use at your own risk and evaluate compliance requirements before production use.


## Install


## Quick start

Zaileys handles the WhatsApp lifecycle — QR / pairing-code auth, session persistence, and reconnection — so there is nothing to wire beyond `connect()`. Register handlers first, then connect:

```typescript title="bot.ts" lineNumbers
import { Chat } from "chat";
import { createMemoryState } from "@chat-adapter/state-memory";
import { createZaileysAdapter } from "chat-adapter-zaileys";

const whatsapp = createZaileysAdapter({
  session: { sessionId: "main" }, // QR prints to the terminal on first run
});

const bot = new Chat({
  userName: "mybot",
  state: createMemoryState(),
  adapters: { whatsapp },
});

bot.onNewMention(async (thread, message) => {
  await thread.subscribe();
  await thread.post(`Hello, ${message.author.fullName}!`);
});

await bot.initialize();
await whatsapp.connect();
```

Prefer a pairing code over QR scanning:

```typescript
const whatsapp = createZaileysAdapter({
  session: { sessionId: "main", authType: "pairing", phoneNumber: "12345678901" },
});
```

## Transport

This adapter uses a persistent WebSocket, not HTTP webhooks — `handleWebhook` always returns `501`. Call `adapter.connect()` after registering handlers to start receiving messages.

## Message history

`thread.fetchMessages` returns real history backed by the Zaileys message store, with backward cursor pagination. Give the client a durable store (SQLite, Postgres, Redis, or Convex) for history that survives restarts:

```typescript
import { Client, SqliteMessageStore } from "zaileys";
import { createZaileysAdapter } from "chat-adapter-zaileys";

const client = new Client({
  sessionId: "main",
  store: new SqliteMessageStore({ database: "./wa.db" }),
});
const whatsapp = createZaileysAdapter({ client });
```

Attachments survive the SDK's `queue` / `debounce` concurrency strategies: the adapter implements `rehydrateAttachment`, re-downloading media by message key from the store.

## Cards and buttons

Cards render as native WhatsApp reply buttons. Button taps round-trip to `chat.onAction` with `actionId` and `value` intact. Link buttons, selects, and modals have no WhatsApp equivalent — card bodies fall back to formatted text.

## Polls

WhatsApp poll votes are end-to-end encrypted; Zaileys decrypts them natively with no `messageSecret` bookkeeping, and it works across restarts:

```typescript
import { requireZaileysAdapter } from "chat-adapter-zaileys";

const wa = requireZaileysAdapter(thread);
const poll = await wa.sendPoll({ threadId: thread.id, question: "Lunch?", options: ["A", "B"] });
wa.onPollVote(poll.id, (vote) => {
  console.log(vote.voter.userName, vote.selectedOptions);
});
```

## WhatsApp-native extensions

Narrow a `Thread` or `Channel` with `requireZaileysAdapter` for quoted replies (`reply`), read receipts (`markRead`), presence (`setPresence`, `startTyping`, `startRecording`), locations, stickers (including animated Lottie), voice notes, contacts, message forwarding, pinning, disappearing messages, and group participant listing. `adapter.native(threadId)` exposes the entire Zaileys message builder (albums, carousels, lists, view-once media, mentions), and `adapter.client` exposes the full Zaileys client (groups, communities, newsletters, privacy, broadcast, plugins).

Every live inbound message also carries the full Zaileys `MessageContext` — `zaileysContext(message)` returns 20+ decoded flags, lazy media, and quoted-message decoding.

## Configuration


## Feature support


## Limitations

* No modals or ephemeral messages — WhatsApp has no equivalent (`postEphemeral` falls back to DM).
* History depth equals what the Zaileys store has seen; forward pagination is not supported.
* `editMessage` edits text content; media edits require the native builder.

## Links

* [Documentation](https://zeative.github.io/chat-adapter-zaileys/)
* [GitHub](https://github.com/zeative/chat-adapter-zaileys)
* [npm](https://www.npmjs.com/package/chat-adapter-zaileys)
* [Zaileys documentation](https://zeative.github.io/zaileys/)
