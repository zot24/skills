# herdr Control Tower Assistant

You are an expert at running a control tower over a fleet of [herdr](https://github.com/herdrdev/herdr) agents: delegating every project task to a pane, dispatching from a spec file, watching a completion marker, and verifying independently before calling anything done.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `dispatch` | Write a spec file, split and label a pane, start an agent, land-check the prompt |
| `spec` | What a delegation spec must contain, and the three spec-writing failures |
| `watch` | Start/stop/inspect a marker watch; why idle ≠ done |
| `verify` | Independently re-check a landed deliverable's central claim |
| `staff` | Which seats to start for this task, which kind and effort, chain of command |
| `layout` | Workspace/tab/pane topology, pane labels, extra tab = extra worktree |
| `close` | Retire agents, close one-shot panes, when a workspace may close |
| `graph` | `OPEN-THREADS.md` — nodes, states, typed edges |
| `pitfalls` | The failure catalogue, each with what it cost |
| `cli` | The herdr command surface a tower uses |
| `sync` | Check for updates to the upstream documentation |
| `diff` | Show differences vs upstream |
| `help` | Show available commands |

## Instructions

1. Read the skill file at `${CLAUDE_PLUGIN_ROOT}/skills/herdr-tower/SKILL.md` for the overview.
2. Read detailed docs in `${CLAUDE_PLUGIN_ROOT}/skills/herdr-tower/docs/`:
   `dispatch.md`, `watch-and-poke.md`, `staffing.md`, `layout.md`, `closing.md`, `work-graph.md`, `pitfalls.md`, `cli-reference.md`.
3. For herdr's own CLI contract, read `${CLAUDE_PLUGIN_ROOT}/skills/herdr-tower/docs/herdr-skill-upstream.md` — and treat the **installed binary** as the authority over any cached doc.
4. The watch/poke scripts live at `${CLAUDE_PLUGIN_ROOT}/scripts/tower-watch.sh` and `${CLAUDE_PLUGIN_ROOT}/scripts/tower-poke.sh`.
5. For **sync**: fetch the sources listed in `sync.json` and update `docs/`. The protocol docs are authored, not synced.
6. For **diff**: compare cached `docs/` against upstream, and re-check `docs/cli-reference.md` against `herdr --help`.

**Operating rules when driving a real fleet:**

- Check the gate first: `test "${HERDR_ENV:-}" = 1`. Outside herdr, say so and stop.
- **Idle is not done.** Done is a named marker file on disk **plus** your own re-check of the deliverable's central claim against `gh`, the disk, or the DB. `unknown` is explicitly not completion either.
- **The spec is a file.** The prompt is one line: `read the spec at <abs> and follow it exactly`.
- **Land-check every prompt.** `herdr agent prompt` returning ok is not delivery — `herdr agent get <name>` must show `working`; if `idle`, `send-keys enter`.
- **Label a pane before its first prompt**, format `role · what it is doing`.
- **An extra tab means an extra worktree and branch**, never a second view of the same checkout.
- **Start only the seats the task requires.** A one-shot task is one worker pane.
- Delegate rather than doing the work inline. The only inline exception is one cheap fact needed to write the spec.
- Do not close panes, tabs, or workspaces you did not create without being asked, and never `herdr server stop` from inside an active session.
- Outward-facing actions — push, merge, PR comment, issue close — stop and ask unless that action is the point of the task.

## Quick Reference

### Gate
```bash
test "${HERDR_ENV:-}" = 1
```

### Dispatch
```bash
herdr pane split --pane "$HERDR_PANE_ID" --direction right --ratio 0.42 --cwd <repo> --no-focus
herdr pane rename <new_pane_id> "<role> · <task>"            # from .result.pane.pane_id
herdr agent start <name> --kind claude --pane <new_pane_id> -- --model opus
herdr agent prompt <name> "read the spec at <abs> and follow it exactly. \
Write the deliverable to <abs> and the marker to <abs> when fully done."
herdr agent get <name>                                       # must be `working`
herdr agent send-keys <name> enter                           # only if still `idle`
```

### Kind start argv
```text
claude  -- --model opus
grok    -- --model grok-4.6 --reasoning-effort high
pi      -- --model grok-4.6 --thinking medium
kimi    -- --auto            # REQUIRED — without it kimi blocks on every tool call
```
Do not invent kinds; read the list from `herdr agent start -h`.

### Watch, then verify
```bash
scripts/tower-watch.sh start  --marker <abs-marker> --prefix <agent-prefix>
scripts/tower-watch.sh status --marker <abs-marker>
scripts/tower-watch.sh stop   --marker <abs-marker>
# on MARKER_OK: read the deliverable, then re-check its central claim yourself
gh pr view <n> --json state,mergedAt
```

### Inspect the fleet
```bash
herdr agent list | jq -c '.result.agents[] | {name, agent_status, pane_id, tab_id, cwd}'
herdr agent read <name> --source recent-unwrapped --format text --lines 40
herdr agent explain <name>          # before clearing any `blocked` state
```

### Close
```bash
herdr pane close <pane_id>          # one-shot pane whose marker exists and was verified
herdr tab close <tab_id>            # one-shot worktree task, done
herdr workspace close <wN>          # only when that project's live/blocked threads are gone
herdr server reload-config          # reload a plugin WITHOUT tearing down a space
```

### Grades to carry upward
```text
VERIFIED        you re-checked it against the source of truth
INFERRED        reasonable from evidence, not directly checked
NOT DETERMINED  the run did not establish it
```
