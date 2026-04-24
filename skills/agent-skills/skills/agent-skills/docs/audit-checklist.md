<!-- Source: Internal audit specification for skills repository -->
# Skills Compliance Audit Checklist

This document defines the audit process for validating all skills in the repository against the required structure and conventions.

## How to Run

Use the `/agent-skills audit` command. The agent will scan all skill directories and produce a compliance matrix.

## Required Files (per skill)

Every skill MUST have all 7 of these files:

| # | File | Path Pattern | Notes |
|---|------|-------------|-------|
| 1 | SKILL.md | `skills/<name>/skills/<name>/SKILL.md` | ~100 lines recommended, max 150 |
| 2 | docs/ | `skills/<name>/skills/<name>/docs/` | Cached upstream documentation |
| 3 | Command | `skills/<name>/commands/<name>.md` | Slash command entry point |
| 4 | sync.json | `skills/<name>/sync.json` | Sync config (sources can be empty) |
| 5 | plugin.json | `skills/<name>/.claude-plugin/plugin.json` | Plugin metadata |
| 6 | .gitignore | `skills/<name>/.gitignore` | Must exclude `.cache/` |
| 7 | README.md | `skills/<name>/README.md` | User-facing documentation |

## Registration Checks

Skills must also be registered in these locations:

| Registration | File | Required? |
|-------------|------|-----------|
| Marketplace | `.claude-plugin/marketplace.json` | Always |
| CI Sync | `.github/workflows/sync-docs.yml` SKILLS array | Only if skill has upstream docs to sync |
| CLAUDE.md structure | `CLAUDE.md` project structure section | Always |
| CLAUDE.md sources | `CLAUDE.md` skill sources table | Always |

## Quality Checks

| Check | Threshold | Symbol |
|-------|-----------|--------|
| SKILL.md line count | ≤100 optimal, ≤150 acceptable, >150 warning | ✅ / ⚠️ |
| docs/ file count | ≥1 required, ≥5 good, ≥10 excellent | Count shown |
| Version consistency | sync.json = plugin.json = marketplace.json | ✅ / ⚠️ |
| .gitignore content | Must contain `.cache/` | ✅ / ❌ |

## Output Format

The audit produces a **Compliance Matrix** table:

```markdown
| Skill | SKILL.md | docs/ | commands/ | sync.json | plugin.json | .gitignore | README.md | Marketplace | CI Sync |
|-------|----------|-------|-----------|-----------|-------------|------------|-----------|-------------|---------|
| my-skill | ✅ 96L | ✅ 10 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
```

### Column Definitions

| Column | What to Check | Values |
|--------|--------------|--------|
| **SKILL.md** | File exists + line count | `✅ <N>L` or `⚠️ <N>L` (if >150) or `❌` |
| **docs/** | Directory exists + file count | `✅ <N>` or `❌` |
| **commands/** | `commands/<name>.md` exists | `✅` or `❌` |
| **sync.json** | File exists | `✅` or `❌` |
| **plugin.json** | `.claude-plugin/plugin.json` exists | `✅` or `❌` |
| **.gitignore** | File exists | `✅` or `❌` |
| **README.md** | File exists | `✅` or `❌` |
| **Marketplace** | Entry in `marketplace.json` | `✅` or `❌` |
| **CI Sync** | In SKILLS array (or `N/A` if no upstream) | `✅` / `N/A` / `❌` |

### After the Matrix

List any issues found:

```markdown
### Issues Found

1. **`skill-name`** — description of issue
2. **`skill-name`** — description of issue

### Summary

- **Total skills**: N
- **Fully compliant**: N/N
- **Issues**: N
```

## How to Perform the Audit

1. **List all skill directories**: `ls skills/` (each subdirectory is a skill)
2. **For each skill**, check all 7 required files exist at the correct paths
3. **Count SKILL.md lines**: `wc -l` on the file
4. **Count docs files**: `ls skills/<name>/skills/<name>/docs/ | wc -l`
5. **Check marketplace.json**: Parse and verify skill name is present
6. **Check sync-docs.yml**: Verify skill is in SKILLS array (skip for skills with empty `sources` in sync.json)
7. **Check version consistency**: Compare version in sync.json, plugin.json, and marketplace.json
8. **Generate the matrix table** with results
9. **List issues** below the table
