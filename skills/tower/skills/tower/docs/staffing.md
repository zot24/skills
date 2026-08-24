# Staffing — start only the seats the task requires

Distilled from a live tower's `docs/staffing.md` and `docs/org-model.md`. The menu below is a
**menu**, not a standing orchestra: a task that needs one worker starts one worker.

## The graph

```
tower → PM
          → mentor ──(if a decision is open)── adversary   (≠ mentor kind, 2–3 loops)
          → mentor → one worker                            (serial on this repo)
          → reviewer                                       (if a mergeable diff exists)
          → QA                                             (if user-facing / data / ship)
```

| Seat | Start it when | Kind / model | Effort |
|---|---|---|---|
| **PM** (`<project>-pm`) | sustained multi-cycle work | claude opus | high |
| **Mentor** (`<project>-mentor`) | sustained multi-cycle work | claude opus | high |
| **Worker — judgement** | there is a task | claude opus | high |
| **Worker — bulk** | mechanical: rebase, census apply, codemod | kimi `--auto` | medium (no CLI effort flag) |
| **Adversary** (`<project>-adversary`) | an open design or ADR | grok-4.6, ≠ mentor kind | high |
| **Reviewer** (`<project>-reviewer`) | a PR or mergeable diff exists | grok-4.6, ≠ author kind | high |
| **Scout** | read-only code or GitHub census | grok-4.6 | medium |
| **QA** (`<project>-qa`) | a human will click it, or data moves | pi + grok-4.6 | low |
| **Tower brain** | this session | any strong judgement model | high |

`xhigh` / `max` effort only when the owner asks for it.

**A single one-shot task is one worker pane.** PM and mentor exist to keep a *loop* moving; they
are overhead on a task with one deliverable and one marker.

**An already-staffed space is different.** If at least one standing seat (PM, mentor, or scout)
is already live, start any seat the spec's staff plan marks `required`, then prompt the PM. An
open space with no standing seats is still a one-shot: one worker. Do not spawn PM + mentor +
scout on every one-shot, and do not treat “the space exists” as a roster. Standing seats already
up stay up. Optional rows still wait for `when` (`decision` / `pr` / `user_facing` / `task`).

A spec that names `herdr agent prompt` for mentor and scout is a loop. Prose "mentor reviews"
is not a loop.

## What each seat is for

- **PM** — keeps every loop MOVING. Notices finished batches, verifies the central claim itself,
  releases the next cycle, keeps the loop log current. Holds the repo-level view (open PRs,
  pending owner questions, cross-workstream collisions) that individual developers lack.
- **Mentor** — reviews all developers' work and asks the question the developer did not ask
  itself. Spot-checks at least one claim per cycle against the source. Dispatches the next piece
  of work. **Must be a different herdr kind than the adversary.**
- **Developer** — does the work. One live task each.
- **Adversary** — a second brain on *decisions*, not keystrokes. Attacks the design and "are we
  building the right thing?" for a fixed number of loops (default 3). Stop when they agree, or
  escalate the leftover disagreement to the owner.
- **Reviewer** — diffs only: correctness, tests, blast radius. May reuse the adversary's pane
  once the design has settled.
- **QA** — **runs the thing.** Clicks it, curls it, imports it, looks at the number on the
  screen. Reports what happened, not what the tests assert.

## Why supervised

A developer alone produces confident work nobody checked. Developer plus reviewer produces good
work that *stops* — it finishes a batch and waits for a release the tower forgets to give,
because the tower is running several projects. The PM exists solely to close that gap; the
mentor exists so nothing merges on an agent's own say-so.

Each role fails in its own way, so bound them differently:

- **Developer** — over-claims. Demand `file:line` and a grade per claim.
- **Mentor** — is only as good as its questions. Make it state what it already knew versus what
  it had to derive. A mentor that never contradicts its developer is rubber-stamping.
- **PM** — politely stalls. Tell it in words: *"do not stop and wait for me between cycles —
  that waiting is the failure you were created to fix."* Without that sentence it waits.

## When QA is required

"Tests pass" and "it works" are different facts. QA is **required** for:

- **A fix to a user-facing flow.** Team invites were once "fixed" on `main` with tests green and
  nobody had sent one real invite — delivery worked, activation was unverified.
