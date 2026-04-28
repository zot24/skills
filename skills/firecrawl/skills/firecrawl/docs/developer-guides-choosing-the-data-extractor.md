> Source: https://docs.firecrawl.dev/developer-guides/usage-guides/choosing-the-data-extractor.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Choosing the Data Extractor

> Compare /agent, /extract, and /scrape (JSON mode) to pick the right tool for structured data extraction

Firecrawl offers three approaches for extracting structured data from web pages. Each serves different use cases with varying levels of automation and control.

## Quick Comparison

| Feature             | `/agent`                               | `/extract`                                 | `/scrape` (JSON mode)        |
| ------------------- | -------------------------------------- | ------------------------------------------ | ---------------------------- |
| **Status**          | Active                                 | Use `/agent` instead                       | Active                       |
| **URL Required**    | No (optional)                          | Yes (wildcards supported)                  | Yes (single URL)             |
| **Scope**           | Web-wide discovery                     | Multiple pages/domains                     | Single page                  |
| **URL Discovery**   | Autonomous web search                  | Crawls from given URLs                     | None                         |
| **Processing**      | Asynchronous                           | Asynchronous                               | Synchronous                  |
| **Schema Required** | No (prompt or schema)                  | No (prompt or schema)                      | No (prompt or schema)        |
| **Pricing**         | Dynamic (5 free runs/day)              | Token-based (1 credit = 15 tokens)         | 1 credit/page                |
| **Best For**        | Research, discovery, complex gathering | Multi-page extraction (when you know URLs) | Known single-page extraction |

## 1. `/agent` Endpoint

The `/agent` endpoint is Firecrawl's most advanced offering—the successor to `/extract`. It uses AI agents to autonomously search, navigate, and gather data from across the web.

### Key Characteristics

* **URLs Optional**: Just describe what you need via `prompt`; URLs are completely optional
* **Autonomous Navigation**: The agent searches and navigates deep into sites to find your data
* **Deep Web Search**: Autonomously discovers information across multiple domains and pages
* **Parallel Processing**: Processes multiple sources simultaneously for faster results
* **Models Available**: `spark-1-mini` (default, 60% cheaper) and `spark-1-pro` (higher accuracy)

