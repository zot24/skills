# Pi Skill

Expert knowledge about [Pi](https://pi.dev) (`@earendil-works/pi-coding-agent`) — the minimal terminal coding harness. Procedure for extending Pi, improving it, adding custom providers, writing extensions / skills / themes / pi packages, forking, and running from source.

## What This Skill Covers

- **Agent loop**: `packages/agent` (`@earendil-works/pi-agent-core`)
- **Providers**: `packages/ai` (`@earendil-works/pi-ai`), including custom providers
- **CLI / TUI / extensions / skills / themes / packages**: `packages/coding-agent`
- **TUI library**: `packages/tui`
- **From source**: `npm install --ignore-scripts`, `npm run check`, `./test.sh`, `./pi-test.sh`
- **Experimental**: `packages/protocol`, `packages/client`, `packages/server`
- **Also in tree**: `packages/evals` (private), `packages/telemetry`, `packages/session-backends/sqlite-node`

## Usage

```
/pi help                  # Show available commands
/pi extend                # Change the agent loop
/pi provider              # Custom provider
/pi extension             # Write a Pi extension
/pi skill                 # Write a Pi skill
/pi theme                 # Write a Pi theme
/pi package               # Write a pi package
/pi fork                  # Fork / rebrand
/pi debug                 # Debug TUI / loop
/pi source                # Run from source
/pi sync                  # Update docs from upstream
```

## Documentation Sources

Documentation is synced from [pi.dev/docs/latest](https://pi.dev/docs/latest) (`extract-content`) and from [earendil-works/pi](https://github.com/earendil-works/pi) (`raw` README / AGENTS.md / CONTRIBUTING.md plus the agent, ai, and tui package READMEs). Cached under `skills/pi/docs/`.

The `discover-pages.sh` script crawls the `/docs/latest` HTML hub and reports pages not yet tracked in `sync.json`. It skips Platform Setup (windows, termux, tmux, terminal-setup, shell-aliases).

## Sync

```bash
# Check for new upstream pages
./skills/pi/discover-pages.sh

# Auto-add new pages to sync.json
./skills/pi/discover-pages.sh --auto-add

# Sync all documentation
.github/workflows/scripts/sync-skill.sh skills/pi --force
```
