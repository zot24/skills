# Wealthfolio Skill

Expert knowledge about [Wealthfolio](https://wealthfolio.app) — the open-source, **private, local-first** portfolio and net-worth tracker. *Keep your financial data on your device, with optional cloud sync via Connect.*

## What This Skill Covers

- **Getting started**: install/onboarding across Desktop (macOS/Windows/Linux), Mobile (iOS), and Self-Hosted Web (Docker)
- **Concepts**: tracking modes (Holdings vs Transactions), activity types, cost basis & lots, performance metrics (TWR/MWR), market data & FX
- **User guide**: dashboards, activities, CSV import, accounts & portfolios, spending & budgets, allocation targets & rebalancing, goals, retirement/FIRE, contribution limits, custom market-data providers, health center, settings, export & backup
- **Sync & AI**: Wealthfolio Connect (broker sync + encrypted multi-device sync), the local AI assistant (Ollama), mobile
- **Self-hosting**: configuration, Docker, Docker Compose, Unraid, Proxmox, Coolify, reverse proxy
- **Addon development**: getting started (Node 20+, pnpm, live-reload dev mode, CLI scaffolding) and the typed addon API reference

## Usage

```
/wealthfolio help                    # Show available commands
/wealthfolio start                   # Install & onboarding
/wealthfolio concepts                # Tracking modes, cost basis, performance
/wealthfolio import                  # CSV import walkthrough
/wealthfolio guide dashboards        # A user-guide topic
/wealthfolio connect                 # Connect broker sync
/wealthfolio self-host docker        # Self-hosting a topic
/wealthfolio addon getting-started   # Addon development
/wealthfolio sync                    # Update docs from upstream
```

## Documentation Sources

All documentation is synced from [wealthfolio.app/docs](https://wealthfolio.app/docs) and cached under `skills/wealthfolio/docs/`, mirroring the upstream URL structure (`docs/concepts/`, `docs/guide/`, `docs/guide/self-hosting/`, `docs/addons/`).

The `discover-pages.sh` script detects new upstream pages not yet tracked in `sync.json`.

## Sync

```bash
# Check for new upstream pages
./skills/wealthfolio/discover-pages.sh

# Auto-add new pages to sync.json
./skills/wealthfolio/discover-pages.sh --auto-add

# Sync all documentation
.github/workflows/scripts/sync-skill.sh skills/wealthfolio --force
```

## Upstream

- **Website / Docs**: https://wealthfolio.app — https://wealthfolio.app/docs
- **Repository**: https://github.com/wealthfolio/wealthfolio
- **Docker image**: [`afadil/wealthfolio`](https://hub.docker.com/r/afadil/wealthfolio)
