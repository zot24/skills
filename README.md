# AI Agent Skills

An opinionated selection of skills for daily dev workflows.

**Agent Skills Compatible** - All skills follow the [Agent Skills](https://agentskills.io) open format specification.

## Available Skills

| Skill | Description |
|-------|-------------|
| [umbrel-app](./skills/umbrel-app) | Expert assistant for developing, packaging, testing, and submitting apps for umbrelOS |
| [claude-code-expert](./skills/claude-code-expert) | Comprehensive Claude Code & Anthropic ecosystem knowledge. Official patterns for agents, skills, hooks, commands, MCP. |
| [openclaw](./skills/openclaw) | Expert on OpenClaw (formerly Clawdbot) - AI assistant framework connecting Claude/LLMs to messaging platforms (WhatsApp, Telegram, Discord, Slack, Signal, iMessage, Teams, Google Chat, Matrix, BlueBubbles, Zalo) |
| [agent-browser](./skills/agent-browser) | Expert on agent-browser - Vercel's headless browser automation CLI for AI agents with 50+ commands, snapshots, and multi-session support |
| [chat-sdk](./skills/chat-sdk) | Expert on Chat SDK - Vercel's open-source template for building production-ready AI chatbots with generative UI, artifacts, and multi-provider support |
| [ai-sdk](./skills/ai-sdk) | Expert on AI SDK - Vercel's TypeScript toolkit for building AI applications with unified LLM API, streaming, tool calling, and agents |
| [agent-skills](./skills/agent-skills) | Expert at the Agent Skills open format for extending AI agent capabilities - create, validate, and understand SKILL.md files |
| [hermes](./skills/hermes) | Expert at understanding and working with Hermes Agent - its memory system, skills, cron jobs, tools, and behavioral conventions |
| [safe-delete](./skills/safe-delete) | Prevents catastrophic file deletion by transforming rm commands to trash and blocking dangerous patterns like `rm -rf /` |
| [x-engagement](./skills/x-engagement) | Crafts high-engagement X (Twitter) content using conversation hijacking, authority building, and strategic hooks |

## Installation

### Add the Marketplace

```bash
/plugin marketplace add zot24/skills
```

### Install a Skill

```bash
/plugin install umbrel-app@zot24-skills
```

### Or Add to Project Settings

Add to your project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "zot24-skills": {
      "source": {
        "source": "github",
        "repo": "zot24/skills"
      }
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
/umbrel-app:umbrel debug ./my-app        # Troubleshoot issues

# Claude Code expertise
/claude-code-expert:claude create agent    # Guide for creating agents
/claude-code-expert:claude create skill    # Guide for creating skills
/claude-code-expert:claude validate ./x    # Validate against best practices
/claude-code-expert:claude features        # Show Claude Code capabilities

# OpenClaw AI assistant framework
/openclaw:openclaw setup                  # Installation guide
/openclaw:openclaw channel whatsapp       # Configure WhatsApp
/openclaw:openclaw channel telegram        # Configure Telegram
/openclaw:openclaw diagnose               # Troubleshoot issues
/openclaw:openclaw gateway                # Gateway configuration

# Agent browser automation
/agent-browser:agent-browser open <url>    # Open a webpage
/agent-browser:agent-browser snapshot     # Get element refs
/agent-browser:agent-browser click @e2    # Click by ref
/agent-browser:agent-browser screenshot   # Capture viewport

# Hermes Agent
/hermes:hermes memory                    # How Hermes memory works
/hermes:hermes skills                    # How to create Hermes skills
/hermes:hermes cron                      # Cron job configuration

# Safe delete
/safe-delete:safe-delete enable          # Enable trash-based deletion
/safe-delete:safe-delete status          # Check current mode
```

### Natural Language

You can also just describe what you want:

```
"Create an Umbrel app for my Docker project"
"Help me package this for umbrelOS"
"How do I create a Claude Code agent?"
"What are the best practices for hooks?"
"How do I set up WhatsApp with OpenClaw?"
"My Telegram bot isn't receiving messages"
"Automate browser login with agent-browser"
"How do I use snapshots for element selection?"
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

### openclaw

Expert on OpenClaw (formerly Clawdbot) AI assistant framework:

- **setup** - Installation and configuration guide
- **channel** - Configure messaging platforms (WhatsApp, Telegram, Discord, Slack, Signal, iMessage, Teams, Google Chat, Matrix, BlueBubbles, Zalo)
- **diagnose** - Troubleshoot common issues
- **gateway** - Gateway configuration and remote access
- **skills** - Create and manage OpenClaw skills
- **memory** - Memory system configuration
- **sync/diff** - Stay updated with upstream docs

```bash
/openclaw:openclaw setup
/openclaw:openclaw channel whatsapp
/openclaw:openclaw diagnose
```

[Full documentation](./skills/openclaw/README.md)

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
- umbrel-app, claude-code-expert, openclaw, agent-browser, chat-sdk, ai-sdk, agent-skills, hermes

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

**Current versions:**

| Skill | Version |
|-------|---------|
| umbrel-app | 1.3.0 |
| claude-code-expert | 1.0.1 |
| openclaw | 4.0.0 |
| agent-browser | 1.1.0 |

### Configuration

Set custom schedule via repository variable:

```
SYNC_SCHEDULE: "0 6 1,15 * *"  # Cron format
```

## Structure

```
skills/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace manifest (10 skills)
├── .github/
│   ├── scripts/
│   │   └── sync-skill.sh        # Generic sync script
│   └── workflows/
│       ├── sync-docs.yml        # Scheduled sync workflow
│       └── release-on-merge.yml # Auto-release on PR merge
├── skills/
│   ├── umbrel-app/              # Umbrel app development
│   ├── claude-code-expert/      # Claude Code knowledge base
│   ├── openclaw/                # OpenClaw messaging framework
│   ├── agent-browser/           # Browser automation for AI agents
│   ├── chat-sdk/                # Vercel Chat SDK
│   ├── ai-sdk/                  # Vercel AI SDK
│   ├── agent-skills/            # Agent Skills specification
│   ├── hermes/                  # Hermes Agent self-knowledge
│   ├── safe-delete/             # Safe file deletion
│   └── x-engagement/            # X/Twitter engagement
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
