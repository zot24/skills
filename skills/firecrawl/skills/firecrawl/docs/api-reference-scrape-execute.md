> Source: https://docs.firecrawl.dev/api-reference/endpoint/scrape-execute.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Interact with the page

> Execute code or an AI prompt in the browser session bound to a scrape job.

Use this endpoint to continue interacting with the same browser state initialized from a previous scrape. Either `code` or `prompt` must be provided — not both.

`POST /v2/scrape/{jobId}/interact` handles the full lifecycle:

1. If no browser session exists for this scrape job yet, Firecrawl creates one at the same page state as the original scrape.
2. When `code` is provided, Firecrawl runs it in the browser sandbox. When `prompt` is provided, an AI agent automates the task using natural language.
3. Later `POST /interact` calls on the same `jobId` reuse the same live browser state.

When you are done, call `DELETE /v2/scrape/{jobId}/interact` to stop the session.

## Path Parameters

| Parameter | Type          | Required | Description                                                            |
| --------- | ------------- | -------- | ---------------------------------------------------------------------- |
| `jobId`   | string (UUID) | Yes      | The scrape job ID from `data.metadata.scrapeId` in the scrape response |

## Request Body

| Parameter  | Type   | Required | Default  | Description                                                                                |
| ---------- | ------ | -------- | -------- | ------------------------------------------------------------------------------------------ |
| `code`     | string | No       | —        | Code to execute in the browser sandbox (1–100,000 chars). Required if `prompt` is not set. |
| `prompt`   | string | No       | —        | Natural language task for the AI agent (1–10,000 chars). Required if `code` is not set.    |
| `language` | string | No       | `"node"` | One of `"python"`, `"node"`, or `"bash"`. Only used with `code`.                           |
| `timeout`  | number | No       | `30`     | Execution timeout in seconds (1–300).                                                      |
| `origin`   | string | No       | —        | Optional origin label used for telemetry.                                                  |

## Response

| Field                    | Type    | Description                                                                        |
| ------------------------ | ------- | ---------------------------------------------------------------------------------- |
| `success`                | boolean | Whether the execution completed without errors                                     |
| `liveViewUrl`            | string  | Read-only live view URL for the browser session                                    |
| `interactiveLiveViewUrl` | string  | Interactive live view URL (viewers can control the browser)                        |
| `output`                 | string  | AI agent's final response (only present when using `prompt`)                       |
| `stdout`                 | string  | Standard output from the code execution                                            |
| `result`                 | string  | Return value — last expression value for Node.js, final page snapshot for `prompt` |
| `stderr`                 | string  | Standard error output                                                              |
| `exitCode`               | number  | Exit code of the execution (`0` = success)                                         |
| `killed`                 | boolean | Whether the execution was terminated due to timeout                                |
| `error`                  | string  | Error message (only present on failure)                                            |

### Example Request (Code)

```bash
curl -X POST "https://api.firecrawl.dev/v2/scrape/550e8400-e29b-41d4-a716-446655440000/interact" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "code": "const title = await page.title(); JSON.stringify({ title });",
    "language": "node",
    "timeout": 30
  }'
```

### Example Response (Code)

```json
{
  "success": true,
  "liveViewUrl": "https://liveview.firecrawl.dev/...",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
  "stdout": "",
  "result": "{\"title\":\"Example Domain\"}",
  "stderr": "",
  "exitCode": 0,
  "killed": false
}
```

### Example Request (Prompt)

```bash
curl -X POST "https://api.firecrawl.dev/v2/scrape/550e8400-e29b-41d4-a716-446655440000/interact" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Find the pricing section and tell me the price of the Pro plan",
    "timeout": 60
  }'
```

### Example Response (Prompt)

```json
{
  "success": true,
  "liveViewUrl": "https://liveview.firecrawl.dev/...",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
  "output": "The Pro plan costs $49/month and includes unlimited scrapes, priority support, and custom integrations.",
  "stdout": "...",
  "result": "...",
  "stderr": "",
  "exitCode": 0,
  "killed": false
}
```

### Error Codes

| Status | Description                                                 |
| ------ | ----------------------------------------------------------- |
| `402`  | Insufficient credits for a browser session                  |
| `403`  | Scrape job belongs to a different team                      |
| `404`  | Scrape job not found                                        |
| `409`  | Replay context unavailable — rerun the scrape and try again |
| `410`  | Browser session has already been destroyed                  |
| `429`  | Maximum concurrent browser sessions reached                 |
| `502`  | Browser service or AI agent execution failed                |
| `503`  | Browser feature not configured (self-hosted only)           |

For detailed usage with examples, see the [Interact feature guide](/features/interact).


## OpenAPI

````yaml /api-reference/v2-openapi.json POST /scrape/{jobId}/interact
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
  /scrape/{jobId}/interact:
    post:
      tags:
        - Scraping
      summary: Interact with the browser session associated with a scrape job
      operationId: interactWithScrapeBrowserSession
      parameters:
        - name: jobId
          in: path
          required: true
          schema:
            type: string
            format: uuid
          description: The scrape job ID
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              required:
                - code
              properties:
                code:
                  type: string
                  minLength: 1
                  maxLength: 100000
                  description: Code to execute in the scrape-bound browser sandbox
                language:
                  type: string
                  enum:
                    - python
                    - node
                    - bash
                  default: node
                  description: >-
                    Language of the code to execute. Use `node` for JavaScript
                    or `bash` for agent-browser CLI commands.
                timeout:
                  type: integer
                  minimum: 1
                  maximum: 300
                  default: 30
                  description: Execution timeout in seconds
                origin:
                  type: string
                  description: Optional origin label used for execution telemetry
      responses:
        '200':
          description: Code executed successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                  stdout:
                    type: string
                    nullable: true
                    description: Standard output from the code execution
                  result:
                    type: string
                    nullable: true
                    description: Standard output (alias for stdout)
                  stderr:
                    type: string
                    nullable: true
                    description: Standard error output from the code execution
                  exitCode:
                    type: integer
                    nullable: true
                    description: Exit code of the executed process
                  killed:
                    type: boolean
                    description: Whether the process was killed due to timeout
                  error:
                    type: string
                    nullable: true
                    description: Error message if the code raised an exception
        '400':
          description: Invalid job ID
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: Invalid job ID format.
        '402':
          description: Payment required
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: Payment required to access this resource.
        '403':
          description: Forbidden
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: Forbidden.
        '404':
          description: Scrape job not found
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: Job not found.
        '409':
          description: >-
            Scrape replay context is unavailable or session could not be
            initialized
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: >-
                      Replay context is unavailable for this scrape job. Please
                      rerun the scrape.
        '410':
          description: Scrape browser session has already been destroyed
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: Browser session has been destroyed.
        '429':
          description: Too many active browser sessions
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: >-
                      You have reached the maximum number of active browser
                      sessions.
        '502':
          description: Failed to communicate with browser service
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: Failed to execute code in browser session.
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
