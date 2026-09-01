> Source: https://honcho.dev/docs/v1/api-reference/endpoint/keys/create-key.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Create Key

> Create a new Key


## OpenAPI

````yaml post /v1/keys
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
  /v1/keys:
    post:
      tags:
        - keys
      summary: Create Key
      description: Create a new Key
      operationId: create_key_v1_keys_post
      parameters:
        - name: app_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: ID of the app to scope the key to
            title: App Id
          description: ID of the app to scope the key to
        - name: user_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: ID of the user to scope the key to
            title: User Id
          description: ID of the user to scope the key to
        - name: session_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: ID of the session to scope the key to
            title: Session Id
          description: ID of the session to scope the key to
        - name: collection_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: ID of the collection to scope the key to
            title: Collection Id
          description: ID of the collection to scope the key to
        - name: expires_at
          in: query
          required: false
          schema:
            anyOf:
              - type: string
                format: date-time
              - type: 'null'
            title: Expires At
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema: {}
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
              const key = await client.keys.create();

              console.log(key);
            }

            main();
        - lang: Python
          source: |-
            import os
            from honcho import Honcho

            client = Honcho(
                api_key=os.environ.get("HONCHO_API_KEY"),  # This is the default and can be omitted
            )
            key = client.keys.create()
            print(key)
components:
  schemas:
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
