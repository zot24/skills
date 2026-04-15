> Source: https://docs.honcho.dev/v3/guides/community/pi-honcho-memory.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Pi

> Persistent memory extension for the pi coding agent

[pi-honcho-memory](https://github.com/agneym/pi-honcho-memory) is a persistent memory extension for [pi](https://pi.dev), a coding agent CLI. It gives pi long-term memory across sessions — user preferences, project context, and past decisions are remembered and automatically injected into the system prompt.

## Getting Started

Install the extension inside pi:

```bash
pi install npm:@agney/pi-honcho-memory
```

The integration requires:

1. A Honcho API key from [app.honcho.dev](https://app.honcho.dev)
2. Running `/honcho-setup` inside pi for interactive configuration, or setting `HONCHO_API_KEY` in your environment

The Honcho plugin is a community integration. See the [plugin README](https://github.com/agneym/pi-honcho-memory/blob/main/README.md) for full installation and configuration instructions.

## How It Works

The extension hooks into pi's extension system. It automatically syncs user and assistant messages to Honcho after each agent response, injects cached user profile and project context into the system prompt with zero network latency, and exposes LLM tools (`honcho_search`, `honcho_chat`, `honcho_remember`) for active memory operations. Session scoping is configurable — memory can be shared per repo, per git branch, or per directory. If Honcho is unavailable, pi continues working normally.

## Next Steps


    Source code, installation, and full documentation.


    Learn about peers, sessions, and dialectic reasoning.


