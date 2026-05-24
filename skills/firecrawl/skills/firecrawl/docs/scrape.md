> Source: https://docs.firecrawl.dev/features/scrape



<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="https://firecrawl.dev" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">Firecrawl Docs home page</span><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=c45b3c967c19a39190e76fe8e9c2ed5a" class="nav-logo w-auto relative object-contain shrink-0 block dark:hidden h-6" alt="light logo" /><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=3fee4abe033bd3c26e8ad92043a91c17" class="nav-logo w-auto relative object-contain shrink-0 hidden dark:block h-6" alt="dark logo" /></a>


Search...


Scrape


Scrape


<a href="/introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor] hover:text-primary dark:hover:text-primary-light text-gray-800 dark:text-gray-200" data-active="true" aria-current="location">Documentation</a>


<a href="/sdks/overview" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">SDKs</a>


<a href="https://www.firecrawl.dev/app" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200" target="_blank" rel="noreferrer">Integrations</a>


<a href="/api-reference/v2-introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">API Reference</a>


<a href="/ai-onboarding" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">Build with AI</a>


Scrape


# Scrape


Copy page


Turn any url into clean data


Copy page


> ## Documentation Index
>
> Fetch the complete documentation index at: <https://docs.firecrawl.dev/llms.txt>
>
> Use this file to discover all available pages before exploring further.


- It manages complexities: proxies, caching, rate limits, js-blocked content
- Handles dynamic content: dynamic websites, js-rendered sites, PDFs, images
- Outputs clean markdown, structured data, screenshots or html.


## Try it in the Playground


If a request fails, see <a href="/api-reference/errors" class="link">Errors</a> for the full catalog of error codes, causes, remedies, and retry guidance.


## 


<a href="#scraping-a-url-with-firecrawl" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#/scrape-endpoint" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#installation" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


CLI


``` shiki
# pip install firecrawl-py

from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")
```


### 


<a href="#usage" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

# Scrape a website:
doc = firecrawl.scrape("https://firecrawl.dev", formats=["markdown", "html"])
print(doc)
```


### 


<a href="#response" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "data" : {
    "markdown": "Launch Week I is here! [See our Day 2 Release 🚀](https://www.firecrawl.dev/blog/launch-week-i-day-2-doubled-rate-limits)[💥 Get 2 months free...",
    "html": "<!DOCTYPE html><html lang=\"en\" class=\"light\" style=\"color-scheme: light;\"><body class=\"__variable_36bd41 __variable_d7dc5d font-inter ...",
    "metadata": {
      "title": "Home - Firecrawl",
      "description": "Firecrawl crawls and converts any website into clean markdown.",
      "language": "en",
      "keywords": "Firecrawl,Markdown,Data,Mendable,Langchain",
      "robots": "follow, index",
      "ogTitle": "Firecrawl",
      "ogDescription": "Turn any website into LLM-ready data.",
      "ogUrl": "https://www.firecrawl.dev/",
      "ogImage": "https://www.firecrawl.dev/og.png?123",
      "ogLocaleAlternate": [],
      "ogSiteName": "Firecrawl",
      "sourceURL": "https://firecrawl.dev",
      "statusCode": 200,
      "contentType": "text/html"
    }
  }
}
```


## 


<a href="#scrape-formats" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- Markdown (`markdown`)
- Summary (`summary`)
- HTML (`html`) - cleaned version of the page’s HTML
- Raw HTML (`rawHtml`) - unmodified HTML as received from the page
- Screenshot (`screenshot`, with options like `fullPage`, `quality`, `viewport`) — screenshot URLs expire after 24 hours
- Links (`links`)
- JSON (`json`) - structured output
- Images (`images`) - extract all image URLs from the page
- Branding (`branding`) - extract brand identity and design system
- Audio (`audio`) - extract MP3 audio from supported video URLs, e.g. YouTube (returns a signed GCS URL, expires after 1 hour)
- Video (`video`) - extract best-quality video from supported video URLs, e.g. YouTube (returns a signed GCS URL, expires after 1 hour)
- Query (`query`, with `prompt` and optional `mode`) - ask a natural-language question about the page; the answer is returned in the `answer` field


## 


<a href="#extract-structured-data" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#/scrape-with-json-endpoint" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


<a href="#extracting-without-schema" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


<a href="#json-format-options" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- `schema`: JSON Schema for the structured output.
- `prompt`: Optional prompt to help guide extraction when a schema is present or when you prefer light guidance.

## 


<a href="#extract-brand-identity" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#/scrape-with-branding-endpoint" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')

result = firecrawl.scrape(
    url='https://firecrawl.dev',
    formats=['branding']
)

