> Source: https://docs.firecrawl.dev/integrations/camelai.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Camel AI

> Firecrawl integrates with Camel AI as a data loader.


  **Official CAMEL docs:** [docs.camel-ai.org/key\_modules/loaders](https://docs.camel-ai.org/key_modules/loaders)

  Firecrawl ships as a CAMEL loader, turning any site into LLM-ready markdown for your agents


## Installation

```bash theme={null}
pip install camel-ai
```

Set your Firecrawl key so the loader picks it up automatically:

```bash theme={null}
export FIRECRAWL_API_KEY="fc-your-api-key"
```

## Usage

With Camel AI and Firecrawl you can quickly build multi-agent systems that use data from the web.

### Using Firecrawl to Gather an Entire Website

`crawl` returns once the job finishes. Check `status`, then read the markdown from `data`.

```python theme={null}
from camel.loaders import Firecrawl

firecrawl = Firecrawl()

response = firecrawl.crawl(url="https://www.camel-ai.org/about")
print(response["status"])  # "completed" when the crawl has finished

print(response["data"][0]["markdown"])
```

### Using Firecrawl to Gather a Single Page

```python theme={null}
from camel.loaders import Firecrawl

firecrawl = Firecrawl()

response = firecrawl.scrape(url="https://www.camel-ai.org/about")
print(response["markdown"])
```


  `Firecrawl()` reads `FIRECRAWL_API_KEY` from the environment. Pass `api_key=...` to override it, or `api_url=...` to point at a [self-hosted](/contributing/self-host) instance.


## Resources

* [CAMEL loaders documentation](https://docs.camel-ai.org/key_modules/loaders)
* [CAMEL and Firecrawl walkthrough](https://www.camel-ai.org/blogs/firecrawl)
* [Firecrawl scrape](/features/scrape) and [crawl](/features/crawl) docs
