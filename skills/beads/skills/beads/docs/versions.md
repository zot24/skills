# Versions & documentation drift

> Authored for this skill — **not** synced from upstream. Everything else in `docs/` is a cached upstream page.

## What is current

| Claim | Grade | Evidence |
|-------|-------|----------|
| Latest beads release is **v1.2.2** | **VERIFIED 2026-08-17** | GitHub releases API for `gastownhall/beads` returns `tag_name: v1.2.2`, published `2026-08-15T03:59:10Z`. Preceding tags: `v1.2.2-rc.1`, `v1.2.1`, `v1.2.0`, `v1.1.2`. |
| The docs site describes the **1.1.0** release | **VERIFIED 2026-08-17** | `https://beads.gascity.com/index.md` states: *"These docs are for the 1.1.0 release of beads — see the v1.1.0 release notes."* Cached verbatim in [intro.md](intro.md). |
| Which behaviour changed between 1.1.0 and 1.2.2 | **NOT DETERMINED** | Not audited for this skill. Read the release notes for `v1.2.0`, `v1.2.1`, and `v1.2.2` before relying on any single flag documented here. |

**So: the cached pages in `docs/` describe 1.1.0 while the shipping binary is 1.2.2.** That gap is recorded rather than papered over. Do not assume a flag documented here exists in your installed `bd`, and do not assume a flag missing here is unsupported.

## Known drift signals

- **v1.2.1 was an accidental, untested release.** Upstream publishes a dedicated recovery page for databases migrated by it (`https://beads.gascity.com/recovery/accidental-1-2-1-release.md`). **VERIFIED 2026-08-17** — the page is listed in `llms.txt`. If a user is on 1.2.1, send them there before doing anything else with their database.
- Upstream added `v1.2.x` pages (recovery, federation, events journal) that this skill does not cache. `https://beads.gascity.com/llms.txt` is the authoritative page index; check it during `sync`.

## How to check what is actually installed

```bash
bd version                 # installed binary
bd info --schema --json    # database schema version
bd doctor                  # configuration + hook health
bd migrate --inspect --json  # migration plan before upgrading a database
```

Then compare against the latest tag:

```bash
curl -s https://api.github.com/repos/gastownhall/beads/releases/latest | jq -r .tag_name
```

## Upgrade posture

- Upgrading the **binary** is cheap (`brew upgrade beads`, `npm update -g @beads/bd`, re-run the install script). Upgrading a **database** across a schema migration is not — `bd migrate --dry-run` / `--inspect --json` first, and back up.
- `bd` refuses to open a database whose schema is *ahead* of the binary. If a teammate upgraded and you did not, upgrade rather than forcing anything.
- After upgrading, re-run `bd hooks install` so git hooks match the new binary.

**Grade for this section:** **INFERRED** from [installation.md](installation.md), [readme-upstream.md](readme-upstream.md), and [quickstart.md](quickstart.md) (schema-version check, `bd migrate`, hook reinstall are all documented there); the specific 1.1.0 → 1.2.2 upgrade path is **NOT DETERMINED**.
