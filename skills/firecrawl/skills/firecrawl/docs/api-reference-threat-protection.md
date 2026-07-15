> Source: https://docs.firecrawl.dev/api-reference/endpoint/threat-protection.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Threat Protection Policy

Returns the effective [threat protection](/features/threat-protection) policy for your organization. Enterprise feature; requires the feature to be enabled for your team.


## OpenAPI

````yaml api-reference/v2-openapi.json GET /team/threat-protection
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
  /team/threat-protection:
    get:
      tags:
        - Threat Protection
      summary: Get the team's threat protection policy
      operationId: getThreatProtection
      responses:
        '200':
          description: Effective threat protection policy for the team's organization.
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: true
                  data:
                    type: object
                    properties:
                      mode:
                        type: string
                        enum:
                          - 'off'
                          - normal
                        description: >-
                          Threat protection mode. `off` disables checks;
                          `normal` checks URLs against Google Web Risk (+2
                          credits per URL scanned).
                        example: normal
                      riskScoreThreshold:
                        type: integer
                        minimum: 0
                        maximum: 100
                        description: >-
                          Normalized score (0-100) at or above which a
                          classifier verdict is blocked. Lower is stricter.
                        example: 75
                      blacklist:
                        type: array
                        items:
                          type: string
                        description: >-
                          Exact domains or globs (e.g. `*.example.com`) always
                          blocked, without a classifier call.
                        example:
                          - '*.risky.example'
                      whitelist:
                        type: array
                        items:
                          type: string
                        description: >-
                          Exact domains or globs always allowed. Wins over every
                          other rule.
                        example:
                          - '*.trusted.example'
                      blockedTlds:
                        type: array
                        items:
                          type: string
                        description: >-
                          Top-level domains to block outright, lowercase without
                          a leading dot.
                        example:
                          - zip
                      failurePolicy:
                        type: string
                        enum:
                          - open
                          - closed
                        description: >-
                          Behavior when the classifier is unreachable: `closed`
                          blocks (default), `open` allows.
                        example: closed
                      allowRequestOverrides:
                        type: boolean
                        description: >-
                          Whether individual requests may pass a
                          `threatProtection` object. When false, such requests
                          are rejected with 403.
                        example: true
                      configured:
                        type: boolean
                        description: >-
                          Whether the organization has saved a policy (vs.
                          serving defaults).
                        example: true
                      updatedAt:
                        type: string
                        format: date-time
                        nullable: true
        '403':
          description: >-
            Threat protection is not enabled for this team, or a request
            override was sent while overrides are disabled.
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
