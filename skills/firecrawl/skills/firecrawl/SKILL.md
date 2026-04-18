---
name: firecrawl
description: Expert on Firecrawl — web scraping, crawling, search, and browser automation API for AI agents. Use when the user wants to scrape websites, crawl pages, search the web, extract structured data, or convert URLs to LLM-ready content. Triggers on mentions of firecrawl, web scraping, crawling, site mapping, /scrape, /search, /crawl, /map, /interact.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Firecrawl

Firecrawl turns any website into clean, LLM-ready markdown, structured data, or screenshots.

## Overview

- **`/scrape`** — Extract markdown/HTML/JSON from a single URL
- **`/search`** — Query-based web discovery with optional content extraction
- **`/crawl`** — Recursively gather content from entire sites
- **`/map`** — Discover all URLs on a website
- **`/interact`** — Browser automation (clicks, forms, navigation)
- **`/extract`** — LLM-powered structured data extraction with schemas

## Install

```bash
npx -y firecrawl-cli@latest init --all --browser
```

This installs CLI tools, build skills, and opens browser auth for API key setup.

## Quick Start

```python
from firecrawl import FirecrawlApp
app = FirecrawlApp(api_key="fc-...")
result = app.scrape_url("https://example.com", params={"formats": ["markdown"]})
print(result["markdown"])
```

```typescript
import FirecrawlApp from '@mendable/firecrawl-js';
const app = new FirecrawlApp({ apiKey: 'fc-...' });
const result = await app.scrapeUrl('https://example.com', { formats: ['markdown'] });
```

## Choose Your Path

- **Live web data now** — Use CLI: `firecrawl search`, `firecrawl scrape`
- **App integration** — SDK + `FIRECRAWL_API_KEY` in `.env`
- **Need API key** — Run install with `--browser` or visit firecrawl.dev/app
- **REST API directly** — `POST https://api.firecrawl.dev/v2/scrape` with Bearer token

## Core Concepts

**Scrape vs Crawl vs Map**: Scrape extracts one page. Crawl recursively follows links. Map discovers URLs without extracting content.

**Output Formats**: `markdown` (default), `html`, `rawHtml`, `screenshot`, `links`, `extract` (structured JSON via LLM).

**LLM Extraction**: Pass a JSON schema to `/scrape` or `/extract` to get structured data back.

## Documentation

- **[Quickstart](docs/quickstart.md)** — Installation and first API call
- **[Scrape](docs/scrape.md)** — Single-page extraction
- **[Search](docs/search.md)** — Web search with content hydration
- **[Crawl](docs/crawl.md)** — Recursive site crawling
- **[Map](docs/map.md)** — URL discovery
- **[Interact](docs/interact.md)** — Browser actions on live pages
- **[Batch Scrape](docs/batch-scrape.md)** — Batch operations
- **[Agent](docs/agent.md)** — Autonomous web data gathering
- **[Extract](docs/extract.md)** — LLM structured extraction
- **[SDKs](docs/sdks.md)** — Node, Python, Go, Rust, Java, Elixir
- **[MCP Server](docs/mcp-server.md)** — MCP integration for Claude/Cursor
- **[Self-Hosting](docs/self-hosting.md)** — Deploy your own Firecrawl
- **[Webhooks](docs/webhooks.md)** — Event notifications
- **[API Reference](docs/api-reference.md)** — Auth, rate limits, errors
- **[Upstream README](docs/readme-upstream.md)** — Full project documentation

## Common Workflows

### Scrape a page to markdown
```bash
curl -X POST https://api.firecrawl.dev/v2/scrape \
  -H "Authorization: Bearer fc-..." \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com", "formats": ["markdown"]}'
```

### Search and extract
```python
results = app.search("latest AI news", params={"limit": 5})
for r in results["data"]:
    print(r["url"], r["markdown"][:200])
```

## Upstream Sources

- **Repository**: https://github.com/mendableai/firecrawl
- **Documentation**: https://docs.firecrawl.dev
- **Docs Index**: https://docs.firecrawl.dev/llms.txt
- **Skills Repo**: https://github.com/firecrawl/skills

## Sync & Update

When user runs `sync`: fetch latest from upstream sources, update docs/ files.
When user runs `diff`: compare current vs upstream, report changes.