- **Anything that moves or transforms data** — imports, migrations, syncs. One portfolio import
  passed every resolution check and still bound `BTC` to a Grayscale ticker, valuing $5,079 at
  $2.19. Only running it and looking at the number caught that.
- **Anything about to ship outward** — a PR merging into a user path, an app update the owner
  will install.

QA is skipped for read-only research, audits, censuses, doc work, and internal tooling whose
failure is loud. On a close call the mentor decides and records the decision.

**A QA verdict names what it exercised**: the exact flow, inputs, environment, and what was NOT
covered. *"Ran the happy path on local, did not test the duplicate-email case"* is a verdict.
*"QA passed"* is not one.

## Chain of command — state it in every spec, it is not inferable

- Only the **mentor** prompts a developer. Two agents prompting one developer duplicates and
  loses work. Reviewer and QA report **to** the mentor.
- The **PM** prompts the mentor, and assigns diffs/flows to reviewer and QA.
- **QA gets the build, not the diff.** A QA agent that has read the code tests what the code
  intends rather than what the user gets; that independence is the whole value.
- The **tower** prompts the PM, and holds the money gate: only the human authorises anything that
  spends budget or is irreversible or outward-facing. Everything in that class goes to the owner
  queue and the loop continues on whatever else is unblocked.
- If a **PM pane is already live**, the tower prompts that PM — never a worker. The PM prompts
  mentor and scout. Two agents prompting one developer still duplicates work.

## Lessons this table encodes

1. **PM / IC / QA** — orchestrator → workers → validators. Not invented here.
2. **Creator ≠ verifier, and a different model.** A builder has cost bias on its own work.
3. **Serial on one repo.** Parallel workers on a shared checkout produce conflicts and
   duplicates. Parallel is for *read-only* work — search, review, census.
4. **3–5 concurrent agents max** while one human watches one repo. Hundreds only when each agent
   owns an independent PR.
5. **Negotiate done before code** — the validation contract first, then implement.
6. **The evaluator runs the thing.** QA is not a second diff reader.
7. **Risk-tier the panel.** A typo does not get the dream team.
8. **Harness beats model.** Enforce with tests, markers, and land-checks; agents lie.
9. **One ticket ≈ one context window.** Review in a *fresh* one.
10. **A trio keeps the loop moving.** Two agents produce good work that stops.

## What not to do

- Do not spawn all six seats on every feature.
- Do not put two workers on the same files without a dependency split.
- Do not let the author review its own PR in the same context.
- Do not let a mentor's cycle ceiling sit **below** its PM's. That contradiction guarantees a
  stall while nothing appears to misbehave; it cost 4.5 hours once. Ceilings **reference, never
  restate** — write "stop at the current ceiling (see above)" so one number lives in one place.

## Time-box every autonomous loop

A loop left running spends money and touches a repo while nobody watches. Ask the human for a
wall-clock limit when standing one up, and enforce it twice:

1. **In the PM's instructions** — an absolute epoch deadline, not a duration. It checks
   `date +%s` before releasing each cycle, refuses to start a cycle it cannot finish, and winds
   down into a final log whose status opens with `STOPPED — <reason>` and names the exact next
   cycle so a cold session can resume.
2. **As a tower-side backstop** — a backgrounded `sleep` to the same epoch that then stops the
   workspace.

The deadline outranks the cycle ceiling; whichever comes first wins. **The agent-side deadline is
the one that actually holds** — a tower-launched `sleep` backstop was killed by the harness twice
before firing and fired correctly once. Treat it as a nice-to-have, re-check the wall clock
yourself whenever you touch the workspace, and **do not re-arm a killed timer a third time.**

Also give every loop a **convergence condition**, not just a ceiling: stop when the mentor raises
no new finding for two consecutive cycles, and stop immediately if the same failure recurs twice.

## Cycle hygiene

- **One prompt per cycle**, and never into a `working` or `blocked` agent — check
  `herdr agent get` first.
- **The cycle record is written before the prompt is dispatched.** No unrecorded prompts.
- **Verify, don't relay.** The PM re-runs the tests and confirms the file exists itself.
- **One write target outside the repo** — a cycle directory holding the mentor's per-cycle notes
  and the PM's loop log, the loop log **rewritten** each cycle with status first. Appending
  instead accumulated three live-looking "needs the human" sections with nothing marking which
  was current.
