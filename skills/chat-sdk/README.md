# Chat SDK Skill

Expert assistant for building multi-platform chat bots and agents with [Chat SDK](https://chat-sdk.dev/) (`vercel/chat`).

## Overview

[Chat SDK](https://chat-sdk.dev/) is a unified TypeScript SDK for building chat bots and agents across Slack, Microsoft Teams, Google Chat, Discord, Telegram, WhatsApp, and more — one codebase, type-safe adapters, JSX cards/modals, and first-class AI streaming. This skill provides comprehensive guidance on adapters, event handling, messaging, interactivity, and the API surface.

## Features

- **Single codebase**: deploy the same bot logic to Slack, Teams, Google Chat, Discord, Telegram, GitHub, Linear, WhatsApp, Messenger, and more
- **Type-safe adapters**: official, vendor-official, and community adapters with auto-detected credentials
- **Event-driven handlers**: mentions, messages, reactions, button clicks, slash commands, modals
- **Rich UI**: JSX cards, buttons, and modals rendered natively per platform
- **AI streaming**: first-class support for streaming LLM responses to chat threads, plus AI SDK tool integration
- **Serverless-ready state**: pluggable persistence (memory, Redis, ioredis, Postgres, MySQL, Cloudflare Durable Objects)

## Commands

| Command | Description |
|---------|-------------|
| `/chat-sdk overview` | Introduction, core concepts, and getting started |
| `/chat-sdk adapters` | List and explain platform adapters |
| `/chat-sdk ai` | AI streaming, AI SDK tools, and message conversion |
| `/chat-sdk api <name>` | Look up an API reference entry |
| `/chat-sdk sync` | Update documentation from upstream |
| `/chat-sdk diff` | Show changes vs upstream |
| `/chat-sdk help` | Show available commands |

## Quick Start

```typescript
import { Chat } from "chat";
import { createSlackAdapter } from "@chat-adapter/slack";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    slack: createSlackAdapter(), // auto-detects SLACK_BOT_TOKEN, SLACK_SIGNING_SECRET
  },
});

bot.onNewMention(async (thread) => {
  await thread.post("Hello! I'm listening to this thread.");
});
```

Or scaffold a new bot app:

```bash
npx create-chat-sdk my-bot
```

## Documentation

- [Introduction](skills/chat-sdk/docs/introduction.md)
- [Getting Started](skills/chat-sdk/docs/getting-started.md)
- [Adapters Overview](skills/chat-sdk/docs/adapters.md)
- [AI Overview](skills/chat-sdk/docs/ai.md)
- [API Reference](skills/chat-sdk/docs/api.md)
- Per-adapter docs: `skills/chat-sdk/docs/adapter-<name>.md`, `adapter-vendor-<name>.md`, `adapter-community-<name>.md`

## Upstream Sources

- **Repository**: https://github.com/vercel/chat
- **Documentation**: https://chat-sdk.dev

## Documentation Sync

Documentation is synced from upstream sources. Run sync manually:

```bash
.github/workflows/scripts/sync-skill.sh skills/chat-sdk
```

Or wait for the bi-weekly CI sync.

## License

MIT
