> Source: https://docs.firecrawl.dev/features/llm-extract.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# JSON mode - Structured result

> Extract structured data from pages via LLMs


  **v2 API Change:** JSON schema extraction is fully supported in v2, but the API format has changed. In v2, the schema is embedded directly inside the format object as `formats: [{type: "json", schema: {...}}]`. The v1 `jsonOptions` parameter no longer exists in v2.


## Scrape and extract structured data with Firecrawl

Firecrawl uses AI to get structured data from web pages in 3 steps:

1. **Set the Schema (optional):**
   Define a JSON schema (using OpenAI's format) to specify the data you want, or just provide a `prompt` if you don't need a strict schema, along with the webpage URL.

2. **Make the Request:**
   Send your URL and schema to our scrape endpoint using JSON mode. See how here:
   [Scrape Endpoint Documentation](https://docs.firecrawl.dev/api-reference/endpoint/scrape)

3. **Get Your Data:**
   Get back clean, structured data matching your schema that you can use right away.

This makes getting web data in the format you need quick and easy.

## Extract structured data

### JSON mode via /scrape

Used to extract structured data from scraped pages.

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

Output:

```json JSON
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

### Structured data without schema

You can also extract without a schema by just passing a `prompt` to the endpoint. The llm chooses the structure of the data.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  app = Firecrawl(api_key="fc-YOUR-API-KEY")

  result = app.scrape(
      'https://firecrawl.dev',
      formats=[{
        "type": "json",
        "prompt": "Extract the company mission from the page."
      }],
      only_main_content=False,
      timeout=120000
  )

  print(result)
  ```

  ```js Node
  import Firecrawl from "@mendable/firecrawl-js";

  const app = new Firecrawl({
    apiKey: "fc-YOUR_API_KEY"
  });

  const result = await app.scrape("https://firecrawl.dev", {
    formats: [{
      type: "json",
      prompt: "Extract the company mission from the page."
    }]
  });

  console.log(result);
  ```

  ```bash cURL
  curl -X POST https://api.firecrawl.dev/v2/scrape \
      -H 'Content-Type: application/json' \
      -H 'Authorization: Bearer YOUR_API_KEY' \
      -d '{
        "url": "https://firecrawl.dev",
        "formats": [{
          "type": "json",
          "prompt": "Extract the company mission from the page."
        }]
      }'
  ```
</CodeGroup>

Output:

```json JSON
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

### Real-world example: Extracting company information

Here's a comprehensive example extracting structured company information from a website:

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
      'https://firecrawl.dev/',
      formats=[{
          "type": "json",
          "schema": CompanyInfo.model_json_schema()
      }]
  )

  print(result)
  ```

  ```js Node
  import Firecrawl from "@mendable/firecrawl-js";
  import { z } from "zod";

  const app = new Firecrawl({
    apiKey: "fc-YOUR_API_KEY"
  });

  const companyInfoSchema = z.object({
    company_mission: z.string(),
    supports_sso: z.boolean(),
    is_open_source: z.boolean(),
    is_in_yc: z.boolean()
  });

  const result = await app.scrape("https://firecrawl.dev/", {
    formats: [{
      type: "json",
      schema: companyInfoSchema
    }]
  });

  console.log(result);
  ```

  ```bash cURL
  curl -X POST https://api.firecrawl.dev/v2/scrape \
      -H 'Content-Type: application/json' \
      -H 'Authorization: Bearer YOUR_API_KEY' \
      -d '{
        "url": "https://firecrawl.dev/",
        "formats": [{
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
        }]
      }'
  ```
</CodeGroup>

Output:

```json Output
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

### JSON format options

When using JSON mode in v2, include an object in `formats` with the schema embedded directly:

`formats: [{ type: 'json', schema: { ... }, prompt: '...' }]`

Parameters:

* `schema`: JSON Schema describing the structured output you want (required for schema-based extraction).
* `prompt`: Optional prompt to guide extraction (also used for no-schema extraction).

**Important:** Unlike v1, there is no separate `jsonOptions` parameter in v2. The schema must be included directly inside the format object in the `formats` array.


  **HTML attributes are not available in JSON extraction.** JSON extraction works on the markdown conversion of the page, which only preserves visible text content. HTML attributes (e.g., `data-id`, custom attributes on elements) are stripped during conversion and the LLM cannot see them. If you need to extract HTML attribute values, use `rawHtml` format and parse attributes client-side, or use an `executeJavascript` action to inject attribute values into visible text before extraction.


## Tips for consistent extraction

If you are seeing inconsistent or incomplete results from JSON extraction, these practices can help:

* **Keep prompts short and focused.** Long prompts with many rules increase variability. Move specific constraints (like allowed values) into the schema instead.
* **Use concise property names.** Avoid embedding instructions or enum lists in property names. Use a short key like `"installation_type"` and put allowed values in an `enum` array.
* **Add `enum` arrays for constrained fields.** When a field has a fixed set of values, list them in `enum` and make sure they match the exact text shown on the page.
* **Include null-handling in field descriptions.** Add `"Return null if not found on the page."` to each field's `description` so the model does not guess missing values.
* **Add location hints.** Tell the model where to find data on the page, e.g. `"Flow rate in GPM from the Specifications table."`.
* **Split large schemas into smaller requests.** Schemas with many fields (e.g. 30+) produce less consistent results. Split them into 2–3 requests of 10–15 fields each.
* **Avoid `minItems`/`maxItems` on arrays.** JSON Schema validation keywords like `minItems` and `maxItems` do not control how much content the scraper collects. Setting `minItems: 20` will not make the LLM return more items — it may instead hallucinate entries to satisfy the constraint. Remove these keywords and use a `prompt` instead (e.g. `"Extract ALL reviews from the page. Do not skip any."`) to guide completeness.
* **Use `"type": "array"` to extract lists of items.** If you need to extract multiple items (e.g. a list of people, products, or reviews), wrap them in an array property with an `items` block. Using `"type": "object"` for a list will return only a single item. See the array schema example below.

**Example of a well-structured schema:**

```json
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

**Example of extracting a list of items:**

When a page contains multiple items (e.g. team members, products, reviews), use `"type": "array"` with `"items"` to get the full list:

```json
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
