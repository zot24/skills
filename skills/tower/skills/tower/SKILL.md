---
name: tower
description: Run a control tower over a fleet of herdr agents — delegate every project task to a pane, dispatch from a spec file, watch a completion marker, and verify independently before calling anything done. Includes acceptance gates — a gates file of CHECK/EXPECT/EVIDENCE outcomes verified by a vendored checker, so a completion marker carries proof and "done" is an exit code instead of a claim. Use when operating or staffing a herdr fleet, writing a delegation spec, deciding whether an agent is finished, writing acceptance criteria, or verifying a delivered job. Use at session start; when the user asks for status, catalog, an unpaid ask, or to reconvene; when choosing a plane; when escalating, handing off, or seating a write on a worktree. Triggers on herdr, control tower, tower, fleet, agent pane, marker, land-check, idle vs done, definition of done, gates file, gate-check, GATES.md, MARKER_OK, CHECK/EXPECT, unlazy, session start, catalog, unpaid ask, reconvene, planes, escalate, handoff, worktree, auto-wiki.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# tower — run the control tower

[herdr](https://github.com/herdrdev/herdr) (Apache-2.0, `herdrdev/herdr`) gives every coding agent a real terminal pane on a background server, and exposes the whole session over a CLI and socket API. A **control tower** is one agent that uses that API to run the others: it writes specs, launches panes, watches for completion, verifies the result, and reports. This skill is the operating protocol for that seat.

herdr itself teaches the CLI — see [herdr's own skill](docs/herdr-skill-upstream.md). This skill teaches the part herdr cannot: **how not to be lied to by your own fleet** — as a session loop, as dispatch discipline, *and* as machine-checked acceptance gates.

**Official vs house.** Install official `herdr` and nvk `wiki-manager` separately. This skill does not replace them. Folded here is house **herdr-fleet** (dispatch/supervise), not the official CLI skill. `docs/herdr-skill-upstream.md` is a synced pointer, not a skill this marketplace maintains.

## Overview

- **Delegate by default.** Project coding, audits, censuses, log reads, judgement against a repo — all of it goes to a pane. Work done inline burns the tower's context, is invisible in the fleet UI, and dies with the session.
- **A spec is a file, not a prompt.** Prompts get truncated and echoed; files do not. The prompt is one line pointing at the spec.
- **Idle is not done.** Done is a named marker file on disk *plus* an independent re-check of the deliverable's central claim. Agent prose is say-so.
- **Watch the marker, then poke.** A background poller waits on the marker path and prompts the tower when it lands. Never hook agent `idle`.
- **Worktree is the default implement seat.** Home stays on `main`. For a write, branch, or PR: `herdr worktree list`, then `open` or `create`. Start the seats the task requires on that worktree workspace. A worktree workspace with no live named seats is not staffed. See [layout](docs/layout.md).
- **Thread in the name.** Agent `<slug>-<N>-<role>` (must match `[a-z][a-z0-9_-]{0,31}`; shorten the slug, not the thread id, if it would overflow). Pane `#<N> · <role> · <task>`. The `#` is the label, never the agent name. See [layout](docs/layout.md).
- **Start only the seats the task requires.** The role menu is not a standing orchestra.
- **A gate that cannot fail is not a gate.** Every spec names a gates file; done means the checker exits 0.
- **Planes.** herdr is the default for project work. Inline is one cheap fact to fill the spec. Other runners are instance config, not this skill. See [dispatch](docs/dispatch.md).
- **Auto-wiki.** A hook on `main` calls `scripts/auto-wiki.py`. It rewrites high-level wiki pages from the git diff. It does not paste the source. See [auto-wiki](docs/auto-wiki.md).

## Quick Start

```bash
test "${HERDR_ENV:-}" = 1                       # tower must live inside herdr

# 1. spec on disk — it names the gates file for the job
$EDITOR scratchpad/specs/2026-08-17-thing.md

# 2. pane, labelled before the first prompt (cwd is the worktree; <N> is the thread id)
herdr pane split --pane "$HERDR_PANE_ID" --direction right --ratio 0.42 --cwd ~/code/thing --no-focus
herdr pane rename <new_pane_id> "#<N> · worker · thing"
herdr agent start <slug>-<N>-worker --kind claude --pane <new_pane_id> -- --model opus

# 3. dispatch, then land-check that it actually arrived
herdr agent prompt builder "read the spec at /abs/specs/2026-08-17-thing.md and follow it exactly. \
Write the deliverable to /abs/deliverables/thing.md and the marker to /abs/markers/thing.done when fully done."
herdr agent get builder | jq -r .result.agent.agent_status   # must be working, not idle

# 4. leave the chat — the marker wakes you
scripts/tower-watch.sh start --marker /abs/markers/thing.done --prefix builder

# 5. accept only through the gates
node scripts/gate-check.mjs --status /abs/gates/thing.md       # exit 0 or it is not done
```

## Core Concepts

- **The loop.** Write spec → prompt a pane → start the watch → **stop analysing in this chat** → marker lands → verify → reconvene with the fleet table of every agent, tab, and run. The tower's jobs are specs, launch, land-check, watch, verify, report. It does not do the work.
- **Three grades, preserved upward.** Every load-bearing claim is VERIFIED / INFERRED / NOT DETERMINED. Collapsing the last two is how a gap ships as a conclusion. A report where nothing is ever NOT DETERMINED had a spec that was too loose.
- **Live work is a graph, not a chat.** A new owner ask may add a node or defer one in writing; it never drops a live one. See [work graph](docs/work-graph.md).

## Daily OS

The outer loop. Dispatch is the inner loop. Details: [operating loop](docs/operating-loop.md).

1. **Session start.** Load the work graph. Read the live map and the status board. Report fleet, queue head, entitled kinds/models, pin file, dispatch blockers. Do not start agents. Do not edit product repos. Completion: one compact decision summary.
2. **Unpaid ask.** Before the reply that starts a new job, settle every ask from the previous owner message: answer it in this reply, or name it parked and why. A pane start does not pay a question. See [work graph](docs/work-graph.md).
3. **catalog.** Same board, entitlement focus. Name entitled vs missing kinds/models. Name pin slots whose kind is missing. Do not go outside the board unless the board cannot answer.
4. **reconvene.** After a marker: verify, then one owner table (Project, Status, What is true, Wrong/gap, You). That is the conversation. Not a running commentary while panes work.

On demand (not session-start steps):

- **Escalate.** An item the tower cannot decide goes to the owner queue after re-verify, or is declined because it is already fixed. Details: [operating loop](docs/operating-loop.md).
- **Handoff.** A handoff note is an output rewritten from live herdr and markers on disk. It is never a source of liveness. Details: [operating loop](docs/operating-loop.md).
- **Closeout.** Route the deliverable into the project's knowledge base, or mark it ephemeral with a reason. Nothing auto-promotes. Details: [operating loop](docs/operating-loop.md).

## Acceptance gates

Reuse **unlazy v2** enforcement via the vendored checker. Do not rebuild it. Do not run unlazy **orchestrated** mode inside a herdr fleet — the space PM owns dispatch.

Every spec names a gates file. Each gate is one observable outcome with `CHECK` / `EXPECT` / `EVIDENCE`. Format: [gate format](docs/gate-format.md). Parent workflow: [gates workflow](docs/workflow.md).

```bash
CHECKER="${CLAUDE_PLUGIN_ROOT}/skills/tower/scripts/gate-check.mjs"
node "$CHECKER" gates/<name>.md             # run unmet checks, flip boxes, write evidence
node "$CHECKER" --status gates/<name>.md    # report only, change nothing
```

Done means `gate-check.mjs --status <gates>` exits **0**. An empty `touch` marker is not done. A checked box with `EVIDENCE: pending` is unmet. A gate you decided not to meet is `ABANDON: <id> <reason>`, not deleted.

- The implementer may run the checker; **the parent re-runs `--status`** before calling anything done.
- A gates file with zero `- [ ] Gn:` checkboxes exits **2**, never ALL MET.
- Do not write a second checker. This one is vendored for that reason.

## Documentation

House leftovers folded here (not six plugins): `herdr-fleet` (HOUSE dispatch, not official herdr), `work-graph`, `space-loop`, `reconvene-table`, `verify-deliverable`, `model-router`, plus **auto-wiki**. Official `herdr` and nvk `wiki-manager` stay separate installs.

- **[Operating loop](docs/operating-loop.md)** — Session start, catalog, unpaid ask, reconvene, Escalate, Handoff, closeout, and the reconvene-table PR verb list
- **[Dispatch](docs/dispatch.md)** — planes, the spec file, the eight-step delegation protocol, and the three spec-writing failures
- **[Watch & poke](docs/watch-and-poke.md)** — why idle ≠ done, marker polling, the land-check, and how to verify a deliverable independently
- **[verify-deliverable](docs/verify-deliverable.md)** — seven-step re-check; verdict pass / partial / fail
- **[Staffing](docs/staffing.md)** — the role graph, required vs optional seats, kinds/models/effort, chain of command, and time-boxing an autonomous loop
- **[space-loop](docs/space-loop.md)** — Loop block in every PM spec; tower never prompts scout/mentor when a PM is live
- **[herdr-fleet](docs/herdr-fleet.md)** — fleet index, `agent read`, pane-record-before-close
- **[model-router](docs/model-router.md)** — board-first RoutingDecision; pin ∩ entitled
- **[Layout](docs/layout.md)** — worktree as the default implement seat, thread in the agent name, pane labels, and why an extra tab means an extra worktree
- **[Closing](docs/closing.md)** — retiring agents, closing one-shot panes, when a workspace may close, and reloading a plugin without killing a space
- **[Work graph](docs/work-graph.md)** — work graph file, unpaid ask, node states, and typed edges
- **[auto-wiki](docs/auto-wiki.md)** — rewrite wiki pages from a git diff; hook calls this package's script
- **[Patterns](docs/patterns/README.md)** — adopted loops (catalog). Auto-wiki is the named adopt.
- **[Pitfalls](docs/pitfalls.md)** — the failure catalogue, each with what it actually cost
- **[CLI reference](docs/cli-reference.md)** — the herdr surface a tower uses, verified against v0.7.5
- **[Gate format](docs/gate-format.md)** — the file shape, `CHECK` / `EXPECT` / `EVIDENCE`, `ABANDON`, and how to write a gate that means something
- **[Checker reference](docs/checker.md)** — CLI flags, exit codes, matching, file discovery, timeouts
- **[Gates workflow](docs/workflow.md)** — spec names the gates, implementer fills them, parent re-runs `--status`
- **[Boundaries and attribution](docs/boundaries.md)** — what the gates take from unlazy, what they refuse, and the licence
- **[herdr's own skill](docs/herdr-skill-upstream.md)** · **[herdr README](docs/readme-upstream.md)** — upstream, synced

## Common Workflows

- **Session start.** Work graph + live map + status board → one compact decision summary. Do not start agents. Then catalog, or dispatch.
- **Dispatch one task.** Spec file (naming its gates) → worktree workspace (not home `main`) → split + rename pane → `agent start` → `agent prompt` → land-check `working` → `tower-watch.sh start` → on `MARKER_OK`, read the deliverable, re-check its central claim against `gh`, the disk, or the DB yourself, and re-run `gate-check.mjs --status` for exit 0.
- **Stand up a project workspace.** Start the required seats only (usually PM + mentor + one worker), one tab, roles as splits, every pane labelled `#<N> · <role> · <task>`. Add reviewer when there is a mergeable diff, QA when a human will click it.
- **Split investigate-and-change.** Phase A is read-only and ends in `STOP`; the owner decides; Phase B is released separately. Discover-and-fix in one uninterrupted run is how an agent fixes the wrong thing confidently.

## Scripts

- `scripts/tower-watch.sh`, `scripts/tower-poke.sh` — the watch/poke loop. Point at a tower root with `TOWER_ROOT`; both are read-only against product repos.
- `scripts/gate-check.mjs` — the acceptance checker. Vendored from Leonxlnx/unlazy (MIT), zero dependencies, Node 16+. Keep the attribution header and [LICENSE.unlazy](LICENSE.unlazy) together; re-vendor by hand per [boundaries](docs/boundaries.md).
- `scripts/auto-wiki.py` — rewrite high-level wiki pages from a git diff. Consumer hook calls this file. Not a copier.

## Upstream Sources

- **Repository**: https://github.com/herdrdev/herdr
- **Documentation**: https://herdr.dev/docs/ · [socket API](https://herdr.dev/docs/socket-api/) · [agent skill](https://herdr.dev/docs/agent-skill/)
- **Checker**: [Leonxlnx/unlazy](https://github.com/Leonxlnx/unlazy/blob/main/scripts/gate-check.mjs), MIT

## Sync & Update

When the user runs `sync`: re-fetch the upstream README and `skills/herdr/SKILL.md` listed in `sync.json`. The protocol docs are authored, not synced — see `sync.json` notes. When the user runs `diff`: compare cached `docs/` against upstream, re-check `docs/cli-reference.md` against the installed `herdr --help`, and re-read `docs/boundaries.md` before changing the checker.
