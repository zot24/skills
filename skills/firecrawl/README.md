# Firecrawl Skill

Expert assistant for web scraping, crawling, search, and browser automation using [Firecrawl](https://firecrawl.dev).

## What This Skill Covers

- Scraping single pages to clean markdown, HTML, or structured JSON
- Web search with content extraction
- Recursive site crawling
- URL discovery and site mapping
- Browser automation (clicks, forms, navigation)
- LLM-powered structured data extraction
- SDK usage (Node, Python, Go, Rust, Java, Elixir)
- MCP server integration for Claude and Cursor
- Self-hosting Firecrawl

## Usage

### Slash Commands

```
/firecrawl scrape https://example.com    # Scrape a page
/firecrawl search "AI news"              # Web search
/firecrawl crawl https://docs.example.com # Crawl a site
/firecrawl map https://example.com       # Discover URLs
/firecrawl sdk python                    # Python SDK guide
/firecrawl mcp                           # MCP server setup
/firecrawl self-host                     # Self-hosting guide
/firecrawl sync                          # Update documentation
```

### Natural Language Triggers

The skill activates on mentions of: firecrawl, web scraping, crawling, site mapping, scrape URL, search web, extract data.

## Documentation Sources

All documentation is synced from [docs.firecrawl.dev](https://docs.firecrawl.dev).

Full page index available at `https://docs.firecrawl.dev/llms.txt`.

## Sync

```bash
# Discover new upstream pages
./skills/firecrawl/discover-pages.sh

# Auto-add new pages to sync.json
./skills/firecrawl/discover-pages.sh --auto-add

# Sync all documentation
.github/workflows/scripts/sync-skill.sh skills/firecrawl --force
```

## Skill Structure

```
skills/firecrawl/
├── .claude-plugin/plugin.json     # Plugin metadata
├── commands/firecrawl.md          # Slash command entry point
├── skills/firecrawl/
│   ├── SKILL.md                   # Overview + references (~100 lines)
│   └── docs/                      # Cached upstream documentation
├── discover-pages.sh              # Page discovery from llms.txt
├── sync.json                      # Sync configuration
└── README.md                      # This file
```
