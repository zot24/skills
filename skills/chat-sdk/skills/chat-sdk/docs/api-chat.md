> Source: https://chat-sdk.dev/docs/api/chat.md

---
title: Chat
description: The class that coordinates adapters, state, and event handlers for a multi-platform chat bot.
type: reference
related:
  - /docs/usage
  - /docs/handling-events
---

# Chat


The `Chat` class coordinates adapters, state, and event handlers. Create one instance and register handlers for different event types.

```typescript
import { Chat } from "chat";
```

## Constructor

```typescript
const bot = new Chat(config);
```


These options are deprecated but still read, so existing bots keep working:

| Option           | Replacement                                                                                                                       |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `onLockConflict` | `concurrency`. It only applies under the `drop` strategy, where `'force'` releases the held lock instead of throwing `LockError`. |
| `identity`       | `history.user.identity`                                                                                                           |
| `transcripts`    | `history.user`                                                                                                                    |
| `threadHistory`  | `history.thread`                                                                                                                  |
| `messageHistory` | `history.thread`. It was renamed to `threadHistory` first, which takes precedence when both are set.                              |

## Event handlers

### onNewMention

Fires when the bot is @-mentioned in a thread it has not subscribed to. Most bots start new conversations from this handler.

```typescript
bot.onNewMention(async (thread, message) => {
  await thread.subscribe();
  await thread.post("Hello!");
});
```


### onDirectMessage

Fires for every direct message when registered. Direct message handlers run before `onSubscribedMessage`, `onNewMention`, and pattern handlers. If no direct message handler is registered, unsubscribed DMs fall through to `onNewMention` for backward compatibility.

```typescript
bot.onDirectMessage(async (thread, message, channel) => {
  await thread.post(`Got your DM in ${channel.id}: ${message.text}`);
});
```


### onSubscribedMessage

Fires for every new message in a subscribed non-DM thread. Once subscribed, messages (including @-mentions) route here instead of `onNewMention`. DM threads route to `onDirectMessage` first when a direct message handler is registered.

```typescript
bot.onSubscribedMessage(async (thread, message) => {
  if (message.isMention) {
    // User @-mentioned us in a thread we're already watching
  }
  await thread.post(`Got: ${message.text}`);
});
```

### onNewMessage

Fires for messages matching a regex pattern in unsubscribed threads.

```typescript
bot.onNewMessage(/^!help/i, async (thread, message) => {
  await thread.post("Available commands: !help, !status");
});
```


### onReaction

Fires when a user adds or removes an emoji reaction.

```typescript
import { emoji } from "chat";

// Filter to specific emoji
bot.onReaction([emoji.thumbs_up, emoji.heart], async (event) => {
  if (event.added) {
    await event.thread.post(`Thanks for the ${event.emoji}!`);
  }
});

// Handle all reactions
bot.onReaction(async (event) => { /* ... */ });
```


### onAction

Fires when a user clicks a button or selects an option in a card.

```typescript
// Single action
bot.onAction("approve", async (event) => {
  if (event.thread) {
    await event.thread.post("Approved!");
  }
});

// Multiple actions
bot.onAction(["approve", "reject"], async (event) => { /* ... */ });

// All actions
bot.onAction(async (event) => { /* ... */ });
```


### onModalSubmit

Fires when a user submits a modal form.

```typescript
bot.onModalSubmit("feedback", async (event) => {
  const comment = event.values.comment;
  if (event.relatedThread) {
    await event.relatedThread.post(`Feedback: ${comment}`);
  }
});
```


Returns `ModalResponse | undefined` to control the modal after submission:

| Response                                               | Effect                                                       |
| ------------------------------------------------------ | ------------------------------------------------------------ |
| `{ action: "close" }`                                  | Closes the current view and goes back one level in the stack |
| `{ action: "clear" }`                                  | Closes all views and dismisses the modal                     |
| `{ action: "errors", errors: { fieldId: "message" } }` | Shows validation errors                                      |
| `{ action: "update", modal: ModalElement }`            | Replaces the modal content                                   |
| `{ action: "push", modal: ModalElement }`              | Pushes a new modal view onto the stack                       |

### onOptionsLoad

Fires when an `ExternalSelect` requests options dynamically. Slack only. The handler is keyed on the select's `id` and must return options within Slack's 3-second budget. The adapter caps the loader at about 2.5 seconds and returns an empty result on timeout.

```typescript
bot.onOptionsLoad("assignee", async (event) => {
  const people = await peopleService.search(event.query);
  return people.map((p) => ({ label: p.fullName, value: p.id }));
});
```

Return an array of `OptionsLoadGroup` (`{ label, options }[]`) instead of a flat array to render grouped headers, such as "Recent" and "All". Slack allows at most 100 groups and 100 options per group.


