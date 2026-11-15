> Source: https://docs.firecrawl.dev/features/search



Search


# Search


Search the web and get full content from results


## Try it in the Playground


## <a href="#performing-a-search-with-firecrawl" class="anchor-link" aria-label="Navigate to header: Performing a Search with Firecrawl"></a><span id="_R_99crmhkd74t9_" class="cursor-pointer">Performing a Search with Firecrawl</span>

### <a href="#/search-endpoint" class="anchor-link" aria-label="Navigate to header: /search endpoint"></a><span id="_R_b9crmhkd74t9_" class="cursor-pointer">/search endpoint</span>


### <a href="#installation" class="anchor-link" aria-label="Navigate to header: Installation"></a><span id="_R_f9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Installation</span>


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


### <a href="#basic-usage" class="anchor-link" aria-label="Navigate to header: Basic Usage"></a><span id="_R_j9crmhkd74t9_" class="cursor-pointer">Basic Usage</span>


Python


Node


cURL


CLI


``` shiki
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


``` shiki
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


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
curl -s -X POST "https://api.firecrawl.dev/v2/search" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "firecrawl",
    "limit": 3
  }'
```


``` shiki
# Search the web
firecrawl search "firecrawl web scraping" --limit 5 --pretty
```


### <a href="#response" class="anchor-link" aria-label="Navigate to header: Response"></a><span id="_R_n9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Response</span>


``` shiki
{
  "success": true,
  "data": {
    "web": [
      {
        "url": "https://www.firecrawl.dev/",
        "title": "Firecrawl - The context API for AI agents",
        "description": "The web crawling, scraping, and search API for AI. Built for scale. Firecrawl delivers the entire internet to AI agents and builders.",
        "position": 1
      },
      {
        "url": "https://github.com/firecrawl/firecrawl",
        "title": "firecrawl/firecrawl: Turn entire websites into LLM-ready ... - GitHub",
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


``` shiki
result = firecrawl.search("query")
for item in result.web or []:
    print(item.url, item.title)
```


``` shiki
const result = await firecrawl.search("query");
for (const item of result.web ?? []) {
  console.log(item.url, item.title);
}
```


## <a href="#search-result-types" class="anchor-link" aria-label="Navigate to header: Search result types"></a><span id="_R_v9crmhkd74t9_" class="cursor-pointer">Search result types</span>


- `web`: standard web results (default)
- `news`: news-focused results
- `images`: image search results
- `alexandria`: data tools from <a href="/features/alexandria" class="link">Alexandria</a>, the Firecrawl catalogue of third-party data providers


### <a href="#alexandria-tools" class="anchor-link" aria-label="Navigate to header: Alexandria tools"></a><span id="_R_179crmhkd74t9_" class="cursor-pointer">Alexandria tools</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "podcast conversations about AI agents",
    "sources": ["web", "alexandria"],
    "limit": 2
  }'
```


- By default, each tool has only its `provider`, `capability`, and `description`. Set `toolDetail` to `"summary"` for more metadata, or to `"full"` for the input and output contracts.
- Search also adds tools that match the websites in your results. Set `domainTools: false` to turn off this domain matching.
- Tool discovery needs an API key. It is not available with zero data retention.


## <a href="#search-categories" class="anchor-link" aria-label="Navigate to header: Search Categories"></a><span id="_R_1h9crmhkd74t9_" class="cursor-pointer">Search Categories</span>


- `research`: Restrict web search to academic and research websites (arxiv.org, nature.com, pubmed.ncbi.nlm.nih.gov, and similar). Results are web pages, returned in `data.web`. For paper records, use <a href="/api-reference/endpoint/research-search-papers" class="link"><code>GET /search/research/papers</code></a>
- `pdf`: Search for PDFs
- `developer`: Search the <a href="/features/developer" class="link">Developer Index</a> — issues, merged pull requests, and READMEs from public code repositories, alongside curated documentation sites
- `gov`: Search the <a href="/features/gov" class="link">Firecrawl Government Index</a> — statutes, regulations, codes, court opinions, and other government publications


### <a href="#research-category-search" class="anchor-link" aria-label="Navigate to header: Research Category Search"></a><span id="_R_1p9crmhkd74t9_" class="cursor-pointer">Research Category Search</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "machine learning transformers",
    "categories": ["research"],
    "limit": 10
  }'
```


``` shiki
curl -s "https://api.firecrawl.dev/v2/search/research/papers?query=CRISPR%20base%20editing%20off-target%20effects&k=10"
```


### <a href="#developer-category-search" class="anchor-link" aria-label="Navigate to header: Developer Category Search"></a><span id="_R_239crmhkd74t9_" class="cursor-pointer">Developer Category Search</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "how do I configure retries",
    "categories": ["developer"],
    "limit": 10
  }'
```


### <a href="#gov-category-search" class="anchor-link" aria-label="Navigate to header: Gov Category Search"></a><span id="_R_2b9crmhkd74t9_" class="cursor-pointer">Gov Category Search</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "food labeling requirements for allergens",
    "categories": ["gov"],
    "limit": 10
  }'
```


### <a href="#mixed-category-search" class="anchor-link" aria-label="Navigate to header: Mixed Category Search"></a><span id="_R_2l9crmhkd74t9_" class="cursor-pointer">Mixed Category Search</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "neural networks",
    "categories": ["research", "pdf"],
    "limit": 15
  }'
```


## <a href="#domain-filters" class="anchor-link" aria-label="Navigate to header: Domain Filters"></a><span id="_R_2r9crmhkd74t9_" class="cursor-pointer">Domain Filters</span>


### <a href="#include-domains" class="anchor-link" aria-label="Navigate to header: Include Domains"></a><span id="_R_319crmhkd74t9_" class="cursor-pointer">Include Domains</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "web scraping",
    "includeDomains": ["firecrawl.dev", "docs.firecrawl.dev"],
    "limit": 10
  }'
```


### <a href="#exclude-domains" class="anchor-link" aria-label="Navigate to header: Exclude Domains"></a><span id="_R_359crmhkd74t9_" class="cursor-pointer">Exclude Domains</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "web scraping tools",
    "excludeDomains": ["example.com"],
    "limit": 10
  }'
