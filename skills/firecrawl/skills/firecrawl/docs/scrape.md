> Source: https://docs.firecrawl.dev/features/scrape.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Scrape

> Turn any url into clean data

Firecrawl converts web pages into markdown, ideal for LLM applications.

* It manages complexities: proxies, caching, rate limits, js-blocked content
* Handles dynamic content: dynamic websites, js-rendered sites, PDFs, images
* Outputs clean markdown, structured data, screenshots or html.

For details, see the [Scrape Endpoint API Reference](https://docs.firecrawl.dev/api-reference/endpoint/scrape).


  Test scraping in the interactive playground — no code required.


If a request fails, see [Errors](/api-reference/errors) for the full catalog of error codes, causes, remedies, and retry guidance.

## Scraping a URL with Firecrawl

### /scrape endpoint

Used to scrape a URL and get its content.

### Installation

<CodeGroup>
  ```python Python
  # pip install firecrawl-py

  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )
  ```

  ```js Node
  // npm install firecrawl

  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });
  ```

  ```bash CLI
  # Install globally with npm
  npm install -g firecrawl

  # Authenticate (one-time setup)
  firecrawl login
  ```
</CodeGroup>

### Usage

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  # Scrape a website:
  doc = firecrawl.scrape("https://firecrawl.dev", formats=["markdown", "html"])
  print(doc)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  // Scrape a website:
  const doc = await firecrawl.scrape('https://firecrawl.dev', { formats: ['markdown', 'html'] });
  console.log(doc);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://firecrawl.dev",
      "formats": ["markdown", "html"]
    }'
  ```

  ```bash CLI
  # Scrape a URL and get markdown
  firecrawl https://firecrawl.dev

  # With multiple formats (returns JSON)
  firecrawl https://firecrawl.dev --format markdown,html,links --pretty
  ```
</CodeGroup>

For more details about the parameters, refer to the [API Reference](https://docs.firecrawl.dev/api-reference/endpoint/scrape).


  **PDFs and documents:** `/scrape` auto-detects PDFs, DOCX, and other document types from URLs. Pass a PDF URL the same way you would any webpage -- Firecrawl parses it and returns clean markdown. For local files that are not accessible by URL, use [`/parse`](/features/parse) instead.

  ```python Python
  doc = firecrawl.scrape("https://example.com/report.pdf", formats=["markdown"])
  print(doc.markdown)
  ```


  Each scrape consumes 1 credit. Additional credits apply for certain options: JSON mode costs 4 additional credits per page, question and highlights formats cost 4 additional credits per page per format, enhanced proxy costs 4 additional credits per page, PII redaction costs 4 additional credits per page, PDF parsing costs 1 credit per PDF page, and audio or video extraction costs 4 additional credits per page.


### Response

SDKs will return the data object directly. cURL will return the payload exactly as shown below.

```json theme={null}
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

## Scrape Formats

You can now choose what formats you want your output in. You can specify multiple output formats. Supported formats are:

* Markdown (`markdown`)
* Summary (`summary`)
* HTML (`html`) - cleaned version of the page's HTML
* Raw HTML (`rawHtml`) - unmodified HTML as received from the page
* Screenshot (`screenshot`, with options like `fullPage`, `quality`, `viewport`) — screenshot URLs expire after 24 hours
* Links (`links`)
* JSON (`json`) - structured output
* Images (`images`) - extract all image URLs from the page
* Branding (`branding`) - extract brand identity and design system
* Product (`product`) - extract a structured product (title, price, availability, variants) from product pages
* Audio (`audio`) - extract MP3 audio from supported video URLs, e.g. YouTube (returns a signed GCS URL, expires after 1 hour)
* Video (`video`) - extract best-quality video from supported video URLs, e.g. YouTube (returns a signed GCS URL, expires after 1 hour)
* Query (`query`, with `prompt` and optional `mode`) - ask a natural-language question about the page; the answer is returned in the `answer` field

Output keys will match the format you choose.

## Extract structured data

### /scrape (with json) endpoint

