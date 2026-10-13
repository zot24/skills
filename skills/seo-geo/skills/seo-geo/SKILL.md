---
name: seo-geo
description: Technical SEO and GEO (generative engine optimization) for Astro sites on Cloudflare Workers — head tags, canonicals, sitemap, robots.txt, noindex on preview builds, JSON-LD structured data, Cloudflare AI bot policies and AI crawler rules, llms.txt, answer-first copy that AI assistants quote, Core Web Vitals and a scripted audit. Use when building or auditing a landing page for search, making a site visible in ChatGPT, Claude, Perplexity or Copilot answers, writing meta tags or schema, or deciding which AI bots to allow. Triggers on SEO, GEO, AEO, AI search, meta description, canonical, sitemap, robots.txt, JSON-LD, schema.org, llms.txt, GPTBot, ClaudeBot, OAI-SearchBot, AI Crawl Control, Content-Signal, rich results.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# seo-geo

Makes a site easy to find for search engines **and** easy to quote for answer engines. Search ranks
pages; assistants lift passages. Both need the same base: crawlable pages, clear entities, specific
answers.

## Overview

- **Technical SEO** — `Seo.astro` head component, `site` + sitemap, generated `robots.txt`, preview
  builds kept out of the index, redirects, Core Web Vitals
- **Structured data** — one JSON-LD graph per page, `Organization` with `sameAs`, page types
- **AI crawlers** — Cloudflare AI bot policies (Search, Agent, Training) and `robots.txt` in agreement
- **llms.txt** — generated from the site's own content
- **Answer-first content** — query map and ten writing rules for passages assistants quote
- **Audit** — scripted checks with pass criteria

## Defaults

| Decision | Default | Change when |
|---|---|---|
| Search and Agent AI bots | Allow | never on a site that wants traffic |
| Training AI bots | Allow | the site sells its content |
| Preview builds | `noindex` + `Disallow: /` | — |
| Canonical origin | apex, `https`, no trailing slash | the owner already ranks on `www` |
| `llms.txt` | always | — |

## Documentation

Authored guides (start here):

- **[Technical SEO](docs/technical-seo.md)** — config, head component, previews, robots.txt, performance
- **[Structured data](docs/structured-data.md)** — JSON-LD component, site-wide nodes, page types, validation
- **[AI crawlers](docs/ai-crawlers.md)** — behaviours, edge policy, robots groups, verify, AI referrers
- **[llms.txt](docs/llms-txt.md)** — format, generated endpoint, what the summary says
- **[Answer-first content](docs/answer-first-content.md)** — query map, writing rules, review loop
- **[Audit](docs/audit.md)** — crawlability, per-page checks, GEO, Lighthouse

Synced upstream references:

- **[Cloudflare AI bot policies](docs/cloudflare-ai-bot-policies.md)** · **[Managed robots.txt](docs/cloudflare-managed-robots-txt.md)**
- **[Manage AI crawlers](docs/cloudflare-manage-ai-crawlers.md)** · **[AI bots reference](docs/cloudflare-ai-bots-reference.md)** · **[Analyze AI traffic](docs/cloudflare-analyze-ai-traffic.md)**
- **[Astro sitemap](docs/astro-sitemap.md)** · **[llms.txt spec](docs/llms-txt-spec.md)**

## Common workflows

- **New site:** technical SEO and structured data go in with the starter; write copy with
  answer-first rules; set AI bot policies; run the audit before launch.
- **Existing site:** run the [audit](docs/audit.md), fix crawlability first, then structured data,
  then content.
- **"Why doesn't ChatGPT mention us?":** [AI crawlers](docs/ai-crawlers.md) → Verify, then
  `llms.txt`, `sameAs`, and the passage that should answer the question.

## Related skills

- `search-engines` — Search Console and Bing: submission, indexing, queries
- `cloudflare-domains` — redirects, Crawler Hints
- `site-design-options` — layout, voice and copy spec
- `web-perf` (cloudflare/skills) — deep performance work
- `umami` — AI referrer traffic, heatmaps on the pages being optimised

## Sync & Update

When user runs `sync`: run `.github/workflows/scripts/sync-skill.sh skills/seo-geo --force`.
When user runs `diff`: run the same script with `--dry-run`. Authored guides are not touched by sync.
