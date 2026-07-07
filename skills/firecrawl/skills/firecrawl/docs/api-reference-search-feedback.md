> Source: https://docs.firecrawl.dev/api-reference/endpoint/search-feedback.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Search Feedback

> Submit quality feedback for a search job and help improve Firecrawl search results.

Use search feedback after a `search` result is used or fails to help. Feedback improves result quality and can refund 1 credit for the first feedback submission on a search job, subject to team limits.

### Example Request

```bash theme={null}
curl -X POST "https://api.firecrawl.dev/v2/search/550e8400-e29b-41d4-a716-446655440000/feedback" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "rating": "good",
    "valuableSources": [
      {
        "url": "https://docs.firecrawl.dev/features/search",
        "reason": "Most up-to-date description of /search."
      }
    ],
    "missingContent": [
      {
        "topic": "Pricing for the search endpoint",
        "description": "No pricing tier table for /search specifically."
      }
    ],
    "querySuggestions": "Boost docs.firecrawl.dev for queries that mention Firecrawl"
  }'
```


## OpenAPI

````yaml api-reference/v2-openapi.json POST /search/{jobId}/feedback
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
  /search/{jobId}/feedback:
    post:
      tags:
        - Search
        - Feedback
      summary: Submit feedback for a search job
      operationId: submitSearchFeedback
      parameters:
        - name: jobId
          in: path
          required: true
          schema:
            type: string
            format: uuid
          description: Search job id returned by /search.
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SearchFeedbackRequest'
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
          description: Search not found for this team
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/FeedbackErrorResponse'
        '409':
          description: Feedback cannot be recorded for this search
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
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
