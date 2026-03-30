---
name: hermes
description: Expert at understanding and working with Hermes Agent — its memory system, skills, cron jobs, tools, and behavioral conventions. Use when configuring Hermes, writing skills for it, debugging its behavior, or understanding what it can and cannot do.
trigger: how does hermes work, hermes memory, hermes skills, hermes tools, hermes configuration, hermes capabilities, what can hermes do
---

# Hermes Agent — Self-Knowledge

Hermes is an autonomous AI agent by Nous Research that persists across sessions, builds memory of users, and executes scheduled tasks.

## Core Architecture

- **Memory**: Dual-store — `memory` (agent notes) + `user` (user profile). Persists via Honcho between sessions. Injected as header into every turn.
- **Skills**: Procedural memory at `~/.hermes/skills/{category}/{skill}/SKILL.md`. Auto-loaded when relevant. Converted from experience after complex tasks.
- **Cron Jobs**: Scheduled tasks at `~/.hermes/cron/jobs.json`. Run in isolated sessions. Output saved to `~/.hermes/cron/output/{job_id}/{timestamp}.md`.
- **Tools**: 40+ built-in tools + MCP servers. Discovery at startup, registered in tool registry.

## Memory System

```
══════════════════════════════════════════════
MEMORY (your personal notes) [85% — 1,890/2,200 chars]
══════════════════════════════════════════════
Entries separated by § (section sign)
Entries can be multiline
Capacity % shown so agent knows when to prune
```

**Instruction Capture System**: When user states a preference or correction, ask "Save to instructions?", synthesize to `~/.hermes/instructions.md` (not a literal copy — a refined version).

**Memory commands**:
- `memory_add` — save durable facts
- `honcho_conclude` — write peer profile conclusions
- `session_search` — recall past sessions

## Skills System

Skills trigger automatically based on keywords in the user's request. After a complex task (5+ tool calls), offer to save the approach as a skill.

**Skill structure**:
```
~/.hermes/skills/{category}/{skill-name}/
├── SKILL.md              # Required: frontmatter + instructions
├── references/           # Optional: detailed docs
├── scripts/              # Optional: executable code
└── assets/               # Optional: templates, data
```

**Creating skills**:
1. Complex task succeeded → offer to save
2. Errors overcome → update existing skill
3. User corrected approach → patch immediately
4. Use `skill_manage` with `action=create/patch/edit/delete`

## Cron Jobs

Jobs are defined in `~/.hermes/cron/jobs.json` with fields: `name`, `prompt`, `schedule`, `deliver`, `enabled`.

**Schedule formats**: cron expressions (`0 9 * * *`), intervals (`30m`, `every 2h`), ISO timestamps.

**Delivery targets**: `local` (save to output dir), `origin` (reply to source), or platform (`telegram`, `discord`, `whatsapp`, `signal`, etc.).

**Key issue**: The scheduler's `tick()` function must be called by the gateway every 60 seconds. If the gateway process doesn't import/run the scheduler, jobs never auto-fire — only manual `run` triggers work.

## Tool Categories

| Category | Tools |
|----------|-------|
| Terminal | `terminal`, `process` — run shell commands, manage background jobs |
| Files | `read_file`, `write_file`, `patch`, `search_files` |
| Browser | `browser_navigate`, `browser_snapshot`, `browser_click`, `browser_vision` |
| Web | `web_search`, `web_extract` |
| Cron | `cronjob` — create, list, run, pause, remove scheduled jobs |
| Memory | `memory`, `honcho_conclude`, `session_search` |
| Skills | `skill_manage`, `skill_view`, `skills_list` |
| Code | `execute_code` — Python script with hermes_tools |
| Delegation | `delegate_task` — spawn subagents for isolated parallel work |
| Vision | `vision_analyze` — AI image analysis |
| TTS | `text_to_speech` — convert text to audio |

## Key Conventions

- **Communication style**: Concise, direct. Code speaks louder than words.
- **Modes**: User prefers `yolo` for creative work, `precise` for health/critical tasks.
- **Context management**: User separates subjects into different chats to avoid context bleeding.
- **Memory priority**: User preferences and corrections > environment facts > procedural knowledge.
- **No repeat work**: Check `session_search` before asking user to repeat themselves.

## Documentation

Reference docs cached locally from upstream:

### Getting Started
- **[Installation](skills/hermes/docs/installation.md)** - Setup and install
- **[Quickstart](skills/hermes/docs/quickstart.md)** - First steps
- **[Learning Path](skills/hermes/docs/learning-path.md)** - Guided learning

### User Guide
- **[CLI](skills/hermes/docs/cli.md)** - Command-line interface
- **[Configuration](skills/hermes/docs/configuration.md)** - Config options
- **[Messaging](skills/hermes/docs/messaging.md)** - Messaging platforms
- **[Profiles](skills/hermes/docs/profiles.md)** - Running multiple agents
- **[Security](skills/hermes/docs/security.md)** - Security model

### Features
- **[Tools](skills/hermes/docs/tools.md)** - Built-in tools
- **[Memory](skills/hermes/docs/memory.md)** - Memory system
- **[Skills](skills/hermes/docs/skills.md)** - Skills system
- **[MCP](skills/hermes/docs/mcp.md)** - MCP integration
- **[Voice Mode](skills/hermes/docs/voice-mode.md)** - Voice interaction
- **[Personality](skills/hermes/docs/personality.md)** - Personality customization
- **[Context Files](skills/hermes/docs/context-files.md)** - Context file system
- **[Cron](skills/hermes/docs/cron.md)** - Scheduled tasks

### Guides
- **[MCP Guide](skills/hermes/docs/guide-mcp.md)** - Using MCP with Hermes
- **[Voice Guide](skills/hermes/docs/guide-voice-mode.md)** - Voice mode guide
- **[Tips](skills/hermes/docs/tips.md)** - Usage tips

### Reference
- **[CLI Commands](skills/hermes/docs/cli-commands.md)** - Full command reference
- **[FAQ](skills/hermes/docs/faq.md)** - Frequently asked questions
- **[Architecture](skills/hermes/docs/architecture.md)** - System architecture
- **[Source Reference](skills/hermes/docs/source-reference.md)** - Repo structure, all tools, toolsets, platforms, config sections, env vars
- **[Config Reference](skills/hermes/docs/config-reference.md)** - Full cli-config.yaml.example
- **[Env Reference](skills/hermes/docs/env-reference.md)** - Full .env.example

### Upstream
- Docs: https://hermes-agent.nousresearch.com/docs
- Repo: https://github.com/NousResearch/hermes-agent
- Skills spec: https://agentskills.io
