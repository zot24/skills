# beads Skill

Expert knowledge about [beads](https://github.com/gastownhall/beads) (`bd`) — a dependency-aware, Dolt-backed issue tracker built for AI coding agents that lose their context between sessions. *Create beads → let the graph decide → `bd ready` → claim, close, push.*

## What This Skill Covers

- **Model**: beads (issues) as a version-controlled work graph, hash IDs that never collide across agents or branches, priorities/types/statuses, and what `bd ready` actually computes
- **Dependencies**: blocking types (`blocks`, `parent-child`, `conditional-blocks`, `waits-for`) vs annotation-only types (`discovered-from`, `related`, `tracks`, `caused-by`, …), dependency trees, cycle detection
- **Workflows**: declaring repeatable work as a formula, `bd cook` into a proto, `bd mol pour` into a molecule, ephemeral wisps, and gates that park a step on a PR, CI run, timer, or human decision
- **Sync**: Dolt as the source of truth, `bd dolt push` / `pull` over `refs/dolt/data`, bootstrap on a fresh clone, and why `.beads/issues.jsonl` is a passive export rather than a backup
- **Agent integration**: `bd setup claude` and the SessionStart `bd prime` hook, IDE recipes for other agents, and the stable `--json` output contract
- **Operations**: installing the CLI (Homebrew, npm, mise, install script), `bd doctor`, database migration and compaction, and version-vs-docs drift

## Usage

```
/beads help                # Show available commands
/beads quickstart          # Install, init, create, ready, claim, close, push
/beads install             # Every install path; CLI vs plugin vs MCP
/beads setup               # Wire beads into Claude Code and other agents
/beads concepts            # The work graph, ready work, hash IDs
/beads deps                # Dependency types and bd dep usage
/beads ready               # What bd ready computes, --explain, --claim
/beads workflows           # formula -> proto -> molecule, gates, wisps
/beads json                # The --json output contract
/beads version             # Installed version vs latest release and docs drift
/beads sync                # Update docs from upstream
```

## Documentation Sources

Documentation is synced from the beads docs site and cached under `skills/beads/docs/`. Every page on https://beads.gascity.com is served as Markdown (append `.md`), and `https://beads.gascity.com/llms.txt` is the authoritative index of all pages — check it when adding sources. `sync.json` declares **18 sources**: 17 docs-site pages plus the upstream `README.md` from GitHub.

One file is **authored for this skill and deliberately not synced**: `docs/versions.md`.

## Version Drift (important)

The cached docs describe the **1.1.0** release; the latest published release is **v1.2.2** (2026-08-15) — both **VERIFIED 2026-08-17**. The docs site's own introduction page says so in as many words, so this is upstream drift, not a stale cache. Treat flag-level detail here as approximate for 1.2.x, check `bd version` against the actual binary, and read `docs/versions.md` before an upgrade. Upstream also publishes a recovery page for databases migrated by the accidental **v1.2.1** release.

## Notes

- Beads is installed **system-wide**, not vendored into a project. The `.beads/` directory in a repo holds only the issue database (`.beads/embeddeddolt/` in the default embedded mode).
- `bd ready` is not `bd list --status open`. `list` shows every open issue; `ready` computes the graph and returns only unblocked, unclaimed work.
- Issue IDs are content hashes. An agent must read them back from `--json` output — never invent, guess, or renumber them.
- Destructive commands (`bd admin cleanup --force`, `bd purge`, `bd admin reset`) are permanent; compaction is recoverable only via `bd restore` or Dolt history.

## Sync

```bash
# Sync this skill's docs from upstream
.github/workflows/scripts/sync-skill.sh skills/beads

# Force refresh (ignore freshness check)
.github/workflows/scripts/sync-skill.sh skills/beads --force

# Dry run
.github/workflows/scripts/sync-skill.sh skills/beads --dry-run
```

## Upstream

- **Repository**: https://github.com/gastownhall/beads
- **Documentation**: https://beads.gascity.com (Markdown per page, with `/llms.txt`)
