[Skip to main content](https://docs.firecrawl.dev/features/crawl#content-area)

[Firecrawl Docs home page![light logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=c45b3c967c19a39190e76fe8e9c2ed5a)![dark logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=3fee4abe033bd3c26e8ad92043a91c17)](https://firecrawl.dev/)

v2
![US](https://d3gk2c5xim1je2.cloudfront.net/flags/US.svg)

English

Search...

Ctrl K

Search...

Navigation

More

Crawl

[Documentation](https://docs.firecrawl.dev/introduction) [SDKs](https://docs.firecrawl.dev/sdks/overview) [Integrations](https://www.firecrawl.dev/app) [API Reference](https://docs.firecrawl.dev/api-reference/v2-introduction)

- [Playground](https://firecrawl.dev/playground)
- [Blog](https://firecrawl.dev/blog)
- [Community](https://discord.gg/firecrawl)
- [Changelog](https://firecrawl.dev/changelog)

##### Get Started

- [Introduction](https://docs.firecrawl.dev/introduction)
- [Skill + CLI](https://docs.firecrawl.dev/sdks/cli)
- [MCP Server](https://docs.firecrawl.dev/mcp-server)
- [Advanced Scraping Guide](https://docs.firecrawl.dev/advanced-scraping-guide)
- Plans & Billing


##### Core Endpoints

- [Search](https://docs.firecrawl.dev/features/search)
- Scrape

- [Interact](https://docs.firecrawl.dev/features/interact)

##### More

- [Map](https://docs.firecrawl.dev/features/map)
- [Crawl](https://docs.firecrawl.dev/features/crawl)
- Agent (Research Preview)


##### Quickstarts

- Node.js

- Serverless

- PHP

- Ruby

- Python

- [Go](https://docs.firecrawl.dev/quickstarts/go)
- [Rust](https://docs.firecrawl.dev/quickstarts/rust)
- [Elixir](https://docs.firecrawl.dev/quickstarts/elixir)
- Java

- .NET


##### Developer Guides

- [OpenClaw](https://docs.firecrawl.dev/developer-guides/openclaw)
- [Full-Stack Templates](https://docs.firecrawl.dev/developer-guides/examples)
- Usage Guides

- LLM SDKs and Frameworks

- Cookbooks

- MCP Setup Guides

- Common Sites

- Workflow Automation


##### Webhooks

- [Overview](https://docs.firecrawl.dev/webhooks/overview)
- [Event Types](https://docs.firecrawl.dev/webhooks/events)
- [Security](https://docs.firecrawl.dev/webhooks/security)
- [Testing](https://docs.firecrawl.dev/webhooks/testing)

##### Use Cases

- [Overview](https://docs.firecrawl.dev/use-cases/overview)
- [AI Platforms](https://docs.firecrawl.dev/use-cases/ai-platforms)
- [Lead Enrichment](https://docs.firecrawl.dev/use-cases/lead-enrichment)
- [SEO Platforms](https://docs.firecrawl.dev/use-cases/seo-platforms)
- [Deep Research](https://docs.firecrawl.dev/use-cases/deep-research)
- View more


##### Dashboard

- [Overview](https://docs.firecrawl.dev/dashboard)

##### Contributing

- [Open Source vs Cloud](https://docs.firecrawl.dev/contributing/open-source-or-cloud)
- [Running Locally](https://docs.firecrawl.dev/contributing/guide)
- [Self-hosting](https://docs.firecrawl.dev/contributing/self-host)

On this page

- [Installation](https://docs.firecrawl.dev/features/crawl#installation)
- [Basic usage](https://docs.firecrawl.dev/features/crawl#basic-usage)
- [Scrape options](https://docs.firecrawl.dev/features/crawl#scrape-options)
- [Checking crawl status](https://docs.firecrawl.dev/features/crawl#checking-crawl-status)
- [Response handling](https://docs.firecrawl.dev/features/crawl#response-handling)
- [SDK methods](https://docs.firecrawl.dev/features/crawl#sdk-methods)
- [Crawl and wait](https://docs.firecrawl.dev/features/crawl#crawl-and-wait)
- [Start and check later](https://docs.firecrawl.dev/features/crawl#start-and-check-later)
- [Real-time results with WebSocket](https://docs.firecrawl.dev/features/crawl#real-time-results-with-websocket)
- [Webhooks](https://docs.firecrawl.dev/features/crawl#webhooks)
- [Event types](https://docs.firecrawl.dev/features/crawl#event-types)
- [Payload](https://docs.firecrawl.dev/features/crawl#payload)
- [Verifying webhook signatures](https://docs.firecrawl.dev/features/crawl#verifying-webhook-signatures)
- [Configuration reference](https://docs.firecrawl.dev/features/crawl#configuration-reference)
- [Important details](https://docs.firecrawl.dev/features/crawl#important-details)

![Firecrawl](https://docs.firecrawl.dev/logo/light.svg)![Firecrawl](https://docs.firecrawl.dev/logo/dark.svg)

### Ready to build?

Start getting web data for free and scale seamlessly as your project expands. **No credit card needed.**

[Start for free](https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=start_for_free) [See our plans](https://www.firecrawl.dev/pricing?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=see_our_plans)

Crawl submits a URL to Firecrawl and recursively discovers and scrapes every reachable subpage. It handles sitemaps, JavaScript rendering, and rate limits automatically, returning clean markdown or structured data for each page.

- Discovers pages via sitemap and recursive link traversal
- Supports path filtering, depth limits, and subdomain/external link control
- Returns results via polling, WebSocket, or webhook

[**Try it in the Playground** \\
\\
Test crawling in the interactive playground — no code required.](https://www.firecrawl.dev/playground?endpoint=crawl)

## [​](https://docs.firecrawl.dev/features/crawl\#installation)  Installation

Python

Node

CLI

```
# pip install firecrawl-py

from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")
```

## [​](https://docs.firecrawl.dev/features/crawl\#basic-usage)  Basic usage

Submit a crawl job by calling `POST /v2/crawl` with a starting URL. The endpoint returns a job ID that you use to poll for results.

Python

Node

cURL

CLI

```
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

docs = firecrawl.crawl(url="https://docs.firecrawl.dev", limit=10)
print(docs)
```

Each page crawled consumes 1 credit. The default crawl `limit` is 10,000 pages. Before starting, the crawl endpoint checks that your remaining credits can cover the `limit` — if not, it returns a **402 (Payment Required)** error. Set a lower `limit` to match your intended crawl size (e.g. `limit: 100`) to avoid this. Additional credits apply for certain options: JSON mode costs 4 additional credits per page, enhanced proxy costs 4 additional credits per page, and PDF parsing costs 1 credit per PDF page.

### [​](https://docs.firecrawl.dev/features/crawl\#scrape-options)  Scrape options

All options from the [Scrape endpoint](https://docs.firecrawl.dev/api-reference/endpoint/scrape) are available in crawl via `scrapeOptions` (JS) / `scrape_options` (Python). These apply to every page the crawler scrapes, including formats, proxy, caching, actions, location, and tags.

Python

Node

```
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')

# Crawl with scrape options
response = firecrawl.crawl('https://example.com',
    limit=100,
    scrape_options={
        'formats': [\
            'markdown',\
            { 'type': 'json', 'schema': { 'type': 'object', 'properties': { 'title': { 'type': 'string' } } } }\
        ],
        'proxy': 'auto',
        'max_age': 600000,
        'only_main_content': True
    }
)
```

## [​](https://docs.firecrawl.dev/features/crawl\#checking-crawl-status)  Checking crawl status

Use the job ID to poll for the crawl status and retrieve results.

Python

Node

cURL

CLI

```
status = firecrawl.get_crawl_status("<crawl-id>")
print(status)
```

Job results are available via the API for 24 hours after completion. After this period, you can still view your crawl history and results in the [activity logs](https://www.firecrawl.dev/app/logs).

Pages in the crawl results `data` array are pages that Firecrawl successfully scraped, even if the target site returned an HTTP error like 404. The `metadata.statusCode` field shows the HTTP status code from the target site. To retrieve pages that Firecrawl itself failed to scrape (e.g. network errors, timeouts, or robots.txt blocks), use the dedicated [Get Crawl Errors](https://docs.firecrawl.dev/api-reference/endpoint/crawl-get-errors) endpoint (`GET /crawl/{id}/errors`).

### [​](https://docs.firecrawl.dev/features/crawl\#response-handling)  Response handling

The response varies based on the crawl’s status. For incomplete or large responses exceeding 10MB, a `next` URL parameter is provided. You must request this URL to retrieve the next 10MB of data. If the `next` parameter is absent, it indicates the end of the crawl data.

The `skip` and `next` parameters are only relevant when hitting the API directly.
If you’re using the SDK, pagination is handled automatically and all
results are returned at once.

Scraping

Completed

```
{
  "status": "scraping",
  "total": 36,
  "completed": 10,
  "creditsUsed": 10,
  "expiresAt": "2024-00-00T00:00:00.000Z",
  "next": "https://api.firecrawl.dev/v2/crawl/123-456-789?skip=10",
  "data": [\
    {\
      "markdown": "[Firecrawl Docs home page![light logo](https://mintlify.s3-us-west-1.amazonaws.com/firecrawl/logo/light.svg)!...",\
      "html": "<!DOCTYPE html><html lang=\"en\" class=\"js-focus-visible lg:[--scroll-mt:9.5rem]\" data-js-focus-visible=\"\">...",\
      "metadata": {\
        "title": "Build a 'Chat with website' using Groq Llama 3 | Firecrawl",\
        "language": "en",\
        "sourceURL": "https://docs.firecrawl.dev/learn/rag-llama3",\
        "description": "Learn how to use Firecrawl, Groq Llama 3, and Langchain to build a 'Chat with your website' bot.",\
        "ogLocaleAlternate": [],\
        "statusCode": 200\
      }\
    },\
    ...\
  ]\
}\
```\
\
## [​](https://docs.firecrawl.dev/features/crawl\#sdk-methods)  SDK methods\
\
There are two ways to use crawl with the SDK.\
\
### [​](https://docs.firecrawl.dev/features/crawl\#crawl-and-wait)  Crawl and wait\
\
The `crawl` method waits for the crawl to complete and returns the full response. It handles pagination automatically. This is recommended for most use cases.\
\
Python\
\
Node\
\
```\
from firecrawl import Firecrawl\
from firecrawl.types import ScrapeOptions\
\
firecrawl = Firecrawl(api_key="fc-YOUR_API_KEY")\
\
# Crawl a website:\
crawl_status = firecrawl.crawl(\
  'https://firecrawl.dev',\
  limit=100,\
  scrape_options=ScrapeOptions(formats=['markdown', 'html']),\
  poll_interval=30\
)\
print(crawl_status)\
```\
\
The response includes the crawl status and all scraped data:\
\
Python\
\
Node\
\
```\
success=True\
status='completed'\
completed=100\
total=100\
creditsUsed=100\
expiresAt=datetime.datetime(2025, 4, 23, 19, 21, 17, tzinfo=TzInfo(UTC))\
next=None\
data=[\
  Document(\
    markdown='[Day 7 - Launch Week III.Integrations DayApril 14th to 20th](...',\
    metadata={\
      'title': '15 Python Web Scraping Projects: From Beginner to Advanced',\
      ...\
      'scrapeId': '97dcf796-c09b-43c9-b4f7-868a7a5af722',\
      'sourceURL': 'https://www.firecrawl.dev/blog/python-web-scraping-projects',\
      'url': 'https://www.firecrawl.dev/blog/python-web-scraping-projects',\
      'statusCode': 200\
    }\
  ),\
  ...\
]\
```\
\
### [​](https://docs.firecrawl.dev/features/crawl\#start-and-check-later)  Start and check later\
\
The `startCrawl` / `start_crawl` method returns immediately with a crawl ID. You then poll for status manually. This is useful for long-running crawls or custom polling logic.\
\
Python\
\
Node\
\
cURL\
\
CLI\
\
```\
from firecrawl import Firecrawl\
\
firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")\
\
job = firecrawl.start_crawl(url="https://docs.firecrawl.dev", limit=10)\
print(job)\
\
# Check the status of the crawl\
status = firecrawl.get_crawl_status(job.id)\
print(status)\
```\
\
The initial response returns the job ID:\
\
```\
{\
  "success": true,\
  "id": "123-456-789",\
  "url": "https://api.firecrawl.dev/v2/crawl/123-456-789"\
}\
```\
\
## [​](https://docs.firecrawl.dev/features/crawl\#real-time-results-with-websocket)  Real-time results with WebSocket\
\
The watcher method provides real-time updates as pages are crawled. Start a crawl, then subscribe to events for immediate data processing.\
\
Python\
\
Node\
\
```\
import asyncio\
from firecrawl import AsyncFirecrawl\
\
async def main():\
    firecrawl = AsyncFirecrawl(api_key="fc-YOUR-API-KEY")\
\
    # Start a crawl first\
    started = await firecrawl.start_crawl("https://firecrawl.dev", limit=5)\
\
    # Watch updates (snapshots) until terminal status\
    async for snapshot in firecrawl.watcher(started.id, kind="crawl", poll_interval=2, timeout=120):\
        if snapshot.status == "completed":\
            print("DONE", snapshot.status)\
            for doc in snapshot.data:\
                print("DOC", doc.metadata.source_url if doc.metadata else None)\
        elif snapshot.status == "failed":\
            print("ERR", snapshot.status)\
        else:\
            print("STATUS", snapshot.status, snapshot.completed, "/", snapshot.total)\
\
asyncio.run(main())\
```\
\
## [​](https://docs.firecrawl.dev/features/crawl\#webhooks)  Webhooks\
\
You can configure webhooks to receive real-time notifications as your crawl progresses. This allows you to process pages as they are scraped instead of waiting for the entire crawl to complete.\
\
cURL\
\
```\
curl -X POST https://api.firecrawl.dev/v2/crawl \\
    -H 'Content-Type: application/json' \\
    -H 'Authorization: Bearer YOUR_API_KEY' \\
    -d '{\
      "url": "https://docs.firecrawl.dev",\
      "limit": 100,\
      "webhook": {\
        "url": "https://your-domain.com/webhook",\
        "metadata": {\
          "any_key": "any_value"\
        },\
        "events": ["started", "page", "completed"]\
      }\
    }'\
```\
\
### [​](https://docs.firecrawl.dev/features/crawl\#event-types)  Event types\
\
| Event | Description |\
| --- | --- |\
| `crawl.started` | Fires when the crawl begins |\
| `crawl.page` | Fires for each page successfully scraped |\
| `crawl.completed` | Fires when the crawl finishes |\
| `crawl.failed` | Fires if the crawl encounters an error |\
\
### [​](https://docs.firecrawl.dev/features/crawl\#payload)  Payload\
\
```\
{\
  "success": true,\
  "type": "crawl.page",\
  "id": "crawl-job-id",\
  "data": [...], // Page data for 'page' events\
  "metadata": {}, // Your custom metadata\
  "error": null\
}\
```\
\
### [​](https://docs.firecrawl.dev/features/crawl\#verifying-webhook-signatures)  Verifying webhook signatures\
\
Every webhook request from Firecrawl includes an `X-Firecrawl-Signature` header containing an HMAC-SHA256 signature. Always verify this signature to ensure the webhook is authentic and has not been tampered with.\
\
1. Get your webhook secret from the [Advanced tab](https://www.firecrawl.dev/app/settings?tab=advanced) of your account settings\
2. Extract the signature from the `X-Firecrawl-Signature` header\
3. Compute HMAC-SHA256 of the raw request body using your secret\
4. Compare with the signature header using a timing-safe function\
\
Never process a webhook without verifying its signature first. The `X-Firecrawl-Signature` header contains the signature in the format: `sha256=abc123def456...`\
\
For complete implementation examples in JavaScript and Python, see the [Webhook Security documentation](https://docs.firecrawl.dev/webhooks/security). For comprehensive webhook documentation including detailed event payloads, payload structure, advanced configuration, and troubleshooting, see the [Webhooks documentation](https://docs.firecrawl.dev/webhooks/overview).\
\
## [​](https://docs.firecrawl.dev/features/crawl\#configuration-reference)  Configuration reference\
\
The full set of parameters available when submitting a crawl job:\
\
| Parameter | Type | Default | Description |\
| --- | --- | --- | --- |\
| `url` | `string` | (required) | The starting URL to crawl from |\
| `limit` | `integer` | `10000` | Maximum number of pages to crawl |\
| `maxDiscoveryDepth` | `integer` | (none) | Maximum depth from the root URL based on link-discovery hops, not the number of `/` segments in the URL. Each time a new URL is found on a page, it is assigned a depth one higher than the page it was discovered on. The root site and sitemapped pages have a discovery depth of 0. Pages at the max depth are still scraped, but links on them are not followed. |\
| `includePaths` | `string[]` | (none) | URL pathname regex patterns to include. Only matching paths are crawled. |\
| `excludePaths` | `string[]` | (none) | URL pathname regex patterns to exclude from the crawl |\
| `regexOnFullURL` | `boolean` | `false` | Match `includePaths`/`excludePaths` against the full URL (including query parameters) instead of just the pathname |\
| `crawlEntireDomain` | `boolean` | `false` | Follow internal links to sibling or parent URLs, not just child paths |\
| `allowSubdomains` | `boolean` | `false` | Follow links to subdomains of the main domain |\
| `allowExternalLinks` | `boolean` | `false` | Follow links to external websites |\
| `sitemap` | `string` | `"include"` | Sitemap handling: `"include"` (default), `"skip"`, or `"only"` |\
| `ignoreQueryParameters` | `boolean` | `false` | Avoid re-scraping the same path with different query parameters |\
| `ignoreRobotsTxt` | `boolean` | `false` | Ignore the website’s robots.txt rules. **Enterprise only** — contact [support@firecrawl.com](mailto:support@firecrawl.com) to enable. |\
| `robotsUserAgent` | `string` | (none) | Custom User-Agent string for robots.txt evaluation. When set, robots.txt is fetched with this User-Agent and rules are matched against it instead of the default. **Enterprise only** — contact [support@firecrawl.com](mailto:support@firecrawl.com) to enable. |\
| `delay` | `number` | (none) | Delay in seconds between scrapes to respect rate limits. Setting this forces concurrency to 1. |\
| `maxConcurrency` | `integer` | (none) | Maximum concurrent scrapes. Defaults to your team’s concurrency limit. |\
| `scrapeOptions` | `object` | (none) | Options applied to every scraped page (formats, proxy, caching, actions, etc.) |\
| `webhook` | `object` | (none) | Webhook configuration for real-time notifications |\
| `prompt` | `string` | (none) | Natural language prompt to generate crawl options. Explicitly set parameters override generated equivalents. |\
\
## [​](https://docs.firecrawl.dev/features/crawl\#important-details)  Important details\
\
By default, crawl ignores sublinks that are not children of the URL you provide. For example, `website.com/other-parent/blog-1` would not be returned if you crawled `website.com/blogs/`. Use the `crawlEntireDomain` parameter to include sibling and parent paths. To crawl subdomains like `blog.website.com` when crawling `website.com`, use the `allowSubdomains` parameter.\
\
- **Sitemap discovery**: By default, the crawler includes the website’s sitemap to discover URLs (`sitemap: "include"`). If you set `sitemap: "skip"`, only pages reachable through HTML links from the root URL are found. Assets like PDFs or deeply nested pages listed in the sitemap but not directly linked from HTML will be missed. For maximum coverage, keep the default setting.\
- **Credit usage**: Each page crawled costs 1 credit. JSON mode adds 4 credits per page, enhanced proxy adds 4 credits per page, and PDF parsing costs 1 credit per PDF page.\
- **Result expiration**: Job results are available via the API for 24 hours after completion. After that, view results in the [activity logs](https://www.firecrawl.dev/app/logs).\
- **Crawl errors**: The `data` array contains pages Firecrawl successfully scraped. Use the [Get Crawl Errors](https://docs.firecrawl.dev/api-reference/endpoint/crawl-get-errors) endpoint to retrieve pages that failed due to network errors, timeouts, or robots.txt blocks.\
- **Non-deterministic results**: Crawl results may vary between runs of the same configuration. Pages are scraped concurrently, so the order in which links are discovered depends on network timing and which pages finish loading first. This means different branches of a site may be explored to different extents near the depth boundary, especially at higher `maxDiscoveryDepth` values. To get more deterministic results, set `maxConcurrency` to `1` or use `sitemap: "only"` if the site has a comprehensive sitemap.\
\
> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.\
\
[Suggest edits](https://github.com/firecrawl/firecrawl-docs/edit/main/features/crawl.mdx) [Raise issue](https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&body=Path:%20/features/crawl)\
\
[Map\\
\\
Previous](https://docs.firecrawl.dev/features/map) [Agent\\
\\
Next](https://docs.firecrawl.dev/features/agent)\
\
Ctrl+I\
\
Chat Widget\
\
Loading...