> Source: https://chat-sdk.dev/docs/platform-adapters.md

---
title: Platform Adapters
description: Platform-specific adapters that connect your bot to any messaging platform.
type: overview
prerequisites:
  - /docs/getting-started
  - /docs/adapters
---

# Platform Adapters


Platform adapters handle webhook verification, message parsing, and API calls for each messaging platform. Install only the adapters you need. Browse all available adapters, including community-built ones, on the [Adapters](/adapters) page.

Need a browser chat UI? See the [Web adapter](/adapters/official/web). It speaks the AI SDK UI stream protocol and works with React (`@ai-sdk/react`), Vue (`@ai-sdk/vue`), and Svelte (`@ai-sdk/svelte`), so the same bot serves Slack, Teams, and any browser framework out of the box.

Ready to build your own? Follow the [building](/docs/contributing/building) guide.

## Feature matrix

<GlobalFeatureMatrix type="platform" />

### Messaging

| Feature            | [Slack](/adapters/slack) | [Teams](/adapters/teams)         | [Google Chat](/adapters/gchat) | [Discord](/adapters/discord) | [Telegram](/adapters/telegram)   | [GitHub](/adapters/github) | [Linear](/adapters/linear)          | [WhatsApp](/adapters/whatsapp) | [Messenger](/adapters/messenger) |
| ------------------ | ------------------------ | -------------------------------- | ------------------------------ | ---------------------------- | -------------------------------- | -------------------------- | ----------------------------------- | ------------------------------ | -------------------------------- |
| Post message       |                 |                         |                       |                     |                         |                   |                            |                       |                         |
| Edit message       |                 |                         |                       |                     |                         |                   |  Partial                    |                       |                         |
| Delete message     |                 |                         |                       |                     |                         |                   |  Partial                    |                       |                         |
| File uploads       |                 |                         |                       |                     |  Single file/media       |                   |                            |  Images, audio, docs  |                         |
| Streaming          |  Native         |  Native (DMs) / Buffered |  Post+Edit             |  Post+Edit           |  Rich drafts / Post+Edit |  Buffered          |  Agent sessions / Post+Edit |  Buffered              |  Buffered                |
| Scheduled messages |  Native         |                         |                       |                     |                         |                   |                            |                       |                         |

### Rich content

| Feature         | Slack               | Teams          | Google Chat       | Discord       | Telegram                               | GitHub        | Linear        | WhatsApp                      | Messenger                |
| --------------- | ------------------- | -------------- | ----------------- | ------------- | -------------------------------------- | ------------- | ------------- | ----------------------------- | ------------------------ |
| Card format     | Block Kit           | Adaptive Cards | Google Chat Cards | Embeds        | Markdown + inline keyboard buttons     | GFM Markdown  | Markdown      | WhatsApp templates            | Generic/Button Templates |
| Buttons         |            |       |          |      |  Inline keyboard callbacks     |      |      |  Interactive replies |  Max 3, postback |
| Link buttons    |            |       |          |      |  Inline keyboard URLs          |      |      |                      |                 |
| Select menus    |            |       |          |      |                               |      |      |                      |                 |
| Tables          |  Block Kit |  GFM  |  ASCII    |  GFM |  Native messages / ASCII cards |  GFM |  GFM |                      |  ASCII           |
| Fields          |            |       |          |      |                               |      |      |  Template variables   |  ASCII           |
| Images in cards |            |       |          |      |                               |      |      |                      |                 |
| Modals          |            |       |          |      |                               |      |      |                      |                 |

### Conversations

