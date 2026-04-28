> Source: https://docs.firecrawl.dev/quickstarts/fastify.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Fastify

> Use Firecrawl with Fastify to build high-performance web scraping and search APIs.

## Prerequisites

* Node.js 18+
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)

## Setup

```bash
npm install fastify @mendable/firecrawl-js
```

Add your API key to `.env`:

```bash
FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

## Search the web

```javascript
import Fastify from "fastify";
import Firecrawl from "@mendable/firecrawl-js";

const fastify = Fastify({ logger: true });
const firecrawl = new Firecrawl({ apiKey: process.env.FIRECRAWL_API_KEY });

fastify.post("/search", async (request) => {
  const { query } = request.body;
  return firecrawl.search(query, { limit: 5 });
});

fastify.listen({ port: 3000 });
```

## Scrape a page

```javascript
fastify.post("/scrape", async (request) => {
  const { url } = request.body;
  return firecrawl.scrape(url);
});
```

## Interact with a page

Use interact to control a live browser session — click buttons, fill forms, and extract dynamic content.

```javascript
fastify.post("/interact", async (request) => {
  const { url } = request.body;

  const result = await firecrawl.scrape(url, { formats: ['markdown'] });
  const scrapeId = result.metadata?.scrapeId;

  await firecrawl.interact(scrapeId, { prompt: 'Search for iPhone 16 Pro Max' });
  const response = await firecrawl.interact(scrapeId, { prompt: 'Click on the first result and tell me the price' });

  await firecrawl.stopInteraction(scrapeId);

  return { output: response.output };
});
```

## As a Fastify plugin

Encapsulate the client in a plugin for reuse across routes:

```javascript
import fp from "fastify-plugin";
import Firecrawl from "@mendable/firecrawl-js";

export default fp(async function firecrawlPlugin(fastify) {
  const client = new Firecrawl({ apiKey: process.env.FIRECRAWL_API_KEY });
  fastify.decorate("firecrawl", client);
});
```

Register the plugin, then use `fastify.firecrawl` in any route:

```javascript
fastify.register(firecrawlPlugin);

fastify.post("/search", async function (request) {
  const { query } = request.body;
  return this.firecrawl.search(query, { limit: 5 });
});
```

## Test it

```bash
curl -X POST http://localhost:3000/search \
  -H "Content-Type: application/json" \
  -d '{"query": "firecrawl web scraping"}'
```

## Next steps


    All scrape options including formats, actions, and proxies


    Search the web and get full page content


    Click, fill forms, and extract dynamic content


    Full SDK reference with crawl, map, batch scrape, and more


