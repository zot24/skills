<!-- Source: https://github.com/teamchong/pxpipe (README; full API in src/core/index.ts) — hand-curated -->

# pxpipe Library API

Use pxpipe's core without the proxy — works on Node and Cloudflare Workers.

```bash
npm install pxpipe-proxy
```

## Render text to image pages

```ts
import { renderTextToImages } from "pxpipe-proxy";

const { pages } = await renderTextToImages(toolResultText);
// pages[i].png contains a Uint8Array
```

## Transform Anthropic message bodies

```ts
import { transformAnthropicMessages } from "pxpipe-proxy";

const { body, applied, info } = await transformAnthropicMessages({
  body: requestBytes,
  model: "claude-fable-5",
});
```

- `body` — the (possibly) transformed request bytes
- `applied` — whether any imaging occurred (the profitability gate may decline)
- `info` — details about what was converted

## Advanced Options

- `options.keepSharp(block)` — predicate that pins specified blocks as text (no imaging). Use for blocks containing byte-exact values (hashes, IDs, secrets).
- `options.emitRecoverable` — returns the originals of imaged blocks so callers can recover exact text later.

Full API surface lives in `src/core/index.ts` of the upstream repo: https://github.com/teamchong/pxpipe