```


### <a href="#category-response-format" class="anchor-link" aria-label="Navigate to header: Category Response Format"></a><span id="_R_399crmhkd74t9_" class="cursor-pointer">Category Response Format</span>


``` shiki
{
  "success": true,
  "data": {
    "web": [
      {
        "url": "https://arxiv.org/abs/2024.12345",
        "title": "Advances in Neural Network Architecture",
        "description": "Research paper on neural network improvements",
        "category": "research"
      },
      {
        "url": "https://example.com/neural-networks.pdf",
        "title": "Neural Networks Survey",
        "description": "A survey of neural network architectures",
        "category": "pdf"
      }
    ]
  }
}
```


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "openai",
    "sources": ["news"],
    "limit": 5
  }'
```


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "jupiter",
    "sources": ["images"],
    "limit": 8
  }'
```


### <a href="#hd-image-search-with-size-filtering" class="anchor-link" aria-label="Navigate to header: HD Image Search with Size Filtering"></a><span id="_R_3l9crmhkd74t9_" class="cursor-pointer">HD Image Search with Size Filtering</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "sunset imagesize:1920x1080",
    "sources": ["images"],
    "limit": 5
  }'
```


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "mountain wallpaper larger:2560x1440",
    "sources": ["images"],
    "limit": 8
  }'
```


- `imagesize:1920x1080` - Full HD (1080p)
- `imagesize:2560x1440` - QHD (1440p)
- `imagesize:3840x2160` - 4K UHD
- `larger:1920x1080` - HD and above
- `larger:2560x1440` - QHD and above

## <a href="#search-with-content-scraping" class="anchor-link" aria-label="Navigate to header: Search with Content Scraping"></a><span id="_R_419crmhkd74t9_" class="cursor-pointer">Search with Content Scraping</span>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR_API_KEY",
)

# Search and scrape content
results = firecrawl.search(
    "firecrawl web scraping",
    limit=3,
    scrape_options={
        "formats": ["markdown", "links"]
    }
)
```


``` shiki
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


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer fc-YOUR_API_KEY" for higher rate limits:
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -d '{
    "query": "firecrawl web scraping",
    "limit": 3,
    "scrapeOptions": {
      "formats": ["markdown", "links"]
    }
  }'
```


``` shiki
# Search and scrape results
firecrawl search "firecrawl" --scrape --scrape-formats markdown --limit 5 --pretty
```


### <a href="#response-with-scraped-content" class="anchor-link" aria-label="Navigate to header: Response with Scraped Content"></a><span id="_R_499crmhkd74t9_" class="cursor-pointer">Response with Scraped Content</span>


``` shiki
{
  "success": true,
  "data": [
    {
      "title": "Firecrawl - The Ultimate Web Scraping API",
      "description": "Firecrawl is a powerful web scraping API that turns any website into clean, structured data for AI and analysis.",
      "url": "https://firecrawl.dev/",
      "markdown": "# Firecrawl\n\nThe Ultimate Web Scraping API\n\n## Turn any website into clean, structured data\n\nFirecrawl makes it easy to extract data from websites for AI applications, market research, content aggregation, and more...",
      "links": [
        "https://firecrawl.dev/pricing",
        "https://firecrawl.dev/docs",
        "https://firecrawl.dev/guides"
      ],
      "metadata": {
        "title": "Firecrawl - The Ultimate Web Scraping API",
        "description": "Firecrawl is a powerful web scraping API that turns any website into clean, structured data for AI and analysis.",
        "sourceURL": "https://firecrawl.dev/",
        "statusCode": 200
      }
    }
  ]
}
```


