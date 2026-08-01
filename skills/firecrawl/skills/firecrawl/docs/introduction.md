> Source: https://docs.firecrawl.dev/introduction.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Introduction

> Search the web, scrape any page, and interact with it, all through one API.


  **For AI agents:** Use [llms.txt](/llms.txt) for a full index of all documentation.


<div className="firecrawl-cta-box">
  <div style={{ display: "flex", alignItems: "flex-start", gap: "8px", marginBottom: "8px" }}>
    <Icon icon="sack-dollar" color="#ff4d00" size={22} />

    <div className="firecrawl-cta-title" style={{ margin: 0 }}>
      <span style={{ color: "#ff4d00" }}>Bounty: 5,000 credit reward</span>
      <span style={{ fontWeight: 400 }}> for solid feedback on Firecrawl</span>
    </div>
  </div>

  <p className="firecrawl-cta-description">
    To qualify, complete a high-signal interview (thoughtful, concrete use cases, etc) with our Firecrawl Feedback Assistant. Only takes a few minutes, can be stopped at any time, and is both human/agent-friendly (just paste the link into your agentic harness!). New to Firecrawl? Your take still counts.
  </p>

  <a href={"https://www.firecrawl.dev/survey/dsag9?src=" + (props.src || "docs-introduction")} className="firecrawl-cta-btn-primary firecrawl-cta-btn-inline">
    Start the interview
  </a>

  <p className="firecrawl-cta-description" style={{ fontSize: "12px", fontStyle: "italic", margin: "12px 0 0 0" }}>
    Include your email to be eligible. Interviews are reviewed for quality at the end of each week.
  </p>
</div>

## Get started

<McpClientSelector />

### Install the Firecrawl CLI

One command installs the Firecrawl CLI, authenticates in your browser, and adds skills to every detected coding agent.

```bash theme={null}
npx -y firecrawl-cli@latest init --all --browser
```


  Restart your coding agent after setup so it can discover the new skills. See
  [Skills + CLI](/sdks/cli) for the full setup.


### Set up with an agent

Provide your agent with this Firecrawl setup prompt.

<AgentSetupButton />

### Build and test directly


    Create a free account for direct API access and higher limits


    Test Firecrawl in the browser without writing code


***

## What can Firecrawl do?


    Search the web and get full page content from results


    Extract content from any URL as markdown, HTML, or structured JSON


    Continue working with any scraped page: click, fill forms, extract dynamic
    content


### Why Firecrawl?

* **LLM-ready output**: Clean markdown, structured JSON, screenshots, and more.
* **Handles the hard stuff**: Proxies, anti-bot, JavaScript rendering, and dynamic content.
* **Reliable**: Built for production with high uptime and consistent results.
* **Fast**: Results in seconds, optimized for high throughput.
* **MCP Server**: Connect Firecrawl to any AI tool via the [Model Context Protocol](/mcp-server).

***

## Search

Search the web and get full page content from results in one call. See the [Search feature docs](/features/search) for all options.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  results = firecrawl.search(
      query="firecrawl",
      limit=3,
  )
  print(results)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const results = await firecrawl.search('firecrawl', {
    limit: 3,
    scrapeOptions: { formats: ['markdown'] }
  });
  console.log(results);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/search" \
    -H "Content-Type: application/json" \
    -d '{
      "query": "firecrawl",
      "limit": 3
    }'
  ```

  ```bash CLI
  # Search the web
  firecrawl search "firecrawl web scraping" --limit 5 --pretty
  ```
</CodeGroup>


  SDKs will return the data object directly. cURL will return the complete payload.

  ```json JSON
  {
    "success": true,
    "data": {
      "web": [
        {
          "url": "https://www.firecrawl.dev/",
          "title": "Firecrawl - The Web Data API for AI",
          "description": "The web crawling, scraping, and search API for AI. Built for scale. Firecrawl delivers the entire internet to AI agents and builders.",
          "position": 1
        },
        {
          "url": "https://github.com/firecrawl/firecrawl",
          "title": "mendableai/firecrawl: Turn entire websites into LLM-ready ... - GitHub",
          "description": "Firecrawl is an API service that takes a URL, crawls it, and converts it into clean markdown or structured data.",
          "position": 2
        },
        ...
      ],
      "images": [
        {
          "title": "Quickstart | Firecrawl",
          "imageUrl": "https://mintlify.s3.us-west-1.amazonaws.com/firecrawl/logo/logo.png",
          "imageWidth": 5814,
          "imageHeight": 1200,
          "url": "https://docs.firecrawl.dev/",
          "position": 1
        },
        ...
      ],
      "news": [
        {
          "title": "Y Combinator startup Firecrawl is ready to pay $1M to hire three AI agents as employees",
          "url": "https://techcrunch.com/2025/05/17/y-combinator-startup-firecrawl-is-ready-to-pay-1m-to-hire-three-ai-agents-as-employees/",
          "snippet": "It's now placed three new ads on YC's job board for “AI agents only” and has set aside a $1 million budget total to make it happen.",
          "date": "3 months ago",
          "position": 1
        },
        ...
      ]
    }
  }
  ```


## Scrape

Scrape any URL and get its content in markdown, HTML, or other formats. See the [Scrape feature docs](/features/scrape) for all options.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  # Scrape a website:
  doc = firecrawl.scrape("https://firecrawl.dev", formats=["markdown", "html"])
  print(doc)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  // Scrape a website:
  const doc = await firecrawl.scrape('https://firecrawl.dev', { formats: ['markdown', 'html'] });
  console.log(doc);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://firecrawl.dev",
      "formats": ["markdown", "html"]
    }'
  ```

  ```bash CLI
  # Scrape a URL and get markdown
  firecrawl https://firecrawl.dev

  # With multiple formats (returns JSON)
  firecrawl https://firecrawl.dev --format markdown,html,links --pretty
  ```
