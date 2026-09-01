> Source: https://honcho.dev/docs/v1/api-reference/endpoint/metamessages/get-metamessage.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Metamessage

> Get a specific Metamessage by ID


## OpenAPI

````yaml get /v1/apps/{app_id}/users/{user_id}/metamessages/{metamessage_id}
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
  /v1/apps/{app_id}/users/{user_id}/metamessages/{metamessage_id}:
    get:
      tags:
        - metamessages
      summary: Get Metamessage
      description: Get a specific Metamessage by ID
      operationId: >-
        get_metamessage_v1_apps__app_id__users__user_id__metamessages__metamessage_id__get
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
        - name: metamessage_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the metamessage to retrieve
            title: Metamessage Id
          description: ID of the metamessage to retrieve
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Metamessage'
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
              const metamessage = await client.apps.users.metamessages.get('app_id', 'user_id', 'metamessage_id');

              console.log(metamessage.id);
            }

            main();
        - lang: Python
          source: |-
            import os
            from honcho import Honcho

            client = Honcho(
                api_key=os.environ.get("HONCHO_API_KEY"),  # This is the default and can be omitted
            )
            metamessage = client.apps.users.metamessages.get(
                metamessage_id="metamessage_id",
                app_id="app_id",
                user_id="user_id",
            )
            print(metamessage.id)
components:
  schemas:
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
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
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
