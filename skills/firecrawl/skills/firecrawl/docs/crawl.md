> Source: https://docs.firecrawl.dev/features/crawl



<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="https://firecrawl.dev" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">Firecrawl Docs home page</span><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=c45b3c967c19a39190e76fe8e9c2ed5a" class="nav-logo w-auto relative object-contain shrink-0 block dark:hidden h-6" alt="light logo" /><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=3fee4abe033bd3c26e8ad92043a91c17" class="nav-logo w-auto relative object-contain shrink-0 hidden dark:block h-6" alt="dark logo" /></a>


Search...


More


Crawl


<a href="/introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor] hover:text-primary dark:hover:text-primary-light text-gray-800 dark:text-gray-200" data-active="true" aria-current="location">Documentation</a>


<a href="/sdks/overview" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">SDKs</a>


<a href="https://www.firecrawl.dev/app" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200" target="_blank" rel="noreferrer">Integrations</a>


<a href="/api-reference/v2-introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">API Reference</a>


<a href="/ai-onboarding" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">Build with AI</a>


More


# Crawl


Copy page


Recursively crawl a website and get content from every page


Copy page


> ## Documentation Index
>
> Fetch the complete documentation index at: <https://docs.firecrawl.dev/llms.txt>
>
> Use this file to discover all available pages before exploring further.


- Discovers pages via sitemap and recursive link traversal
- Supports path filtering, depth limits, and subdomain/external link control
- Returns results via polling, WebSocket, or webhook


## Try it in the Playground


## 


<a href="#installation" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


CLI


``` shiki
# pip install firecrawl-py

from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")
```


## 


<a href="#basic-usage" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

docs = firecrawl.crawl(url="https://docs.firecrawl.dev", limit=10)
print(docs)
```


### 


<a href="#scrape-options" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')

# Crawl with scrape options
response = firecrawl.crawl('https://example.com',
    limit=100,
    scrape_options={
        'formats': [
            'markdown',
            { 'type': 'json', 'schema': { 'type': 'object', 'properties': { 'title': { 'type': 'string' } } } }
        ],
        'proxy': 'auto',
        'max_age': 600000,
        'only_main_content': True
    }
)
```


## 


<a href="#checking-crawl-status" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
status = firecrawl.get_crawl_status("<crawl-id>")
print(status)
```


### 


<a href="#response-handling" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Scraping


Completed


``` shiki
{
  "status": "scraping",
  "total": 36,
  "completed": 10,
  "creditsUsed": 10,
  "expiresAt": "2024-00-00T00:00:00.000Z",
  "next": "https://api.firecrawl.dev/v2/crawl/123-456-789?skip=10",
  "data": [
    {
      "markdown": "[Firecrawl Docs home page![light logo](https://mintlify.s3-us-west-1.amazonaws.com/firecrawl/logo/light.svg)!...",
      "html": "<!DOCTYPE html><html lang=\"en\" class=\"js-focus-visible lg:[--scroll-mt:9.5rem]\" data-js-focus-visible=\"\">...",
      "metadata": {
        "title": "Build a 'Chat with website' using Groq Llama 3 | Firecrawl",
        "language": "en",
        "sourceURL": "https://docs.firecrawl.dev/learn/rag-llama3",
        "description": "Learn how to use Firecrawl, Groq Llama 3, and Langchain to build a 'Chat with your website' bot.",
        "ogLocaleAlternate": [],
        "statusCode": 200
      }
    },
    ...
  ]
}
```


## 


<a href="#sdk-methods" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#crawl-and-wait" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


``` shiki
from firecrawl import Firecrawl
from firecrawl.types import ScrapeOptions

firecrawl = Firecrawl(api_key="fc-YOUR_API_KEY")