## <a href="#search-then-scrape-two-step-pattern" class="anchor-link" aria-label="Navigate to header: Search then Scrape (Two-Step Pattern)"></a><span id="_R_4d9crmhkd74t9_" class="cursor-pointer">Search then Scrape (Two-Step Pattern)</span>


Python


JavaScript


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR_API_KEY")

# Step 1: Search
results = firecrawl.search("firecrawl web scraping", limit=5)

# Step 2: Scrape each result URL for full content
for item in results.web or []:
    page = firecrawl.scrape(item.url, formats=["markdown"])
    print(page.markdown[:200])
```


``` shiki
import Firecrawl from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

// Step 1: Search
const results = await firecrawl.search("firecrawl web scraping", { limit: 5 });

// Step 2: Scrape each result URL for full content
for (const item of results.web ?? []) {
  const page = await firecrawl.scrape(item.url, { formats: ["markdown"] });
  console.log(page.markdown?.substring(0, 200));
}
```


- **One-step** (`scrapeOptions` in search): You want content from all results. Simpler and faster.
- **Two-step** (search then scrape): You want to filter, rank, or selectively scrape results. More flexible.


## <a href="#advanced-search-options" class="anchor-link" aria-label="Navigate to header: Advanced Search Options"></a><span id="_R_4l9crmhkd74t9_" class="cursor-pointer">Advanced Search Options</span>


### <a href="#location-customization" class="anchor-link" aria-label="Navigate to header: Location Customization"></a><span id="_R_4p9crmhkd74t9_" class="cursor-pointer">Location Customization</span>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR_API_KEY",
)

# Search with location settings (Germany)
search_result = firecrawl.search(
    "web scraping tools",
    limit=5,
    location="Germany"
)

# Process the results
for result in search_result.data:
    print(f"Title: {result['title']}")
    print(f"URL: {result['url']}")
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: "fc-YOUR-API-KEY",
});

// Search with location settings (Germany)
const results = await firecrawl.search('web scraping tools', {
  limit: 5,
  location: "Germany"
});

// Process the results
console.log(results);
```


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer fc-YOUR_API_KEY" for higher rate limits:
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -d '{
    "query": "web scraping tools",
    "limit": 5,
    "location": "Germany"
  }'
```


``` shiki
# Search with location
firecrawl search "local restaurants" --location "San Francisco,California,United States" --country US --pretty
```


### <a href="#time-based-search" class="anchor-link" aria-label="Navigate to header: Time-Based Search"></a><span id="_R_4t9crmhkd74t9_" class="cursor-pointer">Time-Based Search</span>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)

results = firecrawl.search(
    query="firecrawl",
    limit=5,
    tbs="qdr:d",
)
print(len(results.get('web', [])))
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: "fc-YOUR-API-KEY",
});

const results = await firecrawl.search('firecrawl', {
  limit: 5,
  tbs: 'qdr:d', // past day
});

console.log(results.web);
```


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer fc-YOUR_API_KEY" for higher rate limits:
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -d '{
    "query": "latest web scraping techniques",
    "limit": 5,
    "tbs": "qdr:w"
  }'
```


``` shiki
# Search with time filter (past week)
firecrawl search "firecrawl updates" --tbs qdr:w --limit 5 --pretty
```


- `qdr:h` - Past hour
- `qdr:d` - Past 24 hours
- `qdr:w` - Past week
- `qdr:m` - Past month
- `qdr:y` - Past year
- `sbd:1` - Sort by date (newest first)


Python


JavaScript


cURL


``` shiki
from firecrawl import Firecrawl

# Initialize the client with your API key
firecrawl = Firecrawl(api_key="fc-YOUR_API_KEY")

# Search for results from December 2024
search_result = firecrawl.search(
    "firecrawl updates",
    limit=10,
    tbs="cdr:1,cd_min:12/1/2024,cd_max:12/31/2024"
)
```


``` shiki
import { Firecrawl } from 'firecrawl';

// Initialize the client with your API key
const firecrawl = new Firecrawl({apiKey: "fc-YOUR_API_KEY"});

// Search for results from December 2024
firecrawl.search("firecrawl updates", {
  limit: 10,
  tbs: "cdr:1,cd_min:12/1/2024,cd_max:12/31/2024"
})
.then(searchResult => {
  console.log(searchResult.data);
});
```


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "firecrawl updates",
    "limit": 10,
    "tbs": "cdr:1,cd_min:12/1/2024,cd_max:12/31/2024"
  }'
```


