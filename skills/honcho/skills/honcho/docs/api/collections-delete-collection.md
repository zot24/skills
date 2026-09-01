> Source: https://honcho.dev/docs/v1/api-reference/endpoint/collections/delete-collection.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Delete Collection

> Delete a Collection and its documents


## OpenAPI

````yaml delete /v1/apps/{app_id}/users/{user_id}/collections/{collection_id}
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
  /v1/apps/{app_id}/users/{user_id}/collections/{collection_id}:
    delete:
      tags:
        - collections
      summary: Delete Collection
      description: Delete a Collection and its documents
      operationId: >-
        delete_collection_v1_apps__app_id__users__user_id__collections__collection_id__delete
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
        - name: collection_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the collection to delete
            title: Collection Id
          description: ID of the collection to delete
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
              const collection = await client.apps.users.collections.delete('app_id', 'user_id', 'collection_id');

              console.log(collection);
            }

            main();
        - lang: Python
          source: |-
            import os
            from honcho import Honcho

            client = Honcho(
                api_key=os.environ.get("HONCHO_API_KEY"),  # This is the default and can be omitted
            )
            collection = client.apps.users.collections.delete(
                collection_id="collection_id",
                app_id="app_id",
                user_id="user_id",
            )
            print(collection)
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
