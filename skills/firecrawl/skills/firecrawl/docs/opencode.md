> Source: https://docs.firecrawl.dev/quickstarts/opencode.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# MCP Web Search & Scrape in OpenCode

> Add Firecrawl web scraping and search to OpenCode

Add Firecrawl's keyless Search, Scrape, and Parse tools to [OpenCode](https://opencode.ai) through the hosted MCP server.

## Quick setup

Add this to `~/.config/opencode/opencode.json` or your project's `opencode.json`:

```json theme={null}
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "firecrawl": {
      "type": "remote",
      "url": "https://mcp.firecrawl.dev/v2/mcp",
      "enabled": true
    }
  }
}
```

Restart OpenCode, then run `opencode mcp list` and confirm that `firecrawl` shows as connected. Its tools are `firecrawl_search`, `firecrawl_scrape`, and `firecrawl_parse`.

Keyless access has limits shared by users on the same public IP. Sign in from an interactive client with [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md), or [add an API key](https://docs.firecrawl.dev/mcp-server/keyless.md#add-an-api-key) for unattended use.

## Try it

```text theme={null}
Search the web for the latest Bun release notes and summarize the sources.
```

```text theme={null}
Scrape https://docs.firecrawl.dev/introduction and list the code examples.
```

## Troubleshooting

* **Server does not attach:** run `opencode mcp list` and confirm the remote URL and status.
* **Crawl or another tool is missing:** keyless exposes exactly Search, Scrape, and Parse. Connect with OAuth or an API key for the broader tool surface.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
