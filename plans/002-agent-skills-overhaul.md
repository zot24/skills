# Plan 002: Rebuild agent-skills as the dual-spec authority (open spec + official Anthropic docs)

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 7cb28b4..HEAD -- skills/agent-skills/ .claude-plugin/marketplace.json`
> Changes to `.github/workflows/scripts/sync-skill.sh` are EXPECTED (plan 001).
> If `skills/agent-skills/**` changed since this plan was written, compare the
> "Current state" excerpts against the live files before proceeding; on a
> mismatch, treat it as a STOP condition.

## Status

- **Priority**: P1
- **Effort**: M
- **Risk**: LOW
- **Depends on**: plans/001-fix-sync-skill-script.md (MDX stripping must exist before syncing the new sources)
- **Category**: docs
- **Planned at**: commit `7cb28b4`, 2026-07-06

## Why this matters

The `agent-skills` skill is this repo's authority on the SKILL.md format, but it is stale and partially corrupted:

1. **agentskills.io restructured its site.** The old `what-are-skills.md` URL now 307-redirects to the site homepage, so the synced `docs/what-are-skills.md` literally contains the homepage — including a raw JSX `LogoCarousel` component. `integrate-skills.md` survives only via a redirect to `client-implementation/adding-skills-support.md`. Five new skill-creation pages (quickstart, best-practices, using-scripts, evaluating-skills, optimizing-descriptions) exist upstream and aren't synced.
2. **Official Anthropic documentation is almost entirely missing.** Only one of ~8 official pages is cached. Everything Claude-Code-specific — `context: fork`, `disable-model-invocation`, `argument-hint`, `$ARGUMENTS`, dynamic context injection, hooks, plus the Agent SDK and API skill-management docs — is absent, so the skill can't answer the questions this repo's own maintainers most need.
3. **No `discover-pages.sh`** even though agentskills.io serves `llms.txt` — the exact mechanism (already auto-run by CI for other skills) that would have caught the restructure.

Retrieval channel decision (already made — do not revisit): sources stay as curl-fetched `.md` endpoints. The `.md`/`llms.txt` endpoints ARE Anthropic's official machine-readable docs channel; an MCP/live-lookup approach would contradict this repo's committed-cached-docs architecture. Sources are scoped to skills-related pages only.

## Current state

- `skills/agent-skills/sync.json` — 5 sources; lines 13–29 point at the dead/redirecting agentskills.io paths (`/specification.md` is the only agentskills.io path still canonical). Version `1.2.3` (line 3).
- `skills/agent-skills/skills/agent-skills/SKILL.md` — 107 lines; describes only the open format; "Documentation" section (lines 54–61) lists 6 docs.
- `skills/agent-skills/skills/agent-skills/docs/` — 7 files: `readme-upstream.md`, `specification.md`, `what-are-skills.md` (CORRUPTED — contains homepage + JSX), `integrate-skills.md`, `best-practices.md` (Anthropic platform page, fine), `examples.md` (hand-written), `audit-checklist.md` (internal).
- `skills/agent-skills/commands/agent-skills.md` — command table + docs list at lines 23–30.
- `skills/agent-skills/.claude-plugin/plugin.json` — version `1.2.3`.
- `.claude-plugin/marketplace.json` — agent-skills entry around line 40, version `1.2.3`.
- No `skills/agent-skills/discover-pages.sh`.

Corruption evidence, `docs/what-are-skills.md:11-13`:
```
export const LogoCarousel = ({clients}) => {
  const [shuffled, setShuffled] = useState(clients);
  useEffect(() => {
```

All 17 target URLs below were verified HTTP 200 (no redirect) on 2026-07-06.

Exemplar for `discover-pages.sh`: `skills/1password-cli/discover-pages.sh` (uses `set -euo pipefail`, jq over sync.json, and exact-match dedup `grep -qxF` — see its line 55). Model after it.

## Commands you will need

| Purpose | Command | Expected on success |
|---------|---------|---------------------|
| Validate JSON | `jq empty skills/agent-skills/sync.json` | exit 0 |
| Run sync | `.github/workflows/scripts/sync-skill.sh skills/agent-skills --force` | exit 0, `has_changes=true` |
| Script syntax | `bash -n skills/agent-skills/discover-pages.sh` | exit 0 |
| JSX check | `grep -l "export const" skills/agent-skills/skills/agent-skills/docs/*.md` | no matches |

## Scope

**In scope** (the only files you should modify/create):
- `skills/agent-skills/sync.json`
- `skills/agent-skills/skills/agent-skills/SKILL.md`
- `skills/agent-skills/skills/agent-skills/docs/*.md` (via the sync script; plus deleting none — corrupted files get overwritten in place)
- `skills/agent-skills/commands/agent-skills.md` (docs list only)
- `skills/agent-skills/README.md` (features/docs list only)
- `skills/agent-skills/discover-pages.sh` (create)
- `skills/agent-skills/.claude-plugin/plugin.json` (version + description only)
- `.claude-plugin/marketplace.json` (agent-skills version only)

**Out of scope** (do NOT touch):
- `.github/workflows/scripts/sync-skill.sh` (plan 001 owns it)
- `.github/workflows/sync-docs.yml` — agent-skills is already in the SKILLS array, and the workflow auto-globs `skills/*/discover-pages.sh`; no registration needed.
- `docs/audit-checklist.md` and `docs/examples.md` — hand-written, keep.
- Every other skill directory.
- CLAUDE.md / root README skill tables — the upstream-source description for agent-skills there stays accurate enough ("URL-based"); plan 003 owns CLAUDE.md edits.

## Git workflow

- Branch: `advisor/002-agent-skills-overhaul` off `main` (after plan 001's branch is merged, or stack on it)
- Conventional commits, e.g. `feat(agent-skills): sync official Anthropic skills docs and fix stale upstream paths`
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: Rewrite `skills/agent-skills/sync.json`

Replace the `sources` array with exactly these 17 entries. Keep `name`, `description`, `cache_dir` as-is; set `"version": "1.3.0"`. Use `"type": "extract-content"` and `"freshness_days": 14` for all except where noted.

Open spec (agentskills.io):

| url | target |
|-----|--------|
| `https://raw.githubusercontent.com/agentskills/agentskills/main/README.md` | `skills/agent-skills/docs/readme-upstream.md` (type `raw`) |
| `https://agentskills.io/specification.md` | `skills/agent-skills/docs/specification.md` |
| `https://agentskills.io/home.md` | `skills/agent-skills/docs/what-are-skills.md` |
| `https://agentskills.io/client-implementation/adding-skills-support.md` | `skills/agent-skills/docs/integrate-skills.md` |
| `https://agentskills.io/skill-creation/quickstart.md` | `skills/agent-skills/docs/skill-creation-quickstart.md` |
| `https://agentskills.io/skill-creation/best-practices.md` | `skills/agent-skills/docs/skill-creation-best-practices.md` |
| `https://agentskills.io/skill-creation/using-scripts.md` | `skills/agent-skills/docs/using-scripts.md` |
| `https://agentskills.io/skill-creation/evaluating-skills.md` | `skills/agent-skills/docs/evaluating-skills.md` |
| `https://agentskills.io/skill-creation/optimizing-descriptions.md` | `skills/agent-skills/docs/optimizing-descriptions.md` |

