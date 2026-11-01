> Source: https://docs.firecrawl.dev/mcp-server/development.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Started

> Set up Firecrawl MCP with keyless access, account sign-in, or an API key.

Choose how the connection will authenticate. Signing in and adding an API key are two paths to the same access: both reach the full tool surface on your team's plan.

> [card] [Try Instantly](https://docs.firecrawl.dev/mcp-server/keyless.md#try-keyless)
>
> No account or key. Search, Scrape, and Parse within daily limits.

> [card] [Sign in](https://docs.firecrawl.dev/mcp-server/oauth.md)
>
> Browser sign-in from Codex, Claude Code, or your favorite harness.

> [card] [Use an API key](https://docs.firecrawl.dev/mcp-server/keyless.md#add-an-api-key)
>
> Configure an API key in your client, no browser needed.

Use ChatGPT, Codex or Claude? Install the native Firecrawl connector in one click:

> [card] [Add to ChatGPT & Codex](https://chatgpt.com/plugins/plugin_asdk_app_6a314a73f8ac819195b0d55e36b9c609?q=firecrawl)
>
> Install the native Firecrawl connector in ChatGPT and Codex.

> [card] [Add to Claude](https://claude.ai/directory/connectors/firecrawl)
>
> Install the native Firecrawl connector in Claude.

Using Claude Desktop, Cowork, or the Code tab? Follow the [Claude Desktop guide](https://docs.firecrawl.dev/quickstarts/claude-desktop.md) to connect once under the server name `firecrawl`.

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

> [!NOTE]
>
> This is a server URL for your MCP client, not a page to open directly in a browser. API-key connections use `https://mcp.firecrawl.dev/v2/mcp` with a bearer token instead; see [Add an API key](https://docs.firecrawl.dev/mcp-server/keyless.md#add-an-api-key).

## Client setup

> [card] [For Agents](https://docs.firecrawl.dev/mcp-server/keyless.md)
>
> Start keyless or use an API key.

> [card] [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md)
>
> Sign in via browser.

Using GitHub Copilot? Follow the [Copilot CLI and VS Code guide](https://docs.firecrawl.dev/quickstarts/github-copilot.md).

Next: [choose a tool](https://docs.firecrawl.dev/mcp-server/tools) or [run the server locally](https://docs.firecrawl.dev/mcp-server/local).


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
