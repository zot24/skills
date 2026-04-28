> Source: https://docs.firecrawl.dev/quickstarts/aws-lambda.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# AWS Lambda

> Use Firecrawl with AWS Lambda to search, scrape, and interact with web data in serverless functions.

## Prerequisites

* AWS account with Lambda access
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)

## Setup

```bash
mkdir firecrawl-lambda && cd firecrawl-lambda
npm init -y
npm install @mendable/firecrawl-js
```

## Search the web

Create `index.mjs` with a search handler:

```javascript
import Firecrawl from "@mendable/firecrawl-js";

const firecrawl = new Firecrawl({ apiKey: process.env.FIRECRAWL_API_KEY });

export async function handler(event) {
  const body = JSON.parse(event.body || "{}");

  if (body.action === "search") {
    const results = await firecrawl.search(body.query, { limit: 5 });
    return {
      statusCode: 200,
      body: JSON.stringify(results),
    };
  }

  return { statusCode: 400, body: JSON.stringify({ error: "Unknown action" }) };
}
```

## Scrape a page

Add a `scrape` action to the same handler:

```javascript
if (body.action === "scrape") {
  const result = await firecrawl.scrape(body.url);
  return {
    statusCode: 200,
    body: JSON.stringify(result),
  };
}
```

## Interact with a page

Add an `interact` action to control a live browser session — click buttons, fill forms, and extract dynamic content:

```javascript
if (body.action === "interact") {
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
  return {
    statusCode: 200,
    body: JSON.stringify({ output: response.output }),
  };
}
```

## Deploy

Package and deploy with the AWS CLI:

```bash
zip -r function.zip index.mjs node_modules/

aws lambda create-function \
  --function-name firecrawl-scraper \
  --runtime nodejs20.x \
  --handler index.handler \
  --zip-file fileb://function.zip \
  --role arn:aws:iam::YOUR_ACCOUNT:role/lambda-role \
  --environment Variables="{FIRECRAWL_API_KEY=fc-YOUR-API-KEY}" \
  --timeout 60
```


  Set the Lambda timeout to at least 30 seconds. Scraping dynamic pages and interact sessions can take longer than the default 3-second timeout.


## Next steps


    Search the web and get full page content


    All scrape options including formats, actions, and proxies


    Click, fill forms, and extract dynamic content


    Full SDK reference with crawl, map, batch scrape, and more