# Crawl a website:
crawl_status = firecrawl.crawl(
  'https://firecrawl.dev', 
  limit=100, 
  scrape_options=ScrapeOptions(formats=['markdown', 'html']),
  poll_interval=30
)
print(crawl_status)
```


Python


Node


``` shiki
success=True
status='completed'
completed=100
total=100
creditsUsed=100
expiresAt=datetime.datetime(2025, 4, 23, 19, 21, 17, tzinfo=TzInfo(UTC))
next=None
data=[
  Document(
    markdown='[Day 7 - Launch Week III.Integrations DayApril 14th to 20th](...',
    metadata={
      'title': '15 Python Web Scraping Projects: From Beginner to Advanced',
      ...
      'scrapeId': '97dcf796-c09b-43c9-b4f7-868a7a5af722',
      'sourceURL': 'https://www.firecrawl.dev/blog/python-web-scraping-projects',
      'url': 'https://www.firecrawl.dev/blog/python-web-scraping-projects',
      'statusCode': 200
    }
  ),
  ...
]
```


### 


<a href="#start-and-check-later" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

job = firecrawl.start_crawl(url="https://docs.firecrawl.dev", limit=10)
print(job)

# Check the status of the crawl
status = firecrawl.get_crawl_status(job.id)
print(status)
```


``` shiki
{
  "success": true,
  "id": "123-456-789",
  "url": "https://api.firecrawl.dev/v2/crawl/123-456-789"
}
```


## 


<a href="#real-time-results-with-websocket" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


``` shiki
import asyncio
from firecrawl import AsyncFirecrawl

async def main():
    firecrawl = AsyncFirecrawl(api_key="fc-YOUR-API-KEY")

    # Start a crawl first
    started = await firecrawl.start_crawl("https://firecrawl.dev", limit=5)

    # Watch updates (snapshots) until terminal status
    async for snapshot in firecrawl.watcher(started.id, kind="crawl", poll_interval=2, timeout=120):
        if snapshot.status == "completed":
            print("DONE", snapshot.status)
            for doc in snapshot.data:
                print("DOC", doc.metadata.source_url if doc.metadata else None)
        elif snapshot.status == "failed":
            print("ERR", snapshot.status)
        else:
            print("STATUS", snapshot.status, snapshot.completed, "/", snapshot.total)

asyncio.run(main())
```


## 


<a href="#webhooks" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/crawl \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer YOUR_API_KEY' \
    -d '{
      "url": "https://docs.firecrawl.dev",
      "limit": 100,
      "webhook": {
        "url": "https://your-domain.com/webhook",
        "metadata": {
          "any_key": "any_value"
        },
        "events": ["started", "page", "completed"]
      }
    }'
```


### 


<a href="#event-types" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Event             | Description                              |
|-------------------|------------------------------------------|
| `crawl.started`   | Fires when the crawl begins              |
| `crawl.page`      | Fires for each page successfully scraped |
| `crawl.completed` | Fires when the crawl finishes            |
| `crawl.failed`    | Fires if the crawl encounters an error   |


### 


<a href="#payload" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "type": "crawl.page",
  "id": "crawl-job-id",
  "data": [...], // Page data for 'page' events
  "metadata": {}, // Your custom metadata
  "error": null
}
```


### 


<a href="#verifying-webhook-signatures" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  Get your webhook secret from the <a href="https://www.firecrawl.dev/app/settings?tab=advanced" class="link" target="_blank" rel="noreferrer">Advanced tab</a> of your account settings
2.  Extract the signature from the `X-Firecrawl-Signature` header
3.  Compute HMAC-SHA256 of the raw request body using your secret
4.  Compare with the signature header using a timing-safe function


## 


