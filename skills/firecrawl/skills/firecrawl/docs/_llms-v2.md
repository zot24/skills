> Source: https://docs.firecrawl.dev/_llms/en/v2.md

# Firecrawl Docs: English v2

## v2

### Documentation

#### Get Started

- [Introduction](https://docs.firecrawl.dev/introduction.md): Search the web, scrape any page, and interact with it, all through one API.
- [CLI](https://docs.firecrawl.dev/sdks/cli.md): Firecrawl skills are an easy way for AI agents such as Claude Code, Antigravity and OpenCode to use Firecrawl through the CLI.
- [Build with AI](https://docs.firecrawl.dev/ai-onboarding.md): Everything you need to onboard your AI agent to Firecrawl.
- [Advanced Scraping Guide](https://docs.firecrawl.dev/advanced-scraping-guide.md): Configure scrape options, browser actions, crawl, map, and the agent endpoint with Firecrawl's full API surface.

##### MCP

- [Get Started](https://docs.firecrawl.dev/mcp-server.md): Set up Firecrawl MCP with keyless access, account sign-in, or an API key.
- [Get Started](https://docs.firecrawl.dev/mcp-server.md): Set up Firecrawl MCP with keyless access, account sign-in, or an API key.
- [For Agents](https://docs.firecrawl.dev/mcp-server/keyless.md): Agents can start instantly, no API key required. Add an API key to unlock more usage.
- [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md): Sign in via your browser.

##### Plans and Billing

- [Billing](https://docs.firecrawl.dev/billing.md): How Firecrawl billing, credits, and plans work
- [Rate Limits](https://docs.firecrawl.dev/rate-limits.md): Rate limits for different pricing plans and API requests
- [Partner Credits](https://docs.firecrawl.dev/partner-credits.md): How Firecrawl partner credits work, including eligibility, expiration, and plan limits

##### Enterprise

- [Enterprise](https://docs.firecrawl.dev/enterprise.md): Enterprise plans, security, and features for Firecrawl at scale
- [IP Restrictions](https://docs.firecrawl.dev/features/ip-restrictions.md): Restrict your team's API keys to an allowlist of IP addresses or CIDR ranges, so they only work from approved networks. Enforced server-side.
- [Key Restrictions](https://docs.firecrawl.dev/features/key-restrictions.md): Lock an individual API key to specific output formats and endpoints. Enforced server-side, with no way for a request to override it.
- [Threat Protection](https://docs.firecrawl.dev/features/threat-protection.md): Block requests to risky URLs across every endpoint, using a policy your organization controls. Enforced server-side.
- [SIEM Audit Logging](https://docs.firecrawl.dev/features/siem.md): Stream a structured audit event for every scrape your team runs to your own SIEM, starting with Microsoft Sentinel. Delivered server-side.

#### Core Endpoints

- [Interact after scraping](https://docs.firecrawl.dev/features/interact.md): Interact with a page you fetched by prompting or running code.

##### Search

- [Search](https://docs.firecrawl.dev/features/search.md): Search the web and get full content from results
- [Search Highlights](https://docs.firecrawl.dev/features/search-highlights.md): Return query-relevant passages instead of plain website descriptions
- [Research Index](https://docs.firecrawl.dev/features/research.md): Search papers, read paper passages, and find related work
- [Developer Index](https://docs.firecrawl.dev/features/developer.md): Search issues, merged pull requests, repository READMEs, and curated documentation sites

##### Scrape

- [Scrape](https://docs.firecrawl.dev/features/scrape.md): Turn any url into clean data
- [Faster Scraping](https://docs.firecrawl.dev/features/fast-scraping.md): Speed up your scrapes by 500% with the maxAge parameter
- [Batch Scrape](https://docs.firecrawl.dev/features/batch-scrape.md): Scrape multiple URLs in a single batch job
- [JSON mode - Structured result](https://docs.firecrawl.dev/features/llm-extract.md): Extract structured data from pages via LLMs
- [Change Tracking](https://docs.firecrawl.dev/features/change-tracking.md): Detect and monitor changes in web content between scrapes
- [Enhanced Mode](https://docs.firecrawl.dev/features/enhanced-mode.md): Use enhanced proxies for reliable scraping on complex sites
- [Lockdown Mode](https://docs.firecrawl.dev/features/lockdown.md): Cache-only scrape mode for compliance and air-gapped environments. No outbound traffic.
- [PII Redaction](https://docs.firecrawl.dev/features/pii-redaction.md): Redact personally identifiable information from scrape and parse output
- [Proxies](https://docs.firecrawl.dev/features/proxies.md): Learn about proxy types, locations, and how Firecrawl selects proxies for your requests.
- [Document Parsing](https://docs.firecrawl.dev/features/document-parsing.md): Learn about document parsing capabilities.

##### Monitor

- [Monitoring](https://docs.firecrawl.dev/features/monitoring.md): Schedule recurring checks, detect changes, and get notified by webhook or email
- [Page monitoring](https://docs.firecrawl.dev/features/monitoring-page.md): Watch known URLs and get alerted on meaningful page changes
- [Website monitoring](https://docs.firecrawl.dev/features/monitoring-website.md): Crawl a website on a schedule and detect changes across every discovered page
- [Entire web-scale monitoring](https://docs.firecrawl.dev/features/monitoring-web-scale.md): Run always-on web searches and alert when new matching results appear

#### More

- [Parse](https://docs.firecrawl.dev/features/parse.md): Turn documents — PDFs, Word, Excel, PowerPoint, and more — into clean markdown, per-page content, layout blocks, and structured JSON
- [Map](https://docs.firecrawl.dev/features/map.md): Input a website and get all the urls on the website - extremely fast
- [Crawl](https://docs.firecrawl.dev/features/crawl.md): Recursively crawl a website and get content from every page

#### Quickstarts

- [Go](https://docs.firecrawl.dev/quickstarts/go.md): Get started with Firecrawl in Go. Scrape, search, and interact with web data using the REST API.
- [Rust](https://docs.firecrawl.dev/quickstarts/rust.md): Get started with Firecrawl in Rust. Search, scrape, and interact with web data using the official SDK.
- [Elixir](https://docs.firecrawl.dev/quickstarts/elixir.md): Get started with Firecrawl in Elixir. Search, scrape, and interact with web data using the official SDK.

##### Node.js

- [Node.js](https://docs.firecrawl.dev/quickstarts/nodejs.md): Get started with Firecrawl in Node.js. Scrape, search, and interact with web data using the official SDK.
- [Next.js](https://docs.firecrawl.dev/quickstarts/nextjs.md): Use Firecrawl with Next.js to scrape, search, and interact with web data in your React application.
- [Express](https://docs.firecrawl.dev/quickstarts/express.md): Use Firecrawl with Express to build web scraping and search APIs.
- [NestJS](https://docs.firecrawl.dev/quickstarts/nestjs.md): Use Firecrawl with NestJS to build structured web scraping and search services.
- [Fastify](https://docs.firecrawl.dev/quickstarts/fastify.md): Use Firecrawl with Fastify to build high-performance web scraping and search APIs.
- [Hono](https://docs.firecrawl.dev/quickstarts/hono.md): Use Firecrawl with Hono to build lightweight web scraping and search APIs that run anywhere.
- [Bun](https://docs.firecrawl.dev/quickstarts/bun.md): Use Firecrawl with Bun to build fast web scraping and search servers.
- [Remix](https://docs.firecrawl.dev/quickstarts/remix.md): Use Firecrawl with Remix to scrape, search, and interact with web data in your full-stack React app.
- [Nuxt](https://docs.firecrawl.dev/quickstarts/nuxt.md): Use Firecrawl with Nuxt to scrape, search, and interact with web data in your Vue application.
- [SvelteKit](https://docs.firecrawl.dev/quickstarts/sveltekit.md): Use Firecrawl with SvelteKit to scrape, search, and interact with web data in your Svelte application.
- [Astro](https://docs.firecrawl.dev/quickstarts/astro.md): Use Firecrawl with Astro to scrape, search, and interact with web data in your content-driven site.
- [Mastra](https://docs.firecrawl.dev/quickstarts/mastra.md): Wire Firecrawl into Mastra tools so your agents and workflows can search and scrape live web data.

##### Serverless

- [Cloudflare Workers](https://docs.firecrawl.dev/quickstarts/cloudflare-workers.md): Use Firecrawl with Cloudflare Workers to search, scrape, and interact with web data at the edge.
- [Vercel Functions](https://docs.firecrawl.dev/quickstarts/vercel-functions.md): Use Firecrawl with Vercel Functions to search, scrape, and interact with web data in serverless deployments.
- [Vercel Marketplace](https://docs.firecrawl.dev/quickstarts/vercel-marketplace.md): Install Firecrawl from the Vercel Marketplace, attach it to a project, and use the injected FIRECRAWL_API_KEY in your Vercel app.
- [AWS Lambda](https://docs.firecrawl.dev/quickstarts/aws-lambda.md): Use Firecrawl with AWS Lambda to search, scrape, and interact with web data in serverless functions.
- [Supabase Edge Functions](https://docs.firecrawl.dev/quickstarts/supabase-edge-functions.md): Use Firecrawl with Supabase Edge Functions to search, scrape, and interact with web data at the edge.
- [Deno Deploy](https://docs.firecrawl.dev/quickstarts/deno-deploy.md): Use Firecrawl with Deno Deploy to search, scrape, and interact with web data at the edge.

##### PHP

- [PHP](https://docs.firecrawl.dev/quickstarts/php.md): Get started with Firecrawl in PHP. Scrape, search, and interact with web data using the REST API.
- [Laravel](https://docs.firecrawl.dev/quickstarts/laravel.md): Use Firecrawl with Laravel to search, scrape, and interact with web data using the REST API.

##### Ruby

- [Ruby](https://docs.firecrawl.dev/quickstarts/ruby.md): Get started with Firecrawl in Ruby. Search, scrape, and interact with web data using the REST API.
- [Rails](https://docs.firecrawl.dev/quickstarts/rails.md): Use Firecrawl with Ruby on Rails to search, scrape, and interact with web data using the REST API.

##### Python

- [Python](https://docs.firecrawl.dev/quickstarts/python.md): Get started with Firecrawl in Python. Scrape, search, and interact with web data using the official SDK.
- [FastAPI](https://docs.firecrawl.dev/quickstarts/fastapi.md): Use Firecrawl with FastAPI to build async web scraping and search APIs in Python.
- [Django](https://docs.firecrawl.dev/quickstarts/django.md): Use Firecrawl with Django to scrape, search, and interact with web data in your Python web application.
- [Flask](https://docs.firecrawl.dev/quickstarts/flask.md): Use Firecrawl with Flask to build web scraping and search APIs in Python.

##### Java

- [Java](https://docs.firecrawl.dev/quickstarts/java.md): Get started with Firecrawl in Java. Search, scrape, and interact with web data using the official SDK.
- [Spring Boot](https://docs.firecrawl.dev/quickstarts/spring-boot.md): Use Firecrawl with Spring Boot to search, scrape, and interact with web data using the official Java SDK.

##### .NET

- [.NET](https://docs.firecrawl.dev/quickstarts/dotnet.md): Get started with Firecrawl in .NET. Scrape, search, and interact with web data using the REST API.
- [ASP.NET Core](https://docs.firecrawl.dev/quickstarts/aspnet-core.md): Use Firecrawl with ASP.NET Core to search, scrape, and interact with web data using the REST API.

#### Developer Guides

- [Full-Stack Templates](https://docs.firecrawl.dev/developer-guides/examples.md): Explore real-world examples and tutorials for Firecrawl

##### Usage Guides

- [Choosing the Data Extractor](https://docs.firecrawl.dev/developer-guides/usage-guides/choosing-the-data-extractor.md): Compare /agent, /extract, and /scrape (JSON mode) to pick the right tool for structured data extraction
- [Verifying Freshness and Liveness](https://docs.firecrawl.dev/developer-guides/usage-guides/verifying-freshness-and-liveness.md): Understand the difference between content freshness and whether the state represented by a page is current

##### LLM SDKs and Frameworks

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

##### Cookbooks

- [Building an AI Research Assistant with Firecrawl and AI SDK](https://docs.firecrawl.dev/developer-guides/cookbooks/ai-research-assistant-cookbook.md): Build a complete AI-powered research assistant with web scraping and search capabilities
- [Building a Brand Style Guide Generator with Firecrawl](https://docs.firecrawl.dev/developer-guides/cookbooks/brand-style-guide-generator-cookbook.md): Generate professional PDF brand style guides by extracting design systems from any website using Firecrawl's branding format

##### Integrations

- [Integrations](https://docs.firecrawl.dev/integrations.md): Add Firecrawl web search, scraping, and interaction to the coding agents, app builders, frameworks, and automation platforms you already use
- [Hermes Agent](https://docs.firecrawl.dev/integrations/hermes.md): Use Firecrawl as the default web search and extract backend in Hermes Agent
- [Replit](https://docs.firecrawl.dev/integrations/replit.md): Official Replit Connector for Firecrawl web search, scraping, and browser interaction
- [Lovable](https://docs.firecrawl.dev/integrations/lovable.md): Connect Firecrawl to Lovable apps for live web scraping and crawling
- [LangChain](https://docs.firecrawl.dev/integrations/langchain.md): Use Firecrawl in LangChain as a document loader or as agent tools.
- [LlamaIndex](https://docs.firecrawl.dev/integrations/llamaindex.md): Firecrawl integrates with LlamaIndex as a document reader.
- [CrewAI](https://docs.firecrawl.dev/integrations/crewai.md): Learn how to use Firecrawl with CrewAI
- [Camel AI](https://docs.firecrawl.dev/integrations/camelai.md): Firecrawl integrates with Camel AI as a data loader.
- [Praison AI](https://docs.firecrawl.dev/integrations/praison.md): Scrape the web with Firecrawl as a Praison AI tool
- [Dify](https://docs.firecrawl.dev/integrations/dify.md): Official Firecrawl plugin for Dify workflows, plus knowledge base website sync
- [Langflow](https://docs.firecrawl.dev/integrations/langflow.md): Learn how to use Firecrawl on Langflow
- [Flowise](https://docs.firecrawl.dev/integrations/flowise.md): Learn how to use Firecrawl on Flowise
- [Zapier](https://docs.firecrawl.dev/integrations/zapier.md): Official tutorials and Zapier integration templates for Firecrawl automation
- [Make](https://docs.firecrawl.dev/integrations/make.md): Official integration and workflow automation for Firecrawl and Make
- [n8n](https://docs.firecrawl.dev/integrations/n8n.md): Learn how to use Firecrawl with n8n for web scraping automation, a complete step-by-step guide.
- [Pipedream](https://docs.firecrawl.dev/integrations/pipedream.md): Add Firecrawl scrape, crawl, search, map, and extract steps to Pipedream workflows
- [Composio](https://docs.firecrawl.dev/integrations/composio.md): Use Firecrawl tools inside Composio agent workflows
- [SourceSync.ai](https://docs.firecrawl.dev/integrations/sourcesyncai.md): Firecrawl integrates with SourceSync.ai for web scraping capabilities.

#### Webhooks

- [Overview](https://docs.firecrawl.dev/webhooks/overview.md): Real-time notifications for your Firecrawl operations
- [Event Types](https://docs.firecrawl.dev/webhooks/events.md): Webhook event reference
- [Security](https://docs.firecrawl.dev/webhooks/security.md): Verify webhook authenticity
- [Testing](https://docs.firecrawl.dev/webhooks/testing.md): Test and debug webhooks

#### Use Cases

- [Use Cases](https://docs.firecrawl.dev/use-cases/overview.md): Transform web data into powerful features for your applications
- [AI Platforms](https://docs.firecrawl.dev/use-cases/ai-platforms.md): Power AI assistants and let customers build AI apps
- [Lead Enrichment](https://docs.firecrawl.dev/use-cases/lead-enrichment.md): Extract and filter leads from websites to power your sales pipeline
- [SEO Platforms](https://docs.firecrawl.dev/use-cases/seo-platforms.md): Optimize websites for AI assistants and search engines
- [Deep Research](https://docs.firecrawl.dev/use-cases/deep-research.md): Build agentic research tools with deep web search capabilities

##### View more

- [Product & E-commerce](https://docs.firecrawl.dev/use-cases/product-ecommerce.md): Monitor pricing and track inventory across e-commerce sites
- [Content Generation](https://docs.firecrawl.dev/use-cases/content-generation.md): Generate AI content based on website data, images, and news
- [Developers & MCP](https://docs.firecrawl.dev/use-cases/developers-mcp.md): Build powerful integrations with Model Context Protocol support
- [Investment & Finance](https://docs.firecrawl.dev/use-cases/investment-finance.md): Track companies and extract financial insights from web data
- [Competitive Intelligence](https://docs.firecrawl.dev/use-cases/competitive-intelligence.md): Monitor competitor websites and track changes in real-time
- [Data Migration](https://docs.firecrawl.dev/use-cases/data-migration.md): Transfer web data efficiently between platforms and systems
- [Observability & Monitoring](https://docs.firecrawl.dev/use-cases/observability.md): Monitor websites, track uptime, and detect changes in real-time

#### Other

- [Overview](https://docs.firecrawl.dev/dashboard.md): Overview of the Firecrawl dashboard and its key features
- [Debug Firecrawl with Ask](https://docs.firecrawl.dev/features/ask.md): Debug a failed job or any Firecrawl integration issue with an agentic support API

#### Contributing

- [Open source or Firecrawl Cloud](https://docs.firecrawl.dev/contributing/open-source-or-cloud.md): Choose between self-hosting Firecrawl for infrastructure control and Firecrawl Cloud for the fastest managed path to production.
- [Run Firecrawl locally for development](https://docs.firecrawl.dev/contributing/guide.md): Set up the Firecrawl API development environment, verify a local scrape, and run the source-owned test harness before contributing.
- [Self-hosting Firecrawl](https://docs.firecrawl.dev/contributing/self-host.md): Self-host Firecrawl with Docker Compose, verify a local scrape, understand open-source limits, and prepare the stack for production.

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
- [CLI](https://docs.firecrawl.dev/sdks/cli.md): Firecrawl skills are an easy way for AI agents such as Claude Code, Antigravity and OpenCode to use Firecrawl through the CLI.

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

#### Interact Endpoints

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

#### Partner Integration

- [Partner Integration API](https://docs.firecrawl.dev/partner-integration.md): API reference for approved Firecrawl partners to create and manage API keys for their users

### Build with AI

#### Getting Started

##### Build with AI

- [Build with AI](https://docs.firecrawl.dev/ai-onboarding.md): Everything you need to onboard your AI agent to Firecrawl.
- [Agent Auth (WorkOS ID-JAG)](https://docs.firecrawl.dev/ai-onboarding/agent-auth.md): Register a Firecrawl API key via WorkOS ID-JAG agent auth. Discovery and links to auth.md.

#### AI Tools

- [CLI](https://docs.firecrawl.dev/sdks/cli.md): Firecrawl skills are an easy way for AI agents such as Claude Code, Antigravity and OpenCode to use Firecrawl through the CLI.
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

#### Agent Endpoint

- [FIRE-1 Agent (Beta)](https://docs.firecrawl.dev/agents/fire-1.md): AI agent that enables intelligent navigation and interaction with web pages
- [FIRE-1 Agent (Beta)](https://docs.firecrawl.dev/agents/fire-1-extract.md): FIRE-1 is an AI agent that enables intelligent navigation and interaction with web pages

#### Agentic Debugging

- [Debug Firecrawl with Ask](https://docs.firecrawl.dev/features/ask.md): Debug a failed job or any Firecrawl integration issue with an agentic support API

#### Cookbooks

- [Building an AI Research Assistant with Firecrawl and AI SDK](https://docs.firecrawl.dev/developer-guides/cookbooks/ai-research-assistant-cookbook.md): Build a complete AI-powered research assistant with web scraping and search capabilities
- [Building a Brand Style Guide Generator with Firecrawl](https://docs.firecrawl.dev/developer-guides/cookbooks/brand-style-guide-generator-cookbook.md): Generate professional PDF brand style guides by extracting design systems from any website using Firecrawl's branding format

## OpenAPI Specs

- [v2-openapi](/api-reference/v2-openapi.json)
- [webhooks-openapi](/api-reference/webhooks-openapi.json)
