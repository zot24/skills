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
| Edit message       |                 |                         |                       |                     |                         |                   | <Warn /> Partial                    | <Cross />                      | <Cross />                        |
| Delete message     |                 |                         |                       |                     |                         |                   | <Warn /> Partial                    | <Cross />                      | <Cross />                        |
| File uploads       |                 |                         | <Cross />                      |                     | <Warn /> Single file/media       | <Cross />                  | <Cross />                           |  Images, audio, docs  | <Cross />                        |
| Streaming          |  Native         | <Warn /> Native (DMs) / Buffered | <Warn /> Post+Edit             | <Warn /> Post+Edit           | <Warn /> Rich drafts / Post+Edit | <Warn /> Buffered          | <Warn /> Agent sessions / Post+Edit | <Warn /> Buffered              | <Warn /> Buffered                |
| Scheduled messages |  Native         | <Cross />                        | <Cross />                      | <Cross />                    | <Cross />                        | <Cross />                  | <Cross />                           | <Cross />                      | <Cross />                        |

### Rich content

| Feature         | Slack               | Teams          | Google Chat       | Discord       | Telegram                               | GitHub        | Linear        | WhatsApp                      | Messenger                |
| --------------- | ------------------- | -------------- | ----------------- | ------------- | -------------------------------------- | ------------- | ------------- | ----------------------------- | ------------------------ |
| Card format     | Block Kit           | Adaptive Cards | Google Chat Cards | Embeds        | Markdown + inline keyboard buttons     | GFM Markdown  | Markdown      | WhatsApp templates            | Generic/Button Templates |
| Buttons         |            |       |          |      | <Warn /> Inline keyboard callbacks     | <Cross />     | <Cross />     |  Interactive replies | <Warn /> Max 3, postback |
| Link buttons    |            |       |          |      | <Warn /> Inline keyboard URLs          | <Cross />     | <Cross />     | <Cross />                     |                 |
| Select menus    |            | <Cross />      |          | <Cross />     | <Cross />                              | <Cross />     | <Cross />     | <Cross />                     | <Cross />                |
| Tables          |  Block Kit |  GFM  | <Warn /> ASCII    |  GFM | <Warn /> Native messages / ASCII cards |  GFM |  GFM | <Cross />                     | <Warn /> ASCII           |
| Fields          |            |       |          |      |                               |      |      | <Warn /> Template variables   | <Warn /> ASCII           |
| Images in cards |            |       |          |      | <Cross />                              |      | <Cross />     |                      |                 |
| Modals          |            |       | <Cross />         | <Cross />     | <Cross />                              | <Cross />     | <Cross />     | <Cross />                     | <Cross />                |

### Conversations

| Feature                                                                                  | Slack            | Teams           | Google Chat      | Discord   | Telegram            | GitHub    | Linear                  | WhatsApp  | Messenger |
| ---------------------------------------------------------------------------------------- | ---------------- | --------------- | ---------------- | --------- | ------------------- | --------- | ----------------------- | --------- | --------- |
| Slash commands                                                                           |         | <Cross />       | <Cross />        |  | <Cross />           | <Cross /> | <Cross />               | <Cross /> | <Cross /> |
| Mentions                                                                                 |         |        |         |  |            |  |                | <Cross /> |  |
| Add reactions                                                                            |         | <Cross />       |         |  |            |  |                |  | <Cross /> |
| Remove reactions                                                                         |         | <Cross />       |         |  |            | <Warn />  | <Warn />                |  | <Cross /> |
| Typing indicator                                                                         |         |        | <Cross />        |  |            | <Cross /> | <Warn /> Agent sessions | <Warn />  |  |
| DMs                                                                                      |         |        |         |  |            | <Cross /> | <Cross />               |  |  |
| Ephemeral messages                                                                       |  Native | <Cross />       |  Native | <Cross /> | <Cross />           | <Cross /> | <Cross />               | <Cross /> | <Cross /> |
| User lookup ([`getUser`](/docs/api/chat#getuser))                                        |         | <Warn /> Cached | <Warn /> Cached  |  | <Warn /> Seen users |  |                | <Cross /> | <Cross /> |
| Parent subject ([`message.subject`](/docs/subject))                                      | <Cross />        | <Cross />       | <Cross />        | <Cross /> | <Cross />           |  |                | <Cross /> | <Cross /> |
| Native client ([`.webClient` / `.octokit` / `.linearClient`](/docs/api/chat#getadapter)) |         | <Cross />       | <Cross />        | <Cross /> | <Cross />           |  |                | <Cross /> | <Cross /> |
| Custom API endpoint (`apiUrl`)                                                           |         |        |         |  |            |  |                |  |  |

### Message history

| Feature                | Slack     | Teams     | Google Chat | Discord   | Telegram        | GitHub    | Linear    | WhatsApp                           | Messenger                          |
| ---------------------- | --------- | --------- | ----------- | --------- | --------------- | --------- | --------- | ---------------------------------- | ---------------------------------- |
| Fetch messages         |  |  |    |  | <Warn /> Cached |  |  | <Warn /> Cached sent messages only | <Warn /> Cached sent messages only |
| Fetch single message   |  | <Cross /> | <Cross />   | <Cross /> | <Warn /> Cached | <Cross /> | <Cross /> | <Cross />                          | <Warn /> Cached                    |
| Fetch thread info      |  |  |    |  |        |  |  |                           |                           |
| Fetch channel messages |  |  |    |  | <Warn /> Cached |  | <Cross /> | <Cross />                          | <Warn /> Cached                    |
| List threads           |  |  |    |  | <Cross />       |  | <Cross /> | <Cross />                          | <Cross />                          |
| Fetch channel info     |  |  |    |  |        |  | <Cross /> | <Cross />                          |                           |
| Post channel message   |  |  |    |  |        | <Cross /> | <Cross /> |                           |                           |

<Callout type="info">
  <Warn /> indicates partial support. The feature works with limitations. See individual adapter pages for details.
</Callout>

## How adapters work

Each adapter implements a standard interface that the `Chat` class uses to route events and send messages. When a webhook arrives:

1. The adapter verifies the request signature
2. Parses the platform-specific payload into a normalized `Message`
3. Routes to your handlers via the `Chat` class
4. Converts outgoing messages from markdown/AST/cards to the platform's native format

## Using multiple adapters

Register multiple [adapters](/adapters) and your event handlers work across all of them:

```typescript title="lib/bot.ts" lineNumbers


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

<Callout type="info">
  The examples above use Redis for state. See [State Adapters](/docs/state-adapters) for all available options.
</Callout>

Each adapter creates a webhook handler accessible via `bot.webhooks.<name>`.

## Customizing an adapter via subclassing

Each official adapter exposes its extension surface as `protected` members so you can subclass it to override or extend platform-specific behavior without forking the package. Use this when you need to handle a payload type the built-in adapter doesn't cover, intercept verification, or wrap an existing handler.

```typescript title="lib/custom-telegram.ts" lineNumbers


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

<Callout type="warn">
  The `protected` extension surface is intentionally broader than the public API but is not yet considered fully stable. Method signatures may evolve in minor releases as we learn from real-world subclasses. Pin the adapter version you build against, watch the changelog for the affected adapter, and prefer overriding the smallest hook that solves your problem so upgrades stay easy. If you rely on a particular hook, please open an issue so we can promote it to a stable, documented extension point.
</Callout>
