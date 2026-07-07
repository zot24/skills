# Plan 008: Make release-please the single owner of version fields (stop inline bumps in sync workflows)

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 61449aa..HEAD -- .github/workflows/sync-docs.yml .github/workflows/sync-hermes-on-release.yml release-please-config.json .release-please-manifest.json`
> Changes from plans 007 (env-indirection in the same workflows) and 009
> (4 new packages in release-please config) are EXPECTED and REQUIRED —
> see "Depends on". Any other drift: compare excerpts before proceeding.

## Status

- **Priority**: P2
- **Effort**: M
- **Risk**: MED — changes release pipeline behavior; read the whole plan before editing
- **Depends on**: plans/009-manifest-consistency.md (MUST be done first — otherwise flue/wealthfolio/1password-cli/portainerctl lose version automation entirely). plans/007 should also land first (same files; rebase over it).
- **Category**: tech-debt
- **Planned at**: commit `61449aa`, 2026-07-06

## Why this matters

Three independent writers mutate the same version fields today:

1. **release-please** (`release-please-config.json` per-package `extra-files`) rewrites `$.version` in each skill's `sync.json` and `.claude-plugin/plugin.json` from its manifest baseline when a release PR merges.
2. **sync-docs.yml** (lines ~112–146) patch-bumps the same two files PLUS the skill's `marketplace.json` entry, inline, directly on main, on every bi-weekly sync with changes.
3. **sync-hermes-on-release.yml** (lines ~135–148) patch-bumps hermes's `sync.json` a third way.

Consequences observed in the live repo: `.release-please-manifest.json` records `skills/agent-skills: 1.2.3` while the actual files say `1.3.0` (bumped by writer #2 during PR #125). When release-please next processes a releasable commit for agent-skills, it computes the next version from **its manifest baseline** (1.2.3 → 1.2.4) and writes that into the extra-files — a version **regression** from 1.3.0, plus a git tag that doesn't match file contents. Double-bumps in the other direction happen too. One owner must win.

**Decision (already made — do not relitigate):** release-please owns versions. Its release PRs bump files, generate CHANGELOGs, and tag; the sync workflows just commit content with conventional-commit messages (`fix(<skill>): sync docs`), which release-please turns into patch releases. Marketplace propagation is handled by the existing `sync-marketplace.yml` safety net, which triggers when a push to main touches `skills/*/.claude-plugin/plugin.json` (i.e. when a release-please PR merges).

## Current state

- `.github/workflows/sync-docs.yml` — the inline bump block sits inside the per-skill loop:
  ```
  116  if [ -f "skills/$SKILL/sync.json" ]; then
  117    CURRENT=$(jq -r '.version' "skills/$SKILL/sync.json")
  ...    (patch-bump; writes sync.json, then plugin.json, then marketplace.json)
  146  fi
  ```
  preceded by the comment `# Patch-bump version across sync.json, plugin.json…`. NOTE: if plan 007 landed, line numbers shifted — locate by the comment text.
- `.github/workflows/sync-hermes-on-release.yml` — step `Bump skill version and record synced release` (~lines 133–148): writes the marker file `.last-synced-release` AND patch-bumps `skills/hermes/sync.json`. The marker write must SURVIVE; only the bump goes.
- `release-please-config.json` — per-package `extra-files` entries of shape:
  ```json
  { "type": "json", "path": "sync.json", "jsonpath": "$.version" },
  { "type": "json", "path": ".claude-plugin/plugin.json", "jsonpath": "$.version" }
  ```
  These are the KEEP side. After plan 009, all 22 skills have package stanzas.
- `.release-please-manifest.json` — 18 (22 after plan 009) baseline versions, several now BEHIND the file versions (agent-skills 1.2.3 vs files 1.3.0; check others with the audit command below).
- `sync-marketplace.yml` triggers on push to main touching `skills/*/.claude-plugin/plugin.json` or `.claude-plugin/marketplace.json`; `sync-marketplace.sh` copies each plugin.json version into marketplace.json. It pushes with `[skip ci]`.
- `release-please.yml` runs on push to main. CHECK which token it uses: if it creates release PRs and merges with only `GITHUB_TOKEN`, pushes it makes will NOT trigger `sync-marketplace.yml` (GitHub suppresses GITHUB_TOKEN-initiated triggers). See STOP conditions.

## Commands you will need

| Purpose | Command | Expected |
|---|---|---|
| YAML parse | `python3 -c "import yaml; [yaml.safe_load(open(f)) for f in ['.github/workflows/sync-docs.yml','.github/workflows/sync-hermes-on-release.yml']]; print('OK')"` | `OK` |
| Manifest-vs-file audit | `jq -r 'to_entries[] | "\(.key) \(.value)"' .release-please-manifest.json | while read p v; do fv=$(jq -r '.version' "$p/sync.json" 2>/dev/null); [ "$v" != "$fv" ] && echo "DRIFT $p manifest=$v file=$fv"; done` | (used in step 3; drift lines expected before fix, none after) |
| JSON valid | `jq empty release-please-config.json .release-please-manifest.json` | exit 0 |

## Scope

**In scope**: `.github/workflows/sync-docs.yml` (delete bump block only), `.github/workflows/sync-hermes-on-release.yml` (delete bump lines only, keep marker), `.release-please-manifest.json` (re-baseline to current file versions).
**Out of scope**: `release-please-config.json` beyond reading it (009 owns additions; extra-files stay as-is), `sync-marketplace.{yml,sh}`, all skill files, all version values in sync.json/plugin.json/marketplace.json themselves.

## Git workflow

- Branch: `advisor/008-version-ownership` off `main` (after 007 and 009 are merged)
- One commit: `fix(ci): release-please owns version fields; drop inline bumps from sync workflows`
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: Precondition checks

1. Confirm 009 landed: `jq '.packages | length' release-please-config.json` → 22.
2. Confirm the token situation: open `.github/workflows/release-please.yml` and note the token used by the release-please action. If it is `secrets.RELEASE_PLEASE_TOKEN` (a PAT), downstream triggering works — proceed. If ONLY `secrets.GITHUB_TOKEN`, STOP (see STOP conditions).

### Step 2: Remove the inline bump from sync-docs.yml

Delete the whole `if [ -f "skills/$SKILL/sync.json" ]; then … fi` bump block (comment line through its closing `fi`) inside the per-skill loop — the block that writes sync.json, plugin.json, and marketplace.json versions. Everything around it (CHANGES extraction, ALL_CHANGES accumulation) stays.

**Verify**: YAML parses; `grep -c 'Patch-bump version' .github/workflows/sync-docs.yml` → 0; `grep -c 'marketplace.json' .github/workflows/sync-docs.yml` → 0 bump-related hits (read remaining hits to confirm they're unrelated, e.g. paths in comments).

### Step 3: Remove the bump from sync-hermes-on-release.yml, keep the marker

In the `Bump skill version and record synced release` step, keep `echo "$VERSION" > skills/hermes/.last-synced-release` and delete the patch-bump lines (CURRENT/IFS/patch/NEW_VERSION/jq/mv/echo Bumped). Rename the step to `Record synced release`.

**Verify**: YAML parses; `grep -c 'Bumped skill version' .github/workflows/sync-hermes-on-release.yml` → 0; the marker-file line still present.

### Step 4: Re-baseline the release-please manifest

Run the manifest-vs-file audit command. For every DRIFT line, set the manifest value to the CURRENT FILE version (files are ahead; the manifest must catch up so release-please's next computation starts from reality):

```bash
jq -r 'keys[]' .release-please-manifest.json | while read p; do
  fv=$(jq -r '.version' "$p/sync.json" 2>/dev/null)
  [ -n "$fv" ] && [ "$fv" != "null" ] && tmp=$(mktemp) && jq --arg p "$p" --arg v "$fv" '.[$p] = $v' .release-please-manifest.json > "$tmp" && mv "$tmp" .release-please-manifest.json
