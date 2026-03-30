> Source: https://github.com/NousResearch/hermes-agent (repo analysis)

# Hermes Agent Source Reference

Internals and configuration details derived from the hermes-agent repository source code.

## Repository Structure

```
hermes-agent/
├── agent/              # Core agent loop, conversation management
├── gateway/            # Messaging platform gateway
│   ├── platforms/      # Platform adapters (telegram, discord, slack, etc.)
│   ├── builtin_hooks/  # Gateway lifecycle hooks
│   ├── config.py       # Gateway configuration
│   ├── delivery.py     # Message delivery system
│   ├── session.py      # Session management
│   └── run.py          # Gateway entrypoint
├── tools/              # All built-in tools
├── skills/             # Bundled skills (26 categories)
├── optional-skills/    # Extra skills not loaded by default
├── cron/               # Cron job scheduler
├── honcho_integration/ # Honcho cross-session memory
├── hermes_cli/         # CLI interface
├── environments/       # Terminal backend environments
├── docker/             # Docker support files
├── acp_adapter/        # Editor integration (VS Code/Zed/JetBrains)
├── acp_registry/       # ACP registry
├── cli.py              # CLI entrypoint
├── run_agent.py        # Agent runner
├── toolsets.py         # Tool grouping and resolution
├── hermes_constants.py # Global constants
├── hermes_state.py     # State management
├── model_tools.py      # Model/provider tools
├── utils.py            # Shared utilities
├── mcp_serve.py        # MCP server mode
├── cli-config.yaml.example  # Full config reference
└── .env.example        # Environment variables reference
```

## Complete Tool Registry

### Core Tools (_HERMES_CORE_TOOLS)

```python
# Web
"web_search", "web_extract"

# Terminal + process management
"terminal", "process"

# File manipulation
"read_file", "write_file", "patch", "search_files"

# Vision + image generation
"vision_analyze", "image_generate"

# Mixture of Agents
"mixture_of_agents"

# Skills
"skills_list", "skill_view", "skill_manage"

# Browser automation
"browser_navigate", "browser_snapshot", "browser_click",
"browser_type", "browser_scroll", "browser_back",
"browser_press", "browser_close", "browser_get_images",
"browser_vision", "browser_console"

# Text-to-speech
"text_to_speech"

# Planning & memory
"todo", "memory"

# Session history search
"session_search"

# Clarifying questions
"clarify"

# Code execution + delegation
"execute_code", "delegate_task"

# Cronjob management
"cronjob"

# Cross-platform messaging (gated on gateway running)
"send_message"

# Honcho memory tools (gated on honcho being active)
"honcho_context", "honcho_profile", "honcho_search", "honcho_conclude"

# Home Assistant (gated on HASS_TOKEN)
"ha_list_entities", "ha_get_state", "ha_list_services", "ha_call_service"
```

### Tool Source Files

| Tool File | Tools Provided |
|-----------|---------------|
| `web_tools.py` | web_search, web_extract |
| `terminal_tool.py` | terminal |
| `process_registry.py` | process |
| `file_tools.py` | read_file, write_file, patch, search_files |
| `file_operations.py` | File operation helpers |
| `vision_tools.py` | vision_analyze |
| `image_generation_tool.py` | image_generate |
| `mixture_of_agents_tool.py` | mixture_of_agents |
| `skills_tool.py` | skills_list, skill_view |
| `skill_manager_tool.py` | skill_manage |
| `browser_tool.py` | All browser_* tools |
| `tts_tool.py` | text_to_speech |
| `todo_tool.py` | todo |
| `memory_tool.py` | memory |
| `session_search_tool.py` | session_search |
| `clarify_tool.py` | clarify |
| `code_execution_tool.py` | execute_code |
| `delegate_tool.py` | delegate_task |
| `cronjob_tools.py` | cronjob |
| `send_message_tool.py` | send_message |
| `honcho_tools.py` | honcho_context, honcho_profile, honcho_search, honcho_conclude |
| `homeassistant_tool.py` | ha_list_entities, ha_get_state, ha_list_services, ha_call_service |
| `mcp_tool.py` | Dynamic MCP tools |
| `transcription_tools.py` | Audio transcription |
| `voice_mode.py` | Voice mode control |
| `approval.py` | Command approval system |
| `tirith_security.py` | Security scanning integration |
| `url_safety.py` | URL safety checks |
| `skills_hub.py` | Skill search/install from GitHub |
| `skills_sync.py` | Skill synchronization |
| `skills_guard.py` | Skill security guards |

### Toolset Presets

