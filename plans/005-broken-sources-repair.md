# Plan 005: Repair the 36 broken upstream sources and the discovery scripts that should have caught them

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 61449aa..HEAD -- skills/flue skills/chat-sdk skills/firecrawl skills/obsidian skills/agent-browser skills/hermes skills/honcho skills/servarr`
> If any in-scope file changed since this plan was written, compare the
> "Current state" excerpts against the live code before proceeding; on a
> mismatch, treat it as a STOP condition.

## Status

- **Priority**: P1
- **Effort**: L
- **Risk**: LOW (docs/config only; no shared-script changes)
- **Depends on**: none
- **Category**: correctness
- **Planned at**: commit `61449aa`, 2026-07-06

## Why this matters

CI sync run 28831719688 (2026-07-07, the first run with working failure reporting) revealed 36 upstream sources that fail on every sync, across 6 skills. Local verification confirmed these are genuine 404s/restructures, not CI network blocks. Until fixed, every bi-weekly sync warns on all of them, the affected docs rot silently, and real new failures drown in the noise. Additionally, four discovery scripts have the substring-dedup bug already fixed elsewhere, and two discovery scripts are entirely broken against their live sites — which is why these restructures went unnoticed.

Per-skill verified diagnosis (all URL checks done 2026-07-06 from a residential connection):

| Skill | Broken | Diagnosis |
|---|---|---|
| flue | 17 URLs (`/docs/api/*-channel`, `/docs/cli/connect`, `/docs/cli/logs`) | 404 — site restructured; `https://flueframework.com/llms.txt` now also 404s, so flue's discover script is blind |
| chat-sdk | 6 URLs (`chat-sdk.dev/docs/*.md`) | 404 — docs restructured; `https://chat-sdk.dev/llms.txt` returns 200 (new structure is discoverable); skill has NO discover script |
| firecrawl | 4 URLs | `api-reference/endpoint/extract-get.md` is a self-redirect loop (Location: same path); 3 `developer-guides/mcp-setup-guides/*.md` are 404 |
| obsidian | 6 URLs (help.obsidian.md pages + publish.obsidian.md + coddingtonbear.github.io) | HTTP 200 but content validation fails — JS-rendered app shell, no static content. The committed docs for these topics are clean *authored* fallbacks, per a note in obsidian's sync.json |
| agent-browser | 1 URL (`agent-browser.dev/agent-mode`) | 404 — page removed/renamed |
| hermes | 1 URL (`hermes-agent.nousresearch.com/docs/ko/`) | 404 — Korean docs section removed |

## Current state

- Sources live in each skill's `sync.json` under `skills/<name>/sync.json`; targets resolve to `skills/<name>/skills/<name>/docs/…` via the sync script's `$SKILL_DIR/$target` convention.
- Discovery-script dedup bug (same defect fixed in firecrawl/servarr in a prior round — see `git log --oneline --grep="exact-match"`):
  - `skills/hermes/discover-pages.sh:57`: `if ! echo "$EXISTING_URLS" | grep -qF "$full_url"; then`
  - `skills/honcho/discover-pages.sh:52`: `if ! echo "$EXISTING_URLS" | grep -qF "$url"; then`
  - Correct exemplar: `skills/1password-cli/discover-pages.sh:55` uses `grep -qxF`.
- hermes/honcho discover scripts also abort (instead of warning) on curl failure: `skills/hermes/discover-pages.sh:34` and `skills/honcho/discover-pages.sh:34` do `VAR=$(curl -sSL "$URL" 2>/dev/null)` with no `|| true` under `set -euo pipefail`. Exemplars flue:34 / wealthfolio:33 append `|| true`.
- servarr crawler broken (recorded in plans/README.md from the previous round): its page-extraction regex expects `/en/sonarr/...` paths but wiki.servarr.com now emits `/sonarr/...`, so discovery always finds 0 pages. Find the regex in `skills/servarr/discover-pages.sh` (around the `PATHS`/`ALL_DISCOVERED` extraction).
- The generic sync runner is `.github/workflows/scripts/sync-skill.sh` (fixed in a prior round — do NOT modify it).

## Commands you will need

| Purpose | Command | Expected on success |
|---------|---------|---------------------|
| Probe a URL | `curl -s -o /dev/null -w "%{http_code}" -L --max-time 15 <url>` | 200 for keepers |
| Validate JSON | `jq empty skills/<name>/sync.json` | exit 0 |
| Sync one skill | `.github/workflows/scripts/sync-skill.sh skills/<name> --force` | exit 0, summary shows `Successful: <n>` with 0 failed |
| Script syntax | `bash -n skills/<name>/discover-pages.sh` | exit 0 |

## Scope

**In scope**:
- `skills/{flue,chat-sdk,firecrawl,obsidian,agent-browser,hermes}/sync.json`
- Docs files those syncs create/update under each skill's `skills/<name>/docs/`
- `skills/hermes/discover-pages.sh`, `skills/honcho/discover-pages.sh` (dedup + curl guard)
- `skills/servarr/discover-pages.sh` (crawler regex)
- `skills/flue/discover-pages.sh` (repoint index source)
- `skills/chat-sdk/discover-pages.sh` (create)
- SKILL.md docs lists of affected skills ONLY where a docs file is added/renamed/removed

**Out of scope**:
- `.github/workflows/scripts/sync-skill.sh` and all workflows
- Version fields (CI bumps them on sync; leave versions alone)
- adguard (separate plan 006), agent-skills, and all other skills
- Do not delete any committed docs file that has no replacement — stale docs beat no docs

## Git workflow

- Branch: `advisor/005-broken-sources-repair` off `main`
- One conventional commit per skill: `fix(<skill>): repair broken upstream sources`, `fix(hermes,honcho): exact-match URL dedup in discovery`, etc.
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: Trivial script fixes (hermes, honcho)

1. `skills/hermes/discover-pages.sh:57` and `skills/honcho/discover-pages.sh:52`: change `grep -qF` → `grep -qxF`. Caveat: `-x` needs one-clean-URL-per-line on the left side — hermes normalizes with `sed 's:/*$:/:'` (line 51); confirm the *discovered* side gets the same normalization before comparing; if it doesn't, apply the same `sed` to the discovered URL rather than dropping `-x`.
2. Both scripts' line 34: append ` || true` to the `$(curl …)` command substitution, matching `skills/flue/discover-pages.sh:34`.

**Verify**: `bash -n` both scripts → exit 0. Run each without flags: exits cleanly, reports either new pages or "already tracked", and does NOT report any URL that appears verbatim in its own sync.json.

### Step 2: Fix servarr's crawler regex

Read `skills/servarr/discover-pages.sh`, find where it extracts wiki paths (expects `/en/<app>/...`). Update to match the live site's `/sonarr/...`-style paths. Confirm the new pattern against reality first:
```bash
curl -sL https://wiki.servarr.com/sonarr | grep -oE 'href="/[a-z]+/[^"]*"' | head -5
```
Adjust the extraction accordingly (accept both `/en/`-prefixed and bare app-prefixed paths for robustness).

**Verify**: `./skills/servarr/discover-pages.sh` (no flags) discovers > 0 candidate pages, and none of the reported NEW URLs already appear in `skills/servarr/sync.json`.

### Step 3: flue — rediscover the restructured site, repair sources

1. Probe for the new docs structure: try `https://flueframework.com/sitemap.xml`, `https://flueframework.com/docs`, and follow links from the docs landing page. The old paths were `docs/api/<name>-channel` and `docs/cli/{connect,logs}` — likely renamed (e.g. `docs/channels/<name>` — note `docs/channels/slack` was probed 2026-07-06 and 404'd too, so do NOT guess; extract real links from the live landing page).
2. For each of the 17 dead sources in `skills/flue/sync.json`, either (a) replace the URL with its verified-200 successor keeping the same `target`, or (b) if the topic no longer exists upstream, delete the source entry but KEEP the committed docs file, appending a line `> NOTE: upstream page removed; content frozen as of last sync` under its `> Source:` header.
3. Update `skills/flue/discover-pages.sh` to index from whatever the live site offers (sitemap.xml or landing-page crawl) instead of the dead `llms.txt`.

**Verify**: `.github/workflows/scripts/sync-skill.sh skills/flue --force` → summary shows 0 FAILED/INVALID. `./skills/flue/discover-pages.sh` runs clean.

### Step 4: chat-sdk — repair via its live llms.txt

1. `curl -s https://chat-sdk.dev/llms.txt` — it returns 200 and lists current doc pages. Map each of the 6 dead sources to its successor page (same topic: setup, architecture, models-and-providers, artifacts, theming, deploying). Keep targets stable.
2. Create `skills/chat-sdk/discover-pages.sh` modeled on `skills/1password-cli/discover-pages.sh` (llms.txt-driven, `grep -qxF` dedup, `--auto-add` flag support, `set -euo pipefail`). CI auto-globs `skills/*/discover-pages.sh` — no registration needed.

**Verify**: sync chat-sdk → 0 FAILED. `bash -n` + a flagless run of the new discover script reports no already-tracked URL as NEW.

### Step 5: firecrawl — fix 4 URLs

1. `extract-get.md`: self-redirect loop. Check `https://docs.firecrawl.dev/llms.txt` for the extract endpoint's current path; replace or, if gone, drop the source (keep the doc file with the frozen-content note).
2. The 3 `mcp-setup-guides/*.md`: probe llms.txt for their new location (MCP setup docs likely moved); same replace-or-freeze rule.

