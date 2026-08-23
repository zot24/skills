---
name: tower
description: Run a control tower over a fleet of herdr agents — delegate every project task to a pane, dispatch from a spec file, watch a completion marker, and verify independently before calling anything done. Includes acceptance gates — a gates file of CHECK/EXPECT/EVIDENCE outcomes verified by a vendored checker, so a completion marker carries proof and "done" is an exit code instead of a claim. Use when operating or staffing a herdr fleet, writing a delegation spec, deciding whether an agent is finished, writing acceptance criteria, or verifying a delivered job. Triggers on herdr, control tower, tower, fleet, agent pane, marker, land-check, poke, watch the marker, idle vs done, delegation spec, staffing, completion marker, marker file, .done file, mark the job done, report ready, definition of done, GATES.md, gates file, gate table, gate-check, MARKER_OK, EVIDENCE pending, CHECK/EXPECT, unlazy.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# tower — run the control tower

[herdr](https://github.com/herdrdev/herdr) (Apache-2.0, `herdrdev/herdr`) gives every coding agent a real terminal pane on a background server, and exposes the whole session over a CLI and socket API. A **control tower** is one agent that uses that API to run the others: it writes specs, launches panes, watches for completion, verifies the result, and reports. This skill is the operating protocol for that seat.

herdr itself teaches the CLI — see [herdr's own skill](docs/herdr-skill-upstream.md). This skill teaches the part herdr cannot: **how not to be lied to by your own fleet** — as dispatch discipline *and* as machine-checked acceptance gates.

## Overview

- **Delegate by default.** Project coding, audits, censuses, log reads, judgement against a repo — all of it goes to a pane. Work done inline burns the tower's context, is invisible in the fleet UI, and dies with the session.
- **A spec is a file, not a prompt.** Prompts get truncated and echoed; files do not. The prompt is one line pointing at the spec.
- **Idle is not done.** Done is a named marker file on disk *plus* an independent re-check of the deliverable's central claim. Agent prose is say-so.
- **Watch the marker, then poke.** A background poller waits on the marker path and prompts the tower when it lands. Never hook agent `idle`.
- **Name every pane, and one tab per checkout.** An extra tab means an extra worktree and branch, never a second view of the same `main`.
- **Start only the seats the task requires.** The role menu is not a standing orchestra.
- **A gate that cannot fail is not a gate.** Every spec names a gates file; done means the checker exits 0.

## Quick Start

```bash
test "${HERDR_ENV:-}" = 1                       # tower must live inside herdr

# 1. spec on disk — it names the gates file for the job
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

# 5. accept only through the gates (see Acceptance gates below)
node scripts/gate-check.mjs --status /abs/gates/thing.md       # exit 0 or it is not done
```

## Core Concepts

- **The loop.** Write spec → prompt a pane → start the watch → **stop analysing in this chat** → marker lands → verify → reconvene with one table of every agent, tab, and run. The tower's jobs are specs, launch, land-check, watch, verify, report. It does not do the work.
- **Three grades, preserved upward.** Every load-bearing claim is VERIFIED / INFERRED / NOT DETERMINED. Collapsing the last two is how a gap ships as a conclusion. A report where nothing is ever NOT DETERMINED had a spec that was too loose.
- **Live work is a graph, not a chat.** A new owner ask may add a node or defer one in writing; it never drops a live one. See [work graph](docs/work-graph.md).

## Acceptance gates

Reuse **unlazy v2** enforcement via the vendored checker. Do not rebuild it. Do not run unlazy **orchestrated** mode inside a herdr fleet — the space PM owns dispatch.

Before dispatch, the spec names a gates file. Each gate is one observable outcome:

```markdown
- [ ] G1: zot24/skills has an open PR for this work
  CHECK: gh pr list --repo zot24/skills --state open --json title --jq 'map(.title)|join(",")'
  EXPECT: tower
  EVIDENCE: pending
```

`EXPECT` is a substring, or `/regex/flags`. With an `EXPECT`, the match decides and the exit code is ignored — a check may exit non-zero by design. With no `EXPECT`, the exit code decides.

```bash
CHECKER="${CLAUDE_PLUGIN_ROOT}/skills/tower/scripts/gate-check.mjs"

node "$CHECKER" gates/<name>.md             # run unmet checks, flip boxes, write evidence
node "$CHECKER" --status gates/<name>.md    # report only, change nothing
echo $?                                     # must be 0
```

Done means `gate-check.mjs --status <gates>` exits **0**. An empty `touch` marker is not done. A checked box with `EVIDENCE: pending` is unmet.

When no command can prove an outcome, omit `CHECK`. Fill `EVIDENCE:` with a quote, a `file:line`, or a URL. `pending` is still unmet.

A gate you decided not to meet is recorded, not deleted:

```markdown
ABANDON: G3 the upstream API has no endpoint for this
```

An abandoned gate does not block exit 0. It stays visible in the file and in the summary line.

### Gate rules

- The implementer may run the checker; **the parent re-runs `--status`** before calling anything done. Never let the implementer be the only one who ran it.
- A gates file with zero `- [ ] Gn:` checkboxes exits **2**, never ALL MET. Headings are not gates.
- Do not write a second checker. This one is vendored for that reason.

## Documentation

- **[Dispatch](docs/dispatch.md)** — the spec file, the eight-step delegation protocol, the guardrails every spec carries, and the three spec-writing failures that cost real work
- **[Watch & poke](docs/watch-and-poke.md)** — why idle ≠ done, marker polling, the land-check, and how to verify a deliverable independently
- **[Staffing](docs/staffing.md)** — the role graph, required vs optional seats, kinds/models/effort, chain of command, and time-boxing an autonomous loop
- **[Layout](docs/layout.md)** — workspaces, tabs, panes, pane labels, and why an extra tab means an extra worktree
- **[Closing](docs/closing.md)** — retiring agents, closing one-shot panes, when a workspace may close, and reloading a plugin without killing a space
- **[Work graph](docs/work-graph.md)** — `OPEN-THREADS.md`, node states, and typed edges
- **[Pitfalls](docs/pitfalls.md)** — the failure catalogue, each with what it actually cost
- **[CLI reference](docs/cli-reference.md)** — the herdr surface a tower uses, verified against v0.7.5
- **[Gate format](docs/gate-format.md)** — the file shape, `CHECK` / `EXPECT` / `EVIDENCE`, `ABANDON`, and how to write a gate that means something
- **[Checker reference](docs/checker.md)** — CLI flags, exit codes, matching, file discovery, timeouts
- **[Gates workflow](docs/workflow.md)** — spec names the gates, implementer fills them, parent re-runs `--status`
- **[Boundaries and attribution](docs/boundaries.md)** — what the gates take from unlazy, what they refuse, and the licence
- **[herdr's own skill](docs/herdr-skill-upstream.md)** · **[herdr README](docs/readme-upstream.md)** — upstream, synced

## Common Workflows

- **Dispatch one task.** Spec file (naming its gates) → split + rename pane → `agent start` → `agent prompt` → land-check `working` → `tower-watch.sh start` → on `MARKER_OK`, read the deliverable, re-check its central claim against `gh`, the disk, or the DB yourself, and re-run `gate-check.mjs --status` for exit 0.
- **Stand up a project workspace.** Start the required seats only (usually PM + mentor + one worker), one tab, roles as splits, every pane labelled `role · what it is doing`. Add reviewer when there is a mergeable diff, QA when a human will click it.
- **Split investigate-and-change.** Phase A is read-only and ends in `STOP`; the owner decides; Phase B is released separately. Discover-and-fix in one uninterrupted run is how an agent fixes the wrong thing confidently.

## Scripts

- `scripts/tower-watch.sh`, `scripts/tower-poke.sh` — the watch/poke loop. Point at a tower root with `TOWER_ROOT`; both are read-only against product repos.
- `scripts/gate-check.mjs` — the acceptance checker. Vendored from Leonxlnx/unlazy (MIT), zero dependencies, Node 16+. Keep the attribution header and [LICENSE.unlazy](LICENSE.unlazy) together; re-vendor by hand per [boundaries](docs/boundaries.md).

## Upstream Sources

- **Repository**: https://github.com/herdrdev/herdr
- **Documentation**: https://herdr.dev/docs/ · [socket API](https://herdr.dev/docs/socket-api/) · [agent skill](https://herdr.dev/docs/agent-skill/)
- **Checker**: [Leonxlnx/unlazy](https://github.com/Leonxlnx/unlazy/blob/main/scripts/gate-check.mjs), MIT

## Sync & Update

When the user runs `sync`: re-fetch the upstream README and `skills/herdr/SKILL.md` listed in `sync.json`. The protocol docs are authored, not synced — see `sync.json` notes. When the user runs `diff`: compare cached `docs/` against upstream, re-check `docs/cli-reference.md` against the installed `herdr --help`, and re-read `docs/boundaries.md` before changing the checker.
