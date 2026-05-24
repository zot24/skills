> Source: https://docs.firecrawl.dev/features/llm-extract



<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="https://firecrawl.dev" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">Firecrawl Docs home page</span><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=c45b3c967c19a39190e76fe8e9c2ed5a" class="nav-logo w-auto relative object-contain shrink-0 block dark:hidden h-6" alt="light logo" /><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=3fee4abe033bd3c26e8ad92043a91c17" class="nav-logo w-auto relative object-contain shrink-0 hidden dark:block h-6" alt="dark logo" /></a>


Search...


Scrape


JSON mode - Structured result


<a href="/introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor] hover:text-primary dark:hover:text-primary-light text-gray-800 dark:text-gray-200" data-active="true" aria-current="location">Documentation</a>


<a href="/sdks/overview" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">SDKs</a>


<a href="https://www.firecrawl.dev/app" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200" target="_blank" rel="noreferrer">Integrations</a>


<a href="/api-reference/v2-introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">API Reference</a>


<a href="/ai-onboarding" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">Build with AI</a>


Scrape


# JSON mode - Structured result


Copy page


Extract structured data from pages via LLMs


Copy page


> ## Documentation Index
>
> Fetch the complete documentation index at: <https://docs.firecrawl.dev/llms.txt>
>
> Use this file to discover all available pages before exploring further.


- For **anything beyond one URL** — multiple URLs, URL patterns, or agentic discovery — see <a href="/features/agent" class="link">Agent</a>.
- Full comparison: <a href="/developer-guides/usage-guides/choosing-the-data-extractor" class="link">Choosing the Data Extractor</a>.


For schema validation failures and other extraction errors, see <a href="/api-reference/errors" class="link">Errors</a> — extraction-specific issues typically surface as `400` or `422` responses.


## 


<a href="#scrape-and-extract-structured-data-with-firecrawl" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <span data-as="p">**Set the Schema (optional):** Define a JSON schema (using OpenAI’s format) to specify the data you want, or just provide a `prompt` if you don’t need a strict schema, along with the webpage URL.</span>
2.  <span data-as="p">**Make the Request:** Send your URL and schema to our scrape endpoint using JSON mode. See how here: <a href="https://docs.firecrawl.dev/api-reference/endpoint/scrape" class="link" target="_blank" rel="noreferrer">Scrape Endpoint Documentation</a></span>
3.  <span data-as="p">**Get Your Data:** Get back clean, structured data matching your schema that you can use right away.</span>


## 


<a href="#extract-structured-data" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#json-mode-via-/scrape" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
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


### 


<a href="#structured-data-without-schema" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
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


### 


<a href="#real-world-example-extracting-company-information" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
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


``` shiki
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


### 


<a href="#json-format-options" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- `schema`: JSON Schema describing the structured output you want (required for schema-based extraction).
- `prompt`: Optional prompt to guide extraction (also used for no-schema extraction).


## 


<a href="#tips-for-consistent-extraction" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


<a href="/features/batch-scrape" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-start"></a>


Batch Scrape


<a href="/features/change-tracking" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-end"></a>


Change Tracking


