> Source: https://docs.firecrawl.dev/api-reference/endpoint/agent.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Agent

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json POST /agent
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
  /agent:
    post:
      tags:
        - Agent
      summary: Start an agent task for agentic data extraction
      operationId: startAgent
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                urls:
                  type: array
                  items:
                    type: string
                    format: uri
                  description: Optional list of URLs to constrain the agent to
                prompt:
                  type: string
                  description: The prompt describing what data to extract
                  maxLength: 10000
                schema:
                  type: object
                  description: Optional JSON schema to structure the extracted data
                maxCredits:
                  type: number
                  description: >-
                    Maximum credits to spend on this agent task. Defaults to
                    2500 if not set. Values above 2,500 are always billed as
                    paid requests.
                strictConstrainToURLs:
                  type: boolean
                  description: >-
                    If true, agent will only visit URLs provided in the urls
                    array
                model:
                  type: string
                  enum:
                    - spark-2
                    - spark-1-mini
                    - spark-1-pro
                  default: spark-2
                  description: >-
                    The model to use for the agent task. spark-2 is the default
                    and the model every run executes on. The Spark 1 model names
                    remain accepted for backwards compatibility but are
                    deprecated and route to spark-2.
                effort:
                  type: string
                  enum:
                    - low
                    - medium
                    - high
                  description: >-
                    Reasoning budget for the agent task. Every run executes on
                    spark-2, so effort can be sent with or without model.
                webhook:
                  type: object
                  description: >-
                    A webhook specification object. Subscribes to agent
                    lifecycle events (agent.started, agent.action,
                    agent.completed, agent.failed, agent.cancelled).
                  properties:
                    url:
                      type: string
                      format: uri
                      description: The URL to send webhook events to.
                    headers:
                      type: object
                      description: Headers to send to the webhook URL.
                      additionalProperties:
                        type: string
                    metadata:
                      type: object
                      description: >-
                        Custom metadata that will be included in all webhook
                        payloads for this agent job.
                      additionalProperties:
                        type: string
                    events:
                      type: array
                      description: >-
                        The events to send to the webhook URL. Defaults to all
                        events.
                      items:
                        type: string
                        enum:
                          - started
                          - action
                          - completed
                          - failed
                          - cancelled
                      default:
                        - started
                        - action
                        - completed
                        - failed
                        - cancelled
                  required:
                    - url
                auditMetadata:
                  $ref: '#/components/schemas/AuditMetadata'
                threatProtection:
                  $ref: '#/components/schemas/ThreatProtectionOverride'
              required:
                - prompt
      responses:
        '200':
          description: Agent task started successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                  id:
                    type: string
                    format: uuid
        '400':
          description: >-
            Bad request — the request body failed validation (for example an
            invalid JSON schema).
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: 'Invalid JSON schema: ...'
        '402':
          description: Payment required
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Payment required to access this resource.
        '403':
          description: >-
            Forbidden — a provided URL is blocked by the team's threat
            protection policy.
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: >-
                      This URL (https://example.com) is blocked by your
                      organization's threat protection policy (rule: blocklist).
                      If you believe this is a mistake, contact your
                      organization administrator to adjust the policy (e.g.
                      whitelist the domain).
        '429':
          description: Too many requests
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Rate limit exceeded.
        '500':
          description: Internal server error — the agent service could not be reached.
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Failed to passthrough agent request.
      security:
        - bearerAuth: []
components:
  schemas:
    AuditMetadata:
      type: object
      description: >-
        User attribution included with SIEM logging events when SIEM Logging is
        enabled for the organization.
      additionalProperties: false
      required:
        - username
      properties:
        username:
          type: string
          maxLength: 1024
          description: The username associated with the request.
    ThreatProtectionOverride:
      type: object
      title: Threat Protection Override
      description: >-
        Per-request [Threat
        Protection](https://docs.firecrawl.dev/features/threat-protection)
        override. Fields you provide replace the corresponding fields of your
        organization's policy for this request only; omitted fields keep their
        organization-level values. Requires Threat Protection to be enabled for
        your team (enterprise feature) — otherwise the request is rejected with
        a 403. If your organization has disabled request overrides, any request
        that includes this object is rejected with a 403. If Threat Protection
        is enforced for your team, `mode` may not be set to `off`.
      properties:
        mode:
          type: string
          enum:
            - 'off'
            - normal
          description: >-
            URL scanning mode for this request. `normal` checks URLs against
            Google Web Risk (+2 credits per URL scanned).
        riskScoreThreshold:
          type: integer
          minimum: 0
          maximum: 100
          description: >-
            Normalized risk score (0–100) at or above which a classifier verdict
            blocks the URL. Lower is stricter.
          example: 75
        blacklist:
          type: array
          maxItems: 1000
          items:
            type: string
          description: >-
            Domains to always block, as plain domains (`example.com`) or
            wildcard globs (`*.example.com`). No protocol, path, or port.
        whitelist:
          type: array
          maxItems: 1000
          items:
            type: string
          description: >-
            Domains to always allow, as plain domains or wildcard globs. Wins
            over every other rule.
        blockedTlds:
          type: array
          maxItems: 1000
          items:
            type: string
          description: >-
            Top-level domains to block outright, lowercase without the leading
            dot (e.g. `zip`).
        failurePolicy:
          type: string
          enum:
            - open
            - closed
          description: >-
            What to do when the classifier can't be reached: `closed` blocks the
            request, `open` allows it.
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
