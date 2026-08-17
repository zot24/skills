---
name: llm-wiki
description: Expert on llm-wiki (nvk) — LLM-compiled, append-only Markdown knowledge bases for any AI coding agent. Use when working with a wiki hub or topic wiki; ingesting sources, compiling articles, querying a corpus, linting, auditing, or archiving; capturing Ideas and promoting them to Projects; managing session memory, feedback, inventory, datasets, or private adapters; or installing/pinning the plugin on Claude Code, Codex, OpenCode, or Pi. Triggers on mentions of llm-wiki, nvk/llm-wiki, /wiki commands, wiki hub, topic wiki, wikis.json, raw/ and wiki/ layers, compile wedge, query-lite, wiki:ingest, wiki:compile, wiki:query, wiki:lint, wiki:idea, wiki:adapter.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# llm-wiki — LLM-compiled knowledge bases

[llm-wiki](https://github.com/nvk/llm-wiki) (MIT, by **nvk**) turns a coding agent into a research engine backed by append-only Markdown wikis. Core loop: **ingest** external sources → **compile** synthesized, cross-referenced, confidence-scored articles → **query** → generate **output** artifacts. Zero runtime services; it drives the agent's own built-in tools.

## Overview

- **Two-layer corpus** — `raw/` holds immutable ingested sources; `wiki/` holds synthesized articles that cite them. Articles are written, never clipboard-copied.
- **Hub + isolated topic wikis** — a lightweight hub (`wikis.json`, `_index.md`, `log.md`) registers topic wikis under `topics/<name>/`, each with its own indexes so topics never bleed into each other.
- **Indexes are a derived cache** — `.md` files and their YAML frontmatter are the source of truth; `_index.md` is rebuilt on read when stale.
- **Operational memory** — default-on redacted session capture under `HUB/.sessions/`, plus feedback curation. Promotion into topic knowledge is always explicit.
- **Trust layer** — `/wiki:librarian` scores article staleness/quality; `/wiki:audit` traces outputs back through `wiki/` and `raw/` to detect drift.
- **Multi-agent** — one protocol across Claude Code, Codex, OpenCode, Pi, and a portable `AGENTS.md` fallback.

## Quick Start

```bash
claude plugin install wiki@llm-wiki     # Claude Code
codex plugin marketplace add nvk/llm-wiki && codex plugin add wiki@llm-wiki
```

```text
/wiki init bitcoin-security          # create ~/wiki/topics/bitcoin-security/
/wiki:ingest https://example.com/paper
/wiki:compile                        # raw/ sources -> cited wiki/ articles
/wiki:query "what are the threat models?"
```

## Core Concepts

- **Substrate vs. synthesis** — ingestion/indexing is commodity; the defensible part is the *compile* step that turns sources into cited articles and verdicts.
- **Read-only query path** — `/wiki:query` runs a compact "query-lite" protocol: indexes before articles, exact files before searching, never mutate while answering, never fill a gap from model memory. See [query-lite](docs/query-lite.md).
- **Explicit boundaries** — raw sources are immutable in normal workflows, archives are a context filter rather than deletion, inventory is tracking state rather than factual evidence, and nothing is promoted into topic knowledge implicitly.

## Documentation

### Architecture & layout
- **[Wiki structure](docs/wiki-structure.md)** — hub, topic wiki, every directory and file
- **[Indexing](docs/indexing.md)** — the Derived Index Protocol and staleness rules
- **[Hub resolution](docs/hub-resolution.md)** — config precedence, portable/shared hubs, macOS privacy diagnostics
- **[Skill manifest](docs/skill-manifest-upstream.md)** — the upstream skill's own principles and routing
- **[Fuzzy router](docs/router.md)** — how natural language maps to a subcommand, with priority order

### Core workflows
- **[Ingestion](docs/ingestion.md)** · **[Compilation](docs/compilation.md)** · **[Query (query-lite)](docs/query-lite.md)**
- **[Linting](docs/linting.md)** — structural + factual checks, allowlists, `--fix` semantics
- **[Librarian](docs/librarian.md)** · **[Audit](docs/audit.md)** — quality scoring and trust/provenance tracing
- **[Archive](docs/archive.md)** — topic lifecycle and per-command archived-content semantics

### Tracking & delivery
- **[Inventory](docs/inventory.md)** — items, candidates, entities, corpora, record frontmatter
- **[Ideas](docs/ideas.md)** — the Concept → Idea → Project path, approval, frozen `BRIEF.md`
- **[Projects](docs/projects.md)** · **[Portfolio](docs/portfolio.md)** — grouped outputs and the read-only hub-wide view
- **[Datasets](docs/datasets.md)** — manifests that index external data without copying it

### Memory, extension, operations
- **[Sessions](docs/sessions.md)** · **[Feedback](docs/feedback.md)** — redacted capture, rehydrate, explicit promotion
- **[Private adapters](docs/adapters.md)** — the `llm-wiki-adapter/v1` boundary, machine-local registry, governed remote writes
- **[Research infrastructure](docs/research-infrastructure.md)** — parallel agents, thesis mode
- **[Versioning & upgrades](docs/versioning.md)** — which release lines change behavior, how to pin, what to check first
- **[Command reference](docs/readme-upstream.md)** — the full upstream command table
- **[Portable protocol](docs/agents-portable.md)** — single-file `AGENTS.md` for any agent

## Common Workflows

- **Research a topic from scratch**: `/wiki:research "<topic>" --new-topic` spawns parallel investigative agents, ingests what they find, and compiles articles. Add `--mode thesis "<claim>"` for for/against evidence with a verdict.
- **Bulk-import an upstream corpus**: `/wiki:ingest-collection <git-repo|mediawiki-dump|wayback-cdx> --limit N --dry-run` previews a bounded import before writing. Never crawl HTML recursively.
- **Keep a corpus honest**: `/wiki:lint` for structure, `/wiki:librarian` for staleness, `/wiki:audit` to trace an output back to its sources. Run `lint` without `--fix` first — `--fix` rewrites indexes.

## Upstream Sources

- **Repository**: https://github.com/nvk/llm-wiki
- **Documentation**: https://llm-wiki.net (single-page docs, with `/llms.txt`)

## Sync & Update

When the user runs `sync`: re-fetch the upstream README, `AGENTS.md`, and the `claude-plugin/skills/wiki-manager/references/*.md` files listed in `sync.json`, and update `docs/`.
When the user runs `diff`: compare cached `docs/` against upstream and report what moved.
