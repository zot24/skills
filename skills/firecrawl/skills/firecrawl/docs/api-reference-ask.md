> Source: https://docs.firecrawl.dev/api-reference/endpoint/ask.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Ask

> Diagnose Firecrawl job, account, and API usage issues with an AI support agent.

The `/support/ask` endpoint is an AI support agent that diagnoses issues with your Firecrawl jobs, account, and API usage. Send a question and receive a verified answer with actionable fix parameters — typically in 15–30 seconds.

## Designed for AI agents

`/support/ask` is built for **agent-to-agent** communication. If you're building an AI agent that uses Firecrawl, wire this endpoint into your error-handling flow so your agent can self-diagnose scraping failures, crawl issues, and configuration problems without human intervention.

Pass a `rationale` field to give the support agent context about what your end user is trying to accomplish. This helps prioritize the evidence gathering.

## How it works

1. **You describe the problem** — a natural-language question describing the issue.
2. **The agent investigates** — it inspects job logs, account state, documentation, and source code.
3. **The agent validates** — when possible, the agent tests a fix against the live Firecrawl API (e.g., retrying a scrape with adjusted parameters).
4. **You get a verified answer** — the response includes a prose `answer`, machine-readable `fixParameters` you can apply directly, and `validation` results showing whether the fix was tested.

## Authentication

Uses your Firecrawl API key as the bearer token. The request is automatically scoped to your team — you can only query your own jobs and account data.

```bash theme={null}
curl -X POST https://api.firecrawl.dev/v2/support/ask \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "my crawl returned 3 pages but I expected 50",
    "rationale": "user is on their third failed crawl attempt today"
  }'
```

## Response fields

| Field           | Type           | Description                                                                          |
| --------------- | -------------- | ------------------------------------------------------------------------------------ |
| `answer`        | string         | 2-4 sentence prose covering the diagnosis and fix                                    |
| `confidence`    | string         | `high`, `medium`, or `low`                                                           |
| `fixParameters` | object \| null | API parameters to apply the fix (e.g., `{"waitFor": 5000}`)                          |
| `validation`    | object \| null | Whether the fix was tested: `tested`, `result` (success/failure/skipped), `evidence` |
| `feedback`      | object \| null | Present when the agent gets stuck; `{ blockedBy, attempted }`. Null on success.      |
| `durationMs`    | integer        | Total execution time in milliseconds                                                 |

## Status codes

| Code  | Meaning                                         |
| ----- | ----------------------------------------------- |
| `200` | Answered or stuck (envelope always returned)    |
| `400` | Invalid JSON or schema violation                |
| `401` | Missing or invalid bearer token                 |
| `504` | Hit 60s hard budget — partial envelope returned |

For the feature guide with integration examples, see the [Ask feature documentation](/features/ask).

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json POST /support/ask
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
  /support/ask:
    post:
      tags:
        - Support
      summary: Ask the Firecrawl support agent
      description: >-
        Diagnose Firecrawl job, account, and API usage issues with an AI support
        agent.
      operationId: askSupportAgent
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SupportAskRequest'
      responses:
        '200':
          description: Support agent answer
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SupportAskResponse'
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
    SupportAskRequest:
      type: object
      required:
        - question
      additionalProperties: true
      properties:
        question:
          type: string
          description: Question or issue for the support agent to diagnose.
        rationale:
          type: string
          description: Optional context about what the end user is trying to accomplish.
    SupportAskResponse:
      type: object
      properties:
        answer:
          type: string
          description: Diagnosis and recommended fix.
        confidence:
          type: string
          enum:
            - high
            - medium
            - low
        fixParameters:
          type: object
          nullable: true
          additionalProperties: true
          description: Machine-readable API parameters that may fix the issue.
        validation:
          type: object
          nullable: true
          additionalProperties: true
          description: Validation result when the support agent tested or attempted a fix.
        feedback:
          type: object
          nullable: true
          additionalProperties: true
          description: Present when the support agent is blocked or needs more information.
        durationMs:
          type: integer
          description: Total support-agent execution time in milliseconds.
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
