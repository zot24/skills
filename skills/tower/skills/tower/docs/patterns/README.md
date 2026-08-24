# Patterns

A **pattern** is a named loop we copied and now run. A mapping rule is not a pattern. An ADR is not a pattern.

Each row: name, do we run it, where the cut lives, where the idea came from.

Do not invent rows here. Do not promote “one repo → one wiki Project” into this catalog.

## Adopted

| Pattern | Cut | Source |
|---|---|---|
| [Auto-wiki](auto-wiki.md) | `main` moves → diff → rewrite those pages → commit | [Danny Postma](https://x.com/dannypostma/status/2091359121484448027) · nvk · Karpathy |

Built in this package: [auto-wiki](../auto-wiki.md) and `scripts/auto-wiki.py`. A file copy is not this pattern.

## We run these

| Pattern | Where it lives | Source |
|---|---|---|
| LLM wiki | nvk `wiki-manager` — **separate install** | nvk/llm-wiki · Karpathy |
| Control tower | this skill | [herdr](https://github.com/herdrdev/herdr) |
| Fleet trio / space-loop | [space-loop](../space-loop.md) | Factory / Anthropic in [staffing](../staffing.md) |
| Idle is not done | [watch & poke](../watch-and-poke.md) | herdr family · this skill |
| Worktree seat | [layout](../layout.md) | herdr worktree |
| Acceptance gates | [gate format](../gate-format.md) | [unlazy](https://github.com/Leonxlnx/unlazy) |
| Creator ≠ verifier | [staffing](../staffing.md) | Factory |
| Supervised cycle | [staffing](../staffing.md) | supervised cycle loop |
| Wiki first | query the topic before a spec | nvk query-first |
| Risk-tier the panel | [staffing](../staffing.md) | Cloudflare via staffing |
| Serial writer / parallel trees | [staffing](../staffing.md) · [layout](../layout.md) | Factory |
| Unpaid ask + work graph | [work graph](../work-graph.md) | this skill |
| Phase A then STOP | [dispatch](../dispatch.md) | this skill |
| Reconvene table | [operating loop](../operating-loop.md) | folded `reconvene-table` |
| Redact before a second model | [space-loop](../space-loop.md) | X ingest Rec 5 |
| One official wiki pack | nvk `wiki-manager` only; no house wiki-query | nvk |
| Installer owns skills | `zskills`; no leftover local copies | zskills |
| One skill per job | published `tower` only | this package |
| Claude is adversary only | [staffing](../staffing.md) · [model-router](../model-router.md) | pins |
| Sync docs on upstream release | pi skill watches earendil-works/pi releases | this marketplace |
| Close the space when the job is done | [closing](../closing.md) | herdr closing |
| Human lease beats a poll | user action waits; background check yields | tempo |
| Do not guess a cause | error text = stage observed, or undetermined | evidence discipline |
| Spec on disk before start | [dispatch](../dispatch.md) | this skill |
| Steal only with a doer | HAVE / STEAL / SKIP; no skippable cron | Rule B |
| Colour workspaces | one colour per product | herdr |
| Loops, not one-shot prompts | observe → act → verify → stop | Loop Library |
| Explicit skills | skills on disk, not vibes | Pocock |
| Harness > model | pins, kinds, land-check | [staffing](../staffing.md) lesson 8 |

## Looked, not a new pattern

Tickets, not loops: floorplan UI, skill-doctor grade/apply, zskills typed CRUD, release-please auto-merge warn, README 1024-char cap, wiki digest harvest.

STEAL not shipped: live/unverifiable/exited watchers; weekly unused-skill doctor.

## Not a pattern

| Thing | What it is |
|---|---|
| One git repo → one wiki Project | mapping rule (ADR). Not a pattern. |
| Hub first, no per-repo `.wiki/` yet | ADR |
| Folder name `orchestrator` → `tower` | rename (out of scope) |

## Add a row when

The owner adopts a named loop, we can point at a source, and we either run it or we have a spec to build it.
