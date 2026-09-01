> Source: https://honcho.dev/docs/v1/api-reference/endpoint/sessions/chat.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Chat

> Chat with the Dialectic API


## OpenAPI

````yaml post /v1/apps/{app_id}/users/{user_id}/sessions/{session_id}/chat
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
  /v1/apps/{app_id}/users/{user_id}/sessions/{session_id}/chat:
    post:
      tags:
        - sessions
      summary: Chat
      description: Chat with the Dialectic API
      operationId: chat_v1_apps__app_id__users__user_id__sessions__session_id__chat_post
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
        - name: session_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the session
            title: Session Id
          description: ID of the session
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/DialecticOptions'
              description: Dialectic Endpoint Parameters
      responses:
        '200':
          description: Response to a question informed by Honcho's User Representation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DialecticResponse'
            text/event-stream: {}
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
              const dialecticResponse = await client.apps.users.sessions.chat('app_id', 'user_id', 'session_id', {
                queries: 'string',
              });

              console.log(dialecticResponse.content);
            }

            main();
        - lang: Python
          source: |-
            import os
            from honcho import Honcho

            client = Honcho(
                api_key=os.environ.get("HONCHO_API_KEY"),  # This is the default and can be omitted
            )
            dialectic_response = client.apps.users.sessions.chat(
                session_id="session_id",
                app_id="app_id",
                user_id="user_id",
                queries="string",
            )
            print(dialectic_response.content)
components:
  schemas:
    DialecticOptions:
      properties:
        queries:
          anyOf:
            - type: string
            - items:
                type: string
              type: array
          title: Queries
        stream:
          type: boolean
          title: Stream
          default: false
      type: object
      required:
        - queries
      title: DialecticOptions
    DialecticResponse:
      properties:
        content:
          type: string
          title: Content
      type: object
      required:
        - content
      title: DialecticResponse
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
