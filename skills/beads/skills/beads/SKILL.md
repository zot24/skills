---
name: beads
description: Expert on beads (`bd`) — the dependency-aware, Dolt-backed issue tracker built for AI coding agents that lose context between sessions. Use when installing or initializing bd, creating and closing issues, working the `bd ready` queue, adding dependencies or gates, writing formulas and pouring molecules, syncing with `bd dolt push`/`pull`, or wiring beads into Claude Code and other agents. Triggers on mentions of beads, bd, `bd ready`, `bd create`, `bd dolt`, gastownhall/beads, bead, molecule, formula, wisp, gate, ready queue, Dolt issue tracker, .beads/.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# beads — dependency-aware issue tracker for agents

[beads](https://github.com/gastownhall/beads) (`bd`) stores work as a graph of **beads** (issues) in a version-controlled [Dolt](https://github.com/dolthub/dolt) database. `bd ready` computes the claimable frontier — open issues with no open blockers — so an agent that lost its context can ask *what can I work on right now?* instead of re-reading a rotting plan file. It is not Jira: the graph, not a human dispatcher, decides what is next.

## Overview

- **Ready queue over flat lists** — `bd ready` excludes anything blocked, in progress, deferred, or gated. `bd list --status open` is *not* the same thing.
- **Hash IDs** — `bd-a1b2` is derived from content, not a counter, so concurrent agents and branches never collide and merges never renumber.
- **Typed dependencies** — blocking (`blocks`, `parent-child`, `conditional-blocks`, `waits-for`) vs annotation-only (`discovered-from`, `related`, `tracks`, `caused-by`, …).
- **Workflows** — a **formula** (TOML) is `bd cook`ed into a **proto**, then `bd mol pour`ed into a **molecule** of real beads; **wisps** are the ephemeral variant, **gates** park a step on a PR, CI run, timer, or human sign-off.
- **Dolt sync, not git refs you fight with** — issue data rides `refs/dolt/data` on the existing remote via `bd dolt push` / `bd dolt pull`. `.beads/issues.jsonl` is a passive export, not the database and not a backup.
- **Agent-first output** — nearly every command takes `--json` against a versioned schema contract.

## Quick Start

```bash
brew install beads                 # or: npm install -g @beads/bd
bd init --quiet                    # non-interactive init for agents
bd create "Set up database" -p 1 -t task --json
bd dep add <child-id> <blocker-id> # blocker must close first
bd ready --json                    # the claimable frontier
bd update <id> --claim             # take it atomically
bd close <id> --reason "done"
bd dolt push                       # share with the team
```

## Agent rules

1. **Install `bd` if it is missing** — check `bd version`; if absent use `brew install beads`, `npm install -g @beads/bd`, or the install script. Never hand-roll a `go build`.
2. **Never invent issue IDs.** IDs are hashes minted by `bd create`. Read them back from the command's `--json` output; never guess, extrapolate, or renumber (`bd-1`, `bd-2` in the docs are illustrative only).
3. **Always pass `--json`** when the output feeds a decision — the schema is a stable contract ([json-schema](docs/json-schema.md)).
4. **Work discovered mid-task becomes a bead with provenance**: `bd create "…" --deps discovered-from:<current-id> --json`. It links without blocking.
5. **Ask the graph, do not scan it** — `bd ready --json`, then `bd ready --explain --json` when something you expected is missing.
6. **Close with a reason**, and `bd dolt push` before the session ends or work is lost to the next clone.

## Documentation

### Getting started
- **[Intro](docs/intro.md)** · **[Installation](docs/installation.md)** — every install path, components (CLI / plugin / MCP), platform notes
- **[Quickstart](docs/quickstart.md)** — init, create, depend, ready, claim, close, sync
- **[IDE setup](docs/ide-setup.md)** — `bd setup` recipes, hooks, instruction files
- **[Versions & drift](docs/versions.md)** — authored: which version the docs describe vs the current release

### Core concepts
- **[How beads works](docs/core-concepts.md)** — the graph, ready work, storage modes, the whole model in one page
- **[Issues](docs/issues.md)** · **[Dependencies & gates](docs/dependencies.md)** — fields, types, priorities, edge semantics
- **[Hash IDs](docs/hash-ids.md)** — why IDs are hashes and what that buys concurrent agents
- **[Sync concepts](docs/sync-concepts.md)** — Dolt as source of truth, and what JSONL export is *not*

### Workflows
- **[Workflows](docs/workflows.md)** — formula → proto → molecule in three phases
- **[Formulas](docs/formulas.md)** · **[Molecules](docs/molecules.md)** · **[Gates](docs/gates.md)** · **[Wisps](docs/wisps.md)**

### Reference
- **[CLI reference](docs/cli-reference.md)** — index of every top-level `bd` command
- **[JSON schema contract](docs/json-schema.md)** — the `--json` envelope and per-command fields
- **[Claude Code integration](docs/claude-code.md)** — `bd setup claude`, the SessionStart `bd prime` hook
- **[Upstream README](docs/readme-upstream.md)** — the project's own overview

## Common Workflows

- **Adopt beads in a repo**: `bd init --quiet` → `bd setup claude` (SessionStart hook runs `bd prime`) → seed beads → `bd dolt push`.
- **Work a session**: `bd ready --json` → `bd update <id> --claim` → work → `bd close <id> --reason "…"` → repeat until `bd ready` is empty → `bd dolt push`.
- **Break down an epic**: `bd create "Auth System" -t epic --json`, then `bd create "…" --parent <epic-id>` per child; inspect with `bd dep tree <epic-id>`.
- **Repeatable pipeline**: write `release.formula.toml` → `bd cook release.formula.toml` → `bd mol pour release --var version=X` → `bd ready --mol <mol-id>`.
- **Something you expected is not ready**: `bd ready --explain --json`, then `bd blocked`, `bd dep cycles`, `bd doctor`.

## Upstream Sources

- **Repository**: https://github.com/gastownhall/beads
- **Documentation**: https://beads.gascity.com (every page is served as Markdown; `/llms.txt` is the index)

## Sync & Update

When the user runs `sync`: re-fetch the docs-site Markdown pages and the upstream README listed in `sync.json`, and update `docs/`. Check `/llms.txt` for pages added upstream that are not yet sources.
When the user runs `diff`: compare cached `docs/` against upstream and report what moved — including whether the docs' stated release still lags the latest tag (see [versions](docs/versions.md)).
