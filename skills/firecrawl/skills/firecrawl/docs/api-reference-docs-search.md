> Source: https://docs.firecrawl.dev/api-reference/endpoint/docs-search.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Docs Search

> Answer Firecrawl documentation questions using the public docs corpus.

The `/support/docs-search` endpoint answers questions using Firecrawl's public documentation. Requires your Firecrawl API key. Returns a concise, docs-grounded answer with citations to the relevant documentation pages.

## Use cases

* **AI agents** that need to look up Firecrawl API usage, parameters, or best practices
* **Support bots** that answer customer questions from the docs
* **Developer tools** that surface relevant documentation inline

## Example

```bash
curl -X POST https://api.firecrawl.dev/v2/support/docs-search \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "what header carries the webhook signature, and how do I verify it?"
  }'
```

### Response

```json
{
  "requestId": "req_...",
  "answer": "The signature is sent in the X-Firecrawl-Signature header...",
  "evidence": [
    {
      "pathOrUrl": "webhooks/security.mdx#L1-L52",
      "reason": "Documents webhook signature verification"
    }
  ],
  "usage": { "inputTokens": 4356, "outputTokens": 688, "totalTokens": 5044 },
  "durationMs": 11252
}
```

## Response fields

| Field        | Type    | Description                                                      |
| ------------ | ------- | ---------------------------------------------------------------- |
| `answer`     | string  | Concise answer grounded in Firecrawl documentation               |
| `evidence`   | array   | Documentation pages referenced, with `pathOrUrl` and `reason`    |
| `usage`      | object  | Token consumption (`inputTokens`, `outputTokens`, `totalTokens`) |
| `durationMs` | integer | Total execution time in milliseconds                             |

For the full feature guide, see the [Ask feature documentation](/features/ask).

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json POST /support/docs-search
openapi: 3.0.0
info:
  title: Firecrawl API
  version: v2
  description: >-
    API for interacting with Firecrawl services to perform web scraping and
    crawling tasks.
  contact:
    name: Firecrawl Support
    url: https://firecrawl.dev/support
    email: support@firecrawl.dev
servers:
  - url: https://api.firecrawl.dev/v2
security:
  - bearerAuth: []
paths:
  /support/docs-search:
    post:
      tags:
        - Support
      summary: Search Firecrawl docs with citations
      description: Answer Firecrawl documentation questions using the public docs corpus.
      operationId: searchSupportDocs
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SupportDocsSearchRequest'
      responses:
        '200':
          description: Docs-grounded answer
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SupportDocsSearchResponse'
        '400':
          description: Invalid request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SupportProxyErrorResponse'
        '401':
          description: Missing or invalid bearer token
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SupportProxyErrorResponse'
        '503':
          description: Support agent unavailable
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SupportProxyErrorResponse'
        '504':
          description: Support agent timeout
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SupportProxyErrorResponse'
      security:
        - bearerAuth: []
components:
  schemas:
    SupportDocsSearchRequest:
      type: object
      required:
        - question
      properties:
        question:
          type: string
          description: Documentation question to answer.
    SupportDocsSearchResponse:
      type: object
      properties:
        requestId:
          type: string
        answer:
          type: string
          description: Concise answer grounded in Firecrawl documentation.
        evidence:
          type: array
          items:
            type: object
            properties:
              pathOrUrl:
                type: string
              reason:
                type: string
        usage:
          type: object
          properties:
            inputTokens:
              type: integer
            outputTokens:
              type: integer
            totalTokens:
              type: integer
        durationMs:
          type: integer
          description: Total docs-search execution time in milliseconds.
    SupportProxyErrorResponse:
      type: object
      properties:
        error:
          type: string
          description: Support proxy or upstream error code.
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
