> Source: https://honcho.dev/docs/v3/api-reference/endpoint/workspaces/chat-workspace.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Workspace Chat

> Query the entire workspace using natural language. Runs the Dialectic agent over every peer in the workspace rather than a single (observer, observed) pair: there is no anchor peer and no `target`.

Pass `session_id` to narrow message tools to one session, or `scope` to restrict recall to the union of the named scopes' member sessions (always an allowlist, even for a single name; a scope with no member sessions recalls nothing). `session_id` and `scope` are mutually exclusive.

Set `stream: true` to receive the answer as a `text/event-stream` of `{"delta": {"content": ...}, "done": false}` chunks terminated by `{"done": true}`. Requires a workspace- or admin-level key.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/chat
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
  version: 3.1.2
servers:
  - url: https://api.honcho.dev
    description: Production SaaS Platform
  - url: http://localhost:8000
    description: Local Development Server
security: []
paths:
  /v3/workspaces/{workspace_id}/chat:
    post:
      tags:
        - workspaces
      summary: Workspace Chat
      description: >-
        Query the entire workspace using natural language. Runs the Dialectic
        agent over every peer in the workspace rather than a single (observer,
        observed) pair: there is no anchor peer and no `target`.


        Pass `session_id` to narrow message tools to one session, or `scope` to
        restrict recall to the union of the named scopes' member sessions
        (always an allowlist, even for a single name; a scope with no member
        sessions recalls nothing). `session_id` and `scope` are mutually
        exclusive.


        Set `stream: true` to receive the answer as a `text/event-stream` of
        `{"delta": {"content": ...}, "done": false}` chunks terminated by
        `{"done": true}`. Requires a workspace- or admin-level key.
      operationId: chat_v3_workspaces__workspace_id__chat_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/WorkspaceChatOptions'
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                properties:
                  content:
                    anyOf:
                      - type: string
                      - type: 'null'
                    title: Content
                  evidence:
                    anyOf:
                      - $ref: '#/components/schemas/Evidence'
                      - type: 'null'
                    description: >-
                      What the answer was built from. Present only when
                      `include_evidence` is true.
                required:
                  - content
                title: DialecticResponse
                type: object
            text/event-stream: {}
        '422':
          description: Validation Error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HTTPValidationError'
      security:
        - HTTPBearer: []
components:
  schemas:
    WorkspaceChatOptions:
      properties:
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
          description: Optional session to scope message tools to
        query:
          type: string
          maxLength: 10000
          minLength: 1
          title: Query
          description: Workspace chat prompt
        stream:
          type: boolean
          title: Stream
          default: false
        reasoning_level:
          type: string
          enum:
            - minimal
            - low
            - medium
            - high
            - max
          title: Reasoning Level
          description: 'Level of reasoning to apply: minimal, low, medium, high, or max'
          default: low
        response_format:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Response Format
          description: >-
            Optional JSON Schema (root type 'object') the response must conform
            to. When provided, `content` is a JSON string matching this schema.
        scope:
          anyOf:
            - type: string
            - items:
                type: string
              type: array
              maxItems: 100
              minItems: 1
            - type: 'null'
          title: Scope
          description: >-
            Optional (unprefixed) scope name(s) restricting recall to the union
            of the scopes' member sessions (explicit allowlist, fail-closed: an
            empty union recalls nothing). Mutually exclusive with `session_id`.
            Requires a workspace- or admin-level key.
        include_evidence:
          type: boolean
          title: Include Evidence
          description: >-
            When true, the response includes an `evidence` object listing the
            conclusions and messages the agent read while answering, plus the
            tool calls it made. Evidence is collated from what the agent
            accessed; the model is never asked to cite anything, so evidence may
            over-report (accessed is not the same as used).
          default: false
      type: object
      required:
        - query
      title: WorkspaceChatOptions
      description: Options for workspace-level chat (no anchor peer; see DialecticOptions).
    Evidence:
      description: >-
        What the dialectic agent read and did while answering.


        Collated from the agent's own reads rather than reported by the model,
        so

        it is deterministic but over-reports: it lists what the agent accessed,

        which is not necessarily what the answer relied on.


        Meant for auditing and analytics -- inspecting why an answer looks the
        way

        it does, or measuring what recall actually reaches the agent. It is not
        a

        read API: conclusions carry their text because that text is the thing
        being

        audited and the deriver keeps it short, while messages carry identity
        alone

        (see `EvidenceMessageRef`).
      properties:
        conclusions:
          description: >-
            Conclusions the agent read, whether prefetched or found via its
            tools
          items:
            $ref: '#/components/schemas/EvidenceObservation'
          title: Conclusions
          type: array
        messages:
          description: >-
            Messages the agent read via its search and grep tools, by ID and
            provenance only. Fetch a message to read its content.
          items:
            $ref: '#/components/schemas/EvidenceMessageRef'
          title: Messages
          type: array
        tool_calls:
          description: >-
            Tools the agent invoked, in order, with their arguments. Results are
            omitted (they are reflected in `conclusions` and `messages`), and so
            are calls that failed, so this is a record of successful invocations
            rather than a complete reasoning trace.
          items:
            $ref: '#/components/schemas/EvidenceToolCall'
          title: Tool Calls
          type: array
        reasoning_trace_id:
          anyOf:
            - type: string
            - type: 'null'
          description: >-
            ID of the stored reasoning trace for this call, when trace storage
            is enabled
          title: Reasoning Trace Id
      title: Evidence
      type: object
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    EvidenceObservation:
      description: A conclusion the dialectic agent read while answering.
      properties:
        id:
          description: Conclusion (document) ID
          title: Id
          type: string
        level:
          description: 'Conclusion level: explicit, deductive, inductive, or contradiction'
          enum:
            - explicit
            - deductive
            - inductive
            - contradiction
          title: Level
          type: string
        content:
          description: >-
            The conclusion text (the derived conclusion, for non-explicit
            levels)
          title: Content
          type: string
        created_at:
          description: When the conclusion was derived, from its source messages when known
          format: date-time
          title: Created At
          type: string
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          description: Session the conclusion is scoped to, if any
          title: Session Id
        source_ids:
          description: >-
            IDs of the conclusions this one was derived from. Empty for explicit
            conclusions, which derive from messages rather than from other
            conclusions.
          items:
            type: string
          title: Source Ids
          type: array
      required:
        - id
        - level
        - content
        - created_at
      title: EvidenceObservation
      type: object
    EvidenceMessageRef:
      description: |-
        A message the dialectic agent read while answering.

        Identity and provenance only -- no content. Message content is
        caller-supplied and unbounded, so carrying it would let one answer drag
        megabytes behind it, and would invite callers to read messages out of
        evidence in bulk rather than asking for the ones they want. Fetch the
        message by `id` when the text is needed.
      properties:
        id:
          description: Message ID
          title: Id
          type: string
        session_id:
          description: Session the message belongs to
          title: Session Id
          type: string
        peer_id:
          description: Peer who sent the message
          title: Peer Id
          type: string
        created_at:
          description: When the message was sent
          format: date-time
          title: Created At
          type: string
      required:
        - id
        - session_id
        - peer_id
        - created_at
      title: EvidenceMessageRef
      type: object
    EvidenceToolCall:
      description: A tool the dialectic agent invoked while answering.
      properties:
        tool_name:
          description: Name of the tool
          title: Tool Name
          type: string
        tool_input:
          additionalProperties: true
          description: Arguments the agent passed to the tool
          title: Tool Input
          type: object
      required:
        - tool_name
      title: EvidenceToolCall
      type: object
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
