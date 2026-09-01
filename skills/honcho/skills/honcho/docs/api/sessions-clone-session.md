> Source: https://honcho.dev/docs/v1/api-reference/endpoint/sessions/clone-session.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Clone Session

> Clone a session, optionally up to a specific message


## OpenAPI

````yaml get /v1/apps/{app_id}/users/{user_id}/sessions/{session_id}/clone
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
  /v1/apps/{app_id}/users/{user_id}/sessions/{session_id}/clone:
    get:
      tags:
        - sessions
      summary: Clone Session
      description: Clone a session, optionally up to a specific message
      operationId: >-
        clone_session_v1_apps__app_id__users__user_id__sessions__session_id__clone_get
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
            description: ID of the session to clone
            title: Session Id
          description: ID of the session to clone
        - name: message_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: Message ID to cut off the clone at
            title: Message Id
          description: Message ID to cut off the clone at
        - name: deep_copy
          in: query
          required: false
          schema:
            type: boolean
            description: Whether to deep copy metamessages
            default: false
            title: Deep Copy
          description: Whether to deep copy metamessages
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Session'
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
              const session = await client.apps.users.sessions.clone('app_id', 'user_id', 'session_id');

              console.log(session.id);
            }

            main();
        - lang: Python
          source: |-
            import os
            from honcho import Honcho

            client = Honcho(
                api_key=os.environ.get("HONCHO_API_KEY"),  # This is the default and can be omitted
            )
            session = client.apps.users.sessions.clone(
                session_id="session_id",
                app_id="app_id",
                user_id="user_id",
            )
            print(session.id)
components:
  schemas:
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
