---
name: chat-sdk
description: Expert at Chat SDK (vercel/chat) - the unified TypeScript SDK for building chat bots and agents across Slack, Microsoft Teams, Google Chat, Discord, Telegram, WhatsApp, and more. Use when building multi-platform bots, chat adapters, JSX cards, modals, slash commands, or AI streaming to chat platforms. Triggers on mentions of Chat SDK, chat bots, Slack bot, Teams bot, Discord bot, chat adapters.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Chat SDK Skill

Expert at building multi-platform chat bots and agents with Chat SDK (`vercel/chat`).

## Overview

**Chat SDK** is a TypeScript library for building chat bots that run across multiple platforms from a single codebase:
- Single codebase deployed to Slack, Teams, Google Chat, Discord, Telegram, GitHub, Linear, WhatsApp, Messenger, and more
- Type-safe platform adapters with auto-detected credentials
- Event-driven handlers for mentions, messages, reactions, button clicks, slash commands, and modals
- Thread subscriptions for multi-turn conversations
- Rich UI via JSX cards, buttons, and modals rendered natively per platform
- First-class AI streaming support and serverless-ready distributed state (Redis, ioredis, Postgres, MySQL, Durable Objects)

## Quick Start

```typescript
import { Chat } from "chat";
import { createSlackAdapter } from "@chat-adapter/slack";
import { createRedisState } from "@chat-adapter/redis";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    slack: createSlackAdapter(), // auto-detects SLACK_BOT_TOKEN, SLACK_SIGNING_SECRET
  },
  state: createRedisState(), // auto-detects REDIS_URL
});

bot.onNewMention(async (thread) => {
  await thread.subscribe();
  await thread.post("Hello! I'm listening to this thread.");
});
```

## Core Concepts

- **Chat** — the main entry point that coordinates adapters and routes events to handlers
- **Adapters** — platform-specific implementations handling webhook parsing, message formatting, and API calls (official, vendor-official, and community adapters)
- **State** — a pluggable persistence layer for thread subscriptions, distributed locking, and dedup (memory, Redis, ioredis, Postgres, MySQL, Durable Objects)

## Documentation

**Getting started & usage**: [Introduction](docs/introduction.md), [Getting Started](docs/getting-started.md), [CLI](docs/create-chat-sdk.md), [Creating a Chat Instance](docs/usage.md), [Threads/Messages/Channels](docs/threads-messages-channels.md), [Handling Events](docs/handling-events.md), [Posting Messages](docs/posting-messages.md), [Error Handling](docs/error-handling.md), [Testing](docs/testing.md)

**AI**: [Overview](docs/ai.md), [AI SDK Tools](docs/ai-ai-sdk-tools.md), [toAiMessages](docs/ai-to-ai-messages.md), [Types](docs/ai-types.md)

**Adapters**: [Overview](docs/adapters.md), [Platform Adapters](docs/platform-adapters.md), [Slack Low-Level APIs](docs/slack-primitives.md), [Teams Low-Level APIs](docs/teams-primitives.md), [State Adapters](docs/state-adapters.md)

**Messaging & interactivity**: [Streaming](docs/streaming.md), [Direct Messages](docs/direct-messages.md), [Ephemeral Messages](docs/ephemeral-messages.md), [File Uploads](docs/files.md), [Conversation History](docs/conversation-history.md), [Cards](docs/cards.md), [Modals](docs/modals.md), [Actions](docs/actions.md), [Slash Commands](docs/slash-commands.md), [Emoji](docs/emoji.md), [Overlapping Messages](docs/concurrency.md)

**API reference**: [Overview](docs/api.md), [Chat](docs/api-chat.md), [Thread](docs/api-thread.md), [Channel](docs/api-channel.md), [Message](docs/api-message.md), [Cards](docs/api-cards.md), [Modals](docs/api-modals.md), [Markdown](docs/api-markdown.md), [Transcripts](docs/api-transcripts.md)

**Contributing**: [Building an adapter](docs/contributing-building.md), [Testing adapters](docs/contributing-testing.md), [Publishing](docs/contributing-publishing.md)

**Adapters catalog**: official adapters cached as `docs/adapter-<name>.md` (slack, teams, gchat, discord, telegram, github, linear, whatsapp, twilio, messenger, web, memory, redis, ioredis, postgres), vendor-official adapters as `docs/adapter-vendor-<name>.md` (liveblocks, resend, novu, sendblue, zernio, matrix, agentphone, lark, velt, kapso, linq), and community adapters as `docs/adapter-community-<name>.md` (webex, baileys, blooio, zalo, mattermost, weixin, cloudflare-do, mysql).

- **[Upstream README](docs/readme-upstream.md)** - Full repository README

## Upstream Sources

- **Repository**: https://github.com/vercel/chat
- **Documentation**: https://chat-sdk.dev

## Sync & Update

When user runs `sync`: fetch latest from upstream sources, update docs/ files.
When user runs `diff`: compare current vs upstream, report changes.
