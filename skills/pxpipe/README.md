# pxpipe Skill

Expert knowledge about [pxpipe](https://github.com/teamchong/pxpipe) (npm: `pxpipe-proxy`) — a local proxy that cuts Claude Code's input-token bill by ~59–70% by rendering bulky context (large tool results, old conversation history, system prompt + tool docs) as compressed PNG images before each request leaves your machine.

## What This Skill Covers

- **Setup**: `npx pxpipe-proxy` + `ANTHROPIC_BASE_URL`, persistent operation, instant bypass
- **Configuration**: `PXPIPE_MODELS` allowlist (default `claude-fable-5,gpt-5.6`), `CLAUDE_CODE_SUBAGENT_MODEL` for byte-exact work, dashboard kill switch and per-model toggles
- **How it works**: per-block profitability gate (~19 chars/token breakeven), what gets imaged vs what always stays text
- **Accuracy & caveats**: lossiness, silent confabulation on exact values, per-model read accuracy (Fable 5 ~87–100%, Opus 0/15 on hex recall)
- **Library API**: `renderTextToImages`, `transformAnthropicMessages`, `keepSharp`, `emitRecoverable` on Node and Cloudflare Workers
- **Savings verification**: dual-accounted counterfactual in `~/.pxpipe/events.jsonl`, dollar weights, auditing without trusting headline claims

## Usage

```
/pxpipe help          # Show available commands
/pxpipe setup         # Install and run the proxy
/pxpipe config        # Env vars, model allowlist, dashboard
/pxpipe caveats       # Lossiness and what must never be imaged
/pxpipe library       # Use the core API without the proxy
/pxpipe savings       # Audit token savings from events.jsonl
/pxpipe troubleshoot  # Diagnose common issues
```

Or just describe what you want: "cut my Claude Code token bill with pxpipe", "why did the model misremember that hash while running pxpipe?"

## Quick Start

```bash
npx pxpipe-proxy                                  # proxy on 127.0.0.1:47821
ANTHROPIC_BASE_URL=http://127.0.0.1:47821 claude  # point Claude Code at it
```

Dashboard at `http://127.0.0.1:47821/`.

> **Caveat**: pxpipe is lossy — misreads are silent confabulations. Byte-exact values (hashes, IDs, secrets) must stay text; recent turns always do.

## Upstream

- Repository: https://github.com/teamchong/pxpipe
- npm: https://www.npmjs.com/package/pxpipe-proxy

## License

MIT
