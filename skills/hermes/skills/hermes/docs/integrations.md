> Source: https://hermes-agent.nousresearch.com/docs/integrations/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Integrations


Hermes Agent connects to external systems for AI inference, tool servers, IDE workflows, programmatic access, and more. These integrations extend what Hermes can do and where it can run.


If you only have time to set up one integration, set up [Nous Portal](/docs/integrations/nous-portal) — a single OAuth login covers 300+ models plus the four Tool Gateway tools (web search, image generation, TTS, and browser automation).


## AI Providers & Routing<a href="#ai-providers--routing" class="hash-link" aria-label="Direct link to AI Providers &amp; Routing" translate="no" title="Direct link to AI Providers &amp; Routing">​</a>

Hermes supports multiple AI inference providers out of the box. Use `hermes model` to configure interactively, or set them in `config.yaml`.

- **[AI Providers](/docs/integrations/providers)** — OpenRouter, Anthropic, OpenAI, Google, and any OpenAI-compatible endpoint. Hermes auto-detects capabilities like vision, streaming, and tool use per provider.
- **[Provider Routing](/docs/user-guide/features/provider-routing)** — Fine-grained control over which underlying providers handle your OpenRouter requests. Optimize for cost, speed, or quality with sorting, whitelists, blacklists, and explicit priority ordering.
- **[Fallback Providers](/docs/user-guide/features/fallback-providers)** — Automatic failover to backup LLM providers when your primary model encounters errors. Includes primary model fallback and independent auxiliary task fallback for vision, compression, and web extraction.

## Tool Servers (MCP)<a href="#tool-servers-mcp" class="hash-link" aria-label="Direct link to Tool Servers (MCP)" translate="no" title="Direct link to Tool Servers (MCP)">​</a>

- **[MCP Servers](/docs/user-guide/features/mcp)** — Connect Hermes to external tool servers via Model Context Protocol. Access tools from GitHub, databases, file systems, browser stacks, internal APIs, and more without writing native Hermes tools. Supports both stdio and SSE transports, per-server tool filtering, and capability-aware resource/prompt registration.

## Web Search Backends<a href="#web-search-backends" class="hash-link" aria-label="Direct link to Web Search Backends" translate="no" title="Direct link to Web Search Backends">​</a>

The `web_search` and `web_extract` tools support eight backend providers, configured via `config.yaml` or `hermes tools`:

| Backend                 | Env Var                | Search | Extract | Crawl |
|-------------------------|------------------------|--------|---------|-------|
| **Firecrawl** (default) | `FIRECRAWL_API_KEY`    | ✔      | ✔       | ✔     |
| **SearXNG**             | `SEARXNG_URL`          | ✔      | —       | —     |
| **Brave** (free tier)   | `BRAVE_SEARCH_API_KEY` | ✔      | —       | —     |
| **DuckDuckGo** (ddgs)   | *(none)*               | ✔      | —       | —     |
| **Tavily**              | `TAVILY_API_KEY`       | ✔      | ✔       | ✔     |
| **Exa**                 | `EXA_API_KEY`          | ✔      | ✔       | —     |
| **Parallel**            | `PARALLEL_API_KEY`     | ✔      | ✔       | —     |
| **xAI**                 | `XAI_API_KEY`          | ✔      | —       | —     |

Quick setup example:


``` prism-code
web:
  backend: firecrawl    # firecrawl | searxng | brave-free | ddgs | tavily | exa | parallel | xai
```


If `web.backend` is not set, the backend is auto-detected from whichever API key is available. Self-hosted Firecrawl is also supported via `FIRECRAWL_API_URL`.

## Browser Automation<a href="#browser-automation" class="hash-link" aria-label="Direct link to Browser Automation" translate="no" title="Direct link to Browser Automation">​</a>

Hermes includes full browser automation with multiple backend options for navigating websites, filling forms, and extracting information:

- **Browserbase** — Managed cloud browsers with anti-bot tooling, CAPTCHA solving, and residential proxies
- **Browser Use** — Alternative cloud browser provider
- **Local Chromium-family CDP** — Connect to your running Chrome, Brave, Chromium, or Edge browser using `/browser connect`
- **Local Chromium** — Headless local browser via the `agent-browser` CLI

