> Source: https://docs.firecrawl.dev/developer-guides/mcp-setup-guides/oauth.md

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
* Droid: `droid mcp add firecrawl https://mcp.firecrawl.dev/v2/mcp-oauth --type http` then complete sign-in via `/mcp`
* ChatGPT or Claude.ai: use the native Firecrawl connector — [ChatGPT](https://chatgpt.com/plugins?q=firecrawl) or [Claude](https://claude.ai/directory/connectors/firecrawl).

A human must complete the browser sign-in and approve a team. Do not open the server URL directly in a browser.

> [!NOTE]
>
> `https://mcp.firecrawl.dev/v2/mcp-oauth` is a server URL for your MCP client. It is not a page to open directly in a browser. Your client starts the browser sign-in flow.

Each connection gets its own key, which your client never sees. You can review and revoke connections under [Connected apps in Settings](https://www.firecrawl.dev/app/settings?tab=mcp). To compare MCP sign-in with API keys and OAuth for your own app, see [Authentication](https://docs.firecrawl.dev/authentication.md).

## ChatGPT and Claude

> [card] [Add to ChatGPT](https://chatgpt.com/plugins?q=firecrawl)
>
> Install the native Firecrawl connector in ChatGPT.

> [card] [Add to Claude](https://claude.ai/directory/connectors/firecrawl)
>
> Install the native Firecrawl connector in Claude.

For Claude Desktop, Cowork, and the Code tab, see the [Claude Desktop guide](https://docs.firecrawl.dev/quickstarts/claude-desktop.md).

## Add an API key

> [card] [Add an API key](https://docs.firecrawl.dev/mcp-server/keyless.md#add-an-api-key)
>
> Prefer a key in your client config instead of browser sign-in. Setup lives on For Agents.

## Try

```text theme={null}
Search the web for the latest Firecrawl release notes and summarize the sources.
```

If no Firecrawl tools appear, restart or reload the client after saving its MCP configuration.

## More

> [card] [Choose a tool](https://docs.firecrawl.dev/mcp-server/tools)
>
> Find the right Firecrawl MCP tool and review connection-specific availability.

> [card] [Run locally](https://docs.firecrawl.dev/mcp-server/local)
>
> Start the open-source server over stdio or Streamable HTTP.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
