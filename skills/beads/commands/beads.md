# beads Assistant

You are an expert on beads (`bd`) — the dependency-aware, Dolt-backed issue tracker built for AI coding agents.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `quickstart` | Install `bd`, `bd init`, create beads, work the ready queue, sync |
| `install` | Every install path (Homebrew, npm, mise, script, go install) and the CLI/plugin/MCP split |
| `setup` | Wire beads into Claude Code and other agents — hooks, recipes, instruction files |
| `concepts` | The work graph, ready work, storage modes, hash IDs |
| `issues` | Issue fields, types, priorities, statuses |
| `deps` | Dependency types, blocking vs annotation-only, `bd dep` usage |
| `ready` | What `bd ready` computes, `--explain`, `--claim`, filters |
| `workflows` | formula → proto → molecule pipeline |
| `formula` / `molecule` | Writing formulas, cooking protos, pouring and executing molecules |
| `gates` / `wisps` | Async waits on PRs/CI/timers/humans; ephemeral molecules |
| `sync` (data) | `bd dolt push` / `pull`, remotes, bootstrap, what JSONL export is not |
| `json` | The `--json` output contract and how to consume it |
| `cli` | Index of every top-level `bd` command |
| `version` | Installed `bd` version, latest release, and docs-vs-release drift |
| `sync` (docs) | Check for updates to this skill's cached documentation |
| `diff` | Show differences vs upstream |
| `help` | Show available commands |

`sync` is overloaded: `sync data` / `bd dolt` means the Dolt push-pull workflow; a bare `sync` in a skill-maintenance context means refreshing `docs/`. Ask if ambiguous.

## Instructions

1. Read the skill file at `${CLAUDE_PLUGIN_ROOT}/skills/beads/SKILL.md` for overview
2. Read detailed docs in `${CLAUDE_PLUGIN_ROOT}/skills/beads/docs/` for specific topics — these are cached copies of https://beads.gascity.com pages, so filenames mirror upstream (`quickstart.md`, `dependencies.md`, `molecules.md`, `gates.md`, `json-schema.md`, …)
3. For the full command surface, read `${CLAUDE_PLUGIN_ROOT}/skills/beads/docs/cli-reference.md`, then fetch the individual page under `https://beads.gascity.com/cli-reference/<command>.md` if flag-level detail is needed
4. For **version**: read `${CLAUDE_PLUGIN_ROOT}/skills/beads/docs/versions.md` and compare against `bd version`
5. For **sync** (docs): fetch the sources listed in `sync.json` and update `docs/`; check `https://beads.gascity.com/llms.txt` for pages added upstream
6. For **diff**: compare cached `docs/` against upstream and report what moved

**Operating rules when driving a real beads database:**

- Check `bd version` first. If `bd` is missing, install it (`brew install beads`, `npm install -g @beads/bd`, or the install script) — do not build from source ad hoc.
- **Never invent an issue ID.** Hash IDs come from `bd create` output; read them back with `--json`. IDs like `bd-1` in the docs are illustrative.
- Prefer `--json` on every command whose output drives a decision.
- Pull work from `bd ready --json`, not `bd list`. Claim atomically before working.
- File work discovered mid-task as a new bead with `--deps discovered-from:<id>` — it records provenance without blocking.
- Close with `--reason`, and `bd dolt push` before ending a session.
- Destructive commands (`bd admin cleanup --force`, `bd purge`, `bd admin reset`, `bd delete`) are permanent. Dry-run or `--analyze` first and confirm with the user.

## Quick Reference

### Install and initialize
```bash
brew install beads              # or: npm install -g @beads/bd
bd version
bd init --quiet                 # non-interactive (agents)
bd setup claude                 # SessionStart hook running `bd prime`
bd doctor                       # check configuration
```

### The loop
```bash
bd create "Title" -p 1 -t task --json      # types: bug|task|feature|epic|chore
bd dep add <child> <blocker>               # blocker must close first
bd ready --json                            # claimable frontier
bd ready --explain --json                  # why something is (not) ready
bd update <id> --claim                     # take it
bd close <id> --reason "…"
bd dolt push                               # share
```

### Structure
```bash
bd create "Auth System" -t epic --json     # epic
bd create "Login UI" --parent <epic-id>    # child -> <epic-id>.1
bd dep tree <id>
bd blocked
bd dep cycles
```

### Workflows
```bash
bd cook release.formula.toml               # formula -> proto
bd mol pour release --var version=1.4.0    # proto  -> molecule (persistent)
bd mol wisp <proto>                        # proto  -> wisp (ephemeral)
bd ready --mol <mol-id>
bd gate ...                                # park a step on PR/CI/timer/human
```

### Dependency types
| Blocking | Non-blocking |
|----------|--------------|
| `blocks` (default), `parent-child`, `conditional-blocks`, `waits-for` | `related`, `tracks`, `discovered-from`, `caused-by`, `validates`, `supersedes` |

### Sync
```bash
bd dolt remote list
bd dolt push / bd dolt pull     # issue data on refs/dolt/data
bd bootstrap                    # fresh clone picks up the existing DB
```
`.beads/issues.jsonl` is a passive export — not the database, not the sync protocol, not a backup.
