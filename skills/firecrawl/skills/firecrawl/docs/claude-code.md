> Source: https://docs.firecrawl.dev/quickstarts/claude-code.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Firecrawl in Claude & Claude Code

> Search the web and read pages from Claude or your Claude Code session.

Choose the setup for the app you use. Both paths are optional; you only need to connect the one you want to use.

## Optional: Add to Claude

<div className="fc-agent-prompt fc-openai-install not-prose">
  <div className="fc-openai-install-actions">
    <a className="fc-agent-prompt-button" href="https://claude.ai/directory/connectors/firecrawl" target="_blank" rel="noopener noreferrer">
      <img src="https://mintcdn.com/firecrawl/CCJGFNIrBeZmk4E5/images/agent-clients/claude-ai.svg?fit=max&auto=format&n=CCJGFNIrBeZmk4E5&q=85&s=01e23ce8cedaa21257700fb093ed3735" width="20" height="20" alt="" data-path="images/agent-clients/claude-ai.svg" />

      Add to Claude
      <span aria-hidden="true">↗</span>
    </a>
  </div>
</div>

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


    Find current information and read the content of relevant results.


    Turn URLs into clean markdown or structured data.


    Navigate, click, and fill forms to reach the data you need.


    Discover structured data tools, inspect inputs and pricing, then run them through Firecrawl.


## Other connection modes

* [Try keyless MCP](/mcp-server/keyless#try-keyless) for Search, Scrape, and Parse without an account or key.
* [Configure an API key](/mcp-server/keyless#add-an-api-key) for unattended use. Keep the secret outside agent chat and use an environment-variable reference.
* [Run MCP locally](/mcp-server/local) only when you need a local process or a self-hosted Firecrawl API. The local package requires Node.js 22 or newer.

## Optional: literature research

For paper and literature work, the research-index skill routes those queries to the `firecrawl_research_*` tools and the [Research Index](/features/research) instead of general web search:

```bash theme={null}
npx skills add firecrawl/skills@firecrawl-research-index
```

## Troubleshooting

* **A Firecrawl server already exists:** run `claude mcp remove firecrawl`, add the intended connection once, then start a new session.
* **The browser does not open:** enter `/mcp`, select `firecrawl`, and start authentication from the client.
* **The server shows `401`:** sign in again through `/mcp`; do not paste an API key into the conversation or OAuth URL.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
