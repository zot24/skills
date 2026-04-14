<!-- Source: https://docs.honcho.dev/v3/guides/community/pi-honcho-memory -->

# Pi: Persistent Memory Extension

## Overview

Pi-honcho-memory is a persistent memory plugin designed for the pi coding agent CLI. Long-term memory across sessions -- user preferences, project context, and past decisions are remembered and automatically integrated into system prompts.

## Installation

```bash
pi install npm:@agney/pi-honcho-memory
```

## Requirements

1. API key from [app.honcho.dev](https://app.honcho.dev)
2. Configure via `/honcho-setup` interactively or set `HONCHO_API_KEY` environment variable

Note: This is a community-created integration.

## Functionality

- Automatically syncs messages to Honcho following each agent response
- Injects cached user profile and project context into system prompts with minimal latency
- Exposes LLM tools: `honcho_search`, `honcho_chat`, and `honcho_remember`
- Flexible session scoping (per repository, git branch, or directory)
- Normal pi functionality maintained if Honcho becomes unavailable

## Resources

- **Repository**: [github.com/agneym/pi-honcho-memory](https://github.com/agneym/pi-honcho-memory)
- **Honcho Architecture Guide**: Available in the Honcho documentation on core concepts
