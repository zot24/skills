<!-- Source: https://github.com/teamchong/pxpipe (README) — hand-curated -->

# pxpipe Setup & Configuration

## Install & Run

```bash
npx pxpipe-proxy                                  # starts proxy on 127.0.0.1:47821
ANTHROPIC_BASE_URL=http://127.0.0.1:47821 claude  # point Claude Code at it
```

No CLI flags — configuration flows through environment variables and the dashboard.

To make it persistent, export `ANTHROPIC_BASE_URL` in the shell profile and run the proxy under a process manager (launchd/pm2). Unset the variable (or use the dashboard kill switch) to bypass instantly — the proxy passes non-allowlisted models through byte-identical, so it fails safe.

## Environment Variables

| Variable | Default | Purpose |
|---|---|---|
| `ANTHROPIC_BASE_URL` | — | Set to `http://127.0.0.1:47821` so Claude Code routes through the proxy |
| `PXPIPE_MODELS` | `claude-fable-5,gpt-5.6` | Allowlist of models to image. `off` disables all imaging. Others pass through unmodified |
| `CLAUDE_CODE_SUBAGENT_MODEL` | — | Route subagents to a non-allowlisted model (e.g. `claude-sonnet-5`) so byte-exact work bypasses imaging |

Opus and GPT variants are deliberately opt-in (dashboard or `PXPIPE_MODELS`): they misread imaged content noticeably more than Fable 5.

## Dashboard

At `http://127.0.0.1:47821/`:

- Token savings display (text vs imaged request totals)
- Side-by-side conversion log (original text → rendered PNG)
- Kill switch to disable imaging
- Live model chips to toggle compression per model

## What Gets Imaged

Compressed only when the profitability estimate wins (~19 chars/token breakeven per block):

1. **Large `tool_result` bodies** — file reads, command output, logs above ~6k chars
2. **Collapsed older history** — old turns re-rendered as image pages
3. **System prompt + tool docs** — the static preamble

Never touched: recent conversation turns, sparse prose, model output, small blocks, and any request for a model outside the allowlist.

## Profitability Gate

Text wins on sparse prose (~3.5 chars/token); images win on dense code/JSON (~1 char/token as text, ~3.1 chars per image-token). Claude Code traffic averages ~1.91 chars/token, favoring compression. Blocks below the ~19 chars/token equivalent breakeven stay text.

## Troubleshooting

- **No savings shown**: check the model in use is on the `PXPIPE_MODELS` allowlist and that requests actually route through the proxy (`ANTHROPIC_BASE_URL` set in the same shell that launched `claude`). Small/sparse requests are legitimately skipped by the profitability gate.
- **Model recalls a value wrong** (name, hash, ID from old context): expected failure mode of imaged history — see [accuracy-caveats](accuracy-caveats.md). Ask it to re-read the source file (fresh recent tool_result stays text), or disable imaging for the session.
- **Suspect the proxy is mangling a request**: open the dashboard conversion log and compare original vs rendered; hit the kill switch to A/B.
- **Port conflict**: port is fixed at `47821`; find the conflicting process with `lsof -i :47821`.
- **Latency**: PNG encoding adds time before each request leaves — expected overhead.

## Development (upstream repo)

```bash
pnpm install && pnpm test
pnpm run build  # regenerates dist/
```
