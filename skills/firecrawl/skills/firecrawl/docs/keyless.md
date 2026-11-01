> Source: https://docs.firecrawl.dev/mcp-server/keyless.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# For Agents

> Agents can start instantly, no API key required. Add an API key to unlock more usage.

## Try keyless

Keyless server URL (Streamable HTTP, no credential): `https://mcp.firecrawl.dev/v2/mcp`

* Codex: `codex mcp add firecrawl --url https://mcp.firecrawl.dev/v2/mcp`
* Claude Code: `claude mcp add --transport http firecrawl https://mcp.firecrawl.dev/v2/mcp`
* Cursor or any JSON-config client: `{"mcpServers": {"firecrawl": {"url": "https://mcp.firecrawl.dev/v2/mcp"}}}`
* OpenCode (`opencode.json`): `{"mcp": {"firecrawl": {"type": "remote", "url": "https://mcp.firecrawl.dev/v2/mcp", "enabled": true}}}`
* Droid: `droid mcp add firecrawl https://mcp.firecrawl.dev/v2/mcp --type http`

ChatGPT and Claude use the native Firecrawl connector instead: see [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md#chatgpt-and-claude).

Keyless MCP is rate limited and exposes Search, Scrape, and Parse. Add an API key to unlock the full tool surface or higher limits.

## Add an API key

[Create a Firecrawl API key](https://www.firecrawl.dev/app/api-keys), then add it as a bearer token on the same endpoint in your client config:

```json theme={null}
{
  "mcpServers": {
    "firecrawl": {
      "type": "http",
      "url": "https://mcp.firecrawl.dev/v2/mcp",
      "headers": {
        "Authorization": "Bearer <FIRECRAWL_API_KEY>"
      }
    }
  }
}
```

In Droid, pass the key as a header and turn off OAuth:

```bash theme={null}
droid mcp add firecrawl https://mcp.firecrawl.dev/v2/mcp --type http \
  --header "Authorization: Bearer <FIRECRAWL_API_KEY>" --no-oauth
```

To sign in through the browser instead of pasting a key, see [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md). [Authentication](https://docs.firecrawl.dev/authentication.md) compares API keys, MCP sign-in and OAuth for your own app.

## Verify your connection

Open your client's MCP status or tool list and confirm that `firecrawl` is connected. A keyless connection shows `firecrawl_search`, `firecrawl_scrape`, and `firecrawl_parse`; an API-key connection can expose the [full tool surface](https://docs.firecrawl.dev/mcp-server/tools), subject to plan, deployment, and team policy.

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

For the current keyless allowance and plan limits, see [Rate limits](https://docs.firecrawl.dev/rate-limits.md#keyless-no-api-key).


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
