> Source: https://docs.firecrawl.dev/api-reference/endpoint/feedback.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Endpoint Feedback

> Submit feedback for a completed v2 endpoint job.

Use endpoint feedback to tell Firecrawl whether a completed job result was useful, partial, or bad. This is for endpoint-level output quality on jobs such as `scrape`, `parse`, `map`, and `search`.

The generic feedback schema can carry search-style fields too, but [Search Feedback](/api-reference/endpoint/search-feedback) is the preferred search-specific entry point because it is scoped to a search job ID and highlights valuable sources, missing content, query suggestions, and refund behavior.

### Example Request

```bash theme={null}
curl -X POST "https://api.firecrawl.dev/v2/feedback" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "endpoint": "scrape",
    "jobId": "550e8400-e29b-41d4-a716-446655440000",
    "rating": "partial",
    "issues": ["missing_markdown"],
    "note": "The pricing table was missing from the markdown output.",
    "url": "https://example.com/pricing"
  }'
```


## OpenAPI

````yaml api-reference/v2-openapi.json POST /feedback
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
  /feedback:
    post:
      tags:
        - Feedback
      summary: Submit feedback for a v2 job
      operationId: submitEndpointFeedback
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/EndpointFeedbackRequest'
      responses:
        '200':
          description: Feedback recorded
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/FeedbackResponse'
        '400':
          description: Invalid request body
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/FeedbackErrorResponse'
        '403':
          description: Feedback is not available for this team
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/FeedbackErrorResponse'
        '404':
          description: Job not found for this team
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/FeedbackErrorResponse'
        '409':
          description: Feedback cannot be recorded for this job
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/FeedbackErrorResponse'
        '500':
          description: Server error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/FeedbackErrorResponse'
      security:
        - bearerAuth: []
components:
  schemas:
    EndpointFeedbackRequest:
      allOf:
        - $ref: '#/components/schemas/SearchFeedbackRequest'
        - type: object
          description: >-
            Submit feedback for a v2 job. Include at least one substantive
            signal such as issues, note, valuableSources, missingContent,
            querySuggestions, url, or pageNumbers.
          properties:
            endpoint:
              type: string
              enum:
                - search
                - scrape
                - parse
                - map
            jobId:
              type: string
              format: uuid
            issues:
              type: array
              maxItems: 20
              items:
                type: string
                pattern: ^[a-z0-9][a-z0-9_-]*$
                maxLength: 80
            tags:
              type: array
              maxItems: 20
              items:
                type: string
                pattern: ^[a-z0-9][a-z0-9_-]*$
                maxLength: 80
            note:
              type: string
              maxLength: 4000
            url:
              type: string
              format: uri
            pageNumbers:
              type: array
              maxItems: 100
              items:
                type: integer
                minimum: 1
            metadata:
              type: object
              additionalProperties: true
              description: >-
                Small endpoint-specific metadata object. Must be 8KB or smaller;
                do not include full endpoint results.
            missingContent:
              type: array
              maxItems: 50
              items:
                type: object
                properties:
                  topic:
                    type: string
                    maxLength: 200
                    minLength: 1
                  description:
                    type: string
                    maxLength: 2000
                required:
                  - topic
          required:
            - endpoint
            - jobId
    FeedbackResponse:
      type: object
      properties:
        success:
          type: boolean
          example: true
        feedbackId:
          type: string
          format: uuid
        creditsRefunded:
          type: number
        alreadySubmitted:
          type: boolean
        dailyCapReached:
          type: boolean
        creditsRefundedToday:
          type: number
        dailyRefundCap:
          type: number
        warning:
          type: string
      required:
        - success
        - feedbackId
        - creditsRefunded
    FeedbackErrorResponse:
      type: object
      properties:
        success:
          type: boolean
          example: false
        error:
          type: string
        feedbackErrorCode:
          type: string
        details:
          type: array
          items:
            type: object
      required:
        - success
        - error
    SearchFeedbackRequest:
      type: object
      description: >-
        For 'good', include valuableSources. For 'partial', include
        valuableSources or missingContent. For 'bad', include missingContent or
        querySuggestions.
      properties:
        rating:
          type: string
          enum:
            - good
            - partial
            - bad
        valuableSources:
          type: array
          maxItems: 50
          items:
            type: object
            properties:
              url:
                type: string
                format: uri
              reason:
                type: string
                maxLength: 1000
            required:
              - url
        missingContent:
          type: array
          maxItems: 20
          items:
            type: object
            properties:
              topic:
                type: string
                maxLength: 200
                minLength: 1
              description:
                type: string
                maxLength: 2000
            required:
              - topic
        querySuggestions:
          type: string
          maxLength: 2000
        origin:
          type: string
          default: api
        integration:
          type: string
          nullable: true
      required:
        - rating
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
