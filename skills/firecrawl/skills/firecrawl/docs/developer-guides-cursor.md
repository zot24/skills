> Source: https://docs.firecrawl.dev/quickstarts/cursor.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# MCP Web Search & Scrape in Cursor

> Add web scraping and search to Cursor in 2 minutes

Connect Firecrawl to Cursor through the hosted MCP server, then sign in with your Firecrawl account to give Cursor's AI agent Search, Scrape, Parse, Crawl, Map, Interact, Agent, and Monitor for clean context from the web.

![](https://docs.firecrawl.dev/images/agent-clients/cursor.svg)
Add to Cursor

## Quick setup

1. Click **Add to Cursor** above to open the install dialog in Cursor.
2. Confirm the Firecrawl MCP server installation.
3. Use the server's sign-in option in Cursor to connect your Firecrawl account and approve access.
4. Confirm that Firecrawl's tools are available in Cursor.

> [accordion] Prefer to add the configuration manually?
>
> Add this to `~/.cursor/mcp.json`, or to `.cursor/mcp.json` in your project:
>
> ```json
> {
>   "mcpServers": {
>     "firecrawl": {
>       "url": "https://mcp.firecrawl.dev/v2/mcp-oauth"
>     }
>   }
> }
> ```
>
> Save the file, then complete the browser sign-in from Cursor.

The Cursor CLI reads the same `mcp.json`. Run `agent mcp login firecrawl` to sign in from the terminal.

See the [OAuth connection guide](https://docs.firecrawl.dev/mcp-server/oauth.md) for more details. For unattended use, [configure an API key](https://docs.firecrawl.dev/mcp-server/keyless.md#add-an-api-key).

## Try it

```text theme={null}
Search for the latest TypeScript release notes and summarize the sources.
```

```text theme={null}
Scrape https://firecrawl.dev and explain what it does.
```

## What you can do

> [card] [Search](https://docs.firecrawl.dev/features/search.md)
>
> Find current information and read the content of relevant results.

> [card] [Scrape](https://docs.firecrawl.dev/features/scrape.md)
>
> Turn URLs into clean markdown or structured data.

> [card] [Interact](https://docs.firecrawl.dev/features/interact.md)
>
> Navigate, click, and fill forms to reach the data you need.

> [card] [Alexandria](https://docs.firecrawl.dev/features/alexandria.md)
>
> Discover structured data tools, inspect inputs and pricing, then run them through Firecrawl.

## Troubleshooting

* **Server does not connect:** confirm the URL is exactly `https://mcp.firecrawl.dev/v2/mcp-oauth` and check the server's status under **Customize** or in the **MCP Logs** output.
* **Sign-in is required or expires:** start authentication again from Cursor's MCP server list under **Customize**.
* **Another Firecrawl connection already exists:** update the existing server to the OAuth URL and sign in so only one Firecrawl server is active.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
