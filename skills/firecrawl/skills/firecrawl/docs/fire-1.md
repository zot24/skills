> Source: https://docs.firecrawl.dev/agents/fire-1.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# FIRE-1 Agent (Beta)

> AI agent that enables intelligent navigation and interaction with web pages

FIRE-1 is an AI agent that enhances Firecrawl's scraping capabilities. It can controls browser actions and navigates complex website structures to enable comprehensive data extraction beyond traditional scraping methods.

### What FIRE-1 Can Do:

* Plan and take actions to uncover data
* Interact with buttons, links, inputs, and dynamic elements.
* Get multiple pages of data that require pagination, multiple steps, etc.

## How to use FIRE-1

You can leverage the FIRE-1 agent with the `/v1/extract` endpoint for complex extraction tasks that require navigation across multiple pages or interaction with elements.

**Example:**

<CodeGroup>
  ```python Python
  from firecrawl import FirecrawlApp

  app = FirecrawlApp(api_key="fc-YOUR_API_KEY")

  # Extract data from a website:
  extract_result = app.extract(['firecrawl.dev'],
    prompt="Extract all user comments from this forum thread.",
    schema={
      "type": "object",
      "properties": {
        "comments": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "author": {"type": "string"},
              "comment_text": {"type": "string"}
            },
            "required": ["author", "comment_text"]
          }
        }
      },
      "required": ["comments"]
    },
    agent={
      "model": "FIRE-1"
    }
  )

  print(extract_result)
  ```

  ```js Node
  import FirecrawlApp, { ExtractResponse } from '@mendable/firecrawl-js';

  const app = new FirecrawlApp({apiKey: "fc-YOUR_API_KEY"});

  // Extract from a website using schema and prompt:
  const extractResult = await app.extract(['https://example-forum.com/topic/123'], {
    prompt: "Extract all user comments from this forum thread.",
    schema: {
      type: "object",
      properties: {
        comments: {
          type: "array",
          items: {
            type: "object",
            properties: {
              author: {type: "string"},
              comment_text: {type: "string"}
            },
            required: ["author", "comment_text"]
          }
        }
      },
      required: ["comments"]
    },
    agent: {
      model: 'FIRE-1'
    }
  }) as ExtractResponse;

  if (!extractResult.success) {
    throw new Error(`Failed to extract: ${extractResult.error}`)
  }

  console.log(extractResult)
  ```

  ```bash curl
  curl -X POST https://api.firecrawl.dev/v1/extract \
      -H 'Content-Type: application/json' \
      -H 'Authorization: Bearer YOUR_API_KEY' \
      -d '{
        "urls": ["https://example-forum.com/topic/123"],
        "prompt": "Extract all user comments from this forum thread.",
        "schema": {
          "type": "object",
          "properties": {
            "comments": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "author": {"type": "string"},
                  "comment_text": {"type": "string"}
                },
                "required": ["author", "comment_text"]
              }
            }
          },
          "required": ["comments"]
        },
        "agent": {
          "model": "FIRE-1"
        }
      }'
  ```
</CodeGroup>

## Billing

The cost of using FIRE-1 is non-deterministic. See our [credit calculator](https://www.firecrawl.dev/extract-calculator) to learn about the base cost of each Extract request.

**Why is FIRE-1 more expensive?**\
FIRE-1 leverages advanced browser automation and AI planning to interact with complex web pages, which requires more compute resources than standard extraction.

## Rate limits

* `/extract`: 10 requests per minute
