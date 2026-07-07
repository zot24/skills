# Plan 004: Sync hygiene — register x-engagement's upstream, make CI freshness real, fix URL dedup

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 7cb28b4..HEAD -- .github/workflows/sync-docs.yml skills/x-engagement skills/firecrawl/discover-pages.sh skills/servarr/discover-pages.sh CLAUDE.md`
> CLAUDE.md changes from plan 003 are EXPECTED. Other drift in these files:
> compare against the "Current state" excerpts; on a mismatch, treat as a
> STOP condition.

## Status

- **Priority**: P2
- **Effort**: M
- **Risk**: LOW
- **Depends on**: none (if plan 003 hasn't landed, the CLAUDE.md table edit here may conflict textually — rebase carefully)
- **Category**: tech-debt
- **Planned at**: commit `7cb28b4`, 2026-07-06

## Why this matters

Three unrelated hygiene defects in the sync machinery, batched because each is small:

1. **x-engagement has dead sync config.** Its `sync.json` declares a live upstream (the xai-org/x-algorithm README) but the skill is not in the CI `SKILLS` array, so the source never fetches; its target file doesn't exist; and `CLAUDE.md` classifies the skill as having no upstream docs. The config and the registration contradict each other.
2. **`freshness_days` is inert in CI.** The sync script's cache lives in gitignored `.cache/` directories, which never exist on a fresh CI checkout, so every scheduled run re-fetches ALL sources (600+ URLs across skills like firecrawl at 202 and flue at 110) regardless of the configured freshness. Persisting `.cache/` across runs with `actions/cache` makes the throttle real (tar preserves mtimes, which is what the freshness check reads).
3. **Substring URL dedup in two discover scripts.** `firecrawl` and `servarr` use `grep -qF` when checking if a discovered URL is already tracked — a new URL that is a substring of a tracked one is silently skipped. `1password-cli` already uses the correct exact-match `grep -qxF`.

## Current state

- `skills/x-engagement/sync.json` — version `1.1.0`; one source:
  ```json
  {
    "url": "https://raw.githubusercontent.com/xai-org/x-algorithm/main/README.md",
    "target": "skills/x-engagement/docs/x-algorithm-readme.md",
    "type": "raw",
    "freshness_days": 30
  }
  ```
  The target resolves (per the sync script's `$SKILL_DIR/$target` convention) to `skills/x-engagement/skills/x-engagement/docs/x-algorithm-readme.md`, which does not exist yet — the first sync will create it. The existing `docs/` dir has 6 hand-written files.
- `skills/x-engagement/skills/x-engagement/SKILL.md:37-42` — Documentation list with 6 `docs/*.md` bullets (algorithm-signals, content-quality, content-strategy, conversation-tactics, authority-building, content-ideas).
- `.github/workflows/sync-docs.yml:65` — `SKILLS=(...)` array of 19 names; `x-engagement` absent.
- `.github/workflows/sync-docs.yml:28-37` — `Checkout repository` then `Install dependencies` steps; no cache step anywhere.
- `CLAUDE.md` skill-sources table (~line 230–250): no x-engagement row; the note below the "Register the skill" checklist says x-engagement is a skill "without upstream docs".
- `skills/firecrawl/discover-pages.sh:53`: `if ! echo "$EXISTING_URLS" | grep -qF "$url"; then`
- `skills/servarr/discover-pages.sh:78`: `if ! echo "$EXISTING_URLS" | grep -qF "$full_url"; then`
- `skills/1password-cli/discover-pages.sh:55` (exemplar, correct): `if ! echo "$EXISTING_NORM" | grep -qxF "$url"; then`

## Commands you will need

| Purpose | Command | Expected on success |
|---------|---------|---------------------|
| JSON check | `jq empty skills/x-engagement/sync.json` | exit 0 |
| Run one sync | `.github/workflows/scripts/sync-skill.sh skills/x-engagement --force` | exit 0, `has_changes=true`, target file created |
| Script syntax | `bash -n skills/firecrawl/discover-pages.sh skills/servarr/discover-pages.sh` | exit 0 |
| YAML sanity | `ruby -ryaml -e 'YAML.load_file(".github/workflows/sync-docs.yml")' 2>/dev/null \|\| python3 -c "import yaml,sys; yaml.safe_load(open('.github/workflows/sync-docs.yml'))"` | exit 0 |

## Scope

**In scope** (the only files you should modify/create):
- `.github/workflows/sync-docs.yml` (SKILLS array + new cache step)
- `skills/x-engagement/skills/x-engagement/SKILL.md` (one docs bullet)
- `skills/x-engagement/skills/x-engagement/docs/x-algorithm-readme.md` (created by running the sync)
- `skills/firecrawl/discover-pages.sh` (one character-level fix)
- `skills/servarr/discover-pages.sh` (one character-level fix)
- `CLAUDE.md` (x-engagement rows/notes only)

**Out of scope** (do NOT touch):
- `.github/workflows/scripts/sync-skill.sh` (plan 001 owns it; the freshness fix here is workflow-side by design)
- `skills/x-engagement/sync.json` — it is already correct; only its registration is missing. (Exception: version bump if the repo maintainer wants one — skip it; CI bumps on sync.)
- All other skills and workflows.

## Git workflow

- Branch: `advisor/004-sync-hygiene` off `main`
- Conventional commits, e.g. `fix(ci): persist sync cache across runs`, `fix(x-engagement): register upstream sync`, `fix(firecrawl,servarr): exact-match URL dedup`
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: Register x-engagement in CI and CLAUDE.md

1. `.github/workflows/sync-docs.yml:65`: append `"x-engagement"` to the `SKILLS` array.
2. `CLAUDE.md` skill-sources table: add row
   `| x-engagement | https://github.com/xai-org/x-algorithm | URL-based |`
3. `CLAUDE.md` — the note reading `> **Note**: Skills without upstream docs (e.g. \`safe-delete\`, \`x-engagement\`) don't need CI sync registration…`: remove `x-engagement` from the example list (keep `safe-delete`).

**Verify**: `grep -c 'x-engagement' .github/workflows/sync-docs.yml` → 1; `grep -n 'x-engagement' CLAUDE.md` → shows the table row and no longer the "without upstream docs" note.

### Step 2: Populate the missing target and reference it

Run:
```bash
.github/workflows/scripts/sync-skill.sh skills/x-engagement --force
```
→ creates `skills/x-engagement/skills/x-engagement/docs/x-algorithm-readme.md`.

Then add one bullet to the Documentation list in `skills/x-engagement/skills/x-engagement/SKILL.md` (after line 42, matching the existing bullet style):
```markdown
- **[x-algorithm README (upstream)](docs/x-algorithm-readme.md)** - Cached README from xai-org/x-algorithm, the codebase the playbook is grounded in
```

**Verify**: `test -s skills/x-engagement/skills/x-engagement/docs/x-algorithm-readme.md && echo OK` → `OK`; first line of that file is `> Source: https://raw.githubusercontent.com/xai-org/x-algorithm/main/README.md`.

### Step 3: Persist `.cache/` across CI runs

In `.github/workflows/sync-docs.yml`, insert between the `Install dependencies` and `Setup Git` steps:

```yaml
      - name: Restore sync cache
        uses: actions/cache@v4
        with:
          path: skills/*/.cache
          key: sync-cache-${{ github.run_id }}
          restore-keys: |
            sync-cache-
