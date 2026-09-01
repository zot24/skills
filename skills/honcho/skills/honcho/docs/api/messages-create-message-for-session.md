> Source: https://honcho.dev/docs/v1/api-reference/endpoint/messages/create-message-for-session.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Create Message For Session

> Adds a message to a session


## OpenAPI

````yaml post /v1/apps/{app_id}/users/{user_id}/sessions/{session_id}/messages
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
  /v1/apps/{app_id}/users/{user_id}/sessions/{session_id}/messages:
    post:
      tags:
        - messages
      summary: Create Message For Session
      description: Adds a message to a session
      operationId: >-
        create_message_for_session_v1_apps__app_id__users__user_id__sessions__session_id__messages_post
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
              $ref: '#/components/schemas/MessageCreate'
              description: Message creation parameters
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Message'
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
              const message = await client.apps.users.sessions.messages.create('app_id', 'user_id', 'session_id', {
                content: 'content',
                is_user: true,
              });

              console.log(message.id);
            }

            main();
        - lang: Python
          source: |-
            import os
            from honcho import Honcho

            client = Honcho(
                api_key=os.environ.get("HONCHO_API_KEY"),  # This is the default and can be omitted
            )
            message = client.apps.users.sessions.messages.create(
                session_id="session_id",
                app_id="app_id",
                user_id="user_id",
                content="content",
                is_user=True,
            )
            print(message.id)
components:
  schemas:
    MessageCreate:
      properties:
        content:
          type: string
          maxLength: 50000
          minLength: 0
          title: Content
        is_user:
          type: boolean
          title: Is User
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
          default: {}
      type: object
      required:
        - content
        - is_user
      title: MessageCreate
    Message:
      properties:
        id:
          type: string
          title: Id
        content:
          type: string
          title: Content
        is_user:
          type: boolean
          title: Is User
        session_id:
          type: string
          title: Session Id
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
          default: {}
        created_at:
          type: string
          format: date-time
          title: Created At
        app_id:
          type: string
          title: App Id
        user_id:
          type: string
          title: User Id
      type: object
      required:
        - id
        - content
        - is_user
        - session_id
        - created_at
        - app_id
        - user_id
      title: Message
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
