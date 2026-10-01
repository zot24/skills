> Source: https://docs.firecrawl.dev/mcp-server/clients.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Started

> Set up Firecrawl MCP with keyless access, account sign-in, or an API key.

Choose how the connection will authenticate. Signing in and adding an API key are two paths to the same access: both reach the full tool surface on your team's plan.


    No account or key. Search, Scrape, and Parse within daily limits.


    Browser sign-in from Codex, Claude Code, or your favorite harness.


    Configure an API key in your client, no browser needed.


## Sign in

Point your client at the OAuth server URL. Your client opens a browser window where you sign in to Firecrawl and approve a team:

```json theme={null}
{
  "mcpServers": {
    "firecrawl": {
      "type": "http",
      "url": "https://mcp.firecrawl.dev/v2/mcp-oauth"
    }
  }
}
```

No API key or headers are needed. Review and revoke connections from [MCP settings](https://www.firecrawl.dev/app/settings?tab=mcp).


  This is a server URL for your MCP client, not a page to open directly in a browser. API-key connections use `https://mcp.firecrawl.dev/v2/mcp` with a bearer token instead; see [Add an API key](/mcp-server/keyless#add-an-api-key).


## Client setup


    Start keyless or use an API key.


    Sign in via browser.


Next: [choose a tool](/mcp-server/tools) or [run the server locally](/mcp-server/local).
