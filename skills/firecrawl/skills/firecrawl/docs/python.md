> Source: https://docs.firecrawl.dev/quickstarts/python.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Python

> Get started with Firecrawl in Python. Scrape, search, and interact with web data using the official SDK.

## Prerequisites

* Python 3.8+
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)

## Install the SDK

```bash theme={null}
pip install firecrawl
```

## Search the web

```python theme={null}
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR-API-KEY")
results = app.search("firecrawl web scraping", limit=5)

for result in results.web:
    print(result.title, result.url)
```

## Scrape a page

```python theme={null}
result = app.scrape("https://example.com")
print(result.markdown)
```

> [accordion] Example response
>
> ```json
> {
>   "markdown": "# Example Domain\n\nThis domain is for use in illustrative examples...",
>   "metadata": {
>     "title": "Example Domain",
>     "source_url": "https://example.com"
>   }
> }
> ```

## Interact with a page

Use Interact to control a live browser session — click buttons, fill forms, and extract dynamic content.

```python theme={null}
result = app.scrape("https://www.amazon.com", formats=["markdown"])
scrape_id = result.metadata.scrape_id

app.interact(scrape_id, prompt="Search for iPhone 16 Pro Max")
response = app.interact(scrape_id, prompt="Click on the first result and tell me the price")
print(response.output)

app.stop_interaction(scrape_id)
```

## Environment variable

Instead of passing `api_key` directly, set the `FIRECRAWL_API_KEY` environment variable:

```bash theme={null}
export FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

```python theme={null}
app = Firecrawl()
```

## Next steps

> [card] [Scrape docs](https://docs.firecrawl.dev/features/scrape.md)
>
> All scrape options including formats, actions, and proxies

> [card] [Search docs](https://docs.firecrawl.dev/features/search.md)
>
> Search the web and get full page content

> [card] [Interact docs](https://docs.firecrawl.dev/features/interact.md)
>
> Click, fill forms, and extract dynamic content

> [card] [Python SDK reference](https://docs.firecrawl.dev/sdks/python.md)
>
> Full SDK reference with crawl, map, async, and more


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
