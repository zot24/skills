> Source: https://docs.firecrawl.dev/api-reference/endpoint/agent-get.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Agent Status

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json GET /agent/{jobId}
openapi: 3.0.0
info:
  title: Firecrawl API
  version: v2
  description: >-
    API for interacting with Firecrawl services to perform web scraping and
    crawling tasks.
  contact:
    name: Firecrawl Support
    url: https://firecrawl.dev/support
    email: support@firecrawl.dev
servers:
  - url: https://api.firecrawl.dev/v2
security:
  - bearerAuth: []
paths:
  /agent/{jobId}:
    parameters:
      - name: jobId
        in: path
        description: The ID of the agent job
        required: true
        schema:
          type: string
          format: uuid
    get:
      tags:
        - Agent
      summary: Get the status of an agent job
      operationId: getAgentStatus
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                  status:
                    type: string
                    enum:
                      - processing
                      - completed
                      - failed
                  data:
                    type: object
                    description: >-
                      The extracted data (only present when status is
                      completed). Never set on a failed run, including one that
                      stopped at its credit limit.
                  partial:
                    description: >-
                      Best-effort JSON recovered from an incomplete run. Only
                      present on some failed runs, such as one that reached
                      `maxCredits`; never present while the run is processing.
                      It may be missing rows or fields, so do not treat it as a
                      completed result.
                  partialSchemaValid:
                    type: boolean
                    description: >-
                      Whether `partial` validates against the request's JSON
                      schema. Only present when `partial` is present and the
                      request included a `schema`.
                  stopReason:
                    type: string
                    enum:
                      - credit_limit_reached
                    description: >-
                      Why a failed run stopped early. `credit_limit_reached`
                      means the run hit its `maxCredits` limit. Only present
                      when status is failed.
                  message:
                    type: string
                    description: >-
                      A note from the agent about the result. In `chat` mode, a
                      follow-up that asks for no new data is answered here
                      instead of in `data`. On a failed credit-limit stop, it
                      may explain what is incomplete.
                  model:
                    type: string
                    enum:
                      - spark-2
                      - spark-1-pro
                      - spark-1-mini
                    default: spark-2
                    description: >-
                      Model preset used for the agent run. Every new run
                      executes on spark-2; Spark 1 names only appear on legacy
                      runs.
                  effort:
                    type: string
                    enum:
                      - low
                      - medium
                      - high
                    description: >-
                      Reasoning budget used for the agent run (only present for
                      runs that set effort)
                  error:
                    type: string
                    description: Error message (only present when status is failed)
                  expiresAt:
                    type: string
                    format: date-time
                  creditsUsed:
                    type: number
                  threadId:
                    type: string
                    format: uuid
                    description: The thread this run belongs to.
                  threadTurn:
                    type: integer
                    description: This run's turn in the thread, starting at 1.
                  mode:
                    type: string
                    enum:
                      - extract
                      - chat
                  suggestions:
                    type: array
                    description: >-
                      Follow-ups the agent offers for the next turn of the
                      thread.
                    items:
                      type: object
                      properties:
                        label:
                          type: string
                        prompt:
                          type: string
                  pendingApproval:
                    $ref: '#/components/schemas/AgentPendingApproval'
                  exchange:
                    $ref: '#/components/schemas/AgentExchangeSummary'
        '400':
          description: Bad request — the job ID is not a valid UUID.
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Invalid job ID format. Job ID must be a valid UUID.
        '404':
          description: Agent job not found
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Agent job not found
      security:
        - bearerAuth: []
components:
  schemas:
    AgentPendingApproval:
      type: object
      description: >-
        What the turn stopped to ask. Answer it on the next turn of the thread
        with `exchange.approve` or `exchange.decline`.
      properties:
        id:
          type: string
          description: Send this as `approvalId`.
        kind:
          type: string
          enum:
            - calls
            - terms
          description: >-
            `calls`: paid provider calls held back by `requireApproval`.
            `terms`: providers whose data terms need accepting
            (`onTermsRequired: "ask"`). Absent on items written before terms
            offers existed, which are `calls`.
        reason:
          type: string
          description: Why the agent wants to make these calls.
        calls:
          type: array
          description: The paid calls waiting for approval. Empty on a `terms` approval.
          items:
            type: object
            properties:
              id:
                type: string
                description: Pass in `exchange.approve.callIds` to approve only some calls.
              provider:
                type: string
              capability:
                type: string
              input:
                type: object
                description: The options the call would run with.
              more:
                type: array
                items:
                  type: object
                description: Further inputs the same call would run with.
              creditsEstimate:
                type: number
                nullable: true
                description: Estimated credits, or null when unknown.
        terms:
          type: array
          description: On a `terms` approval, the providers whose terms need accepting.
          items:
            type: object
            properties:
              provider:
                type: string
              name:
                type: string
              capability:
                type: string
              adds:
                type: string
                description: What the provider would add.
              version:
                type: string
                description: The terms version.
              digest:
                type: string
                nullable: true
                description: >-
                  Null when the catalog published no digest; `terms/show`
                  returns it.
              url:
                type: string
                description: Where a person accepts the terms in the dashboard.
        resolution:
          type: object
          nullable: true
          description: Null until a later turn answers the approval.
          properties:
            approved:
              type: boolean
            callIds:
              type: array
              items:
                type: string
            always:
              type: boolean
            byRunId:
              type: string
    AgentExchangeSummary:
      type: object
      description: >-
        What the run did with Alexandria. `toolkits` and `requireApproval` are
        what the run resolved to after thread inheritance.
      properties:
        enabled:
          type: boolean
        toolkits:
          type: array
          items:
            type: string
          description: >-
            Pinned providers. Empty or absent means every provider the team can
            use.
        requireApproval:
          type: boolean
        onTermsRequired:
          type: string
          enum:
            - skip
            - ask
        paidCalls:
          type: integer
          description: Paid provider calls the run made.
        creditsUsed:
          type: number
          nullable: true
          description: Credits the provider calls used, or null when unknown.
        skippedProviders:
          type: array
          description: >-
            Providers that would have helped but need data terms your team has
            not accepted. Any `onTermsRequired` mode.
          items:
            type: object
            properties:
              provider:
                type: string
              name:
                type: string
              capability:
                type: string
              adds:
                type: string
                description: What the provider would have added.
              reason:
                type: string
                enum:
                  - terms_required
              version:
                type: string
                description: The terms version.
              termsUrl:
                type: string
                description: Where a person accepts the terms in the dashboard.
        requiresAction:
          type: object
          description: >-
            `onTermsRequired: "ask"` only, when a terms offer ended the turn:
            the calls to view and accept each provider's terms. Nothing here
            runs for you, and `terms/accept` must only be called after your user
            explicitly agrees.
          properties:
            type:
              type: string
              enum:
                - accept_terms
            approvalId:
              type: string
              description: >-
                The `terms` `pendingApproval` to answer once the terms are
                accepted.
            providers:
              type: array
              items:
                type: object
                properties:
                  provider:
                    type: string
                  name:
                    type: string
                  capability:
                    type: string
                  adds:
                    type: string
                  version:
                    type: string
                  digest:
                    type: string
                    nullable: true
                    description: >-
                      Null when the catalog published no digest; `terms/show`
                      returns it.
                  url:
                    type: string
                  show:
                    type: object
                    description: >-
                      The `terms/show` call, as `{ provider, capability, options
                      }` for `/v2/scrape` `alexandria`.
                  accept:
                    type: object
                    description: >-
                      The `terms/accept` call, as `{ provider, capability,
                      options }` for `/v2/scrape` `alexandria`.
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````

This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
