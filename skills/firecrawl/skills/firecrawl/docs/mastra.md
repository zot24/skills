> Source: https://docs.firecrawl.dev/quickstarts/mastra.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Mastra

> Wire Firecrawl into Mastra tools and agents so they can search, scrape, and interact with live web pages.

## Prerequisites

* Node.js 22.13+
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)
* An API key from a supported [Mastra model provider](https://mastra.ai/models)
* An existing Mastra project — follow the [Mastra quickstart](https://mastra.ai/guides/getting-started/quickstart) to set one up

## Install the SDK

```bash theme={null}
npm install firecrawl
```

## Set your API key

Add your API key to `.env`:

```bash theme={null}
FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

## Build the Firecrawl tools

Create `src/mastra/tools/firecrawl.ts` to expose search and scrape as Mastra tools:

```typescript theme={null}
import { Firecrawl } from "firecrawl";
import { createTool } from "@mastra/core/tools";
import { z } from "zod";

const firecrawl = new Firecrawl();

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
      results: (results.web ?? []).flatMap((item) =>
        "url" in item ? [{ title: item.title ?? null, url: item.url }] : [],
      ),
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

```typescript theme={null}
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

```typescript theme={null}
import { Mastra } from "@mastra/core";
import { webAgent } from "./agents/web-agent";

export const mastra = new Mastra({
  agents: { webAgent },
});
```

## Test in Studio

Run the dev server and open [Mastra Studio](https://mastra.ai/docs/studio/overview) at `http://localhost:4111`:

```bash theme={null}
npm run dev
```

Open the **Web Agent** and try prompts like:

* "Find the latest Firecrawl changelog and summarize the last release."
* "Search for Firecrawl pricing and extract the plan tiers."

## Give the agent a hosted browser

For pages that need clicks, typing, or scrolling, Mastra's [`@mastra/browser-firecrawl`](https://mastra.ai/integrations/browsers/firecrawl) package runs the agent's browser tools in a Firecrawl browser session, so you don't need a local Chromium install.

```bash theme={null}
npm install @mastra/browser-firecrawl agent-browser@0.19.0
```

> [!NOTE]
>
> Pin `agent-browser` to 0.19.0. Later releases ship only the CLI, so `@mastra/browser-firecrawl` fails to import with `Cannot find package .../agent-browser/index.js`.

Create `src/mastra/agents/browser-agent.ts`, then register `browserAgent` on your Mastra instance the same way as `webAgent`:

```typescript theme={null}
import { Agent } from "@mastra/core/agent";
import { FirecrawlBrowser } from "@mastra/browser-firecrawl";

export const browserAgent = new Agent({
  id: "browser-agent",
  name: "Browser Agent",
  instructions:
    "Use the browser tools to open pages, click, and type. Take a snapshot after each action to check the result.",
  model: "openai/gpt-5.4",
  browser: new FirecrawlBrowser({ apiKey: process.env.FIRECRAWL_API_KEY }),
});
```

Each conversation thread gets its own browser session by default. See the [Mastra Firecrawl browser docs](https://mastra.ai/integrations/browsers/firecrawl) for shared sessions, session timeouts, and saved profiles.

## Self-hosted Firecrawl

If you run Firecrawl yourself, add `FIRECRAWL_API_URL` to `.env`. The SDK reads it from the environment, so the tools above need no changes:

```bash theme={null}
FIRECRAWL_API_URL=http://localhost:3002
```

## Next steps

> [card] [Scrape docs](https://docs.firecrawl.dev/features/scrape.md)
>
> All scrape options including formats, actions, and proxies

> [card] [Search docs](https://docs.firecrawl.dev/features/search.md)
>
> Search the web and get full page content

> [card] [Agent docs](https://docs.firecrawl.dev/features/agent.md)
>
> Let an agent drive Firecrawl end to end

> [card] [Node SDK reference](https://docs.firecrawl.dev/sdks/node.md)
>
> Full SDK reference with crawl, map, batch scrape, and more


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