print(result['branding'])
```


### 


<a href="#response-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "data": {
    "branding": {
      "colorScheme": "dark",
      "logo": "https://firecrawl.dev/logo.svg",
      "colors": {
        "primary": "#FF6B35",
        "secondary": "#004E89",
        "accent": "#F77F00",
        "background": "#1A1A1A",
        "textPrimary": "#FFFFFF",
        "textSecondary": "#B0B0B0"
      },
      "fonts": [
        {
          "family": "Inter"
        },
        {
          "family": "Roboto Mono"
        }
      ],
      "typography": {
        "fontFamilies": {
          "primary": "Inter",
          "heading": "Inter",
          "code": "Roboto Mono"
        },
        "fontSizes": {
          "h1": "48px",
          "h2": "36px",
          "h3": "24px",
          "body": "16px"
        },
        "fontWeights": {
          "regular": 400,
          "medium": 500,
          "bold": 700
        }
      },
      "spacing": {
        "baseUnit": 8,
        "borderRadius": "8px"
      },
      "components": {
        "buttonPrimary": {
          "background": "#FF6B35",
          "textColor": "#FFFFFF",
          "borderRadius": "8px"
        },
        "buttonSecondary": {
          "background": "transparent",
          "textColor": "#FF6B35",
          "borderColor": "#FF6B35",
          "borderRadius": "8px"
        }
      },
      "images": {
        "logo": "https://firecrawl.dev/logo.svg",
        "favicon": "https://firecrawl.dev/favicon.ico",
        "ogImage": "https://firecrawl.dev/og-image.png"
      }
    }
  }
}
```


### 


<a href="#branding-profile-structure" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- `colorScheme`: The detected color scheme (`"light"` or `"dark"`)
- `logo`: URL of the primary logo
- `colors`: Object containing brand colors:
  - `primary`, `secondary`, `accent`: Main brand colors
  - `background`, `textPrimary`, `textSecondary`: UI colors
  - `link`, `success`, `warning`, `error`: Semantic colors
- `fonts`: Array of font families used on the page
- `typography`: Detailed typography information:
  - `fontFamilies`: Primary, heading, and code font families
  - `fontSizes`: Size definitions for headings and body text
  - `fontWeights`: Weight definitions (light, regular, medium, bold)
  - `lineHeights`: Line height values for different text types
- `spacing`: Spacing and layout information:
  - `baseUnit`: Base spacing unit in pixels
  - `borderRadius`: Default border radius
  - `padding`, `margins`: Spacing values
- `components`: UI component styles:
  - `buttonPrimary`, `buttonSecondary`: Button styles
  - `input`: Input field styles
- `icons`: Icon style information
- `images`: Brand images (logo, favicon, og:image)
- `animations`: Animation and transition settings
- `layout`: Layout configuration (grid, header/footer heights)
- `personality`: Brand personality traits (tone, energy, target audience)

### 


<a href="#combining-with-other-formats" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')

result = firecrawl.scrape(
    url='https://firecrawl.dev',
    formats=['markdown', 'branding', 'screenshot']
)

print(result['markdown'])
print(result['branding'])
print(result['screenshot'])
```


## 


<a href="#audio-extraction" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

doc = firecrawl.scrape("https://www.youtube.com/watch?v=dQw4w9WgXcQ", formats=["audio"])
print(doc.audio)  # Signed GCS URL to the MP3 file
```


## 


<a href="#video-extraction" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

doc = firecrawl.scrape("https://www.youtube.com/watch?v=dQw4w9WgXcQ", formats=["video"])
print(doc.video)  # Signed GCS URL to the video file
```


## 


<a href="#question-format" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- `question` (required for `type: "question"`): the question to answer. Maximum 10,000 characters.


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

doc = firecrawl.scrape(
    "https://firecrawl.dev",
    formats=[{"type": "question", "question": "What is Firecrawl?"}],
)
print(doc.answer)
```


## 


<a href="#highlights-format" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- `query` (required for `type: "highlights"`): the source-text selection request. Maximum 10,000 characters.


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

doc = firecrawl.scrape(
    "https://firecrawl.dev",
    formats=[{"type": "highlights", "query": "What is Firecrawl?"}],
)
print(doc.highlights)
```


## 


<a href="#interacting-with-the-page-with-actions" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Natural language** for flexible, non-deterministic flows. e.g. *“search for ‘wireless headphones’, filter to 4+ stars under \$200, and return the results”*.
- **Playwright or agent-browser code** for deterministic steps. e.g. `await page.click('#export')`.


### 


<a href="#example" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

doc = firecrawl.scrape(
    url="https://example.com/login",
    formats=["markdown"],
    actions=[
        {"type": "write", "text": "john@example.com"},
        {"type": "press", "key": "Tab"},
        {"type": "write", "text": "secret"},
        {"type": "click", "selector": 'button[type="submit"]'},
        {"type": "wait", "milliseconds": 1500},
        {"type": "screenshot", "full_page": True},
    ],
)

print(doc.markdown, doc.screenshot)
```


### 


<a href="#output" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


JSON


