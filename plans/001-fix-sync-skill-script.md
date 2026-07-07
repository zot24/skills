# Plan 001: Fix sync-skill.sh failure reporting, remove dead code, strip MDX from extracted docs

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 7cb28b4..HEAD -- .github/workflows/scripts/sync-skill.sh`
> If the file changed since this plan was written, compare the
> "Current state" excerpts against the live code before proceeding; on a
> mismatch, treat it as a STOP condition.

## Status

- **Priority**: P1
- **Effort**: S
- **Risk**: LOW
- **Depends on**: none
- **Category**: bug
- **Planned at**: commit `7cb28b4`, 2026-07-06

## Why this matters

Three defects in the shared sync script `.github/workflows/scripts/sync-skill.sh`, which every skill's bi-weekly documentation sync runs through:

1. **CI never learns about failed fetches.** The script runs under `set -euo pipefail` (line 10), and `generate_summary()` uses `((total++))` (line 480). In bash, `((expr))` returns exit status 1 when the expression evaluates to 0 — which happens on the very first increment (`total` starts at 0, post-increment evaluates to 0). Under `set -e` the script dies right there, so the `has_failures=true` / `has_changes=true` markers (lines 574–584) are never printed. The CI workflow `.github/workflows/sync-docs.yml` greps stdout for `has_failures=true` to populate its failure report — so broken upstream sources are silently invisible. (Change detection still works only because the workflow independently runs `git diff`.)
2. **Dead, misleading version-bump code.** `bump_version()` (lines 444–464) is defined but never called; the real bump logic lives inline in `sync-docs.yml` and updates three files (sync.json, plugin.json, marketplace.json), while the dead function updates only sync.json. Anyone running the script manually and reading it would expect behavior that doesn't happen.
3. **MDX/JSX leaks into synced markdown.** `extract_content()` strips Mintlify tags (`<Tip>`, `<Card>`, …) but not MDX constructs. Mintlify sites' `.md` endpoints can embed `export const Foo = (...) => {...}` component blocks and `import` lines. This has already corrupted a real file: `skills/agent-skills/skills/agent-skills/docs/what-are-skills.md` currently contains a JSX `LogoCarousel` component with `useState`/`useEffect` from the agentskills.io homepage. Plan 002 re-points that skill at pages that also carry MDX exports, so this fix must land first.

## Current state

- `.github/workflows/scripts/sync-skill.sh` — the only file to modify.

Line 10:
```bash
set -euo pipefail
```

Lines 478–486 (inside `generate_summary()`):
```bash
    while IFS='|' read -r url status code timestamp; do
        [[ "$url" =~ ^# ]] && continue
        ((total++))
        case "$status" in
            SUCCESS) ((success++)) ;;
            FAILED) ((failed++)) ;;
            SKIPPED) ((skipped++)) ;;
            INVALID) ((invalid++)) ;;
        esac
```

Lines 443–464: `bump_version()` — full function starting with the comment
`# Update sync.json version (patch bump)` and ending with `echo "$new_version"` + `}`.

Lines 196–201 (inside `extract_content()`, the already-markdown branch) — the perl
cleanup that strips Mintlify tags:
```bash
        perl -pe '
            # Strip Mintlify-specific tags like <Tip>, <Warning>, etc.
            s/<\/?(?:Tip|Warning|Note|Info|Check|Accordion|AccordionGroup|Card|CardGroup|Steps|Step|Tabs|Tab)[^>]*>//gi;
            # Strip code block theme annotations
            s/\s+theme=\{null\}//g;
        ' "$input_file" | \
```

Repo conventions: plain bash with `log_info`/`log_warn`/`log_error` helpers defined at the top of this same file; conventional-commit messages like `fix(ci): description` (see `git log --oneline`).

## Commands you will need

| Purpose | Command | Expected on success |
|---------|---------|---------------------|
| Syntax check | `bash -n .github/workflows/scripts/sync-skill.sh` | exit 0, no output |
| Live run (network) | `.github/workflows/scripts/sync-skill.sh skills/agent-skills --dry-run --force` | exits 0, prints `=== Sync Summary ===` AND a `has_changes=` line |

There is no test suite or linter in this repo; `shellcheck` is not installed on this machine. Verification is `bash -n` plus behavioral runs.

## Scope

**In scope** (the only file you should modify):
- `.github/workflows/scripts/sync-skill.sh`

**Out of scope** (do NOT touch, even though they look related):
- `.github/workflows/sync-docs.yml` — its inline version-bump block is the surviving implementation; leave it.
- `.github/workflows/scripts/sync-marketplace.sh`
- Any `skills/**` file — plan 002 handles the corrupted doc; re-syncing here would produce noise.

## Git workflow

- Branch: `advisor/001-fix-sync-skill-script` off `main`
- One commit, message: `fix(ci): correct set -e arithmetic in sync summary, strip MDX exports, drop dead bump_version`
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: Fix the `set -e` arithmetic bug in `generate_summary`

Replace the five `((var++))` increments (lines 480–485) with POSIX-safe assignments:

```bash
    while IFS='|' read -r url status code timestamp; do
        [[ "$url" =~ ^# ]] && continue
        total=$((total + 1))
        case "$status" in
            SUCCESS) success=$((success + 1)) ;;
            FAILED) failed=$((failed + 1)) ;;
            SKIPPED) skipped=$((skipped + 1)) ;;
            INVALID) invalid=$((invalid + 1)) ;;
        esac
```

**Verify**: `bash -n .github/workflows/scripts/sync-skill.sh` → exit 0.

### Step 2: Delete the dead `bump_version()` function

