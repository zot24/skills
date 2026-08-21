---
name: nvk-wiki-hermes
description: >-
  Hermes hyphen-slash pack of every nvk/llm-wiki v0.23.0 Claude command
  (/wiki, /wiki-compile, /wiki-ingest, …). Use when the user wants the
  official nvk command surface on Hermes. Never Karpathy llm-wiki.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# nvk-wiki-hermes — official nvk v0.23.0 command pack

Peer of the **llm-wiki expert** skill. This package is the **command
surface**, not the expert digest. Extending `skills/llm-wiki/` would smash
that expert skill, so these slashes live here.

Pin: nvk/llm-wiki **v0.23.0** (`d02cbcb`). Sync from that tag, not `master`.

Hermes cannot use colons in slashes. Map:

| Claude | Hermes | Skill |
|---|---|---|
| `/wiki` | `/wiki` | `wiki` |
| `/wiki:adapter` | `/wiki-adapter` | `wiki-adapter` |
| `/wiki:archive` | `/wiki-archive` | `wiki-archive` |
| `/wiki:assess` | `/wiki-assess` | `wiki-assess` |
| `/wiki:audit` | `/wiki-audit` | `wiki-audit` |
| `/wiki:collect` | `/wiki-collect` | `wiki-collect` |
| `/wiki:compile` | `/wiki-compile` | `wiki-compile` |
| `/wiki:dataset` | `/wiki-dataset` | `wiki-dataset` |
| `/wiki:feedback` | `/wiki-feedback` | `wiki-feedback` |
| `/wiki:idea` | `/wiki-idea` | `wiki-idea` |
| `/wiki:ingest` | `/wiki-ingest` | `wiki-ingest` |
| `/wiki:ingest-collection` | `/wiki-ingest-collection` | `wiki-ingest-collection` |
| `/wiki:inventory` | `/wiki-inventory` | `wiki-inventory` |
| `/wiki:librarian` | `/wiki-librarian` | `wiki-librarian` |
| `/wiki:lint` | `/wiki-lint` | `wiki-lint` |
| `/wiki:ll` | `/wiki-ll` | `wiki-ll` |
| `/wiki:output` | `/wiki-output` | `wiki-output` |
| `/wiki:plan` | `/wiki-plan` | `wiki-plan` |
| `/wiki:portfolio` | `/wiki-portfolio` | `wiki-portfolio` |
| `/wiki:project` | `/wiki-project` | `wiki-project` |
| `/wiki:query` | `/wiki-query` | `wiki-query` |
| `/wiki:refresh` | `/wiki-refresh` | `wiki-refresh` |
| `/wiki:research` | `/wiki-research` | `wiki-research` |
| `/wiki:retract` | `/wiki-retract` | `wiki-retract` |
| `/wiki:session` | `/wiki-session` | `wiki-session` |
| `/wiki:specialist` | `/wiki-specialist` | `wiki-specialist` |
| `/wiki:thesis` | `/wiki-thesis` | `wiki-thesis` |

Load the matching `wiki` / `wiki-<cmd>` skill. Each of those SKILL.md files
embeds the official command body.

Do not invent protocols. Do not compile or `lint --fix` a hub unless the
user invoked that command and the official body allows it.

## Documentation

- **[Layout](docs/layout.md)** — what is vendored, what is generated, and which files never to hand-edit
- **[The llm-wiki CLI](docs/cli.md)** — three commands need an external CLI, how it is resolved, and what to install
- **[Pin policy](docs/pin.md)** — why the sources are tag-pinned to v0.23.0 and what a version bump involves
