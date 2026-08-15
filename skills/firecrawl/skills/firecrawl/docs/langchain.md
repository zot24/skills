> Source: https://docs.firecrawl.dev/integrations/langchain.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# LangChain

> Use Firecrawl in LangChain as a document loader or as agent tools.


  **Official package:** [`langchain-firecrawl`](https://pypi.org/project/langchain-firecrawl/) · [source](https://github.com/firecrawl/langchain-firecrawl)

  Scrape, crawl, map, extract, and search from LangChain, as a document loader or as agent tools


## Install

```bash theme={null}
pip install langchain-firecrawl
```

Get a key from [firecrawl.dev](https://www.firecrawl.dev/app/api-keys) and set it in your environment (or pass `api_key=...`):

```bash theme={null}
export FIRECRAWL_API_KEY="fc-your-api-key"
```

## Document loader

`FirecrawlLoader` returns LangChain `Document`s. Choose a `mode`:

| Mode      | What it loads      |
| --------- | ------------------ |
| `scrape`  | One page           |
| `crawl`   | A whole site       |
| `map`     | Discovered URLs    |
| `extract` | Structured data    |
| `search`  | Web search results |

```python theme={null}
from langchain_firecrawl import FirecrawlLoader

loader = FirecrawlLoader(url="https://www.firecrawl.dev", mode="scrape")
docs = loader.load()

print(docs[0].page_content[:200])
print(docs[0].metadata)
```

## Agent tools

Each capability is also a `BaseTool` you can bind to an agent:

```python theme={null}
from langchain_firecrawl import (
    FirecrawlScrape,
    FirecrawlCrawl,
    FirecrawlMap,
    FirecrawlExtract,
    FirecrawlSearch,
)

scrape = FirecrawlScrape()
result = scrape.invoke({"url": "https://www.firecrawl.dev"})
print(result["markdown"])

search = FirecrawlSearch()
print(search.invoke({"query": "best web scraping libraries", "limit": 5}))
```

## LangChain JS

The JavaScript loader ships in `@langchain/community` and takes the Firecrawl JS SDK as a peer dependency:

```bash theme={null}
npm install @langchain/community @mendable/firecrawl-js
```

```typescript theme={null}
import { FireCrawlLoader } from "@langchain/community/document_loaders/web/firecrawl";

const loader = new FireCrawlLoader({
  url: "https://firecrawl.dev",
  apiKey: process.env.FIRECRAWL_API_KEY, // defaults to FIRECRAWL_API_KEY
  mode: "scrape", // "scrape" for a single page, "crawl" for subpages
});

const docs = await loader.load();
```

## Resources

* [`langchain-firecrawl` on PyPI](https://pypi.org/project/langchain-firecrawl/)
* [Firecrawl scrape](/features/scrape) and [crawl](/features/crawl) docs
* [Firecrawl Python SDK](/sdks/python) and [Node SDK](/sdks/node)
