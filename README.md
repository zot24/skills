# AI Agent Skills

An opinionated selection of skills for daily dev workflows.

**Agent Skills Compatible** - All skills follow the [Agent Skills](https://agentskills.io) open format specification.

## Available Skills

| Skill | Description |
|-------|-------------|
| [umbrel-app](./skills/umbrel-app) | Expert assistant for developing, packaging, testing, and submitting apps for umbrelOS |
| [claude-code-expert](./skills/claude-code-expert) | Comprehensive Claude Code & Anthropic ecosystem knowledge. Official patterns for agents, skills, hooks, commands, MCP. |
| [agent-browser](./skills/agent-browser) | Expert on agent-browser - Vercel's headless browser automation CLI for AI agents with 50+ commands, snapshots, and multi-session support |
| [chat-sdk](./skills/chat-sdk) | Expert on Chat SDK - Vercel's open-source template for building production-ready AI chatbots with generative UI, artifacts, and multi-provider support |
| [ai-sdk](./skills/ai-sdk) | Expert on AI SDK - Vercel's TypeScript toolkit for building AI applications with unified LLM API, streaming, tool calling, and agents |
| [agent-skills](./skills/agent-skills) | Expert at the Agent Skills open format for extending AI agent capabilities - create, validate, and understand SKILL.md files |
| [hermes](./skills/hermes) | Expert at understanding and working with Hermes Agent - its memory system, skills, cron jobs, tools, and behavioral conventions |
| [honcho](./skills/honcho) | Expert on Honcho — AI-native memory and context platform for LLM applications with persistent memory, user modeling, and context management |
| [safe-delete](./skills/safe-delete) | Prevents catastrophic file deletion by transforming rm commands to trash and blocking dangerous patterns like `rm -rf /` |
| [x-engagement](./skills/x-engagement) | Crafts high-engagement X (Twitter) content using conversation hijacking, authority building, and strategic hooks |
| [gh-issue-tracker](./skills/gh-issue-tracker) | Install, configure, and manage gh-issue-tracker — lightweight error tracking that creates GitHub Issues with deduplication, fingerprinting, and rate limiting |
| [firecrawl](./skills/firecrawl) | Expert on Firecrawl — web scraping, crawling, search, and browser automation API for AI agents with clean LLM-ready output |
| [servarr](./skills/servarr) | Deploy, configure, and manage the full media stack — Sonarr, Radarr, Lidarr, Prowlarr, Plex, Overseerr, qBittorrent, Bazarr, and Recyclarr |
| [obsidian](./skills/obsidian) | Manage and optimize Obsidian vaults — organization, Dataview, Templater, workflows, MCP integration, plugins, sync, and publishing |
| [adguard](./skills/adguard) | Deploy, configure, and manage AdGuard Home — network-wide DNS ad blocking, filtering, DHCP, client management, and REST API automation |
| [immich](./skills/immich) | Deploy, configure, and manage Immich — self-hosted photo and video management with machine learning, facial recognition, mobile backup, and REST API |
| [glinet](./skills/glinet) | Configure and manage GL.iNet routers — VPN, AdGuard Home, DNS, multi-WAN failover, drop-in gateway, firewall, and network modes |
| [umami](./skills/umami) | Deploy, configure, and manage Umami — open-source privacy-focused web analytics with API client, tracker, events, statistics, and reports |
| [flue](./skills/flue) | Expert on Flue — the open-source TypeScript framework for building durable, autonomous AI agents and workflows on the Pi harness. Write once, deploy anywhere, use any LLM. |
| [wealthfolio](./skills/wealthfolio) | Expert on Wealthfolio — the open-source, private, local-first portfolio & net-worth tracker (desktop, iOS, self-hosted Docker). Concepts, CSV import, self-hosting, and addon development. |
| [1password-cli](./skills/1password-cli) | Expert on the 1Password CLI (`op`) — manage 1Password from the terminal, read/inject secrets with secret references, run op run/op inject, manage items & vaults, service accounts, shell plugins, and the SSH agent. |
| [portainerctl](./skills/portainerctl) | Expert on portainerctl — Portainer's official CLI for driving Portainer Business Edition over its REST API. Auth via API token, environments, stacks, GitOps deploys, containers, Kubernetes, edge, users/teams/RBAC. |

## Installation

### Recommended: install with zskills (Rust CLI package manager)

[`zskills`](https://github.com/zot24/zskills) is a Rust package manager built specifically for managing Claude Code skills — declarative install, multi-marketplace, atomic settings.json round-trip.

```bash
cargo install --git https://github.com/zot24/zskills

zskills marketplace add zot24/skills
zskills install umbrel-app servarr immich    # name resolution is unambiguous
```

Declarative `skills.toml` in any repo or in `~/.config/zskills/`:

```toml
[[skills]]
name = "umbrel-app"
marketplace = "zot24-skills"

[[skills]]
name = "servarr"
marketplace = "zot24-skills"
```

```bash
zskills sync                  # idempotent, applies the manifest
zskills sync --dry-run        # preview changes first
```

### Inside Claude Code (built-in)

```bash
/plugin marketplace add zot24/skills
/plugin install umbrel-app@zot24-skills
```

### Or add to project settings manually

`.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "zot24-skills": {
      "source": { "source": "github", "repo": "zot24/skills" }
    }
  },
  "enabledPlugins": {
    "umbrel-app@zot24-skills": true
  }
}
```

## Usage

Once installed, you can use skills via **slash commands** or **natural language**.

### Slash Commands

Format: `/skill-name:command-name [arguments]`

```bash
# Umbrel app development
/umbrel-app:umbrel scaffold my-app        # Create new app structure
/umbrel-app:umbrel validate ./my-app      # Validate app configuration
/umbrel-app:umbrel convert ./docker-app   # Convert Docker Compose to Umbrel
/umbrel-app:umbrel pr ./my-app            # Generate PR submission
/umbrel-app:umbrel debug ./my-app         # Troubleshoot issues

# Claude Code expertise
/claude-code-expert:claude create agent    # Guide for creating agents
/claude-code-expert:claude create skill    # Guide for creating skills
/claude-code-expert:claude validate ./x    # Validate against best practices
/claude-code-expert:claude features        # Show Claude Code capabilities

# Agent browser automation
/agent-browser:agent-browser open <url>    # Open a webpage
/agent-browser:agent-browser snapshot      # Get element refs
/agent-browser:agent-browser click @e2     # Click by ref
/agent-browser:agent-browser screenshot    # Capture viewport

# Hermes Agent
/hermes:hermes memory                    # How Hermes memory works
/hermes:hermes skills                    # How to create Hermes skills
/hermes:hermes cron                      # Cron job configuration

# Honcho memory platform
/honcho:honcho quickstart                # Get started with Honcho
/honcho:honcho context                   # Context retrieval for LLMs
/honcho:honcho sdk                       # SDK reference

# Safe delete
/safe-delete:safe-delete enable          # Enable trash-based deletion
/safe-delete:safe-delete status          # Check current mode

# Firecrawl web scraping
/firecrawl:firecrawl scrape https://example.com  # Scrape a page
/firecrawl:firecrawl search "AI news"            # Web search
/firecrawl:firecrawl crawl https://docs.site.com # Crawl a site
/firecrawl:firecrawl mcp                         # MCP server setup

# Media stack management
/servarr:servarr setup docker      # Full Docker stack
/servarr:servarr integrate         # Wire up all apps
/servarr:servarr profiles          # TRaSH quality profiles
/servarr:servarr remote            # Laptop→NAS setup

# Immich photo management
/immich:immich setup                  # Docker Compose deployment
/immich:immich backup                 # Database + filesystem backup
/immich:immich library /mnt/photos    # External library setup
/immich:immich upload /path/to/photos # CLI bulk upload
```

### Natural Language

You can also just describe what you want:

```
"Create an Umbrel app for my Docker project"
"Help me package this for umbrelOS"
"How do I create a Claude Code agent?"
"What are the best practices for hooks?"
"Automate browser login with agent-browser"
"How do I use snapshots for element selection?"
"Add persistent memory to my LLM agent with Honcho"
"How do I get user context from Honcho for my chatbot?"
"Write a viral X/Twitter post about AI"
"Set up a safe delete alias so I don't accidentally delete everything"
```

The skills auto-activate based on context.

## Skill Details

### umbrel-app

Full lifecycle support for Umbrel app development:

- **scaffold** - Generate complete app structure
- **validate** - Check against 20+ requirements
- **convert** - Transform Docker Compose to Umbrel format
- **pr** - Generate submission-ready PR content
- **debug** - Troubleshoot issues
- **sync/diff** - Stay updated with upstream docs

```bash
/umbrel-app:umbrel scaffold my-app
/umbrel-app:umbrel validate ./my-app
```

[Full documentation](./skills/umbrel-app/README.md)

### claude-code-expert

Comprehensive Claude Code and Anthropic ecosystem knowledge:

- **create agent/skill/hook/command** - Official patterns and guidance
- **validate** - Check artifacts against official checklists
- **patterns** - Browse available creation patterns
- **features** - Learn about Claude Code capabilities
- **sync/check** - Keep documentation up to date

```bash
/claude-code-expert:claude create agent
/claude-code-expert:claude create skill
/claude-code-expert:claude validate ./my-agent
/claude-code-expert:claude features
```

[Full documentation](./skills/claude-code-expert/README.md)

### agent-browser

Expert on Vercel's browser automation CLI for AI agents:

- **open** - Navigate to webpages
- **snapshot** - Get accessibility tree with element refs
- **click/fill/type** - Interact with elements by ref
- **screenshot** - Capture viewport or full page
- **session** - Manage isolated browser instances
- **network** - Intercept and mock requests
- **sync/diff** - Stay updated with upstream docs

```bash
/agent-browser:agent-browser open https://example.com
/agent-browser:agent-browser snapshot -i
/agent-browser:agent-browser click @e2
/agent-browser:agent-browser screenshot page.png
```

[Full documentation](./skills/agent-browser/README.md)

### chat-sdk

Expert on Vercel's Chat SDK for building production-ready AI chatbots:

- **setup** - Installation and project scaffolding
- **providers** - Configure OpenAI, Anthropic, Google, and other LLM providers
- **ui** - Build generative UI with artifacts
- **streaming** - Implement streaming responses
- **tools** - Define and use tools with LLMs
- **sync/diff** - Stay updated with upstream docs

[Full documentation](./skills/chat-sdk/README.md)

### ai-sdk

Expert on Vercel's AI SDK - TypeScript toolkit for building AI applications:

- **providers** - Unified API across 100+ LLMs
- **streaming** - Streaming text, audio, and image generation
- **tool calling** - Structured tool definitions and execution
- **agents** - Build autonomous agents with memory
- **rags** - Retrieval augmented generation patterns
- **sync/diff** - Stay updated with upstream docs

[Full documentation](./skills/ai-sdk/README.md)

### agent-skills

Expert at the Agent Skills open format specification:

- **create** - Create new SKILL.md files following the spec
- **validate** - Validate skills against the specification
- **spec** - Understand the Agent Skills format
- **best-practices** - Authoring guidelines and patterns
- **integrate** - Add skills to your agent
- **sync/diff** - Stay updated with upstream docs

```bash
/skills-ref validate ./skills/my-skill
```

[Full documentation](./skills/agent-skills/README.md)

### hermes

Expert at understanding and configuring Hermes Agent:

- **memory** - Dual-store memory, Honcho profiles, instruction capture
- **skills** - How skills are created, triggered, and structured
- **cron** - Schedule formats, delivery targets, scheduler architecture
- **tools** - Built-in tool categories and capabilities
- **config** - Configuration files and environment variables
- **conventions** - Communication style and user preferences

```bash
/hermes:hermes memory
/hermes:hermes skills
/hermes:hermes cron
```

[Full documentation](./skills/hermes/README.md)

### honcho

Expert on Honcho — AI-native memory and context platform for LLM applications:

- **quickstart** - Setup and first API calls
- **architecture** - Core data model (workspaces, peers, sessions)
- **context** - Retrieve context for LLM injection
- **peers** - Working with peer representations
- **dreaming** - Autonomous memory consolidation
- **sdk** - Python and TypeScript SDK reference
- **api** - Full REST API reference
- **integrate** - Guides for Claude Code, MCP, LangGraph, Discord, Telegram, and more
- **sync/diff** - Stay updated with upstream docs

```bash
/honcho:honcho quickstart
/honcho:honcho context
/honcho:honcho sdk
/honcho:honcho integrate discord
```

[Full documentation](./skills/honcho/README.md)

### safe-delete

Prevents catastrophic file deletion by intercepting dangerous rm commands:

- **enable** - Activate trash-based deletion (aliases rm to trash-cli)
- **block** - Block patterns like `rm -rf /` or `rm -rf /*`
- **whitelist** - Allow specific directories to be deleted
- **status** - Show current protection state
- **restore** - Recover files from trash

```bash
/safe-delete:safe-delete enable
/safe-delete:safe-delete status
```

[Full documentation](./skills/safe-delete/README.md)

### x-engagement

Crafts high-engagement X (Twitter) content using strategic frameworks:

- **hook** - Write viral-worthy opening hooks
- **authority** - Build authority through strategic content
- **conversation** - Hijack trending conversations
- **thread** - Write viral threads
- **draft** - Generate engagement-optimized posts

```bash
/x-engagement:x-engagement hook "AI agents"
/x-engagement:x-engagement thread "Why most AI projects fail"
```

[Full documentation](./skills/x-engagement/README.md)

### firecrawl

Expert on Firecrawl web scraping, crawling, and data extraction API:

- **scrape** - Extract markdown/HTML/JSON from a single URL
- **search** - Query-based web discovery with content extraction
- **crawl** - Recursively gather content from entire sites
- **map** - Discover all URLs on a website
- **interact** - Browser automation (clicks, forms, navigation)
- **extract** - LLM-powered structured data extraction
- **sdk** - Node, Python, Go, Rust SDK reference
- **mcp** - MCP server setup for Claude/Cursor
- **sync/diff** - Stay updated with upstream docs

```bash
/firecrawl:firecrawl scrape https://example.com
/firecrawl:firecrawl search "AI news"
/firecrawl:firecrawl crawl https://docs.example.com
```

[Full documentation](./skills/firecrawl/README.md)

### servarr

Deploy and manage the complete media automation stack:

- **setup** - Docker Compose for full stack (9 services)
- **configure** - App-specific configuration guides
- **api** - API usage with curl examples for all apps
- **integrate** - Wire up Prowlarr → *arr apps → qBittorrent → Plex
- **profiles** - TRaSH quality profiles via Recyclarr
- **status** - Health check all running instances
- **troubleshoot** - Diagnose common issues
- **add** - Add movies/shows/artists via API
- **request** - Overseerr request workflow
- **remote** - Laptop→NAS management patterns

```bash
/servarr:servarr setup docker
/servarr:servarr integrate
/servarr:servarr add movie "Inception"
/servarr:servarr remote
```

[Full documentation](./skills/servarr/README.md)

### immich

Deploy and manage Immich, a self-hosted photo and video management solution:

- **setup** - Docker Compose deployment guide
- **configure** - Environment variables and settings
- **backup** - Database and filesystem backup/restore
- **library** - External library setup for existing photo directories
- **upload** - CLI bulk upload with album creation
- **api** - REST API usage with curl examples
- **ml** - Machine learning configuration (CLIP, faces, OCR)
- **mobile** - Mobile app setup and backup

```bash
/immich:immich setup
/immich:immich backup
/immich:immich upload /path/to/photos
/immich:immich library /mnt/nas/photos
```

[Full documentation](./skills/immich/README.md)

### glinet

Configure and manage GL.iNet routers (firmware v4.x):

- **setup** - First time setup and internet configuration
- **vpn** - WireGuard, OpenVPN, Tailscale client/server
- **adguard** - Built-in AdGuard Home ad blocking
- **gateway** - Drop-in gateway for existing networks
- **dns** - Encrypted DNS (DoH, DoT, DNSCrypt)
- **multiwan** - Failover and load balancing
- **firewall** - Port forwarding, DMZ, access control
- **storage** - USB/Samba/WebDAV/DLNA

```bash
/glinet:glinet setup
/glinet:glinet vpn wireguard
/glinet:glinet adguard
/glinet:glinet gateway
```

[Full documentation](./skills/glinet/README.md)

### umami

Deploy and manage Umami, a privacy-focused open-source web analytics platform:

- **setup** — Docker Compose, source, and cloud installation
- **api** — `@umami/api-client` TypeScript client for all endpoints
- **track** — Client-side and server-side event tracking
- **stats** — Website statistics, metrics, and active users
- **reports** — Attribution, funnel, retention, journey, revenue, UTM
- **realtime** — Live visitor data
- **teams** — Team and user management

```bash
/umami:umami setup
/umami:umami api getWebsites
/umami:umami track purchase
/umami:umami stats <websiteId>
/umami:umami reports funnel
```

[Full documentation](./skills/umami/README.md)

### flue

Expert on Flue — the open-source TypeScript framework (by the Astro team) for building durable, autonomous AI agents and workflows on the Pi harness:

- **quickstart** — Install, first agent, run locally
- **agent** — Building agents with `createAgent` (harness-driven)
- **workflow** — Authoring deterministic `run(...)` workflows
- **channels** — Verified inbound provider events (Slack, GitHub, Stripe, …)
- **cli** — `init`, `dev`, `run`, `connect`, `build`, `add`, `update`, `logs`, `docs`
- **sdk** — `createFlueClient`, agents, workflows, runs, events
- **api** — Agent, routing, provider, sandbox, and channel APIs
- **deploy** — Cloudflare, AWS, Docker, Fly, Node, Railway, Render, SST, and more
- **sync/diff** — Stay updated with upstream docs

```bash
/flue:flue quickstart
/flue:flue agent
/flue:flue deploy cloudflare
/flue:flue add channel slack
```

[Full documentation](./skills/flue/README.md)

### wealthfolio

Expert on Wealthfolio — the open-source, private, local-first portfolio & net-worth tracker (desktop, iOS, self-hosted Docker):

- **start** — Install & onboarding (download, accounts, first activities)
- **concepts** — Tracking modes, activity types, cost basis & lots, performance metrics
- **import** — CSV import: column mapping, activity types, troubleshooting
- **guide** — Dashboards, accounts, spending & budgets, goals, retirement/FIRE, contribution limits
- **connect** — Wealthfolio Connect broker sync & encrypted multi-device sync
- **ai** — Local AI assistant via Ollama
- **self-host** — Docker, Docker Compose, Unraid, Proxmox, Coolify, reverse proxy
- **addon** — Addon development (getting started, API reference)
- **sync/diff** — Stay updated with upstream docs

```bash
/wealthfolio:wealthfolio start
/wealthfolio:wealthfolio import
/wealthfolio:wealthfolio self-host docker
/wealthfolio:wealthfolio addon getting-started
```

[Full documentation](./skills/wealthfolio/README.md)

### 1password-cli

Expert on the 1Password CLI (the `op` command) for managing 1Password from the terminal and loading secrets into scripts and CI:

- **start** — Install (macOS/Windows/Linux), enable desktop-app integration, first sign-in
- **signin** — Manual sign-in, multiple accounts, biometric unlock
- **secrets** — Secret references (`op://vault/item/field`), `op read`
- **run / inject** — `op run -- <cmd>` and `op inject` for env vars, `.env`, and config files
- **item / vault** — Full CRUD for items and vaults, fields, share links, permissions
- **service-account** — Automation/CI auth via `OP_SERVICE_ACCOUNT_TOKEN`; Connect server
- **plugin** — Shell plugins (`op plugin`) for 80+ third-party CLIs
- **ssh** — 1Password SSH agent, SSH keys, git commit signing
- **sync/diff** — Stay updated with upstream docs

```bash
/1password-cli:1password-cli start
/1password-cli:1password-cli secrets
/1password-cli:1password-cli run
/1password-cli:1password-cli service-account
```

[Full documentation](./skills/1password-cli/README.md)

### portainerctl

Expert on portainerctl — Portainer's official CLI for driving Portainer Business Edition over its REST API:

- **install** — Binary download / build from source; supported Portainer version
- **auth** — API-token (PAT) auth, kubeconfig-style contexts, `PORTAINERCTL_*` env vars for CI
- **environment** — Environments/endpoints, environment groups, tags, snapshots
- **stack** — Deploy Compose/Swarm/Kubernetes stacks from file or Git (GitOps), lifecycle
- **docker / kubernetes** — Containers/images/volumes/networks, Helm, kubectl & docker passthrough
- **edge** — Edge stacks, groups, jobs, configs, update schedules
- **admin** — Users/teams/RBAC, registries, webhooks, backups, licensing, observability
- **sync/diff** — Stay updated with upstream README

```bash
/portainerctl:portainerctl install
/portainerctl:portainerctl auth
/portainerctl:portainerctl stack deploy
/portainerctl:portainerctl environment list
```

[Full documentation](./skills/portainerctl/README.md)

## Adding New Skills

1. Create a new directory under `skills/`:

   ```
   skills/
   └── my-new-skill/
       ├── .claude-plugin/
       │   └── plugin.json
       ├── commands/
       ├── skills/
       ├── sync.json           # Required for CI automation
       └── README.md
   ```

2. Create `sync.json` for automated updates:

   ```json
   {
     "name": "my-new-skill",
     "version": "1.0.0",
     "description": "What it does",
     "sources": [
       {
         "url": "https://example.com/docs.md",
         "target": "skills/my-skill/docs/readme-upstream.md",
         "freshness_days": 14
       }
     ],
     "cache_dir": ".cache"
   }
   ```

3. Add entry to `.claude-plugin/marketplace.json`:

   ```json
   {
     "name": "my-new-skill",
     "source": "./skills/my-new-skill",
     "description": "What it does",
     "version": "1.0.0"
   }
   ```

4. Add skill to CI sync array in `.github/workflows/sync-docs.yml` if it has upstream docs
5. Commit and push

## CI Automation

The repository includes automated workflows for keeping skill documentation up to date.

### Scheduled Sync

Runs bi-weekly (1st and 15th of each month) to check for upstream documentation changes. Only syncs skills with actual upstream documentation sources.

**Manual trigger**: Actions > Sync Skill Documentation > Run workflow

Options:
- `force`: Force sync even without detected changes
- `dry_run`: Check for changes without creating PR

**Skills with CI sync enabled:**
- umbrel-app, claude-code-expert, agent-browser, chat-sdk, ai-sdk, agent-skills, hermes, honcho, firecrawl, servarr, obsidian, adguard, immich, glinet, umami

### Automated Releases (release-please)

This repository uses [release-please](https://github.com/googleapis/release-please) to automate versioning and releases based on [Conventional Commits](https://www.conventionalcommits.org/).

**How it works:**

1. Push commits using conventional format: `feat(skill-name): description`
2. Release-please detects changes and creates a release PR
3. The PR updates versions and CHANGELOG automatically
4. When merged, creates a GitHub release with tag (e.g., `umbrel-app-v1.3.0`)

**Commit types:**

| Prefix | Version Bump | Changelog Section |
|--------|--------------|-------------------|
| `feat` | Minor (1.x.0) | Features |
| `fix` | Patch (1.0.x) | Bug Fixes |
| `docs` | Patch (1.0.x) | Documentation |
| `chore` | None | Hidden |

**Configuration files:**

- `release-please-config.json` - Release settings and package definitions
- `.release-please-manifest.json` - Current versions for each skill

### Configuration

Set custom schedule via repository variable:

```
SYNC_SCHEDULE: "0 6 1,15 * *"  # Cron format
```

## Structure

```
skills/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace manifest
├── .github/
│   ├── scripts/
│   │   └── sync-skill.sh         # Generic sync script
│   └── workflows/
│       ├── sync-docs.yml         # Scheduled sync workflow
│       └── release-on-merge.yml  # Auto-release on PR merge
├── skills/
│   ├── umbrel-app/               # Umbrel app development
│   ├── claude-code-expert/       # Claude Code knowledge base
│   ├── agent-browser/            # Browser automation for AI agents
│   ├── chat-sdk/                 # Vercel Chat SDK
│   ├── ai-sdk/                   # Vercel AI SDK
│   ├── agent-skills/             # Agent Skills specification
│   ├── hermes/                   # Hermes Agent self-knowledge
│   ├── honcho/                   # Honcho AI-native memory platform
│   ├── safe-delete/              # Safe file deletion
│   ├── x-engagement/             # X/Twitter engagement
│   ├── gh-issue-tracker/         # Error tracking via GitHub Issues
│   ├── firecrawl/                # Firecrawl web scraping API
│   ├── servarr/                  # Media stack (*arr suite + Plex)
│   ├── obsidian/                 # Obsidian vault management
│   ├── adguard/                  # AdGuard Home DNS filtering
│   ├── immich/                   # Immich photo/video management
│   ├── glinet/                   # GL.iNet router management
│   └── umami/                    # Umami web analytics
└── README.md
```

## Agent Skills Compatibility

All skills in this repository follow the [Agent Skills](https://agentskills.io) open format specification:

| Requirement | Status |
|-------------|--------|
| Valid `name` field (lowercase, hyphens) | ✓ |
| Name matches directory | ✓ |
| Descriptive `description` with triggers | ✓ |
| SKILL.md under 500 lines | ✓ |
| Progressive disclosure pattern | ✓ |
| References in docs/ folder | ✓ |

### Specification Compliance

- **SKILL.md format**: YAML frontmatter + Markdown body
- **Progressive disclosure**: Metadata → Instructions → References (docs/)
- **Directory structure**: `skills/<name>/skills/<name>/SKILL.md`
- **Token efficiency**: Main skills ~100 lines, detailed docs loaded on-demand

### Validate with skills-ref

```bash
pip install skills-ref
skills-ref validate ./skills/umbrel-app/skills/umbrel-app
```

For more information, see [agentskills.io](https://agentskills.io) or the [agent-skills skill](./skills/agent-skills).

## License

MIT
