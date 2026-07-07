> Source: https://chat-sdk.dev/docs/api/channel.md

---
title: Channel
description: Channel container that holds threads, with methods for listing, posting, and iteration.
type: reference
---

# Channel


A `Channel` represents a channel or conversation container that holds threads. Both `Thread` and `Channel` extend the shared `Postable` interface, so they share common methods like `post()`, `state`, and `messages`.

Get a channel via `thread.channel` or `chat.channel()`:

```typescript
// Navigate from a thread
const channel = thread.channel;

// Get directly by ID
const channel = chat.channel("slack:C123ABC");
```

## Properties


## Channel ID format

Channel IDs are derived from thread IDs by dropping the thread-specific part. By default, this is the first two colon-separated segments:

| Platform    | Thread ID                                   | Channel ID            |
| ----------- | ------------------------------------------- | --------------------- |
| Slack       | `slack:C123ABC:1234567890.123456`           | `slack:C123ABC`       |
| Teams       | `teams:{base64}:{base64}`                   | `teams:{base64}`      |
| Google Chat | `gchat:spaces/ABC123:{base64}`              | `gchat:spaces/ABC123` |
| Discord     | `discord:{guildId}:{channelId}/{messageId}` | `discord:{guildId}`   |

## messages

Iterate channel-level messages (top-level, not thread replies) newest first. Auto-paginates lazily.

```typescript
for await (const msg of channel.messages) {
  console.log(msg.text);
}
```

## threads

Iterate threads in the channel, most recently active first. Returns lightweight `ThreadSummary` objects.

```typescript
for await (const thread of channel.threads()) {
  console.log(thread.rootMessage.text, thread.replyCount);
}
```

### ThreadSummary


## post

Post a message to the channel top-level (not in a thread).

```typescript
await channel.post("Hello channel!");
await channel.post({ markdown: "**Announcement**: New release!" });
```

Accepts the same message formats as `thread.post()` — see [PostableMessage](/docs/api/postable-message).

## schedule

Schedule a message for future delivery to the channel top-level. Currently only supported by the Slack adapter — other adapters throw `NotImplementedError`.

```typescript
const scheduled = await channel.schedule("Weekly reminder: update your status!", {
  postAt: new Date("2026-03-10T09:00:00Z"),
});

// Cancel before it's sent
await scheduled.cancel();
```

Accepts the same message formats as `channel.post()` (except streaming). See [ScheduledMessage](/docs/api/thread#scheduledmessage) for the return type.

## fetchMetadata

Fetch channel metadata from the platform.

```typescript
const info = await channel.fetchMetadata();
console.log(info.name, info.memberCount);
```

### ChannelInfo


## state

Store typed, per-channel state. Works the same as thread state with a 30-day TTL.

```typescript
const state = await channel.state;
await channel.setState({ lastAnnouncement: new Date().toISOString() });
```

## postEphemeral

Post a message visible only to a specific user.

```typescript
await channel.postEphemeral(userId, "Only you can see this", {
  fallbackToDM: true,
});
```

## startTyping

Show a typing indicator. No-op on platforms that don't support it. On Slack, you can pass an optional `status` string to show a custom loading message (requires `assistant:write` scope).

```typescript
await channel.startTyping();

// With custom status (Slack only)
await channel.startTyping("Searching documents...");
```

## mentionUser

Get a platform-specific @-mention string.

```typescript
await channel.post(`Hey ${channel.mentionUser(userId)}, check this out!`);
```
