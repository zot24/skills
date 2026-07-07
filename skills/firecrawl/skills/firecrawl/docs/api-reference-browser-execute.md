> Source: https://docs.firecrawl.dev/api-reference/endpoint/browser-execute.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Execute Code in a Session

> Run Playwright or agent-browser code in a standalone Interact session.

## Headers

| Header          | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <API_KEY>` |
| `Content-Type`  | `application/json` |

## Request Body

| Parameter  | Type   | Required | Default  | Description                                                                              |
| ---------- | ------ | -------- | -------- | ---------------------------------------------------------------------------------------- |
| `code`     | string | Yes      | -        | Code to execute (1-100,000 characters)                                                   |
| `language` | string | No       | `"node"` | Language of the code: `"python"`, `"node"`, or `"bash"` (for agent-browser CLI commands) |
| `timeout`  | number | No       | -        | Execution timeout in seconds (1-300)                                                     |

## Response

| Field      | Type    | Description                                                 |
| ---------- | ------- | ----------------------------------------------------------- |
| `success`  | boolean | Whether the code executed successfully                      |
| `stdout`   | string  | Standard output from the code execution                     |
| `result`   | string  | Standard output from the code execution                     |
| `stderr`   | string  | Standard error output from the code execution               |
| `exitCode` | number  | Exit code of the executed process                           |
| `killed`   | boolean | Whether the process was killed due to timeout               |
| `error`    | string  | Error message if execution failed (only present on failure) |

### Example Request

```bash theme={null}
curl -X POST "https://api.firecrawl.dev/v2/interact/550e8400-e29b-41d4-a716-446655440000/execute" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "code": "await page.goto(\"https://example.com\")\ntitle = await page.title()\nprint(title)",
    "language": "python"
  }'
```

### Example Response (Success)

```json theme={null}
{
  "success": true,
  "result": "Example Domain"
}
```

### Example Response (Error)

```json theme={null}
{
  "success": true,
  "error": "TimeoutError: page.goto: Timeout 30000ms exceeded."
}
```

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json POST /interact/{sessionId}/execute
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
  /interact/{sessionId}/execute:
    post:
      tags:
        - Interact
      summary: Execute code in an interact session
      operationId: executeBrowserCode
      parameters:
        - name: sessionId
          in: path
          required: true
          schema:
            type: string
          description: The interact session ID
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
                  description: Code to execute in the browser sandbox
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
                  description: Execution timeout in seconds
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
        '402':
          description: Payment required
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Payment required to access this resource.
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
