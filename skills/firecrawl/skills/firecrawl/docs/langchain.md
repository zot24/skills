> Source: https://docs.firecrawl.dev/integrations/langchain.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# LangChain

> Use Firecrawl in LangChain as a document loader or as agent tools.

> [!NOTE]
>
> **Official package:** [`langchain-firecrawl`](https://pypi.org/project/langchain-firecrawl/) · [source](https://github.com/firecrawl/langchain-firecrawl)
>
> Scrape, crawl, map, extract, and search from LangChain, as a document loader or as agent tools

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

| Mode | What it loads |
| - | - |
| `scrape` | One page |
| `crawl` | A whole site |
| `map` | Discovered URLs |
| `extract` | Structured data |
| `search` | Web search results |

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

The `FireCrawlLoader` in `@langchain/community` still calls v1 SDK methods, so it fails with the current Firecrawl JS SDK. Until it's updated, call the [Firecrawl Node SDK](https://docs.firecrawl.dev/sdks/node.md) directly and wrap the results in LangChain `Document`s:

```bash theme={null}
npm install firecrawl @langchain/core
```

```typescript theme={null}
import Firecrawl from "firecrawl";
import { Document } from "@langchain/core/documents";

const firecrawl = new Firecrawl(); // reads FIRECRAWL_API_KEY

const crawl = await firecrawl.crawl("https://firecrawl.dev", { limit: 5 });

const docs = crawl.data.map(
  (page) => new Document({ pageContent: page.markdown ?? "", metadata: page.metadata ?? {} })
);
```

## Resources

* [`langchain-firecrawl` on PyPI](https://pypi.org/project/langchain-firecrawl/)
* [Firecrawl scrape](https://docs.firecrawl.dev/features/scrape.md) and [crawl](https://docs.firecrawl.dev/features/crawl.md) docs
* [Firecrawl Python SDK](https://docs.firecrawl.dev/sdks/python.md) and [Node SDK](https://docs.firecrawl.dev/sdks/node.md)


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
