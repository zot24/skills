<!-- Source: https://docs.honcho.dev/v3/guides/integrations/openclaw -->

# OpenClaw Integration

## Overview

OpenClaw is an AI agent platform that gains memory capabilities through the Honcho plugin. Works across WhatsApp, Telegram, Discord, Slack, and other channels, with an option to run entirely locally.

## Installation

```bash
openclaw plugins install @honcho-ai/openclaw-honcho
openclaw honcho setup
openclaw gateway --force
```

The setup command configures your API key and can migrate existing memory files.

## Key Features

- **Memory Persistence**: Conversations saved to Honcho automatically after each AI turn
- **Context Access**: AI uses tools like `honcho_context`, `honcho_search_conclusions`, `honcho_search_messages`, and `honcho_ask`
- **Dual Peer Model**: Separate memory for users and agents, with isolated memory in multi-agent setups
- **Subagent Support**: Parent agents observe subagent activity without attribution

## Available Tools

- Context lookup
- Conclusion search
- Message discovery
- Session history
- LLM-powered `honcho_ask` for user information synthesis

## Configuration

Settings managed through `openclaw honcho setup` or directly in `~/.openclaw/openclaw.json`. Key options: API key, workspace ID, base URL for self-hosted instances.

## Local Search Integration

QMD integration enables both Honcho cross-session memory and local markdown file searching for hybrid memory capabilities.
