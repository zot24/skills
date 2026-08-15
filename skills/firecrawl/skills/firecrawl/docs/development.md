> Source: https://docs.firecrawl.dev/mcp-server/development.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Started

> Set up Firecrawl MCP with keyless access, account sign-in, or an API key.

Choose how the connection will authenticate. Signing in and adding an API key are two paths to the same access: both reach the full tool surface on your team's plan.


    No account or key. Search, Scrape, and Parse within daily limits.


    Browser sign-in from Codex, Claude Code, or your favorite harness.


    Configure an API key in your client, no browser needed.


## Add an API key

[Create a Firecrawl API key](https://www.firecrawl.dev/app/api-keys), then send it as a bearer token:

```text theme={null}
URL: https://mcp.firecrawl.dev/v2/mcp
Authorization: Bearer <FIRECRAWL_API_KEY>
```

Configure the key through an environment variable or your client's secret storage, never in the MCP URL.


  This is a server URL for your MCP client, not a page to open directly in a browser. Sign-in connections use `https://mcp.firecrawl.dev/v2/mcp-oauth` instead, and your client starts the browser flow.


## Client setup


    Start keyless or use an API key.


    Sign in via browser.


Next: [choose a tool](/mcp-server/tools) or [run the server locally](/mcp-server/local).