**Verify**: sync firecrawl → 0 FAILED.

### Step 6: obsidian — remove the JS-rendered sources

The 6 failing sources (5 × `help.obsidian.md`/`publish.obsidian.md`, 1 × `coddingtonbear.github.io/obsidian-local-rest-api`) return app-shell HTML that can never pass content validation, and obsidian's sync.json already notes the corresponding docs are authored fallbacks. Delete those 6 source entries from `skills/obsidian/sync.json`; leave the committed docs untouched. If any of the 6 has an official markdown mirror (check `https://help.obsidian.md/llms.txt`), prefer repointing over deleting.

**Verify**: sync obsidian → 0 FAILED/INVALID; `git diff --stat` shows only sync.json changed for obsidian (docs untouched).

### Step 7: agent-browser and hermes — 1 URL each

1. agent-browser: probe `https://agent-browser.dev/` for where "agent mode" content moved (llms.txt if present). Replace or freeze.
2. hermes: `docs/ko/` (Korean) removed upstream. Delete the source from `skills/hermes/sync.json`; if a committed Korean doc exists in hermes's docs/, keep it with the frozen note; if the target was never created, just delete the source.

**Verify**: sync both → 0 FAILED.

### Step 8: Full-fleet confirmation

Run the whole sync loop locally over the six repaired skills:
```bash
for s in flue chat-sdk firecrawl obsidian agent-browser hermes; do
  .github/workflows/scripts/sync-skill.sh "skills/$s" --force | grep -E "Failed:|Invalid" && echo "STILL BROKEN: $s"
done
```
**Verify**: no `STILL BROKEN` lines.

