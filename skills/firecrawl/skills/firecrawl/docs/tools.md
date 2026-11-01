> Source: https://docs.firecrawl.dev/mcp-server/tools.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Firecrawl MCP tools

> Choose a Firecrawl MCP tool and understand its availability and operating behavior.

Firecrawl MCP exposes tools for finding, extracting, interacting with, and monitoring web content. Your MCP client receives the exact input schema for every available tool when it connects.

## Tool availability

| Connection mode | Available tools |
| - | - |
| Hosted OAuth | Full tool surface, subject to plan and team policy |
| Hosted API key | Full tool surface, subject to plan and team policy |
| Hosted keyless | `firecrawl_search`, `firecrawl_scrape`, and `firecrawl_parse` |
| Local with the Firecrawl cloud API | API-backed tools; direct local-file Parse is unavailable |
| Local with a self-hosted Firecrawl API | Tools supported by the services enabled in that deployment |

Start with [Get Started](https://docs.firecrawl.dev/mcp-server.md) and pick [For Agents](https://docs.firecrawl.dev/mcp-server/keyless.md) or [For Humans](https://docs.firecrawl.dev/mcp-server/oauth.md). Some optional tools can be disabled by environment or team policy.

## Choose a tool

| Job | Tool | Use it when |
| - | - | - |
| Read one page | `firecrawl_scrape` | You know the URL and need page content or structured fields. |
| Extract structured data | `firecrawl_scrape` with JSON format | You have the URL and want data matching a prompt or JSON schema. |
| Discover site URLs | `firecrawl_map` | You need to find pages before deciding what to extract. |
| Search the web | `firecrawl_search` | You have a query rather than a known URL. |
| Get data from a third-party provider | `firecrawl_find_tools`, then `firecrawl_scrape` with `alexandria` | You need typed records from a provider in the [Alexandria](https://docs.firecrawl.dev/features/alexandria.md) catalogue. Authenticated `firecrawl_search` also returns matching tools in `data.tools`. |
| Parse a file | `firecrawl_parse` | You need content from a PDF, document, spreadsheet, or HTML file. |
| Extract many pages | `firecrawl_crawl` and `firecrawl_check_crawl_status` | You need to traverse a site or section. The crawl tool polls the job to a terminal state before returning. |
| Run autonomous research | `firecrawl_agent` and `firecrawl_agent_status` | The task spans multiple sources and the exact pages are not known. |
| Operate a live page | `firecrawl_interact` and `firecrawl_interact_stop` | You need clicks, form fills, navigation, or dynamic-page extraction. |
| Search scientific literature | `firecrawl_research_*` | You need to find papers, read passages from inside one, or follow citations. Searches the [Research Index](https://docs.firecrawl.dev/features/research.md) of PubMed, bioRxiv, medRxiv, and arXiv paper abstracts. |
| Answer a programming question | `firecrawl_developer_search` | You need primary-source answers from issues, merged pull requests, READMEs, and curated docs. |
| Answer a legal or regulatory question | `firecrawl_gov_search` | You need statutes, regulations, codes, court opinions, or other government publications from the [Firecrawl Government Index](https://docs.firecrawl.dev/features/gov.md). |
| Monitor changes | `firecrawl_monitor_*` | You need recurring checks, diffs, and webhook or email notifications. |
| Send product feedback | `firecrawl_search_feedback` and `firecrawl_feedback` | You want to rate search results or report endpoint-level quality. |

`firecrawl_gov_search` also accepts the optional filters `jurisdiction`, `court`, `courtType`, `cites`, and `domain` (`firecrawl-mcp` 3.34.0 or later). See [Government Index filters](https://docs.firecrawl.dev/features/gov.md#filters).

> [!NOTE]
>
> The former Extract MCP tool is deprecated and is not part of the current tool surface. Use Scrape with JSON format for a known page, or Agent when Firecrawl must discover the sources. See [Choosing the Data Extractor](https://docs.firecrawl.dev/developer-guides/usage-guides/choosing-the-data-extractor.md) for the full comparison.

> [!TIP]
>
> Use the schema shown by your MCP client for the current arguments. The feature guides below explain the underlying Firecrawl behavior without duplicating those schemas here.

## Important behavior

> [accordion] Parse a local file
>
> A local MCP server connected to a self-hosted Firecrawl API can read `filePath` directly. The hosted server cannot read files from your machine, so it uses a two-call handoff:
>
> 1. Call `firecrawl_parse` with `filePath` to receive an upload command and `uploadRef`.
> 2. Run the upload command on the machine that can read the file.
> 3. Call `firecrawl_parse` again with the returned `uploadRef`.
>
> The upload command uses a short-lived signed target and does not contain your Firecrawl API key. Use `firecrawl_scrape` for a public document URL.

> [accordion] Check a running crawl
>
> `firecrawl_crawl` normally starts a crawl and polls it to a terminal state before returning. If that wait times out, resume the job with `firecrawl_check_crawl_status` and the crawl ID. Use the same status tool for a crawl created outside the current MCP call.
>
> `firecrawl_agent` is asynchronous: it returns a job identifier, and `firecrawl_agent_status` checks that job until it completes or fails.

> [accordion] Close Interact sessions
>
> Start with a `url`, or reuse the `scrapeId` from a previous Scrape call. When the workflow is finished, call `firecrawl_interact_stop` with the `scrapeId` to release the session.

> [accordion] Manage monitors safely
>
> The `firecrawl_monitor_*` family creates, lists, updates, runs, and inspects recurring monitors. `firecrawl_monitor_delete` permanently removes a monitor and should be called only when the user explicitly intends to delete it.

> [accordion] Use Alexandria data tools
>
> [Alexandria](https://docs.firecrawl.dev/features/alexandria.md) tools need an authenticated session. Keyless sessions get no Alexandria tools.
>
> 1. **Discover.** Authenticated `firecrawl_search` uses `sources: ["web", "alexandria"]` by default and returns matching tools in `data.tools`. Use `sources: ["alexandria"]` for tools only, or `sources: ["web"]` to omit semantic tool discovery.
> 2. **Inspect.** Call `firecrawl_find_tools` with no arguments to browse categories, then providers, then tools. Use `query` or `urls` to find tools for a task or a website. Use `capabilities` to read the full contract of a tool. Follow the returned `nextTool` for the next step.
> 3. **Run.** Call `firecrawl_scrape` with `alexandria: {provider, capability, options}` instead of `url`. Send an array of up to 10 calls to run them together. Each result in `data.alexandria` has `data` or an `error`.
>
> Discovery is free. Each run costs the price listed on its tool. If a provider needs accepted terms, the tool returns `THIRD_PARTY_DATA_TERMS_REQUIRED` with `requiresAction.url`. Give that URL to an org admin, who accepts the terms in the Firecrawl dashboard. The agent must not accept terms. After the admin confirms, send the same call again.

> [accordion] Enable optional feedback tools
>
> Set `FIRECRAWL_NO_SEARCH_FEEDBACK=1` to prevent `firecrawl_search_feedback` from being registered. Set `FIRECRAWL_NO_ENDPOINT_FEEDBACK=1` to prevent `firecrawl_feedback` from being registered.

## Feature guides

> [card] [Scrape](https://docs.firecrawl.dev/features/scrape.md)
>
> Extract content or structured fields from one URL.

> [card] [Search](https://docs.firecrawl.dev/features/search.md)
>
> Find relevant web, news, image, and developer sources.

> [card] [Research Index](https://docs.firecrawl.dev/features/research.md)
>
> Search papers, read passages, and follow citations.

> [card] [Developer Index](https://docs.firecrawl.dev/features/developer.md)
>
> Answer coding questions from issues, PRs, READMEs, and docs.

> [card] [Government Index](https://docs.firecrawl.dev/features/gov.md)
>
> Search statutes, regulations, codes, and court opinions.

> [card] [Crawl](https://docs.firecrawl.dev/features/crawl.md)
>
> Traverse and extract a site or section.

> [card] [Parse](https://docs.firecrawl.dev/features/parse.md)
>
> Convert files into LLM-ready output.

> [card] [Interact](https://docs.firecrawl.dev/features/interact.md)
>
> Operate dynamic pages in a live browser session.

> [card] [Agent](https://docs.firecrawl.dev/features/agent.md)
>
> Run autonomous multi-source research.

> [card] [Monitoring](https://docs.firecrawl.dev/features/monitoring.md)
>
> Track page changes and receive notifications.

> [card] [Alexandria](https://docs.firecrawl.dev/features/alexandria.md)
>
> Find and run data tools from third-party providers.

## Troubleshooting

* **A tool is missing:** confirm the connection mode on [Get Started](https://docs.firecrawl.dev/mcp-server.md), reconnect or restart the client, and check whether team policy disables optional tools.
* **The client returns `401`:** check the configured server URL first.
  * If the configured URL is `/v2/mcp-oauth`, sign in again through the client.
  * If it is `/v2/mcp`, either replace the API key on that server or update the existing server URL to `/v2/mcp-oauth` and complete sign-in.
  * Start a new client session after either change.
* **The client is rate-limited:** review the current [rate limits](https://docs.firecrawl.dev/rate-limits.md), wait for the retry interval, or move from keyless to authenticated access.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
