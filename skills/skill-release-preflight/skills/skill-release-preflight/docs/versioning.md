# Versioning

## Who owns what

release-please owns every skill version. Nothing else writes one.

| File | Written by | When |
|---|---|---|
| `.release-please-manifest.json` | release-please | on a release PR merge |
| `skills/<name>/sync.json` | release-please, via `extra-files` | same commit |
| `skills/<name>/.claude-plugin/plugin.json` | release-please, via `extra-files` | same commit |
| `.claude-plugin/marketplace.json` | the `sync-marketplace` workflow | **after** the release PR merges |

`release-please-config.json` declares the two `extra-files` per package, which is what keeps
`sync.json` and `plugin.json` in lockstep:

```json
"extra-files": [
  {"type": "json", "path": "sync.json", "jsonpath": "$.version"},
  {"type": "json", "path": ".claude-plugin/plugin.json", "jsonpath": "$.version"}
]
```

## Marketplace lag is expected

`marketplace.json` trails `plugin.json` between a release merge and the `sync-marketplace` run.
`check-consistency.sh` treats that as a **warning**, not a failure, on purpose. Do not "fix" it by
hand — the next workflow run reconciles it.

## A hand bump fails CI

```
MISMATCH: version disagreement <skill> (sync=1.2.0 plugin=1.1.1)
```

Revert to the value release-please believes, which is the manifest:

```bash
jq -r '."skills/<name>"' .release-please-manifest.json
```

Do not bump the other file to match. That hides the desync from the checker and leaves
release-please computing its next version from a number it never wrote.

## Never add a fifth copy

Four locations are checked. Any other copy is invisible to CI and will drift.

`SKILL.md` frontmatter is not a version location. A `version:` field there is not part of the Agent
Skills format, is never read by the checker, and has already drifted a full minor release in this
repo without anything reporting it.

## A new skill does not ship as 1.0.0

Seed all four locations at `1.0.0` and the introducing commit is a `feat:`, so release-please bumps
**from** 1.0.0 to **1.1.0**. `1.0.0` is never released and never tagged, and the first changelog
entry links to a compare against a tag that returns 404.

Force the first release to be the version you seeded:

```
feat(<name>): add the <name> skill

<body>

Release-As: 1.0.0
```

Seeding `0.0.0` instead does not help — a `feat:` from `0.0.0` gives `0.1.0`.

**Keep the footer on a commit that touches only that skill's path.** `Release-As` applies to every
package the commit is attributed to, so a commit that also touched two other skills would force all
three to that version — a downgrade for the two that were already ahead.

**A squash merge collapses that protection.** When a repo squash-merges with
`squash_merge_commit_message: COMMIT_MESSAGES`, every commit body in the PR is concatenated into one
commit that touches every path in the PR. Splitting the work across commits does not survive it.
Check the repo's merge settings:

```bash
gh api repos/<owner>/<repo> --jq '{squash: .allow_squash_merge, msg: .squash_merge_commit_message}'
```

If the repo squashes, put the new skill in a PR of its own.

## Conventional commits decide the bump

| Prefix | Bump | Changelog section |
|---|---|---|
| `feat:` | minor | Features |
| `fix:` | patch | Bug Fixes |
| `docs:` | patch | Documentation |
| `chore:` | none | hidden |

Attribution is by **file path**, not by scope. A commit touching only root files — `README.md`,
`CLAUDE.md`, `.github/**` — belongs to no package and bumps nothing. A cross-cutting docs fix that
touches one skill's directory bumps only that skill, even when the change also corrected another
skill's documentation elsewhere.
