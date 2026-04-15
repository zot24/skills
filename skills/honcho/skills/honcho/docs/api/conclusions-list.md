> Source: https://docs.honcho.dev/v3/api-reference/endpoint/conclusions/list-conclusions.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# List Conclusions

> List Conclusions using optional filters, ordered by recency unless `reverse` is true. Results are paginated.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/conclusions/list
openapi: 3.1.0
info:
  title: Honcho API
  summary: The Identity Layer for the Agentic World
  description: >-
    Honcho is a platform for giving agents user-centric memory and social
    cognition.
  contact:
    name: Plastic Labs
    url: https://honcho.dev/
    email: hello@plasticlabs.ai
  license:
    name: GNU Affero General Public License v3.0
    url: https://github.com/plastic-labs/honcho/blob/main/LICENSE
  version: 3.0.3
servers:
  - url: https://api.honcho.dev
    description: Production SaaS Platform
  - url: http://localhost:8000
    description: Local Development Server
security: []
paths:
  /v3/workspaces/{workspace_id}/conclusions/list:
    post:
      tags:
        - conclusions
      summary: List Conclusions
      description: >-
        List Conclusions using optional filters, ordered by recency unless
        `reverse` is true. Results are paginated.
      operationId: list_conclusions_v3_workspaces__workspace_id__conclusions_list_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: reverse
          in: query
          required: false
          schema:
            anyOf:
              - type: boolean
              - type: 'null'
            description: Whether to reverse the order of results
            default: false
            title: Reverse
          description: Whether to reverse the order of results
        - name: page
          in: query
          required: false
          schema:
            type: integer
            minimum: 1
            description: Page number
            default: 1
            title: Page
          description: Page number
        - name: size
          in: query
          required: false
          schema:
            type: integer
            maximum: 100
            minimum: 1
            description: Page size
            default: 50
            title: Size
          description: Page size
      requestBody:
        content:
          application/json:
            schema:
              anyOf:
                - $ref: '#/components/schemas/ConclusionGet'
                - type: 'null'
              description: Filtering options for the Conclusions list
              title: Options
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Page_Conclusion_'
        '422':
          description: Validation Error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HTTPValidationError'
      security:
        - HTTPBearer: []
        - {}
components:
  schemas:
    ConclusionGet:
      properties:
        filters:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Filters
      type: object
      title: ConclusionGet
      description: Schema for listing conclusions with optional filters.
    Page_Conclusion_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/Conclusion'
          type: array
          title: Items
        total:
          type: integer
          minimum: 0
          title: Total
        page:
          type: integer
          minimum: 1
          title: Page
        size:
          type: integer
          minimum: 1
          title: Size
        pages:
          type: integer
          minimum: 0
          title: Pages
      type: object
      required:
        - items
        - total
        - page
        - size
        - pages
      title: Page[Conclusion]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    Conclusion:
      properties:
        id:
          type: string
          title: Id
        content:
          type: string
          title: Content
        observer_id:
          type: string
          title: Observer Id
          description: The peer who made the conclusion
        observed_id:
          type: string
          title: Observed Id
          description: The peer the conclusion is about
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
        created_at:
          type: string
          format: date-time
          title: Created At
      type: object
      required:
        - id
        - content
        - observer_id
        - observed_id
        - created_at
      title: Conclusion
      description: Conclusion response - external view of a document.
    ValidationError:
      properties:
        loc:
          items:
            anyOf:
              - type: string
              - type: integer
          type: array
          title: Location
        msg:
          type: string
          title: Message
        type:
          type: string
          title: Error Type
        input:
          title: Input
        ctx:
          type: object
          title: Context
      type: object
      required:
        - loc
        - msg
        - type
      title: ValidationError
  securitySchemes:
    HTTPBearer:
      type: http
      scheme: bearer

````
