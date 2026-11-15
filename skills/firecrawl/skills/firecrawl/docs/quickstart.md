> Source: https://docs.firecrawl.dev/introduction



Get Started


# Introduction


The context API for AI agents. Search the web, scrape any page, and interact with it through one API.


## <a href="#get-started" class="anchor-link" aria-label="Navigate to header: Get started"></a><span id="_R_39crmhkd74t9_" class="cursor-pointer">Get started</span>

### <a href="#build-directly-with-the-api" class="anchor-link" aria-label="Navigate to header: Build directly with the API"></a><span id="_R_99crmhkd74t9_" class="cursor-pointer">Build directly with the API</span>


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://firecrawl.dev",
    "formats": ["markdown", "html"]
  }'
```


## <a href="#other-ways-to-get-started" class="anchor-link" aria-label="Navigate to header: Other ways to get started"></a><span id="_R_h9crmhkd74t9_" class="cursor-pointer">Other ways to get started</span>

### <a href="#install-the-firecrawl-cli" class="anchor-link" aria-label="Navigate to header: Install the Firecrawl CLI"></a><span id="_R_j9crmhkd74t9_" class="cursor-pointer">Install the Firecrawl CLI</span>


``` shiki
npx -y firecrawl-cli@latest init --all --browser
```


### <a href="#set-up-with-an-agent" class="anchor-link" aria-label="Navigate to header: Set up with an agent"></a><span id="_R_r9crmhkd74t9_" class="cursor-pointer">Set up with an agent</span>


### <a href="#build-and-test-directly" class="anchor-link" aria-label="Navigate to header: Build and test directly"></a><span id="_R_139crmhkd74t9_" class="cursor-pointer">Build and test directly</span>


## Get your API key


## Try it in the Playground


------------------------------------------------------------------------

## <a href="#what-can-firecrawl-do" class="anchor-link" aria-label="Navigate to header: What can Firecrawl do?"></a><span id="_R_199crmhkd74t9_" class="cursor-pointer">What can Firecrawl do?</span>


## Search


## Scrape


## Interact


### <a href="#why-firecrawl" class="anchor-link" aria-label="Navigate to header: Why Firecrawl?"></a><span id="_R_1d9crmhkd74t9_" class="cursor-pointer">Why Firecrawl?</span>

- **LLM-ready output**: Clean markdown, structured JSON, screenshots, and more.
- **Handles the hard stuff**: Proxies, anti-bot, JavaScript rendering, and dynamic content.
- **Reliable**: Built for production with high uptime and consistent results.
- **Fast**: Results in seconds, optimized for high throughput.
- **MCP Server**: Connect Firecrawl to any AI tool via the <a href="/mcp-server" class="link">Model Context Protocol</a>.


<a href="https://www.firecrawl.dev/survey/uilpn?src=docs-alexandria" class="firecrawl-cta-btn-primary firecrawl-cta-btn-inline"><span data-as="p">Start the interview</span></a>


------------------------------------------------------------------------

## <a href="#search" class="anchor-link" aria-label="Navigate to header: Search"></a><span id="_R_1l9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Search</span>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)

results = firecrawl.search(
    query="firecrawl",
    limit=3,
)
print(results)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: "fc-YOUR-API-KEY",
});

const results = await firecrawl.search('firecrawl', {
  limit: 3,
  scrapeOptions: { formats: ['markdown'] }
});
console.log(results);
```


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
curl -s -X POST "https://api.firecrawl.dev/v2/search" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "firecrawl",
    "limit": 3
  }'
```


``` shiki
# Search the web
firecrawl search "firecrawl web scraping" --limit 5 --pretty
```


Response


``` shiki
{
  "success": true,
  "data": {
    "web": [
      {
        "url": "https://www.firecrawl.dev/",
        "title": "Firecrawl - The context API for AI agents",
        "description": "The web crawling, scraping, and search API for AI. Built for scale. Firecrawl delivers the entire internet to AI agents and builders.",
        "position": 1
      },
      {
        "url": "https://github.com/firecrawl/firecrawl",
        "title": "firecrawl/firecrawl: Turn entire websites into LLM-ready ... - GitHub",
        "description": "Firecrawl is an API service that takes a URL, crawls it, and converts it into clean markdown or structured data.",
        "position": 2
      },
      ...
    ],
    "images": [
      {
        "title": "Quickstart | Firecrawl",
        "imageUrl": "https://mintlify.s3.us-west-1.amazonaws.com/firecrawl/logo/logo.png",
        "imageWidth": 5814,
        "imageHeight": 1200,
        "url": "https://docs.firecrawl.dev/",
        "position": 1
      },
      ...
    ],
    "news": [
      {
        "title": "Y Combinator startup Firecrawl is ready to pay $1M to hire three AI agents as employees",
        "url": "https://techcrunch.com/2025/05/17/y-combinator-startup-firecrawl-is-ready-to-pay-1m-to-hire-three-ai-agents-as-employees/",
        "snippet": "It's now placed three new ads on YC's job board for “AI agents only” and has set aside a $1 million budget total to make it happen.",
        "date": "3 months ago",
        "position": 1
      },
      ...
    ]
  }
}
```


## <a href="#scrape" class="anchor-link" aria-label="Navigate to header: Scrape"></a><span id="_R_1t9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Scrape</span>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)

# Scrape a website:
doc = firecrawl.scrape("https://firecrawl.dev", formats=["markdown", "html"])
print(doc)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: "fc-YOUR-API-KEY",
});

// Scrape a website:
const doc = await firecrawl.scrape('https://firecrawl.dev', { formats: ['markdown', 'html'] });
console.log(doc);
```


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://firecrawl.dev",
    "formats": ["markdown", "html"]
  }'
