> Source: https://docs.firecrawl.dev/quickstarts/amp.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# MCP Web Search & Scrape in Amp

> Add Firecrawl web scraping and search to Sourcegraph Amp

Add Firecrawl's search, scrape, crawl, and browser tools to [Sourcegraph Amp](https://ampcode.com) via MCP.

## Quick Setup

### 1. Get Your API Key

Sign up at [firecrawl.dev/app](https://www.firecrawl.dev/app) and copy your API key.

### 2. Add Firecrawl to Amp

Open Amp settings and add an MCP server. Amp accepts standard MCP config:

```json theme={null}
{
  "amp.mcpServers": {
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "firecrawl-mcp"],
      "env": {
        "FIRECRAWL_API_KEY": "fc-YOUR-API-KEY"
      }
    }
  }
}
```

Replace `fc-YOUR-API-KEY` with your Firecrawl API key.

### 3. Reload Amp

Reload the Amp window. Firecrawl tools are now available to the agent.

## Quick Demo

```
Search the web for "Sourcegraph Cody vs Amp" and summarize the differences.
```

```
Scrape https://docs.firecrawl.dev and list the core endpoints.
```

```
Crawl https://example.com and output a site map as JSON.
```

## Remote Hosted URL (no Node.js required)

```json theme={null}
{
  "amp.mcpServers": {
    "firecrawl": {
      "url": "https://mcp.firecrawl.dev/v2/mcp"
    }
  }
}
```

This configuration uses the keyless Firecrawl toolset. For an account-connected or unattended setup, follow the [hosted MCP connection modes](/developer-guides/mcp-setup-guides/oauth); keep API keys in an Authorization header or secure-secret store, never in a URL.

## Troubleshooting

* **Server fails to start** — check Amp's MCP log view for stderr output.
* **Missing `npx`** — install Node.js 18+ or use the remote hosted URL above.
