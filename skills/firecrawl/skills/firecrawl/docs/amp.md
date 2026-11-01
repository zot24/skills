> Source: https://docs.firecrawl.dev/quickstarts/amp.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# MCP Web Search & Scrape in Amp

> Add Firecrawl web scraping and search to Amp

Add Firecrawl's keyless Search, Scrape, and Parse tools to [Amp](https://ampcode.com) through the hosted MCP server.

## Quick setup

Add this to your Amp settings file (`~/.config/amp/settings.json`; `amp config edit` opens it):

```json theme={null}
{
  "amp.mcpServers": {
    "firecrawl": {
      "url": "https://mcp.firecrawl.dev/v2/mcp"
    }
  }
}
```

Or let the CLI write it for you:

```bash theme={null}
amp mcp add firecrawl https://mcp.firecrawl.dev/v2/mcp
```

Restart Amp and confirm that `firecrawl_search`, `firecrawl_scrape`, and `firecrawl_parse` are available.

Keyless access has limits shared by users on the same public IP. Sign in from an interactive client with [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md), or [add an API key](https://docs.firecrawl.dev/mcp-server/keyless.md#add-an-api-key) for unattended use.

## Try it

```text theme={null}
Search the web for the latest Amp release notes and summarize the sources.
```

```text theme={null}
Scrape https://docs.firecrawl.dev and list the core endpoints.
```

## Troubleshooting

* **Server does not connect:** confirm the URL is exactly `https://mcp.firecrawl.dev/v2/mcp` and run `amp mcp doctor` to check the server's status.
* **Crawl or another tool is missing:** keyless exposes exactly Search, Scrape, and Parse. Connect with OAuth or an API key for the broader tool surface.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