```


``` shiki
# Scrape a URL and get markdown
firecrawl https://firecrawl.dev

# With multiple formats (returns JSON)
firecrawl https://firecrawl.dev --format markdown,html,links --pretty
```


Response


``` shiki
{
  "success": true,
  "data" : {
    "markdown": "Launch Week I is here! [See our Day 2 Release 🚀](https://www.firecrawl.dev/blog/launch-week-i-day-2-doubled-rate-limits)[💥 Get 2 months free...",
    "html": "<!DOCTYPE html><html lang=\"en\" class=\"light\" style=\"color-scheme: light;\"><body class=\"__variable_36bd41 __variable_d7dc5d font-inter ...",
    "metadata": {
      "title": "Home - Firecrawl",
      "description": "Firecrawl crawls and converts any website into clean markdown.",
      "language": "en",
      "keywords": "Firecrawl,Markdown,Data,Mendable,Langchain",
      "robots": "follow, index",
      "ogTitle": "Firecrawl",
      "ogDescription": "The API to search, scrape, and interact with the web at scale.",
      "ogUrl": "https://www.firecrawl.dev/",
      "ogImage": "https://www.firecrawl.dev/og.png?123",
      "ogLocaleAlternate": [],
      "ogSiteName": "Firecrawl",
      "sourceURL": "https://firecrawl.dev",
      "statusCode": 200,
      "contentType": "text/html"
    }
  }
}
```


## <a href="#interact" class="anchor-link" aria-label="Navigate to header: Interact"></a><span id="_R_259crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Interact</span>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)

# 1. Scrape Amazon's homepage
result = app.scrape("https://www.amazon.com", formats=["markdown"])
scrape_id = result.metadata.scrape_id

# 2. Interact — search for a product and get its price
app.interact(scrape_id, prompt="Search for iPhone 16 Pro Max")
response = app.interact(scrape_id, prompt="Click on the first result and tell me the price")
print(response.output)

# 3. Stop the session
app.stop_interaction(scrape_id)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const app = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: 'fc-YOUR-API-KEY',
});

// 1. Scrape Amazon's homepage
const result = await app.scrape('https://www.amazon.com', { formats: ['markdown'] });
const scrapeId = result.metadata?.scrapeId;

// 2. Interact — search for a product and get its price
await app.interact(scrapeId, { prompt: 'Search for iPhone 16 Pro Max' });
const response = await app.interact(scrapeId, { prompt: 'Click on the first result and tell me the price' });
console.log(response.output);

// 3. Stop the session
await app.stopInteraction(scrapeId);
```


``` shiki
# 1. Scrape Amazon's homepage
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
RESPONSE=$(curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://www.amazon.com", "formats": ["markdown"]}')

SCRAPE_ID=$(echo $RESPONSE | jq -r '.data.metadata.scrapeId')

# 2. Interact — search for a product and get its price
curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Search for iPhone 16 Pro Max"}'

curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Click on the first result and tell me the price"}'

# 3. Stop the session
curl -s -X DELETE "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact"
```


``` shiki
# 1. Scrape Amazon's homepage (scrape ID is saved automatically)
firecrawl scrape https://www.amazon.com

# 2. Interact — search for a product and get its price
firecrawl interact "Search for iPhone 16 Pro Max"
firecrawl interact "Click on the first result and tell me the price"

# 3. Stop the session
firecrawl interact stop
```


Response


``` shiki
{
  "success": true,
  "cdpUrl": "wss://browser.firecrawl.dev/...",
  "liveViewUrl": "https://liveview.firecrawl.dev/...",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
  "output": "The iPhone 16 Pro Max (256GB) is priced at $1,199.00.",
  "exitCode": 0,
  "killed": false
}
```


------------------------------------------------------------------------

## <a href="#more-capabilities" class="anchor-link" aria-label="Navigate to header: More capabilities"></a><span id="_R_2f9crmhkd74t9_" class="cursor-pointer">More capabilities</span>


## Agent


## Interact


## Webhooks


## Browser Sandbox


## Parse


## Map


## Crawl


------------------------------------------------------------------------

## <a href="#resources" class="anchor-link" aria-label="Navigate to header: Resources"></a><span id="_R_2l9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Resources</span>


## API Reference


## SDKs


## Open Source


## Integrations


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/introduction.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/introduction" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


