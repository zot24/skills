> Source: https://honcho.dev/docs/v3/api-reference/endpoint/dreams/get-dream.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Dream

> Get one dream run with every change it committed.

The response lists the conclusions the dream created with the conclusions
each was derived from, the conclusions it removed as they read when
removed, and the peer card before and after.


## OpenAPI

````yaml get /v3/workspaces/{workspace_id}/dreams/{run_id}
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
  version: 3.6.1
servers:
  - url: https://api.honcho.dev
    description: Production SaaS Platform
security: []
paths:
  /v3/workspaces/{workspace_id}/dreams/{run_id}:
    get:
      tags:
        - dreams
      summary: Get Dream
      description: >-
        Get one dream run with every change it committed.


        The response lists the conclusions the dream created with the
        conclusions

        each was derived from, the conclusions it removed as they read when

        removed, and the peer card before and after.
      operationId: get_dream_v3_workspaces__workspace_id__dreams__run_id__get
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: run_id
          in: path
          required: true
          schema:
            type: string
            description: The dream's run ID
            title: Run Id
          description: The dream's run ID
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DreamRunDetail'
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
    DreamRunDetail:
      properties:
        id:
          type: string
          title: Id
          description: The dream's run ID
        observer_id:
          type: string
          title: Observer Id
          description: The peer whose representation the dream changed
        observed_id:
          type: string
          title: Observed Id
          description: The peer the representation is about
        dream_type:
          anyOf:
            - type: string
            - type: 'null'
          title: Dream Type
          description: >-
            The kind of dream, e.g. `omni` (deduction and induction) or a card
            refresh
        trigger_reason:
          anyOf:
            - type: string
            - type: 'null'
          title: Trigger Reason
          description: What scheduled the dream, e.g. `document_threshold` or `manual`
        status:
          type: string
          enum:
            - running
            - completed
            - failed
            - interrupted
          title: Status
          description: >-
            `failed` and `interrupted` runs can still have changes: each change
            is committed as it is made.
        created_count:
          type: integer
          title: Created Count
          description: Conclusions the dream created
        removed_count:
          type: integer
          title: Removed Count
          description: Conclusions the dream removed
        peer_card_updated:
          type: boolean
          title: Peer Card Updated
          description: Whether the dream changed the peer card
        started_at:
          type: string
          format: date-time
          title: Started At
        finished_at:
          anyOf:
            - type: string
              format: date-time
            - type: 'null'
          title: Finished At
        pruned_at:
          anyOf:
            - type: string
              format: date-time
            - type: 'null'
          title: Pruned At
          description: >-
            When retention first deleted some of this run's changes. Null unless
            a retention window (`DREAM_HISTORY_RETENTION_DAYS`, unset by
            default) pruned the run, which can predate the current setting. Past
            the window a run keeps only the created conclusions that still
            exist; `removed` and `peer_card` are gone. The counts stay as the
            dream recorded them.
        created:
          items:
            $ref: '#/components/schemas/DreamCreatedConclusion'
          type: array
          title: Created
        removed:
          items:
            $ref: '#/components/schemas/DreamRemovedConclusion'
          type: array
          title: Removed
        peer_card:
          anyOf:
            - $ref: '#/components/schemas/DreamPeerCardChange'
            - type: 'null'
      type: object
      required:
        - id
        - observer_id
        - observed_id
        - status
        - created_count
        - removed_count
        - peer_card_updated
        - started_at
        - created
        - removed
      title: DreamRunDetail
      description: A dream run with every change it committed.
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    DreamCreatedConclusion:
      properties:
        conclusion:
          $ref: '#/components/schemas/DreamConclusionRef'
        sources:
          items:
            $ref: '#/components/schemas/DreamConclusionRef'
          type: array
          title: Sources
          description: >-
            Premises for deductive conclusions, supporting evidence for
            inductive ones
        specialist:
          anyOf:
            - type: string
            - type: 'null'
          title: Specialist
          description: The dream specialist that made the change
      type: object
      required:
        - conclusion
        - sources
      title: DreamCreatedConclusion
      description: A conclusion a dream created, with the conclusions it was derived from.
    DreamRemovedConclusion:
      properties:
        id:
          type: string
          title: Id
        content:
          type: string
          title: Content
        level:
          anyOf:
            - type: string
              enum:
                - explicit
                - deductive
                - inductive
                - contradiction
            - type: 'null'
          title: Level
        replaced_by:
          anyOf:
            - type: string
            - type: 'null'
          title: Replaced By
          description: >-
            Set when a new conclusion from the same dream superseded this one as
            a near-duplicate
        specialist:
          anyOf:
            - type: string
            - type: 'null'
          title: Specialist
      type: object
      required:
        - id
        - content
      title: DreamRemovedConclusion
      description: A conclusion a dream removed, as it read when it was removed.
    DreamPeerCardChange:
      properties:
        before:
          anyOf:
            - items:
                type: string
              type: array
            - type: 'null'
          title: Before
          description: Null when there was no card
        after:
          items:
            type: string
          type: array
          title: After
      type: object
      required:
        - before
        - after
      title: DreamPeerCardChange
      description: The peer card before the dream's first update and after its last.
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
    DreamConclusionRef:
      properties:
        id:
          type: string
          title: Id
        content:
          anyOf:
            - type: string
            - type: 'null'
          title: Content
          description: Null when the conclusion is `unavailable`
        level:
          anyOf:
            - type: string
              enum:
                - explicit
                - deductive
                - inductive
                - contradiction
            - type: 'null'
          title: Level
        status:
          type: string
          enum:
            - current
            - removed
            - unavailable
          title: Status
          description: >-
            `current`: still in the representation. `removed`: a later dream
            removed it; `removed_in_run` names that dream. `unavailable`: it was
            deleted (through the API, with its session, or by the deriver), or
            the dream that removed it is past the server's retention window.
        removed_in_run:
          anyOf:
            - type: string
            - type: 'null'
          title: Removed In Run
      type: object
      required:
        - id
        - status
      title: DreamConclusionRef
      description: A conclusion referenced by a dream, resolved when the run is read.
  securitySchemes:
    HTTPBearer:
      type: http
      scheme: bearer

````

This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
