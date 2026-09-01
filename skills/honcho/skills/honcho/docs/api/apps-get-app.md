> Source: https://honcho.dev/docs/v1/api-reference/endpoint/apps/get-app.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get App

> Get an App by ID.

If app_id is provided as a query parameter, it uses that (must match JWT app_id).
Otherwise, it uses the app_id from the JWT.


## OpenAPI

````yaml get /v1/apps
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
  /v1/apps:
    get:
      tags:
        - apps
      summary: Get App
      description: >-
        Get an App by ID.


        If app_id is provided as a query parameter, it uses that (must match JWT
        app_id).

        Otherwise, it uses the app_id from the JWT.
      operationId: get_app_v1_apps_get
      parameters:
        - name: app_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: App ID to retrieve. If not provided, uses JWT
            title: App Id
          description: App ID to retrieve. If not provided, uses JWT
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/App'
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
              const app = await client.apps.get();

              console.log(app.id);
            }

            main();
        - lang: Python
          source: |-
            import os
            from honcho import Honcho

            client = Honcho(
                api_key=os.environ.get("HONCHO_API_KEY"),  # This is the default and can be omitted
            )
            app = client.apps.get()
            print(app.id)
components:
  schemas:
    App:
      properties:
        id:
          type: string
          title: Id
        name:
          type: string
          title: Name
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
        - name
        - created_at
      title: App
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
