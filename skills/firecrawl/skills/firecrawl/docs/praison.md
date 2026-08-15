> Source: https://docs.firecrawl.dev/integrations/praison.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Praison AI

> Scrape the web with Firecrawl as a Praison AI tool


  **Official Praison docs:** [praison.ai/docs/tools/external/firecrawl](https://praison.ai/docs/tools/external/firecrawl)

  Give Praison agents live web scraping through Firecrawl


## Overview

Praison AI can call Firecrawl as a tool so agents scrape web pages and use the cleaned content during runs.

## Quick start

1. Install the tools extra:

```bash theme={null}
pip install "praisonai[tools]"
```

2. Set `FIRECRAWL_API_KEY` for Firecrawl cloud
3. Pass a Firecrawl tool to your agent:

```python theme={null}
from praisonaiagents import Agent
from praisonai_tools import FirecrawlTool

agent = Agent(
    name="WebScraper",
    instructions="You are a web scraping assistant. Use Firecrawl to extract content.",
    tools=[FirecrawlTool()],
)

print(agent.chat("Scrape the content from https://praison.ai/docs"))
```

## What you can do

| Capability | Use case                                                               |
| ---------- | ---------------------------------------------------------------------- |
| **Scrape** | Fetch cleaned page content into agent context (`FirecrawlTool.scrape`) |
| **Crawl**  | Collect pages from a site (`FirecrawlTool.crawl(url, limit=10)`)       |

## Resources

* [Praison `FirecrawlTool` guide](https://praison.ai/docs/tools/external/firecrawl)
* [Firecrawl scrape docs](/features/scrape)
