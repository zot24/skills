# Plan 009: Bring all four skill manifests into agreement and add a CI consistency check

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 61449aa..HEAD -- skills.toml release-please-config.json .release-please-manifest.json README.md CLAUDE.md .github/workflows/`
> Plan 007's workflow changes are EXPECTED. Any other drift: compare
> against "Current state" excerpts; on a mismatch treat as STOP.

## Status

- **Priority**: P1 (unblocks plan 008; ends a recurring drift class)
- **Effort**: M
- **Risk**: LOW
- **Depends on**: none (plan 008 depends on THIS)
- **Category**: tech-debt / dx
- **Planned at**: commit `61449aa`, 2026-07-06

## Why this matters

The repo has four manifests that must agree on the skill set, and all four have drifted — always by omitting the newest skills, because the registration checklist in CLAUDE.md doesn't mention two of them:

1. `.claude-plugin/marketplace.json` — 22 plugins (the reference set; complete).
2. `skills.toml` (zskills install manifest) — 20 entries; **missing `1password-cli`, `portainerctl`** → `zskills sync` silently never installs the two newest skills.
3. `release-please-config.json` — 18 packages; **missing `flue`, `wealthfolio`, `1password-cli`, `portainerctl`** → those four get no automated releases/CHANGELOGs (verified: 0 of the 4 present).
4. `.github/workflows/sync-docs.yml` SKILLS array — 20 (correct: 22 minus the two genuinely no-upstream skills `safe-delete`, `gh-issue-tracker`).

Plus `README.md:612`'s "Skills with CI sync enabled" list shows only 15 of the 20. This class of drift has now been caught twice by audits; a 30-line check script run on every PR ends it permanently.

## Current state

- `skills.toml` — 20 `[[skills]]` blocks, ends with `wealthfolio`; entry shape:
  ```toml
  [[skills]]
  name = "wealthfolio"
  marketplace = "zot24-skills"
  ```
- `release-please-config.json` — `.packages` has 18 keys of shape `skills/<name>`; each package stanza carries `component`, and `extra-files` for `sync.json` + `.claude-plugin/plugin.json` `$.version` (read an existing stanza, e.g. `skills/hermes`, as the template).
- `.release-please-manifest.json` — 18 keys `skills/<name>: "<version>"`.
- `README.md:611-612`:
  ```
  **Skills with CI sync enabled:**
  - umbrel-app, claude-code-expert, agent-browser, chat-sdk, ai-sdk, agent-skills, hermes, honcho, firecrawl, servarr, obsidian, adguard, immich, glinet, umami
  ```
  Actual SKILLS array (`.github/workflows/sync-docs.yml`, search `SKILLS=(`) has 20: adds flue, wealthfolio, 1password-cli, portainerctl, x-engagement.
- `CLAUDE.md:304-309` — "**Register the skill** (all four places):" listing marketplace.json, SKILLS array, CLAUDE.md table, README — no skills.toml, no release-please.
- Current versions of the 4 unregistered skills (for manifest entries): read each `skills/<name>/sync.json` `.version` at execution time — do not assume 1.0.0.

## Commands you will need

| Purpose | Command | Expected |
|---|---|---|
| TOML count | `grep -c '\[\[skills\]\]' skills.toml` | 22 when done |
| RP counts | `jq '.packages | length' release-please-config.json; jq 'keys | length' .release-please-manifest.json` | 22 / 22 |
| JSON valid | `jq empty release-please-config.json .release-please-manifest.json` | exit 0 |
| Check script | `.github/workflows/scripts/check-consistency.sh` | exit 0, `All manifests consistent` |

## Scope

**In scope**: `skills.toml`, `release-please-config.json`, `.release-please-manifest.json`, `README.md` (the line-612 list only), `CLAUDE.md` (registration checklist section only), NEW `.github/workflows/scripts/check-consistency.sh`, NEW `.github/workflows/validate.yml`.
**Out of scope**: marketplace.json (it's the reference), sync-docs.yml SKILLS array (already correct), all skill directories, all version values except the two manifest entries you add verbatim from files.

## Git workflow

- Branch: `advisor/009-manifest-consistency` off `main`
- Commits: `fix: register missing skills in skills.toml and release-please` + `feat(ci): add manifest consistency check`
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: skills.toml

Append entries for `1password-cli` and `portainerctl` matching the existing shape (name + `marketplace = "zot24-skills"`).

**Verify**: `grep -c '\[\[skills\]\]' skills.toml` → 22.

### Step 2: release-please registration

1. In `release-please-config.json`, add package stanzas for `skills/flue`, `skills/wealthfolio`, `skills/1password-cli`, `skills/portainerctl`, copying the `skills/hermes` stanza shape (component = skill name; same extra-files pair).
2. In `.release-please-manifest.json`, add the four keys with each skill's CURRENT `sync.json` version (read them; use exactly what's in the file).

**Verify**: both `jq` counts → 22; `jq empty` both files → exit 0; `jq -r '.["skills/flue"]' .release-please-manifest.json` equals `jq -r '.version' skills/flue/sync.json`.

### Step 3: README + CLAUDE.md

1. `README.md:612`: replace the 15-name list with the 20 names from the SKILLS array, same formatting.
2. `CLAUDE.md` registration section: change "**Register the skill** (all four places):" to "(all six places):" and add two bullets: `- Add to `skills.toml` (zskills install manifest)` and `- Add package + manifest entries to `release-please-config.json` / `.release-please-manifest.json``. Mirror the same two lines in the "Registration Steps" checklist below it.

**Verify**: `grep -c 'skills.toml' CLAUDE.md` → ≥ 2; README list contains `portainerctl` and `x-engagement`.

### Step 4: The consistency check script

Create `.github/workflows/scripts/check-consistency.sh` (executable, `set -euo pipefail`, deps jq only — no TOML parser: grep the simple `name = "..."` lines). Logic:

1. REF = sorted plugin names from `.claude-plugin/marketplace.json`.
2. Check each skill dir `skills/*/` (with `.claude-plugin/plugin.json`) appears in REF and vice versa.
3. Check skills.toml names == REF.
4. Check release-please-config packages == REF **minus an explicit allowlist** (empty today) — hardcode `EXEMPT_RELEASE=""` as a documented variable.
5. Check sync-docs.yml SKILLS array == REF minus `EXEMPT_SYNC="safe-delete gh-issue-tracker"` (documented: skills with no upstream sources).
6. Check per-skill version agreement: `sync.json` == `plugin.json` == marketplace entry.
7. Print each mismatch as `MISMATCH: <manifest> <missing/extra> <name>`; exit 1 on any; else print `All manifests consistent` and exit 0.

**Verify**: run it → exit 0 after steps 1–3. Then prove it detects: temporarily remove a name from skills.toml, run → exit 1 with a MISMATCH line, restore.

### Step 5: The CI job

Create `.github/workflows/validate.yml`:

```yaml
name: Validate
on:
  pull_request:
  push:
    branches: [main]
jobs:
  consistency:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Check manifest consistency
        run: |
          chmod +x .github/workflows/scripts/check-consistency.sh
          .github/workflows/scripts/check-consistency.sh
```

**Verify**: `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/validate.yml')); print('OK')"` → `OK`.

## Test plan

Step 4's mutation test (remove/restore a skills.toml entry) is the test for the checker; the greps/counts are the tests for the registrations. No test framework — do not add one.

## Done criteria

- [ ] 22 / 22 / 22 counts (skills.toml, rp-config, rp-manifest)
- [ ] check-consistency.sh exits 0 on the repo; exits 1 on the mutation test
- [ ] validate.yml parses; README list has 20 names; CLAUDE.md says six places
- [ ] `git status --porcelain` touches only in-scope files (plus `plans/README.md`)

## STOP conditions

- Version disagreement discovered by check #6 that predates this plan (e.g. a skill whose plugin.json ≠ sync.json) — report it, don't silently "fix" versions.
- skills.toml has structure beyond the simple 3-line blocks (comments/options that grep parsing would mangle) — report before editing.
- A skill directory exists without `.claude-plugin/plugin.json` — it's not a plugin; report, don't add it anywhere.

## Maintenance notes

- The two allowlists in check-consistency.sh (`EXEMPT_SYNC`, `EXEMPT_RELEASE`) are the only knobs; new no-upstream skills go in `EXEMPT_SYNC` deliberately.
- Plan 008 depends on this landing (it needs all 22 skills release-please-registered before removing the inline bumps).
- The first release-please run after this may open release PRs for the four newly registered skills — expected, not a bug.
- Reviewer should scrutinize: the four new manifest baselines exactly match current file versions (a wrong baseline causes the regression bug plan 008 describes).
