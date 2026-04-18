[Skip to main content](https://docs.firecrawl.dev/api-reference/v2-introduction#content-area)

[Firecrawl Docs home page![light logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=c45b3c967c19a39190e76fe8e9c2ed5a)![dark logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=3fee4abe033bd3c26e8ad92043a91c17)](https://firecrawl.dev/)

v2
![US](https://d3gk2c5xim1je2.cloudfront.net/flags/US.svg)

English

Search...

Ctrl K

Search...

Navigation

Using the API

Introduction

[Documentation](https://docs.firecrawl.dev/introduction) [SDKs](https://docs.firecrawl.dev/sdks/overview) [Integrations](https://www.firecrawl.dev/app) [API Reference](https://docs.firecrawl.dev/api-reference/v2-introduction)

- [Playground](https://firecrawl.dev/playground)
- [Blog](https://firecrawl.dev/blog)
- [Community](https://discord.gg/firecrawl)
- [Changelog](https://firecrawl.dev/changelog)

##### Using the API

- [Introduction](https://docs.firecrawl.dev/api-reference/v2-introduction)

##### Search Endpoints

- [POST\\
\\
Search](https://docs.firecrawl.dev/api-reference/endpoint/search)

##### Scrape Endpoints

- [POST\\
\\
Scrape](https://docs.firecrawl.dev/api-reference/endpoint/scrape)
- [POST\\
\\
Interact with the page](https://docs.firecrawl.dev/api-reference/endpoint/scrape-execute)
- [DEL\\
\\
Stop Interacting](https://docs.firecrawl.dev/api-reference/endpoint/scrape-browser-delete)
- [POST\\
\\
Batch Scrape](https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape)
- [GET\\
\\
Get Batch Scrape Status](https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape-get)
- [DEL\\
\\
Cancel Batch Scrape](https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape-delete)
- [GET\\
\\
Get Batch Scrape Errors](https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape-get-errors)

##### Interact & Browser Endpoints

- [POST\\
\\
Interact with the page](https://docs.firecrawl.dev/api-reference/endpoint/scrape-execute)
- [DEL\\
\\
Stop Interacting](https://docs.firecrawl.dev/api-reference/endpoint/scrape-browser-delete)
- [POST\\
\\
Create Browser Session](https://docs.firecrawl.dev/api-reference/endpoint/browser-create)
- [POST\\
\\
Execute Browser Code](https://docs.firecrawl.dev/api-reference/endpoint/browser-execute)
- [GET\\
\\
List Browser Sessions](https://docs.firecrawl.dev/api-reference/endpoint/browser-list)
- [DEL\\
\\
Delete Browser Session](https://docs.firecrawl.dev/api-reference/endpoint/browser-delete)

##### Map Endpoints

- [POST\\
\\
Map](https://docs.firecrawl.dev/api-reference/endpoint/map)

##### Crawl Endpoints

- [POST\\
\\
Crawl](https://docs.firecrawl.dev/api-reference/endpoint/crawl-post)
- [GET\\
\\
Get Crawl Status](https://docs.firecrawl.dev/api-reference/endpoint/crawl-get)
- [POST\\
\\
Crawl Params Preview](https://docs.firecrawl.dev/api-reference/endpoint/crawl-params-preview)
- [DEL\\
\\
Cancel Crawl](https://docs.firecrawl.dev/api-reference/endpoint/crawl-delete)
- [GET\\
\\
Get Crawl Errors](https://docs.firecrawl.dev/api-reference/endpoint/crawl-get-errors)
- [GET\\
\\
Get Active Crawls](https://docs.firecrawl.dev/api-reference/endpoint/crawl-active)

##### Agent Endpoints

- [POST\\
\\
Agent](https://docs.firecrawl.dev/api-reference/endpoint/agent)
- [GET\\
\\
Get Agent Status](https://docs.firecrawl.dev/api-reference/endpoint/agent-get)
- [DEL\\
\\
Cancel Agent](https://docs.firecrawl.dev/api-reference/endpoint/agent-delete)

##### Extract Endpoints

- [POST\\
\\
Extract](https://docs.firecrawl.dev/api-reference/endpoint/extract)
- [GET\\
\\
Get Extract Status](https://docs.firecrawl.dev/api-reference/endpoint/extract-get)

##### Account Endpoints

- [GET\\
\\
Activity](https://docs.firecrawl.dev/api-reference/endpoint/activity)
- [GET\\
\\
Credit Usage](https://docs.firecrawl.dev/api-reference/endpoint/credit-usage)
- [GET\\
\\
Historical Credit Usage](https://docs.firecrawl.dev/api-reference/endpoint/credit-usage-historical)
- [GET\\
\\
Token Usage](https://docs.firecrawl.dev/api-reference/endpoint/token-usage)
- [GET\\
\\
Historical Token Usage](https://docs.firecrawl.dev/api-reference/endpoint/token-usage-historical)
- [GET\\
\\
Queue Status](https://docs.firecrawl.dev/api-reference/endpoint/queue-status)

##### Webhook Payloads

- Crawl

- Batch Scrape

- Agent


On this page

- [Features](https://docs.firecrawl.dev/api-reference/v2-introduction#features)
- [Agentic Features](https://docs.firecrawl.dev/api-reference/v2-introduction#agentic-features)
- [Base URL](https://docs.firecrawl.dev/api-reference/v2-introduction#base-url)
- [Authentication](https://docs.firecrawl.dev/api-reference/v2-introduction#authentication)
- [Response codes](https://docs.firecrawl.dev/api-reference/v2-introduction#response-codes)
- [Rate limit](https://docs.firecrawl.dev/api-reference/v2-introduction#rate-limit)

![Firecrawl](https://docs.firecrawl.dev/logo/light.svg)![Firecrawl](https://docs.firecrawl.dev/logo/dark.svg)

### Ready to build?

Start getting web data for free and scale seamlessly as your project expands. **No credit card needed.**

[Start for free](https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=start_for_free) [See our plans](https://www.firecrawl.dev/pricing?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=see_our_plans)

The Firecrawl API gives you programmatic access to web data. All endpoints share a common base URL, authentication scheme, and response format described on this page.

## [​](https://docs.firecrawl.dev/api-reference/v2-introduction\#features)  Features

[**Scrape** \\
\\
Extract content from any webpage in markdown or json format.](https://docs.firecrawl.dev/api-reference/endpoint/scrape)

[**Crawl** \\
\\
Crawl entire websites and get content from all pages.](https://docs.firecrawl.dev/api-reference/endpoint/crawl-post)

[**Map** \\
\\
Get a complete list of URLs from any website quickly and reliably.](https://docs.firecrawl.dev/api-reference/endpoint/map)

[**Search** \\
\\
Search the web and get full page content in any format.](https://docs.firecrawl.dev/api-reference/endpoint/search)

## [​](https://docs.firecrawl.dev/api-reference/v2-introduction\#agentic-features)  Agentic Features

[**Agent** \\
\\
Autonomous web data gathering powered by AI.](https://docs.firecrawl.dev/api-reference/endpoint/agent)

[**Browser** \\
\\
Create and control browser sessions for interactive web tasks.](https://docs.firecrawl.dev/api-reference/endpoint/browser-create)

## [​](https://docs.firecrawl.dev/api-reference/v2-introduction\#base-url)  Base URL

All requests use the following base URL:

```
https://api.firecrawl.dev
```

## [​](https://docs.firecrawl.dev/api-reference/v2-introduction\#authentication)  Authentication

Every request requires an `Authorization` header with your API key:

```
Authorization: Bearer fc-YOUR-API-KEY
```

Include this header in all API calls. You can find your API key in the [Firecrawl dashboard](https://www.firecrawl.dev/app/api-keys).

cURL

Python

Node

```
curl -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Authorization: Bearer fc-YOUR-API-KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com"}'
```

## [​](https://docs.firecrawl.dev/api-reference/v2-introduction\#response-codes)  Response codes

Firecrawl uses conventional HTTP status codes to indicate the outcome of your requests. Codes in the `2xx` range indicate success, `4xx` codes indicate client errors, and `5xx` codes indicate server errors.

| Status | Description |
| --- | --- |
| `200` | Request was successful. |
| `400` | Invalid request parameters. |
| `401` | API key is missing or invalid. |
| `402` | Payment required. |
| `404` | The requested resource was not found. |
| `429` | Rate limit exceeded. |
| `5xx` | Server error on Firecrawl’s side. |

When a `5xx` error occurs, the response body includes a specific error code to help you diagnose the issue.

## [​](https://docs.firecrawl.dev/api-reference/v2-introduction\#rate-limit)  Rate limit

The Firecrawl API enforces rate limits on all endpoints to ensure service stability. Rate limits are based on the number of requests within a specific time window.When you exceed the rate limit, the API returns a `429` status code. Back off and retry the request after a short delay.

[Suggest edits](https://github.com/firecrawl/firecrawl-docs/edit/main/api-reference/v2-introduction.mdx) [Raise issue](https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&body=Path:%20/api-reference/v2-introduction)

[Search\\
\\
Next](https://docs.firecrawl.dev/api-reference/endpoint/search)

Ctrl+I

Chat Widget

Loading...