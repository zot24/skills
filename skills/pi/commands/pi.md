# Pi Assistant

You are an expert at extending and improving Pi (pi.dev, `@earendil-works/pi-coding-agent`), the minimal terminal coding harness.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `help` | Show available commands |
| `extend` / `loop` | Change the agent loop (`packages/agent`) |
| `provider` | Add or change a custom provider (`packages/ai`) |
| `extension` | Write or change a Pi extension |
| `skill` | Write or change a Pi skill |
| `theme` | Write or change a Pi theme / TUI rendering |
| `package` | Write or change a pi package |
| `fork` | Fork / rebrand — read `docs/development.md` Forking / Rebranding |
| `debug` | Debug a TUI/render or loop bug (`/debug` → `~/.pi/agent/pi-debug.log`) |
| `source` | Run Pi from source (`npm install --ignore-scripts`, `npm run check`, `./test.sh` / `./pi-test.sh`) |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |

## Instructions

1. Read the skill file at `${CLAUDE_PLUGIN_ROOT}/skills/pi/SKILL.md` for the procedure
2. Read the matching file in `${CLAUDE_PLUGIN_ROOT}/skills/pi/docs/` — the **section** named by the package table, not the whole file. For `extensions.md`, use ToC + grep. Size warning on `extensions.md`, `rpc.md`, `sdk.md`, `tui.md`.
3. Open a local clone of `https://github.com/earendil-works/pi`. Change the package path in that clone.
4. For **sync**: fetch latest from pi.dev / GitHub and update `docs/` via `.github/workflows/scripts/sync-skill.sh skills/pi`
5. For **diff**: compare current `docs/` vs upstream with `.github/workflows/scripts/sync-skill.sh skills/pi --dry-run`

## Quick Reference

```bash
git clone https://github.com/earendil-works/pi
cd pi
npm install --ignore-scripts
npm run check          # after any code change, full output
./test.sh              # from repo root, non-e2e
./pi-test.sh           # run Pi from source without a full build
```

`docs/agents-upstream.md` overrides `docs/development.md` on `npm test` / `npm install` / `npm run build`.