``` shiki
{
  "success": true,
  "data": {
    "markdown": "Our first Launch Week is over! [See the recap 🚀](blog/firecrawl-launch-week-1-recap)...",
    "actions": {
      "screenshots": [
        "https://alttmdsdujxrfnakrkyi.supabase.co/storage/v1/object/public/media/screenshot-75ef2d87-31e0-4349-a478-fb432a29e241.png"
      ],
      "scrapes": [
        {
          "url": "https://www.firecrawl.dev/",
          "html": "<html><body><h1>Firecrawl</h1></body></html>"
        }
      ]
    },
    "metadata": {
      "title": "Home - Firecrawl",
      "description": "Firecrawl crawls and converts any website into clean markdown.",
      "language": "en",
      "keywords": "Firecrawl,Markdown,Data,Mendable,Langchain",
      "robots": "follow, index",
      "ogTitle": "Firecrawl",
      "ogDescription": "Turn any website into LLM-ready data.",
      "ogUrl": "https://www.firecrawl.dev/",
      "ogImage": "https://www.firecrawl.dev/og.png?123",
      "ogLocaleAlternate": [],
      "ogSiteName": "Firecrawl",
      "sourceURL": "http://google.com",
      "statusCode": 200
    }
  }
}
```


## 


<a href="#location-and-language" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#how-it-works" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#usage-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- `country`: ISO 3166-1 alpha-2 country code (e.g., ‘US’, ‘AU’, ‘DE’, ‘JP’). Defaults to ‘US’.
- `languages`: An array of preferred languages and locales for the request in order of priority. Defaults to the language of the specified location.


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

doc = firecrawl.scrape('https://example.com',
    formats=['markdown'],
    location={
        'country': 'US',
        'languages': ['en']
    }
)

print(doc)
```


## 


<a href="#caching-and-maxage" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Default freshness window**: `maxAge = 172800000` ms (2 days). If a cached page is newer than this, it’s returned instantly; otherwise, the page is scraped and then cached.
- **Performance**: This can speed up scrapes by up to 5x when data doesn’t need to be ultra-fresh.
- **Always fetch fresh**: Set `maxAge` to `0`. Note that this bypasses the cache entirely, so every request goes through the full scraping pipeline, meaning that the request will take longer to complete and is more likely to fail. Use a non-zero `maxAge` if freshness on every request is not critical.
- **Avoid storing**: Set `storeInCache` to `false` if you don’t want Firecrawl to cache/store results for this request.
- **Cache-only lookup**: Set `minAge` to perform a cache-only lookup without triggering a fresh scrape. The value is in milliseconds and specifies the minimum age the cached data must be. If no cached data is found, a `404` with error code `SCRAPE_NO_CACHED_DATA` is returned. Set `minAge` to `1` to accept any cached data regardless of age.
- **Change tracking**: Requests that include `changeTracking` bypass the cache, so `maxAge` is ignored.
- **Credits**: Cached results still cost 1 credit per page. Caching improves speed, not credit usage.


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl
firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')

doc = firecrawl.scrape(url='https://example.com', max_age=0, formats=['markdown'])
print(doc)
```


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl
firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')

doc = firecrawl.scrape(url='https://example.com', max_age=600000, formats=['markdown', 'html'])
print(doc)
```


## 


<a href="#batch-scraping-multiple-urls" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#how-it-works-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#usage-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

job = firecrawl.batch_scrape([
    "https://firecrawl.dev",
    "https://docs.firecrawl.dev",
], formats=["markdown"], poll_interval=2, wait_timeout=120)

print(job)
```


### 


<a href="#response-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


#### 


<a href="#synchronous" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "status": "completed",
  "total": 36,
  "completed": 36,
  "creditsUsed": 36,
  "expiresAt": "2024-00-00T00:00:00.000Z",
  "next": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789?skip=26",
  "data": [
    {
      "markdown": "[Firecrawl Docs home page![light logo](https://mintlify.s3-us-west-1.amazonaws.com/firecrawl/logo/light.svg)!...",
      "html": "<!DOCTYPE html><html lang=\"en\" class=\"js-focus-visible lg:[--scroll-mt:9.5rem]\" data-js-focus-visible=\"\">...",
      "metadata": {
        "title": "Build a 'Chat with website' using Groq Llama 3 | Firecrawl",
        "language": "en",
        "sourceURL": "https://docs.firecrawl.dev/learn/rag-llama3",
        "description": "Learn how to use Firecrawl, Groq Llama 3, and Langchain to build a 'Chat with your website' bot.",
        "ogLocaleAlternate": [],
        "statusCode": 200
      }
    },
    ...
  ]
}
```


#### 


<a href="#asynchronous" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "id": "123-456-789",
  "url": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789"
}
```


## 


<a href="#enhanced-mode" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#zero-data-retention-zdr" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/scrape \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "url": "https://example.com",
    "formats": ["markdown"],
    "zeroDataRetention": true
  }'
```


> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/scrape.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/scrape" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


<a href="/features/search" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-start"></a>


Search


<a href="/features/fast-scraping" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-end"></a>


Faster Scraping


