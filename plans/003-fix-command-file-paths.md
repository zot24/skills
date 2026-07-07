# Plan 003: Fix broken skill paths in command files and correct CLAUDE.md inaccuracies

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving to the
> next step. If anything in the "STOP conditions" section occurs, stop and
> report — do not improvise. When done, update the status row for this plan
> in `plans/README.md` — unless a reviewer dispatched you and told you they
> maintain the index.
>
> **Drift check (run first)**: `git diff --stat 7cb28b4..HEAD -- 'skills/*/commands' CLAUDE.md`
> A change to `skills/agent-skills/commands/agent-skills.md` from plan 002 is
> EXPECTED (its docs list changed; the path prefix on its line 23 should be
> untouched). Any other drift in these files: compare against the "Current
> state" excerpts; on a mismatch, treat as a STOP condition.

## Status

- **Priority**: P2
- **Effort**: M
- **Risk**: LOW
- **Depends on**: none (safe to run before/after 001–002; coordinate only on `skills/agent-skills/commands/agent-skills.md` as noted)
- **Category**: bug
- **Planned at**: commit `7cb28b4`, 2026-07-06

## Why this matters

Every plugin's slash command tells the agent to read the skill file at a path that does not resolve at runtime. Commands execute from the **user's project CWD**, not the plugin directory, and the written path is additionally missing one nesting level. 19 of 22 command files share the bug (seeded from the template in `CLAUDE.md`), one (`hermes`) points at a directory name that never existed, and only `safe-delete` is closest to correct (right nesting, still CWD-relative). In practice Claude Code auto-loads the SKILL.md when the skill triggers, which masks the bug — but any agent that follows the instruction literally gets file-not-found, and the template keeps stamping the mistake into every new skill.

Claude Code plugins expose `${CLAUDE_PLUGIN_ROOT}` (absolute path to the installed plugin directory) precisely for this; paths in command files should use it.

Separately, `CLAUDE.md` — the authoritative contributor guide — contains three factual errors found in audit: the structure diagram shows the sync script at `.github/scripts/` (real path `.github/workflows/scripts/`, which `CLAUDE.md:217` itself uses), lists a workflow `release-on-merge.yml` that doesn't exist (real workflows: `release-please.yml`, `sync-docs.yml`, `sync-hermes-on-release.yml`, `sync-marketplace.yml`), and labels `portainerctl` "Self-contained" although it has a live upstream source in its sync.json and is in the CI SKILLS array.

## Current state

- 19 command files contain the pattern `Read the skill file at \`skills/<name>/SKILL.md\`` (single-nested, CWD-relative). Exact list (file:line):
  - `skills/agent-skills/commands/agent-skills.md:23`
  - `skills/1password-cli/commands/1password-cli.md:29`
  - `skills/agent-browser/commands/agent-browser.md:23`
  - `skills/adguard/commands/adguard.md:25`
  - `skills/ai-sdk/commands/ai-sdk.md:24`
  - `skills/firecrawl/commands/firecrawl.md:26`
  - `skills/chat-sdk/commands/chat-sdk.md:22`
  - `skills/flue/commands/flue.md:28`
  - `skills/glinet/commands/glinet.md:32`
  - `skills/obsidian/commands/obsidian.md:27`
  - `skills/immich/commands/immich.md:26`
  - `skills/honcho/commands/honcho.md:28`
  - `skills/portainerctl/commands/portainerctl.md:27`
  - `skills/umami/commands/umami.md:26`
  - `skills/servarr/commands/servarr.md:27`
  - `skills/umbrel-app/commands/umbrel-app.md:22`
  - `skills/wealthfolio/commands/wealthfolio.md:26`
  - `skills/x-engagement/commands/x-engagement.md:22`
  - `skills/safe-delete/commands/safe-delete.md:20` — double-nested (`skills/safe-delete/skills/safe-delete/SKILL.md`) but still CWD-relative
- Most of these files also reference `skills/<name>/docs/` a line or two below — same defect, fix together.
- `skills/hermes/commands/hermes.md:15`: `Use the SKILL.md at \`skills/hermes-self-knowledge/SKILL.md\`` — `hermes-self-knowledge` never existed; real skill dir is `skills/hermes/skills/hermes/`.
- `skills/claude-code-expert/commands/` — check it too; it did not match the grep, but verify its paths while in there.
- Template that seeds new skills, `CLAUDE.md:163-164`:
  ```
  1. Read the skill file at `skills/<skill>/SKILL.md` for overview
  2. Read detailed docs in `skills/<skill>/docs/` for specific topics
  ```
- `CLAUDE.md:13-15` (structure diagram):
  ```
  ├── .github/
  │   ├── scripts/
  │   │   └── sync-skill.sh   # Generic sync script
  ```
- `CLAUDE.md:18`: `│       └── release-on-merge.yml`
- `CLAUDE.md:249`: `| portainerctl | https://github.com/portainer/portainerctl | Self-contained |`

Correct path shape (relative to plugin root; plugins are installed with `skills/<name>/` as root because `.claude-plugin/plugin.json` lives there):
`${CLAUDE_PLUGIN_ROOT}/skills/<name>/SKILL.md` and `${CLAUDE_PLUGIN_ROOT}/skills/<name>/docs/`.

## Commands you will need

| Purpose | Command | Expected on success |
|---------|---------|---------------------|
| Find stale paths | `grep -rn 'skills/[a-z0-9-]*/SKILL.md' skills/*/commands/*.md CLAUDE.md \| grep -v 'CLAUDE_PLUGIN_ROOT'` | no matches when done |
| Ghost name | `grep -rn 'hermes-self-knowledge' skills/` | no matches when done |

## Scope

