> Source: https://honcho.dev/docs/v1/api-reference/endpoint/sessions/get-sessions.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Sessions

> Get All Sessions for a User


## OpenAPI

````yaml post /v1/apps/{app_id}/users/{user_id}/sessions/list
openapi: 3.1.0
info:
  title: Honcho API
  summary: The Identity Layer for the Agentic World
  description: >-
    Honcho is a platform for giving agents user-centric memory and social
    cognition
  contact:
    name: Plastic Labs
    url: https://honcho.dev/
    email: hello@plasticlabs.ai
  version: 1.1.0
servers:
  - url: http://localhost:8000
    description: Local Development Server
  - url: https://demo.honcho.dev
    description: Demo Server
  - url: https://api.honcho.dev
    description: Production SaaS Platform
security: []
paths:
  /v1/apps/{app_id}/users/{user_id}/sessions/list:
    post:
      tags:
        - sessions
      summary: Get Sessions
      description: Get All Sessions for a User
      operationId: get_sessions_v1_apps__app_id__users__user_id__sessions_list_post
      parameters:
        - name: app_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the app
            title: App Id
          description: ID of the app
        - name: user_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the user
            title: User Id
          description: ID of the user
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
                - $ref: '#/components/schemas/SessionGet'
                - type: 'null'
              description: Filtering and pagination options for the sessions list
              title: Options
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Page_Session_'
        '422':
          description: Validation Error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HTTPValidationError'
      security:
        - HTTPBearer: []
        - {}
      x-codeSamples:
        - lang: JavaScript
          source: |-
            import Honcho from 'honcho-ai';

            const client = new Honcho({
              apiKey: process.env['HONCHO_API_KEY'], // This is the default and can be omitted
            });

            async function main() {
              // Automatically fetches more pages as needed.
              for await (const session of client.apps.users.sessions.list('app_id', 'user_id')) {
                console.log(session.id);
              }
            }

            main();
        - lang: Python
          source: |-
            import os
            from honcho import Honcho

            client = Honcho(
                api_key=os.environ.get("HONCHO_API_KEY"),  # This is the default and can be omitted
            )
            page = client.apps.users.sessions.list(
                user_id="user_id",
                app_id="app_id",
            )
            page = page.items[0]
            print(page.id)
components:
  schemas:
    SessionGet:
      properties:
        filter:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Filter
        is_active:
          type: boolean
          title: Is Active
          default: false
      type: object
      title: SessionGet
    Page_Session_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/Session'
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
      title: Page[Session]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    Session:
      properties:
        id:
          type: string
          title: Id
        is_active:
          type: boolean
          title: Is Active
        user_id:
          type: string
          title: User Id
        app_id:
          type: string
          title: App Id
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
          default: {}
        created_at:
          type: string
          format: date-time
          title: Created At
      type: object
      required:
        - id
        - is_active
        - user_id
        - app_id
        - created_at
      title: Session
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