### <a href="#custom-timeout" class="anchor-link" aria-label="Navigate to header: Custom Timeout"></a><span id="_R_5d9crmhkd74t9_" class="cursor-pointer">Custom Timeout</span>


Python


JavaScript


cURL


``` shiki
from firecrawl import Firecrawl

# Initialize the client with your API key
firecrawl = Firecrawl(api_key="fc-YOUR_API_KEY")

# Set a 30-second timeout
search_result = firecrawl.search(
    "complex search query",
    limit=10,
    timeout=30000  # 30 seconds in milliseconds
)
```


``` shiki
import { Firecrawl } from 'firecrawl';

// Initialize the client with your API key
const firecrawl = new Firecrawl({apiKey: "fc-YOUR_API_KEY"});

// Set a 30-second timeout
firecrawl.search("complex search query", {
  limit: 10,
  timeout: 30000  // 30 seconds in milliseconds
})
.then(searchResult => {
  // Process results
  console.log(searchResult.data);
});
```


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "complex search query",
    "limit": 10,
    "timeout": 30000
  }'
```


### <a href="#safe-search" class="anchor-link" aria-label="Navigate to header: Safe Search"></a><span id="_R_5j9crmhkd74t9_" class="cursor-pointer">Safe Search</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "firecrawl",
    "safe": true
  }'
```


## <a href="#zero-data-retention-zdr" class="anchor-link" aria-label="Navigate to header: Zero Data Retention (ZDR)"></a><span id="_R_5p9crmhkd74t9_" class="cursor-pointer">Zero Data Retention (ZDR)</span>


### <a href="#end-to-end-zdr" class="anchor-link" aria-label="Navigate to header: End-to-End ZDR"></a><span id="_R_5v9crmhkd74t9_" class="cursor-pointer">End-to-End ZDR</span>


- **Cost:** 10 credits per 10 results
- **Parameter:** `enterprise: ["zdr"]`


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "sensitive topic",
    "limit": 10,
    "enterprise": ["zdr"]
  }'
```


### <a href="#anonymized-zdr" class="anchor-link" aria-label="Navigate to header: Anonymized ZDR"></a><span id="_R_679crmhkd74t9_" class="cursor-pointer">Anonymized ZDR</span>


- **Cost:** 2 credits per 10 results
- **Parameter:** `enterprise: ["anon"]`


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "sensitive topic",
    "limit": 10,
    "enterprise": ["anon"]
  }'
```


### <a href="#combining-search-zdr-with-scrape-zdr" class="anchor-link" aria-label="Navigate to header: Combining Search ZDR with Scrape ZDR"></a><span id="_R_6f9crmhkd74t9_" class="cursor-pointer">Combining Search ZDR with Scrape ZDR</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/search \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "query": "sensitive topic",
    "limit": 5,
    "enterprise": ["zdr"],
    "scrapeOptions": {
      "formats": ["markdown"]
    }
  }'
```


## <a href="#cost-implications" class="anchor-link" aria-label="Navigate to header: Cost Implications"></a><span id="_R_6l9crmhkd74t9_" class="cursor-pointer">Cost Implications</span>


- **Basic scrape**: 1 credit per webpage
- **PDF parsing**: 1 credit per PDF page
- **JSON mode**: 4 additional credits per webpage


- Set `parsers: []` if PDF parsing isn’t required
- Limit the number of search results with the `limit` parameter

## <a href="#advanced-scraping-options" class="anchor-link" aria-label="Navigate to header: Advanced Scraping Options"></a><span id="_R_6v9crmhkd74t9_" class="cursor-pointer">Advanced Scraping Options</span>


> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>

## <a href="#measured-performance" class="anchor-link" aria-label="Navigate to header: Measured Performance"></a><span id="_R_759crmhkd74t9_" class="cursor-pointer">Measured Performance</span>


| Metric | Value | Source | Date | n / ± |
|----|----|----|----|----|
| Agent Score (Mean Relevant × Quality) | 14.58, rank 2 of 8 (Mean Relevant 4.30/5, Quality 3.39/5) | <a href="https://aimultiple.com/agentic-search" class="link" target="_blank" rel="noreferrer">AIMultiple — Agentic Search Benchmark</a> | Dec 2025 (source updated May 25, 2026) | 95% CI 13.12–15.98, n=100 AI/LLM-domain queries drawn from AIMultiple’s own organic search traffic (10,000 bootstrap resamples); the source notes results don’t generalize to other domains |


## <a href="#search-feedback" class="anchor-link" aria-label="Navigate to header: Search feedback"></a><span id="_R_7d9crmhkd74t9_" class="cursor-pointer">Search feedback</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/search.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/search" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


