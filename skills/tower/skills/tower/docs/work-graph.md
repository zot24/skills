# Work graph — the tower's memory between reconvenes

Distilled from a live tower's `work-graph` skill. A tower runs several projects at once and gets
interrupted by the owner constantly; the chat is not a record of what is open.

## The file

One file at the tower root — call it `OPEN-THREADS.md` — is the graph. **Nodes are threads;
edges are what a thread waits on and what it frees.**

```markdown
# Open threads
Last rewritten: 2026-08-17T14:02-03:00 (from live map + live herdr)

| # | Thread | Status | Next / edges |
|---|---|---|---|
| 51 | 🟢 billing — invite activation QA | **blocked** | waits_on: owner decision → owner queue #3 |
| 52 | 🔵 portfolio — import ticker binding | live | dev·k3 in `w2:p1`; waits_on: `markers/import-fix.done` |
| 53 | ⚪ tower skill | live | waits_on: `markers/2026-08-17-tower-skill.done`; unblocks: 47 |
```

## The one rule

**A new owner message may only *add* a node, or *defer* a node in writing. It never replaces the
graph.** An interrupt that silently drops a live row is how a paying customer's blocker sits at
rank 1 for fifteen days.

## Unpaid ask

**Unpaid ask.** One owner message with N asks is N nodes. An in-chat question is a node.
Deferring one sibling does not defer the others. A later message may add a node; it does not
close an unpaid ask.

**Continuous questions in one session are expected.** Launch or answer every still-open ask.
Do **not** park an earlier question because a new one arrived. Park only when the owner
says forget / park / later. Owner 2026-08-25: parking #202 to start #203 was the failure.

## When to touch it

At session start · on any status request · when the owner sends a new ask · **before any
dispatch** · when a marker lands and the tower reconvenes.

1. **Read it first.** If the timestamp is cold or a row disagrees with reality, rewrite it from
   what is actually alive (`herdr agent list`, `herdr tab list`) and which markers exist on disk.
   Re-stamp `Last rewritten`. **Never rebuild the graph from a handoff document** — rebuild it
   from live herdr plus the filesystem. A tower that trusted a handoff over live herdr
   confidently described a fleet that had not existed for a week.
2. **Attach the new ask as a node before writing its spec** — colour + thread name, status, next
   action.
3. **Type the edges that exist**, in the Next column: `waits_on: <marker path>`,
   `unblocks: <thread #>`, `escalates: <owner queue>`. An edge you cannot name stays unwritten.
4. **Keep every live node.** Starting a track that would leave one unattended: park it, finish
   it, or write it `deferred` with a reason — *in the file* — then take the new ask.
5. **Pay unpaid asks in the same reply** that starts the new job: answer them, or name each
   parked item and why. A pane start is not payment.
6. **On marker land**, before reconvening: flip that node to `done` against the marker file, and
   release whatever it `unblocks`.

## States

| Status | Means |
|---|---|
| `live` | open and attended — a pane is working it, or the tower owes it a next move |
| `blocked` | waiting on a **named** edge: a marker, a PR, an owner decision |
| `deferred` | parked on purpose, with the reason written in the row |
| `done` | the marker exists **and** was verified — agent say-so alone leaves it `live` |

Nodes carry status only. Dispatch mechanics live in [dispatch](dispatch.md), marker mechanics in
[watch & poke](watch-and-poke.md), pane mechanics in [layout](layout.md).

## The owner queue is a separate file

Decisions only a human can make go to one file at the tower root — not into a per-project log.
Every loop is time-boxed twice over while **owner decisions have no clock at all**, and that
asymmetry, not agent stalling, is a fleet's real bottleneck.

- **Re-verify every item against the source of truth before it enters, and stamp it with the
  check date.** A loop log is an agent's say-so; the independent-verify rule applies to it too.
- **Every item carries an age in days and the cost of deciding it.** "One message, no
  credentials" outranks a policy call, however interesting the policy call is.
- **An item past a week is dropped, not queued.** Decide it, delegate it, or delete it with a
  reason. A deletion with a rationale is a legitimate outcome; a silently ageing rank-1 is not.
- Items with no checkable source — local infrastructure, no GitHub state — are labelled
  UNVERIFIED in place rather than promoted to fact.
