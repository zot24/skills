> Source: https://docs.firecrawl.dev/features/proxies.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Proxies

> Learn about proxy types, locations, and how Firecrawl selects proxies for your requests.

Firecrawl provides different proxy types to help you scrape websites with varying levels of complexity. The proxy type can be specified using the `proxy` parameter.

> By default, Firecrawl routes all requests through proxies to help ensure reliability and access, even if you do not specify a proxy type or location.

## Location-Based Proxy Selection

Firecrawl automatically selects the best proxy based on your specified or detected location. This helps optimize scraping performance and reliability. However, not all locations are currently supported. The following locations are available:

| Country Code | Country Name         | Basic Proxy Support | Enhanced Proxy Support |
| ------------ | -------------------- | ------------------- | ---------------------- |
| AE           | United Arab Emirates | Yes                 | No                     |
| AT           | Austria              | Yes                 | No                     |
| AU           | Australia            | Yes                 | No                     |
| BE           | Belgium              | Yes                 | No                     |
| BR           | Brazil               | Yes                 | No                     |
| CA           | Canada               | Yes                 | No                     |
| CH           | Switzerland          | Yes                 | No                     |
| CN           | China                | Yes                 | No                     |
| DE           | Germany              | Yes                 | No                     |
| DK           | Denmark              | Yes                 | No                     |
| EG           | Egypt                | Yes                 | No                     |
| ES           | Spain                | Yes                 | No                     |
| FR           | France               | Yes                 | No                     |
| GB           | United Kingdom       | Yes                 | No                     |
| GR           | Greece               | Yes                 | No                     |
| IL           | Israel               | Yes                 | No                     |
| IN           | India                | Yes                 | No                     |
| IT           | Italy                | Yes                 | No                     |
| JP           | Japan                | Yes                 | No                     |
| MX           | Mexico               | Yes                 | No                     |
| NL           | Netherlands          | Yes                 | Yes                    |
| PL           | Poland               | Yes                 | No                     |
| QA           | Qatar                | Yes                 | No                     |
| SE           | Sweden               | Yes                 | No                     |
| TR           | Turkey               | Yes                 | No                     |
| US           | United States        | Yes                 | Yes                    |

The list of supported proxy locations will change over time.

If you need proxies in a location not listed above, please [contact us](mailto:help@firecrawl.com) and let us know your requirements.

If you do not specify a proxy or location, Firecrawl will automatically use US proxies.

## How to Specify Proxy Location

You can request a specific proxy location by setting the `location.country` parameter in your request. For example, to use a German proxy, set `location.country` to `DE`.

For full details, see the [API reference for `location.country`](https://docs.firecrawl.dev/api-reference/endpoint/scrape#body-location).

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

If you request a country where a proxy is not available, Firecrawl will use the closest available region (EU or US) and set the browser location to your requested country.

We highly recommend leaving `location` unspecified unless you are sure you need it.

## Proxy Types


  The `proxy` parameter is deprecated. We recommend `auto` — the default — which lets Firecrawl handle proxy selection for you.


* **basic**: Proxies for scraping most sites.
* **enhanced**: Enhanced proxies for scraping complex sites while maintaining privacy. [Learn more about Enhanced Mode →](/features/enhanced-mode)
* **auto**: Recommended. Firecrawl will automatically retry scraping with enhanced proxies if the basic proxy fails.

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
