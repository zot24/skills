# check-consistency.sh

The same script CI runs, via `.github/workflows/validate.yml` on `pull_request` and on push to
`main`. A local pass means the `consistency` check passes.

```bash
bash .github/workflows/scripts/check-consistency.sh
echo $?    # 0 consistent, 1 mismatch
```

Invoke it with `bash`. The execute bit does not always survive a checkout, and a missing one has
already produced a confusing CI failure.

## What it compares

`.claude-plugin/marketplace.json` is the reference set. Every check is symmetric — it reports both a
missing entry and an extra one.

| # | Compares | Against |
|---|---|---|
| 1 | `skills/*/` dirs holding a `plugin.json` | the marketplace plugin list |
| 2 | `skills.toml` names | the marketplace list |
| 3 | `release-please-config.json` packages | the marketplace list minus `EXEMPT_RELEASE` |
| 4 | the `SKILLS` array in `sync-docs.yml` | the marketplace list minus `EXEMPT_SYNC` |
| 5 | `sync.json` version vs `plugin.json` version | **hard failure** |
| 6 | `plugin.json` version vs `marketplace.json` version | **warning only** |

## Reading a mismatch

| Line | Cause | Fix |
|---|---|---|
| `MISMATCH: marketplace.json missing <name>` | new skill directory, no marketplace entry | add entry 1 |
| `MISMATCH: skills.toml missing <name>` | not registered for `zskills` | add entry 2 |
| `MISMATCH: release-please-config.json missing <name>` | no package stanza | add entry 3 |
| `MISMATCH: sync-docs.yml SKILLS missing <name>` | has upstream sources but no CI sync | add to `SKILLS` |
| `MISMATCH: sync-docs.yml SKILLS extra (should be exempt) <name>` | in both `SKILLS` and `EXEMPT_SYNC` | remove from `SKILLS` |
| `MISMATCH: version disagreement <name> (sync=… plugin=…)` | a hand-edited version | revert to `.release-please-manifest.json` |
| `MISMATCH: skills/*/.claude-plugin/plugin.json missing <name>` | in the marketplace with no directory on disk | remove the entry, or add the skill |
| `MISMATCH: skills.toml extra <name>` | left behind after a skill was removed | delete entry 2 |
| `MISMATCH: release-please-config.json extra <name>` | same, for the package stanza | delete entry 3 |
| `MISMATCH: sync-docs.yml SKILLS extra <name>` | in the array but not in the marketplace | remove from `SKILLS` |
| `MISMATCH: version files missing <name>` | `sync.json` or `plugin.json` absent | create the missing file |
| `WARNING: marketplace.json version lags plugin.json` | normal, between a release merge and `sync-marketplace` | do nothing |

Only the `MISMATCH` lines fail the run. The `WARNING` is expected and deliberate.

## What it does not check

- `README.md` and `CLAUDE.md` prose tables.
- Any version outside the four tracked locations — it never reads `SKILL.md`.
- Whether a skill in `EXEMPT_SYNC` genuinely has no upstream.
- `skills.toml` content beyond names.

Each of those has been a real source of drift. Treat a green run as "the manifests agree", not as
"the repo is correct".