Used to extract structured data from scraped pages.


  Extracting products? For product pages, the [`product` format](#extract-product-data) returns structured product fields (title, price, availability, variants) deterministically — no LLM call and no schema to define. Reach for `json` when you need custom fields or non-product pages.


<CodeGroup>
  ```python Python
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

  ```js Node
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

  ```bash cURL
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
</CodeGroup>

Output:

```json JSON theme={null}
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

### Extracting without schema

You can now extract without a schema by just passing a `prompt` to the endpoint. The llm chooses the structure of the data.

<CodeGroup>
  ```python Python
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

  ```js Node
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

  ```bash cURL
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
</CodeGroup>

Output:

```json JSON theme={null}
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

### JSON format options

When using the `json` format, pass an object inside `formats` with the following parameters:

* `schema`: JSON Schema for the structured output.
* `prompt`: Optional prompt to help guide extraction when a schema is present or when you prefer light guidance.

## Extract brand identity

### /scrape (with branding) endpoint

The branding format extracts comprehensive brand identity information from a webpage, including colors, fonts, typography, spacing, UI components, and more. This is useful for design system analysis, brand monitoring, or building tools that need to understand a website's visual identity.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key='fc-YOUR_API_KEY',
  )

  result = firecrawl.scrape(
      url='https://firecrawl.dev',
      formats=['branding']
  )

  print(result['branding'])
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const result = await firecrawl.scrape('https://firecrawl.dev', {
      formats: ['branding']
  });

  console.log(result.branding);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://firecrawl.dev",
      "formats": ["branding"]
    }'
  ```
</CodeGroup>

### Response

The branding format returns a comprehensive `BrandingProfile` object with the following structure:

```json Output theme={null}
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

### Branding Profile Structure

The `branding` object contains the following properties:

* `colorScheme`: The detected color scheme (`"light"` or `"dark"`)
* `logo`: URL of the primary logo
* `colors`: Object containing brand colors:
  * `primary`, `secondary`, `accent`: Main brand colors
  * `background`, `textPrimary`, `textSecondary`: UI colors
  * `link`, `success`, `warning`, `error`: Semantic colors
* `fonts`: Array of font families used on the page
* `typography`: Detailed typography information:
  * `fontFamilies`: Primary, heading, and code font families
  * `fontSizes`: Size definitions for headings and body text
  * `fontWeights`: Weight definitions (light, regular, medium, bold)
  * `lineHeights`: Line height values for different text types
* `spacing`: Spacing and layout information:
  * `baseUnit`: Base spacing unit in pixels
  * `borderRadius`: Default border radius
  * `padding`, `margins`: Spacing values
* `components`: UI component styles:
  * `buttonPrimary`, `buttonSecondary`: Button styles
  * `input`: Input field styles
* `icons`: Icon style information
* `images`: Brand images (logo, favicon, og:image)
* `animations`: Animation and transition settings
* `layout`: Layout configuration (grid, header/footer heights)
* `personality`: Brand personality traits (tone, energy, target audience)

### Combining with other formats

You can combine the branding format with other formats to get comprehensive page data:

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key='fc-YOUR_API_KEY',
  )

  result = firecrawl.scrape(
      url='https://firecrawl.dev',
      formats=['markdown', 'branding', 'screenshot']
  )

  print(result['markdown'])
  print(result['branding'])
  print(result['screenshot'])
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const result = await firecrawl.scrape('https://firecrawl.dev', {
      formats: ['markdown', 'branding', 'screenshot']
  });

  console.log(result.markdown);
  console.log(result.branding);
  console.log(result.screenshot);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://firecrawl.dev",
      "formats": ["markdown", "branding", "screenshot"]
    }'
  ```
</CodeGroup>

## Extract product data

The `product` format extracts a structured product **deterministically** — the same kind of structured output as the [`json` format](#extract-structured-data), but without an LLM call or a schema you define, purpose-built for product pages. If you've been pulling product fields with a `json` schema, use `formats: ["product"]` instead — it's faster and cheaper, just limited to products.

It returns a `product` object with title, brand, category, description, and variants — where each variant carries price, original price, availability, and images — useful for price monitoring, catalog ingestion, or comparison-shopping tools.

### /scrape (with product) endpoint

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key='fc-YOUR_API_KEY',
  )

  result = firecrawl.scrape(
      url='https://example.com/products/wireless-headphones',
      formats=['product']
  )

  print(result['product'])
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const result = await firecrawl.scrape('https://example.com/products/wireless-headphones', {
      formats: ['product']
  });

  console.log(result.product);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://example.com/products/wireless-headphones",
      "formats": ["product"]
    }'
  ```