### onSlashCommand

Fires when a user invokes a `/command` in the message composer. Supported on Slack and Discord.

```typescript
// Specific command
bot.onSlashCommand("/status", async (event) => {
  await event.channel.post("All systems operational!");
});

// Multiple commands
bot.onSlashCommand(["/help", "/info"], async (event) => {
  await event.channel.post(`You invoked ${event.command}`);
});

// Catch-all
bot.onSlashCommand(async (event) => {
  console.log(`${event.command} ${event.text}`);
});
```


### onModalClose

Fires when a user closes a modal. Requires `notifyOnClose: true` on the modal.

```typescript
bot.onModalClose("feedback", async (event) => { /* ... */ });
```

### onAssistantThreadStarted

Fires when a user opens a new assistant thread through the Slack Assistants API. Use it to set suggested prompts, show a status indicator, or send an initial greeting.

```typescript
bot.onAssistantThreadStarted(async (event) => {
  const slack = bot.getAdapter("slack") as SlackAdapter;
  await slack.setSuggestedPrompts(event.channelId, event.threadTs, [
    { title: "Get started", message: "What can you help me with?" },
  ]);
});
```


### onAssistantContextChanged

Fires when a user navigates to a different channel while the Slack Assistants API panel is open. Use it to update suggested prompts or context for the new channel.

```typescript
bot.onAssistantContextChanged(async (event) => {
  const slack = bot.getAdapter("slack") as SlackAdapter;
  await slack.setAssistantStatus(event.channelId, event.threadTs, "Updating context...");
});
```

The event shape is identical to `onAssistantThreadStarted`.

### onAgentSessionStopped

Fires after a user clicks Slack's native agent-session stop button. Chat SDK
aborts the active turn and moves the session out of `processing` before this
handler runs.

```typescript
bot.onAgentSessionStopped(async (event) => {
  await releaseExternalResources(event.threadId);
});
```

The event contains `threadId`, `channelId`, `threadTs`,
`streamingMessageTs`, `userId`, and `adapter`. `streamingMessageTs` lists the
streaming messages Slack stopped and can be empty when no stream was active.

### onAgentSessionTitleChanged

Fires when a user renames a Slack agent session.

```typescript
bot.onAgentSessionTitleChanged(async (event) => {
  await syncTitle(event.threadId, event.title);
});
```

The event contains `title`, `previousTitle`, `threadId`, `channelId`,
`threadTs`, `userId`, and `adapter`. `previousTitle` is omitted when the
session did not have a title before the change.

### onAppHomeOpened

Fires when a user opens the bot's Home tab in Slack. Use it to publish a dynamic Home tab view.

```typescript
bot.onAppHomeOpened(async (event) => {
  const slack = bot.getAdapter("slack") as SlackAdapter;
  await slack.publishHomeView(event.userId, {
    type: "home",
    blocks: [{ type: "section", text: { type: "mrkdwn", text: "Welcome!" } }],
  });
});
```


### onInstalled

Fires when the bot is installed, including when an app upgrade adds the bot to the manifest. Routine upgrades do not emit this event. Only the Teams adapter emits it, for personal, group chat, and team installs.

```typescript
bot.onInstalled(async (event) => {
  if (!event.channelId) return;
  await bot.channel(event.channelId).post("Thanks for installing!");
});
```


### onUninstalled

Fires when the bot is removed, including when an app upgrade removes it from the manifest. Same event shape as `onInstalled`, with `action` set to `"remove"` or `"remove-upgrade"`. Clean up durable records for both actions, and do not post to the conversation after removal.

```typescript
bot.onUninstalled(async (event) => {
  await removeInstallation(event);
});
```

