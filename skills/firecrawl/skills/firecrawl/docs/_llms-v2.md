> Source: https://docs.firecrawl.dev/_llms/en/v2.md

# Firecrawl Docs: English v2

## v2

- [English / v2 / Documentation (128 pages)](https://docs.firecrawl.dev/_llms/en/v2/documentation.md): Documentation for English / v2 / Documentation.

### SDKs

#### Overall

- [Overview](https://docs.firecrawl.dev/sdks/overview.md): Firecrawl SDKs are wrappers around the Firecrawl API to help you easily search, scrape, and interact with the web.

#### Official

- [Python](https://docs.firecrawl.dev/sdks/python.md): Firecrawl Python SDK is a wrapper around the Firecrawl API to help you easily turn websites into markdown.
- [Node](https://docs.firecrawl.dev/sdks/node.md): Scrape, crawl, and extract structured data from websites using the Firecrawl Node SDK.
- [Go](https://docs.firecrawl.dev/sdks/go.md): Firecrawl Go SDK is a wrapper around the Firecrawl API to help you easily turn websites into markdown.
- [Java](https://docs.firecrawl.dev/sdks/java.md): Firecrawl Java SDK is a wrapper around the Firecrawl API to help you easily turn websites into markdown.
- [Ruby](https://docs.firecrawl.dev/sdks/ruby.md): Firecrawl Ruby SDK is a wrapper around the Firecrawl API to help you easily turn websites into markdown.
- [Rust](https://docs.firecrawl.dev/sdks/rust.md): Firecrawl Rust SDK is a wrapper around the Firecrawl API to help you easily turn websites into markdown.
- [.NET](https://docs.firecrawl.dev/sdks/dotnet.md): Firecrawl .NET SDK is a wrapper around the Firecrawl API to help you easily turn websites into markdown.
- [PHP](https://docs.firecrawl.dev/sdks/php.md): Firecrawl PHP SDK is a wrapper around the Firecrawl API to help you easily turn websites into markdown.
- [Elixir](https://docs.firecrawl.dev/sdks/elixir.md): Firecrawl Elixir SDK is an auto-generated client for the Firecrawl API v2, built with Req and NimbleOptions.
- [CLI](https://docs.firecrawl.dev/sdks/cli.md): Firecrawl skills are an easy way for AI agents such as Codex, Claude Code, Cursor, and OpenCode to use Firecrawl through the CLI.

### API Reference

#### Using the API

- [Introduction](https://docs.firecrawl.dev/api-reference/v2-introduction.md): Firecrawl API Reference (v2)
- [Errors](https://docs.firecrawl.dev/api-reference/errors.md): Every API error code, what causes it, how to remedy it, and whether to retry.

#### Search Endpoints

- [Search](https://docs.firecrawl.dev/api-reference/endpoint/search.md)
- [Search Feedback](https://docs.firecrawl.dev/api-reference/endpoint/search-feedback.md): Submit quality feedback for a search job and help improve Firecrawl search results.

#### Scrape Endpoints

- [Scrape](https://docs.firecrawl.dev/api-reference/endpoint/scrape.md)
- [Batch Scrape](https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape.md)
- [Get Batch Scrape Status](https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape-get.md)
- [Cancel Batch Scrape](https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape-delete.md)
- [Get Batch Scrape Errors](https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape-get-errors.md)

#### Interact / Browser Sandbox Endpoints

- [Create Interact Session](https://docs.firecrawl.dev/api-reference/endpoint/browser-create.md): Start a standalone Interact browser session you drive with code (no prior scrape required).
- [Execute Code in a Session](https://docs.firecrawl.dev/api-reference/endpoint/browser-execute.md): Run Playwright or agent-browser code in a standalone Interact session.
- [List Interact Sessions](https://docs.firecrawl.dev/api-reference/endpoint/browser-list.md): Retrieve your standalone Interact sessions, optionally filtered by status.
- [Delete Interact Session](https://docs.firecrawl.dev/api-reference/endpoint/browser-delete.md): Destroy a standalone Interact session and release its resources.
- [Interact with a Scraped Page](https://docs.firecrawl.dev/api-reference/endpoint/scrape-execute.md): Execute code or an AI prompt in the browser session bound to a scrape job.
- [Stop Interacting](https://docs.firecrawl.dev/api-reference/endpoint/scrape-browser-delete.md): Stop the interactive browser session associated with a scrape job.

#### Research Index Endpoints

- [Search Papers](https://docs.firecrawl.dev/api-reference/endpoint/research-search-papers.md)
- [Inspect or Read Paper](https://docs.firecrawl.dev/api-reference/endpoint/research-paper.md)
- [Find Related Papers](https://docs.firecrawl.dev/api-reference/endpoint/research-related-papers.md)

#### Developer Index Endpoints

- [Search the Developer Index](https://docs.firecrawl.dev/api-reference/endpoint/developer-search.md)

#### Map Endpoints

- [Map](https://docs.firecrawl.dev/api-reference/endpoint/map.md)

#### Parse Endpoints

- [Parse](https://docs.firecrawl.dev/api-reference/endpoint/parse.md)

#### Crawl Endpoints

- [Crawl](https://docs.firecrawl.dev/api-reference/endpoint/crawl-post.md)
- [Get Crawl Status](https://docs.firecrawl.dev/api-reference/endpoint/crawl-get.md)
- [Crawl Params Preview](https://docs.firecrawl.dev/api-reference/endpoint/crawl-params-preview.md)
- [Cancel Crawl](https://docs.firecrawl.dev/api-reference/endpoint/crawl-delete.md)
- [Get Crawl Errors](https://docs.firecrawl.dev/api-reference/endpoint/crawl-get-errors.md)
- [Get Active Crawls](https://docs.firecrawl.dev/api-reference/endpoint/crawl-active.md)

#### Monitor Endpoints

- [Create Monitor](https://docs.firecrawl.dev/api-reference/endpoint/monitor-create.md)
- [List Monitors](https://docs.firecrawl.dev/api-reference/endpoint/monitor-list.md)
- [Get Monitor](https://docs.firecrawl.dev/api-reference/endpoint/monitor-get.md)
- [Update Monitor](https://docs.firecrawl.dev/api-reference/endpoint/monitor-update.md)
- [Delete Monitor](https://docs.firecrawl.dev/api-reference/endpoint/monitor-delete.md)
- [Run Monitor](https://docs.firecrawl.dev/api-reference/endpoint/monitor-run.md)
- [List Monitor Checks](https://docs.firecrawl.dev/api-reference/endpoint/monitor-checks-list.md)
- [Get Monitor Check](https://docs.firecrawl.dev/api-reference/endpoint/monitor-check-get.md)

#### Feedback Endpoints

- [Endpoint Feedback](https://docs.firecrawl.dev/api-reference/endpoint/feedback.md): Submit feedback for a completed v2 endpoint job.

#### Agentic Debugging Endpoints

- [Ask](https://docs.firecrawl.dev/api-reference/endpoint/ask.md): Diagnose Firecrawl job, account, and API usage issues with an AI support agent.
- [Docs Search](https://docs.firecrawl.dev/api-reference/endpoint/docs-search.md): Answer Firecrawl documentation questions using the public docs corpus.

#### Account Endpoints

- [Activity](https://docs.firecrawl.dev/api-reference/endpoint/activity.md): Lists your team's recent API activity from the last 24 hours. Returns metadata about each job including the job ID, which can be used with the corresponding GET endpoint (e.g. GET /crawl/{id}) to retrieve full results. Supports cursor-based pagination and filtering by endpoint.
- [Credit Usage](https://docs.firecrawl.dev/api-reference/endpoint/credit-usage.md)
- [Historical Credit Usage](https://docs.firecrawl.dev/api-reference/endpoint/credit-usage-historical.md)
- [Queue Status](https://docs.firecrawl.dev/api-reference/endpoint/queue-status.md)
- [Get Threat Protection Policy](https://docs.firecrawl.dev/api-reference/endpoint/threat-protection.md)
- [Update Threat Protection Policy](https://docs.firecrawl.dev/api-reference/endpoint/threat-protection-update.md): Full-document update. Unspecified fields reset to defaults. Enterprise feature, team admins only.

#### Webhook Payloads

##### Crawl

- [Crawl Started](https://docs.firecrawl.dev/api-reference/endpoint/webhook-crawl-started.md): Webhook event sent when a crawl job begins processing.
- [Crawl Page](https://docs.firecrawl.dev/api-reference/endpoint/webhook-crawl-page.md): Webhook event sent for each page scraped during a crawl job.
- [Crawl Completed](https://docs.firecrawl.dev/api-reference/endpoint/webhook-crawl-completed.md): Webhook event sent when a crawl job finishes and all pages have been processed.

##### Batch Scrape

- [Batch Scrape Started](https://docs.firecrawl.dev/api-reference/endpoint/webhook-batch-scrape-started.md): Webhook event sent when a batch scrape job begins processing.
- [Batch Scrape Page](https://docs.firecrawl.dev/api-reference/endpoint/webhook-batch-scrape-page.md): Webhook event sent for each URL scraped during a batch scrape job.
- [Batch Scrape Completed](https://docs.firecrawl.dev/api-reference/endpoint/webhook-batch-scrape-completed.md): Webhook event sent when all URLs in a batch scrape have been processed.

##### Monitor

- [Monitor Page](https://docs.firecrawl.dev/api-reference/endpoint/webhook-monitor-page.md)
- [Monitor Check Completed](https://docs.firecrawl.dev/api-reference/endpoint/webhook-monitor-check-completed.md)

#### Firecrawl for Platforms

- [Firecrawl for Platforms](https://docs.firecrawl.dev/firecrawl-for-platforms.md): API reference for platforms that create and manage Firecrawl API keys for their users

### Build with AI

#### Getting Started

##### Build with AI

- [Build with AI](https://docs.firecrawl.dev/ai-onboarding.md): Everything you need to onboard your AI agent to Firecrawl.
- [Agent Auth (WorkOS ID-JAG)](https://docs.firecrawl.dev/ai-onboarding/agent-auth.md): Register a Firecrawl API key via WorkOS ID-JAG agent auth. Discovery and links to auth.md.

#### AI Tools

- [CLI](https://docs.firecrawl.dev/sdks/cli.md): Firecrawl skills are an easy way for AI agents such as Codex, Claude Code, Cursor, and OpenCode to use Firecrawl through the CLI.
- [OpenClaw](https://docs.firecrawl.dev/quickstarts/openclaw.md): Use Firecrawl with OpenClaw to give your agents web scraping, search, and browser automation capabilities.

##### MCP

- [Get Started](https://docs.firecrawl.dev/mcp-server.md): Set up Firecrawl MCP with keyless access, account sign-in, or an API key.
- [Get Started](https://docs.firecrawl.dev/mcp-server.md): Set up Firecrawl MCP with keyless access, account sign-in, or an API key.
- [For Agents](https://docs.firecrawl.dev/mcp-server/keyless.md): Agents can start instantly, no API key required. Add an API key to unlock more usage.
- [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md): Sign in via your browser.

#### Agent Harnesses

- [OpenClaw](https://docs.firecrawl.dev/quickstarts/openclaw.md): Use Firecrawl with OpenClaw to give your agents web scraping, search, and browser automation capabilities.
- [MCP Web Search & Scrape in Claude Code](https://docs.firecrawl.dev/quickstarts/claude-code.md): Add web scraping and search to Claude Code in 2 minutes
- [MCP Web Search & Scrape in Cursor](https://docs.firecrawl.dev/quickstarts/cursor.md): Add web scraping and search to Cursor in 2 minutes
- [MCP Web Search & Scrape in OpenCode](https://docs.firecrawl.dev/quickstarts/opencode.md): Add Firecrawl web scraping and search to OpenCode
- [MCP Web Search & Scrape in Codex CLI](https://docs.firecrawl.dev/quickstarts/codex-cli.md): Add Firecrawl web scraping and search to OpenAI Codex CLI
- [OpenRouter](https://docs.firecrawl.dev/quickstarts/openrouter.md): Use Firecrawl as a tool with any model served by OpenRouter.
- [MCP Web Search & Scrape in Amp](https://docs.firecrawl.dev/quickstarts/amp.md): Add Firecrawl web scraping and search to Sourcegraph Amp
- [MCP Web Search & Scrape in Windsurf](https://docs.firecrawl.dev/quickstarts/windsurf.md): Add web scraping and search to Windsurf in 2 minutes
- [MCP Web Search & Scrape in Antigravity](https://docs.firecrawl.dev/quickstarts/antigravity.md): Add Firecrawl web scraping and search to Google Antigravity
- [MCP Web Search & Scrape in Gemini CLI](https://docs.firecrawl.dev/quickstarts/gemini-cli.md): Add Firecrawl web scraping and search to Google Gemini CLI
- [Nous Research](https://docs.firecrawl.dev/quickstarts/nous-research.md): Use Firecrawl as a tool with Nous Research Hermes models.
- [AutoGen](https://docs.firecrawl.dev/quickstarts/autogen.md): Use Firecrawl as a tool inside Microsoft AutoGen multi-agent conversations.

#### LLM SDKs and Frameworks

- [OpenAI](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/openai.md): Use Firecrawl with OpenAI for web scraping + AI workflows
- [Anthropic](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/anthropic.md): Use Firecrawl with Claude for web scraping + AI workflows
- [Gemini](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/gemini.md): Use Firecrawl with Google's Gemini AI for web scraping + AI workflows
- [Agent Development Kit (ADK)](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/google-adk.md): Integrate Firecrawl with Google's ADK using MCP for advanced agent workflows
- [Vercel AI SDK](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/vercel-ai-sdk.md): Firecrawl tools for Vercel AI SDK. Web scraping, search, interact, and crawling for AI applications.
- [LangChain](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/langchain.md): Use Firecrawl with LangChain for web scraping + AI workflows
- [LangGraph](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/langgraph.md): Integrate Firecrawl with LangGraph for building agent workflows
- [LlamaIndex](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/llamaindex.md): Use Firecrawl with LlamaIndex for RAG applications
- [Mastra](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/mastra.md): Use Firecrawl with Mastra for building AI workflows
- [ElevenAgents](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/elevenagents.md): Give ElevenLabs voice and chat agents real-time web access with Firecrawl
- [Jev](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/jev.md): Use Firecrawl with TypeSafe's Jev to make fast, structured decisions on web data

#### Agentic Debugging

- [Debug Firecrawl with Ask](https://docs.firecrawl.dev/features/ask.md): Debug a failed job or any Firecrawl integration issue with an agentic support API

#### Cookbooks

- [Building an AI Research Assistant with Firecrawl and AI SDK](https://docs.firecrawl.dev/developer-guides/cookbooks/ai-research-assistant-cookbook.md): Build a complete AI-powered research assistant with web scraping and search capabilities
- [Building a Brand Style Guide Generator with Firecrawl](https://docs.firecrawl.dev/developer-guides/cookbooks/brand-style-guide-generator-cookbook.md): Generate professional PDF brand style guides by extracting design systems from any website using Firecrawl's branding format

## OpenAPI Specs

- [v2-openapi](/api-reference/v2-openapi.json)
- [webhooks-openapi](/api-reference/webhooks-openapi.json)