</CodeGroup>

### Response

The product format returns a `product` object with the following structure:

```json Output theme={null}
{
  "success": true,
  "data": {
    "product": {
      "title": "Wireless Noise-Cancelling Headphones",
      "brand": "Acme",
      "category": "Electronics > Audio > Headphones",
      "url": "https://example.com/products/wireless-headphones",
      "description": "Over-ear wireless headphones with active noise cancellation, 30-hour battery life, and plush memory-foam ear cushions for all-day comfort.",
      "variants": [
        {
          "id": "wireless-headphones-black",
          "sku": "ACME-WH-BLACK",
          "title": "Wireless Noise-Cancelling Headphones — Black",
          "values": {
            "color": "Black"
          },
          "price": {
            "amount": 199.99,
            "currency": "USD",
            "formatted": "$199.99"
          },
          "sale": {
            "originalPrice": {
              "amount": 249.99,
              "currency": "USD",
              "formatted": "$249.99"
            }
          },
          "availability": {
            "inStock": true,
            "text": "In Stock"
          },
          "images": [
            {
              "url": "https://example.com/images/headphones-black.jpg",
              "alt": "Wireless Noise-Cancelling Headphones — Black"
            }
          ]
        }
      ]
    }
  }
}
```

### Product object structure

The `product` object contains the following properties:

* `title`: The product name
* `brand`: The product brand (optional)
* `category`: The product category (optional)
* `url`: The canonical URL of the product
* `description`: The product description (optional)
* `variants`: Array of product variants. Pricing, availability, and images live on each variant — a single-SKU product still returns exactly one variant carrying these. Each variant has:
  * `id`, `sku`, `title`: variant identifiers and label (all optional)
  * `values`: a map of option name to value, e.g. `{ "color": "Charcoal" }` (optional)
  * `price`: the current price object (optional):
    * `amount`: The numeric price value
    * `currency`: The currency code, reported only when the page sources it (optional)
    * `formatted`: The price as displayed on the page (optional)
  * `sale`: present only when the variant is discounted (optional). Contains:
    * `originalPrice`: The original (pre-discount) price, same shape as `price`
  * `availability`: availability information, always present on a variant:
    * `inStock`: Whether the variant is in stock
    * `text`: The raw availability text from the page (optional)
  * `images`: array of variant images, each with a `url` and optional `alt` text (optional)

### How product extraction works

The product format extracts the product deterministically from on-page structured data — no LLM is involved. It merges multiple sources by priority: **JSON-LD > schema.org microdata > RDFa > embedded state (`__NEXT_DATA__`/Nuxt/Apollo/Redux/Remix) > AliExpress `runParams` > GA4 `dataLayer` > OpenGraph/`<meta>`**. The merge is identity-aware, so fields from different products are never combined. Currency is reported only when the page sources it.


  Product extraction is fail-closed: ambiguous pages yield no product, and weaker sources such as OpenGraph only contribute when a price is present. On a page with no extractable product, the response omits the `product` object and adds a `warning` (e.g. "No product found...").


  **Self-hosting:** the `product` format is backed by a dedicated product-extraction service. On Firecrawl Cloud it works out of the box. If you self-host, set `PRODUCT_EXTRACTION_SERVICE_URL` to point at that service — when it is unset, requesting the `product` format returns a warning and no product (the same pattern the audio/video formats use for their service).


### Combining with other formats

You can combine the product format with other formats to get comprehensive page data:

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key='fc-YOUR_API_KEY',
  )

  result = firecrawl.scrape(
      url='https://example.com/products/wireless-headphones',
      formats=['markdown', 'product']
  )

  print(result['markdown'])
  print(result['product'])
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const result = await firecrawl.scrape('https://example.com/products/wireless-headphones', {
      formats: ['markdown', 'product']
  });

  console.log(result.markdown);
  console.log(result.product);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://example.com/products/wireless-headphones",
      "formats": ["markdown", "product"]
    }'
  ```
</CodeGroup>

## Audio extraction

The `audio` format extracts audio from supported websites (e.g. YouTube) as MP3 files and returns a signed Google Cloud Storage URL. This is useful for building audio processing pipelines, transcription services, or podcast tools.


  Audio extraction costs 5 credits per page (1 base + 4 additional).


<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  doc = firecrawl.scrape("https://www.youtube.com/watch?v=dQw4w9WgXcQ", formats=["audio"])
  print(doc.audio)  # Signed GCS URL to the MP3 file
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const doc = await firecrawl.scrape('https://www.youtube.com/watch?v=dQw4w9WgXcQ', {
    formats: ['audio']
  });

  console.log(doc.audio); // Signed GCS URL to the MP3 file
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      "formats": ["audio"]
    }'
  ```