## Test plan

No test framework. The per-step sync runs are the tests. Also confirm no SKILL.md references a docs file that was removed (none should be): for each touched skill run the reference-existence loop:
```bash
grep -o 'docs/[a-z0-9-]*\.md' skills/<name>/skills/<name>/SKILL.md | sort -u | \
  while read f; do [ -f "skills/<name>/skills/<name>/$f" ] || echo "MISSING $f"; done
```

## Done criteria

- [ ] Step 8 loop prints no `STILL BROKEN`
- [ ] `grep -n 'grep -qF ' skills/*/discover-pages.sh` → no matches (all `-qxF`)
- [ ] servarr discovery finds > 0 pages; flue discovery no longer references the dead llms.txt
- [ ] `skills/chat-sdk/discover-pages.sh` exists, executable, `bash -n` clean
- [ ] All touched sync.json files pass `jq empty`
- [ ] No committed docs file deleted anywhere (`git diff --stat` shows no deletions under `*/docs/`)
- [ ] `plans/README.md` status row updated

## STOP conditions

- A replacement URL cannot be found for ≥ half of a skill's dead sources (the site may be gone entirely — report, don't mass-freeze).
- Any live probe suggests a site now requires auth or blocks non-browser agents (repeated 403s).
- Fixing discovery requires touching `.github/workflows/scripts/sync-skill.sh` or any workflow.
- flue's site has no sitemap AND no crawlable docs landing page — report with what you found.

## Maintenance notes

- The freeze-note convention (`> NOTE: upstream page removed…`) marks docs that will never update again; a future audit can decide to delete them deliberately.
- After this lands, the bi-weekly sync should be near-zero-warning; any new warning is signal again. Watch the first scheduled run.
- Deferred: making sync failures open a GitHub issue automatically (direction item in plans/README.md).