Official Anthropic:

| url | target |
|-----|--------|
| `https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview.md` | `skills/agent-skills/docs/anthropic-overview.md` |
| `https://platform.claude.com/docs/en/agents-and-tools/agent-skills/quickstart.md` | `skills/agent-skills/docs/anthropic-api-quickstart.md` |
| `https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices.md` | `skills/agent-skills/docs/best-practices.md` (existing target, keep) |
| `https://platform.claude.com/docs/en/agents-and-tools/agent-skills/enterprise.md` | `skills/agent-skills/docs/anthropic-enterprise.md` |
| `https://platform.claude.com/docs/en/build-with-claude/skills-guide.md` | `skills/agent-skills/docs/anthropic-api-skills-guide.md` |
| `https://code.claude.com/docs/en/skills.md` | `skills/agent-skills/docs/claude-code-skills.md` |
| `https://code.claude.com/docs/en/agent-sdk/skills.md` | `skills/agent-skills/docs/agent-sdk-skills.md` |
| `https://code.claude.com/docs/en/agent-sdk/slash-commands.md` | `skills/agent-skills/docs/agent-sdk-slash-commands.md` |

**Verify**: `jq empty skills/agent-skills/sync.json` → exit 0; `jq '.sources | length' skills/agent-skills/sync.json` → `17`.

### Step 2: Run the sync to populate/repair docs

```bash
.github/workflows/scripts/sync-skill.sh skills/agent-skills --force
```

**Verify**: exit 0; output ends with `has_changes=true` and the summary shows `Successful: 17` (or 17 minus transient failures — if ANY source reports FAILED/INVALID, re-run once; if it persists, STOP).
Then:
- `ls skills/agent-skills/skills/agent-skills/docs/ | wc -l` → `19` (17 synced + `examples.md` + `audit-checklist.md`)
- `grep -l "export const" skills/agent-skills/skills/agent-skills/docs/*.md` → no matches (JSX gone; requires plan 001)
- `head -3 skills/agent-skills/skills/agent-skills/docs/what-are-skills.md` → first line is `> Source: https://agentskills.io/home.md`

