# Plan 011: Repurpose the chat-sdk skill for the new Chat SDK (vercel/chat) — scratch the old AI-Chatbot content

> **Executor instructions**: Follow this plan step by step. Run every
> verification command and confirm the expected result before moving on.
> Touch only the files listed as in scope. If any STOP condition occurs,
> stop and report. Commit in the worktree per the git workflow section.
> SKIP updating `plans/README.md` — the reviewer maintains the index.

## Status

- **Priority**: P1 (operator-requested)
- **Effort**: M
- **Risk**: LOW (single-skill content replacement)
- **Depends on**: plans 005–010 (already merged to main — your base includes them)
- **Category**: docs / direction
- **Planned at**: commit `db165af`, 2026-07-06

## Why this matters

chat-sdk.dev no longer hosts Vercel's AI-Chatbot docs — the domain now serves **Chat SDK (github.com/vercel/chat, npm package `chat`, v4.x)**: a unified TypeScript SDK for building chat bots/agents across Slack, Teams, Google Chat, Discord, Telegram, WhatsApp and more, with type-safe adapters, JSX cards, and AI streaming. The operator has decided: **the skill follows the domain** — scratch the frozen AI-Chatbot content and rebuild the skill around the new product. The new site serves clean per-page markdown (`.md` suffix) and an `llms.txt` index of 79 pages (verified 2026-07-06).

## Current state (post plans 005–010)

- `skills/chat-sdk/sync.json` — 1 source: `https://raw.githubusercontent.com/vercel/ai-chatbot/main/README.md` → `skills/chat-sdk/docs/readme-upstream.md`.
- `skills/chat-sdk/skills/chat-sdk/docs/` — old-product docs, 7 of them frozen with `> NOTE: chat-sdk.dev has been repurposed…` notes (`overview.md`, `setup.md`, `architecture.md`, `models-and-providers.md`, `artifacts.md`, `theming.md`, `deployment.md`) plus `readme-upstream.md` and possibly others — list them with `ls`.
- `skills/chat-sdk/skills/chat-sdk/SKILL.md`, `commands/chat-sdk.md`, `README.md`, `.claude-plugin/plugin.json` — all describe the OLD product (Vercel AI Chatbot template).
- `skills/chat-sdk/discover-pages.sh` — a guard/no-op created by plan 005 (verifies the single GitHub source).
- `CLAUDE.md` skill-sources table has a chat-sdk row pointing at the old upstream.
- Root `README.md` skills table has a chat-sdk row with the old description.
- Version fields: **owned by release-please since plan 008 — do NOT edit any version field.** The breaking-change commit message (below) makes release-please propose the major bump.
- New product facts (verified): `https://chat-sdk.dev/llms.txt` → 79 `.md` page URLs across sections Documentation, Usage, AI, Adapters, Messaging, Interactivity, API Reference, Contributing, Official/Vendor-Official/Community Adapters. Repo: `https://github.com/vercel/chat` (from npm registry metadata for package `chat`). `https://raw.githubusercontent.com/vercel/chat/main/README.md` — probe it; if 404 try the repo's default branch via `gh api repos/vercel/chat --jq .default_branch`.

## Commands you will need

| Purpose | Command | Expected |
|---|---|---|
| JSON valid | `jq empty skills/chat-sdk/sync.json` | exit 0 |
| Sync | `.github/workflows/scripts/sync-skill.sh skills/chat-sdk --force` | exit 0, Successful == Total, 0 FAILED |
| Consistency | `.github/workflows/scripts/check-consistency.sh` | `All manifests consistent` |
| Script syntax | `bash -n skills/chat-sdk/discover-pages.sh` | exit 0 |

## Scope

