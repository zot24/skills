# Operating loop — session start, catalog, unpaid ask, reconvene

The dispatch protocol is how a *job* runs. This file is how a *session* starts, how asks are
catalogued, and how the owner is reconvened. SKILL.md names the four steps; this file is the
ritual.

Generic names: **status board**, **live map**, **work graph file**, **pin file**, **owner queue**.
Instance bins, MCP tool names, and house paths stay out of this skill.

## Session start / status

Completion: one compact decision summary exists.

1. Load the [work graph](work-graph.md). Reconcile it from live herdr and which markers exist on
   disk. Never rebuild it from a handoff document.
2. Read the live map and the status board. Trust the live map over a handoff for liveness.
3. Report: fleet, queue head, entitled kinds and models, pin file, dispatch blockers.
4. Do not start agents. Do not edit product repos.

That summary is the conversation until the owner asks for catalog or dispatch.

## catalog

Completion: entitled vs missing named.

Same board, entitlement focus. Name every pin slot whose kind is missing. Do not hit market
feeds unless the board cannot answer. Freshness results, if used at all, join back to the board
before they change a dispatch.

## Unpaid ask

Pay or park every prior owner ask in the same reply that starts a new job. Full wording:
[work graph](work-graph.md). SKILL.md carries the one-line form the session must match.

## After dispatch

A new owner ask and a landed marker both go through the work graph first — add or defer the
node, never drop a `live` row.

Do not continue a dispatched investigation in the tower chat. Watch markers. When they exist:
verify ([watch & poke](watch-and-poke.md)), then **reconvene**.

## reconvene

The owner reads the tower reply in a terminal. One shape, every time. That is the conversation.
Not a running commentary while panes work.

1. **Headline** — one line: what changed their next click.
2. **Per live thread** — 2–4 short lines, not a dump: what is true now (VERIFIED), what went
   wrong if anything, the click (URL or exact command).
3. **The owner table** — every live or just-closed thread. Never a row with only a number.

| # | Project | Status | What is true | Wrong / gap | You |
|---|---|---|---|---|---|
| 51 | 🟢 billing — invite activation QA | **blocked** | tests green; activation unclicked | owner decision | owner queue #3 |
| 52 | 🔵 portfolio — import ticker binding | live | pane `w2:p1` working | — | waits_on marker |
| 53 | ⚪ tower skill | live | spec on disk | — | waits_on marker |

- **#** — thread id.
- **Project** — name. Never a bare number. Colour is optional instance convention.
- **Status** — `done` / `live` / `blocked` / `partial`.
- **What is true** — one clause the tower checked.
- **Wrong / gap** — one clause, or `—`.
- **You** — the next human click. Full PR URL or the exact command. `—` if nothing.

Cap: 8 rows. Live and blocked first. Done rows only if they still need a click (merge, deploy,
read).

The fleet table (every live agent, tab, pane, run) still belongs in the dispatch reconvene
([dispatch](dispatch.md) step 6). The owner table above is what the human reads. Both are
reconvene. Do not collapse them.

When a PR is the click, run `gh pr view N --json number,title,state,mergedAt,url` this turn.
If `state` is `MERGED`, the You cell is `—`. A work graph file is not evidence of GitHub state.

## Escalate

An item the tower cannot decide goes to the owner queue after re-verify, or is declined because
it is already fixed. Carry age, cost of deciding, VERIFIED date, and the check performed.
Rules: [work graph](work-graph.md).

## Closeout

A report that exists only under `reports/` has taught the system nothing. Route it into the
project's knowledge base, or mark it ephemeral with a reason. Nothing auto-promotes. See
[dispatch](dispatch.md) step 8 and [closing](closing.md).
