# herdr-tower Skill

How to run a **control tower** over a fleet of [herdr](https://github.com/herdrdev/herdr) agents. herdr (Apache-2.0, `herdrdev/herdr`) gives every coding agent a real terminal pane on a background server and exposes the session over a CLI and socket API. This skill is the operating protocol for the agent that drives the others.

herdr ships its own skill teaching the CLI. This one teaches the part herdr cannot: **how not to be lied to by your own fleet.**

## The load-bearing rules

1. **Idle is not done.** `idle` is a terminal state, not a task state — equally true of an agent that finished, crashed, refused, or answered the wrong question. `unknown` explicitly does not prove completion. Done is a **named marker file on disk** plus your own re-check of the deliverable's central claim against `gh`, the disk, or the DB.
2. **The spec is a file.** Prompts get truncated and echoed; files do not. The prompt is one line: `read the spec at <abs> and follow it exactly`.
3. **Watch the marker, then poke.** A background poller waits on the marker path and prompts the tower when it lands. Never hook agent `idle`.
4. **Name every pane** before its first prompt, `role · what it is doing`. **An extra tab means an extra worktree and branch**, never a second view of the same checkout.
5. **Close when finished.** Close one-shot panes whose marker exists and was verified. Close a workspace only when that project's live and blocked threads are gone or deferred in writing. Do not `/exit` a whole space to pick up a plugin — `herdr server reload-config` and restart only the panes that must reload.
6. **Land-check every prompt.** `herdr agent prompt` returning ok is not delivery: a long payload can be backgrounded and killed while `send-keys` still returns `"ok"`. `herdr agent get` must show `working`.
7. **kimi starts with `--auto`**, or it blocks on every tool call and looks idle. Do not invent agent kinds — read the list from `herdr agent start -h`.

## What This Skill Covers

- **Dispatch** — the spec file, what a spec must contain (including the "Not yet specified" section that is the opposite of "Out of scope"), Phase A / Phase B splitting, start argv per kind, and the land-check
- **Watch & verify** — why `idle`, pane regexes, and idle hooks all fail as completion signals; the marker poll; the poke; and how to independently re-check a landed claim
- **Staffing** — the role graph (PM · mentor · worker · adversary · reviewer · scout · QA), which seats are required versus conditional, chain of command, when QA is mandatory, and how to time-box an autonomous loop
- **Layout** — workspaces, tabs, panes, pane labels, and why an extra tab means an extra worktree
- **Closing** — retiring agents (the three conditions), one-shot panes, when a workspace may close, and what never to close
- **Work graph** — `OPEN-THREADS.md`, node states, typed edges, and the single owner queue
- **Pitfalls** — the failure catalogue, each entry with what it actually cost
- **CLI reference** — the herdr surface a tower uses, checked against v0.7.5

## Usage

```
/herdr-tower help                # Show available commands
/herdr-tower dispatch            # Spec -> pane -> agent -> land-check
/herdr-tower spec                # What a delegation spec must contain
/herdr-tower watch               # Marker watching; why idle != done
/herdr-tower verify              # Independently re-check a landed deliverable
/herdr-tower staff               # Which seats to start for this task
/herdr-tower layout              # Tabs, panes, labels, worktrees
/herdr-tower close               # Retiring agents and closing spaces
/herdr-tower graph               # OPEN-THREADS nodes and edges
/herdr-tower pitfalls            # The failure catalogue
/herdr-tower cli                 # herdr command surface
/herdr-tower sync                # Update docs from upstream
```

## Scripts

`scripts/tower-watch.sh` and `scripts/tower-poke.sh` implement the watch/poke loop, ported from a live control tower and genericised. They cost nothing to run — one `stat` and one `herdr agent list` per tick, no model tokens.

```bash
scripts/tower-watch.sh start  --marker <abs-marker> --prefix <agent-prefix> [--interval 120]
scripts/tower-watch.sh once   --marker <abs-marker> --prefix <agent-prefix>
scripts/tower-watch.sh status --marker <abs-marker>
scripts/tower-watch.sh stop   --marker <abs-marker>
```

On `MARKER_OK` the watcher calls `tower-poke.sh`, which prompts the tower's own agent with one line and then land-checks it. Configure with `TOWER_ROOT` (state lives in `$TOWER_ROOT/scratchpad/watch/`), `TOWER_AGENT` (default `tower`), and `TOWER_KIND` (fallback match by kind + cwd, default `claude`). Both scripts no-op safely when `HERDR_ENV != 1`.

## Documentation Sources

Two files under `skills/herdr-tower/docs/` are **synced** from the canonical upstream repo [herdrdev/herdr](https://github.com/herdrdev/herdr) on `master`: `readme-upstream.md` and `herdr-skill-upstream.md` (herdr's own bundled agent skill, the authority on the CLI contract and lifecycle states).

Everything else is **authored for this skill and deliberately not synced** — there is no upstream for it. `dispatch.md`, `watch-and-poke.md`, `staffing.md`, `layout.md`, `closing.md`, `work-graph.md`, and `pitfalls.md` distil the operating doctrine of a private control tower running a multi-project fleet. `cli-reference.md` is authored from the installed binary and verified against herdr 0.7.5; re-check it with `herdr --help` after a herdr update rather than fetching it.

## Notes

- **The installed binary is the authority** for CLI syntax. Group listings (`herdr agent`, `herdr pane`) and `-h` on a leaf command are cheap; but never probe a *mutating* leaf by omitting arguments — `herdr workspace create` is valid with defaults and will execute. Never run bare `herdr` for discovery; it launches or attaches the TUI.
- **Every rule in `pitfalls.md` was paid for once.** They are written with their incident attached, because a rule without its cost gets optimised away by the next agent that reads it.
- This skill is about operating a fleet, not installing herdr. Install is one line from [herdr.dev](https://herdr.dev).

## Sync

```bash
# Sync this skill's docs from upstream
.github/workflows/scripts/sync-skill.sh skills/herdr-tower

# Force refresh (ignore freshness check)
.github/workflows/scripts/sync-skill.sh skills/herdr-tower --force

# Dry run
.github/workflows/scripts/sync-skill.sh skills/herdr-tower --dry-run
```

## Upstream

- **Repository**: https://github.com/herdrdev/herdr
- **Documentation**: https://herdr.dev/docs/ · [socket API](https://herdr.dev/docs/socket-api/) · [agent skill](https://herdr.dev/docs/agent-skill/)
- **License**: Apache-2.0