**In scope** (only these):
- `skills/chat-sdk/sync.json` (rewrite)
- `skills/chat-sdk/skills/chat-sdk/docs/` — DELETE all old files (yes, deletion is authorized for THIS plan — the operator said "scratch what we have"), then populate via sync
- `skills/chat-sdk/skills/chat-sdk/SKILL.md` (rewrite)
- `skills/chat-sdk/commands/chat-sdk.md` (rewrite content, keep `${CLAUDE_PLUGIN_ROOT}` path convention)
- `skills/chat-sdk/README.md` (rewrite)
- `skills/chat-sdk/.claude-plugin/plugin.json` (description/keywords/homepage ONLY — not version)
- `.claude-plugin/marketplace.json` (chat-sdk entry's description ONLY — not version)
- `skills/chat-sdk/discover-pages.sh` (rewrite as a real llms.txt-driven script)
- `CLAUDE.md` (chat-sdk row in the skill-sources table only)
- Root `README.md` (chat-sdk row in the skills table + its details section only)

**Out of scope**: every other skill; workflows; shared scripts; ALL version fields everywhere; `skills.toml`; release-please files.

## Git workflow

- Branch: `advisor/011-chat-sdk-repurpose` off your worktree HEAD
- One commit with a conventional BREAKING message:
  ```
  feat(chat-sdk)!: repurpose skill for the new multi-platform Chat SDK (vercel/chat)

  BREAKING CHANGE: chat-sdk.dev now hosts vercel/chat (unified TypeScript SDK
  for Slack/Teams/Discord/Telegram bots), not the AI Chatbot template. All
  docs, sources, and skill metadata now target the new product.
  ```
- Do NOT push or open a PR.

## Steps

### Step 1: Build the new sync.json from llms.txt

Fetch `https://chat-sdk.dev/llms.txt`, extract all `https://chat-sdk.dev/....md` URLs (expect 79; EXCLUDE `llms-full.txt`). Map each URL to a target with this deterministic rule (targets under `skills/chat-sdk/docs/`, mirroring the URL path):

- `https://chat-sdk.dev/docs.md` → `introduction.md`
- `https://chat-sdk.dev/docs/<path>.md` → `<path>.md` with `/` → `-` (e.g. `docs/ai/ai-sdk-tools.md` → `ai-ai-sdk-tools.md`, `docs/api/chat.md` → `api-chat.md`, `docs/contributing/building.md` → `contributing-building.md`)
- `https://chat-sdk.dev/adapters/official/<name>.md` → `adapter-<name>.md`
- `https://chat-sdk.dev/adapters/vendor-official/<name>.md` → `adapter-vendor-<name>.md`
- `https://chat-sdk.dev/adapters/community/<name>.md` → `adapter-community-<name>.md`

All entries: `"type": "extract-content"`, `"freshness_days": 14`. Add one more source: the vercel/chat repo README (probe the raw URL; use the default branch) → `readme-upstream.md`, type `raw`. Keep sync.json's `name`/`description` fields updated for the new product; DO NOT change `version`. Generate the JSON with a script (jq/python) rather than by hand — 80 entries.

**Verify**: `jq empty` exit 0; `jq '.sources | length'` → 80; `jq -r '.sources[].target' | sort | uniq -d` → empty (no target collisions).

### Step 2: Scratch the old docs and sync the new

1. `git rm -r skills/chat-sdk/skills/chat-sdk/docs/` (removes all old-product files).
2. Run the sync: `.github/workflows/scripts/sync-skill.sh skills/chat-sdk --force`.

**Verify**: sync exits 0, `Successful: 80`, 0 FAILED/INVALID. `ls skills/chat-sdk/skills/chat-sdk/docs/ | wc -l` → 80. `grep -rl 'AI Chatbot\|ai-chatbot' skills/chat-sdk/skills/chat-sdk/docs/` → no matches (old product gone; if a hit appears inside legitimate new-product prose, read it and judge — STOP if ambiguous). Spot-read `introduction.md` and `adapter-slack.md`: real Chat SDK prose, no JSX/HTML pollution.

### Step 3: Rewrite SKILL.md (~100 lines, ≤150)

New frontmatter description (adjust wording as needed, keep trigger style):
```yaml
description: Expert at Chat SDK (vercel/chat) - the unified TypeScript SDK for building chat bots and agents across Slack, Microsoft Teams, Google Chat, Discord, Telegram, WhatsApp, and more. Use when building multi-platform bots, chat adapters, JSX cards, modals, slash commands, or AI streaming to chat platforms. Triggers on mentions of Chat SDK, chat bots, Slack bot, Teams bot, Discord bot, chat adapters.
```
Body: overview bullets (single codebase, type-safe adapters, event-driven handlers, thread subscriptions, JSX cards/modals, AI streaming, serverless-ready with Redis state); a Quick Start (the `new Chat({...})` example shape from `introduction.md` — take it from the synced doc); core concepts (Chat / Adapters / State); a Documentation section referencing the docs/ files GROUPED (Getting started & usage, AI, Adapters, Messaging, Interactivity, API reference, Contributing) — you do NOT need to list all 80 files; list the ~25 most important and say adapter references follow the `adapter-*.md` pattern; Upstream Sources (chat-sdk.dev, github.com/vercel/chat); the standard Sync & Update section.

**Verify**: `wc -l` ≤ 150; every `docs/<file>.md` referenced exists (standard loop).

### Step 4: Rewrite command file, README, plugin/marketplace descriptions

- `commands/chat-sdk.md`: keep the command-table shape (create/validate-style commands don't apply — use: `overview`, `adapters`, `ai`, `api <name>`, `sync`, `diff`, `help`); instructions reference `${CLAUDE_PLUGIN_ROOT}/skills/chat-sdk/SKILL.md` and the docs groups.
- `skills/chat-sdk/README.md`: new product description, usage, features.
- `plugin.json`: description = SKILL.md description's first sentence; keywords for the new product (chat-sdk, chat-bots, slack, teams, discord, telegram, adapters, typescript); homepage `https://chat-sdk.dev`. NOT version.
- `.claude-plugin/marketplace.json`: update ONLY the chat-sdk entry's `description`. NOT version.
- `CLAUDE.md` sources-table chat-sdk row → `| chat-sdk | https://chat-sdk.dev/docs + https://github.com/vercel/chat | URL-based |`.
- Root `README.md`: chat-sdk row description + its details section further down (grep for the old description text).

**Verify**: `grep -rn 'ai-chatbot\|AI Chatbot' skills/chat-sdk/ CLAUDE.md README.md .claude-plugin/marketplace.json | grep -v docs/` → no matches referring to chat-sdk (other skills' rows like ai-sdk are unrelated — read hits before judging).

### Step 5: Rewrite discover-pages.sh

Replace the guard/no-op with a real llms.txt-driven script modeled on `skills/1password-cli/discover-pages.sh`: fetch `https://chat-sdk.dev/llms.txt`, extract `.md` URLs (exclude `llms-full.txt`), dedup vs sync.json with `grep -qxF`, `--auto-add` adds new entries using the step-1 slug mapping, `set -euo pipefail`, `|| true` curl guard.

**Verify**: `bash -n` clean; flagless run reports zero NEW (all 79 tracked) and exits 0.

### Step 6: Full verification

- `.github/workflows/scripts/check-consistency.sh` → `All manifests consistent` (descriptions changed, versions untouched — must still pass).
- Re-run the sync once more → `has_changes=false` or only trivial changes (idempotence).

## Test plan

The step verifications are the tests. No framework; add none.

## Done criteria

- [ ] 80 sources, 80 docs files, sync 80/80 clean
- [ ] No AI-Chatbot-era references in chat-sdk skill files (docs/ excluded from the grep only where hits are new-product prose)
- [ ] SKILL.md ≤ 150 lines, refs resolve
- [ ] discover script real, clean, zero false-NEW
- [ ] check-consistency.sh passes; NO version field changed anywhere (`git diff` contains no `"version"` line changes)
- [ ] Single commit with the BREAKING-change message shape

## STOP conditions

- llms.txt count differs wildly from 79 (site restructured again mid-flight) — report.
- More than 5 of the 80 sources fail to sync after one retry — report which.
- The vercel/chat README raw URL can't be resolved on any branch — proceed without that source but note it.
- Any verification suggests you must edit a version field or a file out of scope.

## Maintenance notes

- release-please will propose `2.0.0` (or the next major) for chat-sdk from the `feat!:` commit — the operator should sanity-check that release PR.
- The discover script now tracks the new site; the old "domain repurposed" note in plans/README.md is superseded by this plan.
- Deferred: a per-adapter deep-dive section in SKILL.md if usage shows demand.
