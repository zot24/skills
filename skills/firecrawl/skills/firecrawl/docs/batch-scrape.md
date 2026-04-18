[Skip to main content](https://docs.firecrawl.dev/features/batch-scrape#content-area)

[Firecrawl Docs home page![light logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=c45b3c967c19a39190e76fe8e9c2ed5a)![dark logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=3fee4abe033bd3c26e8ad92043a91c17)](https://firecrawl.dev/)

v2
![US](https://d3gk2c5xim1je2.cloudfront.net/flags/US.svg)

English

Search...

Ctrl K

Search...

Navigation

Scrape

Batch Scrape

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



  - [Scrape](https://docs.firecrawl.dev/features/scrape)
  - [Faster Scraping](https://docs.firecrawl.dev/features/fast-scraping)
  - [Batch Scrape](https://docs.firecrawl.dev/features/batch-scrape)
  - [JSON mode](https://docs.firecrawl.dev/features/llm-extract)
  - [Change Tracking](https://docs.firecrawl.dev/features/change-tracking)
  - [Enhanced Mode](https://docs.firecrawl.dev/features/enhanced-mode)
  - [Proxies](https://docs.firecrawl.dev/features/proxies)
  - [Document Parsing](https://docs.firecrawl.dev/features/document-parsing)
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

- [How it works](https://docs.firecrawl.dev/features/batch-scrape#how-it-works)
- [Basic usage](https://docs.firecrawl.dev/features/batch-scrape#basic-usage)
- [Response](https://docs.firecrawl.dev/features/batch-scrape#response)
- [Concurrency](https://docs.firecrawl.dev/features/batch-scrape#concurrency)
- [Structured extraction](https://docs.firecrawl.dev/features/batch-scrape#structured-extraction)
- [Response](https://docs.firecrawl.dev/features/batch-scrape#response-2)
- [Webhooks](https://docs.firecrawl.dev/features/batch-scrape#webhooks)
- [Event types](https://docs.firecrawl.dev/features/batch-scrape#event-types)
- [Payload](https://docs.firecrawl.dev/features/batch-scrape#payload)
- [Verifying webhook signatures](https://docs.firecrawl.dev/features/batch-scrape#verifying-webhook-signatures)

![Firecrawl](https://docs.firecrawl.dev/logo/light.svg)![Firecrawl](https://docs.firecrawl.dev/logo/dark.svg)

### Ready to build?

Start getting web data for free and scale seamlessly as your project expands. **No credit card needed.**

[Start for free](https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=start_for_free) [See our plans](https://www.firecrawl.dev/pricing?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=see_our_plans)

Batch scrape lets you scrape multiple URLs in a single job. Pass a list of URLs and optional parameters, and Firecrawl processes them concurrently and returns all results together.

- Works like `/crawl` but for an explicit list of URLs
- Synchronous and asynchronous modes
- Supports all scrape options including structured extraction
- Configurable concurrency per job

## [​](https://docs.firecrawl.dev/features/batch-scrape\#how-it-works)  How it works

You can run a batch scrape in two ways:

| Mode | SDK method (JS / Python) | Behavior |
| --- | --- | --- |
| Synchronous | `batchScrape` / `batch_scrape` | Starts the batch and waits for completion, returning all results |
| Asynchronous | `startBatchScrape` / `start_batch_scrape` | Starts the batch and returns a job ID for polling or webhooks |

## [​](https://docs.firecrawl.dev/features/batch-scrape\#basic-usage)  Basic usage

Python

Node

cURL

```
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

start = firecrawl.start_batch_scrape([\
    "https://firecrawl.dev",\
    "https://docs.firecrawl.dev",\
], formats=["markdown"])  # returns id

job = firecrawl.batch_scrape([\
    "https://firecrawl.dev",\
    "https://docs.firecrawl.dev",\
], formats=["markdown"], poll_interval=2, wait_timeout=120)

print(job.status, job.completed, job.total)
```

### [​](https://docs.firecrawl.dev/features/batch-scrape\#response)  Response

Calling `batchScrape` / `batch_scrape` returns the full results when the batch completes.

Completed

```
{
  "status": "completed",
  "total": 36,
  "completed": 36,
  "creditsUsed": 36,
  "expiresAt": "2024-00-00T00:00:00.000Z",
  "next": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789?skip=26",
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
Calling `startBatchScrape` / `start_batch_scrape` returns a job ID you can track via `getBatchScrapeStatus` / `get_batch_scrape_status`, the API endpoint `/batch/scrape/{id}`, or webhooks. Job results are available via the API for 24 hours after completion. After this period, you can still view your batch scrape history and results in the [activity logs](https://www.firecrawl.dev/app/logs).\
\
```\
{\
  "success": true,\
  "id": "123-456-789",\
  "url": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789"\
}\
```\
\
## [​](https://docs.firecrawl.dev/features/batch-scrape\#concurrency)  Concurrency\
\
By default, a batch scrape job uses your team’s full concurrent browser limit (see [Rate Limits](https://docs.firecrawl.dev/rate-limits)). You can lower this per job with the `maxConcurrency` parameter.For example, `maxConcurrency: 50` limits that job to 50 simultaneous scrapes. Setting this value too low on large batches will significantly slow down processing, so only reduce it if you need to leave capacity for other concurrent jobs.\
\
## [​](https://docs.firecrawl.dev/features/batch-scrape\#structured-extraction)  Structured extraction\
\
You can use batch scrape to extract structured data from every page in the batch. This is useful when you want the same schema applied to a list of URLs.\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
\
firecrawl = Firecrawl(api_key="fc-YOUR_API_KEY")\
\
# Scrape multiple websites:\
batch_scrape_result = firecrawl.batch_scrape(\
    ['https://docs.firecrawl.dev', 'https://docs.firecrawl.dev/sdks/overview'],\
    formats=[{\
        'type': 'json',\
        'prompt': 'Extract the title and description from the page.',\
        'schema': {\
            'type': 'object',\
            'properties': {\
                'title': {'type': 'string'},\
                'description': {'type': 'string'}\
            },\
            'required': ['title', 'description']\
        }\
    }]\
)\
print(batch_scrape_result)\
\
# Or, you can use the start method:\
batch_scrape_job = firecrawl.start_batch_scrape(\
    ['https://docs.firecrawl.dev', 'https://docs.firecrawl.dev/sdks/overview'],\
    formats=[{\
        'type': 'json',\
        'prompt': 'Extract the title and description from the page.',\
        'schema': {\
            'type': 'object',\
            'properties': {\
                'title': {'type': 'string'},\
                'description': {'type': 'string'}\
            },\
            'required': ['title', 'description']\
        }\
    }]\
)\
print(batch_scrape_job)\
\
# You can then use the job ID to check the status of the batch scrape:\
batch_scrape_status = firecrawl.get_batch_scrape_status(batch_scrape_job.id)\
print(batch_scrape_status)\
```\
\
### [​](https://docs.firecrawl.dev/features/batch-scrape\#response-2)  Response\
\
`batchScrape` / `batch_scrape` returns full results:\
\
Completed\
\
```\
{\
  "status": "completed",\
  "total": 36,\
  "completed": 36,\
  "creditsUsed": 36,\
  "expiresAt": "2024-00-00T00:00:00.000Z",\
  "next": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789?skip=26",\
  "data": [\
    {\
      "json": {\
        "title": "Build a 'Chat with website' using Groq Llama 3 | Firecrawl",\
        "description": "Learn how to use Firecrawl, Groq Llama 3, and Langchain to build a 'Chat with your website' bot."\
      }\
    },\
    ...\
  ]\
}\
```\
\
`startBatchScrape` / `start_batch_scrape` returns a job ID:\
\
```\
{\
  "success": true,\
  "id": "123-456-789",\
  "url": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789"\
}\
```\
\
## [​](https://docs.firecrawl.dev/features/batch-scrape\#webhooks)  Webhooks\
\
You can configure webhooks to receive real-time notifications as each URL in your batch is scraped. This lets you process results immediately instead of waiting for the entire batch to complete.\
\
cURL\
\
```\
curl -X POST https://api.firecrawl.dev/v2/batch/scrape \\
    -H 'Content-Type: application/json' \\
    -H 'Authorization: Bearer YOUR_API_KEY' \\
    -d '{\
      "urls": [\
        "https://example.com/page1",\
        "https://example.com/page2",\
        "https://example.com/page3"\
      ],\
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
### [​](https://docs.firecrawl.dev/features/batch-scrape\#event-types)  Event types\
\
| Event | Description |\
| --- | --- |\
| `batch_scrape.started` | The batch scrape job has begun |\
| `batch_scrape.page` | A single URL was successfully scraped |\
| `batch_scrape.completed` | All URLs have been processed |\
| `batch_scrape.failed` | The batch scrape encountered an error |\
\
### [​](https://docs.firecrawl.dev/features/batch-scrape\#payload)  Payload\
\
Each webhook delivery includes a JSON body with the following structure:\
\
```\
{\
  "success": true,\
  "type": "batch_scrape.page",\
  "id": "batch-job-id",\
  "data": [...],\
  "metadata": {},\
  "error": null\
}\
```\
\
### [​](https://docs.firecrawl.dev/features/batch-scrape\#verifying-webhook-signatures)  Verifying webhook signatures\
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
For complete implementation examples in JavaScript and Python, see the [Webhook Security documentation](https://docs.firecrawl.dev/webhooks/security).For comprehensive webhook documentation including detailed event payloads, advanced configuration, and troubleshooting, see the [Webhooks documentation](https://docs.firecrawl.dev/webhooks/overview).\
\
> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.\
\
[Suggest edits](https://github.com/firecrawl/firecrawl-docs/edit/main/features/batch-scrape.mdx) [Raise issue](https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&body=Path:%20/features/batch-scrape)\
\
[Faster Scraping\\
\\
Previous](https://docs.firecrawl.dev/features/fast-scraping) [JSON mode - Structured result\\
\\
Next](https://docs.firecrawl.dev/features/llm-extract)\
\
Ctrl+I\
\
Chat Widget\
\
Loading...