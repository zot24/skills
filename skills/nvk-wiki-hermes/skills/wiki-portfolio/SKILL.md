---
name: wiki-portfolio
description: >-
  Show a read-only hub-wide portfolio of canonical Ideas and active Projects without duplicating topic-owned records. Use when the user runs /wiki-portfolio or /wiki:portfolio. Official nvk/llm-wiki v0.23.0 command body. Never use bundled Karpathy llm-wiki against this hub.
allowed-tools: Read, Glob, Grep, Bash(ls:*), Bash(wc:*), Bash(date:*)
---

# wiki-portfolio — nvk v0.23.0 `/wiki:portfolio`

Vendored **verbatim** from nvk/llm-wiki **v0.23.0** (`d02cbcb`)
`claude-plugin/commands/portfolio.md`.
Do **not** invent compile, ingest, lint, or query protocols.

- Hermes slash: `/wiki-portfolio` (hyphen). Claude: `/wiki:portfolio` (colon). Hermes cannot use colons in slashes.
- Hub: `~/wiki` via `~/.config/llm-wiki/config.json`. Never bundled Karpathy `llm-wiki`.
- This file is self-contained for slash-load. Extra protocol files are optional pointers, not a load dependency.

## Official references (pin, not HEAD)

- `~/.claude/plugins/marketplaces/llm-wiki/plugins/llm-wiki-opencode/skills/wiki-manager/references/portfolio.md` (in-skill copy: `references/portfolio.md`; tag: https://raw.githubusercontent.com/nvk/llm-wiki/v0.23.0/plugins/llm-wiki-opencode/skills/wiki-manager/references/portfolio.md)

Official command body follows. `$ARGUMENTS` is the text after `/wiki-portfolio`.

---
## Your task

Build a current portfolio view across Ideas and Projects. Read
`references/portfolio.md` (vendored v0.23.0; pin `~/.claude/plugins/marketplaces/llm-wiki/plugins/llm-wiki-opencode/skills/wiki-manager/references/portfolio.md`), plus `ideas.md` or `projects.md`
only when their derivation rules are needed.

This operation is read-only. It must not create a `project-ideas` topic, a hub
Ideas/Portfolio directory, saved view, duplicate record, or activity-log entry.

### Resolve scope

Resolve HUB from `$HOME/.config/llm-wiki/config.json`, preferring `hub_path`.

- `--local` selects the current `.wiki/`.
- `--wiki <name>` selects one active topic from `HUB/wikis.json`.
- With neither flag, select every active topic in `HUB/wikis.json`, excluding
  the synthetic `hub` entry.
- Skip archived topics unless `--include-archived` is explicit.

### Build the catalog

For each selected topic:

1. Read its `_index.md`.
2. Read `inventory/ideas/_index.md` when present. Open individual Idea records
   only for missing requested fields, stale-index checks, filters, project
   linkage, or maturity verification.
3. Enumerate active Projects from `output/projects/*/WHY.md`. Read only the
   first heading and first non-heading paragraph by default.
4. Link an Idea and Project only through an explicit resolving `project:` field.
   A linked Project has origin `promoted Idea`; every other Project has origin
   `direct`. Never infer lineage from matching slugs or titles.
5. Apply filters and limits after collecting the compact metadata.

Do not read `raw/`, full Concept/article bodies, loose outputs, or Project
member contents for the ordinary list.

### Report

Show counts followed by separate compact Ideas and Projects tables. Include
topic, canonical link/path, operational state, next action or goal, and explicit
cross-links. State that Concepts are supporting knowledge rather than portfolio
rows and that the result is derived live from topic-owned records.

If the user asks to discover legacy or Concept-derived opportunities, stop
after a 1-3 candidate preview. Do not create bulk Idea records without explicit
approval.
