---
name: wealthfolio
description: Expert on Wealthfolio — the open-source, private, local-first portfolio, investment, and net-worth tracker (desktop, iOS, and self-hosted Docker). Use when tracking accounts/holdings/activities, importing data via CSV, understanding cost basis, performance metrics, or tracking modes, self-hosting via Docker/Unraid/Proxmox/Coolify, configuring Connect broker sync or the AI assistant, or building Wealthfolio addons. Triggers on mentions of Wealthfolio, portfolio tracker, net worth tracker, Wealthfolio Connect, self-hosted finance tracker, wealthfolio addon.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Wealthfolio — Private, Local-First Wealth Tracker

Wealthfolio is an **open-source, private, local-first** portfolio and net-worth tracker. Your financial data stays on your device (or your own server) — no account required, no cloud database, free forever. Pitch: *"the simple, open-source portfolio tracker that keeps your financial data safe."*

## Overview

- **Local-first & private** — data lives in a local autonomous database; nothing leaves your machine unless you opt into Connect.
- **Three forms** — Desktop (macOS Apple Silicon/Intel, Windows x64/ARM64, Linux AppImage), Mobile (iOS now, Android soon), and Self-Hosted Web (Docker, browser access).
- **Core data entry** — manual activities or **CSV import**; the core app has no built-in broker integration.
- **Wealthfolio Connect** (optional paid) — automatic read-only broker sync (30+ institutions) and end-to-end-encrypted multi-device sync.
- **Tracks** — investments across accounts/asset types, cost basis & lots, performance vs. benchmarks, income (dividends/interest), spending & budgets, goals, retirement/FIRE, and contribution limits.
- **Extensible** — a Tauri (Rust + React) app with a developer **addon system** (live-reload dev mode, CLI scaffolding, typed addon API) and a local **AI assistant** (via Ollama).

## Quick Start

```text
1. Download for your OS from https://wealthfolio.app/download (or self-host with Docker).
2. Complete the onboarding wizard.
3. Add accounts (bank / investment / crypto).
4. Add activities manually or via CSV import.
5. Explore dashboards: portfolio value, gain/loss, income, goals.
```

Self-host in one command:

```bash
docker run -d --name wealthfolio -p 8088:8080 \
  -v wealthfolio-data:/data \
  -e WF_CORS_ALLOW_ORIGINS="http://localhost:8088" \
  afadil/wealthfolio:latest
```

## Core Concepts

- **Tracking modes** — *Holdings* (simple: track current positions) vs *Transactions* (full activity history for precise cost basis & realized gains). See [tracking-modes](docs/concepts/tracking-modes.md).
- **Cost basis & lots** — FIFO lot accounting drives realized/unrealized gains. See [cost-basis-and-lots](docs/concepts/cost-basis-and-lots.md).
- **Performance metrics** — TWR vs MWR/money-weighted return, benchmarking. See [performance-metrics](docs/concepts/performance-metrics.md).
- **Market data & FX** — quotes, multi-currency, and custom providers. See [market-data-and-fx](docs/concepts/market-data-and-fx.md).

## Documentation

### Getting started
- **[Introduction](docs/introduction.md)** — what it is, the three platforms, privacy model
- **[Quick Start](docs/quick-start.md)** — install, onboarding, first accounts & activities

### Concepts
- **[Overview](docs/concepts.md)** · **[Tracking Modes](docs/concepts/tracking-modes.md)** · **[Activity Types](docs/concepts/activity-types.md)**
- **[Cost Basis & Lots](docs/concepts/cost-basis-and-lots.md)** · **[Performance Metrics](docs/concepts/performance-metrics.md)** · **[Market Data & FX](docs/concepts/market-data-and-fx.md)**

### User guide
- **[Overview](docs/guide.md)** · **[Dashboards](docs/guide/dashboards.md)** · **[Activities](docs/guide/activities.md)** · **[CSV Import](docs/guide/csv-import.md)** · **[Accounts & Portfolios](docs/guide/accounts.md)**
- **[Spending & Budgets](docs/guide/spending-budgets.md)** · **[Allocation Targets & Rebalancing](docs/guide/allocation-targets.md)** · **[Goals](docs/guide/goals.md)** · **[Retirement & FIRE](docs/guide/retirement-planning.md)** · **[Contribution Limits](docs/guide/contribution-limits.md)**
- **[Market Data Providers](docs/guide/custom-providers.md)** · **[Health Center](docs/guide/health-center.md)** · **[Settings](docs/guide/settings.md)** · **[Export & Backup](docs/guide/data-export.md)**

### Sync & AI
- **[Connect & Broker Sync](docs/guide/connect-broker-sync.md)** · **[AI Assistant (Ollama)](docs/guide/ai-assistant.md)** · **[Mobile](docs/guide/mobile.md)**

### Self-hosting
- **[Overview](docs/guide/self-hosting.md)** · **[Configuration](docs/guide/self-hosting/configuration.md)** · **[Docker](docs/guide/self-hosting/docker.md)** · **[Docker Compose](docs/guide/self-hosting/docker-compose.md)**
- **[Unraid](docs/guide/self-hosting/unraid.md)** · **[Proxmox](docs/guide/self-hosting/proxmox.md)** · **[Coolify](docs/guide/self-hosting/coolify.md)** · **[Reverse Proxy](docs/guide/self-hosting/reverse-proxy.md)**

### Addon development
- **[Getting Started](docs/addons/getting-started.md)** — Node 20+, pnpm, dev mode, CLI scaffolding
- **[API Reference](docs/addons/api-reference.md)** — the typed addon API surface

### Reference
- **[FAQ](docs/faq.md)** · **[Glossary](docs/glossary.md)**

## Common Workflows

- **Import a broker history**: export CSV from your broker → map columns in the [CSV Import](docs/guide/csv-import.md) wizard → review activity types → verify holdings.
- **Self-host for the family**: deploy via [Docker Compose](docs/guide/self-hosting/docker-compose.md), set `WF_CORS_ALLOW_ORIGINS`, front it with a [reverse proxy](docs/guide/self-hosting/reverse-proxy.md).
- **Build an addon**: clone the repo, run addon dev mode (live reload), scaffold with the CLI, code against the [addon API](docs/addons/api-reference.md).

## Upstream Sources

- **Documentation**: https://wealthfolio.app/docs
- **Repository**: https://github.com/wealthfolio/wealthfolio
- **Docker image**: `afadil/wealthfolio` (https://hub.docker.com/r/afadil/wealthfolio)

## Sync & Update

Docs under `docs/` mirror the upstream `wealthfolio.app/docs` URL structure. Run `discover-pages.sh` to detect new upstream pages; run the sync script (or `sync`) to refresh cached docs. On `diff`, compare current docs/ vs upstream.
