# Plan 010: claude-code-expert cleanup — untrack cache/, fix set -e bug, wire up HTML conversion, remove stray docs file

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 61449aa..HEAD -- skills/claude-code-expert`
> If anything changed since this plan was written, compare the "Current
> state" excerpts against the live code; on a mismatch, treat as STOP.

## Status

- **Priority**: P3
- **Effort**: S–M
- **Risk**: LOW
- **Depends on**: none
- **Category**: correctness / tech-debt
- **Planned at**: commit `61449aa`, 2026-07-06

## Why this matters

Four small defects in the repo's one registry-based skill:

1. **Scrape cache is committed.** The skill's sync scripts write fetched upstream content to `cache/` (`scripts/sync-sources.sh:9`, `scripts/fetch-source.sh:9`: `CACHE_DIR="$SKILL_DIR/cache"`), but `skills/claude-code-expert/.gitignore` only ignores `.cache/` (with dot). Two cache files are already git-tracked; every future sync adds committable churn. Repo convention everywhere else: scratch lives in gitignored `.cache/`.
2. **`check-updates.sh` self-destructs when sources are missing.** `set -euo pipefail` (line 5) + `((missing++))` (lines 118, 126, 133): the first increment from 0 returns exit status 1 and kills the script mid-report — exactly when it has something to report. (Same bug class already fixed in `.github/workflows/scripts/sync-skill.sh`.)
3. **Dead HTML conversion.** `scripts/fetch-source.sh:118` defines `html_to_markdown()` but `main()` (lines ~160–187) never calls it, so blog/HTML sources are cached as raw HTML with a `.md` extension.
4. **A stray divergent doc.** `skills/claude-code-expert/docs/patterns/skill-creation.md` (top-level, outside the canonical nested tree) is the ONLY file in a vestigial `docs/` dir, and its content DIFFERS from the canonical `skills/claude-code-expert/skills/claude-code-expert/docs/patterns/skill-creation.md`. Two "skill-creation" guides with different content is a correctness trap.

## Current state

- `skills/claude-code-expert/.gitignore` (entire file):
  ```
  # Sync cache (temporary comparison files)
  .cache/
  ```
- Tracked cache files (`git ls-files skills/claude-code-expert/cache/`): `cache/docs/anthropic/release-notes/claude-code.md`, `cache/github/agentskills/README.md`.
- `scripts/check-updates.sh:5` `set -euo pipefail`; `:118`, `:126`, `:133` each `((missing++))`.
- `scripts/fetch-source.sh:118` `html_to_markdown() {`; `main()` at `:158+` calls `fetch_url` and `add_metadata` only.
- `skills/claude-code-expert/commands/claude-code-expert.md:25-38` references docs via `${CLAUDE_PLUGIN_ROOT}/skills/claude-code-expert/docs/` and bare `docs/patterns/...` — those refer to the CANONICAL nested tree; the stray top-level file is reachable only by the ambiguous bare relative path.
- Canonical nested docs tree: `skills/claude-code-expert/skills/claude-code-expert/docs/{ecosystem,patterns,features,validation}/`.

## Commands you will need

| Purpose | Command | Expected |
|---|---|---|
| Script syntax | `bash -n skills/claude-code-expert/scripts/*.sh` | exit 0 |
| Ignore check | `git check-ignore skills/claude-code-expert/cache/x 2>/dev/null; echo $?` | 0 (ignored) when done |
| Tracked cache | `git ls-files skills/claude-code-expert/cache/ | wc -l` | 0 when done |

## Scope

**In scope**: `skills/claude-code-expert/.gitignore`, `scripts/check-updates.sh`, `scripts/fetch-source.sh`, the tracked `cache/` files (untrack), the stray `docs/patterns/skill-creation.md` (top-level only).
**Out of scope**: the canonical nested `skills/claude-code-expert/skills/claude-code-expert/docs/` tree; `sync.json`, `state.json`, `sources/`; commands file; every other skill; the shared sync-skill.sh.

## Git workflow

- Branch: `advisor/010-cce-cleanup` off `main`
- One commit: `fix(claude-code-expert): gitignore cache, fix set -e arithmetic, enable HTML conversion, drop stray doc`
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: Gitignore and untrack the cache

Add `cache/` to `skills/claude-code-expert/.gitignore` (keep `.cache/` too — the shared sync runner uses it). Then `git rm -r --cached skills/claude-code-expert/cache/`.

**Verify**: `git ls-files skills/claude-code-expert/cache/ | wc -l` → 0; `git check-ignore skills/claude-code-expert/cache/github/agentskills/README.md` → prints the path (ignored); the files still exist on disk (`ls skills/claude-code-expert/cache/github/`).

### Step 2: Fix the arithmetic-under-set-e bug

In `scripts/check-updates.sh`, replace all three `((missing++))` (lines 118, 126, 133) with `missing=$((missing + 1))`. Scan the rest of the file (and the other scripts in `scripts/`) for further bare `((var++))` statements and fix identically.

**Verify**: `bash -n skills/claude-code-expert/scripts/check-updates.sh` → exit 0; `grep -rn '((.*++))' skills/claude-code-expert/scripts/ | grep -v 'for (('` → no matches. Behavioral: `cd skills/claude-code-expert && ./scripts/check-updates.sh --verbose; echo "exit=$?"` → runs to its footer (prints its final section) even if sources are missing.

### Step 3: Wire up html_to_markdown

In `scripts/fetch-source.sh` `main()`: read `html_to_markdown()`'s signature (input/output args) and insert a call after the fetch succeeds and before `add_metadata`, applied only when the fetched file is detected as HTML (the function itself checks — read it; if the check lives inside, just call it unconditionally with the fetched file).

**Verify**: `bash -n` → exit 0. Behavioral: `./scripts/fetch-source.sh https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills /tmp/cce-test.md && head -20 /tmp/cce-test.md` → output is markdown-ish (has the metadata header; no `<!DOCTYPE`/`<script`). If pandoc-dependent and pandoc is present (`command -v pandoc` → yes on this machine), expect clean conversion.

### Step 4: Remove the stray divergent doc

First diff the two copies to check the stray has nothing uniquely valuable:
```bash
diff skills/claude-code-expert/docs/patterns/skill-creation.md \
     skills/claude-code-expert/skills/claude-code-expert/docs/patterns/skill-creation.md | head -40
```
If the differences are staleness (older content in the stray), delete the top-level `skills/claude-code-expert/docs/` directory. If the STRAY contains substantive content the canonical copy lacks, STOP and report the diff instead.

**Verify**: `test -d skills/claude-code-expert/docs && echo EXISTS || echo GONE` → `GONE`; `grep -rn '\.\./docs/\|expert/docs/patterns' skills/claude-code-expert/commands/ skills/claude-code-expert/skills/ | grep -v 'skills/claude-code-expert/docs'` → confirm no reference targets the deleted top-level path (references to the nested `docs/` are fine).

## Test plan

The behavioral checks in steps 2–3 are the tests. No framework; add none.

## Done criteria

- [ ] `git ls-files skills/claude-code-expert/cache/` → empty; `cache/` gitignored
- [ ] No bare `((var++))` in `skills/claude-code-expert/scripts/`
- [ ] `check-updates.sh --verbose` completes (prints its final section, exit code documented in report)
- [ ] fetch-source.sh converts an HTML URL to markdown in the behavioral test
- [ ] Top-level `skills/claude-code-expert/docs/` removed (or STOP report filed)
- [ ] `git status --porcelain` touches only in-scope files (plus `plans/README.md`)

## STOP conditions

- The stray doc has unique substantive content (step 4 diff) — report, don't merge content yourself.
- `html_to_markdown` turns out to be broken (produces empty/garbage output in the step 3 test) — report; wiring in a broken function is worse than dead code.
- Untracking `cache/` breaks a script that expects the committed files (grep scripts/ for `cache/` reads first — the files remain on disk, so this should be impossible; STOP only if a script does `git`-based reads of them).

## Maintenance notes

- The skill's registry sync (`sync-sources.sh`) now writes only to an ignored dir; its knowledge snapshots live in `sources/`/`state.json` + the nested docs — reviewers should not see `cache/` in future diffs.
- If the skill is ever migrated to the standard URL-based sync.json shape, this custom script stack goes away entirely — deliberately out of scope here.
