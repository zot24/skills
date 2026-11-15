> Source: https://docs.firecrawl.dev/api-reference/v2-introduction



Using the API


# Introduction


Firecrawl API Reference (v2)


## <a href="#features" class="anchor-link" aria-label="Navigate to header: Features"></a><span id="_R_59crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Features</span>


## Search


## Scrape


## Interact


## Parse


## Monitor


## Crawl


## Map


## Agent


## Alexandria


## <a href="#base-url" class="anchor-link" aria-label="Navigate to header: Base URL"></a><span id="_R_99crmhkd74t9_" class="cursor-pointer">Base URL</span>


``` shiki
https://api.firecrawl.dev
```


## <a href="#authentication" class="anchor-link" aria-label="Navigate to header: Authentication"></a><span id="_R_f9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Authentication</span>


``` shiki
Authorization: Bearer fc-YOUR-API-KEY
```


cURL


Python


Node


``` shiki
curl -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Authorization: Bearer fc-YOUR-API-KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com"}'
```


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

result = firecrawl.scrape("https://example.com")
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

const result = await firecrawl.scrape('https://example.com');
```


## <a href="#response-codes" class="anchor-link" aria-label="Navigate to header: Response codes"></a><span id="_R_v9crmhkd74t9_" class="cursor-pointer">Response codes</span>


## <a href="#429-responses" class="anchor-link" aria-label="Navigate to header: 429 responses"></a><span id="_R_159crmhkd74t9_" class="cursor-pointer">429 responses</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/api-reference/v2-introduction.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/api-reference/v2-introduction" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


