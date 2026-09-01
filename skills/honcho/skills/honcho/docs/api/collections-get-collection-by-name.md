> Source: https://honcho.dev/docs/v1/api-reference/endpoint/collections/get-collection-by-name.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Collection By Name

> Get a Collection by Name


## OpenAPI

````yaml get /v1/apps/{app_id}/users/{user_id}/collections/name/{name}
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
  /v1/apps/{app_id}/users/{user_id}/collections/name/{name}:
    get:
      tags:
        - collections
      summary: Get Collection By Name
      description: Get a Collection by Name
      operationId: >-
        get_collection_by_name_v1_apps__app_id__users__user_id__collections_name__name__get
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
        - name: name
          in: path
          required: true
          schema:
            type: string
            description: Name of the collection to retrieve
            title: Name
          description: Name of the collection to retrieve
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Collection'
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
              const collection = await client.apps.users.collections.getByName('app_id', 'user_id', 'name');

              console.log(collection.id);
            }

            main();
        - lang: Python
          source: |-
            import os
            from honcho import Honcho

            client = Honcho(
                api_key=os.environ.get("HONCHO_API_KEY"),  # This is the default and can be omitted
            )
            collection = client.apps.users.collections.get_by_name(
                name="name",
                app_id="app_id",
                user_id="user_id",
            )
            print(collection.id)
components:
  schemas:
    Collection:
      properties:
        id:
          type: string
          title: Id
        name:
          type: string
          title: Name
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
        - name
        - user_id
        - app_id
        - created_at
      title: Collection
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