</CodeGroup>

## Video extraction

The `video` format extracts best-quality video from supported websites (e.g. YouTube) and returns a signed Google Cloud Storage URL. This is useful for building video processing pipelines, moderation tools, or media archiving workflows.


  Video extraction costs 5 credits per page (1 base + 4 additional).


<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  doc = firecrawl.scrape("https://www.youtube.com/watch?v=dQw4w9WgXcQ", formats=["video"])
  print(doc.video)  # Signed GCS URL to the video file
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const doc = await firecrawl.scrape('https://www.youtube.com/watch?v=dQw4w9WgXcQ', {
    formats: ['video']
  });

  console.log(doc.video); // Signed GCS URL to the video file
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      "formats": ["video"]
    }'
  ```
</CodeGroup>

<span id="question-format" />

## Question format

Use the `question` format to ask a natural-language question about the page. Firecrawl returns the answer in the response's `answer` field.


  The `question` format costs 5 credits per page (1 base + 4 additional for the LLM call).


Options inside the format object:

* `question` (required for `type: "question"`): the question to answer. Maximum 10,000 characters.

You can combine `question` with other formats — for example, request `markdown` and `question` together to get page content and an answer in a single call.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  doc = firecrawl.scrape(
      "https://firecrawl.dev",
      formats=[{"type": "question", "question": "What is Firecrawl?"}],
  )
  print(doc.answer)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const doc = await firecrawl.scrape('https://firecrawl.dev', {
    formats: [{ type: 'question', question: 'What is Firecrawl?' }],
  });

  console.log(doc.answer);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://firecrawl.dev",
      "formats": [
        { "type": "question", "question": "What is Firecrawl?" }
      ]
    }'
  ```
</CodeGroup>

The `question` format is also available in `/search` via `scrapeOptions`, which runs the same extraction across each search result.

<span id="highlights-format" />

## Highlights format

Use the `highlights` format to find relevant source text from the page. Firecrawl returns the selected text in the response's `highlights` field.


  The `highlights` format costs 5 credits per page (1 base + 4 additional for the LLM call).


Options inside the format object:

* `query` (required for `type: "highlights"`): the source-text selection request. Maximum 10,000 characters.

