# Watch & poke — idle is not done

The single most load-bearing rule in this skill. Distilled from a live tower's `CLAUDE.md`
(delegation protocol steps 3–5), its `herdr-fleet` skill, and `bin/tower-watch.sh` /
`bin/tower-poke.sh`, ported here as `scripts/tower-watch.sh` and `scripts/tower-poke.sh`.

## Why `idle` cannot mean done

herdr's lifecycle states describe a **terminal**, not a task:

| State | What it actually means |
|---|---|
| `working` | the agent is producing output |
| `idle` | the agent is ready for input, and its tab has been seen in the focused UI |
| `done` | the same underlying idle state, after unseen background work finished |
| `blocked` | herdr recognised an approval or question UI |
| `unknown` | an agent is present but herdr cannot classify it — **this does not prove completion** |

An agent is `idle` when it has finished *a turn*. It is equally `idle` when it crashed, refused,
answered the wrong question, hit a permission prompt it then dismissed, or decided the task was
already complete. None of those are done. `unknown` is explicitly not a completion signal, and
`idle` is only reported after the tab has been *seen* — so it is partly a fact about your UI
focus, not about the work.

**Done = a named marker file exists on disk, AND you re-checked the deliverable's central claim
yourself.** Everything else is the agent's say-so.

## Why not a pane regex either

Matching output text for "done" false-positives on the **prompt echo** — the agent's own copy of
your instruction, which contains the word. And an agent on the alternate screen loses the
scrollback entirely, so the string may never reach herdr's buffer at all.

Poll for the file.

## Why not a herdr `idle` hook

Do not wire completion to an agent-state hook. A hook on `idle` fires on every turn boundary,
every permission prompt, and every crash. The marker file is a claim the agent had to
deliberately write after finishing; a state transition is not.

`herdr agent wait --until idle` has the same problem and the same fix: use it to detect that an
agent has *stopped*, never that it has *succeeded*.

## The watch loop

```bash
# cwd: ${CLAUDE_PLUGIN_ROOT}
scripts/tower-watch.sh start  --marker <abs-marker> --prefix <agent-prefix> [--interval 120]
scripts/tower-watch.sh once   --marker <abs-marker> --prefix <agent-prefix>
scripts/tower-watch.sh status --marker <abs-marker>
scripts/tower-watch.sh stop   --marker <abs-marker>
```

`start` backgrounds a poller (default every 120s) that logs the live agents' statuses each tick
and exits the moment the marker file appears. It costs nothing — no model tokens, one `stat`
and one `herdr agent list` per tick. The log and pidfile live under
`$TOWER_ROOT/scratchpad/watch/<sha1-of-marker>.{log,pid}`.

Hand-rolled equivalent, when you want it inline:

```bash
until [ -f "$MARKER" ]; do sleep 30; done
```

Background it. The point of the watch is that the tower is *not* sitting in the chat burning
context while an agent works.

## The poke

On `MARKER_OK`, `tower-watch.sh` calls `tower-poke.sh`, which prompts the **tower's own agent**
with one line:

```
MARKER_OK <marker>. Reconvene now: read the matching deliverable, verify the central
claim, flip the work graph, one status table. Do not restart the job. Idle is not done
— the marker is.
```

That is how a tower hears about a landing without polling in-conversation. `tower-poke.sh`
resolves its target as: the agent literally named `tower`, else the agent whose `cwd` is
`$TOWER_ROOT` and whose kind matches `$TOWER_KIND` — renaming it to `tower` so the next poke is
unambiguous. It refuses to do anything when `HERDR_ENV != 1`.

The poke *starts* the reconvene. It is not the verification. The owner table (Project, Status,
What is true, Wrong/gap, You) lives in [operating loop](operating-loop.md).

## Verify independently — the step everything else exists to protect

Seven-step list (verdict `pass` / `partial` / `fail`): [verify-deliverable](verify-deliverable.md).

After the marker lands, read the deliverable, then **re-check its central claim against the
source of truth yourself**:

| Claim about | Check with |
|---|---|
| GitHub state — PR merged, issue closed, CI green | `gh pr view <n> --json state,mergedAt` |
| A file was written / a config changed | read the file, `git diff` |
| Schema or data | query the DB, not the migration file |
| A deployment or version | the deployed endpoint, not the changelog |
| A test passes | run it |

Agents report confidently and are sometimes wrong. This applies to **anything built from an
agent's output**, including a queue or a summary assembled from other agents' logs — an owner
queue once opened with "a paying customer has been blocked for 15 days, never asked", when the
question had been asked eight days earlier and the bug was fixed and closed that same day. Two
more items in the same queue were equally stale. **A queue built from cold logs manufactures
urgency about finished work**, which costs more than the silence it was meant to fix.

Only after that check does the work-graph node flip to `done`. Marker without verification
leaves it `live`.

## Grading what survives

Carry three grades through the verification, and upward into the report:

- **VERIFIED** — you personally re-checked it against the source of truth
- **INFERRED** — reasonable from evidence, not directly checked
- **NOT DETERMINED** — the run did not establish it

Collapsing INFERRED into VERIFIED is how a gap ships as a conclusion. If a report never says NOT
DETERMINED, the third grade is decorative and the spec was too loose.
