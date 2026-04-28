> Source: https://docs.firecrawl.dev/features/enhanced-mode.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Enhanced Mode

> Use enhanced proxies for reliable scraping on complex sites

Firecrawl provides different proxy types to help you scrape websites with varying levels of complexity. Set the `proxy` parameter to control which proxy strategy is used for a request.

## Proxy types

Firecrawl supports three proxy types:

| Type       | Description                                                  | Speed  | Cost                                                        |
| ---------- | ------------------------------------------------------------ | ------ | ----------------------------------------------------------- |
| `basic`    | Standard proxies suitable for most sites                     | Fast   | 1 credit                                                    |
| `enhanced` | Enhanced proxies for complex sites                           | Slower | 5 credits per request                                       |
| `auto`     | Tries `basic` first, then retries with `enhanced` on failure | Varies | 1 credit if basic succeeds, 5 credits if enhanced is needed |

If you do not specify a proxy, Firecrawl defaults to `auto`.

## Basic usage

Set the `proxy` parameter to choose a proxy strategy. The following example uses `auto`, which lets Firecrawl decide when to escalate to enhanced proxies.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(api_key='fc-YOUR-API-KEY')

  # Choose proxy strategy: 'basic' | 'enhanced' | 'auto'
  doc = firecrawl.scrape('https://example.com', formats=['markdown'], proxy='auto')

  print(doc.warning or 'ok')
  ```

  ```js Node
  import Firecrawl from '@mendable/firecrawl-js';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  // Choose proxy strategy: 'basic' | 'enhanced' | 'auto'
  const doc = await firecrawl.scrape('https://example.com', {
    formats: ['markdown'],
    proxy: 'auto'
  });

  console.log(doc.warning || 'ok');
  ```

  ```bash cURL

  // Choose proxy strategy: 'basic' | 'enhanced' | 'auto'
  curl -X POST https://api.firecrawl.dev/v2/scrape \
      -H 'Content-Type: application/json' \
      -H 'Authorization: Bearer fc-YOUR-API-KEY' \
      -d '{
        "url": "https://example.com",
        "proxy": "auto"
      }'

  ```
</CodeGroup>


  Enhanced proxy requests cost **5 credits per request**. When using `auto`, the 5-credit cost only applies if the basic proxy fails and the enhanced retry succeeds.


> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