done
```

**Verify**: re-run the audit command → zero DRIFT lines; `jq empty .release-please-manifest.json` → exit 0.

## Test plan

No local way to run release-please. The proof points: YAML parses, greps show the bumps gone, manifest audit is clean. The first real validation is the next sync + release cycle — note in your report that the operator should watch the first release-please PR after this lands and confirm the versions it proposes are `file-version + 1` for changed skills, no regressions.

## Done criteria

- [ ] No version-bump jq writes remain in either workflow (greps above)
- [ ] Manifest audit prints zero DRIFT
- [ ] Both workflows + both JSON files parse
- [ ] `git status --porcelain` touches only the 3 in-scope files (plus `plans/README.md`)

## STOP conditions

- `release-please.yml` uses only `GITHUB_TOKEN` → the marketplace-propagation chain breaks silently when inline bumps are removed (release PR merges would no longer trigger sync-marketplace). STOP and report; the fix (adding a PAT or explicit marketplace step) is a scope change the operator must approve.
- `jq '.packages | length'` ≠ 22 (009 not landed) — STOP, dependency unmet.
- The bump block in sync-docs.yml doesn't match the excerpt shape (007 or other changes moved things beyond recognition) — STOP.
- Any skill's sync.json version differs from its plugin.json version (pre-existing inconsistency the re-baseline can't resolve cleanly) — list them and STOP.

## Maintenance notes

- After this: version bumps happen ONLY via merged release-please PRs. If a skill's version looks stale, check for an unmerged release PR before suspecting a bug.
- The `[skip ci]` on sync-marketplace's own commits plus GITHUB_TOKEN-suppression prevents loops — don't "fix" that.
- Deferred: removing `marketplace.json` version duplication entirely (single source in plugin.json) — bigger consumer-facing change, not this plan.
