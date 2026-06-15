> Source: https://docs.firecrawl.dev/introduction



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="https://firecrawl.dev" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">Firecrawl Docs home page</span><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=c45b3c967c19a39190e76fe8e9c2ed5a" class="nav-logo w-auto relative object-contain shrink-0 block dark:hidden h-6" alt="light logo" /><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=3fee4abe033bd3c26e8ad92043a91c17" class="nav-logo w-auto relative object-contain shrink-0 hidden dark:block h-6" alt="dark logo" /></a>


Search...


Get Started


Introduction


<a href="/introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor] hover:text-primary dark:hover:text-primary-light text-gray-800 dark:text-gray-200" data-active="true" aria-current="location">Documentation</a>


<a href="/sdks/overview" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">SDKs</a>


<a href="https://www.firecrawl.dev/app" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200" target="_blank" rel="noreferrer">Integrations</a>


<a href="/api-reference/v2-introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">API Reference</a>


<a href="/ai-onboarding" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">Build with AI</a>


Get Started


# Introduction


Copy page


Search the web, scrape any page, and interact with it — all through one API.


Copy page


## 


<a href="#get-started" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## Get your API key


## Try it in the Playground


### 


<a href="#use-firecrawl-with-ai-agents-recommended" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
npx -y firecrawl-cli@latest init --all --browser
```


------------------------------------------------------------------------

## 


<a href="#what-can-firecrawl-do" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## Search


## Scrape


## Interact


### 


<a href="#why-firecrawl" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **LLM-ready output**: Clean markdown, structured JSON, screenshots, and more.
- **Handles the hard stuff**: Proxies, anti-bot, JavaScript rendering, and dynamic content.
- **Reliable**: Built for production with high uptime and consistent results.
- **Fast**: Results in seconds, optimized for high throughput.
- **MCP Server**: Connect Firecrawl to any AI tool via the <a href="/mcp-server" class="link">Model Context Protocol</a>.

------------------------------------------------------------------------

## 


<a href="#search" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

results = firecrawl.search(
    query="firecrawl",
    limit=3,
)
print(results)
```


Response


``` shiki
{
  "success": true,
  "data": {
    "web": [
      {
        "url": "https://www.firecrawl.dev/",
        "title": "Firecrawl - The Web Data API for AI",
        "description": "The web crawling, scraping, and search API for AI. Built for scale. Firecrawl delivers the entire internet to AI agents and builders.",
        "position": 1
      },
      {
        "url": "https://github.com/firecrawl/firecrawl",
        "title": "mendableai/firecrawl: Turn entire websites into LLM-ready ... - GitHub",
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


## 


<a href="#scrape" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

# Scrape a website:
doc = firecrawl.scrape("https://firecrawl.dev", formats=["markdown", "html"])
print(doc)
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
      "ogDescription": "Turn any website into LLM-ready data.",
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


## 


<a href="#interact" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR-API-KEY")

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


Response


``` shiki
{
  "success": true,
  "liveViewUrl": "https://liveview.firecrawl.dev/...",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
  "output": "The iPhone 16 Pro Max (256GB) is priced at $1,199.00.",
  "exitCode": 0,
  "killed": false
}
```


------------------------------------------------------------------------

## 


<a href="#more-capabilities" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## Agent


## Interact


## Webhooks


## Browser Sandbox


## Map


## Crawl


------------------------------------------------------------------------

## 


<a href="#resources" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## API Reference


## SDKs


## Open Source


## Integrations


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/introduction.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/introduction" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


<a href="/sdks/cli" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-end"></a>


Skills + CLI


