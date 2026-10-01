> Source: https://chat-sdk.dev/adapters/community/zaileys.md

---
title: Zaileys (WhatsApp)
description: Community WhatsApp adapter for Chat SDK built on Zaileys, a wrapper around the unofficial WhatsApp Web API. Self-hosted over WebSocket, with QR or pairing-code auth, stored message history, native buttons from Cards, decrypted poll votes, and scheduled messages.
tagline: WhatsApp adapter built on Zaileys, with fetchMessages history from the Zaileys store, Cards rendered as native WhatsApp buttons, decrypted poll votes, scheduling, and rich media. Zaileys manages auth, reconnection, and session persistence.
package: chat-adapter-zaileys
---

# Zaileys (WhatsApp)


  This adapter uses Zaileys, which builds on Baileys, an unofficial third-party WhatsApp Web API. It is not an official WhatsApp or Meta API and may break when WhatsApp changes its internal protocols. WhatsApp may also suspend or ban numbers that use unofficial automation. Use it at your own risk, and evaluate your compliance requirements before using it in production.


## Install


## Quick start

Zaileys handles QR and pairing-code auth, session persistence, and reconnection, so the adapter needs no setup beyond `connect()`. Register handlers first, then connect:

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

## Authentication

Zaileys manages the WhatsApp session for you. Pass its client options as `session`.

### QR code

QR is the default. On first run, the QR code prints to the terminal, as in the quick start.

### Pairing code

To use a pairing code instead of scanning a QR code, set `authType` and `phoneNumber`:

```typescript
const whatsapp = createZaileysAdapter({
  session: { sessionId: "main", authType: "pairing", phoneNumber: "12345678901" },
});
```

## Configuration


## Transport

The adapter receives messages over a persistent WebSocket instead of HTTP webhooks, so `handleWebhook` always returns `501`. Call `adapter.connect()` after registering handlers to start receiving messages.

## Message history

`thread.fetchMessages` returns history from the Zaileys message store, with backward cursor pagination. For history that survives restarts, give the client a durable store (SQLite, Postgres, Redis, or Convex):

```typescript
import { Client, SqliteMessageStore } from "zaileys";
import { createZaileysAdapter } from "chat-adapter-zaileys";

const client = new Client({
  sessionId: "main",
  store: new SqliteMessageStore({ database: "./wa.db" }),
});
const whatsapp = createZaileysAdapter({ client });
```

Attachments survive the SDK's `queue` and `debounce` concurrency strategies. The adapter implements `rehydrateAttachment`, which re-downloads media by message key from the store.

## Cards and buttons

Cards render as native WhatsApp reply buttons, and the card body is sent as formatted text. Button taps round-trip to `chat.onAction` with `actionId` and `value` intact. Link buttons, selects, and modals have no WhatsApp equivalent.

## Polls

WhatsApp poll votes are end-to-end encrypted. Zaileys decrypts them without any `messageSecret` bookkeeping on your side, and decryption keeps working across restarts:

```typescript
import { requireZaileysAdapter } from "chat-adapter-zaileys";

const wa = requireZaileysAdapter(thread);
const poll = await wa.sendPoll({ threadId: thread.id, question: "Lunch?", options: ["A", "B"] });
wa.onPollVote(poll.id, (vote) => {
  console.log(vote.voter.userName, vote.selectedOptions);
});
```

## WhatsApp extensions

Narrow a `Thread` or `Channel` with `requireZaileysAdapter` to use WhatsApp features that have no Chat SDK equivalent: quoted replies (`reply`), read receipts (`markRead`), presence (`setPresence`, `startTyping`, `startRecording`), locations, stickers (including animated Lottie), voice notes, contacts, message forwarding, pinning, disappearing messages, and group participant listing.

For anything else, `adapter.native(threadId)` exposes the entire Zaileys message builder (albums, carousels, lists, view-once media, mentions), and `adapter.client` exposes the full Zaileys client (groups, communities, newsletters, privacy, broadcast, plugins).

Every live inbound message also carries the full Zaileys `MessageContext`. `zaileysContext(message)` returns it, with 20+ decoded flags, lazy media, and quoted-message decoding.

## Limitations

* No modals or ephemeral messages, because WhatsApp has no equivalent. `postEphemeral` falls back to a DM.
* History depth equals what the Zaileys store has seen, and forward pagination is not supported.
* `editMessage` edits text content. Media edits require the native builder.

## Feature support


## Resources

* [Documentation](https://zeative.github.io/chat-adapter-zaileys/)
* [GitHub](https://github.com/zeative/chat-adapter-zaileys)
* [npm](https://www.npmjs.com/package/chat-adapter-zaileys)
* [Zaileys documentation](https://zeative.github.io/zaileys/)
