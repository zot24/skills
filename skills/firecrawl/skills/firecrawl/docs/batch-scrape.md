> Source: https://docs.firecrawl.dev/features/batch-scrape



Scrape


# Batch Scrape


Scrape multiple URLs in a single batch job


- Works like `/crawl` but for an explicit list of URLs
- Synchronous and asynchronous modes
- Supports all scrape options including structured extraction
- Configurable concurrency per job

## <a href="#operations" class="anchor-link" aria-label="Navigate to header: Operations"></a><span id="_R_59crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Operations</span>


| Task | API reference | SDK vocabulary |
|----|----|----|
| Start a batch | <a href="/api-reference/endpoint/batch-scrape" class="link"><code>batch-scrape</code></a> | `batchScrape` / `batch_scrape`, `startBatchScrape` / `start_batch_scrape` |
| Check status and results | <a href="/api-reference/endpoint/batch-scrape-get" class="link"><code>batch-scrape-get</code></a> | `getBatchScrapeStatus` / `get_batch_scrape_status` |
| Cancel a running batch | <a href="/api-reference/endpoint/batch-scrape-delete" class="link"><code>batch-scrape-delete</code></a> | Cancel or delete the batch job by ID |
| Inspect errors | <a href="/api-reference/endpoint/batch-scrape-get-errors" class="link"><code>batch-scrape-get-errors</code></a> | Error/status helper for failed URLs |


## <a href="#how-it-works" class="anchor-link" aria-label="Navigate to header: How it works"></a><span id="_R_99crmhkd74t9_" class="cursor-pointer">How it works</span>


| Mode | SDK method (JS / Python) | Behavior |
|----|----|----|
| Synchronous | `batchScrape` / `batch_scrape` | Starts the batch and waits for completion, returning all results |
| Asynchronous | `startBatchScrape` / `start_batch_scrape` | Starts the batch and returns a job ID for polling or webhooks |


## <a href="#basic-usage" class="anchor-link" aria-label="Navigate to header: Basic usage"></a><span id="_R_f9crmhkd74t9_" class="cursor-pointer">Basic usage</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

# Asynchronous: starts the batch and returns a job ID immediately
start = firecrawl.start_batch_scrape([
    "https://firecrawl.dev",
    "https://docs.firecrawl.dev",
], formats=["markdown"])

status = firecrawl.get_batch_scrape_status(start.id)

# Or synchronous: starts the batch and waits for completion
job = firecrawl.batch_scrape([
    "https://firecrawl.dev",
    "https://docs.firecrawl.dev",
], formats=["markdown"], poll_interval=2, wait_timeout=120)

print(job.status, job.completed, job.total)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

// Asynchronous: starts the batch and returns a job ID immediately
const { id } = await firecrawl.startBatchScrape([
  'https://firecrawl.dev',
  'https://docs.firecrawl.dev'
], {
  options: { formats: ['markdown'] },
});

const status = await firecrawl.getBatchScrapeStatus(id);

// Or synchronous: starts the batch and waits for completion
const job = await firecrawl.batchScrape([
  'https://firecrawl.dev',
  'https://docs.firecrawl.dev'
], { options: { formats: ['markdown'] }, pollInterval: 2, timeout: 120 });

console.log(job.status, job.completed, job.total);
```


``` shiki
curl -s -X POST "https://api.firecrawl.dev/v2/batch/scrape" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "urls": ["https://firecrawl.dev", "https://docs.firecrawl.dev"],
    "formats": ["markdown"]
  }'
```


### <a href="#response" class="anchor-link" aria-label="Navigate to header: Response"></a><span id="_R_j9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Response</span>


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


## <a href="#concurrency" class="anchor-link" aria-label="Navigate to header: Concurrency"></a><span id="_R_t9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Concurrency</span>


## <a href="#structured-extraction" class="anchor-link" aria-label="Navigate to header: Structured extraction"></a><span id="_R_139crmhkd74t9_" class="cursor-pointer">Structured extraction</span>


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


``` shiki
import { Firecrawl, ScrapeResponse } from 'firecrawl';

const firecrawl = new Firecrawl({apiKey: "fc-YOUR_API_KEY"});

// Define schema to extract contents into
const schema = {
  type: "object",
  properties: {
    title: { type: "string" },
    description: { type: "string" }
  },
  required: ["title", "description"]
};

// Scrape multiple websites (synchronous):
const batchScrapeResult = await firecrawl.batchScrape(['https://docs.firecrawl.dev', 'https://docs.firecrawl.dev/sdks/overview'], { 
  formats: [
    {
      type: "json",
      prompt: "Extract the title and description from the page.",
      schema: schema
    }
  ]
});

// Output all the results of the batch scrape:
console.log(batchScrapeResult)

// Or, you can use the start method:
const batchScrapeJob = await firecrawl.startBatchScrape(['https://docs.firecrawl.dev', 'https://docs.firecrawl.dev/sdks/overview'], { 
  formats: [
    {
      type: "json",
      prompt: "Extract the title and description from the page.",
      schema: schema
    }
  ]
});
console.log(batchScrapeJob)

// You can then use the job ID to check the status of the batch scrape:
const batchScrapeStatus = await firecrawl.getBatchScrapeStatus(batchScrapeJob.id);
console.log(batchScrapeStatus)
```


``` shiki
curl -X POST https://api.firecrawl.dev/v2/batch/scrape \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer YOUR_API_KEY' \
    -d '{
      "urls": ["https://docs.firecrawl.dev", "https://docs.firecrawl.dev/sdks/overview"],
      "formats" : [{
        "type": "json",
        "prompt": "Extract the title and description from the page.",
        "schema": {
          "type": "object",
          "properties": {
            "title": {
              "type": "string"
            },
            "description": {
              "type": "string"
            }
          },
          "required": [
            "title",
            "description"
          ]
        }
      }]
    }'
```


### <a href="#response-2" class="anchor-link" aria-label="Navigate to header: Response"></a><span id="_R_199crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Response</span>


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


## <a href="#webhooks" class="anchor-link" aria-label="Navigate to header: Webhooks"></a><span id="_R_1j9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Webhooks</span>


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


### <a href="#event-types" class="anchor-link" aria-label="Navigate to header: Event types"></a><span id="_R_1p9crmhkd74t9_" class="cursor-pointer">Event types</span>


| Event                    | Description                           |
|--------------------------|---------------------------------------|
| `batch_scrape.started`   | The batch scrape job has begun        |
| `batch_scrape.page`      | A single URL was successfully scraped |
| `batch_scrape.completed` | All URLs have been processed          |
| `batch_scrape.failed`    | The batch scrape encountered an error |


### <a href="#payload" class="anchor-link" aria-label="Navigate to header: Payload"></a><span id="_R_1t9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Payload</span>


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


### <a href="#verifying-webhook-signatures" class="anchor-link" aria-label="Navigate to header: Verifying webhook signatures"></a><span id="_R_239crmhkd74t9_" class="cursor-pointer">Verifying webhook signatures</span>


1.  Get your webhook secret from the <a href="https://www.firecrawl.dev/app/settings?tab=advanced" class="link" target="_blank" rel="noreferrer">Advanced tab</a> of your account settings
2.  Extract the signature from the `X-Firecrawl-Signature` header
3.  Compute HMAC-SHA256 of the raw request body using your secret
4.  Compare with the signature header using a timing-safe function


> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/batch-scrape.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/batch-scrape" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


