[Skip to main content](https://docs.firecrawl.dev/features/scrape#content-area)

[Firecrawl Docs home page![light logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=c45b3c967c19a39190e76fe8e9c2ed5a)![dark logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=3fee4abe033bd3c26e8ad92043a91c17)](https://firecrawl.dev/)

v2
![US](https://d3gk2c5xim1je2.cloudfront.net/flags/US.svg)

English

Search...

Ctrl K

Search...

Navigation

Scrape

Scrape

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

- [Scraping a URL with Firecrawl](https://docs.firecrawl.dev/features/scrape#scraping-a-url-with-firecrawl)
- [/scrape endpoint](https://docs.firecrawl.dev/features/scrape#%2Fscrape-endpoint)
- [Installation](https://docs.firecrawl.dev/features/scrape#installation)
- [Usage](https://docs.firecrawl.dev/features/scrape#usage)
- [Response](https://docs.firecrawl.dev/features/scrape#response)
- [Scrape Formats](https://docs.firecrawl.dev/features/scrape#scrape-formats)
- [Extract structured data](https://docs.firecrawl.dev/features/scrape#extract-structured-data)
- [/scrape (with json) endpoint](https://docs.firecrawl.dev/features/scrape#%2Fscrape-with-json-endpoint)
- [Extracting without schema](https://docs.firecrawl.dev/features/scrape#extracting-without-schema)
- [JSON format options](https://docs.firecrawl.dev/features/scrape#json-format-options)
- [Extract brand identity](https://docs.firecrawl.dev/features/scrape#extract-brand-identity)
- [/scrape (with branding) endpoint](https://docs.firecrawl.dev/features/scrape#%2Fscrape-with-branding-endpoint)
- [Response](https://docs.firecrawl.dev/features/scrape#response-2)
- [Branding Profile Structure](https://docs.firecrawl.dev/features/scrape#branding-profile-structure)
- [Combining with other formats](https://docs.firecrawl.dev/features/scrape#combining-with-other-formats)
- [Audio extraction](https://docs.firecrawl.dev/features/scrape#audio-extraction)
- [Interacting with the page with Actions](https://docs.firecrawl.dev/features/scrape#interacting-with-the-page-with-actions)
- [Example](https://docs.firecrawl.dev/features/scrape#example)
- [Output](https://docs.firecrawl.dev/features/scrape#output)
- [Location and Language](https://docs.firecrawl.dev/features/scrape#location-and-language)
- [How it works](https://docs.firecrawl.dev/features/scrape#how-it-works)
- [Usage](https://docs.firecrawl.dev/features/scrape#usage-2)
- [Caching and maxAge](https://docs.firecrawl.dev/features/scrape#caching-and-maxage)
- [Batch scraping multiple URLs](https://docs.firecrawl.dev/features/scrape#batch-scraping-multiple-urls)
- [How it works](https://docs.firecrawl.dev/features/scrape#how-it-works-2)
- [Usage](https://docs.firecrawl.dev/features/scrape#usage-3)
- [Response](https://docs.firecrawl.dev/features/scrape#response-3)
- [Synchronous](https://docs.firecrawl.dev/features/scrape#synchronous)
- [Asynchronous](https://docs.firecrawl.dev/features/scrape#asynchronous)
- [Enhanced Mode](https://docs.firecrawl.dev/features/scrape#enhanced-mode)
- [Zero Data Retention (ZDR)](https://docs.firecrawl.dev/features/scrape#zero-data-retention-zdr)

![Firecrawl](https://docs.firecrawl.dev/logo/light.svg)![Firecrawl](https://docs.firecrawl.dev/logo/dark.svg)

### Ready to build?

Start getting web data for free and scale seamlessly as your project expands. **No credit card needed.**

[Start for free](https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=start_for_free) [See our plans](https://www.firecrawl.dev/pricing?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=see_our_plans)

Firecrawl converts web pages into markdown, ideal for LLM applications.

- It manages complexities: proxies, caching, rate limits, js-blocked content
- Handles dynamic content: dynamic websites, js-rendered sites, PDFs, images
- Outputs clean markdown, structured data, screenshots or html.

For details, see the [Scrape Endpoint API Reference](https://docs.firecrawl.dev/api-reference/endpoint/scrape).

[**Try it in the Playground** \\
\\
Test scraping in the interactive playground — no code required.](https://www.firecrawl.dev/playground?endpoint=scrape)

## [​](https://docs.firecrawl.dev/features/scrape\#scraping-a-url-with-firecrawl)  Scraping a URL with Firecrawl

### [​](https://docs.firecrawl.dev/features/scrape\#/scrape-endpoint)  /scrape endpoint

Used to scrape a URL and get its content.

### [​](https://docs.firecrawl.dev/features/scrape\#installation)  Installation

Python

Node

CLI

```
# pip install firecrawl-py

from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")
```

### [​](https://docs.firecrawl.dev/features/scrape\#usage)  Usage

Python

Node

cURL

CLI

```
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

# Scrape a website:
doc = firecrawl.scrape("https://firecrawl.dev", formats=["markdown", "html"])
print(doc)
```

For more details about the parameters, refer to the [API Reference](https://docs.firecrawl.dev/api-reference/endpoint/scrape).

Each scrape consumes 1 credit. Additional credits apply for certain options: JSON mode costs 4 additional credits per page, enhanced proxy costs 4 additional credits per page, PDF parsing costs 1 credit per PDF page, and audio extraction costs 4 additional credits per page.

### [​](https://docs.firecrawl.dev/features/scrape\#response)  Response

SDKs will return the data object directly. cURL will return the payload exactly as shown below.

```
{
  "success": true,
  "data" : {
    "markdown": "Launch Week I is here! [See our Day 2 Release 🚀](https://www.firecrawl.dev/blog/launch-week-i-day-2-doubled-rate-limits)[💥 Get 2 months free...",\
    "html": "<!DOCTYPE html><html lang=\"en\" class=\"light\" style=\"color-scheme: light;\"><body class=\"__variable_36bd41 __variable_d7dc5d font-inter ...",\
    "metadata": {\
      "title": "Home - Firecrawl",\
      "description": "Firecrawl crawls and converts any website into clean markdown.",\
      "language": "en",\
      "keywords": "Firecrawl,Markdown,Data,Mendable,Langchain",\
      "robots": "follow, index",\
      "ogTitle": "Firecrawl",\
      "ogDescription": "Turn any website into LLM-ready data.",\
      "ogUrl": "https://www.firecrawl.dev/",\
      "ogImage": "https://www.firecrawl.dev/og.png?123",\
      "ogLocaleAlternate": [],\
      "ogSiteName": "Firecrawl",\
      "sourceURL": "https://firecrawl.dev",\
      "statusCode": 200,\
      "contentType": "text/html"\
    }\
  }\
}\
```\
\
## [​](https://docs.firecrawl.dev/features/scrape\#scrape-formats)  Scrape Formats\
\
You can now choose what formats you want your output in. You can specify multiple output formats. Supported formats are:\
\
- Markdown (`markdown`)\
- Summary (`summary`)\
- HTML (`html`) \- cleaned version of the page’s HTML\
- Raw HTML (`rawHtml`) \- unmodified HTML as received from the page\
- Screenshot (`screenshot`, with options like `fullPage`, `quality`, `viewport`) — screenshot URLs expire after 24 hours\
- Links (`links`)\
- JSON (`json`) \- structured output\
- Images (`images`) \- extract all image URLs from the page\
- Branding (`branding`) \- extract brand identity and design system\
- Audio (`audio`) \- extract MP3 audio from supported video URLs, e.g. YouTube (returns a signed GCS URL, expires after 1 hour)\
\
Output keys will match the format you choose.\
\
## [​](https://docs.firecrawl.dev/features/scrape\#extract-structured-data)  Extract structured data\
\
### [​](https://docs.firecrawl.dev/features/scrape\#/scrape-with-json-endpoint)  /scrape (with json) endpoint\
\
Used to extract structured data from scraped pages.\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
from pydantic import BaseModel\
\
app = Firecrawl(api_key="fc-YOUR-API-KEY")\
\
class CompanyInfo(BaseModel):\
    company_mission: str\
    supports_sso: bool\
    is_open_source: bool\
    is_in_yc: bool\
\
result = app.scrape(\
    'https://firecrawl.dev',\
    formats=[{\
      "type": "json",\
      "schema": CompanyInfo.model_json_schema()\
    }],\
    only_main_content=False,\
    timeout=120000\
)\
\
print(result)\
```\
\
Output:\
\
JSON\
\
```\
{\
    "success": true,\
    "data": {\
      "json": {\
        "company_mission": "AI-powered web scraping and data extraction",\
        "supports_sso": true,\
        "is_open_source": true,\
        "is_in_yc": true\
      },\
      "metadata": {\
        "title": "Firecrawl",\
        "description": "AI-powered web scraping and data extraction",\
        "robots": "follow, index",\
        "ogTitle": "Firecrawl",\
        "ogDescription": "AI-powered web scraping and data extraction",\
        "ogUrl": "https://firecrawl.dev/",\
        "ogImage": "https://firecrawl.dev/og.png",\
        "ogLocaleAlternate": [],\
        "ogSiteName": "Firecrawl",\
        "sourceURL": "https://firecrawl.dev/"\
      },\
    }\
}\
```\
\
### [​](https://docs.firecrawl.dev/features/scrape\#extracting-without-schema)  Extracting without schema\
\
You can now extract without a schema by just passing a `prompt` to the endpoint. The llm chooses the structure of the data.\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
\
app = Firecrawl(api_key="fc-YOUR-API-KEY")\
\
result = app.scrape(\
    'https://firecrawl.dev',\
    formats=[{\
      "type": "json",\
      "prompt": "Extract the company mission from the page."\
    }],\
    only_main_content=False,\
    timeout=120000\
)\
\
print(result)\
```\
\
Output:\
\
JSON\
\
```\
{\
    "success": true,\
    "data": {\
      "json": {\
        "company_mission": "AI-powered web scraping and data extraction",\
      },\
      "metadata": {\
        "title": "Firecrawl",\
        "description": "AI-powered web scraping and data extraction",\
        "robots": "follow, index",\
        "ogTitle": "Firecrawl",\
        "ogDescription": "AI-powered web scraping and data extraction",\
        "ogUrl": "https://firecrawl.dev/",\
        "ogImage": "https://firecrawl.dev/og.png",\
        "ogLocaleAlternate": [],\
        "ogSiteName": "Firecrawl",\
        "sourceURL": "https://firecrawl.dev/"\
      },\
    }\
}\
```\
\
### [​](https://docs.firecrawl.dev/features/scrape\#json-format-options)  JSON format options\
\
When using the `json` format, pass an object inside `formats` with the following parameters:\
\
- `schema`: JSON Schema for the structured output.\
- `prompt`: Optional prompt to help guide extraction when a schema is present or when you prefer light guidance.\
\
## [​](https://docs.firecrawl.dev/features/scrape\#extract-brand-identity)  Extract brand identity\
\
### [​](https://docs.firecrawl.dev/features/scrape\#/scrape-with-branding-endpoint)  /scrape (with branding) endpoint\
\
The branding format extracts comprehensive brand identity information from a webpage, including colors, fonts, typography, spacing, UI components, and more. This is useful for design system analysis, brand monitoring, or building tools that need to understand a website’s visual identity.\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
\
firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')\
\
result = firecrawl.scrape(\
    url='https://firecrawl.dev',\
    formats=['branding']\
)\
\
print(result['branding'])\
```\
\
### [​](https://docs.firecrawl.dev/features/scrape\#response-2)  Response\
\
The branding format returns a comprehensive `BrandingProfile` object with the following structure:\
\
Output\
\
```\
{\
  "success": true,\
  "data": {\
    "branding": {\
      "colorScheme": "dark",\
      "logo": "https://firecrawl.dev/logo.svg",\
      "colors": {\
        "primary": "#FF6B35",\
        "secondary": "#004E89",\
        "accent": "#F77F00",\
        "background": "#1A1A1A",\
        "textPrimary": "#FFFFFF",\
        "textSecondary": "#B0B0B0"\
      },\
      "fonts": [\
        {\
          "family": "Inter"\
        },\
        {\
          "family": "Roboto Mono"\
        }\
      ],\
      "typography": {\
        "fontFamilies": {\
          "primary": "Inter",\
          "heading": "Inter",\
          "code": "Roboto Mono"\
        },\
        "fontSizes": {\
          "h1": "48px",\
          "h2": "36px",\
          "h3": "24px",\
          "body": "16px"\
        },\
        "fontWeights": {\
          "regular": 400,\
          "medium": 500,\
          "bold": 700\
        }\
      },\
      "spacing": {\
        "baseUnit": 8,\
        "borderRadius": "8px"\
      },\
      "components": {\
        "buttonPrimary": {\
          "background": "#FF6B35",\
          "textColor": "#FFFFFF",\
          "borderRadius": "8px"\
        },\
        "buttonSecondary": {\
          "background": "transparent",\
          "textColor": "#FF6B35",\
          "borderColor": "#FF6B35",\
          "borderRadius": "8px"\
        }\
      },\
      "images": {\
        "logo": "https://firecrawl.dev/logo.svg",\
        "favicon": "https://firecrawl.dev/favicon.ico",\
        "ogImage": "https://firecrawl.dev/og-image.png"\
      }\
    }\
  }\
}\
```\
\
### [​](https://docs.firecrawl.dev/features/scrape\#branding-profile-structure)  Branding Profile Structure\
\
The `branding` object contains the following properties:\
\
- `colorScheme`: The detected color scheme (`"light"` or `"dark"`)\
- `logo`: URL of the primary logo\
- `colors`: Object containing brand colors:\
\
  - `primary`, `secondary`, `accent`: Main brand colors\
  - `background`, `textPrimary`, `textSecondary`: UI colors\
  - `link`, `success`, `warning`, `error`: Semantic colors\
- `fonts`: Array of font families used on the page\
- `typography`: Detailed typography information:\
\
  - `fontFamilies`: Primary, heading, and code font families\
  - `fontSizes`: Size definitions for headings and body text\
  - `fontWeights`: Weight definitions (light, regular, medium, bold)\
  - `lineHeights`: Line height values for different text types\
- `spacing`: Spacing and layout information:\
\
  - `baseUnit`: Base spacing unit in pixels\
  - `borderRadius`: Default border radius\
  - `padding`, `margins`: Spacing values\
- `components`: UI component styles:\
\
  - `buttonPrimary`, `buttonSecondary`: Button styles\
  - `input`: Input field styles\
- `icons`: Icon style information\
- `images`: Brand images (logo, favicon, og:image)\
- `animations`: Animation and transition settings\
- `layout`: Layout configuration (grid, header/footer heights)\
- `personality`: Brand personality traits (tone, energy, target audience)\
\
### [​](https://docs.firecrawl.dev/features/scrape\#combining-with-other-formats)  Combining with other formats\
\
You can combine the branding format with other formats to get comprehensive page data:\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
\
firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')\
\
result = firecrawl.scrape(\
    url='https://firecrawl.dev',\
    formats=['markdown', 'branding', 'screenshot']\
)\
\
print(result['markdown'])\
print(result['branding'])\
print(result['screenshot'])\
```\
\
## [​](https://docs.firecrawl.dev/features/scrape\#audio-extraction)  Audio extraction\
\
The `audio` format extracts audio from supported websites (e.g. YouTube) as MP3 files and returns a signed Google Cloud Storage URL. This is useful for building audio processing pipelines, transcription services, or podcast tools.\
\
Audio extraction costs 5 credits per page (1 base + 4 additional).\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
\
firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")\
\
doc = firecrawl.scrape("https://www.youtube.com/watch?v=dQw4w9WgXcQ", formats=["audio"])\
print(doc.audio)  # Signed GCS URL to the MP3 file\
```\
\
## [​](https://docs.firecrawl.dev/features/scrape\#interacting-with-the-page-with-actions)  Interacting with the page with Actions\
\
Firecrawl allows you to perform various actions on a web page before scraping its content. This is particularly useful for interacting with dynamic content, navigating through pages, or accessing content that requires user interaction.Here is an example of how to use actions to navigate to google.com, search for Firecrawl, click on the first result, and take a screenshot.It is important to almost always use the `wait` action before/after executing other actions to give enough time for the page to load.\
\
### [​](https://docs.firecrawl.dev/features/scrape\#example)  Example\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
\
firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")\
\
doc = firecrawl.scrape(\
    url="https://example.com/login",\
    formats=["markdown"],\
    actions=[\
        {"type": "write", "text": "john@example.com"},\
        {"type": "press", "key": "Tab"},\
        {"type": "write", "text": "secret"},\
        {"type": "click", "selector": 'button[type="submit"]'},\
        {"type": "wait", "milliseconds": 1500},\
        {"type": "screenshot", "full_page": True},\
    ],\
)\
\
print(doc.markdown, doc.screenshot)\
```\
\
### [​](https://docs.firecrawl.dev/features/scrape\#output)  Output\
\
JSON\
\
```\
{\
  "success": true,\
  "data": {\
    "markdown": "Our first Launch Week is over! [See the recap 🚀](blog/firecrawl-launch-week-1-recap)...",\
    "actions": {\
      "screenshots": [\
        "https://alttmdsdujxrfnakrkyi.supabase.co/storage/v1/object/public/media/screenshot-75ef2d87-31e0-4349-a478-fb432a29e241.png"\
      ],\
      "scrapes": [\
        {\
          "url": "https://www.firecrawl.dev/",\
          "html": "<html><body><h1>Firecrawl</h1></body></html>"\
        }\
      ]\
    },\
    "metadata": {\
      "title": "Home - Firecrawl",\
      "description": "Firecrawl crawls and converts any website into clean markdown.",\
      "language": "en",\
      "keywords": "Firecrawl,Markdown,Data,Mendable,Langchain",\
      "robots": "follow, index",\
      "ogTitle": "Firecrawl",\
      "ogDescription": "Turn any website into LLM-ready data.",\
      "ogUrl": "https://www.firecrawl.dev/",\
      "ogImage": "https://www.firecrawl.dev/og.png?123",\
      "ogLocaleAlternate": [],\
      "ogSiteName": "Firecrawl",\
      "sourceURL": "http://google.com",\
      "statusCode": 200\
    }\
  }\
}\
```\
\
For more details about the actions parameters, refer to the [API Reference](https://docs.firecrawl.dev/api-reference/endpoint/scrape).\
\
## [​](https://docs.firecrawl.dev/features/scrape\#location-and-language)  Location and Language\
\
Specify country and preferred languages to get relevant content based on your target location and language preferences.\
\
### [​](https://docs.firecrawl.dev/features/scrape\#how-it-works)  How it works\
\
When you specify the location settings, Firecrawl will use an appropriate proxy if available and emulate the corresponding language and timezone settings. By default, the location is set to ‘US’ if not specified.\
\
### [​](https://docs.firecrawl.dev/features/scrape\#usage-2)  Usage\
\
To use the location and language settings, include the `location` object in your request body with the following properties:\
\
- `country`: ISO 3166-1 alpha-2 country code (e.g., ‘US’, ‘AU’, ‘DE’, ‘JP’). Defaults to ‘US’.\
- `languages`: An array of preferred languages and locales for the request in order of priority. Defaults to the language of the specified location.\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
\
firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")\
\
doc = firecrawl.scrape('https://example.com',\
    formats=['markdown'],\
    location={\
        'country': 'US',\
        'languages': ['en']\
    }\
)\
\
print(doc)\
```\
\
For more details about supported locations, refer to the [Proxies documentation](https://docs.firecrawl.dev/features/proxies).\
\
## [​](https://docs.firecrawl.dev/features/scrape\#caching-and-maxage)  Caching and maxAge\
\
To make requests faster, Firecrawl serves results from cache by default when a recent copy is available.\
\
- **Default freshness window**: `maxAge = 172800000` ms (2 days). If a cached page is newer than this, it’s returned instantly; otherwise, the page is scraped and then cached.\
- **Performance**: This can speed up scrapes by up to 5x when data doesn’t need to be ultra-fresh.\
- **Always fetch fresh**: Set `maxAge` to `0`. Note that this bypasses the cache entirely, so every request goes through the full scraping pipeline, meaning that the request will take longer to complete and is more likely to fail. Use a non-zero `maxAge` if freshness on every request is not critical.\
- **Avoid storing**: Set `storeInCache` to `false` if you don’t want Firecrawl to cache/store results for this request.\
- **Cache-only lookup**: Set `minAge` to perform a cache-only lookup without triggering a fresh scrape. The value is in milliseconds and specifies the minimum age the cached data must be. If no cached data is found, a `404` with error code `SCRAPE_NO_CACHED_DATA` is returned. Set `minAge` to `1` to accept any cached data regardless of age.\
- **Change tracking**: Requests that include `changeTracking` bypass the cache, so `maxAge` is ignored.\
- **Credits**: Cached results still cost 1 credit per page. Caching improves speed, not credit usage.\
\
Example (force fresh content):\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')\
\
doc = firecrawl.scrape(url='https://example.com', max_age=0, formats=['markdown'])\
print(doc)\
```\
\
Example (use a 10-minute cache window):\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')\
\
doc = firecrawl.scrape(url='https://example.com', max_age=600000, formats=['markdown', 'html'])\
print(doc)\
```\
\
## [​](https://docs.firecrawl.dev/features/scrape\#batch-scraping-multiple-urls)  Batch scraping multiple URLs\
\
You can now batch scrape multiple URLs at the same time. It takes the starting URLs and optional parameters as arguments. The params argument allows you to specify additional options for the batch scrape job, such as the output formats.\
\
### [​](https://docs.firecrawl.dev/features/scrape\#how-it-works-2)  How it works\
\
It is very similar to how the `/crawl` endpoint works. It submits a batch scrape job and returns a job ID to check the status of the batch scrape.The sdk provides 2 methods, synchronous and asynchronous. The synchronous method will return the results of the batch scrape job, while the asynchronous method will return a job ID that you can use to check the status of the batch scrape.\
\
### [​](https://docs.firecrawl.dev/features/scrape\#usage-3)  Usage\
\
Python\
\
Node\
\
cURL\
\
```\
from firecrawl import Firecrawl\
\
firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")\
\
job = firecrawl.batch_scrape([\
    "https://firecrawl.dev",\
    "https://docs.firecrawl.dev",\
], formats=["markdown"], poll_interval=2, wait_timeout=120)\
\
print(job)\
```\
\
### [​](https://docs.firecrawl.dev/features/scrape\#response-3)  Response\
\
If you’re using the sync methods from the SDKs, it will return the results of the batch scrape job. Otherwise, it will return a job ID that you can use to check the status of the batch scrape.\
\
#### [​](https://docs.firecrawl.dev/features/scrape\#synchronous)  Synchronous\
\
Completed\
\
```\
{\
  "status": "completed",\
  "total": 36,\
  "completed": 36,\
  "creditsUsed": 36,\
  "expiresAt": "2024-00-00T00:00:00.000Z",\
  "next": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789?skip=26",\
  "data": [\
    {\
      "markdown": "[Firecrawl Docs home page![light logo](https://mintlify.s3-us-west-1.amazonaws.com/firecrawl/logo/light.svg)!...",\
      "html": "<!DOCTYPE html><html lang=\"en\" class=\"js-focus-visible lg:[--scroll-mt:9.5rem]\" data-js-focus-visible=\"\">...",\
      "metadata": {\
        "title": "Build a 'Chat with website' using Groq Llama 3 | Firecrawl",\
        "language": "en",\
        "sourceURL": "https://docs.firecrawl.dev/learn/rag-llama3",\
        "description": "Learn how to use Firecrawl, Groq Llama 3, and Langchain to build a 'Chat with your website' bot.",\
        "ogLocaleAlternate": [],\
        "statusCode": 200\
      }\
    },\
    ...\
  ]\
}\
```\
\
#### [​](https://docs.firecrawl.dev/features/scrape\#asynchronous)  Asynchronous\
\
You can then use the job ID to check the status of the batch scrape by calling the `/batch/scrape/{id}` endpoint. This endpoint is meant to be used while the job is still running or right after it has completed **as batch scrape jobs expire after 24 hours**.\
\
```\
{\
  "success": true,\
  "id": "123-456-789",\
  "url": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789"\
}\
```\
\
## [​](https://docs.firecrawl.dev/features/scrape\#enhanced-mode)  Enhanced Mode\
\
For complex websites, Firecrawl offers enhanced mode that provides better success rates while maintaining privacy.Learn more about [Enhanced Mode](https://docs.firecrawl.dev/features/enhanced-mode).\
\
## [​](https://docs.firecrawl.dev/features/scrape\#zero-data-retention-zdr)  Zero Data Retention (ZDR)\
\
Firecrawl supports Zero Data Retention (ZDR) for teams with strict data handling requirements. When enabled, Firecrawl will not persist any page content or extracted data beyond the lifetime of the request.To enable ZDR, set `zeroDataRetention: true` in your request:\
\
cURL\
\
```\
curl -X POST https://api.firecrawl.dev/v2/scrape \\
  -H "Content-Type: application/json" \\
  -H "Authorization: Bearer fc-YOUR_API_KEY" \\
  -d '{\
    "url": "https://example.com",\
    "formats": ["markdown"],\
    "zeroDataRetention": true\
  }'\
```\
\
ZDR is available on Enterprise plans and must be enabled for your team. Visit [firecrawl.dev/enterprise](https://www.firecrawl.dev/enterprise) to get started.ZDR adds **1 additional credit per page** on top of the base scrape cost.\
\
Screenshots are not available in ZDR mode. Because screenshots require uploading to persistent storage, they are incompatible with the ZDR guarantee. Requests that include both `zeroDataRetention: true` and a `screenshot` format will return an error.\
\
> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.\
\
[Suggest edits](https://github.com/firecrawl/firecrawl-docs/edit/main/features/scrape.mdx) [Raise issue](https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&body=Path:%20/features/scrape)\
\
[Search\\
\\
Previous](https://docs.firecrawl.dev/features/search) [Faster Scraping\\
\\
Next](https://docs.firecrawl.dev/features/fast-scraping)\
\
Ctrl+I\
\
Chat Widget\
\
Loading...