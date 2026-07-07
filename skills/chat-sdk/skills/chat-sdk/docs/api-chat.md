> Source: https://chat-sdk.dev/docs/api/chat.md

---
title: Chat
description: The main entry point for creating a multi-platform chat bot.
type: reference
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


## Event handlers

### onNewMention

Fires when the bot is @-mentioned in a thread it has **not** subscribed to. This is the primary entry point for new conversations.

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

Fires for messages matching a regex pattern in **unsubscribed** threads.

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

* `{ action: "close" }` — close the current view (goes back one level in the stack)
* `{ action: "clear" }` — close all views and dismiss the modal entirely
* `{ action: "errors", errors: { fieldId: "message" } }` — show validation errors
* `{ action: "update", modal: ModalElement }` — replace the modal content
* `{ action: "push", modal: ModalElement }` — push a new modal view onto the stack

### onOptionsLoad

Fires when an `ExternalSelect` requests options dynamically. The handler is keyed on the select's `id` and must return options synchronously enough for Slack's 3-second budget (the adapter caps the loader at \~2.5s and substitutes an empty result on timeout). Slack-only.

```typescript
bot.onOptionsLoad("assignee", async (event) => {
  const people = await peopleService.search(event.query);
  return people.map((p) => ({ label: p.fullName, value: p.id }));
});
```

Return an array of `OptionsLoadGroup` (`{ label, options }[]`) instead of a flat array to render grouped headers (e.g. "Recent" / "All"). Slack limits: max 100 groups, max 100 options per group.


### onSlashCommand

Fires when a user invokes a `/command` in the message composer. Currently supported on Slack and Discord.

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

Fires when a user closes a modal (requires `notifyOnClose: true` on the modal).

```typescript
bot.onModalClose("feedback", async (event) => { /* ... */ });
```

### onAssistantThreadStarted

Fires when a user opens a new assistant thread (Slack Assistants API). Use this to set suggested prompts, show a status indicator, or send an initial greeting.

```typescript
bot.onAssistantThreadStarted(async (event) => {
  const slack = bot.getAdapter("slack") as SlackAdapter;
  await slack.setSuggestedPrompts(event.channelId, event.threadTs, [
    { title: "Get started", message: "What can you help me with?" },
  ]);
});
```


### onAssistantContextChanged

Fires when a user navigates to a different channel while the assistant panel is open (Slack Assistants API). Use this to update suggested prompts or context based on the new channel.

```typescript
bot.onAssistantContextChanged(async (event) => {
  const slack = bot.getAdapter("slack") as SlackAdapter;
  await slack.setAssistantStatus(event.channelId, event.threadTs, "Updating context...");
});
```

The event shape is identical to `onAssistantThreadStarted`.

### onAppHomeOpened

Fires when a user opens the bot's Home tab in Slack. Use this to publish a dynamic Home tab view.

```typescript
bot.onAppHomeOpened(async (event) => {
  const slack = bot.getAdapter("slack") as SlackAdapter;
  await slack.publishHomeView(event.userId, {
    type: "home",
    blocks: [{ type: "section", text: { type: "mrkdwn", text: "Welcome!" } }],
  });
});
```


## Utility methods

### webhooks

Type-safe webhook handlers keyed by adapter name. Pass these to your HTTP route handler.

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

Access the platform's typed native API client directly via an SDK-named getter — `.webClient` on Slack, `.linearClient` on Linear, `.octokit` on GitHub:

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

The client uses the credentials from your adapter config. For multi-tenant / multi-workspace adapters (Slack, Linear, GitHub), it returns the client bound to the credentials for the current webhook request context.


  The previous `.client` getter still works on all three adapters as a deprecated alias for `.webClient` / `.linearClient` / `.octokit`.


  Multi-tenant adapters (GitHub App without a fixed installation ID, Linear with per-org OAuth, Slack in multi-workspace mode) require a webhook handler context to resolve credentials when the native client getter is accessed. Calling it outside a handler throws.

  For Slack, you can also bind a token explicitly outside a webhook with `adapter.withBotToken(token, () => adapter.webClient.…)` — useful for cron jobs or workflows. The same pattern is required when `botToken` is configured as an async resolver function, since `.webClient` resolves the token synchronously.

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