**In scope** (the only files you should modify):
- All 22 `skills/*/commands/*.md` files
- `CLAUDE.md` (lines quoted above only)

**Out of scope** (do NOT touch):
- Any `SKILL.md`, `sync.json`, `plugin.json`, workflow, or script file.
- The docs-list content of `skills/agent-skills/commands/agent-skills.md` (plan 002 owns that section — change only the path prefix on its "Read the skill file at…" and "Read detailed docs in…" lines).
- README.md files.

## Git workflow

- Branch: `advisor/003-fix-command-paths` off `main`
- One commit: `fix(commands): use ${CLAUDE_PLUGIN_ROOT} paths in all command files, correct CLAUDE.md` (or two commits, commands + CLAUDE.md)
- Do NOT push or open a PR unless the operator instructed it.

## Steps

### Step 1: Fix the CLAUDE.md command template

Edit `CLAUDE.md:163-164` to:
```
1. Read the skill file at `${CLAUDE_PLUGIN_ROOT}/skills/<skill>/SKILL.md` for overview
2. Read detailed docs in `${CLAUDE_PLUGIN_ROOT}/skills/<skill>/docs/` for specific topics
```

**Verify**: `grep -n 'CLAUDE_PLUGIN_ROOT' CLAUDE.md` → 2 matches at those lines.

### Step 2: Fix the other CLAUDE.md inaccuracies

1. Structure diagram: change `.github/ scripts/` block to reflect reality — script lives at `.github/workflows/scripts/sync-skill.sh` (there is also `sync-marketplace.sh`); workflow list is `release-please.yml`, `sync-docs.yml`, `sync-hermes-on-release.yml`, `sync-marketplace.yml`. Remove `release-on-merge.yml`.
2. Line 249: change portainerctl's sync-type cell from `Self-contained` to `URL-based` (it syncs `https://raw.githubusercontent.com/portainer/portainerctl/develop/README.md` per `skills/portainerctl/sync.json`).

**Verify**: `grep -c 'release-on-merge' CLAUDE.md` → 0; `grep -n 'portainerctl' CLAUDE.md` shows `URL-based`; `grep -c '.github/scripts/' CLAUDE.md` → 0.

### Step 3: Fix all command files

For each of the 22 files in `skills/*/commands/*.md`:

1. Replace CWD-relative skill-file references with `${CLAUDE_PLUGIN_ROOT}` form. For a skill named `<name>`:
   - `skills/<name>/SKILL.md` → `${CLAUDE_PLUGIN_ROOT}/skills/<name>/SKILL.md`
   - `skills/<name>/docs/` (and `skills/<name>/docs/<file>.md`) → `${CLAUDE_PLUGIN_ROOT}/skills/<name>/docs/...`
   - safe-delete's double-nested `skills/safe-delete/skills/safe-delete/SKILL.md` → `${CLAUDE_PLUGIN_ROOT}/skills/safe-delete/SKILL.md`
2. `skills/hermes/commands/hermes.md:15`: `skills/hermes-self-knowledge/SKILL.md` → `${CLAUDE_PLUGIN_ROOT}/skills/hermes/SKILL.md`. Also scan the rest of hermes.md for further `hermes-self-knowledge` occurrences.
3. Check `skills/claude-code-expert/commands/*.md` and `skills/gh-issue-tracker/commands/*.md` for the same patterns; fix if present.

Do this with per-file edits, not a blind repo-wide sed — several files phrase the sentence slightly differently ("for the overview.", "for detailed instructions", "for overview and principles").

**Verify**:
```bash
grep -rn 'skills/[a-z0-9-]*/\(SKILL\.md\|docs\)' skills/*/commands/*.md | grep -v 'CLAUDE_PLUGIN_ROOT'
```
→ no output. And `grep -rn 'hermes-self-knowledge' skills/` → no output.

## Test plan

No test framework. The greps above are the tests. Additionally, pick one plugin (e.g. adguard) and confirm its edited line reads naturally in context: `sed -n '20,30p' skills/adguard/commands/adguard.md`.

## Done criteria

Machine-checkable. ALL must hold:

- [ ] `grep -rn 'skills/[a-z0-9-]*/\(SKILL\.md\|docs\)' skills/*/commands/*.md | grep -vc 'CLAUDE_PLUGIN_ROOT'` → 0
- [ ] `grep -rc 'hermes-self-knowledge' skills/ | grep -v ':0'` → no output
- [ ] `grep -c 'release-on-merge' CLAUDE.md` → 0
- [ ] CLAUDE.md template lines use `${CLAUDE_PLUGIN_ROOT}`
- [ ] `git status --porcelain` shows only `skills/*/commands/*.md` and `CLAUDE.md` modified (plus `plans/README.md`)
- [ ] `plans/README.md` status row updated

## STOP conditions

Stop and report back (do not improvise) if:

- A command file references a docs file that doesn't exist in that skill's `docs/` directory — note it in your report; do NOT invent a replacement (except the known hermes ghost, whose fix is specified above).
- `skills/agent-skills/commands/agent-skills.md` has changed shape beyond what plan 002 describes (docs list updated) — re-locate the path lines before editing; if you can't identify them unambiguously, stop.
- You find yourself wanting to edit a SKILL.md or workflow file.

## Maintenance notes

- New skills will now inherit the correct template from CLAUDE.md; the audit checklist at `skills/agent-skills/skills/agent-skills/docs/audit-checklist.md` could later add a check "command file uses ${CLAUDE_PLUGIN_ROOT}" (deferred).
- Reviewer should scrutinize the hermes file — it had the only semantic (not just structural) error.
- Deferred: deciding whether the "Read the skill file" step is needed at all (the harness auto-loads SKILL.md on skill activation); removing it repo-wide is a larger editorial change than this fix.
