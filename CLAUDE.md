# Skills Development Guide

This repository contains AI agent skills for various development workflows.

For day-to-day install / enable / migrate operations, use [`zskills`](https://github.com/zot24/zskills) — a Rust package manager for Claude Code skills. The `skills.toml` at the repo root is the declarative manifest for `zskills sync`.

## Project Structure

```
skills/
├── .claude-plugin/
│   └── marketplace.json      # Marketplace manifest
├── .github/
│   ├── scripts/
│   │   └── sync-skill.sh   # Generic sync script
│   └── workflows/
│       ├── sync-docs.yml    # Scheduled sync workflow (all skills)
│       └── release-on-merge.yml
├── skills/
│   ├── umbrel-app/           # Umbrel app development
│   ├── claude-code-expert/   # Claude Code knowledge base
│   ├── agent-browser/        # Browser automation for AI agents
│   ├── agent-skills/         # Agent Skills format specification
│   ├── chat-sdk/             # Vercel Chat SDK
│   ├── ai-sdk/               # Vercel AI SDK
│   ├── safe-delete/          # Safe file deletion
│   ├── x-engagement/         # X/Twitter engagement
│   ├── hermes/               # Hermes Agent self-knowledge
│   ├── honcho/               # Honcho AI-native memory platform
│   ├── firecrawl/            # Firecrawl web scraping API
│   ├── gh-issue-tracker/     # GitHub Issues error tracking
│   ├── servarr/              # Media stack (*arr suite + Plex)
│   ├── obsidian/             # Obsidian vault management
│   ├── adguard/              # AdGuard Home DNS filtering
│   ├── immich/               # Immich photo/video management
│   ├── glinet/               # GL.iNet router management
│   ├── umami/                # Umami web analytics
│   ├── flue/                 # Flue open agent framework
│   ├── wealthfolio/          # Private local-first portfolio tracker
│   ├── 1password-cli/        # 1Password CLI (op) secrets management
│   └── portainerctl/         # Portainer CLI (Business Edition)
└── README.md
```

---

## Skill Architecture (IMPORTANT)

All skills MUST follow the **Progressive Disclosure Pattern** from the [Agent Skills specification](https://agentskills.io).

### Progressive Disclosure Pattern

This pattern optimizes token usage by loading content on-demand:

| Level | Location | When Loaded | Token Impact |
|-------|----------|-------------|--------------|
| **Level 1** | SKILL.md frontmatter | Skill discovery | Zero until activated |
| **Level 2** | SKILL.md content | Skill activation | ~500-1000 tokens |
| **Level 3** | docs/*.md files | On-demand reference | Only when needed |

### Standardized Skill Structure

```
skills/<skill-name>/
├── .claude-plugin/
│   └── plugin.json           # Skill metadata
├── commands/
│   └── <skill-name>.md       # Slash command entry point
├── skills/<skill-name>/
│   ├── SKILL.md              # MINIMAL: ~100 lines, summary + references
│   └── docs/                 # DETAILED: cached upstream documentation
│       ├── installation.md
│       ├── commands.md
│       ├── <topic>.md
│       └── readme-upstream.md  # Raw upstream README
├── sync.json                 # CI sync configuration
├── .gitignore                # Excludes .cache/ only
└── README.md                 # User-facing documentation
```

### SKILL.md Template (~100 lines max)

```markdown
---
name: <skill-name>
description: Specific description with trigger keywords. Use when user wants to <action>. Triggers on mentions of <keywords>.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# <Skill Name>

Brief expert statement.

## Overview

4-6 bullet points of key capabilities.

## Quick Start

Minimal code example (5-10 lines).

## Core Concepts

Brief explanation of 2-3 key concepts.

## Documentation

Reference links to docs/ files:

- **[Installation](docs/installation.md)** - Setup instructions
- **[Commands](docs/commands.md)** - Full reference
- **[Topic](docs/topic.md)** - Detailed guide

## Common Workflows

2-3 brief workflow examples.

## Upstream Sources

- **Repository**: <URL>
- **Documentation**: <URL>

## Sync & Update

When user runs `sync`: fetch latest, update docs/ files.
When user runs `diff`: compare current vs upstream.
```

### docs/ Folder Contents

The `docs/` folder contains **cached upstream documentation** that:
- Is fetched from upstream sources
- Is committed to git (NOT gitignored)
- Is updated by CI sync workflow
- Provides detailed reference material

Each file in `docs/` should:
- Have a source URL comment at the top
- Contain the full content from that source
- Be synced via the CI workflow

### commands/<skill-name>.md Template

```markdown
# <Skill Name> Assistant

You are an expert at <domain>.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `<cmd1>` | Description |
| `<cmd2>` | Description |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |
| `help` | Show available commands |

## Instructions

1. Read the skill file at `skills/<skill>/SKILL.md` for overview
2. Read detailed docs in `skills/<skill>/docs/` for specific topics
3. For **sync**: Fetch latest and update docs/ files
4. For **diff**: Compare current vs upstream

## Quick Reference

Brief reference for most common operations.
```

### sync.json Configuration

```json
{
  "name": "<skill-name>",
  "version": "1.0.0",
  "description": "Brief description",
  "sources": [
    {
      "url": "https://raw.githubusercontent.com/<org>/<repo>/main/README.md",
      "target": "skills/<skill>/docs/readme-upstream.md",
      "type": "raw",
      "freshness_days": 14
    },
    {
      "url": "https://<docs-site>/installation",
      "target": "skills/<skill>/docs/installation.md",
      "type": "extract-content",
      "freshness_days": 14
    }
  ],
  "cache_dir": ".cache"
}
```

### .gitignore (Standardized)

```
# Sync cache (temporary comparison files)
.cache/
```

Note: The `docs/` folder is NOT gitignored - it contains committed cached documentation.

---

## Documentation Sync

Each skill syncs documentation from upstream sources.

### Sync Commands

```bash
# Sync a specific skill
.github/workflows/scripts/sync-skill.sh skills/<skill-name>

# Force refresh (ignore cache)
.github/workflows/scripts/sync-skill.sh skills/<skill-name> --force

# Dry run (check without modifying)
.github/workflows/scripts/sync-skill.sh skills/<skill-name> --dry-run
```

### Skill Sources

| Skill | Upstream Source | Sync Type |
|-------|-----------------|-----------|
| umbrel-app | https://github.com/getumbrel/umbrel-apps/blob/master/README.md | URL-based |
| claude-code-expert | Multiple sources via registry.json | Registry-based |
| agent-browser | https://github.com/vercel-labs/agent-browser + https://agent-browser.dev/ | URL-based |
| chat-sdk | https://github.com/vercel/ai-chatbot + https://chat-sdk.dev/ | URL-based |
| ai-sdk | https://github.com/vercel/ai + https://ai-sdk.dev/ | URL-based |
| agent-skills | https://github.com/agentskills/agentskills + https://agentskills.io | URL-based |
| hermes | Hermes Agent docs + operational experience | Hybrid |
| honcho | https://docs.honcho.dev/v3/documentation | URL-based |
| firecrawl | https://docs.firecrawl.dev + https://github.com/mendableai/firecrawl | URL-based |
| gh-issue-tracker | https://github.com/zot24/gh-issue-tracker | Self-contained |
| servarr | https://wiki.servarr.com + https://trash-guides.info + GitHub repos | URL-based |
| obsidian | https://help.obsidian.md + Dataview/Templater docs | URL-based |
| adguard | https://github.com/AdguardTeam/AdGuardHome/wiki | URL-based |
| immich | https://docs.immich.app + https://github.com/immich-app/immich | URL-based |
| glinet | https://docs.gl-inet.com/router/en/4/ | URL-based |
| umami | https://docs.umami.is + https://github.com/umami-software/umami | URL-based |
| flue | https://flueframework.com/docs | URL-based |
| wealthfolio | https://wealthfolio.app/docs | URL-based |
| 1password-cli | https://www.1password.dev/cli + https://app-updates.agilebits.com/product_history/CLI2 | URL-based |
| portainerctl | https://github.com/portainer/portainerctl | Self-contained |
| x-engagement | https://github.com/xai-org/x-algorithm | URL-based |

### When to Sync

1. **Before making changes** - Ensure you have latest upstream documentation
2. **When user reports outdated info** - Run sync with `--force`
3. **Periodically** - CI runs bi-weekly, but manual sync is encouraged

---

## Creating a New Skill

### Step-by-Step

1. **Create directory structure** following the standardized layout:

   ```
   skills/<name>/
   ├── .claude-plugin/
   │   └── plugin.json           # Plugin metadata (required)
   ├── commands/
   │   └── <name>.md             # Slash command entry point (required)
   ├── skills/<name>/
   │   ├── SKILL.md              # ~100 lines, summary + references (required)
   │   └── docs/                 # Cached upstream documentation (required)
   │       ├── <topic>.md
   │       └── ...
   ├── sync.json                 # Sync configuration (required)
   ├── discover-pages.sh         # Auto-discover new upstream pages (optional)
   ├── .gitignore                # Excludes .cache/ only (required)
   └── README.md                 # User-facing documentation (required)
   ```

2. **Write `skills/<name>/skills/<name>/SKILL.md`** (~100 lines max):
   - YAML frontmatter with `name`, `description` (with trigger keywords), `allowed-tools`
   - Quick overview, code examples, and core concepts
   - References to `docs/` files — never duplicate content

3. **Create `docs/` folder** with cached upstream documentation:
   - Fetch all relevant upstream docs
   - Save as individual .md files
   - Add `<!-- Source: URL -->` comment at top of each

4. **Create `commands/<name>.md`** — slash command entry point with command table

5. **Create `.claude-plugin/plugin.json`** — plugin metadata with skill and command paths

6. **Configure `sync.json`** with all upstream sources and `freshness_days`

7. **(Optional) Create `discover-pages.sh`** — recommended for docs sites with `llms.txt` or a crawlable sitemap. This script auto-detects new upstream pages not yet in `sync.json`. The CI workflow calls it before sync if it exists.

8. **Register the skill** (all four places):
   - Add entry to `.claude-plugin/marketplace.json`
   - Add to `SKILLS` array in `.github/workflows/sync-docs.yml` (if skill has upstream docs to sync)
   - Add to skill sources table in this file (`CLAUDE.md`)
   - Add to skills table and details section in `README.md`

> **Note**: Skills without upstream docs (e.g., `safe-delete`) don't need CI sync registration but still need all other files.

### Checklist

#### Required Files
- [ ] `skills/<name>/skills/<name>/SKILL.md` — ~100 lines, references docs/
- [ ] `skills/<name>/skills/<name>/docs/` — Cached upstream documentation
- [ ] `skills/<name>/commands/<name>.md` — Slash command entry point
- [ ] `skills/<name>/sync.json` — Sync configuration (sources can be empty if no upstream)
- [ ] `skills/<name>/.claude-plugin/plugin.json` — Plugin metadata
- [ ] `skills/<name>/.gitignore` — Excludes `.cache/`
- [ ] `skills/<name>/README.md` — User-facing documentation

#### Optional Files
- [ ] `skills/<name>/discover-pages.sh` — Auto-discover new upstream pages (recommended for docs sites)

#### Registration Steps
- [ ] Added to `.claude-plugin/marketplace.json`
- [ ] Added to `SKILLS` array in `.github/workflows/sync-docs.yml` (if has upstream docs)
- [ ] Added to skill sources table in `CLAUDE.md`
- [ ] Added to skills table and details section in `README.md`

---

## Working on Skills

### Before Starting

1. Check current branch
2. Run sync to ensure latest docs
3. Review upstream for recent changes

### Making Changes

1. **SKILL.md changes** - Keep minimal, reference docs/
2. **docs/ changes** - Prefer sync over manual edits
3. **Command changes** - Test command flow locally
4. **New features** - Update README and sync.json

### After Changes

1. Update skill README if user-facing behavior changed
2. Bump version in sync.json if significant
3. Commit with conventional format: `feat(<skill>): description`

---

## Conventions

### Commit Messages

```
feat(<skill>): add new feature
fix(<skill>): fix bug
docs(<skill>): update documentation
chore(<skill>): maintenance task
```

### Version Bumps

- **Patch** (1.0.X): Documentation sync, bug fixes
- **Minor** (1.X.0): New commands/features
- **Major** (X.0.0): Breaking changes

### Labels

PRs should have labels:
- `documentation` - Doc updates
- `automated` - CI-generated PRs
- `<skill-name>` - Skill-specific label

---

## CI Automation

### Sync Workflow

- Runs bi-weekly (1st and 15th of month)
- Syncs all skills in SKILLS array
- Creates PR if changes detected
- Auto-merges with squash

### Manual Trigger

GitHub Actions > Sync Skill Documentation > Run workflow
- Enable `force` to ignore freshness check
- Enable `dry_run` to check without modifying

### Adding New Skill to CI

1. Add skill name to SKILLS array in `.github/workflows/sync-docs.yml`:
   ```yaml
   SKILLS=("umbrel-app" "claude-code-expert" "agent-browser" "<new-skill>")
   ```

2. Ensure sync.json is properly configured with all sources

---

## Best Practices (from Agent Skills Spec)

### Naming Conventions

Use **gerund form** (verb + -ing) for skill names:
- `processing-pdfs` (not `pdf-processor`)
- `analyzing-spreadsheets` (not `spreadsheet-analyzer`)
- `managing-databases` (not `database-manager`)

**Avoid:** Vague names (`helper`, `utils`, `tools`) or reserved words (`anthropic-*`, `claude-*`)

### Writing Descriptions

**Always write in third person** (injected into system prompt):
- Good: "Processes Excel files and generates reports"
- Avoid: "I can help you process Excel files"

**Be specific with trigger keywords:**
```yaml
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
```

### Conciseness

The context window is shared. Only add context the agent doesn't already have.

**Good (~50 tokens):**
```markdown
## Extract PDF text
Use pdfplumber: `pdfplumber.open("file.pdf").pages[0].extract_text()`
```

**Bad (~150 tokens):**
```markdown
## Extract PDF text
PDF (Portable Document Format) files are a common file format...
```

### Avoid Time-Sensitive Information

Use "old patterns" sections instead of dates:
```markdown
## Current method
Use the v2 API endpoint.

## Old patterns
<details>
<summary>Legacy v1 API (deprecated)</summary>
...
</details>
```

### Quality Checklist

Before publishing a skill:
- [ ] Description is specific with trigger keywords
- [ ] SKILL.md body under 500 lines (~100 recommended)
- [ ] Additional details in separate docs/ files
- [ ] No time-sensitive information
- [ ] Consistent terminology throughout
- [ ] File references one level deep
- [ ] Scripts handle errors and list dependencies

---

## Anti-Patterns to Avoid

### DON'T: Put everything in SKILL.md

```markdown
# Bad: 500+ lines in SKILL.md
---
name: my-skill
---

## Section 1
[200 lines of content]

## Section 2
[200 lines of content]

## Section 3
[200 lines of content]
```

### DO: Use progressive disclosure

```markdown
# Good: ~100 lines in SKILL.md with references
---
name: my-skill
---

## Overview
Brief summary.

## Documentation
- **[Section 1](docs/section1.md)** - Detailed guide
- **[Section 2](docs/section2.md)** - Reference
- **[Section 3](docs/section3.md)** - Examples
```

### DON'T: Duplicate content

Having the same information in both SKILL.md AND docs/ files wastes tokens and creates sync issues.

### DO: Single source of truth

- SKILL.md = Summary + references
- docs/ = Detailed content
- SKILL.md references docs/, never duplicates