Look up user information by user ID. Returns a `UserInfo` object with name, email, avatar, and bot status, or `null` if the user was not found. Supported on Slack, Microsoft Teams, Discord, Google Chat, GitHub, Linear, and Telegram. Other adapters will throw `NOT_SUPPORTED`.

```typescript
const user = await bot.getUser("U123456");
console.log(user?.email);    // "alice@company.com"
console.log(user?.fullName); // "Alice Smith"
```

```typescript
// Or with an Author object from a message handler
const user = await bot.getUser(message.author);
```


  **Per-platform constraints:**

  * **Slack** — requires both `users:read` and `users:read.email` scopes (the email scope must be granted at OAuth install time).
  * **Discord** — bot tokens never see email (the `email` OAuth scope only applies in user-context auth).
  * **Telegram** — bots can only look up users who have previously messaged them.
  * **Microsoft Teams** — only works for users who previously interacted with the bot (cached from webhook activity). `avatarUrl` is not returned (Graph API requires a separate photo call).
  * **Google Chat** — same caching constraint as Teams: only users seen in prior webhooks.
  * **GitHub** — `email` is `null` unless the user made it public, or you authenticated with the `user:email` scope.
  * **Linear** — full profile (incl. email + avatar) for any active workspace member.

  Fields that aren't available return `undefined`. Numeric user IDs (Discord/Telegram/GitHub) can be ambiguous when multiple of those adapters are registered — `bot.getUser` throws a `ChatError` with code `AMBIGUOUS_USER_ID` in that case. Pass an `Author` from a message handler (which already carries the adapter), or call the adapter directly (`adapter.getUser(userId)`).


`bot.getUser` throws a `ChatError` in three cases. Handle them if your bot runs on multiple platforms:

| Code                     | When                                                                                         |
| ------------------------ | -------------------------------------------------------------------------------------------- |
| `NOT_SUPPORTED`          | The resolved adapter doesn't implement `getUser` (e.g. WhatsApp)                             |
| `AMBIGUOUS_USER_ID`      | A numeric user ID could belong to more than one registered adapter (Discord/Telegram/GitHub) |
| `UNKNOWN_USER_ID_FORMAT` | The `userId` string doesn't match any registered platform's ID format                        |

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

Get a Thread handle by its thread ID. Useful for posting to threads outside of webhook contexts (e.g. cron jobs, external triggers).

```typescript
const thread = bot.thread("slack:C123ABC:1234567890.123456");
await thread.post("Hello from a cron job!");
```

### channel

Get a Channel by its channel ID.

```typescript
const channel = bot.channel("slack:C123ABC");

for await (const msg of channel.messages) {
  console.log(msg.text);
}
```

### initialize / shutdown

Manually manage the lifecycle. Initialization happens automatically on the first webhook, but you can call it explicitly for non-webhook use cases.

```typescript
await bot.initialize();
// ... do work ...
await bot.shutdown();
```

During shutdown, the SDK calls the optional `disconnect()` method on each adapter before disconnecting the state adapter. This lets adapters clean up platform connections, close WebSockets, or tear down subscriptions. If any adapter's `disconnect()` fails, the remaining adapters and state adapter still disconnect gracefully.

### reviver

Get a `JSON.parse` reviver that deserializes `Thread` and `Message` objects from workflow payloads.

```typescript
const data = JSON.parse(payload, bot.reviver());
await data.thread.post("Hello from workflow!");
```

There is also a standalone `reviver` export that works without a `Chat` instance. This is useful in Vercel Workflow functions where importing the full Chat instance (with its adapter dependencies) is not possible:

```typescript
import { reviver } from "chat";

const data = JSON.parse(payload, reviver) as { thread: Thread; message: Message };
```

The standalone reviver uses lazy adapter resolution - the adapter is looked up from the Chat singleton when first accessed. Call `chat.registerSingleton()` before using thread methods like `post()` (typically inside a `"use step"` function).
