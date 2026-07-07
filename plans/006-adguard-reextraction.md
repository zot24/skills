# Plan 006: Re-source adguard docs from raw wiki markdown (replace ~20k lines of committed HTML)

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 61449aa..HEAD -- skills/adguard`
> If any in-scope file changed since this plan was written, compare the
> "Current state" excerpts against the live code before proceeding; on a
> mismatch, treat it as a STOP condition.

## Status

- **Priority**: P2
- **Effort**: M
- **Risk**: LOW
- **Depends on**: none
- **Category**: docs
- **Planned at**: commit `61449aa`, 2026-07-06

## Why this matters

8 of adguard's 11 committed docs files are full GitHub-rendered HTML pages, not documentation: each begins `<!DOCTYPE html>` (after the `> Source:` header) and runs 2,148–3,596 lines of page chrome, nav, and inline styles — ~20,000 lines total in which the actual AdGuard content is buried. An agent activating this skill and reading these files wades through GitHub's UI markup. The root cause: the sources point at `github.com/.../wiki/<Page>` HTML pages, and extraction committed the raw pages. GitHub exposes every wiki page as raw markdown at `raw.githubusercontent.com/wiki/<org>/<repo>/<Page>.md` — verified 200 on 2026-07-06 for Configuration.md, Home.md, Docker.md, FAQ.md. Switching the sources eliminates extraction entirely.

## Current state

- `skills/adguard/sync.json` sources (relevant subset):
  ```
  raw             https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/README.md
  extract-content https://github.com/AdguardTeam/AdGuardHome/wiki                # → getting-started.md (check target mapping in the file)
  extract-content https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration
  extract-content https://github.com/AdguardTeam/AdGuardHome/wiki/Docker
  extract-content https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption
  extract-content https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP
  extract-content https://github.com/AdguardTeam/AdGuardHome/wiki/Clients
  extract-content https://github.com/AdguardTeam/AdGuardHome/wiki/FAQ
  extract-content https://github.com/AdguardTeam/AdGuardHome/wiki/VPS
  ```
  (Read the full file for the exact `target` of each — keep targets unchanged.)
- Affected committed docs (all begin `<!DOCTYPE html>` at ~line 5): `configuration.md` (3596L), `faq.md`, `dhcp.md`, `docker.md`, `encryption.md`, `clients.md`, `getting-started.md`, `vps.md` under `skills/adguard/skills/adguard/docs/`.
- Clean files (leave alone): `api-reference.md`, `blocklists.md`, `readme-upstream.md`.
- The wiki index page (`/wiki` with no page name) maps to `Home.md` on the raw endpoint.
- Sync runner: `.github/workflows/scripts/sync-skill.sh` (do not modify).

## Commands you will need

| Purpose | Command | Expected on success |
|---------|---------|---------------------|
| Probe raw page | `curl -s -o /dev/null -w "%{http_code}" https://raw.githubusercontent.com/wiki/AdguardTeam/AdGuardHome/<Page>.md` | 200 |
| Validate JSON | `jq empty skills/adguard/sync.json` | exit 0 |
| Sync | `.github/workflows/scripts/sync-skill.sh skills/adguard --force` | exit 0, 0 FAILED |
| HTML check | `grep -l '<!DOCTYPE' skills/adguard/skills/adguard/docs/*.md` | no matches |

## Scope

**In scope**: `skills/adguard/sync.json`; the 8 polluted docs files (rewritten by sync); `skills/adguard/skills/adguard/SKILL.md` only if a docs filename changes (it shouldn't — keep targets).
**Out of scope**: every other skill; the sync script; version fields; the 3 clean docs files.

## Git workflow

- Branch: `advisor/006-adguard-reextraction` off `main`
- One commit: `fix(adguard): source wiki docs from raw markdown instead of HTML pages`
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: Repoint the 8 wiki sources

In `skills/adguard/sync.json`, for each `github.com/AdguardTeam/AdGuardHome/wiki[/<Page>]` source: replace the URL with `https://raw.githubusercontent.com/wiki/AdguardTeam/AdGuardHome/<Page>.md` (bare `/wiki` → `Home.md`) and change its `"type"` from `extract-content` to `raw`. Keep each entry's `target` and `freshness_days` unchanged. Probe every new URL first (see command table) — all 9 wiki pages must return 200; the 4 listed in "Why this matters" are already verified.

**Verify**: `jq empty skills/adguard/sync.json` → exit 0; `jq -r '.sources[].url' skills/adguard/sync.json | grep -c 'raw.githubusercontent.com/wiki'` → 9 (or the actual count of wiki sources in the file — confirm against your read of it).

### Step 2: Re-sync and confirm the pollution is gone

```bash
.github/workflows/scripts/sync-skill.sh skills/adguard --force
```

**Verify**:
- Summary: 0 FAILED/INVALID.
- `grep -l '<!DOCTYPE' skills/adguard/skills/adguard/docs/*.md` → no matches.
- `wc -l skills/adguard/skills/adguard/docs/configuration.md` → dramatically smaller (real wiki content, likely a few hundred lines, not 3596).
- Spot-read the first 30 lines of `configuration.md` and `faq.md`: `> Source:` header followed by real AdGuard prose/headings, no `<div>`/`<script>`.

### Step 3: Confirm SKILL.md references still resolve

```bash
grep -o 'docs/[a-z0-9-]*\.md' skills/adguard/skills/adguard/SKILL.md | sort -u | \
  while read f; do [ -f "skills/adguard/skills/adguard/$f" ] || echo "MISSING $f"; done
```
**Verify**: no output.

## Test plan

No test framework. Steps 2–3 are the tests. Additionally confirm content sanity: `grep -c 'AdGuard' skills/adguard/skills/adguard/docs/getting-started.md` → ≥ 3 (real content present).

## Done criteria

- [ ] All wiki sources use `raw.githubusercontent.com/wiki/...` with type `raw`
- [ ] `grep -rl '<!DOCTYPE' skills/adguard/` → no matches
- [ ] Sync exits 0 with 0 FAILED/INVALID
- [ ] SKILL.md reference loop prints nothing
- [ ] `git status --porcelain` touches only `skills/adguard/**` (plus `plans/README.md`)

## STOP conditions

- Any raw wiki URL 404s (page renamed in the wiki) — probe the wiki sidebar for the new name; if not findable, STOP and report rather than dropping the source.
- A re-synced file is < 20 lines (page exists but is a stub/redirect) — report which.
- The bare `/wiki` source's target conflicts with the `Home.md` mapping in a way you can't resolve from the file — report.

## Maintenance notes

- Raw wiki markdown skips extraction entirely — this is the preferred source shape for ALL GitHub-wiki-backed skills; if another skill adds wiki sources, use this pattern from the start.
- Wiki page renames upstream will now surface as 404 FAILED entries in the sync summary (visible since the failure-reporting fix) instead of silently committing HTML.
- Reviewer should scrutinize: the diff should be almost entirely deletions (~20k lines removed, a few hundred added).
