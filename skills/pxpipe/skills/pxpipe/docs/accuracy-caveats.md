<!-- Source: https://github.com/teamchong/pxpipe (README + FINDINGS.md) — hand-curated -->

# pxpipe Accuracy & Caveats

pxpipe is **lossy**. Read this before recommending it for any workflow involving byte-exact values.

## Silent Confabulation, Not Errors

Vision has no per-glyph confidence; the language prior fills gaps with plausible wrong answers. Misreads come back as confident, plausible values — not error messages.

Measured upstream: exact 12-char hex strings in dense imaged content read **13/15 on Fable 5, 0/15 on Opus 4.8** — and the Opus misses were silent confabulations. A documented real-world failure: "the model recalled a person's name from imaged chat history and got it confidently wrong."

## Per-Model Read Accuracy

| Model | Behavior |
|---|---|
| Fable 5 | Default. Reads imaged content at ~87–100% |
| Opus 4.8 | Opt-in. Misreads ~7% of renders, confabulates hex identifiers |
| GPT 5.6 | Opt-in. Degrades on imaged context |
| All others | Pass through byte-identical (never imaged) |

Keep the default allowlist (`claude-fable-5,gpt-5.6`) unless the user explicitly accepts the tradeoff.

## What Must Never Be Imaged

Byte-exact values: hashes, hex IDs, secrets, API keys, verbatim strings that will be reused exactly. Mitigations, in order of preference:

1. **Recent turns always stay text** — covers most fresh values automatically.
2. **`CLAUDE_CODE_SUBAGENT_MODEL`** — route byte-exact subagent work to a non-allowlisted model so it bypasses imaging entirely.
3. **`keepSharp` (library API)** — pin specific blocks as text; see [library-api](library-api.md).
4. **Re-read the source** — a fresh `tool_result` is recent and stays text.

## Other Limitations

- PNG encoding adds latency before requests leave.
- Well-tested on ASCII/Latin-1; conservative with CJK.
- Verbatim recall from images is unreliable in general — treat imaged history as gist, not ground truth.