### Example

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl
  from pydantic import BaseModel, Field
  from typing import List, Optional

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  class Founder(BaseModel):
      name: str = Field(description="Full name of the founder")
      role: Optional[str] = Field(None, description="Role or position")
      background: Optional[str] = Field(None, description="Professional background")

  class FoundersSchema(BaseModel):
      founders: List[Founder] = Field(description="List of founders")

  result = app.agent(
      prompt="Find the founders of Firecrawl",
      schema=FoundersSchema,
      model="spark-1-mini",
      max_credits=100
  )

  print(result.data)
  ```

  ```js Node
  import Firecrawl from '@mendable/firecrawl-js';
  import { z } from 'zod';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  const result = await firecrawl.agent({
    prompt: "Find the founders of Firecrawl",
    schema: z.object({
      founders: z.array(z.object({
        name: z.string().describe("Full name of the founder"),
        role: z.string().describe("Role or position").optional(),
        background: z.string().describe("Professional background").optional()
      })).describe("List of founders")
    }),
    model: "spark-1-mini",
    maxCredits: 100
  });

  console.log(result.data);
  ```

  ```bash cURL
  curl -X POST "https://api.firecrawl.dev/v2/agent" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "prompt": "Find the founders of Firecrawl",
      "model": "spark-1-mini",
      "maxCredits": 100,
      "schema": {
        "type": "object",
        "properties": {
          "founders": {
            "type": "array",
            "description": "List of founders",
            "items": {
              "type": "object",
              "properties": {
                "name": { "type": "string", "description": "Full name" },
                "role": { "type": "string", "description": "Role or position" },
                "background": { "type": "string", "description": "Professional background" }
              },
              "required": ["name"]
            }
          }
        },
        "required": ["founders"]
      }
    }'
  ```
</CodeGroup>

### Best Use Case: Autonomous Research & Discovery

**Scenario**: You need to find information about AI startups that raised Series A funding, including their founders and funding amounts.

**Why `/agent`**: You don't know which websites contain this information. The agent will autonomously search the web, navigate to relevant sources (Crunchbase, news sites, company pages), and compile the structured data for you.

For more details, see the [Agent documentation](/features/agent).

***

## 2. `/extract` Endpoint


  **Use `/agent` instead**: We recommend migrating to [`/agent`](/features/agent)—it's faster, more reliable, doesn't require URLs, and handles all `/extract` use cases plus more.


The `/extract` endpoint collects structured data from specified URLs or entire domains using LLM-powered extraction.

### Key Characteristics

* **URLs Typically Required**: Provide at least one URL (supports wildcards like `example.com/*`)
* **Domain Crawling**: Can crawl and parse all URLs discovered in a domain
* **Web Search Enhancement**: Optional `enableWebSearch` to follow links outside specified domains
* **Schema Optional**: Supports strict JSON schema OR natural language prompts
* **Async Processing**: Returns job ID for status checking

### The URL Limitation

The fundamental challenge with `/extract` is that you typically need to know URLs upfront:

1. **Discovery gap**: For tasks like "find YC W24 companies," you don't know which URLs contain the data. You'd need a separate search step before calling `/extract`.
2. **Awkward web search**: While `enableWebSearch` exists, it's constrained to start from URLs you provide—an awkward workflow for discovery tasks.
3. **Why `/agent` was created**: `/extract` is good at extracting from known locations, but less effective at discovering where data lives.

### Example

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

  schema = {
      "type": "object",
      "properties": {"description": {"type": "string"}},
      "required": ["description"],
  }

  res = firecrawl.extract(
      urls=["https://docs.firecrawl.dev"],
      prompt="Extract the page description",
      schema=schema,
  )

  print(res.data["description"])
  ```

  ```js Node
  import Firecrawl from '@mendable/firecrawl-js';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  const schema = {
    type: 'object',
    properties: {
      title: { type: 'string' }
    },
    required: ['title']
  };

  const res = await firecrawl.extract({
    urls: ['https://docs.firecrawl.dev'],
    prompt: 'Extract the page title',
    schema,
    scrapeOptions: { formats: [{ type: 'json', prompt: 'Extract', schema }] }
  });

  console.log(res.status || res.success, res.data);
  ```

  ```bash cURL
  curl -s -X POST "https://api.firecrawl.dev/v2/extract" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "urls": ["https://docs.firecrawl.dev"],
      "prompt": "Extract the page title",
      "schema": {
        "type": "object",
        "properties": {"title": {"type": "string"}},
        "required": ["title"]
      },
      "scrapeOptions": {
        "formats": [{"type": "json", "prompt": "Extract", "schema": {"type": "object"}}]
      }
    }'
  ```
</CodeGroup>

### Best Use Case: Targeted Multi-Page Extraction

**Scenario**: You have your competitor's documentation URL and want to extract all their API endpoints from `docs.competitor.com/*`.

**Why `/extract` worked here**: You knew the exact domain. But even then, `/agent` with URLs provided would typically give better results today.

For more details, see the [Extract documentation](/features/extract).

***

## 3. `/scrape` Endpoint with JSON Mode

The `/scrape` endpoint with JSON mode is the most controlled approach—it extracts structured data from a single known URL using an LLM to parse the page content into your specified schema.

### Key Characteristics

* **Single URL Only**: Designed for extracting data from one specific page at a time
* **Exact URL Required**: You must know the precise URL containing the data
* **Schema Optional**: Can use JSON schema OR just a prompt (LLM chooses structure)
* **Synchronous**: Returns data immediately (no job polling needed)
* **Additional Formats**: Can combine JSON extraction with markdown, HTML, screenshots in one request

### Example

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl
  from pydantic import BaseModel

  app = Firecrawl(api_key="fc-YOUR-API-KEY")

  class CompanyInfo(BaseModel):
      company_mission: str
      supports_sso: bool
      is_open_source: bool
      is_in_yc: bool

  result = app.scrape(
      'https://firecrawl.dev',
      formats=[{
        "type": "json",
        "schema": CompanyInfo.model_json_schema()
      }],
      only_main_content=False,
      timeout=120000
  )

  print(result)
  ```

  ```js Node
  import Firecrawl from "@mendable/firecrawl-js";
  import { z } from "zod";

  const app = new Firecrawl({
    apiKey: "fc-YOUR_API_KEY"
  });

  // Define schema to extract contents into
  const schema = z.object({
    company_mission: z.string(),
    supports_sso: z.boolean(),
    is_open_source: z.boolean(),
    is_in_yc: z.boolean()
  });

  const result = await app.scrape("https://firecrawl.dev", {
    formats: [{
      type: "json",
      schema: schema
    }],
  });

  console.log(result);
  ```

  ```bash cURL
  curl -X POST https://api.firecrawl.dev/v2/scrape \
      -H 'Content-Type: application/json' \
      -H 'Authorization: Bearer YOUR_API_KEY' \
      -d '{
        "url": "https://firecrawl.dev",
        "formats": [ {
          "type": "json",
          "schema": {
            "type": "object",
            "properties": {
              "company_mission": {
                        "type": "string"
              },
              "supports_sso": {
                        "type": "boolean"
              },
              "is_open_source": {
                        "type": "boolean"
              },
              "is_in_yc": {
                        "type": "boolean"
              }
            },
            "required": [
              "company_mission",
              "supports_sso",
              "is_open_source",
              "is_in_yc"
            ]
          }
        } ]
      }'
  ```
</CodeGroup>

### Best Use Case: Single-Page Precision Extraction

**Scenario**: You're building a price monitoring tool and need to extract the price, stock status, and product details from a specific product page you already have the URL for.

**Why `/scrape` with JSON mode**: You know exactly which page contains the data, need precise single-page extraction, and want synchronous results without job management overhead.

For more details, see the [JSON mode documentation](/features/llm-extract).

***

## Decision Guide

**Do you know the exact URL(s) containing your data?**

* **NO** → Use `/agent` (autonomous web discovery)
* **YES**
  * **Single page?** → Use `/scrape` with JSON mode
  * **Multiple pages?** → Use `/agent` with URLs (or batch `/scrape`)

### Recommendations by Scenario

| Scenario                                           | Recommended Endpoint            |
| -------------------------------------------------- | ------------------------------- |
| "Find all AI startups and their funding"           | `/agent`                        |
| "Extract data from this specific product page"     | `/scrape` (JSON mode)           |
| "Get all blog posts from competitor.com"           | `/agent` with URL               |
| "Monitor prices across multiple known URLs"        | `/scrape` with batch processing |
| "Research companies in a specific industry"        | `/agent`                        |
| "Extract contact info from 50 known company pages" | `/scrape` with batch processing |

***

## Pricing

| Endpoint              | Cost                               | Notes                                 |
| --------------------- | ---------------------------------- | ------------------------------------- |
| `/scrape` (JSON mode) | 1 credit/page                      | Fixed, predictable                    |
| `/extract`            | Token-based (1 credit = 15 tokens) | Variable based on content             |
| `/agent`              | Dynamic                            | 5 free runs/day; varies by complexity |

### Example: "Find the founders of Firecrawl"

| Endpoint   | How It Works                                    | Credits Used           |
| ---------- | ----------------------------------------------- | ---------------------- |
| `/scrape`  | You find the URL manually, then scrape 1 page   | \~1 credit             |
| `/extract` | You provide URL(s), it extracts structured data | Variable (token-based) |
| `/agent`   | Just send the prompt—agent finds and extracts   | \~100–500 credits      |

**Tradeoff**: `/scrape` is cheapest but requires you to know the URL. `/agent` costs more but handles discovery automatically.

For detailed pricing, see [Firecrawl Pricing](https://firecrawl.dev/pricing).

***

## Migration: `/extract` → `/agent`

If you're currently using `/extract`, migration is straightforward:

**Before (extract):**

```python
result = app.extract(
    urls=["https://example.com/*"],
    prompt="Extract product information",
    schema=schema
)
```

**After (agent):**

```python
result = app.agent(
    urls=["https://example.com"],  # Optional - can omit entirely
    prompt="Extract product information from example.com",
    schema=schema,
    model="spark-1-mini"  # or "spark-1-pro" for higher accuracy
)
```

The key advantage: with `/agent`, you can drop the URLs entirely and just describe what you need.

***

## Key Takeaways

1. **Know the exact URL?** Use `/scrape` with JSON mode—it's the cheapest (1 credit/page), fastest (synchronous), and most predictable option.

2. **Need autonomous research?** Use `/agent`—it handles discovery automatically with 5 free runs/day, then dynamic pricing based on complexity.

3. **Migrate from `/extract`** to `/agent` for new projects—`/agent` is the successor with better capabilities.

4. **Cost vs. convenience tradeoff**: `/scrape` is most cost-effective when you know your URLs; `/agent` costs more but eliminates manual URL discovery.

***

## Further Reading

* [Agent documentation](/features/agent)
* [Agent models](/features/models)
* [JSON mode documentation](/features/llm-extract)
* [Extract documentation](/features/extract)
* [Batch scraping](/features/batch-scrape)
