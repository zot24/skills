# Step 8 — review mode

Run on demand ("how is the site doing?") or on a monthly schedule. Read-only until the owner picks
actions.

## Pull

| Source | What | Skill |
|---|---|---|
| Umami | visitors, top pages, referrers (incl. `chatgpt.com`, `perplexity.ai`, `claude.ai`, `copilot.microsoft.com`), conversion event counts, funnel from landing to `checkout-complete`, revenue | `umami` |
| Umami replays + heatmaps | where visitors stop scrolling on money pages; rage clicks; what they click instead of the CTA | `umami` |
| Search Console | queries, pages, CTR, position; index coverage of key pages | `search-engines` |
| Bing | queries, crawl issues | `search-engines` |
| Site | `seo-geo` audit, Lighthouse | `seo-geo` |

Compare with the previous review when there is one (`apps/web/reviews/<date>.md`).

## Report

Write `apps/web/reviews/<date>.md`:

1. **Numbers** — one table: visitors, conversions, conversion rate, revenue, top 5 queries, AI
   referrals; each with the change since last time.
2. **What the data says** — at most five findings, each tied to a page and a number.
3. **Actions** — at most three, each naming the page, the change, the expected effect and the skill
   that does it (copy rewrite → `site-design-options` / `seo-geo`; tracking gap → `umami`).

Then ask the owner which actions to take. Each approved action becomes a PR.
