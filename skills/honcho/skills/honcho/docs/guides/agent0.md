<!-- Source: https://docs.honcho.dev/v3/guides/community/agent0 -->

# Agent Zero Integration

## Overview

Agent Zero is a general AI agent framework featuring plugin-first architecture. The Honcho plugin adds persistent memory across chat sessions -- users are remembered with their preferences, context, and behavioral patterns.

## Installation

1. Obtain a Honcho API key from app.honcho.dev
2. Clone the plugin into Agent Zero's plugins directory
3. Activate through Settings > Plugins menu

## Functionality

The plugin operates by:
- Hooking into Agent Zero's extension system
- Syncing user and assistant messages to Honcho after each turn
- Prefetching user context into the system prompt on new turns
- Maintaining separate peer models for user and agent interactions
- Continuing normal operation if Honcho becomes unavailable

## Resources

- **Plugin Repository** -- GitHub source code and setup documentation
- **Honcho Architecture** -- Information on peers, sessions, and dialectic reasoning concepts
