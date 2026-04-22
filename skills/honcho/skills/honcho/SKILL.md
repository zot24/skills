---
name: honcho
description: Expert on Honcho — AI-native memory and context platform for LLM applications. Use when building stateful agents, adding persistent memory, managing user representations, or integrating Honcho SDKs. Triggers on mentions of honcho, peer memory, user modeling, session context, dreaming, conclusions, honcho SDK.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Honcho — AI-Native Memory Platform

Honcho provides persistent memory, user modeling, and context management for LLM applications. It learns about users over time through conversations and builds rich representations.

## Overview

- **Workspaces**: Top-level containers isolating data between applications
- **Peers**: Represent users/entities — Honcho builds profiles ("representations") from conversations
- **Sessions**: Conversation threads containing messages between peers
- **Conclusions**: Derived insights Honcho extracts from conversations
- **Dreaming**: Autonomous background process that consolidates and improves memory
- **Context API**: Retrieve formatted context (summaries + recent messages) for LLM injection

## Quick Start

```python
from honcho import Honcho

honcho = Honcho()
workspace = honcho.workspaces.get_or_create("my-app")
peer = honcho.workspaces.peers.get_or_create(workspace.id, "user-123")
session = honcho.workspaces.sessions.get_or_create(workspace.id, session_id="conv-1", peers=["user-123"])

# Store messages
honcho.workspaces.sessions.messages.create(workspace.id, session.id, messages=[
    {"role": "user", "content": "Hello!"},
    {"role": "assistant", "content": "Hi there!"}
])

# Get context for next LLM call
context = honcho.workspaces.sessions.get_context(workspace.id, session.id)
```

## Core Concepts

- **Representations**: Rich user profiles built from conversation patterns — not just facts but behavioral understanding
- **Dreaming**: Background process that reviews conversations, extracts conclusions, and refines representations
- **Context**: Combines session summary + recent messages + peer representation into a token-budgeted payload

## Documentation

### Getting Started
- **[Overview](docs/overview.md)** — What Honcho is and why
- **[Quickstart](docs/quickstart.md)** — Setup and first API calls
- **[Agentic Development](docs/vibecoding.md)** — MCP server, agent skills, and tools

### Core Concepts
- **[Architecture](docs/architecture.md)** — Data model and core concepts
- **[Design Patterns](docs/design-patterns.md)** — Workspace/peer/session patterns
- **[Reasoning](docs/reasoning.md)** — How Honcho reasons over data
- **[Representations](docs/representation.md)** — Peer user models

### Features
- **[Storing Data](docs/storing-data.md)** — Messages and conversations
- **[Get Context](docs/get-context.md)** — Context retrieval for LLMs
- **[Chat Endpoint](docs/chat.md)** — Querying peer knowledge
- **[Advanced Features](docs/advanced-overview.md)** — Dreaming, filters, search, streaming

### API Reference
- **[Introduction](docs/api/introduction.md)** — Authentication and basics
- **[Workspaces](docs/api/workspaces.md)** — Workspace endpoints
- **[Peers](docs/api/peers.md)** — Peer endpoints
- **[Sessions](docs/api/sessions.md)** — Session endpoints
- **[Messages](docs/api/messages.md)** — Message endpoints
- **[Conclusions](docs/api/conclusions.md)** — Conclusion endpoints
- **[Webhooks](docs/api/webhooks.md)** — Webhook endpoints

### Guides & Integrations
- **[Guides Overview](docs/guides/overview.md)** — All guides index
- **[Claude Code](docs/guides/claude-code.md)** — Honcho + Claude Code
- **[MCP Server](docs/guides/mcp.md)** — Model Context Protocol
- **[LangGraph](docs/guides/langgraph.md)** — LangGraph integration
- **[Discord](docs/guides/discord.md)** / **[Telegram](docs/guides/telegram.md)** — Bot guides

### Reference
- **[CLI Reference](docs/cli.md)** — `honcho-cli` terminal tool (`uv tool install honcho-cli`)
- **[SDK Reference](docs/sdk.md)** — Python and TypeScript SDKs
- **[Dashboard](docs/platform.md)** — Honcho dashboard
- **[Self-Hosting](docs/self-hosting.md)** — Local setup
- **[Configuration](docs/configuration.md)** — Provider and infra config

## Upstream Sources

- **Documentation**: https://docs.honcho.dev/v3/documentation
- **Repository**: https://github.com/plastic-labs/honcho
- **Dashboard**: https://app.honcho.dev
- **Docs Index**: https://docs.honcho.dev/llms.txt
