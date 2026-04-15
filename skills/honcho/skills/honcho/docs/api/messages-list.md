> Source: https://docs.honcho.dev/v3/api-reference/endpoint/messages/get-messages.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Messages

> Get all messages for a Session with optional filters. Results are paginated.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/sessions/{session_id}/messages/list
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
  /v3/workspaces/{workspace_id}/sessions/{session_id}/messages/list:
    post:
      tags:
        - messages
      summary: Get Messages
      description: >-
        Get all messages for a Session with optional filters. Results are
        paginated.
      operationId: >-
        get_messages_v3_workspaces__workspace_id__sessions__session_id__messages_list_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: session_id
          in: path
          required: true
          schema:
            type: string
            title: Session Id
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
                - $ref: '#/components/schemas/MessageGet'
                - type: 'null'
              description: Filtering options for the message list
              title: Options
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Page_Message_'
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
    MessageGet:
      properties:
        filters:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Filters
      type: object
      title: MessageGet
    Page_Message_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/Message'
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
      title: Page[Message]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    Message:
      properties:
        id:
          type: string
          title: Id
        content:
          type: string
          title: Content
        peer_id:
          type: string
          title: Peer Id
        session_id:
          type: string
          title: Session Id
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
        created_at:
          type: string
          format: date-time
          title: Created At
        workspace_id:
          type: string
          title: Workspace Id
        token_count:
          type: integer
          title: Token Count
      type: object
      required:
        - id
        - content
        - peer_id
        - session_id
        - created_at
        - workspace_id
        - token_count
      title: Message
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
