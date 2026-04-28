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
| AU           | Australia            | Yes                 | No                     |
| BR           | Brazil               | Yes                 | No                     |
| CA           | Canada               | Yes                 | No                     |
| CN           | China                | Yes                 | No                     |
| CZ           | Czechia              | Yes                 | No                     |
| DE           | Germany              | Yes                 | No                     |
| DK           | Denmark              | Yes                 | Yes                    |
| EE           | Estonia              | Yes                 | No                     |
| EG           | Egypt                | Yes                 | No                     |
| ES           | Spain                | Yes                 | No                     |
| FR           | France               | Yes                 | No                     |
| GB           | United Kingdom       | Yes                 | No                     |
| GR           | Greece               | Yes                 | No                     |
| HU           | Hungary              | Yes                 | No                     |
| ID           | Indonesia            | Yes                 | No                     |
| IL           | Israel               | Yes                 | No                     |
| IN           | India                | Yes                 | No                     |
| IT           | Italy                | Yes                 | No                     |
| JP           | Japan                | Yes                 | No                     |
| MY           | Malaysia             | Yes                 | No                     |
| NO           | Norway               | Yes                 | No                     |
| PL           | Poland               | Yes                 | No                     |
| PT           | Portugal             | Yes                 | No                     |
| QA           | Qatar                | Yes                 | No                     |
| SG           | Singapore            | Yes                 | No                     |
| US           | United States        | Yes                 | Yes                    |
| VN           | Vietnam              | Yes                 | No                     |

The list of supported proxy locations will change over time.

If you need proxies in a location not listed above, please [contact us](mailto:help@firecrawl.com) and let us know your requirements.

If you do not specify a proxy or location, Firecrawl will automatically use US proxies.

## How to Specify Proxy Location

You can request a specific proxy location by setting the `location.country` parameter in your request. For example, to use a Brazilian proxy, set `location.country` to `BR`.

For full details, see the [API reference for `location.country`](https://docs.firecrawl.dev/api-reference/endpoint/scrape#body-location).

<CodeGroup>
  ```python Python
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

  ```js Node
  import Firecrawl from '@mendable/firecrawl-js';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  const doc = await firecrawl.scrape('https://example.com', {
    formats: ['markdown'],
    location: { country: 'US', languages: ['en'] },
  });

  console.log(doc.metadata);
  ```

  ```bash cURL
  curl -X POST "https://api.firecrawl.dev/v2/scrape" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "url": "https://example.com",
      "formats": ["markdown"],
      "location": { "country": "US", "languages": ["en"] }
    }'
  ```
</CodeGroup>

If you request a country where a proxy is not available, Firecrawl will use the closest available region (EU or US) and set the browser location to your requested country.

## Proxy Types

Firecrawl supports three types of proxies:

* **basic**: Proxies for scraping most sites. Fast and usually works.
* **enhanced**: Enhanced proxies for scraping complex sites while maintaining privacy. Slower, but more reliable on certain sites. [Learn more about Enhanced Mode →](/features/enhanced-mode)
* **auto**: Firecrawl will automatically retry scraping with enhanced proxies if the basic proxy fails. If the retry with enhanced is successful, 5 credits will be billed for the scrape. If the first attempt with basic is successful, only the regular cost will be billed.

***

> **Note:** For detailed information on using enhanced proxies, including credit costs and retry strategies, see the [Enhanced Mode documentation](/features/enhanced-mode).

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
