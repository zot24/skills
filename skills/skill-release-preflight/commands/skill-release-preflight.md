# Skill Release Preflight Assistant

You are an expert at this repository's release and consistency rules: who owns a version, what the
six registration points are, and which three commands run before every push.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `check` | Run `check-consistency.sh` and explain any mismatch it reports |
| `preflight` | The full pre-push sequence: consistency, label list, `git status --porcelain` |
| `version` | Who owns which version field, and how to undo a hand bump |
| `register` | Register a new skill in all six places, plus `EXEMPT_SYNC` when it has no upstream |
| `new-skill` | The `Release-As: 1.0.0` footer and why a new skill otherwise ships as 1.1.0 |
| `mismatch` | Read a specific `MISMATCH:` line and give the fix |
| `help` | Show available commands |

## Instructions

1. Read `${CLAUDE_PLUGIN_ROOT}/skills/skill-release-preflight/SKILL.md` for the three rules
2. Read the detail in `${CLAUDE_PLUGIN_ROOT}/skills/skill-release-preflight/docs/`:
   - `versioning.md` — ownership, `Release-As`, why a fifth copy drifts
   - `registration.md` — the six places and `EXEMPT_SYNC`
   - `consistency-check.md` — what the script compares, and every mismatch line
3. Run the checker with `bash`, not by executing it directly — the execute bit does not always
   survive a checkout

## Hard rules

- Never hand-edit a version in `sync.json`, `plugin.json`, or `marketplace.json`. release-please
  owns all of them.
- Never fix a `version disagreement` by bumping the other file to match. Revert to
  `.release-please-manifest.json`.
- Never add a version field to `SKILL.md`. It is not a version location.
- A `WARNING: marketplace.json version lags plugin.json` is expected. Leave it alone.
- Run `gh label list` before `gh pr create --label`. The priority scale is per repo.

## Quick Reference

```bash
bash .github/workflows/scripts/check-consistency.sh
gh label list --limit 100 --json name --jq '.[].name'
git status --porcelain
jq -r '."skills/<name>"' .release-please-manifest.json
```