| Preset | Contents |
|--------|----------|
| `hermes-cli` | All tools except rl + send_message |
| `hermes-telegram` | terminal, file, web, vision, image_gen, tts, browser, skills, todo, cronjob, send_message |
| `hermes-discord` | Same as telegram |
| `hermes-whatsapp` | Same as telegram |
| `hermes-slack` | Same as telegram |
| `debugging` | terminal + web + file |
| `safe` | web + vision + moa (no terminal) |
| `all` | Everything available |

## Gateway Platforms

| Platform | File | Key Features |
|----------|------|-------------|
| Telegram | `telegram.py` | Polling + webhook modes, group mention gating, regex triggers |
| Discord | `discord.py` | Processing reactions, ignore non-mentions, slash commands |
| WhatsApp | `whatsapp.py` | Baileys bridge, persistent aiohttp, LID↔phone aliasing |
| Slack | `slack.py` | Multi-workspace OAuth, socket mode |
| Signal | `signal.py` | URL-encoded phone numbers, attachment RPC |
| Matrix | `matrix.py` | Native voice messages via MSC3245 |
| Mattermost | `mattermost.py` | Configurable mention behavior |
| Email | `email.py` | IMAP/SMTP with connection leak protection |
| Feishu/Lark | `feishu.py` | Event subscriptions, message cards, group chat |
| WeCom | `wecom.py` | Enterprise WeChat, callback verification |
| DingTalk | `dingtalk.py` | DingTalk integration |
| Home Assistant | `homeassistant.py` | Smart home control |
| SMS | `sms.py` | SMS messaging |
| Webhook | `webhook.py` | Generic webhook adapter |
| API Server | `api_server.py` | REST API endpoint |

## Bundled Skill Categories

```
skills/
├── apple/                  # Apple ecosystem
├── autonomous-ai-agents/   # Agent development
├── creative/               # Creative writing, art
├── data-science/           # Data analysis
├── devops/                 # DevOps & infrastructure
├── diagramming/            # Diagram creation
├── dogfood/                # Hermes self-improvement
├── domain/                 # Domain-specific knowledge
├── email/                  # Email management
├── feeds/                  # RSS/feed processing
├── gaming/                 # Game-related
├── gifs/                   # GIF creation
├── github/                 # GitHub workflows
├── index-cache/            # Skill index cache
├── inference-sh/           # inference.sh integration
├── leisure/                # Entertainment
├── mcp/                    # MCP server skills
├── media/                  # Media processing
├── mlops/                  # ML operations
├── note-taking/            # Note-taking apps
├── productivity/           # Productivity tools
├── red-teaming/            # Security testing
├── research/               # Research tools
├── smart-home/             # Home automation
├── social-media/           # Social media
└── software-development/   # Software dev tools

optional-skills/
├── autonomous-ai-agents/   # Advanced agent patterns
├── blockchain/             # Blockchain/crypto
├── communication/          # Communication frameworks
├── creative/               # Extended creative
├── devops/                 # Extended devops
├── email/                  # Extended email
├── health/                 # Health & wellness
├── mcp/                    # Extended MCP
├── migration/              # Migration tools
├── mlops/                  # Extended MLOps
├── productivity/           # Extended productivity
├── research/               # Extended research
└── security/               # Security tools
```

## Configuration Reference (config.yaml)

### Key Sections

| Section | Purpose |
|---------|---------|
| `model` | Default model, provider, base_url, api_key |
| `model.provider` | Provider selection (auto, openrouter, nous, anthropic, custom, etc.) |
| `fallback_providers` | Ordered failover chain across providers |
| `smart_model_routing` | Use cheap model for simple turns |
| `terminal` | Backend (local/ssh/docker/singularity/modal/daytona), cwd, timeout |
| `browser` | Inactivity timeout |
| `compression` | Context compression threshold, ratio, protect_last_n, summary_model |
| `memory` | memory_enabled, user_profile_enabled, char limits, nudge_interval |
| `session_reset` | Mode (both/idle/daily/none), idle_minutes, at_hour |
| `streaming` | Gateway token streaming to platforms |
| `skills` | creation_nudge_interval, external_dirs |
| `agent` | max_turns, verbose, reasoning_effort, personalities |
| `platform_toolsets` | Per-platform tool configuration |
| `mcp_servers` | MCP server definitions (stdio and HTTP) |
| `stt` | Speech-to-text provider and model |
| `code_execution` | Sandbox timeout and max_tool_calls |
| `delegation` | Subagent config: max_iterations, default_toolsets, model override |
| `honcho` | Cross-session user modeling integration |
| `display` | Compact mode, tool_progress, streaming, skin/theme, bell |
| `security` | Tirith pre-exec scanning |
| `privacy` | PII redaction settings |
| `group_sessions_per_user` | Per-user sessions in group chats |

