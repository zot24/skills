> Source: https://docs.firecrawl.dev/ai-onboarding.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Build with AI

> Everything you need to onboard your AI agent to Firecrawl.

If you're developing with AI, Firecrawl offers several resources to improve your experience. Firecrawl ships with **skills** — self-contained knowledge packs that AI coding agents discover and use automatically. One install command gives agents CLI skills for live web work and workflow skills for producing repeatable deliverables. Build skills for integrating Firecrawl into application code are a separate step (`firecrawl setup build`). Firecrawl users can get an API key in two ways. See [Get credentials](#get-credentials) below.

* [Get credentials](#get-credentials)
* [CLI and agent skills](#cli)
* [Using Firecrawl as a Tool](#using-firecrawl-as-a-tool)
* [Agentic Debugging](#agentic-debugging)
* [Firecrawl MCP Server](#firecrawl-mcp-server)
* [Firecrawl Docs for Agents](#firecrawl-docs-for-agents)
* [Quick Start Guides](#quick-start-guides)
* [Agent Harnesses](#agent-harnesses)
* [SDKs](#sdks)

## Get credentials

Firecrawl users can get an API key in two ways. Most users should sign in through the dashboard or CLI. If your agent platform supports WorkOS ID-JAG, it can register directly with Firecrawl.

**Which should I use?** Use the dashboard or CLI unless you know your platform supports WorkOS ID-JAG.

**How you might arrive:**

* **Docs:** you landed here. Pick the option below that matches how you can sign in.
* **API `401`:** ID-JAG capable agents can follow the discovery flow in [`auth.md`](https://www.firecrawl.dev/auth.md) Step 1. Everyone else should use the dashboard or CLI.
* **Direct URL:** follow [`SKILL.md`](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for browser sign-in and setup, or [`auth.md`](https://www.firecrawl.dev/auth.md) for WorkOS ID-JAG registration.
* **Stripe Projects:** in a project that already uses the Stripe CLI, `stripe projects add firecrawl/api --name firecrawl` provisions the account and writes `FIRECRAWL_API_KEY` to `.env`. See [Stripe Projects](https://docs.firecrawl.dev/integrations/stripe-projects.md).

> [card] [Use the dashboard or CLI](https://www.firecrawl.dev/agent-onboarding/SKILL.md)
>
> **Default for most users.** Sign in in the browser, run CLI `--browser`, install skills and MCP, or create an API key in the dashboard.

> [card] [Register with WorkOS ID-JAG](https://docs.firecrawl.dev/ai-onboarding/agent-auth.md)
>
> **For supported agent platforms.** Use this when your platform can mint a WorkOS ID-JAG for Firecrawl. Review [Agent Auth](https://docs.firecrawl.dev/ai-onboarding/agent-auth.md), then follow [`auth.md`](https://www.firecrawl.dev/auth.md).

**Can't sign in or get a key?** The CLI, SDKs, and REST API allow keyless search, scrape, interact, and parse. Hosted MCP exposes the narrower keyless Search, Scrape, and Parse surface; interact requires an account connection or API key there. Keyless access is rate-limited and meant as a fallback, so move to a free account or API key as soon as one is available. See [Keyless (no API key)](https://docs.firecrawl.dev/rate-limits.md#keyless-no-api-key) for details.

Once you have an API key, continue with [CLI and agent skills](#cli) below.

## CLI and agent skills

The [Firecrawl CLI](https://docs.firecrawl.dev/sdks/cli.md) lets your agent search, scrape, interact, crawl, map, and run agent jobs from the terminal. It's built for humans, AI agents, and CI/CD pipelines.

The Firecrawl **skills** are self-contained knowledge packs that AI coding agents like Codex, Claude Code, Cursor, and OpenCode discover and use automatically. A single install command sets up the CLI tools for live web work and the workflow skills for producing repeatable deliverables. Build skills for integrating Firecrawl into application code are installed with `firecrawl setup build`:

```bash theme={null}
npx -y firecrawl-cli@latest init --all --browser
```

* `--all` skips agent selection and initializes every detected agent
* `--browser` opens the browser for Firecrawl authentication automatically
* `--skip-auth`, `--skip-install`, `--skip-skills`, and `--agent <name>` are also available. See `firecrawl init --help`.

After install, verify everything is working:

```bash theme={null}
firecrawl --status
firecrawl scrape "https://firecrawl.dev"
```

To reinstall or scope to a specific agent later:

```bash theme={null}
firecrawl setup skills      # CLI / core skills
firecrawl setup build       # build skills
firecrawl setup workflows   # workflow skills
```

### What the install gives you

Firecrawl skills cover three categories. `init` installs CLI and workflow skills. Run `firecrawl setup build` for build skills. Each segment lives in its own repo so it can evolve independently:

* [`firecrawl/cli`](https://github.com/firecrawl/cli) — CLI skills for live web work
* [`firecrawl/skills`](https://github.com/firecrawl/skills) — build skills for app integration
* [`firecrawl/firecrawl-workflows`](https://github.com/firecrawl/firecrawl-workflows) — workflow skills for repeatable deliverables

**CLI skills** — for live web work during an agent session:

| Skill | Purpose |
| - | - |
| `firecrawl` | Overall CLI command workflow |
| `firecrawl-search` | Search the web and discover pages |
| `firecrawl-scrape` | Extract clean content from a known URL |
| `firecrawl-interact` | Interact with scraped pages using prompts or code |
| `firecrawl-crawl` | Bulk-extract content from an entire site |
| `firecrawl-map` | Discover all URLs on a domain |
| `firecrawl-agent` | Run autonomous web data gathering with a job |
| `firecrawl-monitor` | Detect site changes and get notified |
| `firecrawl-parse` | Parse local documents into markdown |
| `firecrawl-download` | Download a site as local files |
| `firecrawl-research-index` | Search papers, read passages, and follow citations |
| `firecrawl-developer-index` | Search issues, pull requests, READMEs, and docs |

The install above includes both index skills. To add just the paper-search one to an existing setup — worth doing when the work is biomedical or scientific literature — run:

```bash theme={null}
npx skills add firecrawl/skills@firecrawl-research-index
```

**Build skills** — for integrating Firecrawl into application code:

| Skill | Purpose |
| - | - |
| `firecrawl-build` | Choose the right Firecrawl endpoint for your product |
| `firecrawl-build-onboarding` | Auth and project setup |
| `firecrawl-build-scrape` | Implement scraping in app code |
| `firecrawl-build-search` | Implement search in app code |
| `firecrawl-build-interact` | Implement page interaction in app code |

**Workflow skills** — outcome-focused skills that produce a concrete deliverable from Firecrawl web data:

| Skill | Outcome |
| - | - |
| `firecrawl-workflows` | Umbrella skill for choosing the right workflow |
| `firecrawl-deep-research` | Multi-source sourced research reports |
| `firecrawl-seo-audit` | Site maps, on-page SEO checks, SERP comparison, and prioritized fixes |
| `firecrawl-lead-research` | Pre-meeting company and person intelligence briefs |
| `firecrawl-lead-gen` | Prospect list generation from databases and directories |
| `firecrawl-qa` | Live-site QA reports with issues and reproduction steps |
| `firecrawl-competitive-intel` | Recurring pricing, feature, and changelog monitoring |
| `firecrawl-market-research` | Market, financial, earnings, and industry research |
| `firecrawl-research-papers` | Literature reviews from papers, PDFs, and whitepapers |
| `firecrawl-company-directories` | Directory extraction into structured company lists |
| `firecrawl-dashboard-reporting` | Metrics extraction from dashboards and internal web tools |
| `firecrawl-knowledge-base` | LLM-ready reference docs, RAG chunks, training data, or docs mirrors |
| `firecrawl-knowledge-ingest` | Auth-gated or JS-heavy docs portal ingestion |
| `firecrawl-demo-walkthrough` | Product flow walkthroughs and UX teardown reports |
| `firecrawl-shop` | Product research and shopping recommendations |
| `firecrawl-website-design-clone` | Extract a website's design system into an agent-ready `DESIGN.md` |

### Choose your path

CLI and workflow skills come from the install above. Build skills are a separate step: `firecrawl setup build`. The difference is what happens next:

**1. Live web tools (CLI skills)**

Use this when you need web data during your current session — searching the web, scraping known URLs, interacting with scraped pages, crawling docs, mapping a site, or running an agent job.

The default flow:

1. Start with **search** when you need discovery
2. Move to **scrape** when you have a URL
3. Use **interact** when the scraped page needs follow-up actions
4. Use **map** or **crawl** when you need many URLs or pages
5. Use **agent** when the task is open-ended and needs autonomous discovery

```bash theme={null}
# Search the web
firecrawl search "best open-source web crawlers"

# Scrape a page into clean markdown
firecrawl scrape https://docs.firecrawl.dev

# Crawl a whole site
firecrawl crawl https://docs.firecrawl.dev
```

**2. App integration (Build skills)**

Use this when you're building an application, agent, or workflow that calls the Firecrawl API from code. Install the build skills with `firecrawl setup build`. They help with picking the right endpoint, wiring up the SDK, and running a smoke test.

The agent answers one key question — *what should Firecrawl do in the product?* — and the build skills route to `/search`, `/scrape`, `/interact`, `/parse`, `/crawl`, `/map`, or `/agent` accordingly.

**3. Repeatable deliverables (Workflow skills)**

Use this when the goal is a finished artifact — a research report, SEO audit, QA report, lead list, knowledge base, competitive intel digest, or a cloned design system — not raw web data or product code.

Workflow skills infer from context first and only ask short clarifying questions when an input would block the work. They also call out independently parallelizable units so sub-agents can fan out across competitors, pages, or sources.

Pick a workflow directly, or let the umbrella `firecrawl-workflows` skill route the request:

```bash theme={null}
# Multi-source research brief on a topic
"Use firecrawl-deep-research to write a brief on AI agent frameworks"

# Pre-meeting intelligence for a sales call
"Use firecrawl-lead-research to brief me on stripe.com before my 3pm call"

# On-page SEO audit with prioritized fixes
"Use firecrawl-seo-audit on https://example.com"

# Clone a site's design system into DESIGN.md
"Use firecrawl-website-design-clone on https://linear.app"
```

**4. REST API (no install needed)**

If you prefer not to install anything, agents can call the Firecrawl REST API directly. Set the API key and hit the endpoints:

* `POST https://api.firecrawl.dev/v2/search` — discover pages by query
* `POST https://api.firecrawl.dev/v2/scrape` — extract clean markdown from a URL
* `POST https://api.firecrawl.dev/v2/scrape/{scrapeId}/interact` — interact with a scraped page
* `POST https://api.firecrawl.dev/v2/crawl` — bulk-extract an entire site
* `POST https://api.firecrawl.dev/v2/map` — discover URLs on a domain
* `POST https://api.firecrawl.dev/v2/agent` — run autonomous web data gathering

Auth header: `Authorization: Bearer fc-YOUR_API_KEY`

The full onboarding definitions live at:

* Browser sign-in, CLI setup, skills, MCP, and dashboard keys: [`firecrawl.dev/agent-onboarding/SKILL.md`](https://www.firecrawl.dev/agent-onboarding/SKILL.md)
* Agent registration with WorkOS ID-JAG: [`firecrawl.dev/auth.md`](https://www.firecrawl.dev/auth.md)

Agents can fetch either doc directly: use [`agent-onboarding/SKILL.md`](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for human-in-the-loop CLI/browser onboarding, or [`auth.md`](https://www.firecrawl.dev/auth.md) for WorkOS ID-JAG registration.

> [card] [CLI skills](https://github.com/firecrawl/cli)
>
> Live web work during an agent session — search, scrape, interact, map, crawl, and run agent jobs from the terminal.

> [card] [Build skills](https://github.com/firecrawl/skills)
>
> Integrate Firecrawl into application code — pick the right endpoint, wire up the SDK, and ship a verified integration.

> [card] [Workflow skills](https://github.com/firecrawl/firecrawl-workflows)
>
> Produce repeatable deliverables — research briefs, SEO audits, QA reports, lead lists, knowledge bases, and design clones.

## Using Firecrawl as a Tool

Firecrawl gives agents five core tools for working with the web. Each tool maps to an API endpoint and a CLI command. Agents pick the right tool based on what they need:

> [accordion] Search — discover pages by query
>
> Start here when you don't have a URL yet. Search returns relevant web pages for a natural-language query, with optional full-page content included in the results.
>
> ```bash
> # CLI
> firecrawl search "latest OpenAI API pricing"
> ```
>
> ```bash
> # REST API
> curl -X POST https://api.firecrawl.dev/v2/search \
>   -H "Authorization: Bearer fc-YOUR_API_KEY" \
>   -H "Content-Type: application/json" \
>   -d '{"query": "latest OpenAI API pricing"}'
> ```
>
> **When to use:** General web research, finding documentation, competitive analysis, answering questions that require up-to-date web information.
>
> **When not to use:** Scientific literature. To find papers, read passages from inside one, or follow citations, use the [Research Index](https://docs.firecrawl.dev/features/research.md) instead — the `firecrawl_research_*` MCP tools, `firecrawl research search-papers` on the CLI, or the `firecrawl-research-index` skill. Search returns web page snippets; the Research Index returns paper records with full abstracts.

> [accordion] Scrape — extract content from a URL
>
> Use this when you already have a URL and need clean, LLM-ready content. Scrape converts any web page into markdown, HTML, or structured data — handling JavaScript rendering, anti-bot measures, and messy HTML automatically.
>
> ```bash
> # CLI
> firecrawl scrape https://docs.stripe.com/api/charges
> ```
>
> ```bash
> # REST API
> curl -X POST https://api.firecrawl.dev/v2/scrape \
>   -H "Authorization: Bearer fc-YOUR_API_KEY" \
>   -H "Content-Type: application/json" \
>   -d '{"url": "https://docs.stripe.com/api/charges"}'
> ```
>
> **When to use:** Reading documentation, extracting article content, pulling data from a known page, converting web pages to context for LLMs.

> [accordion] Crawl — bulk-extract an entire site
>
> Crawl recursively follows links from a starting URL and scrapes every page it finds. Use it when you need content from an entire site or documentation set, not just a single page.
>
> ```bash
> # CLI
> firecrawl crawl https://docs.firecrawl.dev --limit 50
> ```
>
> ```bash
> # REST API
> curl -X POST https://api.firecrawl.dev/v2/crawl \
>   -H "Authorization: Bearer fc-YOUR_API_KEY" \
>   -H "Content-Type: application/json" \
>   -d '{"url": "https://docs.firecrawl.dev", "limit": 50}'
> ```
>
> **When to use:** Ingesting full documentation sites, building knowledge bases, migrating content, training data collection.

> [accordion] Map — discover all URLs on a domain
>
> Map rapidly discovers every indexed URL on a domain without scraping the content. Use it when you need to understand a site's structure or find specific pages before scraping them.
>
> ```bash
> # CLI
> firecrawl map https://docs.firecrawl.dev
> ```
>
> ```bash
> # REST API
> curl -X POST https://api.firecrawl.dev/v2/map \
>   -H "Authorization: Bearer fc-YOUR_API_KEY" \
>   -H "Content-Type: application/json" \
>   -d '{"url": "https://docs.firecrawl.dev"}'
> ```
>
> **When to use:** Site audits, finding specific pages on a large site, understanding site structure before a targeted crawl.

> [accordion] Interact — work with a scraped page
>
> Interact lets agents continue from a scrape using prompts or code. Use it when a scraped page requires clicks, form fills, navigation, or follow-up extraction.
>
> ```bash
> # CLI
> firecrawl scrape https://example.com
> firecrawl interact "Click the pricing tab and extract the plan names"
> ```
>
> ```bash
> # REST API
> # scrapeId comes from the scrape response (data.metadata.scrapeId)
> curl -X POST https://api.firecrawl.dev/v2/scrape/SCRAPE_ID/interact \
>   -H "Authorization: Bearer fc-YOUR_API_KEY" \
>   -H "Content-Type: application/json" \
>   -d '{"prompt": "Click the pricing tab and extract the plan names"}'
> ```
>
> **When to use:** Continuing from a scrape, navigating dynamic pages, filling forms, and extracting data after page actions.

### How agents chain tools together

Most agent workflows combine multiple tools. A typical pattern:

1. **Search** to find relevant pages → get a list of URLs
2. **Scrape** the most relevant URLs → get clean content
3. **Interact** when the scraped page needs follow-up actions
4. **Agent** when the task needs autonomous discovery or structured multi-page extraction

For bulk work, agents use **Map** to discover URLs first, then **Crawl** or selectively **Scrape** the pages they need.

## Agentic Debugging

When a Firecrawl call fails or returns unexpected results, your agent doesn't have to escalate to a human. The [`/support/ask`](https://docs.firecrawl.dev/api-reference/endpoint/ask) endpoint is an AI support agent built for **agent-to-agent** communication — it diagnoses issues with your jobs, account, and API usage, then returns a verified answer with machine-readable fix parameters your agent can apply directly.

Wire it into your agent's error-handling flow so it can self-recover from scraping failures, crawl issues, and configuration problems — typically in 15–30 seconds, no human in the loop.

### How it works

1. **Your agent describes the problem** — a natural-language question describing the issue.
2. **The support agent investigates** — it inspects job logs, account state, documentation, and source code.
3. **The support agent validates** — when possible, it tests a fix against the live Firecrawl API (e.g., retrying a scrape with adjusted parameters).
4. **Your agent gets a verified answer** — a prose `answer`, machine-readable `fixParameters` to apply directly, and `validation` results showing whether the fix was tested.

### Example

Send a question, plus an optional `rationale` to give the support agent context about what your end user is trying to accomplish:

```bash theme={null}
curl -X POST https://api.firecrawl.dev/v2/support/ask \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "my crawl returned 3 pages but I expected 50",
    "rationale": "user is on their third failed crawl attempt today"
  }'
```

The response includes an `answer`, a `confidence` rating, optional `fixParameters` (e.g., `{"waitFor": 5000}`) your agent can pass to the next call, and `validation` showing whether the fix was tested against the live API.

> [card] [Ask endpoint reference](https://docs.firecrawl.dev/api-reference/endpoint/ask.md)
>
> Full request and response schema for `/support/ask`, including status codes and the feedback envelope returned when the agent gets stuck.

## Firecrawl MCP Server

MCP is an open protocol that lets compatible applications give models access to tools. The open-source [Firecrawl MCP server](https://github.com/firecrawl/firecrawl-mcp-server) supports search, scraping, browsing, crawling, mapping, structured extraction through Scrape JSON, and autonomous Agent jobs.

> [card] [Choose an MCP connection](https://docs.firecrawl.dev/mcp-server.md)
>
> Try keyless access, sign in through an interactive client, or configure an API key for agents, CI, and backend services.

## Firecrawl Docs for Agents

You can give your agent current Firecrawl docs in a context-aware way. Agents can self-onboard by pulling these resources directly — no human wiring required.

**1. Get credentials**

Start at [Get credentials](https://docs.firecrawl.dev/ai-onboarding.md#get-credentials) to choose between dashboard/CLI setup and WorkOS ID-JAG registration. For ID-JAG registration, follow [`auth.md`](https://www.firecrawl.dev/auth.md).

**2. Markdown docs**

Every page has a markdown version. Append `.md` to any docs URL, or use the page action menu to copy the page as markdown.

```
Docs for this page: https://docs.firecrawl.dev/ai-onboarding.md
```

**3. Full llms.txt**

Give your agent all of our docs in a single file.

```
Here are the Firecrawl docs: https://docs.firecrawl.dev/llms-full.txt
```

A shorter index is also available at `https://docs.firecrawl.dev/llms.txt`.

**4. MCP docs server**

For a structured approach using MCP tools, connect the Firecrawl MCP server in Codex, Cursor, Claude Code, Claude Desktop, or another compatible client. Start with the [MCP setup chooser](https://docs.firecrawl.dev/mcp-server.md). Windsurf users should follow the [Windsurf quickstart](https://docs.firecrawl.dev/quickstarts/windsurf.md).

**5. Copy to ChatGPT / Claude**

Every page includes a contextual action menu (copy, view as markdown, open in ChatGPT, open in Claude) so agents and humans can move pages between tools in one click.

## Quick Start Guides

Drop-in quickstarts for the stacks agents build on most often. Point your agent at any of these to scaffold a working Firecrawl integration end-to-end.

Prefer to let Cursor drive? One-click install the Firecrawl MCP server and start prompting in Cursor:

[![Open in Cursor — Add Firecrawl MCP server](https://cursor.com/deeplink/mcp-install-dark.png)](cursor://anysphere.cursor-deeplink/mcp/install?name=firecrawl\&config=eyJ1cmwiOiJodHRwczovL21jcC5maXJlY3Jhd2wuZGV2L3YyL21jcCJ9)

> [card] [Node.js](https://docs.firecrawl.dev/quickstarts/nodejs.md)
>
> Server-side JavaScript and TypeScript with the Firecrawl Node SDK.

> [card] [Next.js](https://docs.firecrawl.dev/quickstarts/nextjs.md)
>
> Scrape, search, and crawl from Next.js route handlers and server actions.

> [card] [Python](https://docs.firecrawl.dev/quickstarts/python.md)
>
> Use Firecrawl from scripts, notebooks, and backend services.

> [card] [FastAPI](https://docs.firecrawl.dev/quickstarts/fastapi.md)
>
> Build async Python APIs that search, scrape, and extract.

> [card] [Cloudflare Workers](https://docs.firecrawl.dev/quickstarts/cloudflare-workers.md)
>
> Run Firecrawl at the edge with Workers.

> [card] [Vercel Functions](https://docs.firecrawl.dev/quickstarts/vercel-functions.md)
>
> Call Firecrawl from Vercel serverless functions.

> [card] [AWS Lambda](https://docs.firecrawl.dev/quickstarts/aws-lambda.md)
>
> Invoke Firecrawl from Lambda handlers.

> [card] [Supabase Edge Functions](https://docs.firecrawl.dev/quickstarts/supabase-edge-functions.md)
>
> Use Firecrawl inside Supabase Deno runtime.

> [card] [Go](https://docs.firecrawl.dev/quickstarts/go.md)
>
> Idiomatic Go SDK for search, scrape, and crawl.

> [card] [Rust](https://docs.firecrawl.dev/quickstarts/rust.md)
>
> Typed Rust SDK for Firecrawl.

> [card] [Laravel](https://docs.firecrawl.dev/quickstarts/laravel.md)
>
> Add Firecrawl to Laravel apps via the PHP SDK.

> [card] [Rails](https://docs.firecrawl.dev/quickstarts/rails.md)
>
> Drop Firecrawl into Ruby on Rails.

See the full list of quickstarts (Express, NestJS, Fastify, Hono, Bun, Remix, Nuxt, SvelteKit, Astro, Mastra, Django, Flask, Elixir, Java, Spring Boot, .NET, ASP.NET Core, and more) in the left sidebar.

## Agent Harnesses

Firecrawl works with the runtimes and frameworks agents actually live inside — coding agents, agent SDKs, and model aggregators. Most coding harnesses can auto-discover the Firecrawl skills via `npx -y firecrawl-cli@latest init --all --browser`; the rest call Firecrawl as a tool over MCP or the REST API.

> [card] [Claude Code](https://docs.firecrawl.dev/quickstarts/claude-code.md)
>
> Anthropic's CLI — set up Firecrawl MCP in Claude Code.

> [card] [Cursor](https://docs.firecrawl.dev/quickstarts/cursor.md)
>
> IDE agent — one-click install Firecrawl MCP in Cursor.

> [card] [OpenCode](https://docs.firecrawl.dev/quickstarts/opencode.md)
>
> Wire Firecrawl MCP into OpenCode.

> [card] [Codex CLI](https://docs.firecrawl.dev/quickstarts/codex-cli.md)
>
> Wire Firecrawl MCP into OpenAI Codex CLI.

> [card] [Grok Build](https://docs.firecrawl.dev/quickstarts/grok-build.md)
>
> Wire Firecrawl MCP into xAI Grok Build.

> [card] [OpenRouter](https://docs.firecrawl.dev/quickstarts/openrouter.md)
>
> Pair any OpenRouter model with Firecrawl web tools.

> [card] [Amp](https://docs.firecrawl.dev/quickstarts/amp.md)
>
> Wire Firecrawl MCP into Sourcegraph Amp.

> [card] [Windsurf](https://docs.firecrawl.dev/quickstarts/windsurf.md)
>
> Agentic IDE — set up Firecrawl MCP in Windsurf.

> [card] [Antigravity](https://docs.firecrawl.dev/quickstarts/antigravity.md)
>
> Add Firecrawl MCP to Google's agentic IDE.

> [card] [Gemini CLI](https://docs.firecrawl.dev/quickstarts/gemini-cli.md)
>
> Wire Firecrawl MCP into Google Gemini CLI.

> [card] [Nous Research](https://docs.firecrawl.dev/quickstarts/nous-research.md)
>
> Use Firecrawl as a tool with Hermes models.

> [card] [AutoGen](https://docs.firecrawl.dev/quickstarts/autogen.md)
>
> Firecrawl tools inside Microsoft AutoGen multi-agent teams.

## SDKs

Official, typed SDKs covering the full Firecrawl API surface. Point your agent at the language matching your stack.

> [card] [Python](https://docs.firecrawl.dev/sdks/python.md)

> [card] [Node](https://docs.firecrawl.dev/sdks/node.md)

> [card] [Go](https://docs.firecrawl.dev/sdks/go.md)

> [card] [Java](https://docs.firecrawl.dev/sdks/java.md)

> [card] [Ruby](https://docs.firecrawl.dev/sdks/ruby.md)

> [card] [Rust](https://docs.firecrawl.dev/sdks/rust.md)

> [card] [.NET](https://docs.firecrawl.dev/sdks/dotnet.md)

> [card] [PHP](https://docs.firecrawl.dev/sdks/php.md)

> [card] [Elixir](https://docs.firecrawl.dev/sdks/elixir.md)

> [card] [CLI](https://docs.firecrawl.dev/sdks/cli.md)

Firecrawl also has first-class SDK bindings for the major LLM SDKs and agent frameworks — see [LLM SDKs and Frameworks](https://docs.firecrawl.dev/developer-guides/llm-sdks-and-frameworks/openai.md) for OpenAI, Anthropic, Gemini, Google ADK, Vercel AI SDK, LangChain, LangGraph, LlamaIndex, Mastra, and ElevenAgents.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
