> Source: https://docs.firecrawl.dev/features/map



More


# Map


Input a website and get all the urls on the website - extremely fast


## <a href="#introducing-/map" class="anchor-link" aria-label="Navigate to header: Introducing /map"></a><span id="_R_19crmhkd74t9_" class="cursor-pointer">Introducing /map</span>


- When you need to prompt the end-user to choose which links to scrape
- Need to quickly know the links on a website
- Need to scrape pages of a website that are related to a specific topic (use the `search` parameter)
- Only need to scrape specific pages of a website


## Try it in the Playground


## <a href="#mapping" class="anchor-link" aria-label="Navigate to header: Mapping"></a><span id="_R_99crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Mapping</span>

### <a href="#/map-endpoint" class="anchor-link" aria-label="Navigate to header: /map endpoint"></a><span id="_R_b9crmhkd74t9_" class="cursor-pointer">/map endpoint</span>


### <a href="#installation" class="anchor-link" aria-label="Navigate to header: Installation"></a><span id="_R_h9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Installation</span>


Python


Node


CLI


``` shiki
# pip install firecrawl

from firecrawl import Firecrawl

firecrawl = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)
```


``` shiki
// npm install firecrawl

import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: "fc-YOUR-API-KEY",
});
```


``` shiki
# Install globally with npm
npm install -g firecrawl

# Authenticate (one-time setup)
firecrawl login
```


### <a href="#usage" class="anchor-link" aria-label="Navigate to header: Usage"></a><span id="_R_l9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Usage</span>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")
res = firecrawl.map(url="https://firecrawl.dev", limit=50, sitemap="include")
print(res)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

const res = await firecrawl.map('https://firecrawl.dev', { limit: 50, sitemap: 'include' });
console.log(res);
```


``` shiki
curl -X POST https://api.firecrawl.dev/v2/map \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer YOUR_API_KEY' \
    -d '{
      "url": "https://firecrawl.dev"
    }'
```


``` shiki
# Map a website to discover URLs
firecrawl map https://firecrawl.dev

# Output as JSON with limit
firecrawl map https://firecrawl.dev --json --limit 100 --pretty
```


### <a href="#response" class="anchor-link" aria-label="Navigate to header: Response"></a><span id="_R_r9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Response</span>


``` shiki
{
  "success": true,
  "links": [
    {
      "url": "https://docs.firecrawl.dev/features/scrape",
      "title": "Scrape | Firecrawl",
      "description": "Turn any url into clean data"
    },
    {
      "url": "https://www.firecrawl.dev/blog/5_easy_ways_to_access_glm_4_5",
      "title": "5 Easy Ways to Access GLM-4.5",
      "description": "Discover how to access GLM-4.5 models locally, through chat applications, via the official API, and using the LLM marketplaces API for seamless integration i..."
    },
    {
      "url": "https://www.firecrawl.dev/playground",
      "title": "Playground - Firecrawl",
      "description": "Preview the API response and get the code snippets for the API"
    },
    {
      "url": "https://www.firecrawl.dev/?testId=2a7e0542-077b-4eff-bec7-0130395570d6",
      "title": "Firecrawl - The Web Data API for AI",
      "description": "The web crawling, scraping, and search API for AI. Built for scale. Firecrawl delivers the entire internet to AI agents and builders. Clean, structured, and ..."
    },
    {
      "url": "https://www.firecrawl.dev/?testId=af391f07-ca0e-40d3-8ff2-b1ecf2e3fcde",
      "title": "Firecrawl - The Web Data API for AI",
      "description": "The web crawling, scraping, and search API for AI. Built for scale. Firecrawl delivers the entire internet to AI agents and builders. Clean, structured, and ..."
    },
    ...
  ]
}
```


#### <a href="#map-with-search" class="anchor-link" aria-label="Navigate to header: Map with search"></a><span id="_R_139crmhkd74t9_" class="cursor-pointer">Map with search</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/map \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_API_KEY' \
  -d '{
    "url": "https://firecrawl.dev",
    "search": "docs"
  }'
```


``` shiki
{
  "status": "success",
  "links": [
    {
      "url": "https://docs.firecrawl.dev",
      "title": "Firecrawl Docs",
      "description": "Firecrawl documentation"
    },
    {
      "url": "https://docs.firecrawl.dev/sdks/python",
      "title": "Firecrawl Python SDK",
      "description": "Firecrawl Python SDK documentation"
    },
    ...
  ]
}
```


## <a href="#location-and-language" class="anchor-link" aria-label="Navigate to header: Location and Language"></a><span id="_R_1d9crmhkd74t9_" class="cursor-pointer">Location and Language</span>


### <a href="#how-it-works" class="anchor-link" aria-label="Navigate to header: How it works"></a><span id="_R_1h9crmhkd74t9_" class="cursor-pointer">How it works</span>


### <a href="#usage-2" class="anchor-link" aria-label="Navigate to header: Usage"></a><span id="_R_1l9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Usage</span>


- `country`: ISO 3166-1 alpha-2 country code (e.g., ‘US’, ‘AU’, ‘DE’, ‘JP’). Defaults to ‘US’.
- `languages`: An array of preferred languages and locales for the request in order of priority. Defaults to the language of the specified location.


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

res = firecrawl.map('https://example.com',
    location={
        'country': 'US',
        'languages': ['en']
    }
)

print(res)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

const res = await firecrawl.map('https://example.com', {
  location: { country: 'US', languages: ['en'] },
});

console.log(res.metadata);
```


``` shiki
curl -X POST "https://api.firecrawl.dev/v2/map" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://example.com",
    "location": { "country": "US", "languages": ["en"] }
  }'
```


## <a href="#considerations" class="anchor-link" aria-label="Navigate to header: Considerations"></a><span id="_R_1v9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Considerations</span>


> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/map.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/map" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