### Inference Providers

| Provider | Key Required | Notes |
|----------|-------------|-------|
| `auto` | Any | Auto-detect from credentials |
| `openrouter` | OPENROUTER_API_KEY | Access to many models |
| `nous` | OAuth (hermes login) | Nous Portal |
| `nous-api` | NOUS_API_KEY | Nous Portal API key |
| `anthropic` | ANTHROPIC_API_KEY | Direct Anthropic API |
| `openai-codex` | OAuth (hermes login --provider openai-codex) | OpenAI Codex |
| `copilot` | GITHUB_TOKEN | GitHub Copilot/Models |
| `zai` | GLM_API_KEY | z.ai / ZhipuAI GLM |
| `kimi-coding` | KIMI_API_KEY | Moonshot AI |
| `minimax` | MINIMAX_API_KEY | MiniMax global |
| `minimax-cn` | MINIMAX_CN_API_KEY | MiniMax China |
| `huggingface` | HF_TOKEN | Hugging Face Inference |
| `kilocode` | KILOCODE_API_KEY | KiloCode gateway |
| `ai-gateway` | AI_GATEWAY_API_KEY | Vercel AI Gateway |
| `custom` | Varies | Any OpenAI-compatible endpoint |

Aliases: `lmstudio`, `ollama`, `vllm`, `llamacpp` all map to `custom`.

### Environment Variables

Key env vars from `.env.example`:

| Variable | Purpose |
|----------|---------|
| `OPENROUTER_API_KEY` | Primary LLM access |
| `LLM_MODEL` | Default model (e.g. anthropic/claude-opus-4.6) |
| `ANTHROPIC_API_KEY` | Direct Anthropic access |
| `GLM_API_KEY` | z.ai / ZhipuAI |
| `KIMI_API_KEY` | Moonshot AI |
| `MINIMAX_API_KEY` | MiniMax |
| `HF_TOKEN` | Hugging Face |
| `EXA_API_KEY` | Exa web search |
| `FIRECRAWL_API_KEY` | Firecrawl web extraction |
| `FAL_KEY` | Image generation |
| `HONCHO_API_KEY` | Cross-session memory |
| `BROWSERBASE_API_KEY` | Browser automation |
| `BROWSERBASE_PROJECT_ID` | Browserbase project |
| `VOICE_TOOLS_OPENAI_KEY` | Whisper STT + OpenAI TTS |
| `GROQ_API_KEY` | Groq Whisper STT |
| `TERMINAL_TIMEOUT` | Command timeout (default: 60) |
| `TERMINAL_LIFETIME_SECONDS` | Env cleanup timeout (default: 300) |
| `SLACK_BOT_TOKEN` | Slack bot |
| `SLACK_APP_TOKEN` | Slack socket mode |
| `DISCORD_IGNORE_NO_MENTION` | Skip non-mention messages |
| `GATEWAY_ALLOW_ALL_USERS` | Open access (default: false) |
| `HERMES_HUMAN_DELAY_MODE` | Response pacing (off/natural/custom) |
| `GITHUB_TOKEN` | Skills Hub search/install |

### Terminal Backends

| Backend | Description |
|---------|-------------|
| `local` | Direct execution on host |
| `ssh` | Remote execution via SSH |
| `docker` | Isolated Docker container |
| `singularity` | Singularity/Apptainer (HPC) |
| `modal` | Modal cloud execution |
| `daytona` | Daytona cloud sandboxes |

## MCP Server Mode

Hermes can expose itself as an MCP server:

```bash
hermes mcp serve          # stdio transport
hermes mcp serve --http   # Streamable HTTP transport
```

Exposes conversations, sessions, attachments to MCP-compatible clients (Claude Desktop, Cursor, VS Code).

## Profile System

Each profile is a fully isolated `HERMES_HOME`:

```bash
hermes profile create mybot          # Blank profile
hermes profile create work --clone    # Clone config only
hermes profile create bak --clone-all # Full clone
hermes -p mybot chat                  # Use profile
hermes profile use mybot              # Set default
hermes profile export mybot           # Export for sharing
hermes profile import backup.tar.gz   # Import
```

Token locks prevent two profiles from sharing the same bot credentials.

## Plugin System

```bash
hermes plugins enable <name>    # Enable plugin
hermes plugins disable <name>   # Disable plugin
```

Plugins can inject messages via `ctx.inject_message()`.
