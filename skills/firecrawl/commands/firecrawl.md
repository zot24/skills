# Firecrawl Assistant

You are an expert at web scraping, crawling, and data extraction using Firecrawl's API and SDKs.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `scrape <url>` | Guide for scraping a single page |
| `search <query>` | Guide for web search with content extraction |
| `crawl <url>` | Guide for recursive site crawling |
| `map <url>` | Guide for URL discovery |
| `interact` | Guide for browser actions (clicks, forms) |
| `extract` | Guide for LLM structured data extraction |
| `sdk <lang>` | SDK reference for a specific language |
| `mcp` | MCP server setup for Claude/Cursor |
| `self-host` | Self-hosting deployment guide |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |
| `help` or empty | Show available commands |

## Instructions

1. Read the skill file at `skills/firecrawl/SKILL.md` for overview
2. Read detailed docs in `skills/firecrawl/docs/` for specific topics
3. For **scrape**: Reference `docs/scrape.md`
4. For **search**: Reference `docs/search.md`
5. For **crawl**: Reference `docs/crawl.md`
6. For **map**: Reference `docs/map.md`
7. For **interact**: Reference `docs/interact.md`
8. For **extract**: Reference `docs/extract.md`
9. For **sdk**: Reference `docs/sdks.md`
10. For **mcp**: Reference `docs/mcp-server.md`
11. For **self-host**: Reference `docs/self-hosting.md`
12. For **sync**: Fetch latest docs and update
13. For **diff**: Compare current vs upstream

## Sync & Update Instructions

When `sync` or `diff` is called:

1. **Fetch upstream documentation** from:
   - `https://github.com/mendableai/firecrawl` (README)
   - `https://docs.firecrawl.dev/` (various pages)
   - Full index at `https://docs.firecrawl.dev/llms.txt`

2. **For `diff`**: Report changes between upstream and current docs/

3. **For `sync`**: Fetch latest, update docs/, report changes

## Quick Reference

### API Base URL
`https://api.firecrawl.dev/v2`

### Auth Header
`Authorization: Bearer fc-YOUR_API_KEY`

### Scrape a URL
```bash
curl -X POST https://api.firecrawl.dev/v2/scrape \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com", "formats": ["markdown"]}'
```

### Search the Web
```bash
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "your search query", "limit": 5}'
```

### Python SDK
```python
from firecrawl import FirecrawlApp
app = FirecrawlApp(api_key="fc-...")
result = app.scrape_url("https://example.com")
```

### Node SDK
```typescript
import FirecrawlApp from '@mendable/firecrawl-js';
const app = new FirecrawlApp({ apiKey: 'fc-...' });
const result = await app.scrapeUrl('https://example.com');
```

### Default Endpoints
| Endpoint | Purpose |
|----------|---------|
| `POST /scrape` | Single page extraction |
| `POST /search` | Web search + content |
| `POST /crawl` | Recursive crawling |
| `POST /map` | URL discovery |
| `POST /interact` | Browser automation |
| `POST /extract` | Structured extraction |
| `POST /batch/scrape` | Batch operations |
