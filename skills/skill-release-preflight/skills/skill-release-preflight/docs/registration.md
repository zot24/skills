# Registering a skill

Six places. Miss one of the first five and `check-consistency.sh` fails, naming the file it is
missing from. The sixth is prose and nothing checks it.

| # | Place | Entry |
|---|---|---|
| 1 | `.claude-plugin/marketplace.json` | `{"name", "source": "./skills/<name>", "description", "version"}` |
| 2 | `skills.toml` | `[[skills]]` with `name` and `marketplace = "zot24-skills"` |
| 3 | `release-please-config.json` | package `skills/<name>` with `component` and both `extra-files` |
| 4 | `.release-please-manifest.json` | `"skills/<name>": "1.0.0"` |
| 5 | `.github/workflows/sync-docs.yml` | the `SKILLS=(...)` array — **unless the skill has no upstream** |
| 6 | `README.md` + `CLAUDE.md` | skills-table row, details section, project tree, Skill Sources row |

Places 1–5 are machine-checked. Place 6 is not — the prose tables agree by attention alone, which is
how a row has gone missing before.

## The no-upstream case

A skill with `"sources": []` has nothing to sync. It must be **absent** from the `SKILLS` array and
**present** in `EXEMPT_SYNC`:

```bash
EXEMPT_SYNC="safe-delete gh-issue-tracker pr-standard tower-gates skill-release-preflight"
```

That list is the live value at the time of writing. Read the file rather than trusting this line —
it is exactly the kind of copy this skill warns about.

The check is symmetric, so both halves are enforced:

- in `SKILLS` **and** in `EXEMPT_SYNC` → `MISMATCH: sync-docs.yml SKILLS extra (should be exempt)`
- in neither → `MISMATCH: sync-docs.yml SKILLS missing`

What is **not** enforced: whether an exempt skill really has no upstream. A skill with live sources
could be parked in `EXEMPT_SYNC` and CI would stay green while its docs quietly went stale. Only put
a skill there when its `sources` array is genuinely empty.

## Layout

```
skills/<name>/
├── .claude-plugin/plugin.json
├── commands/<name>.md
├── skills/<name>/
│   ├── SKILL.md          # ~100 lines: summary + links into docs/
│   └── docs/*.md         # the detail
├── sync.json
├── .gitignore            # .cache/
└── README.md
```

`SKILL.md` lives **two** levels below `skills/`, not one. Tools that discover skills with a
`<dir>/*/SKILL.md` glob will not find anything in this repo — point them at
`skills/<plugin>/skills` instead.

## Before you push

```bash
bash .github/workflows/scripts/check-consistency.sh
```