```

Rationale to preserve in the step name/comment: `actions/cache` with an always-unique key + `restore-keys` prefix restores the most recent cache and saves a fresh one each run; tar preserves file mtimes, which is what `needs_refresh()` in sync-skill.sh reads, so `freshness_days` finally throttles CI fetches.

**Verify**: the YAML-sanity command from the table exits 0; `grep -n 'actions/cache' .github/workflows/sync-docs.yml` → 1 match, positioned before the `Discover new docs pages` step.

### Step 4: Fix substring dedup in firecrawl and servarr discover scripts

- `skills/firecrawl/discover-pages.sh:53`: `grep -qF "$url"` → `grep -qxF "$url"`
- `skills/servarr/discover-pages.sh:78`: `grep -qF "$full_url"` → `grep -qxF "$full_url"`

Caveat: `-x` requires each line of the existing-URL list to be exactly a URL. Inspect how `$EXISTING_URLS` is built in each script (both use `jq -r '.sources[].url'` — plain one-URL-per-line); if either script embeds whitespace or normalization differences, STOP instead of forcing `-x`.

**Verify**: `bash -n` both scripts → exit 0. Then run each report-only (no flag) from repo root:
`./skills/firecrawl/discover-pages.sh || true` and `./skills/servarr/discover-pages.sh || true` — each must NOT report any URL that already appears verbatim in its sync.json (spot-check 2 reported URLs with `grep -F "<url>" skills/<skill>/sync.json`).

## Test plan

No test framework. The verification gates are the tests. The behavioral proof for step 3 can only fully run in CI — acceptable; the YAML check + step placement review is the local gate.

## Done criteria

Machine-checkable. ALL must hold:

- [ ] `x-engagement` present in the SKILLS array; CLAUDE.md row added and stale note fixed
- [ ] `skills/x-engagement/skills/x-engagement/docs/x-algorithm-readme.md` exists, non-empty, referenced from that skill's SKILL.md
- [ ] `actions/cache` step present in sync-docs.yml; YAML parses
- [ ] `grep -n 'grep -qF' skills/firecrawl/discover-pages.sh skills/servarr/discover-pages.sh` → no matches (both now `-qxF`)
- [ ] `git status --porcelain` touches only in-scope files (plus `plans/README.md`)
- [ ] `plans/README.md` status row updated

## STOP conditions

Stop and report back (do not improvise) if:

- The x-engagement sync fetch fails (xai-org/x-algorithm repo moved/renamed) — report; consider recommending source removal instead, but don't decide unilaterally.
- The maintainer intent question surfaces: if you find evidence (commit message, README note) that x-engagement was *deliberately* excluded from CI sync, stop and ask rather than registering it.
- `$EXISTING_URLS` in firecrawl/servarr turns out not to be one-clean-URL-per-line (breaks `-x`).
- Editing sync-docs.yml appears to require touching the SKILLS loop logic itself.

## Maintenance notes

- The cache key strategy (`run_id` + prefix restore) means the cache is rewritten every run; if the repo ever hits GitHub's 10 GB cache quota, scope `path` tighter or add a weekly key.
- With freshness now honored in CI, a source can be at most `freshness_days` stale *plus* the bi-weekly schedule gap; if docs seem stale, `workflow_dispatch` with `force: true` bypasses both.
- Reviewer should scrutinize: step 3's placement (must be after checkout, before discovery/sync) and that `path: skills/*/.cache` globbing is supported by actions/cache v4 (it is — multi-path glob patterns are documented).
- Deferred: rolling out `discover-pages.sh` to ai-sdk/immich/umami/chat-sdk (direction item; needs per-site llms.txt verification first).
