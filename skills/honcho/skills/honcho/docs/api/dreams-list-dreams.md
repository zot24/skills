> Source: https://honcho.dev/docs/v3/api-reference/endpoint/dreams/list-dreams.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# List Dreams

> List dream runs, newest first. Results are paginated.

Each run records what one dream changed in a representation. Filter by
`observed_id` for a peer's history, and add `observer_id` for a single
representation. Runs are not pruned unless the server sets a retention
window.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/dreams/list
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
  /v3/workspaces/{workspace_id}/dreams/list:
    post:
      tags:
        - dreams
      summary: List Dreams
      description: |-
        List dream runs, newest first. Results are paginated.

        Each run records what one dream changed in a representation. Filter by
        `observed_id` for a peer's history, and add `observer_id` for a single
        representation. Runs are not pruned unless the server sets a retention
        window.
      operationId: list_dreams_v3_workspaces__workspace_id__dreams_list_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: page
          in: query
          required: false
          schema:
            type: integer
            maximum: 2147483647
            minimum: 1
            description: Page number (offset mode)
            default: 1
            title: Page
          description: Page number (offset mode)
        - name: size
          in: query
          required: false
          schema:
            type: integer
            maximum: 100
            minimum: 1
            description: Page size
            default: 50
            title: Size
          description: Page size
        - name: cursor
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: >-
              Opt in to cursor pagination. Send an empty value for the first
              page, then the `next_page` value from each response. When set,
              `page` is ignored and the response is a cursor page with no
              `total`.
            title: Cursor
          description: >-
            Opt in to cursor pagination. Send an empty value for the first page,
            then the `next_page` value from each response. When set, `page` is
            ignored and the response is a cursor page with no `total`.
      requestBody:
        content:
          application/json:
            schema:
              anyOf:
                - $ref: '#/components/schemas/DreamRunList'
                - type: 'null'
              description: Filtering options for the dream run list
              title: Options
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                anyOf:
                  - $ref: '#/components/schemas/Page_DreamRun_'
                  - $ref: '#/components/schemas/CursorPage_DreamRun_'
                title: >-
                  Response List Dreams V3 Workspaces  Workspace Id  Dreams List
                  Post
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
    DreamRunList:
      properties:
        observed_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Observed Id
          description: Only runs about this peer
        observer_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Observer Id
          description: >-
            Only runs from this observer's perspective. Combine with
            `observed_id` for one representation.
      type: object
      title: DreamRunList
      description: Filters for listing dream runs.
    Page_DreamRun_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/DreamRun'
          type: array
          title: Items
        total:
          type: integer
          minimum: 0
          title: Total
          description: >-
            Number of matching rows, exact up to the server's
            PAGINATION_COUNT_LIMIT (default 100000) and reported as that limit
            plus one when there are more. While a next page exists it is at
            least one more than this page's last row, so `pages` always reaches
            the end of the list.
        page:
          type: integer
          minimum: 1
          title: Page
        size:
          type: integer
          minimum: 1
          title: Size
        pages:
          type: integer
          minimum: 0
          title: Pages
      type: object
      required:
        - items
        - total
        - page
        - size
        - pages
      title: Page[DreamRun]
    CursorPage_DreamRun_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/DreamRun'
          type: array
          title: Items
        total:
          anyOf:
            - type: integer
            - type: 'null'
          title: Total
        current_page:
          anyOf:
            - type: string
            - type: 'null'
          title: Current Page
          description: Cursor to refetch the current page
        current_page_backwards:
          anyOf:
            - type: string
            - type: 'null'
          title: Current Page Backwards
          description: Cursor to refetch the current page starting from the last item
        previous_page:
          anyOf:
            - type: string
            - type: 'null'
          title: Previous Page
          description: Cursor for the previous page
        next_page:
          anyOf:
            - type: string
            - type: 'null'
          title: Next Page
          description: Cursor for the next page
      type: object
      required:
        - items
      title: CursorPage[DreamRun]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    DreamRun:
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
      title: DreamRun
      description: >-
        One dream over a representation: the observer's model of the observed
        peer.
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

This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