You can combine `highlights` with other formats — for example, request `markdown` and `highlights` together to get page content and source text in a single call.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  doc = firecrawl.scrape(
      "https://firecrawl.dev",
      formats=[{"type": "highlights", "query": "What is Firecrawl?"}],
  )
  print(doc.highlights)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const doc = await firecrawl.scrape('https://firecrawl.dev', {
    formats: [{ type: 'highlights', query: 'What is Firecrawl?' }],
  });

  console.log(doc.highlights);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://firecrawl.dev",
      "formats": [
        { "type": "highlights", "query": "What is Firecrawl?" }
      ]
    }'
  ```
</CodeGroup>

The `highlights` format is also available in `/search` via `scrapeOptions`, which runs the same extraction across each search result.

## PII redaction

Set `redactPII: true` to redact personally identifiable information from returned markdown. The `markdown` field contains the redacted result.

See [PII Redaction](/features/pii-redaction) for SDK, cURL, CLI, and MCP examples.

## Interacting with the page with Actions

Firecrawl allows you to perform various actions on a web page before scraping its content. This is particularly useful for interacting with dynamic content, navigating through pages, or accessing content that requires user interaction.


  **We recommend [Interact](/features/interact) over actions: our newer, more powerful way to interact with scraped pages.**

  Interact runs as a stateful browser session that stays alive across calls, so you can drive a page turn-by-turn with either:

  * **Natural language** for flexible, non-deterministic flows. e.g. *“search for ‘wireless headphones’, filter to 4+ stars under \$200, and return the results”*.
  * **Playwright or agent-browser code** for deterministic steps. e.g. `await page.click('#export')`.

  Interact also supports profiles, persistent sessions, and a live embeddable browser view (with an interactive mode where end users can drive the browser themselves).


Here is an example of how to use actions to navigate to google.com, search for Firecrawl, click on the first result, and take a screenshot.

It is important to almost always use the `wait` action before/after executing other actions to give enough time for the page to load.

### Example

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

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

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const doc = await firecrawl.scrape('https://example.com/login', {
    formats: ['markdown'],
    actions: [
      { type: 'write', text: 'john@example.com' },
      { type: 'press', key: 'Tab' },
      { type: 'write', text: 'secret' },
      { type: 'click', selector: 'button[type="submit"]' },
      { type: 'wait', milliseconds: 1500 },
      { type: 'screenshot', fullPage: true },
    ],
  });

  console.log(doc.markdown, doc.screenshot);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer YOUR_API_KEY" for higher rate limits:
  curl -X POST https://api.firecrawl.dev/v2/scrape \
      -H 'Content-Type: application/json' \
      -d '{
        "url": "https://example.com/login",
        "formats": ["markdown"],
        "actions": [
          { "type": "write", "text": "john@example.com" },
          { "type": "press", "key": "Tab" },
          { "type": "write", "text": "secret" },
          { "type": "click", "selector": "button[type=\"submit\"]" },
          { "type": "wait", "milliseconds": 1500 },
          { "type": "screenshot", "fullPage": true },
        ],
    }'
  ```
</CodeGroup>

### Output

<CodeGroup>
  ```json JSON
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
</CodeGroup>

For workflows that require richer browser control after scraping, such as authenticated sessions, multi-step navigation, or a live view of the page, we recommend [Interact](/features/interact) over extending the actions array.

## Location and Language

Specify country and preferred languages to get relevant content based on your target location and language preferences.

### How it works

When you specify the location settings, Firecrawl will use an appropriate proxy if available and emulate the corresponding language and timezone settings. By default, the location is set to 'US' if not specified.

### Usage

To use the location and language settings, include the `location` object in your request body with the following properties:

* `country`: ISO 3166-1 alpha-2 country code (e.g., 'US', 'AU', 'DE', 'JP'). Defaults to 'US'.
* `languages`: An array of preferred languages and locales for the request in order of priority. Defaults to the language of the specified location.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started — add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  doc = firecrawl.scrape('https://example.com',
      formats=['markdown'],
      location={
          'country': 'US',
          'languages': ['en']
      }
  )

  print(doc)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({
    // No API key needed to get started — add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const doc = await firecrawl.scrape('https://example.com', {
    formats: ['markdown'],
    location: { country: 'US', languages: ['en'] },
  });

  console.log(doc.metadata);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://example.com",
      "formats": ["markdown"],
      "location": { "country": "US", "languages": ["en"] }
    }'
  ```
</CodeGroup>

For more details about supported locations, refer to the [Proxies documentation](/features/proxies).

## Caching and maxAge

To make requests faster, Firecrawl serves results from cache by default when a recent copy is available.

* **Default freshness window**: `maxAge = 172800000` ms (2 days). If a cached page is newer than this, it’s returned instantly; otherwise, the page is scraped and then cached.
* **Performance**: This can speed up scrapes by up to 5x when data doesn’t need to be ultra-fresh.
* **Always fetch fresh**: Set `maxAge` to `0`. Note that this bypasses the cache entirely, so every request goes through the full scraping pipeline, meaning that the request will take longer to complete and is more likely to fail. Use a non-zero `maxAge` if freshness on every request is not critical.
* **Avoid storing**: Set `storeInCache` to `false` if you don’t want Firecrawl to cache/store results for this request.
* **Cache-only lookup**: Set `minAge` to perform a cache-only lookup without triggering a fresh scrape. The value is in milliseconds and specifies the minimum age the cached data must be. If no cached data is found, a `404` with error code `SCRAPE_NO_CACHED_DATA` is returned. Set `minAge` to `1` to accept any cached data regardless of age.
* **Change tracking**: Requests that include `changeTracking` bypass the cache, so `maxAge` is ignored.
* **Credits**: Cached results still cost 1 credit per page. Caching improves speed, not credit usage.