Remove lines 443–464 entirely (the comment `# Update sync.json version (patch bump)` through the function's closing `}`). Confirm first that it has no call sites:

**Verify**: `grep -n "bump_version" .github/workflows/scripts/sync-skill.sh` → no matches after the edit.

### Step 3: Strip MDX imports/exports in `extract_content`

In the already-markdown branch of `extract_content()` (the `perl -pe` block quoted above), the per-line `perl -pe` cannot remove multi-line JSX blocks. Change that stage to a single `perl -0777 -pe` (slurp mode) that does all cleanup:

```bash
        perl -0777 -pe '
            # Strip MDX component definitions: export const/function ... up to a
            # line consisting of }; or } at column 0
            s/^export\s+(?:const|function)\s+\w+.*?^\};?\s*$//gms;
            # Strip MDX import lines
            s/^import\s+.*?;\s*$//gm;
            # Strip MDX comments like {/* ... */}
            s/\{\/\*.*?\*\/\}//gs;
            # Strip Mintlify-specific tags like <Tip>, <Warning>, etc.
            s/<\/?(?:Tip|Warning|Note|Info|Check|Accordion|AccordionGroup|Card|CardGroup|Steps|Step|Tabs|Tab)[^>]*>//gi;
            # Strip code block theme annotations
            s/\s+theme=\{null\}//g;
        ' "$input_file" | \
```

Keep the following `awk` blank-line collapse stage unchanged — it will absorb the blank space left by removed blocks.

**Verify** with a synthetic file:
```bash
cat > /tmp/mdx-test.md <<'EOF'
# Title

export const LogoCarousel = ({clients}) => {
  const [x, setX] = useState(clients);
  return null;
};

import { Foo } from "./foo";

Real content stays.

<Tip>tip body stays</Tip>
EOF
perl -0777 -pe '
    s/^export\s+(?:const|function)\s+\w+.*?^\};?\s*$//gms;
    s/^import\s+.*?;\s*$//gm;
    s/\{\/\*.*?\*\/\}//gs;
    s/<\/?(?:Tip|Warning|Note|Info|Check|Accordion|AccordionGroup|Card|CardGroup|Steps|Step|Tabs|Tab)[^>]*>//gi;
    s/\s+theme=\{null\}//g;
' /tmp/mdx-test.md
```
→ output contains `# Title`, `Real content stays.`, `tip body stays`; contains NO line with `export`, `useState`, or `import`.

### Step 4: Behavioral check of the summary fix

Run a live dry-run sync (network access required; writes only to gitignored `.cache/` and `sync-report.txt`):

```bash
.github/workflows/scripts/sync-skill.sh skills/agent-skills --dry-run --force
```

**Verify**: exit code 0; output includes `=== Sync Summary ===`, a `Total sources:` count ≥ 1, and a final `has_changes=` line. (Before this fix, the script died before printing any of these when at least one source row existed.)

Then simulate a failing source to prove `has_failures=true` now surfaces:

```bash
tmpdir=$(mktemp -d) && cp -r skills/agent-skills "$tmpdir/fail-test" && \
jq '.sources = [{"url":"https://agentskills.io/definitely-missing-page-404.md","target":"skills/agent-skills/docs/nope.md","type":"raw"}]' \
  "$tmpdir/fail-test/sync.json" > "$tmpdir/fail-test/sync.json.new" && \
mv "$tmpdir/fail-test/sync.json.new" "$tmpdir/fail-test/sync.json" && \
.github/workflows/scripts/sync-skill.sh "$tmpdir/fail-test" --force; rm -rf "$tmpdir"
```

**Verify**: output contains `has_failures=true` and the summary lists the 404 URL under `Failed/Invalid sources:`.

## Test plan

No test framework exists in this repo. The synthetic-input checks in steps 3 and 4 are the tests; both must pass. Do not introduce a test framework.

## Done criteria

Machine-checkable. ALL must hold:

- [ ] `bash -n .github/workflows/scripts/sync-skill.sh` exits 0
- [ ] `grep -c '((.*++))' .github/workflows/scripts/sync-skill.sh` outputs 0
- [ ] `grep -c 'bump_version' .github/workflows/scripts/sync-skill.sh` outputs 0
- [ ] Step 3 synthetic MDX test produces no `export`/`import`/`useState` lines
- [ ] Step 4 dry-run prints `=== Sync Summary ===` and a `has_changes=` line, exit 0
- [ ] `git status --porcelain` shows only `.github/workflows/scripts/sync-skill.sh` modified (plus `plans/README.md` if you update the index)
- [ ] `plans/README.md` status row updated

## STOP conditions

Stop and report back (do not improvise) if:

- The excerpts in "Current state" don't match the live file (drift).
- `grep -n "bump_version"` finds a call site anywhere in the repo outside the function definition (`grep -rn "bump_version" .github/`) — the function is not dead and must not be deleted.
- The step 4 live dry-run fails for network reasons twice — commit the code changes anyway but report that behavioral verification was skipped.
- Fixing anything appears to require editing `sync-docs.yml`.

## Maintenance notes

- Any future arithmetic in this script must avoid bare `((var++))` under `set -e`; use `var=$((var + 1))`.
- The MDX-stripping regexes assume component blocks end with `};` or `}` at column 0 — true for Mintlify export blocks today. If a future upstream page survives with JSX fragments, extend the perl rules rather than disabling validation.
- Reviewer should scrutinize: the `perl -0777` slurp replaces a streaming `perl -pe`; confirm output on a large doc (e.g. re-run step 4) is unchanged apart from MDX removal.
- Deferred: `validate_content()` could additionally reject content matching `^export const .*=>` as defense-in-depth; deferred to keep this plan minimal.
