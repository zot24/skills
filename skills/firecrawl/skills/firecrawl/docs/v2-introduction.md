> Source: https://docs.firecrawl.dev/api-reference/v2-introduction.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Introduction

> Firecrawl API Reference (v2)

The Firecrawl API gives you programmatic access to web data. All endpoints share a common base URL, authentication scheme, and response format described on this page.

## Features


    Extract content from any webpage in markdown or json format.


    Upload files and parse them into markdown or other formats.


    Crawl entire websites and get content from all pages.


    Get a complete list of URLs from any website quickly and reliably.


    Search the web and get full page content in any format.


## Agentic Features


    Autonomous web data gathering powered by AI.


    Create and control browser sessions for interactive web tasks.


## Base URL

All requests use the following base URL:

```bash
https://api.firecrawl.dev
```

## Authentication

Every request requires an `Authorization` header with your API key:

```bash
Authorization: Bearer fc-YOUR-API-KEY
```

Include this header in all API calls. You can find your API key in the [Firecrawl dashboard](https://www.firecrawl.dev/app/api-keys).

<CodeGroup>
  ```bash cURL
  curl -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Authorization: Bearer fc-YOUR-API-KEY" \
    -H "Content-Type: application/json" \
    -d '{"url": "https://example.com"}'
  ```

  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

  result = firecrawl.scrape("https://example.com")
  ```

  ```js Node
  import Firecrawl from '@mendable/firecrawl-js';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  const result = await firecrawl.scrape('https://example.com');
  ```
</CodeGroup>

## Response codes

Firecrawl uses conventional HTTP status codes to indicate the outcome of your requests. Codes in the `2xx` range indicate success, `4xx` codes indicate client errors, and `5xx` codes indicate server errors.

| Status | Description                           |
| ------ | ------------------------------------- |
| `200`  | Request was successful.               |
| `400`  | Invalid request parameters.           |
| `401`  | API key is missing or invalid.        |
| `402`  | Payment required.                     |
| `404`  | The requested resource was not found. |
| `429`  | Rate limit exceeded.                  |
| `5xx`  | Server error on Firecrawl's side.     |

When a `5xx` error occurs, the response body includes a specific error code to help you diagnose the issue.

## Rate limit

The Firecrawl API enforces rate limits on all endpoints to ensure service stability. Rate limits are based on the number of requests within a specific time window.

When you exceed the rate limit, the API returns a `429` status code. Back off and retry the request after a short delay.