### Step 3: Rewrite SKILL.md

Rewrite `skills/agent-skills/skills/agent-skills/SKILL.md`, keeping it under 150 lines. Keep the existing frontmatter keys but update `description` to:

```yaml
description: Expert at Agent Skills - both the open agentskills.io format and Claude's official extensions (Claude Code, Agent SDK, Claude API). Use when creating SKILL.md files, understanding the specification, validating skills, choosing frontmatter fields, or integrating skills into agents. Triggers on mentions of agent skills, SKILL.md, skill format, slash commands, skill frontmatter, agent extensibility.
```

Required content changes (keep everything else that still holds):

1. Keep the existing overview/quick-start/structure sections, but note the spec has two layers: the portable open spec, and platform extensions.
2. Add a **"Claude Code extensions (beyond the open spec)"** section with this table:

| Field / feature | Semantics | Scope |
|---|---|---|
| `allowed-tools` | Pre-approved tools the skill may use (e.g. `Read, Bash(git *)`) | Claude Code CLI only — NOT supported in Agent SDK |
| `context: fork` | Run the skill in an isolated subagent context | Claude Code + Agent SDK |
| `agent` | Run the skill via a named subagent type | Claude Code |
| `model` | Model override for the skill's execution | Claude Code |
| `disable-model-invocation` | Only the user can invoke (`/name`); Claude never auto-triggers | Claude Code |
| `argument-hint` | Hint shown for slash-command arguments | Claude Code |
| `$ARGUMENTS`, `$0`/`$1`… | Argument substitution in the skill body | Claude Code |
| `` !`command` `` | Dynamic context injection — command runs and its output replaces the line before Claude reads the skill | Claude Code |
| `@path` | File-content references in the body | Claude Code |

3. Update the **Documentation** section to list the docs in two groups (link every file created in step 2):
   - *Open format (agentskills.io)*: specification, what-are-skills, integrate-skills, skill-creation-quickstart, skill-creation-best-practices, using-scripts, evaluating-skills, optimizing-descriptions, readme-upstream
   - *Official Anthropic*: claude-code-skills, agent-sdk-skills, agent-sdk-slash-commands, anthropic-overview, anthropic-api-quickstart, best-practices, anthropic-enterprise, anthropic-api-skills-guide
   - *Internal*: examples, audit-checklist
4. Update **Upstream Sources** to add `https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview` and `https://code.claude.com/docs/en/skills`.

**Verify**: `wc -l skills/agent-skills/skills/agent-skills/SKILL.md` → ≤ 150. Every `docs/<file>.md` referenced in SKILL.md exists:
```bash
grep -o 'docs/[a-z-]*\.md' skills/agent-skills/skills/agent-skills/SKILL.md | sort -u | \
  while read f; do [ -f "skills/agent-skills/skills/agent-skills/$f" ] || echo "MISSING $f"; done
```
→ no output.

### Step 4: Update the command file and README docs lists

In `skills/agent-skills/commands/agent-skills.md`, update the docs enumeration (currently lines 24–30) to match the new file set from step 3 (same two-group structure, one line each). Do not change the command table. Do NOT fix the `skills/agent-skills/SKILL.md` path prefix here — plan 003 rewrites those paths repo-wide; leave the prefix exactly as-is to avoid a merge conflict.

In `skills/agent-skills/README.md`, extend the "Features" or docs section with one line noting coverage now includes official Claude Code / Agent SDK / Claude API skills documentation.

**Verify**: `grep -c 'claude-code-skills.md' skills/agent-skills/commands/agent-skills.md` → ≥ 1.

### Step 5: Create `skills/agent-skills/discover-pages.sh`

Model after `skills/1password-cli/discover-pages.sh` (read it first). Requirements:

- `#!/bin/bash` + `set -euo pipefail`; depends on `curl` and `jq` (guard with `command -v`).
- Support a `--auto-add` flag exactly like the exemplar (`skills/1password-cli/discover-pages.sh:17-18,71`) — CI invokes every discover script with `--auto-add` (`sync-docs.yml:47-54`). With the flag, auto-add **only agentskills.io discoveries** (entry shape: `"type": "extract-content"`, `"freshness_days": 14`, target `skills/agent-skills/docs/<slug>.md`). Discoveries from the two Anthropic indexes are always report-only (`NEW:` lines) — their keyword filters are too loose to add pages unreviewed.
- Fetch three indexes and build a candidate URL list:
  1. `https://agentskills.io/llms.txt` — extract all `https://agentskills.io/....md` URLs.
  2. `https://code.claude.com/llms.txt` — extract URLs, keep only those matching `skill|slash-command`.
  3. `https://platform.claude.com/llms.txt` — extract URLs, keep only those matching `agent-skills|skills-guide`.
