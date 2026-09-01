> Source: https://honcho.dev/docs/v1/api-reference/endpoint/metamessages/get-metamessages.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Metamessages

> Get metamessages with flexible filtering.

- Filter by user only: No additional parameters needed
- Filter by session: Provide session_id
- Filter by message: Provide message_id (and session_id)
- Filter by type: Provide label
- Filter by metadata: Provide filter object


## OpenAPI

````yaml post /v1/apps/{app_id}/users/{user_id}/metamessages/list
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
  /v1/apps/{app_id}/users/{user_id}/metamessages/list:
    post:
      tags:
        - metamessages
      summary: Get Metamessages
      description: |-
        Get metamessages with flexible filtering.

        - Filter by user only: No additional parameters needed
        - Filter by session: Provide session_id
        - Filter by message: Provide message_id (and session_id)
        - Filter by type: Provide label
        - Filter by metadata: Provide filter object
      operationId: get_metamessages_v1_apps__app_id__users__user_id__metamessages_list_post
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
                - $ref: '#/components/schemas/MetamessageGet'
                - type: 'null'
              description: Filtering options for the metamessages list
              title: Options
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Page_Metamessage_'
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
              for await (const metamessage of client.apps.users.metamessages.list('app_id', 'user_id')) {
                console.log(metamessage.id);
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
            page = client.apps.users.metamessages.list(
                user_id="user_id",
                app_id="app_id",
            )
            page = page.items[0]
            print(page.id)
components:
  schemas:
    MetamessageGet:
      properties:
        metamessage_type:
          anyOf:
            - type: string
            - type: 'null'
          title: Metamessage Type
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
        message_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Message Id
        filter:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Filter
      type: object
      title: MetamessageGet
    Page_Metamessage_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/Metamessage'
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
      title: Page[Metamessage]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    Metamessage:
      properties:
        id:
          type: string
          title: Id
        label:
          type: string
          title: Label
        content:
          type: string
          title: Content
        user_id:
          type: string
          title: User Id
        app_id:
          type: string
          title: App Id
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
        message_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Message Id
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
          default: {}
        created_at:
          type: string
          format: date-time
          title: Created At
        metamessage_type:
          type: string
          title: Metamessage Type
          readOnly: true
      type: object
      required:
        - id
        - label
        - content
        - user_id
        - app_id
        - session_id
        - message_id
        - created_at
        - metamessage_type
      title: Metamessage
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
