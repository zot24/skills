---
name: skill-release-preflight
description: Preflight checks before pushing a change to a skills marketplace repo. Use before git push, before gh pr create, when adding or registering a skill, and whenever a version, sync.json, plugin.json, marketplace.json, skills.toml, or a release-please manifest is touched. Triggers on version bump, bump the version, release-please, check-consistency, MISMATCH, manifest mismatch, marketplace.json, sync.json, plugin.json, register a skill, add a new skill, EXEMPT_SYNC.
allowed-tools: Read, Grep, Glob, Bash
---

# skill-release-preflight

Three commands before every push. Each takes under a second. Each has already caught a failure that
reached CI and cost a round trip with the user.

```bash
bash .github/workflows/scripts/check-consistency.sh     # exits 0, or names the mismatch
gh label list --limit 100 --json name --jq '.[].name'   # before any gh pr create --label
git status --porcelain                                  # only the files you meant to change
```

## Rule 1 — never hand-edit a skill version

release-please owns every skill version and writes `sync.json` and `plugin.json` in lockstep. A hand
edit desynchronises them and fails CI with a `version disagreement` line.

Do not fix that by bumping the other file to match — revert to `.release-please-manifest.json`, and
do not add a version field anywhere new. Ownership, the revert command, and why a fifth copy always
drifts: [versioning](docs/versioning.md).

## Rule 2 — run the repo's own checker before you push

`check-consistency.sh` is the same script CI runs, so a local pass means the `consistency` check
passes. Run it after touching a skill directory, `marketplace.json`, `skills.toml`, either
release-please file, or the `SKILLS` array in `sync-docs.yml`.

The script may arrive without the execute bit — invoke it with `bash`. See
[consistency-check](docs/consistency-check.md) for what each check compares and how to read a
mismatch.

## Rule 3 — read the label list before you post

`gh pr create` rejects the whole command when any `--label` does not exist, **after** the branch is
pushed. The priority scale is per repo: some carry `priority:low`, others stop at `priority:medium`.
Never assume the scale from another repo, and never create a label inside a feature PR.

## Registering a new skill

A skill lands in six places or the checker fails. A skill with `"sources": []` is also exempt from
CI sync and must be named in `EXEMPT_SYNC`. Full table and the failure each omission produces:
[registration](docs/registration.md).

## A new skill does not ship as 1.0.0

Seed all four locations at `1.0.0` and the introducing `feat:` commit bumps it to `1.1.0`, so `1.0.0`
is never tagged. Put a `Release-As: 1.0.0` footer on that commit — and keep it on a commit that
touches **only** that skill's path, because the footer applies to every package the commit is
attributed to. Under a squash merge that is every package in the PR.
[versioning](docs/versioning.md) has the detail.

## Documentation

- **[Versioning](docs/versioning.md)** — who owns which version field, the `Release-As` footer, and why a fifth copy always drifts
- **[Registration](docs/registration.md)** — the six places, `EXEMPT_SYNC`, and what each omission breaks
- **[Consistency check](docs/consistency-check.md)** — what the script compares, and how to read each mismatch