See [Browser Automation](/docs/user-guide/features/browser) for setup and usage.

## Voice & TTS Providers<a href="#voice--tts-providers" class="hash-link" aria-label="Direct link to Voice &amp; TTS Providers" translate="no" title="Direct link to Voice &amp; TTS Providers">​</a>

Text-to-speech and speech-to-text across all messaging platforms:

| Provider               | Quality   | Cost | API Key                  |
|------------------------|-----------|------|--------------------------|
| **Edge TTS** (default) | Good      | Free | None needed              |
| **ElevenLabs**         | Excellent | Paid | `ELEVENLABS_API_KEY`     |
| **OpenAI TTS**         | Good      | Paid | `VOICE_TOOLS_OPENAI_KEY` |
| **MiniMax**            | Good      | Paid | `MINIMAX_API_KEY`        |
| **xAI TTS**            | Good      | Paid | `XAI_API_KEY`            |
| **NeuTTS**             | Good      | Free | None needed              |

Speech-to-text supports six providers: local faster-whisper (free, runs on-device), a local command wrapper, Groq, OpenAI Whisper API, Mistral, and xAI. Voice message transcription works across Telegram, Discord, WhatsApp, and other messaging platforms. See [Voice & TTS](/docs/user-guide/features/tts) and [Voice Mode](/docs/user-guide/features/voice-mode) for details.

## IDE & Editor Integration<a href="#ide--editor-integration" class="hash-link" aria-label="Direct link to IDE &amp; Editor Integration" translate="no" title="Direct link to IDE &amp; Editor Integration">​</a>

- **[IDE Integration (ACP)](/docs/user-guide/features/acp)** — Use Hermes Agent inside ACP-compatible editors such as VS Code, Zed, and JetBrains. Hermes runs as an ACP server, rendering chat messages, tool activity, file diffs, and terminal commands inside your editor.

## Programmatic Access<a href="#programmatic-access" class="hash-link" aria-label="Direct link to Programmatic Access" translate="no" title="Direct link to Programmatic Access">​</a>

- **[API Server](/docs/user-guide/features/api-server)** — Expose Hermes as an OpenAI-compatible HTTP endpoint. Any frontend that speaks the OpenAI format — Open WebUI, LobeChat, LibreChat, NextChat, ChatBox — can connect and use Hermes as a backend with its full toolset.

## Memory & Personalization<a href="#memory--personalization" class="hash-link" aria-label="Direct link to Memory &amp; Personalization" translate="no" title="Direct link to Memory &amp; Personalization">​</a>

- **[Built-in Memory](/docs/user-guide/features/memory)** — Persistent, curated memory via `MEMORY.md` and `USER.md` files. The agent maintains bounded stores of personal notes and user profile data that survive across sessions.
- **[Memory Providers](/docs/user-guide/features/memory-providers)** — Plug in external memory backends for deeper personalization. Eight providers are supported: Honcho (dialectic reasoning), OpenViking (tiered retrieval), Mem0 (cloud extraction), Hindsight (knowledge graphs), Holographic (local SQLite), RetainDB (hybrid search), ByteRover (CLI-based), and Supermemory.

## Messaging Platforms<a href="#messaging-platforms" class="hash-link" aria-label="Direct link to Messaging Platforms" translate="no" title="Direct link to Messaging Platforms">​</a>

Hermes runs as a gateway bot on 27+ messaging platforms, all configured through the same `gateway` subsystem:

