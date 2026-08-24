# Auto-wiki

Status: **adopted**. Built in this package: [auto-wiki](../auto-wiki.md) and `scripts/auto-wiki.py`. A file copy is not this pattern.

## Pattern

```
main HEAD moves → diff the code → rewrite only the pages that cover those files → commit
```

Agents pull that map instead of walking the tree.

## Source

https://x.com/dannypostma/status/2091359121484448027

Tweet (verified via syndication API):

> added a `auto-wiki` feature which i normally have to manually run
>
> every time HEAD on main changes, a `wiki update` runs that changes what changed,
> updates the articles and commits it
>
> this helps keeping a high-level reference of your codebase that agents can quickly pull from

The capture noted **14 replies**. Those replies are **not** ingested here. If the “code is truth / docs are context” text was a reply on that thread, ingest that status next. Do not treat the parent tweet as missing.

## We take from Danny

- Trigger on `main` HEAD, not every branch.
- Diff-scoped update. Not a full rewrite.
- Commit the result.
- Purpose: a high-level map for agents.

## We take from our own rules

- **Rule A** — invalidate on change. A merge on `main` must refresh the map.
- **Rule B** — no rule without a doer. The write rides the merge. Not a skippable cron.

## We take from nvk / Karpathy / GBrain

| From | What |
|---|---|
| nvk `/wiki:refresh` or incremental compile | How a page gets rewritten. We write the hook only. |
| Karpathy LLM wiki | Persistent compiled map, not RAG over the tree every time. |
| GBrain | Do not copy skippable writes. The hook must run. |

nvk `wiki-manager` stays a **separate install**. This pattern is the hook + rewrite, not the compiler.

## Hard rules

1. Trigger only when `main` moves.
2. Update only pages the diff touches.
3. Each changed page names `generated: <sha>..<sha>`.
4. Skip lockfiles, `dist/`, assets.
5. Pages are a map. Code wins if they disagree. Do not copy a generated page into a skill as law.

## Also

https://github.com/nvk/llm-wiki
