# nvk wiki commands on Hermes

Official nvk/llm-wiki v0.23.0 (`d02cbcb`) command pack.
Hermes slashes use hyphens. Claude uses colons.

## Command: $ARGUMENTS

| Hermes | Claude | Skill |
|---|---|---|
| `/wiki` | `/wiki` | `wiki` |
| `/wiki-adapter` | `/wiki:adapter` | `wiki-adapter` |
| `/wiki-archive` | `/wiki:archive` | `wiki-archive` |
| `/wiki-assess` | `/wiki:assess` | `wiki-assess` |
| `/wiki-audit` | `/wiki:audit` | `wiki-audit` |
| `/wiki-collect` | `/wiki:collect` | `wiki-collect` |
| `/wiki-compile` | `/wiki:compile` | `wiki-compile` |
| `/wiki-dataset` | `/wiki:dataset` | `wiki-dataset` |
| `/wiki-feedback` | `/wiki:feedback` | `wiki-feedback` |
| `/wiki-idea` | `/wiki:idea` | `wiki-idea` |
| `/wiki-ingest` | `/wiki:ingest` | `wiki-ingest` |
| `/wiki-ingest-collection` | `/wiki:ingest-collection` | `wiki-ingest-collection` |
| `/wiki-inventory` | `/wiki:inventory` | `wiki-inventory` |
| `/wiki-librarian` | `/wiki:librarian` | `wiki-librarian` |
| `/wiki-lint` | `/wiki:lint` | `wiki-lint` |
| `/wiki-ll` | `/wiki:ll` | `wiki-ll` |
| `/wiki-output` | `/wiki:output` | `wiki-output` |
| `/wiki-plan` | `/wiki:plan` | `wiki-plan` |
| `/wiki-portfolio` | `/wiki:portfolio` | `wiki-portfolio` |
| `/wiki-project` | `/wiki:project` | `wiki-project` |
| `/wiki-query` | `/wiki:query` | `wiki-query` |
| `/wiki-refresh` | `/wiki:refresh` | `wiki-refresh` |
| `/wiki-research` | `/wiki:research` | `wiki-research` |
| `/wiki-retract` | `/wiki:retract` | `wiki-retract` |
| `/wiki-session` | `/wiki:session` | `wiki-session` |
| `/wiki-specialist` | `/wiki:specialist` | `wiki-specialist` |
| `/wiki-thesis` | `/wiki:thesis` | `wiki-thesis` |

If `$ARGUMENTS` is empty or `help`, print this table.
Otherwise route to the matching skill under `skills/`.
Do not invent protocols. Vendor text is the protocol.
