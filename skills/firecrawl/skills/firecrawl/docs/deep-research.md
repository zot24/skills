> Source: https://docs.firecrawl.dev/use-cases/deep-research.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Deep Research

> Build agentic research tools with deep web search capabilities

Build automated research agents that search the web, scrape full-page content, and synthesize findings with an LLM. Firecrawl handles source discovery and content extraction so you can focus on analysis, not parsing HTML.

## Start with a Template


    Blazing-fast AI search with real-time citations


    Deep research agent with LangGraph and answer validation


    Visual AI research assistant for comprehensive analysis


  **Choose from multiple research templates.** Clone, configure your API key, and start researching.


## How It Works

Build powerful research tools that transform scattered web data into comprehensive insights. The core pattern is a **search → scrape → analyze → repeat** loop: use Firecrawl's search API to discover relevant sources, scrape each source for full content, then feed the results into an LLM to synthesize findings and identify follow-up queries.


    Use the `/search` endpoint to find relevant pages for your research topic.

    <CodeGroup>
      ```python Python
      from firecrawl import Firecrawl

      firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

      results = firecrawl.search(
          "recent advances in quantum computing",
          limit=5,
          scrape_options={"formats": ["markdown", "links"]}
      )
      ```

      ```js Node.js
      import Firecrawl from '@mendable/firecrawl-js';

      const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

      const results = await firecrawl.search(
        'recent advances in quantum computing',
        { limit: 5, scrapeOptions: { formats: ['markdown', 'links'] } }
      );
      ```
    </CodeGroup>


    Extract full content from each result to get detailed information with citations.

    <CodeGroup>
      ```python Python
      for result in results:
          doc = firecrawl.scrape(result["url"], formats=["markdown"])
          # Feed doc content into your LLM for analysis
      ```

      ```js Node.js
      for (const result of results) {
        const doc = await firecrawl.scrape(result.url, { formats: ['markdown'] });
        // Feed doc content into your LLM for analysis
      }
      ```
    </CodeGroup>


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


    Use Firecrawl's crawl and search APIs to build iterative research systems. Start with search results, extract content from relevant pages, follow citation links, and aggregate findings. Combine with LLMs to synthesize comprehensive research reports.


    Yes. Firecrawl can extract data from open-access research papers, academic websites, and publicly available scientific publications. It preserves formatting, citations, and technical content critical for research work.


    Firecrawl maintains source attribution and extracts content exactly as presented on websites. All data includes source URLs and timestamps, ensuring full traceability for research purposes.


    Yes. Set up scheduled crawls to track how information changes over time. This is perfect for monitoring trends, policy changes, or any research requiring temporal data analysis.


    Our crawling infrastructure scales to handle thousands of sources simultaneously. Whether you're analyzing entire industries or tracking global trends, Firecrawl provides the data pipeline you need.


## Related Use Cases

* [AI Platforms](/use-cases/ai-platforms) - Build AI research assistants
* [Content Generation](/use-cases/content-generation) - Research-based content
* [Competitive Intelligence](/use-cases/competitive-intelligence) - Market research