- Extract URLs with `grep -oE 'https://[^ )]+'`; normalize by stripping trailing slashes and ensuring a `.md` suffix where the index lists extensionless paths (compare both forms).
- Compare against `jq -r '.sources[].url' sync.json` using exact match `grep -qxF` (NOT `grep -qF`).
- Print each URL not in sync.json prefixed `NEW: `; exit 0 if none, exit 1 if any (matching the convention in the 1password script — check its exit behavior and mirror it).
- `chmod +x` the script.

**Verify**:
- `bash -n skills/agent-skills/discover-pages.sh` → exit 0
- `./skills/agent-skills/discover-pages.sh` (from repo root, network) → after step 1's sync.json, exits reporting **zero new agentskills.io pages** (all 9 covered). It may legitimately report extra `code.claude.com`/`platform.claude.com` matches (e.g. hooks or plugin pages that mention skills) — listing those is acceptable, but if it reports any of the 17 URLs already in sync.json, the dedup is broken: STOP and fix the normalization.

### Step 6: Bump versions to 1.3.0

Set version `1.3.0` (minor — new capability) in:
- `skills/agent-skills/sync.json` (done in step 1)
- `skills/agent-skills/.claude-plugin/plugin.json`
- the agent-skills entry in `.claude-plugin/marketplace.json`

Also update `plugin.json`'s `description` to match the new SKILL.md description's first sentence.

**Verify**:
```bash
jq -r '.version' skills/agent-skills/sync.json skills/agent-skills/.claude-plugin/plugin.json; \
jq -r '.plugins[] | select(.name=="agent-skills") | .version' .claude-plugin/marketplace.json
```
→ three lines, all `1.3.0`.

## Test plan

No test framework. The verification gates above are the tests. Additionally, spot-read two synced files for sanity:
- `sed -n '1,20p' skills/agent-skills/skills/agent-skills/docs/claude-code-skills.md` → starts with `> Source: https://code.claude.com/docs/en/skills.md`, then real prose about skills (contains the phrase "SKILL.md").
- `grep -c 'context' skills/agent-skills/skills/agent-skills/docs/agent-sdk-skills.md` → ≥ 1.

## Done criteria

Machine-checkable. ALL must hold:

- [ ] `jq '.sources | length' skills/agent-skills/sync.json` → 17
- [ ] 19 files in `skills/agent-skills/skills/agent-skills/docs/`
- [ ] `grep -rl "export const" skills/agent-skills/skills/agent-skills/docs/` → no matches
- [ ] `grep -rl "what-are-skills.md\|integrate-skills.md" skills/agent-skills/skills/agent-skills/docs/what-are-skills.md` sanity: first line of that file is `> Source: https://agentskills.io/home.md`
- [ ] SKILL.md ≤ 150 lines; all `docs/*.md` references resolve (step 3 loop prints nothing)
- [ ] `discover-pages.sh` exists, is executable, `bash -n` clean
- [ ] Versions all `1.3.0` (step 6 check)
- [ ] `git status --porcelain` touches only in-scope files
- [ ] `plans/README.md` status row updated

## STOP conditions

Stop and report back (do not improvise) if:

- Plan 001 has not landed (check: `grep -c '((.*++))' .github/workflows/scripts/sync-skill.sh` must be 0). Syncing without it re-imports JSX.
- Any of the 17 URLs returns non-200 or a redirect on sync (site restructured again). Report which; do not guess replacement paths.
- A synced doc still contains `export const` after plan 001's stripping — the MDX shape changed; report the file and offending lines.
- SKILL.md cannot stay under 150 lines with the required content — report the draft length rather than cutting the extensions table.

## Maintenance notes

- The `discover-pages.sh` filters (`skill|slash-command`, `agent-skills|skills-guide`) are the tuning knobs for what counts as "skills-related" on the Anthropic sites; widen them deliberately, not by accident.
- If agentskills.io restructures again, the discover script + CI will now flag it; the failure mode to watch is *redirects* (fetch "succeeds" with wrong content) — the sync script does warn `Redirect detected` in logs.
- Reviewer should scrutinize: the SKILL.md extensions table against the freshly synced `claude-code-skills.md` (the synced doc is the source of truth; fix the table, not the doc).
- Deferred: renaming `best-practices.md` → `anthropic-best-practices.md` for naming symmetry (skipped to avoid churning existing references); an `examples.md` refresh from anthropics/skills.
