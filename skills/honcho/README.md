# Honcho Skill

Expert knowledge about [Honcho](https://honcho.dev) — the AI-native memory and context platform for LLM applications.

## What This Skill Covers

- **Core concepts**: Workspaces, peers, sessions, messages, conclusions, representations
- **Features**: Context retrieval, chat endpoint, dreaming, search, filters, streaming
- **API reference**: All REST endpoints for every resource type
- **CLI**: `honcho-cli` terminal tool for inspecting and debugging workspaces
- **SDKs**: Python and TypeScript SDK usage and examples
- **Integrations**: Claude Code, MCP, LangGraph, CrewAI, Discord, Telegram, and more
- **Self-hosting**: Local development setup and configuration

## Usage

```
/honcho help              # Show available commands
/honcho quickstart        # Get started with Honcho
/honcho architecture      # Core data model
/honcho context           # Using context retrieval
/honcho cli               # CLI reference
/honcho sdk               # SDK reference
/honcho api sessions      # Session API endpoints
/honcho integrate discord # Discord bot guide
/honcho sync              # Update docs from upstream
```

## Documentation Sources

All documentation is synced from [docs.honcho.dev](https://docs.honcho.dev/v3/documentation).

The `discover-pages.sh` script detects new upstream pages not yet tracked in `sync.json`.

## Sync

```bash
# Check for new upstream pages
./skills/honcho/discover-pages.sh

# Auto-add new pages to sync.json
./skills/honcho/discover-pages.sh --auto-add

# Sync all documentation
.github/workflows/scripts/sync-skill.sh skills/honcho --force
```
