> Source: https://chat-sdk.dev/docs/api/channel.md

---
title: Channel
description: Channel container that holds threads, with methods for listing, posting, and iteration.
type: reference
related:
  - /docs/threads-messages-channels
---

# Channel


A `Channel` represents a channel or conversation container that holds threads. `Thread` and `Channel` both extend the `Postable` interface, so they share members such as `post()`, `state`, and `messages`.

Get a channel via `thread.channel` or `chat.channel()`:

```typescript
// Navigate from a thread
const channel = thread.channel;

// Get directly by ID
const channel = chat.channel("slack:C123ABC");
```

## Properties


## Channel ID format

Channel IDs are derived from thread IDs by dropping the thread-specific part. By default, the channel ID is the first two colon-separated segments. Adapters can override this, as the Teams and Discord rows show:

| Platform    | Thread ID                                                                  | Channel ID                                                                 |
| ----------- | -------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| Slack       | `slack:C123ABC:1234567890.123456`                                          | `slack:C123ABC`                                                            |
| Teams       | `teams:{base64(conversationId)}:{base64(serviceUrl)}[:{conversationType}]` | `teams:{base64(conversationId)}:{base64(serviceUrl)}[:{conversationType}]` |
| Google Chat | `gchat:spaces/ABC123:{base64}`                                             | `gchat:spaces/ABC123`                                                      |
| Discord     | `discord:{guildId}:{channelId}[:{threadId}]`                               | `discord:{guildId}:{channelId}`                                            |

## messages

Iterate top-level channel messages, newest first. Thread replies are not included. Pages are fetched lazily as you iterate.

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

Post a top-level message to the channel, outside any thread.

```typescript
await channel.post("Hello channel!");
await channel.post({ markdown: "**Announcement**: New release!" });
```

Accepts the same message formats as `thread.post()`. See [PostableMessage](/docs/api/postable-message).

## schedule

Schedule a top-level message to the channel for future delivery. Only the Slack adapter supports this. Other adapters throw `NotImplementedError`.

```typescript
const scheduled = await channel.schedule("Weekly reminder: update your status!", {
  postAt: new Date("2026-03-10T09:00:00Z"),
});

// Cancel before it's sent
await scheduled.cancel();
```

Accepts the same message formats as `channel.post()`, except streams. See [ScheduledMessage](/docs/api/thread#scheduledmessage) for the return type.

## fetchMetadata

Fetch channel metadata from the platform.

```typescript
const info = await channel.fetchMetadata();
console.log(info.name, info.memberCount);
```

### ChannelInfo


## state

Store typed, per-channel state. Works the same as thread state, with a 30-day TTL.

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

Show a typing indicator. No-op on platforms that don't support it. On Slack, you can pass an optional `status` string to show a custom loading message. This requires the `assistant:write` scope.

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


---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
