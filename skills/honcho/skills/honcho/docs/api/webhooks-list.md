> Source: https://honcho.dev/docs/v3/api-reference/endpoint/webhooks/list-webhook-endpoints.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# List Webhook Endpoints

> List all webhook endpoints, optionally filtered by workspace.


## OpenAPI

````yaml get /v3/workspaces/{workspace_id}/webhooks
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
  version: 3.3.0
servers:
  - url: https://api.honcho.dev
    description: Production SaaS Platform
security: []
paths:
  /v3/workspaces/{workspace_id}/webhooks:
    get:
      tags:
        - webhooks
      summary: List Webhook Endpoints
      description: List all webhook endpoints, optionally filtered by workspace.
      operationId: list_webhook_endpoints_v3_workspaces__workspace_id__webhooks_get
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: Workspace ID
            title: Workspace Id
          description: Workspace ID
        - name: page
          in: query
          required: false
          schema:
            type: integer
            minimum: 1
            description: Page number (offset mode)
            default: 1
            title: Page
          description: Page number (offset mode)
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
        - name: cursor
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: >-
              Opt in to cursor pagination. Send an empty value for the first
              page, then the `next_page` value from each response. When set,
              `page` is ignored and the response is a cursor page with no
              `total`.
            title: Cursor
          description: >-
            Opt in to cursor pagination. Send an empty value for the first page,
            then the `next_page` value from each response. When set, `page` is
            ignored and the response is a cursor page with no `total`.
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                anyOf:
                  - $ref: '#/components/schemas/Page_WebhookEndpoint_'
                  - $ref: '#/components/schemas/CursorPage_WebhookEndpoint_'
                title: >-
                  Response List Webhook Endpoints V3 Workspaces  Workspace Id 
                  Webhooks Get
        '422':
          description: Validation Error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HTTPValidationError'
      security:
        - HTTPBearer: []
components:
  schemas:
    Page_WebhookEndpoint_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/WebhookEndpoint'
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
      title: Page[WebhookEndpoint]
    CursorPage_WebhookEndpoint_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/WebhookEndpoint'
          type: array
          title: Items
        total:
          anyOf:
            - type: integer
            - type: 'null'
          title: Total
        current_page:
          anyOf:
            - type: string
            - type: 'null'
          title: Current Page
          description: Cursor to refetch the current page
        current_page_backwards:
          anyOf:
            - type: string
            - type: 'null'
          title: Current Page Backwards
          description: Cursor to refetch the current page starting from the last item
        previous_page:
          anyOf:
            - type: string
            - type: 'null'
          title: Previous Page
          description: Cursor for the previous page
        next_page:
          anyOf:
            - type: string
            - type: 'null'
          title: Next Page
          description: Cursor for the next page
      type: object
      required:
        - items
      title: CursorPage[WebhookEndpoint]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    WebhookEndpoint:
      properties:
        id:
          type: string
          title: Id
        workspace_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Workspace Id
        url:
          type: string
          title: Url
        created_at:
          type: string
          format: date-time
          title: Created At
      type: object
      required:
        - id
        - workspace_id
        - url
        - created_at
      title: WebhookEndpoint
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

This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
