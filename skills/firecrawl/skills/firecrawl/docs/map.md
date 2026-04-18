[Skip to main content](https://docs.firecrawl.dev/features/map#content-area)

[Firecrawl Docs home page![light logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=c45b3c967c19a39190e76fe8e9c2ed5a)![dark logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=3fee4abe033bd3c26e8ad92043a91c17)](https://firecrawl.dev/)

v2
![US](https://d3gk2c5xim1je2.cloudfront.net/flags/US.svg)

English

Search...

Ctrl K

Search...

Navigation

More

Map

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

- [Introducing /map](https://docs.firecrawl.dev/features/map#introducing-%2Fmap)
- [Mapping](https://docs.firecrawl.dev/features/map#mapping)
- [/map endpoint](https://docs.firecrawl.dev/features/map#%2Fmap-endpoint)
- [Installation](https://docs.firecrawl.dev/features/map#installation)
- [Usage](https://docs.firecrawl.dev/features/map#usage)
- [Response](https://docs.firecrawl.dev/features/map#response)
- [Map with search](https://docs.firecrawl.dev/features/map#map-with-search)
- [Location and Language](https://docs.firecrawl.dev/features/map#location-and-language)
- [How it works](https://docs.firecrawl.dev/features/map#how-it-works)
- [Usage](https://docs.firecrawl.dev/features/map#usage-2)
- [Considerations](https://docs.firecrawl.dev/features/map#considerations)

![Firecrawl](https://docs.firecrawl.dev/logo/light.svg)![Firecrawl](https://docs.firecrawl.dev/logo/dark.svg)

### Ready to build?

Start getting web data for free and scale seamlessly as your project expands. **No credit card needed.**

[Start for free](https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=start_for_free) [See our plans](https://www.firecrawl.dev/pricing?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=see_our_plans)

## [​](https://docs.firecrawl.dev/features/map\#introducing-/map)  Introducing /map

The easiest way to go from a single url to a map of the entire website. This is extremely useful for:

- When you need to prompt the end-user to choose which links to scrape
- Need to quickly know the links on a website
- Need to scrape pages of a website that are related to a specific topic (use the `search` parameter)
- Only need to scrape specific pages of a website

[**Try it in the Playground** \\
\\
Test mapping in the interactive playground — no code required.](https://www.firecrawl.dev/playground?endpoint=map)

## [​](https://docs.firecrawl.dev/features/map\#mapping)  Mapping

### [​](https://docs.firecrawl.dev/features/map\#/map-endpoint)  /map endpoint

Used to map a URL and get urls of the website. This returns most links present on the website.URLs are primarily discovered from the website’s sitemap, supplemented with SERP (search engine) results and previously crawled pages to improve coverage. You can control sitemap behavior with the `sitemap` parameter.

### [​](https://docs.firecrawl.dev/features/map\#installation)  Installation

Python

Node

CLI

```
# pip install firecrawl-py

from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")
```

### [​](https://docs.firecrawl.dev/features/map\#usage)  Usage

Python

Node

cURL

CLI

```
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")
res = firecrawl.map(url="https://firecrawl.dev", limit=50, sitemap="include")
print(res)
```

Each map request consumes 1 credit per call, regardless of the number of URLs returned. For example, setting `limit` to 100,000 still uses 1 credit.

### [​](https://docs.firecrawl.dev/features/map\#response)  Response

SDKs will return the data object directly. cURL will return the payload exactly as shown below.

```
{
  "success": true,
  "links": [\
    {\
      "url": "https://docs.firecrawl.dev/features/scrape",\
      "title": "Scrape | Firecrawl",\
      "description": "Turn any url into clean data"\
    },\
    {\
      "url": "https://www.firecrawl.dev/blog/5_easy_ways_to_access_glm_4_5",\
      "title": "5 Easy Ways to Access GLM-4.5",\
      "description": "Discover how to access GLM-4.5 models locally, through chat applications, via the official API, and using the LLM marketplaces API for seamless integration i..."\
    },\
    {\
      "url": "https://www.firecrawl.dev/playground",\
      "title": "Playground - Firecrawl",\
      "description": "Preview the API response and get the code snippets for the API"\
    },\
    {\
      "url": "https://www.firecrawl.dev/?testId=2a7e0542-077b-4eff-bec7-0130395570d6",\
      "title": "Firecrawl - The Web Data API for AI",\
      "description": "The web crawling, scraping, and search API for AI. Built for scale. Firecrawl delivers the entire internet to AI agents and builders. Clean, structured, and ..."\
    },\
    {\
      "url": "https://www.firecrawl.dev/?testId=af391f07-ca0e-40d3-8ff2-b1ecf2e3fcde",\
      "title": "Firecrawl - The Web Data API for AI",\
      "description": "The web crawling, scraping, and search API for AI. Built for scale. Firecrawl delivers the entire internet to AI agents and builders. Clean, structured, and ..."\
    },\
    ...\
  ]
}
```

Title and description are not always present as it depends on the website.

#### [​](https://docs.firecrawl.dev/features/map\#map-with-search)  Map with search

Map with `search` param allows you to search for specific urls inside a website.

cURL

```
curl -X POST https://api.firecrawl.dev/v2/map \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_API_KEY' \
  -d '{
    "url": "https://firecrawl.dev",
    "search": "docs"
  }'
```

Response will be an ordered list from the most relevant to the least relevant.

```
{
  "status": "success",
  "links": [\
    {\
      "url": "https://docs.firecrawl.dev",\
      "title": "Firecrawl Docs",\
      "description": "Firecrawl documentation"\
    },\
    {\
      "url": "https://docs.firecrawl.dev/sdks/python",\
      "title": "Firecrawl Python SDK",\
      "description": "Firecrawl Python SDK documentation"\
    },\
    ...\
  ]
}
```

## [​](https://docs.firecrawl.dev/features/map\#location-and-language)  Location and Language

Specify country and preferred languages to get relevant content based on your target location and language preferences, similar to the scrape endpoint.

### [​](https://docs.firecrawl.dev/features/map\#how-it-works)  How it works

When you specify the location settings, Firecrawl will use an appropriate proxy if available and emulate the corresponding language and timezone settings. By default, the location is set to ‘US’ if not specified.

### [​](https://docs.firecrawl.dev/features/map\#usage-2)  Usage

To use the location and language settings, include the `location` object in your request body with the following properties:

- `country`: ISO 3166-1 alpha-2 country code (e.g., ‘US’, ‘AU’, ‘DE’, ‘JP’). Defaults to ‘US’.
- `languages`: An array of preferred languages and locales for the request in order of priority. Defaults to the language of the specified location.

Python

Node

cURL

```
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

For more details about supported locations, refer to the [Proxies documentation](https://docs.firecrawl.dev/features/proxies).

## [​](https://docs.firecrawl.dev/features/map\#considerations)  Considerations

This endpoint prioritizes speed, so it may not capture all website links. It primarily relies on the website’s sitemap, supplemented by cached crawl data and search engine results. For a more thorough and up-to-date list of URLs, consider using the [/crawl](https://docs.firecrawl.dev/features/crawl) endpoint instead.

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.

[Suggest edits](https://github.com/firecrawl/firecrawl-docs/edit/main/features/map.mdx) [Raise issue](https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&body=Path:%20/features/map)

[Interact after scraping\\
\\
Previous](https://docs.firecrawl.dev/features/interact) [Crawl\\
\\
Next](https://docs.firecrawl.dev/features/crawl)

Ctrl+I

Chat Widget

Loading...