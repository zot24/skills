> Source: https://docs.firecrawl.dev/use-cases/developers-mcp.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Developers & MCP

> Build powerful integrations with Model Context Protocol support

Give your AI coding assistant the ability to scrape, crawl, and search the web in real time. Firecrawl's MCP server connects to Claude Desktop, Cursor, and other Model Context Protocol clients so your assistant can pull live documentation, discover site structures, and extract structured data on demand.

## Start with a Template

> [card] [MCP Server Firecrawl](https://github.com/firecrawl/firecrawl-mcp-server)
>
> Official MCP server - Search, scrape, and interact with the web from Claude Desktop, Cursor, and other MCP clients

> [card] [Open Lovable](https://github.com/firecrawl/open-lovable)
>
> Build complete applications from any website instantly

> [!NOTE]
>
> **Get started with MCP in minutes.** Follow our [setup guide](https://github.com/firecrawl/firecrawl-mcp-server#installation) to integrate Firecrawl into Claude Desktop or Cursor.

## How It Works

Integrate Firecrawl directly into your AI coding workflow through Model Context Protocol. Once configured, your AI assistant gains access to a set of Firecrawl web tools it can call on your behalf:

| Tool | What it does |
| - | - |
| **Scrape** | Extract content or structured data from a single URL |
| **Batch Scrape** | Extract content from multiple known URLs in parallel |
| **Map** | Discover all indexed URLs on a website |
| **Crawl** | Walk a site section and extract content from every page |
| **Search** | Search the web and optionally extract content from results |

Your assistant picks the right tool automatically. Ask it to "read the Next.js docs" and it will scrape. Ask it to "find all blog posts on example.com" and it will map then batch scrape.

## Why Developers Choose Firecrawl MCP

### Build Smarter AI Assistants

Give your AI real-time access to documentation, APIs, and web resources. Reduce outdated information and hallucinations by providing your assistant with the latest data.

### Zero Infrastructure Required

No servers to manage, no crawlers to maintain. Just configure once and your AI assistant can access websites instantly through the Model Context Protocol.

## Customer Stories

> [card]
>
> **Botpress**
>
> Discover how Botpress uses Firecrawl to streamline knowledge base population and improve developer experience.
>
> [Open](https://www.firecrawl.dev/blog/how-botpress-enhances-knowledge-base-creation-with-firecrawl)

> [card]
>
> **Answer HQ**
>
> Learn how Answer HQ uses Firecrawl to help businesses import website data and build intelligent support assistants.
>
> [Open](https://www.firecrawl.dev/blog/how-answer-hq-powers-ai-customer-support-with-firecrawl)

## FAQs

> [accordion] Which AI assistants support MCP?
>
> Currently, Claude Desktop and Cursor have native MCP support. More AI assistants are adding support regularly. You can also use the MCP SDK to build custom integrations.

> [accordion] Can I use MCP in VS Code or other IDEs?
>
> Yes. VS Code supports MCP natively: run **MCP: Add Server** from the Command Palette, choose **HTTP**, and enter `https://mcp.firecrawl.dev/v2/mcp`. To add it by hand, put Firecrawl under `mcpServers` in `~/.copilot/mcp-config.json` for all your workspaces, or in `.mcp.json` at the workspace root to share it with your team:
>
> ```json
> {
>   "mcpServers": {
>     "firecrawl": {
>       "type": "http",
>       "url": "https://mcp.firecrawl.dev/v2/mcp"
>     }
>   }
> }
> ```
>
> VS Code's older `.vscode/mcp.json` (a top-level `servers` object) still works but is marked deprecated. For Cursor, Windsurf, and other clients, see [For Agents](https://docs.firecrawl.dev/mcp-server/keyless.md).

> [accordion] How do I cache frequently accessed docs?
>
> The MCP server automatically caches responses for 15 minutes. You can configure cache duration in your MCP server settings or implement custom caching logic.

> [accordion] Is there a rate limit for MCP requests?
>
> MCP requests use your standard Firecrawl API rate limits. We recommend batching related requests and using caching for frequently accessed documentation.

> [accordion] How do I set up MCP with my Firecrawl API key?
>
> Follow our [setup guide](https://github.com/firecrawl/firecrawl-mcp-server#installation) to configure MCP. You'll need to add your Firecrawl API key to your MCP configuration file. The process takes just a few minutes.

## Related Use Cases

* [AI Platforms](https://docs.firecrawl.dev/use-cases/ai-platforms.md) - Build AI-powered dev tools
* [Deep Research](https://docs.firecrawl.dev/use-cases/deep-research.md) - Complex technical research
* [Content Generation](https://docs.firecrawl.dev/use-cases/content-generation.md) - Generate documentation


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
