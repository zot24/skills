> Source: https://docs.firecrawl.dev/api-reference/endpoint/credit-usage.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Credit Usage

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json GET /team/credit-usage
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
  /team/credit-usage:
    get:
      tags:
        - Billing
      summary: Get remaining credits for the authenticated team
      operationId: getCreditUsage
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: true
                  data:
                    type: object
                    properties:
                      remainingCredits:
                        type: number
                        description: Number of credits remaining for the team
                        example: 1000
                      planCredits:
                        type: number
                        description: >-
                          Number of credits in the plan. This does not include
                          coupon credits, credit packs, or auto recharge
                          credits.
                        example: 500000
                      billingPeriodStart:
                        type: string
                        format: date-time
                        description: >-
                          Start date of the billing period. null if using the
                          free plan
                        example: '2025-01-01T00:00:00Z'
                        nullable: true
                      billingPeriodEnd:
                        type: string
                        format: date-time
                        description: >-
                          End date of the billing period. null if using the free
                          plan
                        example: '2025-01-31T23:59:59Z'
                        nullable: true
        '404':
          description: Credit usage information not found
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
                    example: Could not find credit usage information
        '500':
          description: Server error
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
                    example: Internal server error while fetching credit usage
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
