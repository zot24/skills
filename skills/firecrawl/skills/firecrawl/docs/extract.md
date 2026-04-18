[Skip to main content](https://docs.firecrawl.dev/features/llm-extract#content-area)

[Firecrawl Docs home page![light logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=c45b3c967c19a39190e76fe8e9c2ed5a)![dark logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=3fee4abe033bd3c26e8ad92043a91c17)](https://firecrawl.dev/)

v2
![US](https://d3gk2c5xim1je2.cloudfront.net/flags/US.svg)

English

Search...

Ctrl K

Search...

Navigation

Scrape

JSON mode - Structured result

[Documentation](https://docs.firecrawl.dev/introduction) [SDKs](https://docs.firecrawl.dev/sdks/overview) [Integrations](https://www.firecrawl.dev/app) [API Reference](https://docs.firecrawl.dev/api-reference/v2-introduction)

- [Playground](https://firecrawl.dev/playground)
- [Blog](https://firecrawl.dev/blog)
- [Community](https://discord.gg/firecrawl)
- [Changelog](https://firecrawl.dev/changelog)

##### Get Started

- [Introduction](https://docs.firecrawl.dev/introduction)
- [Skill + CLI](https://docs.firecrawl.dev/sdks/cli)
- [MCP Server](https://docs.firecrawl.dev/mcp-server)
- [Advanced Scraping Guide](https://docs.firecrawl.dev/advanced-scraping-guide)
- Plans & Billing


##### Core Endpoints

- [Search](https://docs.firecrawl.dev/features/search)
- Scrape



  - [Scrape](https://docs.firecrawl.dev/features/scrape)
  - [Faster Scraping](https://docs.firecrawl.dev/features/fast-scraping)
  - [Batch Scrape](https://docs.firecrawl.dev/features/batch-scrape)
  - [JSON mode](https://docs.firecrawl.dev/features/llm-extract)
  - [Change Tracking](https://docs.firecrawl.dev/features/change-tracking)
  - [Enhanced Mode](https://docs.firecrawl.dev/features/enhanced-mode)
  - [Proxies](https://docs.firecrawl.dev/features/proxies)
  - [Document Parsing](https://docs.firecrawl.dev/features/document-parsing)
- [Interact](https://docs.firecrawl.dev/features/interact)

##### More

- [Map](https://docs.firecrawl.dev/features/map)
- [Crawl](https://docs.firecrawl.dev/features/crawl)
- Agent (Research Preview)


##### Quickstarts

- Node.js

- Serverless

- PHP

- Ruby

- Python

- [Go](https://docs.firecrawl.dev/quickstarts/go)
- [Rust](https://docs.firecrawl.dev/quickstarts/rust)
- [Elixir](https://docs.firecrawl.dev/quickstarts/elixir)
- Java

- .NET


##### Developer Guides

- [OpenClaw](https://docs.firecrawl.dev/developer-guides/openclaw)
- [Full-Stack Templates](https://docs.firecrawl.dev/developer-guides/examples)
- Usage Guides

- LLM SDKs and Frameworks

- Cookbooks

- MCP Setup Guides

- Common Sites

- Workflow Automation


##### Webhooks

- [Overview](https://docs.firecrawl.dev/webhooks/overview)
- [Event Types](https://docs.firecrawl.dev/webhooks/events)
- [Security](https://docs.firecrawl.dev/webhooks/security)
- [Testing](https://docs.firecrawl.dev/webhooks/testing)

##### Use Cases

- [Overview](https://docs.firecrawl.dev/use-cases/overview)
- [AI Platforms](https://docs.firecrawl.dev/use-cases/ai-platforms)
- [Lead Enrichment](https://docs.firecrawl.dev/use-cases/lead-enrichment)
- [SEO Platforms](https://docs.firecrawl.dev/use-cases/seo-platforms)
- [Deep Research](https://docs.firecrawl.dev/use-cases/deep-research)
- View more


##### Dashboard

- [Overview](https://docs.firecrawl.dev/dashboard)

##### Contributing

- [Open Source vs Cloud](https://docs.firecrawl.dev/contributing/open-source-or-cloud)
- [Running Locally](https://docs.firecrawl.dev/contributing/guide)
- [Self-hosting](https://docs.firecrawl.dev/contributing/self-host)

On this page

- [Scrape and extract structured data with Firecrawl](https://docs.firecrawl.dev/features/llm-extract#scrape-and-extract-structured-data-with-firecrawl)
- [Extract structured data](https://docs.firecrawl.dev/features/llm-extract#extract-structured-data)
- [JSON mode via /scrape](https://docs.firecrawl.dev/features/llm-extract#json-mode-via-%2Fscrape)
- [Structured data without schema](https://docs.firecrawl.dev/features/llm-extract#structured-data-without-schema)
- [Real-world example: Extracting company information](https://docs.firecrawl.dev/features/llm-extract#real-world-example-extracting-company-information)
- [JSON format options](https://docs.firecrawl.dev/features/llm-extract#json-format-options)
- [Tips for consistent extraction](https://docs.firecrawl.dev/features/llm-extract#tips-for-consistent-extraction)

![Firecrawl](https://docs.firecrawl.dev/logo/light.svg)![Firecrawl](https://docs.firecrawl.dev/logo/dark.svg)

### Ready to build?

Start getting web data for free and scale seamlessly as your project expands. **No credit card needed.**

[Start for free](https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=start_for_free) [See our plans](https://www.firecrawl.dev/pricing?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=see_our_plans)

**v2 API Change:** JSON schema extraction is fully supported in v2, but the API format has changed. In v2, the schema is embedded directly inside the format object as `formats: [{type: "json", schema: {...}}]`. The v1 `jsonOptions` parameter no longer exists in v2.

## [​](https://docs.firecrawl.dev/features/llm-extract\#scrape-and-extract-structured-data-with-firecrawl)  Scrape and extract structured data with Firecrawl

Firecrawl uses AI to get structured data from web pages in 3 steps:

1. **Set the Schema (optional):**
Define a JSON schema (using OpenAI’s format) to specify the data you want, or just provide a `prompt` if you don’t need a strict schema, along with the webpage URL.
2. **Make the Request:**
Send your URL and schema to our scrape endpoint using JSON mode. See how here:
[Scrape Endpoint Documentation](https://docs.firecrawl.dev/api-reference/endpoint/scrape)
3. **Get Your Data:**
Get back clean, structured data matching your schema that you can use right away.

This makes getting web data in the format you need quick and easy.

## [​](https://docs.firecrawl.dev/features/llm-extract\#extract-structured-data)  Extract structured data

### [​](https://docs.firecrawl.dev/features/llm-extract\#json-mode-via-/scrape)  JSON mode via /scrape

Used to extract structured data from scraped pages.

Python

Node

cURL

```
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
    formats=[{\
      "type": "json",\
      "schema": CompanyInfo.model_json_schema()\
    }],
    only_main_content=False,
    timeout=120000
)

print(result)
```

Output:

JSON

```
{
    "success": true,
    "data": {
      "json": {
        "company_mission": "AI-powered web scraping and data extraction",
        "supports_sso": true,
        "is_open_source": true,
        "is_in_yc": true
      },
      "metadata": {
        "title": "Firecrawl",
        "description": "AI-powered web scraping and data extraction",
        "robots": "follow, index",
        "ogTitle": "Firecrawl",
        "ogDescription": "AI-powered web scraping and data extraction",
        "ogUrl": "https://firecrawl.dev/",
        "ogImage": "https://firecrawl.dev/og.png",
        "ogLocaleAlternate": [],
        "ogSiteName": "Firecrawl",
        "sourceURL": "https://firecrawl.dev/"
      },
    }
}
```

### [​](https://docs.firecrawl.dev/features/llm-extract\#structured-data-without-schema)  Structured data without schema

You can also extract without a schema by just passing a `prompt` to the endpoint. The llm chooses the structure of the data.

Python

Node

cURL

```
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR-API-KEY")

result = app.scrape(
    'https://firecrawl.dev',
    formats=[{\
      "type": "json",\
      "prompt": "Extract the company mission from the page."\
    }],
    only_main_content=False,
    timeout=120000
)

print(result)
```

Output:

JSON

```
{
    "success": true,
    "data": {
      "json": {
        "company_mission": "AI-powered web scraping and data extraction",
      },
      "metadata": {
        "title": "Firecrawl",
        "description": "AI-powered web scraping and data extraction",
        "robots": "follow, index",
        "ogTitle": "Firecrawl",
        "ogDescription": "AI-powered web scraping and data extraction",
        "ogUrl": "https://firecrawl.dev/",
        "ogImage": "https://firecrawl.dev/og.png",
        "ogLocaleAlternate": [],
        "ogSiteName": "Firecrawl",
        "sourceURL": "https://firecrawl.dev/"
      },
    }
}
```

### [​](https://docs.firecrawl.dev/features/llm-extract\#real-world-example-extracting-company-information)  Real-world example: Extracting company information

Here’s a comprehensive example extracting structured company information from a website:

Python

Node

cURL

```
from firecrawl import Firecrawl
from pydantic import BaseModel

app = Firecrawl(api_key="fc-YOUR-API-KEY")

class CompanyInfo(BaseModel):
    company_mission: str
    supports_sso: bool
    is_open_source: bool
    is_in_yc: bool

result = app.scrape(
    'https://firecrawl.dev/',
    formats=[{\
        "type": "json",\
        "schema": CompanyInfo.model_json_schema()\
    }]
)

print(result)
```

Output:

Output

```
{
  "success": true,
  "data": {
    "json": {
      "company_mission": "Turn websites into LLM-ready data",
      "supports_sso": true,
      "is_open_source": true,
      "is_in_yc": true
    }
  }
}
```

### [​](https://docs.firecrawl.dev/features/llm-extract\#json-format-options)  JSON format options

When using JSON mode in v2, include an object in `formats` with the schema embedded directly:`formats: [{ type: 'json', schema: { ... }, prompt: '...' }]`Parameters:

- `schema`: JSON Schema describing the structured output you want (required for schema-based extraction).
- `prompt`: Optional prompt to guide extraction (also used for no-schema extraction).

**Important:** Unlike v1, there is no separate `jsonOptions` parameter in v2. The schema must be included directly inside the format object in the `formats` array.

**HTML attributes are not available in JSON extraction.** JSON extraction works on the markdown conversion of the page, which only preserves visible text content. HTML attributes (e.g., `data-id`, custom attributes on elements) are stripped during conversion and the LLM cannot see them. If you need to extract HTML attribute values, use `rawHtml` format and parse attributes client-side, or use an `executeJavascript` action to inject attribute values into visible text before extraction.

## [​](https://docs.firecrawl.dev/features/llm-extract\#tips-for-consistent-extraction)  Tips for consistent extraction

If you are seeing inconsistent or incomplete results from JSON extraction, these practices can help:

- **Keep prompts short and focused.** Long prompts with many rules increase variability. Move specific constraints (like allowed values) into the schema instead.
- **Use concise property names.** Avoid embedding instructions or enum lists in property names. Use a short key like `"installation_type"` and put allowed values in an `enum` array.
- **Add `enum` arrays for constrained fields.** When a field has a fixed set of values, list them in `enum` and make sure they match the exact text shown on the page.
- **Include null-handling in field descriptions.** Add `"Return null if not found on the page."` to each field’s `description` so the model does not guess missing values.
- **Add location hints.** Tell the model where to find data on the page, e.g. `"Flow rate in GPM from the Specifications table."`.
- **Split large schemas into smaller requests.** Schemas with many fields (e.g. 30+) produce less consistent results. Split them into 2–3 requests of 10–15 fields each.
- **Avoid `minItems`/`maxItems` on arrays.** JSON Schema validation keywords like `minItems` and `maxItems` do not control how much content the scraper collects. Setting `minItems: 20` will not make the LLM return more items — it may instead hallucinate entries to satisfy the constraint. Remove these keywords and use a `prompt` instead (e.g. `"Extract ALL reviews from the page. Do not skip any."`) to guide completeness.
- **Use `"type": "array"` to extract lists of items.** If you need to extract multiple items (e.g. a list of people, products, or reviews), wrap them in an array property with an `items` block. Using `"type": "object"` for a list will return only a single item. See the array schema example below.

**Example of a well-structured schema:**

```
{
  "type": "object",
  "properties": {
    "product_name": {
      "type": ["string", "null"],
      "description": "Full descriptive product name as shown on the page. Return null if not found."
    },
    "installation_type": {
      "type": ["string", "null"],
      "description": "Installation type from the Specifications section. Return null if not found.",
      "enum": ["Deck-mount", "Wall-mount", "Countertop", "Drop-in", "Undermount"]
    },
    "flow_rate_gpm": {
      "type": ["string", "null"],
      "description": "Flow rate in GPM from the Specifications section. Return null if not found."
    }
  }
}
```

**Example of extracting a list of items:**When a page contains multiple items (e.g. team members, products, reviews), use `"type": "array"` with `"items"` to get the full list:

```
{
  "type": "object",
  "properties": {
    "people": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "name": { "type": "string" },
          "role": { "type": "string" },
          "department": { "type": "string" }
        }
      }
    }
  }
}
```

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.

[Suggest edits](https://github.com/firecrawl/firecrawl-docs/edit/main/features/llm-extract.mdx) [Raise issue](https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&body=Path:%20/features/llm-extract)

[Batch Scrape\\
\\
Previous](https://docs.firecrawl.dev/features/batch-scrape) [Change Tracking\\
\\
Next](https://docs.firecrawl.dev/features/change-tracking)

Ctrl+I