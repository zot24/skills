> Source: https://docs.firecrawl.dev/quickstarts/cursor.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# MCP Web Search & Scrape in Cursor

> Add web scraping and search to Cursor in 2 minutes


Connect Firecrawl to Cursor through the hosted MCP server, then sign in with your Firecrawl account.

<CursorInstallButton />

## Quick setup

1. Click **Add to Cursor** above to open the install dialog in Cursor.
2. Confirm the Firecrawl MCP server installation.
3. Use the server's sign-in option in Cursor to connect your Firecrawl account and approve access.
4. Confirm that Firecrawl's tools are available in Cursor.


  Open Cursor Settings, select **MCP**, and add:

  ```json
  {
    "mcpServers": {
      "firecrawl": {
        "url": "https://mcp.firecrawl.dev/v2/mcp-oauth"
      }
    }
  }
  ```

  Save the configuration, then complete the browser sign-in from Cursor.


See the [OAuth connection guide](/mcp-server/oauth) for more details. For unattended use, [configure an API key](/mcp-server/keyless#add-an-api-key).

## Try it

```text theme={null}
Search for the latest TypeScript release notes and summarize the sources.
```

```text theme={null}
Scrape https://firecrawl.dev and explain what it does.
```

## What you can do


    Find current information and read the content of relevant results.


    Turn URLs into clean markdown or structured data.


    Navigate, click, and fill forms to reach the data you need.


    Discover structured data tools, inspect inputs and pricing, then run them through Firecrawl.


## Troubleshooting

* **Server does not connect:** confirm the URL is exactly `https://mcp.firecrawl.dev/v2/mcp-oauth` and inspect Cursor's MCP status.
* **Sign-in is required or expires:** start authentication again from Cursor's MCP settings.
* **Another Firecrawl connection already exists:** update the existing server to the OAuth URL and sign in so only one Firecrawl server is active.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
