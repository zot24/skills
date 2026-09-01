> Source: https://honcho.dev/docs/v1/api-reference/endpoint/apps/update-app.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Update App

> Update an App


## OpenAPI

````yaml put /v1/apps/{app_id}
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
  /v1/apps/{app_id}:
    put:
      tags:
        - apps
      summary: Update App
      description: Update an App
      operationId: update_app_v1_apps__app_id__put
      parameters:
        - name: app_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the app to update
            title: App Id
          description: ID of the app to update
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/AppUpdate'
              description: Updated app parameters
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
              const app = await client.apps.update('app_id');

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
            app = client.apps.update(
                app_id="app_id",
            )
            print(app.id)
components:
  schemas:
    AppUpdate:
      properties:
        name:
          anyOf:
            - type: string
            - type: 'null'
          title: Name
        metadata:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Metadata
      type: object
      title: AppUpdate
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
