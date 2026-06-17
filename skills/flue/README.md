# Flue Skill

Expert knowledge about [Flue](https://flueframework.com) — the open-source TypeScript framework (by the Astro team) for building durable, autonomous AI agents and workflows on the Pi harness. *Write once, deploy anywhere, use any LLM.*

## What This Skill Covers

- **Core concepts**: agents (harness-driven), workflows, durable execution, channels, tools, skills, subagents, MCP
- **Guides**: building agents, workflows, routing, models, database, sandboxes, observability, project layout, React hooks, and per-target setup (Cloudflare, Node)
- **CLI**: `init`, `dev`, `run`, `connect`, `build`, `add`, `update`, `logs`, `docs`
- **SDK**: `createFlueClient`, `client.agents`, `client.workflows`, `client.runs`, events, errors
- **API reference**: agent, routing, provider, sandbox, data-persistence, errors, and all channel APIs
- **Ecosystem**: 10 deploy targets, 17 channels, 10 sandboxes, 8 databases, 3 observability tools
- **Configuration**: `flue.config.ts`

## Usage

```
/flue help                  # Show available commands
/flue quickstart            # Install, first agent, run locally
/flue agent                 # Building agents with createAgent
/flue workflow              # Authoring deterministic workflows
/flue cli connect           # CLI reference for a command
/flue sdk                   # SDK reference
/flue api routing-api       # API reference for a resource
/flue deploy cloudflare     # Deploy guide
/flue add channel slack     # Explain flue add blueprints
/flue sync                  # Update docs from upstream
```

## Documentation Sources

All documentation is synced from [flueframework.com](https://flueframework.com/docs) and cached under `skills/flue/docs/`, mirroring the upstream URL structure (`docs/guide/`, `docs/cli/`, `docs/sdk/`, `docs/api/`, `docs/ecosystem/...`).

The `discover-pages.sh` script detects new upstream pages not yet tracked in `sync.json`.

## Sync

```bash
# Check for new upstream pages
./skills/flue/discover-pages.sh

# Auto-add new pages to sync.json
./skills/flue/discover-pages.sh --auto-add

# Sync all documentation
.github/workflows/scripts/sync-skill.sh skills/flue --force
```
