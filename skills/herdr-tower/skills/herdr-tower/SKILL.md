---
name: herdr-tower
description: Run a control tower over a fleet of herdr agents — delegate every project task to a pane, dispatch from a spec file, watch a completion marker, and verify independently before calling anything done. Use when operating or staffing a herdr fleet, writing a delegation spec, deciding whether an agent is finished, or closing panes and workspaces. Triggers on mentions of herdr, control tower, tower, fleet, agent pane, marker, land-check, herdr workspace, poke, watch the marker, idle vs done, delegation spec, staffing a project workspace.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# herdr-tower — running a control tower

[herdr](https://github.com/herdrdev/herdr) (Apache-2.0, `herdrdev/herdr`) gives every coding agent a real terminal pane on a background server, and exposes the whole session over a CLI and socket API. A **control tower** is one agent that uses that API to run the others: it writes specs, launches panes, watches for completion, verifies the result, and reports. This skill is the operating protocol for that seat.

herdr itself teaches the CLI — see [herdr's own skill](docs/herdr-skill-upstream.md). This skill teaches the part herdr cannot: **how not to be lied to by your own fleet.**

## Overview

- **Delegate by default.** Project coding, audits, censuses, log reads, judgement against a repo — all of it goes to a pane. Work done inline burns the tower's context, is invisible in the fleet UI, and dies with the session.
- **A spec is a file, not a prompt.** Prompts get truncated and echoed; files do not. The prompt is one line pointing at the spec.
- **Idle is not done.** Done is a named marker file on disk *plus* an independent re-check of the deliverable's central claim. Agent prose is say-so.
- **Watch the marker, then poke.** A background poller waits on the marker path and prompts the tower when it lands. Never hook agent `idle`.
- **Name every pane, and one tab per checkout.** An extra tab means an extra worktree and branch, never a second view of the same `main`.
- **Start only the seats the task requires.** The role menu is not a standing orchestra.

## Quick Start

```bash
test "${HERDR_ENV:-}" = 1                       # tower must live inside herdr

# 1. spec on disk
$EDITOR scratchpad/specs/2026-08-17-thing.md

# 2. pane, labelled before the first prompt
herdr pane split --pane "$HERDR_PANE_ID" --direction right --ratio 0.42 --cwd ~/code/thing --no-focus
herdr pane rename <new_pane_id> "builder · thing"
herdr agent start builder --kind claude --pane <new_pane_id> -- --model opus

# 3. dispatch, then land-check that it actually arrived
herdr agent prompt builder "read the spec at /abs/specs/2026-08-17-thing.md and follow it exactly. \
Write the deliverable to /abs/deliverables/thing.md and the marker to /abs/markers/thing.done when fully done."
herdr agent get builder | jq -r .result.agent.agent_status   # must be working, not idle

# 4. leave the chat — the marker wakes you
scripts/tower-watch.sh start --marker /abs/markers/thing.done --prefix builder
```

## Core Concepts

- **The loop.** Write spec → prompt a pane → start the watch → **stop analysing in this chat** → marker lands → verify → reconvene with one table of every agent, tab, and run. The tower's jobs are specs, launch, land-check, watch, verify, report. It does not do the work.
- **Three grades, preserved upward.** Every load-bearing claim is VERIFIED / INFERRED / NOT DETERMINED. Collapsing the last two is how a gap ships as a conclusion. A report where nothing is ever NOT DETERMINED had a spec that was too loose.
- **Live work is a graph, not a chat.** A new owner ask may add a node or defer one in writing; it never drops a live one. See [work graph](docs/work-graph.md).

## Documentation

- **[Dispatch](docs/dispatch.md)** — the spec file, the eight-step delegation protocol, the guardrails every spec carries, and the three spec-writing failures that cost real work
- **[Watch & poke](docs/watch-and-poke.md)** — why idle ≠ done, marker polling, the land-check, and how to verify a deliverable independently
- **[Staffing](docs/staffing.md)** — the role graph, required vs optional seats, kinds/models/effort, chain of command, and time-boxing an autonomous loop
- **[Layout](docs/layout.md)** — workspaces, tabs, panes, pane labels, and why an extra tab means an extra worktree
- **[Closing](docs/closing.md)** — retiring agents, closing one-shot panes, when a workspace may close, and reloading a plugin without killing a space
- **[Work graph](docs/work-graph.md)** — `OPEN-THREADS.md`, node states, and typed edges
- **[Pitfalls](docs/pitfalls.md)** — the failure catalogue, each with what it actually cost
- **[CLI reference](docs/cli-reference.md)** — the herdr surface a tower uses, verified against v0.7.5
- **[herdr's own skill](docs/herdr-skill-upstream.md)** · **[herdr README](docs/readme-upstream.md)** — upstream, synced

## Common Workflows

- **Dispatch one task.** Spec file → split + rename pane → `agent start` → `agent prompt` → land-check `working` → `tower-watch.sh start` → on `MARKER_OK`, read the deliverable and re-check its central claim against `gh`, the disk, or the DB yourself.
- **Stand up a project workspace.** Start the required seats only (usually PM + mentor + one worker), one tab, roles as splits, every pane labelled `role · what it is doing`. Add reviewer when there is a mergeable diff, QA when a human will click it.
- **Split investigate-and-change.** Phase A is read-only and ends in `STOP`; the owner decides; Phase B is released separately. Discover-and-fix in one uninterrupted run is how an agent fixes the wrong thing confidently.

## Scripts

`scripts/tower-watch.sh` and `scripts/tower-poke.sh` implement the watch/poke loop. Point them at a tower root with `TOWER_ROOT`; both are read-only against product repos and cost nothing to run.

## Upstream Sources

- **Repository**: https://github.com/herdrdev/herdr
- **Documentation**: https://herdr.dev/docs/ · [socket API](https://herdr.dev/docs/socket-api/) · [agent skill](https://herdr.dev/docs/agent-skill/)

## Sync & Update

When the user runs `sync`: re-fetch the upstream README and `skills/herdr/SKILL.md` listed in `sync.json`. The protocol docs are authored, not synced — see `sync.json` notes.
When the user runs `diff`: compare cached `docs/` against upstream, and re-check `docs/cli-reference.md` against the installed `herdr --help`.
