> Source: https://docs.firecrawl.dev/use-cases/deep-research.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Deep Research

> Build agentic research tools with deep web search capabilities

Build automated research agents that search the web, scrape full-page content, and synthesize findings with an LLM. Firecrawl handles source discovery and content extraction so you can focus on analysis, not parsing HTML.

> [!NOTE]
>
> This is the current recommended Deep Research workflow. It is built from Firecrawl Search and Scrape. If you are maintaining the legacy v1 Deep Research API, use the [v1 Deep Research endpoint](https://docs.firecrawl.dev/api-reference/v1-endpoint/deep-research) and plan migration to the Search-based workflow.

## Start with a Template

> [card] [Fireplexity](https://github.com/firecrawl/fireplexity)
>
> Blazing-fast AI search with real-time citations

> [card] [Firesearch](https://github.com/firecrawl/firesearch)
>
> Deep research agent with LangGraph and answer validation

> [card] [Open Researcher](https://github.com/firecrawl/open-researcher)
>
> Visual AI research assistant for comprehensive analysis

> [!NOTE]
>
> **Choose from multiple research templates.** Clone, configure your API key, and start researching.

## How It Works

Build powerful research tools that transform scattered web data into comprehensive insights. The core pattern is a **search → scrape → analyze → repeat** loop: use Firecrawl's search API to discover relevant sources, scrape each source for full content, then feed the results into an LLM to synthesize findings and identify follow-up queries.

**1. Search for sources**

Use the `/search` endpoint to find relevant pages for your research topic.

```python Python theme={null}
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

results = firecrawl.search(
    "recent advances in quantum computing",
    limit=5,
    scrape_options={"formats": ["markdown", "links"]}
)
```

```js Node.js theme={null}
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

const results = await firecrawl.search(
  'recent advances in quantum computing',
  { limit: 5, scrapeOptions: { formats: ['markdown', 'links'] } }
);
```

**2. Scrape discovered pages**

Extract full content from each result to get detailed information with citations.

```python Python theme={null}
for result in results:
    doc = firecrawl.scrape(result["url"], formats=["markdown"])
    # Feed doc content into your LLM for analysis
```

```js Node.js theme={null}
for (const result of results) {
  const doc = await firecrawl.scrape(result.url, { formats: ['markdown'] });
  // Feed doc content into your LLM for analysis
}
```

**3. Analyze and iterate**

Use an LLM to synthesize findings, identify gaps, and generate follow-up queries. Repeat the loop until your research question is fully answered.

## Why Researchers Choose Firecrawl

### Accelerate Research from Weeks to Hours

Build automated research systems that discover, read, and synthesize information from across the web. Create tools that deliver comprehensive reports with full citations, eliminating manual searching through hundreds of sources.

### Ensure Research Completeness

Reduce the risk of missing critical information. Build systems that follow citation chains, discover related sources, and surface insights that traditional search methods miss.

## Research Tool Capabilities

* **Iterative Exploration**: Build tools that automatically discover related topics and sources
* **Multi-Source Synthesis**: Combine information from hundreds of websites
* **Citation Preservation**: Maintain full source attribution in your research outputs
* **Intelligent Summarization**: Extract key findings and insights for analysis
* **Trend Detection**: Identify patterns across multiple sources

## FAQs

> [accordion] How can I build research tools with Firecrawl?
>
> Use Firecrawl's crawl and search APIs to build iterative research systems. Start with search results, extract content from relevant pages, follow citation links, and aggregate findings. Combine with LLMs to synthesize comprehensive research reports.

> [accordion] Can Firecrawl handle academic and scientific websites?
>
> Yes. Firecrawl can extract data from open-access research papers, academic websites, and publicly available scientific publications. It preserves formatting, citations, and technical content critical for research work.

> [accordion] How do I ensure research data accuracy?
>
> Firecrawl maintains source attribution and extracts content exactly as presented on websites. All data includes source URLs and timestamps, ensuring full traceability for research purposes.

> [accordion] Can I use Firecrawl for longitudinal studies?
>
> Yes. Set up scheduled crawls to track how information changes over time. This is perfect for monitoring trends, policy changes, or any research requiring temporal data analysis.

> [accordion] How does Firecrawl handle large-scale research projects?
>
> Our crawling infrastructure scales to handle thousands of sources simultaneously. Whether you're analyzing entire industries or tracking global trends, Firecrawl provides the data pipeline you need.

## Related Use Cases

* [AI Platforms](https://docs.firecrawl.dev/use-cases/ai-platforms.md) - Build AI research assistants
* [Content Generation](https://docs.firecrawl.dev/use-cases/content-generation.md) - Research-based content
* [Competitive Intelligence](https://docs.firecrawl.dev/use-cases/competitive-intelligence.md) - Market research


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