Example (force fresh content):

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl
  firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')

  doc = firecrawl.scrape(url='https://example.com', max_age=0, formats=['markdown'])
  print(doc)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  const doc = await firecrawl.scrape('https://example.com', { maxAge: 0, formats: ['markdown'] });
  console.log(doc);
  ```

  ```bash cURL
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://example.com",
      "maxAge": 0,
      "formats": ["markdown"]
    }'
  ```
</CodeGroup>

Example (use a 10-minute cache window):

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl
  firecrawl = Firecrawl(api_key='fc-YOUR_API_KEY')

  doc = firecrawl.scrape(url='https://example.com', max_age=600000, formats=['markdown', 'html'])
  print(doc)
  ```

  ```js Node

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  const doc = await firecrawl.scrape('https://example.com', { maxAge: 600000, formats: ['markdown', 'html'] });
  console.log(doc);
  ```

  ```bash cURL
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://example.com",
      "maxAge": 600000,
      "formats": ["markdown", "html"]
    }'
  ```
</CodeGroup>

## Batch scraping multiple URLs

You can now batch scrape multiple URLs at the same time. It takes the starting URLs and optional parameters as arguments. The params argument allows you to specify additional options for the batch scrape job, such as the output formats.

### How it works

It is very similar to how the `/crawl` endpoint works. It submits a batch scrape job and returns a job ID to check the status of the batch scrape.

The sdk provides 2 methods, synchronous and asynchronous. The synchronous method will return the results of the batch scrape job, while the asynchronous method will return a job ID that you can use to check the status of the batch scrape.

### Usage

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

  job = firecrawl.batch_scrape([
      "https://firecrawl.dev",
      "https://docs.firecrawl.dev",
  ], formats=["markdown"], poll_interval=2, wait_timeout=120)

  print(job)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  const job = await firecrawl.batchScrape([
    'https://firecrawl.dev',
    'https://docs.firecrawl.dev',
  ], { options: { formats: ['markdown'] }, pollInterval: 2, timeout: 120 });

  console.log(job);
  ```

  ```bash cURL
  curl -s -X POST "https://api.firecrawl.dev/v2/batch/scrape" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "urls": ["https://firecrawl.dev", "https://docs.firecrawl.dev"],
      "formats": ["markdown"]
    }'
  ```
</CodeGroup>

### Response

If you’re using the sync methods from the SDKs, it will return the results of the batch scrape job. Otherwise, it will return a job ID that you can use to check the status of the batch scrape.

#### Synchronous

```json Completed theme={null}
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

#### Asynchronous

You can then use the job ID to check the status of the batch scrape by calling the `/batch/scrape/{id}` endpoint. This endpoint is meant to be used while the job is still running or right after it has completed **as batch scrape jobs expire after 24 hours**.

```json theme={null}
{
  "success": true,
  "id": "123-456-789",
  "url": "https://api.firecrawl.dev/v2/batch/scrape/123-456-789"
}
```

## Enhanced Mode

For complex websites, Firecrawl offers enhanced mode that provides better success rates while maintaining privacy.

Learn more about [Enhanced Mode](/features/enhanced-mode).

## Zero Data Retention (ZDR)

Firecrawl supports Zero Data Retention (ZDR) for teams with strict data handling requirements. When enabled, Firecrawl will not persist any page content or extracted data beyond the lifetime of the request.

To enable ZDR, set `zeroDataRetention: true` in your request:

```bash cURL theme={null}
curl -X POST https://api.firecrawl.dev/v2/scrape \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "url": "https://example.com",
    "formats": ["markdown"],
    "zeroDataRetention": true
  }'
```

ZDR is available on Enterprise plans and must be enabled for your team. Visit [firecrawl.dev/enterprise](https://www.firecrawl.dev/enterprise) to get started.

ZDR adds **1 additional credit per page** on top of the base scrape cost.


  Screenshots are not available in ZDR mode. Because screenshots require uploading to persistent storage, they are incompatible with the ZDR guarantee. Requests that include both `zeroDataRetention: true` and a `screenshot` format will return an error.


> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
