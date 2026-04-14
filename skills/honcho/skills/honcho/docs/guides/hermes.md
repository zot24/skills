<!-- Source: https://docs.honcho.dev/v3/guides/integrations/hermes -->

# Hermes Agent + Honcho

## Overview

Hermes Agent, an open-source tool from Nous Research featuring tool-calling and multi-platform deployment, integrates with Honcho for persistent cross-session memory and user modeling.

## Core Capabilities

1. **Context injection at prompt time** -- user information loaded before response generation
2. **Memory persistence across sessions** -- recall of preferences and project history
3. **Durable storage of learned facts** -- important context retained for future interactions

## Architecture

Dual-peer model where both participants have representations:

- **User peer**: Derived from user messages; captures preferences and communication patterns
- **AI peer**: Built from assistant messages; establishes the agent's knowledge base

Both representations feed into the system prompt for contextual awareness.

## Available Tools

| Tool | Function |
|------|----------|
| `honcho_profile` | Fast peer card retrieval (no LLM) |
| `honcho_search` | Semantic search returning ranked excerpts |
| `honcho_context` | Dialectic Q&A powered by Honcho's LLM |
| `honcho_conclude` | Stores preferences and important context |

## Setup

Configure Honcho by running `hermes memory setup` or editing the config file with your instance URL and workspace details.

## Verification

1. Check status with `hermes memory status`
2. Store and recall information across sessions
3. Call Honcho tools directly through Hermes prompts
