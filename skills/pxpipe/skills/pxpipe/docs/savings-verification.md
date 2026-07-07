<!-- Source: https://github.com/teamchong/pxpipe (README; formulas in src/core/baseline.ts) — hand-curated -->

# Verifying pxpipe Savings

Don't trust the headline 59–70% claim — derive your own figure from production logs. pxpipe dual-accounts every request so this is straightforward.

## Methodology (parallel accounting)

On every `/v1/messages` POST:

1. A **free `count_tokens` call** quantifies the uncompressed counterfactual (what the request would have cost as plain text).
2. The **actual Anthropic usage block** is captured from the response.
3. Both are recorded in the **same row, same moment** in `~/.pxpipe/events.jsonl`.

## Dollar Conversion Weights

| Token type | Weight |
|---|---|
| Input | ×1.0 |
| Cache write | ×1.25 |
| Cache read | ×0.1 |
| Output | ×5 |

Cache pricing is applied identically to both sides — no double-counting.

## What "End-to-End Bill" Includes

All requests: small untouched ones, all cache reads/writes, and output tokens (which the proxy never compresses). The 59–70% figure is workload-dependent snapshot data; the durable number is the per-request token cut in your own `events.jsonl`.

## Auditing Yourself

- Log file: `~/.pxpipe/events.jsonl` (one JSON row per request, both counterfactual and actual)
- Field names and formulas: `src/core/baseline.ts` in the upstream repo
- The dashboard at `http://127.0.0.1:47821/` renders the same data live
