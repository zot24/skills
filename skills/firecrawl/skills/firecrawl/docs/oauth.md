> Source: https://docs.firecrawl.dev/mcp-server/oauth.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# For Humans

> Sign in via your browser.

## Sign in

OAuth server URL (Streamable HTTP; the client starts browser sign-in): `https://mcp.firecrawl.dev/v2/mcp-oauth`

* Codex: `codex mcp add firecrawl --url https://mcp.firecrawl.dev/v2/mcp-oauth` then `codex mcp login firecrawl`
* Claude Code: `claude mcp add --transport http firecrawl https://mcp.firecrawl.dev/v2/mcp-oauth` then complete sign-in via `/mcp`
* Cursor or any JSON-config client: `{"mcpServers": {"firecrawl": {"url": "https://mcp.firecrawl.dev/v2/mcp-oauth"}}}`
* OpenCode (`opencode.json`): `{"mcp": {"firecrawl": {"type": "remote", "url": "https://mcp.firecrawl.dev/v2/mcp-oauth", "enabled": true}}}`
* ChatGPT or Claude.ai: use the native Firecrawl connector — [ChatGPT](https://chatgpt.com/plugins?q=firecrawl) or [Claude](https://claude.ai/directory/connectors/firecrawl).

A human must complete the browser sign-in and approve a team. Do not open the server URL directly in a browser.


  `https://mcp.firecrawl.dev/v2/mcp-oauth` is a server URL for your MCP client. It is not a page to open directly in a browser. Your client starts the browser sign-in flow.


You can review and revoke connections from [MCP settings](https://www.firecrawl.dev/app/settings?tab=mcp).

## ChatGPT and Claude


    Install the native Firecrawl connector in ChatGPT.


    Install the native Firecrawl connector in Claude.


## Add an API key


  Prefer a key in your client config instead of browser sign-in. Setup lives on For Agents.


## Try

```text theme={null}
Search the web for the latest Firecrawl release notes and summarize the sources.
```

If no Firecrawl tools appear, restart or reload the client after saving its MCP configuration.

## More


    Find the right Firecrawl MCP tool and review connection-specific availability.


    Start the open-source server over stdio or Streamable HTTP.


