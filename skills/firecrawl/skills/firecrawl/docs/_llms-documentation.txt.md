> Source: https://docs.firecrawl.dev/_llms/en/v2/documentation.txt

# Firecrawl Docs: English v2 Documentation

## Documentation

### Get Started

- [Introduction](https://docs.firecrawl.dev/introduction.md): The web data API for AI agents. Search the web, scrape any page, and interact with it through one API.
- [Firecrawl in ChatGPT & Codex](https://docs.firecrawl.dev/integrations/chatgpt-codex.md): Search the web, read pages, and work with live web data from ChatGPT & Codex.
- [Firecrawl in Claude & Claude Code](https://docs.firecrawl.dev/quickstarts/claude-code.md): Search the web and read pages from Claude or your Claude Code session.
- [MCP Web Search & Scrape in Cursor](https://docs.firecrawl.dev/quickstarts/cursor.md): Add web scraping and search to Cursor in 2 minutes
- [CLI](https://docs.firecrawl.dev/sdks/cli.md): Firecrawl skills are an easy way for AI agents such as Codex, Claude Code, Cursor, and OpenCode to use Firecrawl through the CLI.
- [Advanced Scraping Guide](https://docs.firecrawl.dev/advanced-scraping-guide.md): Configure scrape options, browser actions, crawl, map, and the agent endpoint with Firecrawl's full API surface.

#### MCP

- [Get Started](https://docs.firecrawl.dev/mcp-server.md): Set up Firecrawl MCP with keyless access, account sign-in, or an API key.
- [Get Started](https://docs.firecrawl.dev/mcp-server.md): Set up Firecrawl MCP with keyless access, account sign-in, or an API key.
- [For Agents](https://docs.firecrawl.dev/mcp-server/keyless.md): Agents can start instantly, no API key required. Add an API key to unlock more usage.
- [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md): Sign in via your browser.

#### Plans and Billing

- [Billing](https://docs.firecrawl.dev/billing.md): How Firecrawl billing, credits, and plans work
- [Rate Limits](https://docs.firecrawl.dev/rate-limits.md): Rate limits for different pricing plans and API requests
- [Partner Credits](https://docs.firecrawl.dev/partner-credits.md): How Firecrawl partner credits work, including eligibility, expiration, and plan limits

#### Enterprise

- [Enterprise](https://docs.firecrawl.dev/enterprise.md): Enterprise plans, security, and features for Firecrawl at scale
- [SSO and SCIM](https://docs.firecrawl.dev/features/sso.md): Set up single sign-on (SSO) and SCIM directory sync so your team signs in through your identity provider and user access stays in sync with your directory.
- [IP Restrictions](https://docs.firecrawl.dev/features/ip-restrictions.md): Restrict your team's API keys to an allowlist of IP addresses or CIDR ranges, so they only work from approved networks. Enforced server-side.
- [Key Restrictions](https://docs.firecrawl.dev/features/key-restrictions.md): Lock an individual API key to specific output formats and endpoints. Enforced server-side, with no way for a request to override it.
- [Threat Protection](https://docs.firecrawl.dev/features/threat-protection.md): Block requests to risky URLs across every endpoint, using a policy your organization controls. Enforced server-side.
- [SIEM Audit Logging](https://docs.firecrawl.dev/features/siem.md): Stream a structured audit event for every scrape your team runs to your own SIEM, starting with Microsoft Sentinel. Delivered server-side.

### Core Endpoints

#### Search

- [Search](https://docs.firecrawl.dev/features/search.md): Search the web and get full content from results
- [Search Highlights](https://docs.firecrawl.dev/features/search-highlights.md): Return query-relevant passages instead of plain website descriptions
- [Research Index](https://docs.firecrawl.dev/features/research.md): Search papers, read paper passages, and find related work
- [Developer Index](https://docs.firecrawl.dev/features/developer.md): Search issues, merged pull requests, repository READMEs, and curated documentation sites
- [Government Index](https://docs.firecrawl.dev/features/gov.md): Search statutes, regulations, codes, court opinions, and other government publications

#### Scrape

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

#### Monitor

- [Monitoring](https://docs.firecrawl.dev/features/monitoring.md): Schedule recurring checks, detect changes, and get notified by webhook or email
- [Page monitoring](https://docs.firecrawl.dev/features/monitoring-page.md): Watch known URLs and get alerted on meaningful page changes
- [Website monitoring](https://docs.firecrawl.dev/features/monitoring-website.md): Crawl a website on a schedule and detect changes across every discovered page
- [Entire web-scale monitoring](https://docs.firecrawl.dev/features/monitoring-web-scale.md): Run always-on web searches and alert when new matching results appear

#### Interact / Browser Sandbox

- [Interact after scraping](https://docs.firecrawl.dev/features/interact.md): Interact with a page you fetched by prompting or running code.
- [Browser Sandbox](https://docs.firecrawl.dev/features/browser.md): A secure browser sandbox where agents can interact with the web.

### More

- [Alexandria](https://docs.firecrawl.dev/features/alexandria.md): The knowledge library for superintelligence
- [Parse](https://docs.firecrawl.dev/features/parse.md): Turn documents — PDFs, Word, Excel, PowerPoint, and more — into clean markdown, per-page content, layout blocks, and structured JSON
- [Map](https://docs.firecrawl.dev/features/map.md): Input a website and get all the urls on the website - extremely fast
- [Crawl](https://docs.firecrawl.dev/features/crawl.md): Recursively crawl a website and get content from every page
- [Agent](https://docs.firecrawl.dev/features/agent.md): Gather data wherever it lives on the web.

### Quickstarts

- [Go](https://docs.firecrawl.dev/quickstarts/go.md): Get started with Firecrawl in Go. Scrape, search, and interact with web data using the REST API.
- [Rust](https://docs.firecrawl.dev/quickstarts/rust.md): Get started with Firecrawl in Rust. Search, scrape, and interact with web data using the official SDK.
- [Elixir](https://docs.firecrawl.dev/quickstarts/elixir.md): Get started with Firecrawl in Elixir. Search, scrape, and interact with web data using the official SDK.

#### Node.js

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

#### Serverless

- [Cloudflare Workers](https://docs.firecrawl.dev/quickstarts/cloudflare-workers.md): Use Firecrawl with Cloudflare Workers to search, scrape, and interact with web data at the edge.
- [Vercel Functions](https://docs.firecrawl.dev/quickstarts/vercel-functions.md): Use Firecrawl with Vercel Functions to search, scrape, and interact with web data in serverless deployments.
- [Vercel Marketplace](https://docs.firecrawl.dev/quickstarts/vercel-marketplace.md): Install Firecrawl from the Vercel Marketplace, attach it to a project, and use the injected FIRECRAWL_API_KEY in your Vercel app.
- [AWS Lambda](https://docs.firecrawl.dev/quickstarts/aws-lambda.md): Use Firecrawl with AWS Lambda to search, scrape, and interact with web data in serverless functions.
- [Supabase Edge Functions](https://docs.firecrawl.dev/quickstarts/supabase-edge-functions.md): Use Firecrawl with Supabase Edge Functions to search, scrape, and interact with web data at the edge.
- [Deno Deploy](https://docs.firecrawl.dev/quickstarts/deno-deploy.md): Use Firecrawl with Deno Deploy to search, scrape, and interact with web data at the edge.

#### PHP

- [PHP](https://docs.firecrawl.dev/quickstarts/php.md): Get started with Firecrawl in PHP. Scrape, search, and interact with web data using the REST API.
- [Laravel](https://docs.firecrawl.dev/quickstarts/laravel.md): Use Firecrawl with Laravel to search, scrape, and interact with web data using the REST API.

#### Ruby

- [Ruby](https://docs.firecrawl.dev/quickstarts/ruby.md): Get started with Firecrawl in Ruby. Search, scrape, and interact with web data using the REST API.
- [Rails](https://docs.firecrawl.dev/quickstarts/rails.md): Use Firecrawl with Ruby on Rails to search, scrape, and interact with web data using the REST API.

#### Python

- [Python](https://docs.firecrawl.dev/quickstarts/python.md): Get started with Firecrawl in Python. Scrape, search, and interact with web data using the official SDK.
- [FastAPI](https://docs.firecrawl.dev/quickstarts/fastapi.md): Use Firecrawl with FastAPI to build async web scraping and search APIs in Python.
- [Django](https://docs.firecrawl.dev/quickstarts/django.md): Use Firecrawl with Django to scrape, search, and interact with web data in your Python web application.
- [Flask](https://docs.firecrawl.dev/quickstarts/flask.md): Use Firecrawl with Flask to build web scraping and search APIs in Python.

#### Java

- [Java](https://docs.firecrawl.dev/quickstarts/java.md): Get started with Firecrawl in Java. Search, scrape, and interact with web data using the official SDK.
- [Spring Boot](https://docs.firecrawl.dev/quickstarts/spring-boot.md): Use Firecrawl with Spring Boot to search, scrape, and interact with web data using the official Java SDK.

#### .NET

- [.NET](https://docs.firecrawl.dev/quickstarts/dotnet.md): Get started with Firecrawl in .NET. Scrape, search, and interact with web data using the REST API.
- [ASP.NET Core](https://docs.firecrawl.dev/quickstarts/aspnet-core.md): Use Firecrawl with ASP.NET Core to search, scrape, and interact with web data using the REST API.

### Developer Guides

- [Full-Stack Templates](https://docs.firecrawl.dev/developer-guides/examples.md): Explore real-world examples and tutorials for Firecrawl

#### Usage Guides

- [Choosing the Data Extractor](https://docs.firecrawl.dev/developer-guides/usage-guides/choosing-the-data-extractor.md): Compare /agent, /extract, and /scrape (JSON mode) to pick the right tool for structured data extraction
- [Verifying Freshness and Liveness](https://docs.firecrawl.dev/developer-guides/usage-guides/verifying-freshness-and-liveness.md): Understand the difference between content freshness and whether the state represented by a page is current

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

#### Cookbooks

- [Building an AI Research Assistant with Firecrawl and AI SDK](https://docs.firecrawl.dev/developer-guides/cookbooks/ai-research-assistant-cookbook.md): Build a complete AI-powered research assistant with web scraping and search capabilities
- [Building a Brand Style Guide Generator with Firecrawl](https://docs.firecrawl.dev/developer-guides/cookbooks/brand-style-guide-generator-cookbook.md): Generate professional PDF brand style guides by extracting design systems from any website using Firecrawl's branding format

#### Platforms and frameworks

- [Hermes Agent](https://docs.firecrawl.dev/integrations/hermes.md): Use Firecrawl as the default web search and extract backend in Hermes Agent
- [Replit](https://docs.firecrawl.dev/integrations/replit.md): Official Replit Connector for Firecrawl web search, scraping, and browser interaction
- [Lovable](https://docs.firecrawl.dev/integrations/lovable.md): Connect Firecrawl to Lovable apps for live web scraping and crawling
- [Stripe Projects](https://docs.firecrawl.dev/integrations/stripe-projects.md): Provision a Firecrawl account, API key, and plan from the Stripe Projects CLI
- [LangChain](https://docs.firecrawl.dev/integrations/langchain.md): Use Firecrawl in LangChain as a document loader or as agent tools.
- [LlamaIndex](https://docs.firecrawl.dev/integrations/llamaindex.md): Firecrawl integrates with LlamaIndex as a document reader.
- [CrewAI](https://docs.firecrawl.dev/integrations/crewai.md): Learn how to use Firecrawl with CrewAI
- [Camel AI](https://docs.firecrawl.dev/integrations/camelai.md): Firecrawl integrates with Camel AI as a data loader.
- [Praison AI](https://docs.firecrawl.dev/integrations/praison.md): Scrape the web with Firecrawl as a Praison AI tool
- [Neuron AI](https://docs.firecrawl.dev/integrations/neuron-ai.md): Search the web and read pages as Markdown from Neuron AI agents in PHP
- [Dify](https://docs.firecrawl.dev/integrations/dify.md): Official Firecrawl plugin for Dify workflows, plus knowledge base website sync
- [Langflow](https://docs.firecrawl.dev/integrations/langflow.md): Learn how to use Firecrawl on Langflow
- [Flowise](https://docs.firecrawl.dev/integrations/flowise.md): Learn how to use Firecrawl on Flowise
- [Zapier](https://docs.firecrawl.dev/integrations/zapier.md): Official tutorials and Zapier integration templates for Firecrawl automation
- [Make](https://docs.firecrawl.dev/integrations/make.md): Official integration and workflow automation for Firecrawl and Make
- [n8n](https://docs.firecrawl.dev/integrations/n8n.md): Learn how to use Firecrawl with n8n to give your AI workflows search, scrape, and web interaction capabilities.
- [Pipedream](https://docs.firecrawl.dev/integrations/pipedream.md): Add Firecrawl scrape, crawl, search, map, and extract steps to Pipedream workflows
- [Composio](https://docs.firecrawl.dev/integrations/composio.md): Use Firecrawl tools inside Composio agent workflows
- [SourceSync.ai](https://docs.firecrawl.dev/integrations/sourcesyncai.md): Firecrawl integrates with SourceSync.ai for web scraping capabilities.

### Webhooks

- [Overview](https://docs.firecrawl.dev/webhooks/overview.md): Real-time notifications for your Firecrawl operations
- [Event Types](https://docs.firecrawl.dev/webhooks/events.md): Webhook event reference
- [Security](https://docs.firecrawl.dev/webhooks/security.md): Verify webhook authenticity
- [Testing](https://docs.firecrawl.dev/webhooks/testing.md): Test and debug webhooks

### Use Cases

- [Use Cases](https://docs.firecrawl.dev/use-cases/overview.md): Transform web data into powerful features for your applications
- [AI Platforms](https://docs.firecrawl.dev/use-cases/ai-platforms.md): Power AI assistants and let customers build AI apps
- [Lead Enrichment](https://docs.firecrawl.dev/use-cases/lead-enrichment.md): Extract and filter leads from websites to power your sales pipeline
- [SEO Platforms](https://docs.firecrawl.dev/use-cases/seo-platforms.md): Optimize websites for AI assistants and search engines
- [Deep Research](https://docs.firecrawl.dev/use-cases/deep-research.md): Build agentic research tools with deep web search capabilities

#### View more

- [Product & E-commerce](https://docs.firecrawl.dev/use-cases/product-ecommerce.md): Monitor pricing and track inventory across e-commerce sites
- [Content Generation](https://docs.firecrawl.dev/use-cases/content-generation.md): Generate AI content based on website data, images, and news
- [Developers & MCP](https://docs.firecrawl.dev/use-cases/developers-mcp.md): Build powerful integrations with Model Context Protocol support
- [Investment & Finance](https://docs.firecrawl.dev/use-cases/investment-finance.md): Track companies and extract financial insights from web data
- [Competitive Intelligence](https://docs.firecrawl.dev/use-cases/competitive-intelligence.md): Monitor competitor websites and track changes in real-time
- [Data Migration](https://docs.firecrawl.dev/use-cases/data-migration.md): Transfer web data efficiently between platforms and systems
- [Observability & Monitoring](https://docs.firecrawl.dev/use-cases/observability.md): Monitor websites, track uptime, and detect changes in real-time

### Other

- [Overview](https://docs.firecrawl.dev/dashboard.md): Overview of the Firecrawl dashboard and its key features
- [Debug Firecrawl with Ask](https://docs.firecrawl.dev/features/ask.md): Debug a failed job or any Firecrawl integration issue with an agentic support API

### Contributing

- [Open source or Firecrawl Cloud](https://docs.firecrawl.dev/contributing/open-source-or-cloud.md): Choose between self-hosting Firecrawl for infrastructure control and Firecrawl Cloud for the fastest managed path to production.
- [Contributor setup for Firecrawl](https://docs.firecrawl.dev/contributing/guide.md): Set up the Firecrawl API development environment, verify a local scrape, and run the source-owned test harness before contributing.
- [Self-hosting Firecrawl](https://docs.firecrawl.dev/contributing/self-host.md): Self-host Firecrawl with Docker Compose, verify a local scrape, understand open-source limits, and prepare the stack for production.
