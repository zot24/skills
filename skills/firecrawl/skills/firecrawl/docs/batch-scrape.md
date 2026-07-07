> Source: https://docs.firecrawl.dev/features/batch-scrape.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Batch Scrape

> Scrape multiple URLs in a single batch job

Batch scrape lets you scrape multiple URLs in a single job. Pass a list of URLs and optional parameters, and Firecrawl processes them concurrently and returns all results together.

* Works like `/crawl` but for an explicit list of URLs
* Synchronous and asynchronous modes
* Supports all scrape options including structured extraction
* Configurable concurrency per job

## How it works

You can run a batch scrape in two ways:

| Mode         | SDK method (JS / Python)                  | Behavior                                                         |
| ------------ | ----------------------------------------- | ---------------------------------------------------------------- |
| Synchronous  | `batchScrape` / `batch_scrape`            | Starts the batch and waits for completion, returning all results |
| Asynchronous | `startBatchScrape` / `start_batch_scrape` | Starts the batch and returns a job ID for polling or webhooks    |

## Basic usage

<CodeGroup>
  ```python Python
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

  ```js Node
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

  ```bash cURL
  curl -s -X POST "https://api.firecrawl.dev/v2/batch/scrape" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "urls": ["https://firecrawl.dev", "https://docs.firecrawl.dev"],
      "formats": ["markdown"]
    }'
  ```
</CodeGroup>

### Response

Calling `batchScrape` / `batch_scrape` returns the full results when the batch completes.

```json Completed theme={null}
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

Calling `startBatchScrape` / `start_batch_scrape` returns a job ID you can track via `getBatchScrapeStatus` / `get_batch_scrape_status`, the API endpoint `/batch/scrape/{id}`, or webhooks. Job results are available via the API for 24 hours after completion. After this period, you can still view your batch scrape history and results in the [activity logs](https://www.firecrawl.dev/app/logs).

```json theme={null}
{
  "success": true,
  "id": "123-456-789",
  "url": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789"
}
```

## Concurrency

By default, a batch scrape job uses your team's full concurrent browser limit (see [Rate Limits](/rate-limits)). You can lower this per job with the `maxConcurrency` parameter.

For example, `maxConcurrency: 50` limits that job to 50 simultaneous scrapes. Setting this value too low on large batches will significantly slow down processing, so only reduce it if you need to leave capacity for other concurrent jobs.

## Structured extraction

You can use batch scrape to extract structured data from every page in the batch. This is useful when you want the same schema applied to a list of URLs.

<CodeGroup>
  ```python Python
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

  ```js Node
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

  ```bash cURL
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
</CodeGroup>

### Response

`batchScrape` / `batch_scrape` returns full results:

```json Completed theme={null}
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

`startBatchScrape` / `start_batch_scrape` returns a job ID:

```json theme={null}
{
  "success": true,
  "id": "123-456-789",
  "url": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789"
}
```

## Webhooks

You can configure webhooks to receive real-time notifications as each URL in your batch is scraped. This lets you process results immediately instead of waiting for the entire batch to complete.

```bash cURL theme={null}
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

### Event types

| Event                    | Description                           |
| ------------------------ | ------------------------------------- |
| `batch_scrape.started`   | The batch scrape job has begun        |
| `batch_scrape.page`      | A single URL was successfully scraped |
| `batch_scrape.completed` | All URLs have been processed          |
| `batch_scrape.failed`    | The batch scrape encountered an error |

### Payload

Each webhook delivery includes a JSON body with the following structure:

```json theme={null}
{
  "success": true,
  "type": "batch_scrape.page",
  "id": "batch-job-id",
  "data": [...],
  "metadata": {},
  "error": null
}
```

### Verifying webhook signatures

Every webhook request from Firecrawl includes an `X-Firecrawl-Signature` header containing an HMAC-SHA256 signature. Always verify this signature to ensure the webhook is authentic and has not been tampered with.

1. Get your webhook secret from the [Advanced tab](https://www.firecrawl.dev/app/settings?tab=advanced) of your account settings
2. Extract the signature from the `X-Firecrawl-Signature` header
3. Compute HMAC-SHA256 of the raw request body using your secret
4. Compare with the signature header using a timing-safe function


  Never process a webhook without verifying its signature first. The `X-Firecrawl-Signature` header contains the signature in the format: `sha256=abc123def456...`


For complete implementation examples in JavaScript and Python, see the [Webhook Security documentation](/webhooks/security).

For comprehensive webhook documentation including detailed event payloads, advanced configuration, and troubleshooting, see the [Webhooks documentation](/webhooks/overview).

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
