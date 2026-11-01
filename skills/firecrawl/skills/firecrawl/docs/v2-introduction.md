> Source: https://docs.firecrawl.dev/api-reference/v2-introduction.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Introduction

> Firecrawl API Reference (v2)

> [!NOTE]
>
> **For AI agents:** Use [llms.txt](https://docs.firecrawl.dev/llms.txt) for a full index of all documentation.

The Firecrawl API gives you programmatic access to web data. All endpoints share a common base URL, authentication scheme, and response format described on this page.

## Features

> [card] [Search](https://docs.firecrawl.dev/api-reference/endpoint/search.md)
>
> Search the web and get full page content in any format.

> [card] [Scrape](https://docs.firecrawl.dev/api-reference/endpoint/scrape.md)
>
> Extract content from any webpage in markdown or json format.

> [card] [Interact](https://docs.firecrawl.dev/api-reference/endpoint/browser-create.md)
>
> Create an Interact session to click, fill forms, and navigate pages.

> [card] [Parse](https://docs.firecrawl.dev/api-reference/endpoint/parse.md)
>
> Upload files and parse them into markdown or other formats.

> [card] [Monitor](https://docs.firecrawl.dev/api-reference/endpoint/monitor-create.md)
>
> Schedule recurring checks and get notified when content changes.

> [card] [Crawl](https://docs.firecrawl.dev/api-reference/endpoint/crawl-post.md)
>
> Crawl entire websites and get content from all pages.

> [card] [Map](https://docs.firecrawl.dev/api-reference/endpoint/map.md)
>
> Get a complete list of URLs from any website quickly and reliably.

> [card] [Agent](https://docs.firecrawl.dev/api-reference/endpoint/agent.md)
>
> Autonomous web data gathering powered by AI.

> [card] [Alexandria](https://docs.firecrawl.dev/features/alexandria.md)
>
> Find and run structured data tools from third-party providers.

## Base URL

All requests use the following base URL:

```bash theme={null}
https://api.firecrawl.dev
```

## Authentication

Every request requires an `Authorization` header with your API key:

```bash theme={null}
Authorization: Bearer fc-YOUR-API-KEY
```

Include this header in all API calls. You can find your API key in the [Firecrawl dashboard](https://www.firecrawl.dev/app/api-keys).

To let users connect their own Firecrawl account to your app instead, use [OAuth for apps](https://docs.firecrawl.dev/oauth.md). [Authentication](https://docs.firecrawl.dev/authentication.md) compares every option.

If you are an agent without an API key, start with [Get credentials](https://docs.firecrawl.dev/ai-onboarding.md#get-credentials). If your platform supports WorkOS ID-JAG, use [`auth.md`](https://www.firecrawl.dev/auth.md) for registration instructions.

```bash cURL theme={null}
curl -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Authorization: Bearer fc-YOUR-API-KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com"}'
```

```python Python theme={null}
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

result = firecrawl.scrape("https://example.com")
```

```js Node theme={null}
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

const result = await firecrawl.scrape('https://example.com');
```

## Response codes

Firecrawl uses conventional HTTP status codes to indicate the outcome of your requests. Codes in the `2xx` range indicate success, `4xx` codes indicate client errors, and `5xx` codes indicate server errors.

See [Errors](https://docs.firecrawl.dev/api-reference/errors.md) for the full reference, including the `error` string returned for each failure mode, retry guidance, and a copy-pasteable backoff snippet.

## 429 responses

When you exceed your plan's rate or concurrency limits, the API returns a `429` status code. See [Rate Limits](https://docs.firecrawl.dev/rate-limits.md) for per-plan limits and [Errors](https://docs.firecrawl.dev/api-reference/errors.md) for retry guidance.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