- **[Telegram](/docs/user-guide/messaging/telegram)**, **[Discord](/docs/user-guide/messaging/discord)**, **[Slack](/docs/user-guide/messaging/slack)**, **[WhatsApp](/docs/user-guide/messaging/whatsapp)**, **[Signal](/docs/user-guide/messaging/signal)**, **[Matrix](/docs/user-guide/messaging/matrix)**, **[Mattermost](/docs/user-guide/messaging/mattermost)**, **[Email](/docs/user-guide/messaging/email)**, **[SMS](/docs/user-guide/messaging/sms)**, **[DingTalk](/docs/user-guide/messaging/dingtalk)**, **[Feishu/Lark](/docs/user-guide/messaging/feishu)**, **[WeCom](/docs/user-guide/messaging/wecom)**, **[WeCom Callback](/docs/user-guide/messaging/wecom-callback)**, **[Weixin](/docs/user-guide/messaging/weixin)**, **[BlueBubbles](/docs/user-guide/messaging/bluebubbles)**, **[QQ Bot](/docs/user-guide/messaging/qqbot)**, **[Yuanbao](/docs/user-guide/messaging/yuanbao)**, **[Home Assistant](/docs/user-guide/messaging/homeassistant)**, **[Microsoft Teams](/docs/user-guide/messaging/teams)**, **[Microsoft Teams Meetings](/docs/user-guide/messaging/teams-meetings)**, **[Microsoft Graph Webhook](/docs/user-guide/messaging/msgraph-webhook)**, **[Google Chat](/docs/user-guide/messaging/google_chat)**, **[LINE](/docs/user-guide/messaging/line)**, **[ntfy](/docs/user-guide/messaging/ntfy)**, **[SimpleX](/docs/user-guide/messaging/simplex)**, **[Open WebUI](/docs/user-guide/messaging/open-webui)**, **[Webhooks](/docs/user-guide/messaging/webhooks)**

See the [Messaging Gateway overview](/docs/user-guide/messaging) for the platform comparison table and setup guide.

## Home Automation<a href="#home-automation" class="hash-link" aria-label="Direct link to Home Automation" translate="no" title="Direct link to Home Automation">​</a>

- **[Home Assistant](/docs/user-guide/messaging/homeassistant)** — Control smart home devices via four dedicated tools (`ha_list_entities`, `ha_get_state`, `ha_list_services`, `ha_call_service`). The Home Assistant toolset activates automatically when `HASS_TOKEN` is configured.

## Plugins<a href="#plugins" class="hash-link" aria-label="Direct link to Plugins" translate="no" title="Direct link to Plugins">​</a>

- **[Plugin System](/docs/user-guide/features/plugins)** — Extend Hermes with custom tools, lifecycle hooks, and CLI commands without modifying core code. Plugins are discovered from `~/.hermes/plugins/`, project-local `.hermes/plugins/`, and pip-installed entry points.
- **[Build a Plugin](/docs/developer-guide/plugins)** — Step-by-step guide for creating Hermes plugins with tools, hooks, and CLI commands.

## Training & Evaluation<a href="#training--evaluation" class="hash-link" aria-label="Direct link to Training &amp; Evaluation" translate="no" title="Direct link to Training &amp; Evaluation">​</a>

- **[Batch Processing](/docs/user-guide/features/batch-processing)** — Run the agent across hundreds of prompts in parallel, generating structured ShareGPT-format trajectory data for training data generation or evaluation.


- <a href="#ai-providers--routing" class="table-of-contents__link toc-highlight">AI Providers &amp; Routing</a>
- <a href="#tool-servers-mcp" class="table-of-contents__link toc-highlight">Tool Servers (MCP)</a>
- <a href="#web-search-backends" class="table-of-contents__link toc-highlight">Web Search Backends</a>
- <a href="#browser-automation" class="table-of-contents__link toc-highlight">Browser Automation</a>
- <a href="#voice--tts-providers" class="table-of-contents__link toc-highlight">Voice &amp; TTS Providers</a>
- <a href="#ide--editor-integration" class="table-of-contents__link toc-highlight">IDE &amp; Editor Integration</a>
- <a href="#programmatic-access" class="table-of-contents__link toc-highlight">Programmatic Access</a>
- <a href="#memory--personalization" class="table-of-contents__link toc-highlight">Memory &amp; Personalization</a>
- <a href="#messaging-platforms" class="table-of-contents__link toc-highlight">Messaging Platforms</a>
- <a href="#home-automation" class="table-of-contents__link toc-highlight">Home Automation</a>
- <a href="#plugins" class="table-of-contents__link toc-highlight">Plugins</a>
- <a href="#training--evaluation" class="table-of-contents__link toc-highlight">Training &amp; Evaluation</a>


