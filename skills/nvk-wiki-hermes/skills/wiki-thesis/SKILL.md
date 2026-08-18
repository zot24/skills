---
name: wiki-thesis
description: >-
  Deprecated — use /wiki:research --mode thesis instead. Thesis-driven research with for/against evidence framing and verdicts. Use when the user runs /wiki-thesis or /wiki:thesis. Official nvk/llm-wiki v0.23.0 command body. Never use bundled Karpathy llm-wiki against this hub.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(ls:*), Bash(wc:*), Bash(date:*), Bash(mkdir:*), WebFetch, WebSearch, Agent
---

# wiki-thesis — nvk v0.23.0 `/wiki:thesis`

Vendored **verbatim** from nvk/llm-wiki **v0.23.0** (`d02cbcb`)
`claude-plugin/commands/thesis.md`.
Do **not** invent compile, ingest, lint, or query protocols.

- Hermes slash: `/wiki-thesis` (hyphen). Claude: `/wiki:thesis` (colon). Hermes cannot use colons in slashes.
- Hub: `~/wiki` via `~/.config/llm-wiki/config.json`. Never bundled Karpathy `llm-wiki`.
- This file is self-contained for slash-load. Extra protocol files are optional pointers, not a load dependency.

## Official references (pin, not HEAD)

- Pin wiki-manager: `~/.claude/plugins/marketplaces/llm-wiki/plugins/llm-wiki-opencode/skills/wiki-manager/` (tag v0.23.0 / `d02cbcb`). Load those references only when this command body asks.

Official command body follows. `$ARGUMENTS` is the text after `/wiki-thesis`.

---
## Deprecated

This command has been merged into `/wiki:research --mode thesis "<claim>"`. The thesis-specific logic (Phase 0 decomposition, for/against agent framing, evidence compilation, verdict rendering, anti-confirmation-bias Round 2) now lives as a mode inside research.md, sharing the same infrastructure (agents, credibility scoring, session registry, multi-round --min-time) without duplication.

**For backward compatibility**, this shim executes the same logic:

1. Read `commands/research.md` and follow it with `--mode thesis` prepended to `$ARGUMENTS`
2. All flags (`--min-time`, `--deep`, `--retardmax`, `--wiki`) pass through unchanged
3. The input (everything that is not a flag) becomes the thesis claim

**Migration**: replace `/wiki:thesis "<claim>"` with `/wiki:research --mode thesis "<claim>"` in any saved workflows or documentation. This shim will be removed in a future release.
