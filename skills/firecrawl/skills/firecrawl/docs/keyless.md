> Source: https://docs.firecrawl.dev/mcp-server/keyless.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# For Agents

> Agents can start instantly, no API key required. Add an API key to unlock more usage.

## Try keyless

<div id="try-instantly" />

Keyless server URL (Streamable HTTP, no credential): `https://mcp.firecrawl.dev/v2/mcp`

* Codex: `codex mcp add firecrawl --url https://mcp.firecrawl.dev/v2/mcp`
* Claude Code: `claude mcp add --transport http firecrawl https://mcp.firecrawl.dev/v2/mcp`
* Cursor or any JSON-config client: `{"mcpServers": {"firecrawl": {"url": "https://mcp.firecrawl.dev/v2/mcp"}}}`
* OpenCode (`opencode.json`): `{"mcp": {"firecrawl": {"type": "remote", "url": "https://mcp.firecrawl.dev/v2/mcp", "enabled": true}}}`

ChatGPT and Claude use the native Firecrawl connector instead: see [For Humans](/mcp-server/oauth.md#chatgpt-and-claude).

Keyless MCP is rate limited and exposes Search, Scrape, and Parse. Add an API key to unlock the full tool surface or higher limits.

## Add an API key

[Create a Firecrawl API key](https://www.firecrawl.dev/app/api-keys), then send it as a bearer token to the same endpoint:

```text theme={null}
URL: https://mcp.firecrawl.dev/v2/mcp
Authorization: Bearer <FIRECRAWL_API_KEY>
```

## Verify your connection

Open your client's MCP status or tool list and confirm that `firecrawl` is connected. A keyless connection shows `firecrawl_search`, `firecrawl_scrape`, and `firecrawl_parse`; an API-key connection can expose the [full tool surface](/mcp-server/tools), subject to plan, deployment, and team policy.

## Try

```text theme={null}
Search the web for the latest Firecrawl release notes and summarize the sources.
```

If no Firecrawl tools appear, restart or reload the client after saving its MCP configuration.

## More


    Find the right Firecrawl MCP tool and review connection-specific availability.


    Start the open-source server over stdio or Streamable HTTP.


For the current keyless allowance and plan limits, see [Rate limits](/rate-limits#keyless-no-api-key).
