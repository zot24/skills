> Source: https://docs.firecrawl.dev/features/llm-extract



Scrape


# JSON mode - Structured result


Extract structured data from pages via LLMs


- For **anything beyond one URL** — multiple URLs, URL patterns, or agentic discovery — see <a href="/features/agent" class="link">Agent</a>.
- Full comparison: <a href="/developer-guides/usage-guides/choosing-the-data-extractor" class="link">Choosing the Data Extractor</a>.


For schema validation failures and other extraction errors, see <a href="/api-reference/errors" class="link">Errors</a> — extraction-specific issues typically surface as `400` or `422` responses.


## <a href="#scrape-and-extract-structured-data-with-firecrawl" class="anchor-link" aria-label="Navigate to header: Scrape and extract structured data with Firecrawl"></a><span id="_R_99crmhkd74t9_" class="cursor-pointer">Scrape and extract structured data with Firecrawl</span>


1.  <span data-as="p">**Set the Schema (optional):** Define a JSON schema (using OpenAI’s format) to specify the data you want, or just provide a `prompt` if you don’t need a strict schema, along with the webpage URL.</span>
2.  <span data-as="p">**Make the Request:** Send your URL and schema to our scrape endpoint using JSON mode. See how here: <a href="https://docs.firecrawl.dev/api-reference/endpoint/scrape" class="link" target="_blank" rel="noreferrer">Scrape Endpoint Documentation</a></span>
3.  <span data-as="p">**Get Your Data:** Get back clean, structured data matching your schema that you can use right away.</span>


## <a href="#extract-structured-data" class="anchor-link" aria-label="Navigate to header: Extract structured data"></a><span id="_R_h9crmhkd74t9_" class="cursor-pointer">Extract structured data</span>

### <a href="#json-mode-via-/scrape" class="anchor-link" aria-label="Navigate to header: JSON mode via /scrape"></a><span id="_R_j9crmhkd74t9_" class="cursor-pointer">JSON mode via /scrape</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl
from pydantic import BaseModel

app = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)

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


``` shiki
import { Firecrawl } from "firecrawl";
import { z } from "zod";

const app = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: "fc-YOUR_API_KEY",
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


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer YOUR_API_KEY" for higher rate limits:
curl -X POST https://api.firecrawl.dev/v2/scrape \
    -H 'Content-Type: application/json' \
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


``` shiki
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


### <a href="#structured-data-without-schema" class="anchor-link" aria-label="Navigate to header: Structured data without schema"></a><span id="_R_t9crmhkd74t9_" class="cursor-pointer">Structured data without schema</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)

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


``` shiki
import { Firecrawl } from "firecrawl";

const app = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: "fc-YOUR_API_KEY",
});

const result = await app.scrape("https://firecrawl.dev", {
  formats: [{
    type: "json",
    prompt: "Extract the company mission from the page."
  }]
});

console.log(result);
```


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer YOUR_API_KEY" for higher rate limits:
curl -X POST https://api.firecrawl.dev/v2/scrape \
    -H 'Content-Type: application/json' \
    -d '{
      "url": "https://firecrawl.dev",
      "formats": [{
        "type": "json",
        "prompt": "Extract the company mission from the page."
      }]
    }'
```


``` shiki
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


### <a href="#real-world-example-extracting-company-information" class="anchor-link" aria-label="Navigate to header: Real-world example: Extracting company information"></a><span id="_R_179crmhkd74t9_" class="cursor-pointer">Real-world example: Extracting company information</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl
from pydantic import BaseModel

app = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)

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


``` shiki
import { Firecrawl } from "firecrawl";
import { z } from "zod";

const app = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: "fc-YOUR_API_KEY",
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


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer YOUR_API_KEY" for higher rate limits:
curl -X POST https://api.firecrawl.dev/v2/scrape \
    -H 'Content-Type: application/json' \
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


``` shiki
{
  "success": true,
  "data": {
    "json": {
      "company_mission": "The context API for AI agents",
      "supports_sso": true,
      "is_open_source": true,
      "is_in_yc": true
    }
  }
}
```


### <a href="#json-format-options" class="anchor-link" aria-label="Navigate to header: JSON format options"></a><span id="_R_1h9crmhkd74t9_" class="cursor-pointer">JSON format options</span>


- `schema`: JSON Schema describing the structured output you want (required for schema-based extraction).
- `prompt`: Optional prompt to guide extraction (also used for no-schema extraction).
- `checkPromptInjection`: Deprecated. Use the top-level `checkPromptInjection` scrape option instead (see <a href="#prompt-injection-detection" class="link">Prompt injection detection</a>). A value set here is still honored.


### <a href="#prompt-injection-detection" class="anchor-link" aria-label="Navigate to header: Prompt injection detection"></a><span id="_R_1t9crmhkd74t9_" class="cursor-pointer">Prompt injection detection</span>


``` shiki
{
  "url": "https://example.com",
  "formats": [
    {
      "type": "json",
      "schema": { "type": "object", "properties": { "title": { "type": "string" } } }
    }
  ],
  "checkPromptInjection": true
}
```


- A dedicated classifier call inspects the page content once per scrape, before any LLM-backed format runs, so it adds the classifier’s latency to the request.
- If a prompt injection attempt is detected, the request fails with an HTTP `403` and the error code `SCRAPE_PROMPT_INJECTION_DETECTED`. No output is returned.
- If the check can’t scan all of the content (for example, because the classifier call failed or the page content is over 2,000,000 characters), the scrape continues, the response includes a `warning`, and the check is not billed.
- The check is billed as **+4 credits** when it runs. If the scrape fails after the check has run (including when an injection is detected and the request is blocked), **5 credits** are billed instead of the usual 0 for a failed scrape, since the classifier call still ran.


## <a href="#tips-for-consistent-extraction" class="anchor-link" aria-label="Navigate to header: Tips for consistent extraction"></a><span id="_R_2b9crmhkd74t9_" class="cursor-pointer">Tips for consistent extraction</span>


- **Keep prompts short and focused.** Long prompts with many rules increase variability. Move specific constraints (like allowed values) into the schema instead.
- **Use concise property names.** Avoid embedding instructions or enum lists in property names. Use a short key like `"installation_type"` and put allowed values in an `enum` array.
- **Add `enum` arrays for constrained fields.** When a field has a fixed set of values, list them in `enum` and make sure they match the exact text shown on the page.
- **Include null-handling in field descriptions.** Add `"Return null if not found on the page."` to each field’s `description` so the model does not guess missing values.
- **Add location hints.** Tell the model where to find data on the page, e.g. `"Flow rate in GPM from the Specifications table."`.
- **Split large schemas into smaller requests.** Schemas with many fields (e.g. 30+) produce less consistent results. Split them into 2–3 requests of 10–15 fields each.
- **Avoid `minItems`/`maxItems` on arrays.** JSON Schema validation keywords like `minItems` and `maxItems` do not control how much content the scraper collects. Setting `minItems: 20` will not make the LLM return more items — it may instead hallucinate entries to satisfy the constraint. Remove these keywords and use a `prompt` instead (e.g. `"Extract ALL reviews from the page. Do not skip any."`) to guide completeness.
- **Use `"type": "array"` to extract lists of items.** If you need to extract multiple items (e.g. a list of people, products, or reviews), wrap them in an array property with an `items` block. Using `"type": "object"` for a list will return only a single item. See the array schema example below.


``` shiki
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


``` shiki
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


> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/llm-extract.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/llm-extract" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


