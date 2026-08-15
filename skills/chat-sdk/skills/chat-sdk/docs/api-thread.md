> Source: https://chat-sdk.dev/docs/api/thread.md

---
title: Thread
description: Represents a conversation thread with methods for posting, subscribing, and state management.
type: reference
related:
  - /docs/threads-messages-channels
  - /docs/posting-messages
---

# Thread


A `Thread` is provided to your event handlers and represents a conversation thread on any platform. You can also create thread handles directly using `chat.thread()` or `chat.openDM()`.

## Properties


## post

Post a message to the thread. Accepts strings, structured messages, cards, streams, and `PostableObject` instances (`Plan`, `StreamingPlan`).

```typescript
// Plain text
await thread.post("Hello!");

// Markdown
await thread.post({ markdown: "**Bold** text" });

// AST
await thread.post({ ast: root([paragraph([text("Hello")])]) });

// Card
await thread.post(Card({ title: "Hi", children: [Text("Hello")] }));

// Stream (fullStream recommended for multi-step agents)
await thread.post(result.fullStream);

// Plan (mutable task list)
const plan = new Plan({ initialMessage: "Working..." });
await thread.post(plan);
await plan.addTask({ title: "Step 1" });

// Streaming with platform options
await thread.post(new StreamingPlan(stream, { groupTasks: "plan" }));
```

**Parameters:** `message: string | PostableMessage | CardJSXElement`

**Returns:** `Promise<SentMessage | PostableObject>` — for plain messages and streams, a `SentMessage` with `edit()`, `delete()`, `addReaction()`, and `removeReaction()` methods; for `Plan` / `StreamingPlan` inputs, the same object is returned so you can keep mutating it.

See [Posting Messages](/docs/posting-messages) for details on each format.

## reply

Post a message with a native reference to another message.

```typescript
await thread.reply(message, {
  markdown: "Thanks, I can help with that.",
});
```

**Parameters:** `target: string | Message`, `message: string | AdapterPostableMessage | AsyncIterable<string | StreamChunk | StreamEvent> | CardJSXElement`

**Returns:** `Promise<SentMessage>`

The target `Message` must belong to the same thread. Streams are buffered before sending. Unlike `post()`, `reply()` does not accept `Plan` or `StreamingPlan`. Adapters without native message reply support throw `NotImplementedError`.

Prefer passing the `Message` over its ID. The `Message` is checked against this thread and carried through to `SentMessage.replyTo` and cached thread history. A bare ID is only resolved to a `Message` when the thread already holds it in `recentMessages`; otherwise the reply is still sent, but `replyTo` is left undefined.

## postEphemeral

Post a message visible only to a specific user.

```typescript
await thread.postEphemeral(userId, "Only you can see this", {
  fallbackToDM: true,
});
```


**Returns:** `Promise<EphemeralMessage | null>`

## schedule

Schedule a message for future delivery. Currently only supported by the Slack adapter — other adapters throw `NotImplementedError`.

```typescript
const scheduled = await thread.schedule("Reminder: standup in 5 minutes!", {
  postAt: new Date("2026-03-09T09:00:00Z"),
});

// Cancel before it's sent
await scheduled.cancel();
```

**Parameters:** `message: string | PostableMessage | CardJSXElement`, `options: { postAt: Date }`

**Returns:** `Promise<ScheduledMessage>`


  Streaming and file uploads are not supported in scheduled messages.


## getParticipants

Get the unique human participants in a thread. Returns deduplicated authors, excluding all bots. Useful for subscribing only to 1:1 conversations and unsubscribing when others join.

```typescript
const participants = await thread.getParticipants();

// Subscribe only when one person is talking to the bot
if (participants.length === 1) {
  await thread.subscribe();
}

// Unsubscribe when the thread becomes a group conversation
if (participants.length > 1) {
  await thread.unsubscribe();
}
```


  Each call fetches the full message history to find all participants. On threads with long history this makes multiple API calls to the platform. Consider checking `message.author` against a known set before calling `getParticipants()` on every incoming message.


## subscribe / unsubscribe

Manage thread subscriptions. Subscribed non-DM threads route all messages to `onSubscribedMessage` handlers. DM threads route to `onDirectMessage` first when a direct message handler is registered.

```typescript
await thread.subscribe();
await thread.unsubscribe();
const subscribed = await thread.isSubscribed();
```

Subscriptions persist across restarts via your state adapter.

## state

Store typed, per-thread state that persists across requests. State has a 30-day TTL.

```typescript
// Read state
const state = await thread.state; // TState | null

// Merge into existing state
await thread.setState({ aiMode: true });

// Replace state entirely
await thread.setState({ aiMode: false }, { replace: true });
```

## startTyping

Show a typing indicator in the thread. No-op on platforms that don't support it. On Slack, you can pass an optional `status` string to show a custom loading message (requires `assistant:write` scope).

```typescript
await thread.startTyping();

// With custom status (Slack only)
await thread.startTyping("Searching documents...");
```

## markAsRead

Mark an inbound message as read. WhatsApp, Messenger, and XChat support this capability. Other adapters throw `NotImplementedError`.

Inside a message handler, omit the argument to mark the current message:

```typescript
bot.onDirectMessage(async (thread) => {
  await thread.markAsRead();
});
```

Pass a `Message` or message ID when targeting a message explicitly:

```typescript
await thread.markAsRead(message);
await thread.markAsRead(message.id);
```

A `Message` must belong to the thread, and passing one from another thread throws. A bare message ID is sent to the adapter as given, since there is nothing to check it against. Calling `markAsRead()` without an argument outside a message handler throws because there is no current message.

Platforms may advance the conversation's read state through the target message, which also marks earlier messages as read.

## messages / allMessages

Iterate through message history.

```typescript
// Newest first (auto-paginates)
for await (const msg of thread.messages) {
  console.log(msg.text);
}

// Oldest first (auto-paginates)
for await (const msg of thread.allMessages) {
  console.log(msg.text);
}
```

## refresh

Re-fetch messages from the API and update `recentMessages`.

```typescript
await thread.refresh();
```

## mentionUser

Get a platform-specific @-mention string for a user.

```typescript
await thread.post(`Hey ${thread.mentionUser(userId)}, check this out!`);
```

## Serialization

Threads can be serialized for workflow engines and external systems. The serialized thread includes the current message if one is available.

```typescript
// Serialize
const json = thread.toJSON();

// Pass to a workflow
await workflow.start("my-workflow", {
  thread: thread.toJSON(),
});
```

The serialized format includes the thread ID, channel ID, adapter name, DM status, and the current message (if present).

### Deserialization

Use `bot.reviver()` as a `JSON.parse` reviver to automatically restore `Thread` and `Message` objects from serialized payloads:

```typescript
const data = JSON.parse(payload, bot.reviver());
await data.thread.post("Hello from workflow!");
```

Under the hood, the reviver calls `ThreadImpl.fromJSON()` and `Message.fromJSON()` for any serialized objects it encounters.

## ScheduledMessage

Returned by `thread.schedule()` and `channel.schedule()`.


## SentMessage

Returned by `thread.post()`. Extends `Message` with mutation methods.


---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
