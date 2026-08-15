> Source: https://docs.firecrawl.dev/quickstarts/gemini-cli.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# MCP Web Search & Scrape in Gemini CLI

> Add Firecrawl web scraping and search to Google Gemini CLI

Add Firecrawl's keyless Search, Scrape, and Parse tools to [Google Gemini CLI](https://github.com/google-gemini/gemini-cli) through the hosted MCP server.

## Quick setup

Add this to `~/.gemini/settings.json` or your project's `.gemini/settings.json`:

```json theme={null}
{
  "mcpServers": {
    "firecrawl": {
      "httpUrl": "https://mcp.firecrawl.dev/v2/mcp"
    }
  }
}
```

Restart Gemini CLI, run `/mcp list`, and confirm that `firecrawl_search`, `firecrawl_scrape`, and `firecrawl_parse` are available.

Keyless access has limits shared by users on the same public IP. Sign in from an interactive client with [For Humans](/mcp-server/oauth), or [add an API key](/mcp-server/keyless#add-an-api-key) for unattended use.

## Try it

```text theme={null}
Use Firecrawl to search the web for "Gemini context window" and summarize the sources.
```

```text theme={null}
Scrape https://ai.google.dev/gemini-api/docs and outline the sections.
```

## Troubleshooting

* **Tools do not appear:** restart Gemini CLI after editing `settings.json`; MCP servers load at startup.
* **Crawl or another tool is missing:** keyless exposes exactly Search, Scrape, and Parse. Connect with OAuth or an API key for the broader tool surface.
