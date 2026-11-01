> Source: https://docs.firecrawl.dev/quickstarts/claude-code.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Firecrawl in Claude & Claude Code

> Search the web and read pages from Claude or your Claude Code session.

Give Claude the context API for AI agents: search the web and read pages from Claude or Claude Code. Choose the setup for the app you use. Both paths are optional; connect only the one you want.

## Optional: Add to Claude

![](https://mintcdn.com/firecrawl/CCJGFNIrBeZmk4E5/images/agent-clients/claude-ai.svg?fit=max\&auto=format\&n=CCJGFNIrBeZmk4E5\&q=85\&s=01e23ce8cedaa21257700fb093ed3735)

Add to Claude


[Open](https://claude.ai/directory/connectors/firecrawl)

1. Open the Firecrawl connector using the button above.
2. Connect your Firecrawl account and approve access when prompted.
3. Start a new Claude conversation, enable Firecrawl, and ask it to search or read a page.

```text theme={null}
Use Firecrawl to search for the latest Next.js release notes and summarize the sources.
```

## Optional: Set up Claude Code

Connect Claude Code through the hosted MCP server. Run the command below, then sign in through your browser.

### 1. Add Firecrawl

Run:

```bash theme={null}
claude mcp add --transport http firecrawl https://mcp.firecrawl.dev/v2/mcp-oauth
```

`https://mcp.firecrawl.dev/v2/mcp-oauth` is a client configuration value, not a page to open directly in a browser.

### 2. Sign in and verify

Enter `/mcp` in Claude Code, choose `firecrawl`, and complete the browser sign-in. Start a new Claude Code session if you changed an existing Firecrawl connection.

Confirm that only one `firecrawl` server is active, then try:

```text theme={null}
Search for the latest Next.js release notes and summarize the sources.
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

## Other connection modes

* [Try keyless MCP](https://docs.firecrawl.dev/mcp-server/keyless.md#try-keyless) for Search, Scrape, and Parse without an account or key.
* [Configure an API key](https://docs.firecrawl.dev/mcp-server/keyless.md#add-an-api-key) for unattended use. Keep the secret outside agent chat and use an environment-variable reference.
* [Run MCP locally](https://docs.firecrawl.dev/mcp-server/local) only when you need a local process or a self-hosted Firecrawl API. The local package requires Node.js 22 or newer.

## Optional: literature research

For paper and literature work, the research-index skill routes those queries to the `firecrawl_research_*` tools and the [Research Index](https://docs.firecrawl.dev/features/research.md) instead of general web search:

```bash theme={null}
npx skills add firecrawl/skills@firecrawl-research-index
```

## Troubleshooting

* **A Firecrawl server already exists:** run `claude mcp remove firecrawl`, add the intended connection once, then start a new session.
* **The browser does not open:** enter `/mcp`, select `firecrawl`, and start authentication from the client.
* **The server shows `401`:** sign in again through `/mcp`; do not paste an API key into the conversation or OAuth URL.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