</CodeGroup>


  SDKs will return the data object directly. cURL will return the payload exactly as shown below.

  ```json
  {
    "success": true,
    "data" : {
      "markdown": "Launch Week I is here! [See our Day 2 Release 🚀](https://www.firecrawl.dev/blog/launch-week-i-day-2-doubled-rate-limits)[💥 Get 2 months free...",
      "html": "<!DOCTYPE html><html lang=\"en\" class=\"light\" style=\"color-scheme: light;\"><body class=\"__variable_36bd41 __variable_d7dc5d font-inter ...",
      "metadata": {
        "title": "Home - Firecrawl",
        "description": "Firecrawl crawls and converts any website into clean markdown.",
        "language": "en",
        "keywords": "Firecrawl,Markdown,Data,Mendable,Langchain",
        "robots": "follow, index",
        "ogTitle": "Firecrawl",
        "ogDescription": "Turn any website into LLM-ready data.",
        "ogUrl": "https://www.firecrawl.dev/",
        "ogImage": "https://www.firecrawl.dev/og.png?123",
        "ogLocaleAlternate": [],
        "ogSiteName": "Firecrawl",
        "sourceURL": "https://firecrawl.dev",
        "statusCode": 200,
        "contentType": "text/html"
      }
    }
  }
  ```


## Interact

Scrape a page, then keep working with it: click buttons, fill forms, extract dynamic content, or navigate deeper. Describe what you want in plain English or write code for full control. See the [Interact feature docs](/features/interact) for all options.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  app = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  # 1. Scrape Amazon's homepage
  result = app.scrape("https://www.amazon.com", formats=["markdown"])
  scrape_id = result.metadata.scrape_id

  # 2. Interact — search for a product and get its price
  app.interact(scrape_id, prompt="Search for iPhone 16 Pro Max")
  response = app.interact(scrape_id, prompt="Click on the first result and tell me the price")
  print(response.output)

  # 3. Stop the session
  app.stop_interaction(scrape_id)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const app = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: 'fc-YOUR-API-KEY',
  });

  // 1. Scrape Amazon's homepage
  const result = await app.scrape('https://www.amazon.com', { formats: ['markdown'] });
  const scrapeId = result.metadata?.scrapeId;

  // 2. Interact — search for a product and get its price
  await app.interact(scrapeId, { prompt: 'Search for iPhone 16 Pro Max' });
  const response = await app.interact(scrapeId, { prompt: 'Click on the first result and tell me the price' });
  console.log(response.output);

  // 3. Stop the session
  await app.stopInteraction(scrapeId);
  ```

  ```bash cURL
  # 1. Scrape Amazon's homepage
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  RESPONSE=$(curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{"url": "https://www.amazon.com", "formats": ["markdown"]}')

  SCRAPE_ID=$(echo $RESPONSE | jq -r '.data.metadata.scrapeId')

  # 2. Interact — search for a product and get its price
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
    -H "Content-Type: application/json" \
    -d '{"prompt": "Search for iPhone 16 Pro Max"}'

  curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
    -H "Content-Type: application/json" \
    -d '{"prompt": "Click on the first result and tell me the price"}'

  # 3. Stop the session
  curl -s -X DELETE "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact"
  ```

  ```bash CLI
  # 1. Scrape Amazon's homepage (scrape ID is saved automatically)
  firecrawl scrape https://www.amazon.com

  # 2. Interact — search for a product and get its price
  firecrawl interact "Search for iPhone 16 Pro Max"
  firecrawl interact "Click on the first result and tell me the price"

  # 3. Stop the session
  firecrawl interact stop
  ```
</CodeGroup>


  ```json Response
  {
    "success": true,
    "cdpUrl": "wss://browser.firecrawl.dev/...",
    "liveViewUrl": "https://liveview.firecrawl.dev/...",
    "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
    "output": "The iPhone 16 Pro Max (256GB) is priced at $1,199.00.",
    "exitCode": 0,
    "killed": false
  }
  ```


***

## More capabilities


    Autonomous web data gathering powered by AI


    Click, fill forms, extract dynamic content


    Async event delivery


    Managed browser sessions for interactive workflows


    Discover all URLs on a website


    Recursively gather content from entire sites


***

## Resources


    Complete API documentation with interactive examples


    Python, Node.js, CLI, and community SDKs


    Self-host Firecrawl or contribute to the project


    LangChain, LlamaIndex, OpenAI, and more


