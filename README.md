# Claude Plugins

A collection of Claude Code plugins for various development workflows.

## Available Plugins

| Plugin | Description |
|--------|-------------|
| [umbrel-app](./plugins/umbrel-app) | Expert assistant for developing, packaging, testing, and submitting apps for umbrelOS |
| [claude-code-expert](./plugins/claude-code-expert) | Comprehensive Claude Code & Anthropic ecosystem knowledge. Official patterns for agents, skills, hooks, commands, MCP. |

## Installation

### Add the Marketplace

```bash
/plugin marketplace add zot24/claude-plugins
```

### Install a Plugin

```bash
/plugin install umbrel-app@claude-plugins
```

### Or Add to Project Settings

Add to your project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "claude-plugins": {
      "source": {
        "source": "github",
        "repo": "zot24/claude-plugins"
      }
    }
  },
  "enabledPlugins": {
    "umbrel-app@claude-plugins": true
  }
}
```

## Plugin Details

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

[Full documentation](./plugins/umbrel-app/README.md)

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

[Full documentation](./plugins/claude-code-expert/README.md)

## Adding New Plugins

1. Create a new directory under `plugins/`:
   ```
   plugins/
   └── my-new-plugin/
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
     "name": "my-new-plugin",
     "version": "1.0.0",
     "description": "What it does",
     "sources": [
       {
         "url": "https://example.com/docs.md",
         "target": "skills/my-skill/SKILL.md",
         "freshness_days": 14
       }
     ],
     "cache_dir": ".cache"
   }
   ```

3. Add entry to `.claude-plugin/marketplace.json`:
   ```json
   {
     "name": "my-new-plugin",
     "source": "./plugins/my-new-plugin",
     "description": "What it does",
     "version": "1.0.0"
   }
   ```

4. Commit and push

## CI Automation

The repository includes automated workflows for keeping plugin documentation up to date.

### Scheduled Sync

Runs bi-weekly (1st and 15th of each month) to check for upstream documentation changes.

**Manual trigger**: Actions > Sync Plugin Documentation > Run workflow

Options:
- `plugin`: all, umbrel-app, or claude-code-expert
- `force`: Force sync even without detected changes
- `dry_run`: Check for changes without creating PR

### Release Tagging

When sync PRs are merged:
- Bumps patch version in `sync.json`
- Creates git tag (e.g., `umbrel-app-v1.0.1`)
- Creates GitHub release with changelog

### Configuration

Set custom schedule via repository variable:
```
SYNC_SCHEDULE: "0 6 1,15 * *"  # Cron format
```

## Structure

```
claude-plugins/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace manifest
├── .github/
│   ├── scripts/
│   │   └── sync-plugin.sh        # Generic sync script
│   └── workflows/
│       ├── sync-docs.yml         # Scheduled sync workflow
│       └── release-on-merge.yml  # Auto-release on PR merge
├── plugins/
│   ├── umbrel-app/               # Umbrel app development
│   │   ├── sync.json
│   │   └── ...
│   └── claude-code-expert/       # Claude Code knowledge base
│       ├── sync.json
│       └── ...
└── README.md
```

## License

MIT