`removeInstallation` is application-owned. For Teams team installs, associate
records with `event.raw.channelData.team.id` as well as `conversationId`, which
can differ between installation and removal. See the [Teams persistence example](/adapters/official/teams#installation-lifecycle).

## Utility methods

### abortTurn

Abort the active handler turn for a thread. Chat SDK signals work in this
process immediately and publishes the cancellation through the configured
state adapter for another serverless instance to observe.

```typescript
await bot.abortTurn(thread.id);
```

Platform adapters normally invoke this for native cancellation events. Model
and tool calls must receive `thread.signal` to stop their own upstream work.

### webhooks

Typed webhook handlers keyed by adapter name. Call them from your HTTP route handler.

```typescript
bot.webhooks.slack(request, { waitUntil });
bot.webhooks.teams(request, { waitUntil });
```

### getAdapter

Get a typed adapter instance by name.

```typescript
const slack = bot.getAdapter("slack");
```

#### Direct client access

Each adapter exposes its platform's typed native API client through a getter named after the SDK: `.webClient` on Slack, `.linearClient` on Linear, and `.octokit` on GitHub.

```typescript
// Slack - full WebClient from @slack/web-api
const slack = bot.getAdapter("slack").webClient;
await slack.pins.add({ channel: "C123ABC", timestamp: "1234567890.123456" });

// Linear - full LinearClient from @linear/sdk
const linear = bot.getAdapter("linear").linearClient;
const issue = await linear.issue("ENG-123");
const project = await issue.project;

// GitHub - full Octokit from @octokit/rest
const github = bot.getAdapter("github").octokit;
const { data: pulls } = await github.rest.pulls.list({
  owner: "vercel",
  repo: "chat",
  state: "open",
});
```

The client uses the credentials from your adapter config. For multi-tenant or multi-workspace adapters (Slack, Linear, GitHub), it returns the client bound to the credentials for the current webhook request context.


  The previous `.client` getter still works on all three adapters as a deprecated alias for `.webClient`, `.linearClient`, and `.octokit`.


  Multi-tenant adapters (GitHub App without a fixed installation ID, Linear with per-org OAuth, Slack in multi-workspace mode) require a webhook handler context to resolve credentials when the native client getter is accessed. Calling it outside a handler throws.

  For Slack, you can also bind a token explicitly outside a webhook with `adapter.withBotToken(token, () => adapter.webClient.…)`, for example in cron jobs or workflows. The same pattern is required when `botToken` is configured as an async resolver function, since `.webClient` resolves the token synchronously.

  Single-tenant adapters (PAT, API key, static `botToken` string, or a synchronous `botToken` resolver) work anywhere.


| Adapter | Getter          | Type                              |
| ------- | --------------- | --------------------------------- |
| Slack   | `.webClient`    | `WebClient` from `@slack/web-api` |
| Linear  | `.linearClient` | `LinearClient` from `@linear/sdk` |
| GitHub  | `.octokit`      | `Octokit` from `@octokit/rest`    |

### openDM

Open a direct message thread with a user.

```typescript
const dm = await bot.openDM("U123456");
await dm.post("Hello via DM!");

// Or with an Author object
const dm = await bot.openDM(message.author);
```

### getUser

Look up user information by user ID. Returns a `UserInfo` object with name, email, avatar, and bot status, or `null` if the user was not found.

`bot.getUser` picks the adapter from the format of the user ID, so it only works for platforms whose IDs it can recognize: Slack (`U...` or `W...`), Microsoft Teams (`29:...`), Google Chat (`users/...`), Linear (UUID), and Discord, Telegram, and GitHub (numeric). For other adapters that implement `getUser`, such as X and Twilio, call the adapter directly with `bot.getAdapter("x").getUser(userId)`.

```typescript
const user = await bot.getUser("U123456");
console.log(user?.email);    // "alice@company.com"
console.log(user?.fullName); // "Alice Smith"
```

```typescript
// Or with an Author object from a message handler. The adapter is still
// inferred from author.userId.
const user = await bot.getUser(message.author);
```


| Platform        | Constraints                                                                                                                                                                                       |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Slack           | Requires the `users:read` and `users:read.email` scopes. The email scope must be granted at OAuth install time.                                                                                   |
| Discord         | Bot tokens never see email. The `email` OAuth scope only applies to user-context auth.                                                                                                            |
| Telegram        | Bots can only look up users who have previously messaged them.                                                                                                                                    |
| Microsoft Teams | Only works for users who previously interacted with the bot, because profiles are cached from webhook activity. `avatarUrl` is not returned because the Graph API requires a separate photo call. |
| Google Chat     | Same caching constraint as Teams: only users seen in prior webhooks.                                                                                                                              |
| GitHub          | `email` is only returned if the user made it public or you authenticated with the `user:email` scope.                                                                                             |
| Linear          | Returns the full profile, including email and avatar, for any active workspace member.                                                                                                            |
| X               | Returns the name, username, and avatar. `email` is not returned. Call through the adapter, because X's numeric IDs aren't inferred.                                                               |
| Twilio          | Doesn't call Twilio. Returns a profile built from the phone number, with the number as `userId`, `userName`, and `fullName`.                                                                      |

Fields that aren't available return `undefined`.

Numeric user IDs from Discord, Telegram, and GitHub are ambiguous when more than one of those adapters is registered. In that case `bot.getUser` throws a `ChatError` with code `AMBIGUOUS_USER_ID`, even when you pass an `Author`, because the adapter is inferred from the ID alone. Call the adapter directly instead, for example `thread.adapter.getUser?.(message.author.userId)` inside a handler or `bot.getAdapter("telegram").getUser(userId)` elsewhere.

`bot.getUser` throws a `ChatError` in three cases. Handle them if your bot runs on multiple platforms.

| Code                     | When                                                                                              |
| ------------------------ | ------------------------------------------------------------------------------------------------- |
| `NOT_SUPPORTED`          | The inferred adapter doesn't implement `getUser`                                                  |
| `AMBIGUOUS_USER_ID`      | A numeric user ID could belong to more than one registered adapter (Discord, Telegram, or GitHub) |
| `UNKNOWN_USER_ID_FORMAT` | The `userId` string doesn't match any registered platform's ID format                             |

```typescript
import { ChatError } from "chat";

try {
  const user = await bot.getUser(userId);
  if (!user) {
    // User not found on this platform
  }
} catch (error) {
  if (error instanceof ChatError) {
    if (error.code === "NOT_SUPPORTED") {
      // This adapter doesn't support user lookups
    } else if (error.code === "AMBIGUOUS_USER_ID") {
      // Pass message.author or call adapter.getUser(userId) directly
    } else if (error.code === "UNKNOWN_USER_ID_FORMAT") {
      // userId doesn't match any known platform format
    }
  }
}
```

### thread

Get a `Thread` handle by its thread ID. Use it to post to threads outside a webhook, such as from a cron job or an external trigger.

```typescript
const thread = bot.thread("slack:C123ABC:1234567890.123456");
await thread.post("Hello from a cron job!");
```

### channel

Get a `Channel` by its channel ID.

```typescript
const channel = bot.channel("slack:C123ABC");

for await (const msg of channel.messages) {
  console.log(msg.text);
}
```

### initialize / shutdown

Manage the lifecycle manually. Initialization happens automatically on the first webhook. Call `initialize()` yourself when the bot does work outside a webhook.

```typescript
await bot.initialize();
// ... do work ...
await bot.shutdown();
```

During shutdown, the SDK calls the optional `disconnect()` method on each adapter before disconnecting the state adapter. Adapters use it to clean up platform connections, close WebSockets, or tear down subscriptions. If one adapter's `disconnect()` fails, the remaining adapters and the state adapter still disconnect.

### reviver

Get a `JSON.parse` reviver that deserializes `Thread` and `Message` objects from workflow payloads.

```typescript
const data = JSON.parse(payload, bot.reviver());
await data.thread.post("Hello from workflow!");
```

Threads and channels restored by `bot.reviver()` stay bound to that bot's adapters and state, and restored threads use that bot's streaming defaults, even if another Chat instance is registered later. When using multiple bots, parse each payload with the receiving bot's reviver. This does not isolate state keys if the bots share the same state store.

The binding is not serialized. If a restored object crosses a Workflow step boundary, automatic deserialization uses the registered singleton again. For multiple bots, pass the serialized data and explicitly restore it with the receiving bot's reviver inside the step.

There is also a workflow-safe serialization entrypoint that works without importing the `Chat` runtime. Use it in Vercel Workflow files so serializer registration does not load Node-only runtime dependencies:

```typescript
import { Message, reviver, ThreadImpl } from "chat/serialization";

const data = JSON.parse(payload, reviver) as {
  thread: ThreadImpl;
  message: Message;
};
```

`Message`, `ThreadImpl`, and `ChannelImpl` retain their automatic Workflow serialization when imported from either `chat` or `chat/serialization`. The dedicated entrypoint guarantees their serializer module graph does not load the Node-only `Chat` conversation context.

The standalone reviver resolves adapters lazily, looking them up from the Chat singleton on first access. Call `chat.registerSingleton()` before using thread methods like `post()` (typically inside a `"use step"` function). Once a restored thread or channel resolves its runtime, it retains that Chat instance for its adapter, state, and streaming defaults, even if the singleton changes. Registering the correct bot before first use remains the caller's responsibility; use `bot.reviver()` when the owner must be explicit.

### history

Namespaced access to the History API: cross-platform user history, per-thread reads and cache, and per-channel reads.

```typescript
// User scope: cross-platform, keyed by identity resolver result
await bot.history.user.append(thread, message);
const entries = await bot.history.user.list({ userKey, limit: 20 });
await bot.history.user.delete({ userKey });

// Thread scope: adapter.fetchMessages with cache fallback
const { messages } = await bot.history.thread.list(thread.id, { limit: 20 });

// Channel scope: platform APIs
const { messages: channelMessages } = await bot.history.channel.listMessages(
  channel.id,
  { limit: 10 }
);
const { threads } = await bot.history.channel.listThreads(channel.id, {
  limit: 20,
});
```

See [History API reference](/docs/api/history) for full details and the [History guide](/docs/history) for setup and patterns.


  `bot.transcripts` is a deprecated alias for `bot.history.user`. Accessing either when user history is not configured throws.


---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
