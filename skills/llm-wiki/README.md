# llm-wiki Skill

Expert knowledge about [llm-wiki](https://github.com/nvk/llm-wiki) (MIT, by **nvk**) — LLM-compiled, append-only Markdown knowledge bases for any AI coding agent. *Ingest anything → compile cited articles → query → generate artifacts.*

## What This Skill Covers

- **Architecture**: the hub + isolated topic wikis, the immutable `raw/` vs synthesized `wiki/` split, the Derived Index Protocol, hub resolution and portable/shared hubs
- **Core loop**: ingestion (URLs, files, PDFs, inbox batches, bulk collections), compilation into cross-referenced and confidence-scored articles, and the read-only query-lite protocol
- **Maintenance & trust**: lint (structure + allowlists + `--fix` semantics), librarian quality scoring, audit and provenance tracing, archive lifecycle
- **Tracking & delivery**: inventory records, dataset manifests, the Concept → Idea → Project promotion path, projects, and the hub-wide portfolio view
- **Memory**: default-on redacted session capture, rehydrate, feedback curation, and explicit promotion into topic knowledge
- **Extension**: the private-adapter (`llm-wiki-adapter/v1`) boundary, machine-local registry, and governed remote writes
- **Operations**: installing on Claude Code / Codex / OpenCode / Pi, the portable `AGENTS.md` fallback, checking the installed version, classifying an upgrade diff, and pinning to a tag

## Usage

```
/llm-wiki help                # Show available commands
/llm-wiki quickstart          # Install, create a wiki, ingest, compile, query
/llm-wiki install             # Per-harness install instructions
/llm-wiki structure           # Hub and topic-wiki layout
/llm-wiki query               # The read-only query-lite protocol
/llm-wiki lint                # Health checks and --fix semantics
/llm-wiki idea                # Concept -> Idea -> Project promotion
/llm-wiki adapter             # Private adapters and governed remote writes
/llm-wiki upgrade             # Check version, classify a diff, pin to a tag
/llm-wiki sync                # Update docs from upstream
```

## Documentation Sources

Documentation is synced from the [nvk/llm-wiki](https://github.com/nvk/llm-wiki) repository on `master` and cached under `skills/llm-wiki/docs/`. Filenames mirror upstream, so `docs/linting.md` is the upstream `claude-plugin/skills/wiki-manager/references/linting.md`.

Cached: the README (full command table), the portable `AGENTS.md` protocol, the upstream skill manifest, the fuzzy router command spec, and the 19 `wiki-manager` reference docs.

One file is **authored for this skill and deliberately not synced**: `docs/versioning.md`, which covers how to tell a safe additive release from one that implies a corpus migration, and what to check after an upgrade. Upstream documents each release individually; this consolidates the decision.

## Notes

- llm-wiki installs as a **git checkout of the upstream repo**, so upgrading and downgrading are both just `git checkout <tag>`. The plugin is cheap to roll back; a corpus is not.
- Querying is read-only by contract. Anything that mutates a corpus — `lint --fix`, `retract`, `archive` — should be dry-run first.
- Upstream's fuzzy router matches natural language **in priority order**. Re-read that table after upgrading: a command moving to priority 0 changes what an ordinary sentence does, with no schema change to warn you.

## Sync

```bash
# Sync this skill's docs from upstream
.github/workflows/scripts/sync-skill.sh skills/llm-wiki

# Force refresh (ignore freshness check)
.github/workflows/scripts/sync-skill.sh skills/llm-wiki --force

# Dry run
.github/workflows/scripts/sync-skill.sh skills/llm-wiki --dry-run
```

## Upstream

- **Repository**: https://github.com/nvk/llm-wiki
- **Documentation**: https://llm-wiki.net (single-page docs, with `/llms.txt`)
- **License**: MIT