| Feature                                                                                  | Slack            | Teams           | Google Chat      | Discord   | Telegram            | GitHub    | Linear                  | WhatsApp  | Messenger |
| ---------------------------------------------------------------------------------------- | ---------------- | --------------- | ---------------- | --------- | ------------------- | --------- | ----------------------- | --------- | --------- |
| Slash commands                                                                           |         |        |         |  |            |  |                |  |  |
| Mentions                                                                                 |         |        |         |  |            |  |                |  |  |
| Add reactions                                                                            |         |        |         |  |            |  |                |  |  |
| Remove reactions                                                                         |         |        |         |  |            |   |                 |  |  |
| Typing indicator                                                                         |         |        |         |  |            |  |  Agent sessions |   |  |
| DMs                                                                                      |         |        |         |  |            |  |                |  |  |
| Ephemeral messages                                                                       |  Native |        |  Native |  |            |  |                |  |  |
| User lookup ([`getUser`](/docs/api/chat#getuser))                                        |         |  Cached |  Cached  |  |  Seen users |  |                |  |  |
| Parent subject ([`message.subject`](/docs/subject))                                      |         |        |         |  |            |  |                |  |  |
| Native client ([`.webClient` / `.octokit` / `.linearClient`](/docs/api/chat#getadapter)) |         |        |         |  |            |  |                |  |  |
| Custom API endpoint (`apiUrl`)                                                           |         |        |         |  |            |  |                |  |  |

### Message history

| Feature                | Slack     | Teams     | Google Chat | Discord   | Telegram        | GitHub    | Linear    | WhatsApp                           | Messenger                          |
| ---------------------- | --------- | --------- | ----------- | --------- | --------------- | --------- | --------- | ---------------------------------- | ---------------------------------- |
| Fetch messages         |  |  |    |  |  Cached |  |  |  Cached sent messages only |  Cached sent messages only |
| Fetch single message   |  |  |    |  |  Cached |  |  |                           |  Cached                    |
| Fetch thread info      |  |  |    |  |        |  |  |                           |                           |
| Fetch channel messages |  |  |    |  |  Cached |  |  |                           |  Cached                    |
| List threads           |  |  |    |  |        |  |  |                           |                           |
| Fetch channel info     |  |  |    |  |        |  |  |                           |                           |
| Post channel message   |  |  |    |  |        |  |  |                           |                           |


   indicates partial support. The feature works with limitations. See individual adapter pages for details.


## How adapters work

Each adapter implements a standard interface that the `Chat` class uses to route events and send messages. When a webhook arrives:

1. The adapter verifies the request signature
2. Parses the platform-specific payload into a normalized `Message`
3. Routes to your handlers via the `Chat` class
4. Converts outgoing messages from markdown/AST/cards to the platform's native format

## Using multiple adapters

Register multiple [adapters](/adapters) and your event handlers work across all of them:

```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createSlackAdapter } from "@chat-adapter/slack";
import { createTeamsAdapter } from "@chat-adapter/teams";
import { createGoogleChatAdapter } from "@chat-adapter/gchat";
import { createRedisState } from "@chat-adapter/state-redis";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    slack: createSlackAdapter(),
    teams: createTeamsAdapter(),
    gchat: createGoogleChatAdapter(),
  },
  state: createRedisState(),
});

// This handler fires for mentions on any platform
bot.onNewMention(async (thread) => {
  await thread.subscribe();
  await thread.post("Hello!");
});
```

Each adapter auto-detects credentials from environment variables, so you only need to pass config when overriding defaults.


  The examples above use Redis for state. See [State Adapters](/docs/state-adapters) for all available options.


Each adapter creates a webhook handler accessible via `bot.webhooks.<name>`.

## Customizing an adapter via subclassing

Each official adapter exposes its extension surface as `protected` members so you can subclass it to override or extend platform-specific behavior without forking the package. Use this when you need to handle a payload type the built-in adapter doesn't cover, intercept verification, or wrap an existing handler.

```typescript title="lib/custom-telegram.ts" lineNumbers
import { TelegramAdapter, type TelegramUpdate } from "@chat-adapter/telegram";
import type { WebhookOptions } from "chat";

export class CustomTelegramAdapter extends TelegramAdapter {
  protected override processUpdate(
    update: TelegramUpdate,
    options?: WebhookOptions
  ): void {
    // Handle a payload type the base adapter doesn't, e.g. chat_join_request.
    if ("chat_join_request" in update) {
      this.logger.info("Received chat_join_request", { update });
      return;
    }
    super.processUpdate(update, options);
  }
}
```

Construct your subclass anywhere you'd construct the base adapter, for example, `adapters: { telegram: new CustomTelegramAdapter({ ... }) }`. Members marked `private` intentionally remain inaccessible. If you find a hook you need that isn't `protected`, please open an issue.


  The `protected` extension surface is intentionally broader than the public API but is not yet considered fully stable. Method signatures may evolve in minor releases as we learn from real-world subclasses. Pin the adapter version you build against, watch the changelog for the affected adapter, and prefer overriding the smallest hook that solves your problem so upgrades stay easy. If you rely on a particular hook, please open an issue so we can promote it to a stable, documented extension point.

