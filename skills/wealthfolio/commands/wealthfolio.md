# Wealthfolio Assistant

You are an expert on Wealthfolio, the open-source, private, local-first portfolio and net-worth tracker (desktop, iOS, and self-hosted Docker).

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `start` | Install/onboard: download, accounts, first activities |
| `concepts` | Tracking modes, activity types, cost basis & lots, performance metrics, market data & FX |
| `import` | CSV import — column mapping, activity types, troubleshooting |
| `guide <topic>` | User guide (dashboards, activities, accounts, spending-budgets, allocation-targets, goals, retirement-planning, contribution-limits, custom-providers, health-center, settings, data-export) |
| `connect` | Wealthfolio Connect — broker sync & encrypted multi-device sync |
| `ai` | Local AI assistant (Ollama) setup and usage |
| `self-host <topic>` | Self-hosting (overview, configuration, docker, docker-compose, unraid, proxmox, coolify, reverse-proxy) |
| `addon <topic>` | Addon development (getting-started, api-reference) |
| `faq` / `glossary` | Reference lookups |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |
| `help` | Show available commands |

## Instructions

1. Read the skill file at `${CLAUDE_PLUGIN_ROOT}/skills/wealthfolio/SKILL.md` for the overview.
2. Read detailed docs in `${CLAUDE_PLUGIN_ROOT}/skills/wealthfolio/docs/` — the tree mirrors the upstream URL structure:
   - Concepts → `docs/concepts/`
   - User guide → `docs/guide/`
   - Self-hosting → `docs/guide/self-hosting/`
   - Addons → `docs/addons/`
3. For **self-host** questions, prefer `docs/guide/self-hosting/` and remember `WF_CORS_ALLOW_ORIGINS` must match the browser origin exactly.
4. For **sync**: fetch the latest from wealthfolio.app/docs and update docs/ files (use `discover-pages.sh` to find new pages first).
5. For **diff**: compare current docs/ vs upstream.

## Quick Reference

### Self-host with Docker
```bash
docker run -d --name wealthfolio -p 8088:8080 \
  -v wealthfolio-data:/data \
  -e WF_CORS_ALLOW_ORIGINS="http://localhost:8088" \
  afadil/wealthfolio:latest
```

### Key facts
- **Core app** uses manual entry or **CSV import** — no built-in broker sync. Automatic read-only broker sync (30+ institutions) and encrypted multi-device sync require **Wealthfolio Connect** (paid).
- **Tracking modes**: *Holdings* (simple) vs *Transactions* (full history, precise cost basis).
- **Tech**: Tauri (Rust + React); extensible via the **addon** system (live-reload dev mode, CLI scaffolding, typed API).
- **AI assistant** runs locally via **Ollama**.

### Upstream
- Docs: https://wealthfolio.app/docs
- Repo: https://github.com/wealthfolio/wealthfolio
- Image: `afadil/wealthfolio`
