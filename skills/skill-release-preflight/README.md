# skill-release-preflight Skill

Three commands before every push to this marketplace repo. Each takes under a second, and each has
already caught a failure that reached CI.

```bash
bash .github/workflows/scripts/check-consistency.sh     # exits 0, or names the mismatch
gh label list --limit 100 --json name --jq '.[].name'   # before any gh pr create --label
git status --porcelain                                  # only the files you meant to change
```

## What This Skill Covers

- **Version ownership** — release-please writes `sync.json` and `plugin.json` in lockstep, the
  `sync-marketplace` workflow copies into `marketplace.json`, and nothing else writes a version
- **Undoing a hand bump** — revert to `.release-please-manifest.json`, never bump the other file to
  match
- **The six registration points** — and which mismatch each omission produces
- **`EXEMPT_SYNC`** — when a skill with `"sources": []` belongs there, and what the check does not
  verify
- **`Release-As: 1.0.0`** — why a new skill otherwise ships as `1.1.0` with a changelog link to a
  tag that does not exist
- **Reading `check-consistency.sh`** — every `MISMATCH:` line, and the one `WARNING:` that is
  expected and should be left alone

## Usage

```
/skill-release-preflight:skill-release-preflight preflight
/skill-release-preflight:skill-release-preflight check
/skill-release-preflight:skill-release-preflight version
/skill-release-preflight:skill-release-preflight register
/skill-release-preflight:skill-release-preflight new-skill
/skill-release-preflight:skill-release-preflight mismatch
```

## Documentation

- [Versioning](./skills/skill-release-preflight/docs/versioning.md)
- [Registration](./skills/skill-release-preflight/docs/registration.md)
- [Consistency check](./skills/skill-release-preflight/docs/consistency-check.md)

## Why it exists

A session in this repository hand-bumped `skills/x-engagement/sync.json` to `1.2.0` while
`plugin.json` stayed `1.1.1`. CI failed, and the user had to paste the error back:

```
MISMATCH: version disagreement x-engagement (sync=1.2.0 plugin=1.1.1)
```

`check-consistency.sh` was already in the repository and catches that in under a second. It was not
run before the push. The rule was documented in `CLAUDE.md`; nothing made an agent check it.

## Sources

No upstream. This skill encodes this repository's own rules, so `sync.json` carries an empty
`sources` array and the skill is listed in `EXEMPT_SYNC`.
