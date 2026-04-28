> Source: https://docs.firecrawl.dev/quickstarts/mastra.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Mastra

> Wire Firecrawl into Mastra tools so your agents and workflows can search and scrape live web data.

## Prerequisites

* Node.js 22.13+
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)
* An API key from a supported [Mastra model provider](https://mastra.ai/models)
* An existing Mastra project — follow the [Mastra quickstart](https://mastra.ai/guides/getting-started/quickstart) to set one up

## Install the SDK

```bash
npm install @mendable/firecrawl-js
```

## Set your API key

Add your API key to `.env`:

```bash
FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

## Build the Firecrawl tools

Create `src/mastra/tools/firecrawl.ts` to expose search and scrape as Mastra tools:

```typescript
import Firecrawl from "@mendable/firecrawl-js";
import { createTool } from "@mastra/core/tools";
import { z } from "zod";

const firecrawl = new Firecrawl({ apiKey: process.env.FIRECRAWL_API_KEY! });

export const firecrawlSearch = createTool({
  id: "firecrawl-search",
  description: "Search the web and return top results.",
  inputSchema: z.object({ query: z.string().min(1) }),
  outputSchema: z.object({
    results: z.array(
      z.object({
        title: z.string().nullable(),
        url: z.string(),
      }),
    ),
  }),
  execute: async ({ query }) => {
    const results = await firecrawl.search(query, { limit: 3 });
    return {
      results: (results.web ?? []).map((item) => ({
        title: item.title ?? null,
        url: item.url,
      })),
    };
  },
});

export const firecrawlScrape = createTool({
  id: "firecrawl-scrape",
  description: "Scrape a URL and return markdown content.",
  inputSchema: z.object({ url: z.string().url() }),
  outputSchema: z.object({ markdown: z.string() }),
  execute: async ({ url }) => {
    const result = await firecrawl.scrape(url, {
      formats: ["markdown"],
      onlyMainContent: true,
    });
    return { markdown: result.markdown ?? "" };
  },
});
```

## Create the agent

Create `src/mastra/agents/web-agent.ts` and give it the Firecrawl tools:

```typescript
import { Agent } from "@mastra/core/agent";
import { firecrawlSearch, firecrawlScrape } from "../tools/firecrawl";

export const webAgent = new Agent({
  id: "web-agent",
  name: "Web Agent",
  instructions:
    "Use Firecrawl tools to search and scrape web pages, then summarize the results.",
  model: "openai/gpt-5.4",
  tools: { firecrawlSearch, firecrawlScrape },
});
```

## Register the agent

Register the agent on your Mastra instance in `src/mastra/index.ts`:

```typescript
import { Mastra } from "@mastra/core";
import { webAgent } from "./agents/web-agent";

export const mastra = new Mastra({
  agents: { webAgent },
});
```

## Test in Studio

Run the dev server and open [Mastra Studio](https://mastra.ai/docs/studio/overview):

```bash
mastra dev
```

Open the **Web Agent** and try prompts like:

* "Find the latest Firecrawl changelog and summarize the last release."
* "Search for Firecrawl pricing and extract the plan tiers."

## Self-hosted Firecrawl

If you run Firecrawl locally, set `FIRECRAWL_API_URL` and pass `apiUrl` to the client:

```typescript
const firecrawl = new Firecrawl({
  apiKey: process.env.FIRECRAWL_API_KEY!,
  apiUrl: process.env.FIRECRAWL_API_URL,
});
```

## Next steps


    All scrape options including formats, actions, and proxies


    Search the web and get full page content


    Let an agent drive Firecrawl end to end


    Full SDK reference with crawl, map, batch scrape, and more


