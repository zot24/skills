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

```bash
pip install firecrawl-py
```

## Search the web

```python
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR-API-KEY")
results = app.search("firecrawl web scraping", limit=5)

for result in results.web:
    print(result.title, result.url)
```

## Scrape a page

```python
result = app.scrape("https://example.com")
print(result.markdown)
```


  ```json
  {
    "markdown": "# Example Domain\n\nThis domain is for use in illustrative examples...",
    "metadata": {
      "title": "Example Domain",
      "sourceURL": "https://example.com"
    }
  }
  ```


## Interact with a page

Use Interact to control a live browser session — click buttons, fill forms, and extract dynamic content.

```python
result = app.scrape("https://www.amazon.com", formats=["markdown"])
scrape_id = result.metadata.scrape_id

app.interact(scrape_id, prompt="Search for iPhone 16 Pro Max")
response = app.interact(scrape_id, prompt="Click on the first result and tell me the price")
print(response.output)

app.stop_interaction(scrape_id)
```

## Environment variable

Instead of passing `api_key` directly, set the `FIRECRAWL_API_KEY` environment variable:

```bash
export FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

```python
app = Firecrawl()
```

## Next steps


    All scrape options including formats, actions, and proxies


    Search the web and get full page content


    Click, fill forms, and extract dynamic content


    Full SDK reference with crawl, map, async, and more


