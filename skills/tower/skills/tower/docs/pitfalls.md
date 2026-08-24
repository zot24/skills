# Pitfalls — the failure catalogue

Every entry here was paid for once by a real control tower. They are listed with what they cost,
because a rule without its incident gets optimised away by the next agent that reads it.

## Completion

**Treating `idle` as done.** `idle` is a terminal state, not a task state — it is equally true of
an agent that finished, crashed, refused, or answered the wrong question. `unknown` explicitly
does not prove completion, and `idle` is only reported after the tab has been *seen* in the UI,
so it is partly a fact about your focus. → Marker file plus independent verification.

**Matching pane output for a completion string.** It false-positives on the **prompt echo** — the
agent's own copy of your instruction contains the word "done". → Poll for the file.

**Reading a finished answer out of scrollback.** Agents on the terminal's alternate screen lose
it, and rows that leave the alternate screen never enter herdr's host scrollback, so no `--lines`
value recovers them. → The deliverable is a file path, named in the spec up front.

**Hooking agent `idle` to fire the reconvene.** It fires on every turn boundary, permission
prompt, and crash. → Watch the marker.

## Dispatch

**Trusting `prompt` → ok.** A long payload can time out, get backgrounded, and be killed before
delivery while `send-keys` still returns `"ok"`. A correction was once reported as sent and never
arrived. → `herdr agent get <name>` must show `working`; if `idle`, `send-keys enter`.

**Starting kimi without `--auto`.** It then blocks on every tool call and looks idle and stuck. →
`-- --auto` at start, or `/auto` as the first prompt, then land-check `working` again.

**Inventing an agent kind.** `herdr agent start --kind` takes a fixed list; anything else is a
guess that fails at start time. → Read the list from `herdr agent start --help`.

**Passing `--permission-mode` reflexively.** It *overrides* the user's own harness default, which
is how agents started in accept-edits when the user had chosen otherwise. → Omit it unless you
mean to state it.

**Putting the spec in the prompt.** Prompts get truncated and echoed. → The spec is a file; the
prompt is one line pointing at it.

**Starting a new job without paying the previous owner message.** A later ask that adds work
does not close an unanswered question. Two skills once taught two starts — session loop in one
file, dispatch in another — and unpaid asks died in the gap. → Before the reply that starts a
new job, answer every prior ask or name it parked and why. A pane start does not pay a
question. See [work graph](work-graph.md).

## Spec writing

**Naming the sources the agent should read.** It converts research into confirmation. One agent
said so outright — *"I read the corpus directly rather than through the query tool, because the
spec named specific files"* — and produced five false findings. → Name the question, the
standard, and the deliverable. Not the sources.

**Dispatching before verifying the target.** Three times in one session an agent was aimed at the
wrong artefact: a project's docs instead of its code, then a fork instead of the official repo,
twice. Each round-trip cost a full agent run; one `ls` or `git ls-tree` would have caught all
three. → Verify the source before dispatching, not after.

**Writing only an "Out of scope" section.** It is the opposite instruction to "Not yet
specified", and a spec carrying only the former hands the agent every unlisted gap as licence. →
Both sections, always. Not-yet-specified means *stop and ask*.

**Discover-and-fix in one uninterrupted run.** That is how an agent fixes the wrong thing
confidently. → Phase A read-only, ending in `STOP`; the human decides; Phase B released
separately.

**Never saying NOT DETERMINED.** If the third grade never appears, it is decorative and the spec
was too loose. → Ask explicitly for "say so if you cannot determine something".

## Verification

**Building a queue from cold logs.** An owner queue's first draft opened with "a paying customer
blocked, 15 days, never asked" — the question had been asked eight days earlier and the bug was
fixed and closed that same day. Two more items were equally stale. **A queue assembled from an
agent's logs manufactures urgency about finished work**, which costs more than the silence it was
meant to fix. → Re-verify each item against the source of truth and stamp it with the check date.

**Collapsing INFERRED into VERIFIED when reporting up.** That is how a gap ships as a conclusion.
→ Preserve all three grades; a claim becomes your finding only after you checked it.

**Relaying the agent's report instead of the decision.** The owner sees your summary. → Lead with
what changes their decision; corrections to your own earlier statements go first and plainly.

**Naming a ticket by bare number.** `#805, #771, #763` tells a cold reader nothing about what
they are being asked to prioritise. → "#917 (paying customer blocked on Convert)".

## Fleet state

**Rebuilding the picture from a handoff document.** A tower that trusted a handoff over live
herdr confidently described a fleet that had not existed for a week. → Rebuild from
`herdr agent list` plus which markers exist on disk.

**A second tab on the same checkout.** Two agents on one working tree: one agent's `git checkout`
silently rewrites the other's edits. → An extra tab means an extra worktree and branch.

**Two agents prompting one developer.** Duplicates and loses work. → Only the mentor prompts a
developer; reviewer and QA report to the mentor.

**A mentor's cycle ceiling below its PM's.** Guarantees a stall while nothing appears to
misbehave. It cost 4.5 hours once. → Ceilings reference, never restate: "stop at the current
ceiling (see above)".

**Clearing permission prompts blind in a loop.** It injects stray input into agents that were not
blocked; it killed one agent's first run mid-task. → `herdr agent explain <name>` first, and
never approve a prompt that would spend budget.

**Re-arming a killed timer a third time.** A tower-side `sleep` backstop was killed by the
harness twice before firing. That is the same-failure-twice rule applying to the tower itself. →
The agent-side epoch deadline is the one that holds.

## Teardown

**`/exit`-ing a whole space to pick up a plugin.** It throws away every warm agent in the space,
including the ones holding expensive context, and none of them needed the reload. →
`herdr server reload-config`, then restart only the panes that must reload.

**Closing an agent whose only copy of the work is its own scrollback.** → It stays alive until
the findings are durable in a file, an issue, or the wiki.

**Sweeping continuously.** That is how a warm agent gets closed twenty minutes before the
follow-up arrives. → Sweep at the end of a session, or when a project phase closes.

**`herdr server stop` from inside an active session.** It stops the server and every pane
process. → Never, unless that is explicitly the intent. Use `herdr --session <name>` for
isolated experiments.

## Context

**Doing the work inline.** It burns the tower's context, is invisible in the fleet UI, and dies
with the session. → The only inline exception is one cheap fact needed to write the spec.

**Dumping full herdr JSON into the tower's context.** → `jq -c` a projection.

**Leaving a deliverable only under `reports/`.** One tower measured it: 5 of 95 dated reports
were traceable in its corpus, all five from two days — the habit lapsed exactly as the fleet
scaled up. → Route it into the knowledge base, or the task is not closed.
