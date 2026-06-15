> Source: https://docs.firecrawl.dev/features/batch-scrape



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="https://firecrawl.dev" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">Firecrawl Docs home page</span><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=c45b3c967c19a39190e76fe8e9c2ed5a" class="nav-logo w-auto relative object-contain shrink-0 block dark:hidden h-6" alt="light logo" /><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=3fee4abe033bd3c26e8ad92043a91c17" class="nav-logo w-auto relative object-contain shrink-0 hidden dark:block h-6" alt="dark logo" /></a>


Search...


Scrape


Batch Scrape


<a href="/introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor] hover:text-primary dark:hover:text-primary-light text-gray-800 dark:text-gray-200" data-active="true" aria-current="location">Documentation</a>


<a href="/sdks/overview" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">SDKs</a>


<a href="https://www.firecrawl.dev/app" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200" target="_blank" rel="noreferrer">Integrations</a>


<a href="/api-reference/v2-introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">API Reference</a>


<a href="/ai-onboarding" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">Build with AI</a>


Scrape


# Batch Scrape


Copy page


Scrape multiple URLs in a single batch job


Copy page


- Works like `/crawl` but for an explicit list of URLs
- Synchronous and asynchronous modes
- Supports all scrape options including structured extraction
- Configurable concurrency per job

## 


<a href="#how-it-works" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Mode         | SDK method (JS / Python)                  | Behavior                                                         |
|--------------|-------------------------------------------|------------------------------------------------------------------|
| Synchronous  | `batchScrape` / `batch_scrape`            | Starts the batch and waits for completion, returning all results |
| Asynchronous | `startBatchScrape` / `start_batch_scrape` | Starts the batch and returns a job ID for polling or webhooks    |


## 


<a href="#basic-usage" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

start = firecrawl.start_batch_scrape([
    "https://firecrawl.dev",
    "https://docs.firecrawl.dev",
], formats=["markdown"])  # returns id

job = firecrawl.batch_scrape([
    "https://firecrawl.dev",
    "https://docs.firecrawl.dev",
], formats=["markdown"], poll_interval=2, wait_timeout=120)

print(job.status, job.completed, job.total)
```


### 


<a href="#response" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "status": "completed",
  "total": 36,
  "completed": 36,
  "creditsUsed": 36,
  "expiresAt": "2024-00-00T00:00:00.000Z",
  "next": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789?skip=26",
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


``` shiki
{
  "success": true,
  "id": "123-456-789",
  "url": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789"
}
```


## 


<a href="#concurrency" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#structured-extraction" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR_API_KEY")

# Scrape multiple websites:
batch_scrape_result = firecrawl.batch_scrape(
    ['https://docs.firecrawl.dev', 'https://docs.firecrawl.dev/sdks/overview'], 
    formats=[{
        'type': 'json',
        'prompt': 'Extract the title and description from the page.',
        'schema': {
            'type': 'object',
            'properties': {
                'title': {'type': 'string'},
                'description': {'type': 'string'}
            },
            'required': ['title', 'description']
        }
    }]
)
print(batch_scrape_result)

# Or, you can use the start method:
batch_scrape_job = firecrawl.start_batch_scrape(
    ['https://docs.firecrawl.dev', 'https://docs.firecrawl.dev/sdks/overview'], 
    formats=[{
        'type': 'json',
        'prompt': 'Extract the title and description from the page.',
        'schema': {
            'type': 'object',
            'properties': {
                'title': {'type': 'string'},
                'description': {'type': 'string'}
            },
            'required': ['title', 'description']
        }
    }]
)
print(batch_scrape_job)

# You can then use the job ID to check the status of the batch scrape:
batch_scrape_status = firecrawl.get_batch_scrape_status(batch_scrape_job.id)
print(batch_scrape_status)
```


### 


<a href="#response-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "status": "completed",
  "total": 36,
  "completed": 36,
  "creditsUsed": 36,
  "expiresAt": "2024-00-00T00:00:00.000Z",
  "next": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789?skip=26",
  "data": [
    {
      "json": {
        "title": "Build a 'Chat with website' using Groq Llama 3 | Firecrawl",
        "description": "Learn how to use Firecrawl, Groq Llama 3, and Langchain to build a 'Chat with your website' bot."
      }
    },
    ...
  ]
}
```


``` shiki
{
  "success": true,
  "id": "123-456-789",
  "url": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789"
}
```


## 


<a href="#webhooks" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/batch/scrape \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer YOUR_API_KEY' \
    -d '{
      "urls": [
        "https://example.com/page1",
        "https://example.com/page2",
        "https://example.com/page3"
      ],
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


| Event                    | Description                           |
|--------------------------|---------------------------------------|
| `batch_scrape.started`   | The batch scrape job has begun        |
| `batch_scrape.page`      | A single URL was successfully scraped |
| `batch_scrape.completed` | All URLs have been processed          |
| `batch_scrape.failed`    | The batch scrape encountered an error |


### 


<a href="#payload" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "type": "batch_scrape.page",
  "id": "batch-job-id",
  "data": [...],
  "metadata": {},
  "error": null
}
```


### 


<a href="#verifying-webhook-signatures" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  Get your webhook secret from the <a href="https://www.firecrawl.dev/app/settings?tab=advanced" class="link" target="_blank" rel="noreferrer">Advanced tab</a> of your account settings
2.  Extract the signature from the `X-Firecrawl-Signature` header
3.  Compute HMAC-SHA256 of the raw request body using your secret
4.  Compare with the signature header using a timing-safe function


> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/batch-scrape.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/batch-scrape" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


<a href="/features/fast-scraping" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-start"></a>


Faster Scraping


<a href="/features/llm-extract" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-end"></a>


JSON mode - Structured result


