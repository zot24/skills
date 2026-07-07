---
name: pxpipe
description: Set up, run, tune, and debug pxpipe (pxpipe-proxy) — a local proxy that cuts Claude Code token costs ~59–70% by rendering bulky context (tool results, old history, system prompt) as compressed PNG images before requests leave the machine. Use whenever the user mentions pxpipe, pxpipe-proxy, imaging context, PNG context compression, reducing Claude Code token costs/bill via a proxy, ANTHROPIC_BASE_URL proxies for token savings, or asks to verify pxpipe savings or troubleshoot misread/confabulated values while running it.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# pxpipe — PNG Context Compression Proxy for Claude Code

Local proxy that intercepts `/v1/messages` requests and rewrites bulky text blocks into dense PNG images. An image's token cost is fixed by pixel dimensions, not text volume — dense content (code, JSON, logs) packs ~3.1 chars per image-token vs ~1 char per text-token, landing a ~59–70% lower end-to-end bill on real Claude Code traffic. Runs on Node and Cloudflare Workers. MIT.

**It is lossy.** Misreads are silent confabulations, not errors — see [Accuracy & Caveats](docs/accuracy-caveats.md) before recommending it for workflows involving byte-exact values.

## Overview

- **Selective imaging** — only large `tool_result` bodies (>~6k chars), collapsed older history, and the system prompt/tool docs get imaged, and only when a per-block profitability estimate wins (~19 chars/token breakeven)
- **Fails safe** — recent turns, sparse prose, model output, and non-allowlisted models pass through byte-identical
- **Live dashboard** at `http://127.0.0.1:47821/` — savings, conversion log, kill switch, per-model toggles
- **Auditable savings** — every request dual-accounted against a free `count_tokens` counterfactual in `~/.pxpipe/events.jsonl`
- **Library API** — use `renderTextToImages` / `transformAnthropicMessages` directly without the proxy

## Quick Start

```bash
npx pxpipe-proxy                                  # proxy on 127.0.0.1:47821
ANTHROPIC_BASE_URL=http://127.0.0.1:47821 claude  # point Claude Code at it
```

## Core Concepts

- **Profitability gate** — text averages ~3.5 chars/token on prose but ~1 char/token on dense code/JSON; imaging only wins past ~19 chars/token equivalent density, so sparse content stays text. See [setup](docs/setup.md).
- **Model allowlist** — `PXPIPE_MODELS` defaults to `claude-fable-5,gpt-5.6`. Opus 4.8 and GPT variants are opt-in because they misread imaged content (Opus: 0/15 on exact 12-char hex recall vs 13/15 on Fable 5). See [accuracy](docs/accuracy-caveats.md).
- **Byte-exact escape hatches** — recent turns always stay text; `CLAUDE_CODE_SUBAGENT_MODEL` routes subagent work to a non-imaged model; the library's `keepSharp` pins blocks as text.

## Documentation

- **[Setup & Configuration](docs/setup.md)** — install, env vars, dashboard, profitability gate, troubleshooting
- **[Accuracy & Caveats](docs/accuracy-caveats.md)** — lossiness, per-model read accuracy, what must never be imaged
- **[Library API](docs/library-api.md)** — `renderTextToImages`, `transformAnthropicMessages`, `keepSharp`, `emitRecoverable`
- **[Verifying Savings](docs/savings-verification.md)** — dual-accounting methodology, `events.jsonl` schema, dollar weights
- **[Upstream README](docs/readme-upstream.md)** — full cached upstream documentation

## Common Workflows

- **Try it on one session**: `npx pxpipe-proxy` in one terminal, `ANTHROPIC_BASE_URL=http://127.0.0.1:47821 claude` in another, watch the dashboard.
- **Model recalled a value wrong** (name, hash, ID from old context): expected imaged-history failure — ask it to re-read the source file (fresh tool_result stays text), or hit the dashboard kill switch.
- **Audit the savings claim**: compute your own totals from `~/.pxpipe/events.jsonl` (formulas in `src/core/baseline.ts` upstream) instead of trusting the headline number.

## Upstream Sources

- **Repository**: https://github.com/teamchong/pxpipe
- **npm**: https://www.npmjs.com/package/pxpipe-proxy

## Sync & Update

When user runs `sync`: fetch the latest upstream README and update docs/ files.
When user runs `diff`: compare current docs/ vs upstream.
