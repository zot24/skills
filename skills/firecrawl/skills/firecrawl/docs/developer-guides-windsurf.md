> Source: https://docs.firecrawl.dev/quickstarts/windsurf.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# MCP Web Search & Scrape in Windsurf (Devin Desktop)

> Add web scraping and search to Windsurf, now Devin Desktop, in 2 minutes

Add Firecrawl's keyless Search, Scrape, and Parse tools to Windsurf through the hosted MCP server.

Windsurf is now [Devin Desktop](https://devin.ai/desktop). Both its Devin Local agent and the legacy Cascade agent read MCP servers from the same config file.

## Quick setup

Edit `~/.config/devin/mcp_config.json` (`%APPDATA%\devin\mcp_config.json` on Windows):

```json theme={null}
{
  "mcpServers": {
    "firecrawl": {
      "url": "https://mcp.firecrawl.dev/v2/mcp"
    }
  }
}
```

Or add it with the Devin CLI:

```bash theme={null}
devin mcp add -s user firecrawl https://mcp.firecrawl.dev/v2/mcp
```

Restart Devin Desktop and confirm that `firecrawl_search`, `firecrawl_scrape`, and `firecrawl_parse` are available.

Keyless access has limits shared by users on the same public IP. Sign in from an interactive client with [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md), or [add an API key](https://docs.firecrawl.dev/mcp-server/keyless.md#add-an-api-key) for unattended use.

## Try it

```text theme={null}
Search for the latest Tailwind CSS release notes and summarize the sources.
```

```text theme={null}
Scrape https://firecrawl.dev and explain what it does.
```

## Troubleshooting

* **Server does not connect:** confirm the hosted URL, then check the server in the agent's MCP list or run `devin mcp list`.
* **Crawl or another tool is missing:** keyless exposes exactly Search, Scrape, and Parse. Connect with OAuth or an API key for the broader tool surface.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
