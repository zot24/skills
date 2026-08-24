# space-loop — PM talks to the roster, not only to the tower

Folded from the former house skill `space-loop`. Not a separate plugin.

## The failure

Every open space has PM + mentor + scout panes. Only the PM ever works. Mentor and scout sit
idle with last week's label. The owner sees empty seats.

This is not a herdr bug. The bus exists: `herdr agent prompt <name>`. The tower never wrote
the command into the spec. The PM treated "mentor reviews" as a hint and did the work alone.

## Intended graph

```
owner → tower → PM only
                  PM → scout     (read-only census)
                  PM → mentor    (review)
                  PM → adversary (contradict — every implement/PR)
                  mentor → worker (if a worker exists)
```

The tower is **not** in the inner circuit. The human is **not** in the inner circuit.

When a PM is live, the **tower never prompts scout or mentor**. See [staffing](staffing.md).

## Human enters only when

Put a row in the owner queue. Triggers: merge / push / deploy / spend / credentials; leftover
disagreement after the mentor+adversary loop; a spec `not-yet-specified` that changes the work;
irreversible outward action. Idle seats are **not** a reason to ask the human.

## Hard rules

1. **Start the standing roster** on an open space before the first task prompt.
2. **Prompt the PM only.** Never mentor, scout, worker, reviewer, QA from the tower.
3. Every PM spec **must** contain the **Loop block** below, with real agent names.
4. A job whose spec said "mentor reviews" and whose mentor pane stayed idle for the whole run
   is **not done**, even if the marker exists. Partial.
5. After `MARKER_OK`, the status table names mentor/scout: `working` / `idle-used` /
   `idle-never-prompted`. Do **not** infer recency from `terminal_title` (sticky: first prompt,
   not last) or a Claude `revision` that saturates at 2. Confirm a prompt by a moved
   `state_change_seq` plus a mentor/scout note on disk.
6. **Implement / PR lives on `herdr worktree`.** Home stays on `main`. The PM lists, then
   `open` or `create`. Raw `git worktree add` + `tab create --cwd` is a miss.

## Loop block — paste into every PM spec

Strip instance bins. Keep the named `herdr agent prompt` lines.

```
## Loop (mandatory)

You are the space PM. You do not do the census or the review yourself.

Named seats:
- PM:        <pm-name>        kind grok-4.6
- Mentor:    <mentor-name>    kind grok-4.6
- Scout:     <scout-name>     kind grok-4.6
- Adversary: <adv-name>       kind claude opus — start if missing on implement/PR

Bus: `herdr agent prompt <name>`. Land-check working. Enter if idle.
Write briefs to files. Redact the sent copy before mentor/adversary.

Sequence:
1. Prompt the scout with a census brief. Wait for its note. If the scout cannot run, write why.
2. If this job writes a branch or PR: `herdr worktree list --cwd <repo>`.
   `open` or `create`. Do not `git worktree add`. Home stays on main.
3. Do the PM work using that census. Do not re-do the scout.
4. Prompt the mentor. Wait for its review. The mentor must contradict at least one claim
   or say explicitly it found none and why.
5. On implement/PR: prompt the adversary. Wait for its note. Fold or reject.
   A job with no adversary note is partial.
6. Fold or reject. Then write the marker.

Do not ask the owner unless the spec says the owner queue.
Do not report "ready" until the mentor note exists.
On implement/PR, also wait for the adversary note.
```

A spec that names `herdr agent prompt` for mentor and scout is a loop. Prose "mentor reviews"
is not a loop.

## After a space is idle

Standing seats may stay up (idle between tasks is correct). Close unused extra workers the same
turn. **Do not close the adversary** on an implement/PR space. A seat that has never been
prompted across two jobs: either prompt it next time or close it — do not keep furniture.

Read the pane record before any close — [closing](closing.md).