<a href="#configuration-reference" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Parameter               | Type       | Default     | Description                                                                                                                                                                                                                                                                                                                                                          |
|-------------------------|------------|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `url`                   | `string`   | (required)  | The starting URL to crawl from                                                                                                                                                                                                                                                                                                                                       |
| `limit`                 | `integer`  | `10000`     | Maximum number of pages to crawl                                                                                                                                                                                                                                                                                                                                     |
| `maxDiscoveryDepth`     | `integer`  | (none)      | Maximum depth from the root URL based on link-discovery hops, not the number of `/` segments in the URL. Each time a new URL is found on a page, it is assigned a depth one higher than the page it was discovered on. The root site and sitemapped pages have a discovery depth of 0. Pages at the max depth are still scraped, but links on them are not followed. |
| `includePaths`          | `string[]` | (none)      | URL pathname regex patterns to include. Only matching paths are crawled.                                                                                                                                                                                                                                                                                             |
| `excludePaths`          | `string[]` | (none)      | URL pathname regex patterns to exclude from the crawl                                                                                                                                                                                                                                                                                                                |
| `regexOnFullURL`        | `boolean`  | `false`     | Match `includePaths`/`excludePaths` against the full URL (including query parameters) instead of just the pathname                                                                                                                                                                                                                                                   |
| `crawlEntireDomain`     | `boolean`  | `false`     | Follow internal links to sibling or parent URLs, not just child paths                                                                                                                                                                                                                                                                                                |
| `allowSubdomains`       | `boolean`  | `false`     | Follow links to subdomains of the main domain                                                                                                                                                                                                                                                                                                                        |
| `allowExternalLinks`    | `boolean`  | `false`     | Follow links to external websites                                                                                                                                                                                                                                                                                                                                    |
| `sitemap`               | `string`   | `"include"` | Sitemap handling: `"include"` (default), `"skip"`, or `"only"`                                                                                                                                                                                                                                                                                                       |
| `ignoreQueryParameters` | `boolean`  | `false`     | Avoid re-scraping the same path with different query parameters                                                                                                                                                                                                                                                                                                      |
| `ignoreRobotsTxt`       | `boolean`  | `false`     | Ignore the website’s robots.txt rules. **Enterprise only** — contact <a href="mailto:support@firecrawl.com" class="link" target="_blank" rel="noreferrer">support@firecrawl.com</a> to enable.                                                                                                                                                                       |
| `robotsUserAgent`       | `string`   | (none)      | Custom User-Agent string for robots.txt evaluation. When set, robots.txt is fetched with this User-Agent and rules are matched against it instead of the default. **Enterprise only** — contact <a href="mailto:support@firecrawl.com" class="link" target="_blank" rel="noreferrer">support@firecrawl.com</a> to enable.                                            |
| `delay`                 | `number`   | (none)      | Delay in seconds between scrapes to respect rate limits. Setting this forces concurrency to 1.                                                                                                                                                                                                                                                                       |
| `maxConcurrency`        | `integer`  | (none)      | Maximum concurrent scrapes. Defaults to your team’s concurrency limit.                                                                                                                                                                                                                                                                                               |
| `scrapeOptions`         | `object`   | (none)      | Options applied to every scraped page (formats, proxy, caching, actions, etc.)                                                                                                                                                                                                                                                                                       |
| `webhook`               | `object`   | (none)      | Webhook configuration for real-time notifications                                                                                                                                                                                                                                                                                                                    |
| `prompt`                | `string`   | (none)      | Natural language prompt to generate crawl options. Explicitly set parameters override generated equivalents.                                                                                                                                                                                                                                                         |


## 


<a href="#important-details" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Sitemap discovery**: By default, the crawler includes the website’s sitemap to discover URLs (`sitemap: "include"`). If you set `sitemap: "skip"`, only pages reachable through HTML links from the root URL are found. Assets like PDFs or deeply nested pages listed in the sitemap but not directly linked from HTML will be missed. For maximum coverage, keep the default setting.
- **Credit usage**: Each page crawled costs 1 credit. JSON mode adds 4 credits per page, enhanced proxy adds 4 credits per page, and PDF parsing costs 1 credit per PDF page.
- **Result expiration**: Job results are available via the API for 24 hours after completion. After that, view results in the <a href="https://www.firecrawl.dev/app/logs" class="link" target="_blank" rel="noreferrer">activity logs</a>.
- **Crawl errors**: The `data` array contains pages Firecrawl successfully scraped. Use the <a href="/api-reference/endpoint/crawl-get-errors" class="link">Get Crawl Errors</a> endpoint to retrieve pages that failed due to network errors, timeouts, or robots.txt blocks.
- **Non-deterministic results**: Crawl results may vary between runs of the same configuration. Pages are scraped concurrently, so the order in which links are discovered depends on network timing and which pages finish loading first. This means different branches of a site may be explored to different extents near the depth boundary, especially at higher `maxDiscoveryDepth` values. To get more deterministic results, set `maxConcurrency` to `1` or use `sitemap: "only"` if the site has a comprehensive sitemap.

> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/crawl.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/crawl" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


<a href="/features/map" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-start"></a>


Map


<a href="/quickstarts/nodejs" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-end"></a>


Node.js


