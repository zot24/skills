> Source: https://docs.firecrawl.dev/quickstarts/vercel-functions.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Vercel Functions

> Use Firecrawl with Vercel Functions to search, scrape, and interact with web data in serverless deployments.

## Prerequisites

* Vercel project (Next.js, SvelteKit, Nuxt, or standalone)
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)

## Setup

```bash
npm install @mendable/firecrawl-js
```

Add `FIRECRAWL_API_KEY` as an environment variable in your Vercel project settings, or in `.env.local` for local development:

```bash
FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

## Search the web

Create `api/search.ts` (or `app/api/search/route.ts` for Next.js):

```typescript
import Firecrawl from "@mendable/firecrawl-js";

const firecrawl = new Firecrawl({ apiKey: process.env.FIRECRAWL_API_KEY });

export async function POST(request: Request) {
  const { query } = await request.json();
  const results = await firecrawl.search(query, { limit: 5 });

  return new Response(JSON.stringify(results), {
    headers: { "Content-Type": "application/json" },
  });
}
```

## Scrape a page

Create `api/scrape.ts` (or `app/api/scrape/route.ts` for Next.js):

```typescript
import Firecrawl from "@mendable/firecrawl-js";

const firecrawl = new Firecrawl({ apiKey: process.env.FIRECRAWL_API_KEY });

export async function POST(request: Request) {
  const { url } = await request.json();
  const result = await firecrawl.scrape(url);

  return new Response(JSON.stringify(result), {
    headers: { "Content-Type": "application/json" },
  });
}
```

## Interact with a page

Create `api/interact.ts` (or `app/api/interact/route.ts` for Next.js):

```typescript
import Firecrawl from "@mendable/firecrawl-js";

const firecrawl = new Firecrawl({ apiKey: process.env.FIRECRAWL_API_KEY });

export async function POST(request: Request) {
  const result = await firecrawl.scrape("https://www.amazon.com", {
    formats: ["markdown"],
  });
  const scrapeId = result.metadata?.scrapeId;

  await firecrawl.interact(scrapeId, {
    prompt: "Search for iPhone 16 Pro Max",
  });
  const response = await firecrawl.interact(scrapeId, {
    prompt: "Click on the first result and tell me the price",
  });

  await firecrawl.stopInteraction(scrapeId);

  return new Response(JSON.stringify({ output: response.output }), {
    headers: { "Content-Type": "application/json" },
  });
}
```

## Deploy

```bash
vercel deploy
```

## Test it

```bash
curl -X POST https://your-project.vercel.app/api/search \
  -H "Content-Type: application/json" \
  -d '{"query": "firecrawl web scraping"}'
```


  Vercel Functions have a default timeout of 10 seconds on the Hobby plan and 60 seconds on Pro. For large crawl jobs, use the Firecrawl async API with webhooks instead.


## Next steps


    Search the web and get full page content


    All scrape options including formats, actions, and proxies


    Click, fill forms, and extract dynamic content


    Full SDK reference with crawl, map, batch scrape, and more


