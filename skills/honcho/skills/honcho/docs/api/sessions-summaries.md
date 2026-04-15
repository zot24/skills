> Source: https://docs.honcho.dev/v3/api-reference/endpoint/sessions/get-session-summaries.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Session Summaries

> Get available summaries for a Session.

Returns both short and long summaries if available, including metadata like
the message ID they cover up to, creation timestamp, and token count.


## OpenAPI

````yaml get /v3/workspaces/{workspace_id}/sessions/{session_id}/summaries
openapi: 3.1.0
info:
  title: Honcho API
  summary: The Identity Layer for the Agentic World
  description: >-
    Honcho is a platform for giving agents user-centric memory and social
    cognition.
  contact:
    name: Plastic Labs
    url: https://honcho.dev/
    email: hello@plasticlabs.ai
  license:
    name: GNU Affero General Public License v3.0
    url: https://github.com/plastic-labs/honcho/blob/main/LICENSE
  version: 3.0.3
servers:
  - url: https://api.honcho.dev
    description: Production SaaS Platform
  - url: http://localhost:8000
    description: Local Development Server
security: []
paths:
  /v3/workspaces/{workspace_id}/sessions/{session_id}/summaries:
    get:
      tags:
        - sessions
      summary: Get Session Summaries
      description: >-
        Get available summaries for a Session.


        Returns both short and long summaries if available, including metadata
        like

        the message ID they cover up to, creation timestamp, and token count.
      operationId: >-
        get_session_summaries_v3_workspaces__workspace_id__sessions__session_id__summaries_get
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: session_id
          in: path
          required: true
          schema:
            type: string
            title: Session Id
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SessionSummaries'
        '422':
          description: Validation Error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HTTPValidationError'
      security:
        - HTTPBearer: []
        - {}
components:
  schemas:
    SessionSummaries:
      properties:
        id:
          type: string
          title: Id
        short_summary:
          anyOf:
            - $ref: '#/components/schemas/Summary'
            - type: 'null'
          description: The short summary if available
        long_summary:
          anyOf:
            - $ref: '#/components/schemas/Summary'
            - type: 'null'
          description: The long summary if available
      type: object
      required:
        - id
      title: SessionSummaries
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    Summary:
      properties:
        content:
          type: string
          title: Content
          description: The summary text
        message_id:
          type: string
          title: Message Id
          description: The public ID of the message that this summary covers up to
        summary_type:
          type: string
          title: Summary Type
          description: The type of summary (short or long)
        created_at:
          type: string
          title: Created At
          description: The timestamp of when the summary was created (ISO format)
        token_count:
          type: integer
          title: Token Count
          description: The number of tokens in the summary text
      type: object
      required:
        - content
        - message_id
        - summary_type
        - created_at
        - token_count
      title: Summary
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
        input:
          title: Input
        ctx:
          type: object
          title: Context
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
