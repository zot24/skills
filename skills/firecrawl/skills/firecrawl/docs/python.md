> Source: https://docs.firecrawl.dev/sdks/python.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Python

> Firecrawl Python SDK is a wrapper around the Firecrawl API to help you easily turn websites into markdown.

## Installation

To install the Firecrawl Python SDK, you can use pip:

```python Python theme={null}
# pip install firecrawl-py

from firecrawl import Firecrawl

firecrawl = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)
```

## Usage

Get an API key from [firecrawl.dev](https://firecrawl.dev), then either set it as the `FIRECRAWL_API_KEY` environment variable or pass it directly to the `Firecrawl` class.


  **No API key?** You can construct `Firecrawl` without a key and use `scrape`, `search`, and `interact` on the keyless free tier (rate-limited per IP — see [Rate Limits](/rate-limits#keyless-no-api-key)). All other methods require a key.


```python Python theme={null}
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR_API_KEY")

# Scrape a website:
scrape_status = firecrawl.scrape(
  'https://firecrawl.dev', 
  formats=['markdown', 'html']
)
print(scrape_status)

# Crawl a website:
crawl_status = firecrawl.crawl(
  'https://firecrawl.dev', 
  limit=100, 
  scrape_options={
    'formats': ['markdown', 'html']
  }
)
print(crawl_status)
```

### Scraping a URL

Scrape a single URL with the `scrape` method. It returns the page content as structured data, including markdown, metadata, and any other formats you request.

```python Python theme={null}
# Scrape a website:
scrape_result = firecrawl.scrape('firecrawl.dev', formats=['markdown', 'html'])
print(scrape_result)
```


  The Python SDK converts all response field names from camelCase to snake\_case. For example, metadata fields like `ogImage`, `ogTitle`, and `sourceURL` from the API become `og_image`, `og_title`, and `source_url` in the SDK response.


### Parsing uploaded files

Use `parse` to upload local files (`html`, `pdf`, `docx`, `xlsx`, etc.) directly to `/v2/parse`.
`parse` does not support `changeTracking` or browser-only options like actions, wait\_for, location, mobile, screenshot, and branding.

```python Python theme={null}
from firecrawl.v2.types import ParseOptions

parsed = firecrawl.parse(
    b"<!DOCTYPE html><html><body><h1>Python Parse</h1></body></html>",
    filename="upload.html",
    content_type="text/html",
    options=ParseOptions(formats=["markdown"]),
)

print(parsed.markdown)
```

### Crawl a Website

To crawl a website, use the `crawl` method. It takes the starting URL and optional options as arguments. The options allow you to specify additional settings for the crawl job, such as the maximum number of pages to crawl, allowed domains, and the output format. See [Pagination](#pagination) for auto/manual pagination and limiting.

```python Python theme={null}
job = firecrawl.crawl(url="https://docs.firecrawl.dev", limit=5, poll_interval=1, timeout=120)
print(job)
```

### Sitemap-Only Crawl

Use `sitemap="only"` to crawl sitemap URLs only (the start URL is always included, and HTML link discovery is skipped).

```python Python theme={null}
job = firecrawl.crawl(url="https://docs.firecrawl.dev", sitemap="only", limit=25)
print(job.status, len(job.data))
```

### Start a Crawl

Prefer non-blocking? Check out the [Async Class](#async-class) section below.

Start a job without waiting using `start_crawl`. It returns a job `ID` you can use to check status. Use `crawl` when you want a waiter that blocks until completion. See [Pagination](#pagination) for paging behavior and limits.

```python Python theme={null}
job = firecrawl.start_crawl(url="https://docs.firecrawl.dev", limit=10)
print(job)
```

### Checking Crawl Status

Check the status of a crawl job with `get_crawl_status`. Pass the job ID and receive the current status along with any results collected so far.

```python Python theme={null}
status = firecrawl.get_crawl_status("<crawl-id>")
print(status)
```

### Cancelling a Crawl

Cancel a crawl job with the `cancel_crawl` method. Pass the job ID returned by `start_crawl` to receive the cancellation status.

```python Python theme={null}
ok = firecrawl.cancel_crawl("<crawl-id>")
print("Cancelled:", ok)
```

### Map a Website

Use `map` to generate a list of URLs from a website. The options let you customize the mapping process, including excluding subdomains or utilizing the sitemap.

```python Python theme={null}
res = firecrawl.map(url="https://firecrawl.dev", limit=10)
print(res)
```

### Crawling a Website with WebSockets

To crawl a website with WebSockets, start the job with `start_crawl` and subscribe using the `watcher` helper. Create a watcher with the job ID and attach handlers (e.g., for page, completed, failed) before calling `start()`.

```python Python theme={null}
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

### Pagination

Firecrawl endpoints for crawl and batch scrape return a `next` URL when more data is available. The Python SDK auto-paginates by default and aggregates all documents; in that case `next` will be `None`. You can disable auto-pagination or set limits to control pagination behavior.

#### PaginationConfig

Use `PaginationConfig` to control pagination behavior when calling `get_crawl_status` or `get_batch_scrape_status`:

```python Python theme={null}
from firecrawl.v2.types import PaginationConfig
```

| Option          | Type   | Default | Description                                                                                                      |
| --------------- | ------ | ------- | ---------------------------------------------------------------------------------------------------------------- |
| `auto_paginate` | `bool` | `True`  | When `True`, automatically fetches all pages and aggregates results. Set to `False` to fetch one page at a time. |
| `max_pages`     | `int`  | `None`  | Stop after fetching this many pages (only applies when `auto_paginate=True`).                                    |
| `max_results`   | `int`  | `None`  | Stop after collecting this many documents (only applies when `auto_paginate=True`).                              |
| `max_wait_time` | `int`  | `None`  | Stop after this many seconds (only applies when `auto_paginate=True`).                                           |

#### Manual Pagination Helpers

When `auto_paginate=False`, the response includes a `next` URL if more data is available. Use these helper methods to fetch subsequent pages:

* **`get_crawl_status_page(next_url)`** - Fetch the next page of crawl results using the opaque `next` URL from a previous response.
* **`get_batch_scrape_status_page(next_url)`** - Fetch the next page of batch scrape results using the opaque `next` URL from a previous response.

These methods return the same response type as the original status call, including a new `next` URL if more pages remain.

#### Crawl

Use the waiter method `crawl` for the simplest experience, or start a job and page manually.

##### Simple crawl (auto-pagination, default)

* See the default flow in [Crawl a Website](#crawl-a-website).

##### Manual crawl with pagination control

Start a job, then fetch one page at a time with `auto_paginate=False`. Use `get_crawl_status_page` to fetch subsequent pages:

```python Python theme={null}
crawl_job = client.start_crawl("https://example.com", limit=100)

# Fetch first page
status = client.get_crawl_status(
    crawl_job.id,
    pagination_config=PaginationConfig(auto_paginate=False)
)
print("First page:", len(status.data), "docs")

# Fetch subsequent pages using get_crawl_status_page
while status.next:
    status = client.get_crawl_status_page(status.next)
    print("Next page:", len(status.data), "docs")
```

##### Manual crawl with limits (auto-pagination + early stop)

Keep auto-pagination on but stop early with `max_pages`, `max_results`, or `max_wait_time`:

```python Python theme={null}
status = client.get_crawl_status(
    crawl_job.id,
    pagination_config=PaginationConfig(max_pages=2, max_results=50, max_wait_time=15),
)
print("crawl limited:", status.status, "docs:", len(status.data), "next:", status.next)
```

#### Batch Scrape

Use the waiter method `batch_scrape`, or start a job and page manually.

##### Simple batch scrape (auto-pagination, default)

* See the default flow in [Batch Scrape](/features/batch-scrape).

##### Manual batch scrape with pagination control

Start a job, then fetch one page at a time with `auto_paginate=False`. Use `get_batch_scrape_status_page` to fetch subsequent pages:

```python Python theme={null}
batch_job = client.start_batch_scrape(urls)

# Fetch first page
status = client.get_batch_scrape_status(
    batch_job.id,
    pagination_config=PaginationConfig(auto_paginate=False)
)
print("First page:", len(status.data), "docs")

# Fetch subsequent pages using get_batch_scrape_status_page
while status.next:
    status = client.get_batch_scrape_status_page(status.next)
    print("Next page:", len(status.data), "docs")
```

##### Manual batch scrape with limits (auto-pagination + early stop)

Keep auto-pagination on but stop early with `max_pages`, `max_results`, or `max_wait_time`:

```python Python theme={null}
status = client.get_batch_scrape_status(
    batch_job.id,
    pagination_config=PaginationConfig(max_pages=2, max_results=100, max_wait_time=20),
)
print("batch limited:", status.status, "docs:", len(status.data), "next:", status.next)
```

## Error Handling

When a request fails, the SDK raises an exception with a descriptive message explaining what went wrong. Wrap calls in `try`/`except` to catch these exceptions and handle failures in your application.

## Async Class

For async operations, use the `AsyncFirecrawl` class. Its methods mirror `Firecrawl`, but they don't block the main thread.

```python Python theme={null}
import asyncio
from firecrawl import AsyncFirecrawl

async def main():
    firecrawl = AsyncFirecrawl(api_key="fc-YOUR-API-KEY")

    # Scrape
    doc = await firecrawl.scrape("https://firecrawl.dev", formats=["markdown"])  # type: ignore[arg-type]
    print(doc.get("markdown"))

    # Search
    results = await firecrawl.search("firecrawl", limit=2)
    print(results.get("web", []))

    # Crawl (start + status)
    started = await firecrawl.start_crawl("https://docs.firecrawl.dev", limit=3)
    status = await firecrawl.get_crawl_status(started.id)
    print(status.status)

    # Batch scrape (wait)
    job = await firecrawl.batch_scrape([
        "https://firecrawl.dev",
        "https://docs.firecrawl.dev",
    ], formats=["markdown"], poll_interval=1, timeout=60)
    print(job.status, job.completed, job.total)

asyncio.run(main())
```

```python Python theme={null}
from firecrawl import AsyncFirecrawl

async_firecrawl = AsyncFirecrawl(api_key="fc-YOUR-API-KEY")

parsed = await async_firecrawl.parse(
    b"<!DOCTYPE html><html><body><h1>Async Parse</h1></body></html>",
    filename="upload.html",
    content_type="text/html",
)
```

## Browser

Launch cloud browser sessions and execute code remotely.

### Create a Session

```python Python theme={null}
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR-API-KEY")

session = app.browser()
print(session.id)             # session ID
print(session.cdp_url)        # wss://cdp-proxy.firecrawl.dev/cdp/...
print(session.live_view_url)  # https://liveview.firecrawl.dev/...
```

### Execute Code

```python Python theme={null}
result = app.browser_execute(
    session.id,
    code='await page.goto("https://news.ycombinator.com")\ntitle = await page.title()\nprint(title)',
    language="python",
)
print(result.result)  # "Hacker News"
```

Execute JavaScript instead of Python:

```python Python theme={null}
result = app.browser_execute(
    session.id,
    code='await page.goto("https://example.com"); const t = await page.title(); console.log(t);',
    language="node",
)
```

### Profiles

Save and reuse browser state (cookies, localStorage, etc.) across sessions:

```python Python theme={null}
session = app.browser(
    ttl=600,
    profile={
        "name": "my-profile",
        "save_changes": True,
    },
)
```

### Connect via CDP

For full Playwright control, connect directly using the CDP URL:

```python Python theme={null}
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.connect_over_cdp(session.cdp_url)
    context = browser.contexts[0]
    page = context.pages[0] if context.pages else context.new_page()

    page.goto("https://example.com")
    print(page.title())

    browser.close()
```

### List & Close Sessions

```python Python theme={null}
# List active sessions
sessions = app.list_browsers(status="active")
for s in sessions.sessions:
    print(s.id, s.status, s.created_at)

# Close a session
app.delete_browser(session.id)
```

### Scrape-Bound Interactive Session

Use a scrape job ID to keep interacting with the replayed page context from that scrape:

* `interact(job_id, ...)` runs code in the scrape-bound browser session.
* The first `interact` call auto-initializes the session from the scrape context.
* Additional `interact` calls on the same job ID reuse that live browser state.
* `stop_interaction(job_id)` stops the interactive session when you are done.

```python Python theme={null}
doc = app.scrape(
    "https://example.com",
    actions=[{"type": "click", "selector": "a[href='/pricing']"}],
)

scrape_job_id = doc.metadata_typed.scrape_id
if not scrape_job_id:
    raise RuntimeError("Missing scrape job id")

run = app.interact(
    scrape_job_id,
    code="print(await page.url())",
    language="python",
    timeout=60,
)
print(run.stdout)

app.stop_interaction(scrape_job_id)
```

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
