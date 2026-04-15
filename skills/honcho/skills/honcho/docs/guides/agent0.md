> Source: https://docs.honcho.dev/v3/guides/community/agent0.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Agent Zero

> Add AI-native memory to Agent Zero

[Agent Zero](https://github.com/agent0ai/agent-zero) is a general AI agent framework with a plugin-first architecture. The Honcho plugin gives Agent Zero persistent memory across chat sessions — users are remembered with their preferences, context, and behavioral patterns, even after sessions end and new ones begin.

## Getting Started

The Honcho plugin is a community integration. See the [plugin README](https://github.com/alogotron/a0-plugin-honcho) for full installation and configuration instructions.

The integration requires:

1. A Honcho API key from [app.honcho.dev](https://app.honcho.dev)
2. Cloning the plugin into your Agent Zero plugins directory
3. Enabling it via **Settings > Plugins** in Agent Zero's UI

## How It Works

The plugin hooks into Agent Zero's extension system. It syncs user and assistant messages to Honcho after every turn, prefetches user context into the system prompt on each new turn, and maintains separate peer models for the user and agent. If Honcho is unavailable, the agent continues normally.

## Next Steps


    Source code, installation, and full documentation.


    Learn about peers, sessions, and dialectic reasoning.


