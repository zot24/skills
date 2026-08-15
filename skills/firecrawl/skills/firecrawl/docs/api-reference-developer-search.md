> Source: https://docs.firecrawl.dev/api-reference/endpoint/developer-search.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Search the Developer Index

Search issues, merged pull requests, and READMEs from public code repositories, alongside curated documentation sites. Results are ranked and carry the matched passages in markdown.

`POST` is available on the same path when you want to pass array filters as JSON.

Repeatable filters accept either form on `GET`: a repeated query parameter such as `types=issue&types=pull_request`, or one comma separated value such as `types=issue,pull_request`.

## How `repos` and `sources` scope a search

The index has two halves, and these two filters scope them independently:

* `repos` scopes the repository half, meaning the `issue`, `pull_request`, and `readme` types
* `sources` scopes the documentation half, meaning the `doc` type
* Passing both combines the two halves rather than intersecting them, so you get matching results from either

Because each filter only applies to one half, a filter that cannot match any requested type is rejected rather than silently returning nothing:

* `repos` with no repository type in `types` returns `400`, reporting that `repos` cannot match any requested type and that you should add repository types or drop `repos`
* `sources` with no `doc` in `types` returns `400` with `sources cannot match any requested type; add doc or drop sources`

## How the repository filters scope a search

The seven repository filters — `language` (such as `Rust`), `topic` (such as `async`), `license` (such as `MIT`), `min_stars`, `max_stars`, `archived`, and `fork` — describe a code repository. Most documentation pages in the index come from a crawled website with no repository behind it, and no repository fact can admit or exclude such a page.

A request that sends one of these filters and no `sources` scope therefore gets no `doc` results. Its response holds repository evidence only: the `issue`, `pull_request`, and `readme` types. The `coverage` map reports `doc` as `unavailable`, because the documentation half of the index never ran. This is the design, not an index fault.

To keep documentation results, drop the repository filters. You can also scope the documentation half with `sources`, then read `coverage` to confirm that the `doc` type answered.

<CodeGroup>
  ```bash cURL
  # No API key needed to get started; add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s "https://api.firecrawl.dev/v2/search/developer?query=how%20do%20I%20configure%20retries&k=10&language=Rust&license=MIT"
  ```

  ```bash cURL (POST)
  curl -X POST https://api.firecrawl.dev/v2/search/developer \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "query": "how do I configure retries",
      "k": 10,
      "types": ["issue", "pull_request"],
      "language": "Rust",
      "license": "MIT"
    }'
  ```
</CodeGroup>

## Which values `sources` accepts

`sources` is not a fixed enum. It takes documentation source ids, each a nonempty string of at most 512 characters, and at most 20 per request. The ids reflect the documentation sites in the index, and the set grows over time.

To confirm an id resolves, pass it and read the `sources` array the response adds. It appears only when you sent `sources`, and reports each id exactly as you requested it along with whether it is indexed:

```json theme={null}
{
  "success": true,
  "results": [],
  "sources": [
    { "source": "some-docs-site", "indexed": true },
    { "source": "unknown-docs-site", "indexed": false }
  ]
}
```

`indexed: true` means the source has a published generation, so documentation evidence from it may appear. `indexed: false` means nothing from that id can match, which distinguishes an id that is not in the index from a query that simply found nothing.

`repos` echoes back the same way, as a `repos` array reporting `indexed` plus a per type breakdown under `types`:

```json theme={null}
{
  "success": true,
  "results": [],
  "repos": [
    {
      "repo": "firecrawl/firecrawl",
      "indexed": true,
      "types": { "issue": true, "pullRequest": true, "readme": true }
    }
  ]
}
```

## Reading `coverage`

`coverage` reports the outcome for each result type, one of `ok`, `degraded`, `unavailable`, or `skipped`. Check it when a result type you expected is missing:

* `skipped` means your `types` value did not ask for that type
* `degraded` or `unavailable` means the gap came from the index or from a filter, not from the query. A repository filter is one such cause, as [how the repository filters scope a search](#how-the-repository-filters-scope-a-search) describes

For a workflow overview, see the [Developer Index guide](/features/developer).


## OpenAPI

````yaml api-reference/v2-openapi.json GET /search/developer
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
  /search/developer:
    get:
      tags:
        - Developer
      summary: Search the developer index
      operationId: developerSearch
      parameters:
        - name: query
          in: query
          required: true
          description: Natural-language question or search phrase.
          schema:
            type: string
            minLength: 1
        - name: k
          in: query
          required: false
          description: Number of ranked results to return.
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 10
        - name: types
          in: query
          required: false
          description: >-
            Result kinds to search. Defaults to all four. Accepts a repeated
            parameter (`types=issue&types=pull_request`) or one comma-separated
            value (`types=issue,pull_request`).
          schema:
            type: array
            items:
              type: string
              enum:
                - doc
                - issue
                - pull_request
                - readme
        - name: repos
          in: query
          required: false
          description: >-
            Repository slugs to scope the repository half of the index to, such
            as `firecrawl/firecrawl`. Applies to the `issue`, `pull_request`,
            and `readme` types only. Sent together with `sources`, the two
            halves are combined rather than intersected, so matching results
            come back from either. Returns 400 when no repository type is in
            `types`, reporting that `repos` cannot match any requested type and
            that you should add repository types or drop `repos`.
          schema:
            type: array
            items:
              type: string
        - name: sources
          in: query
          required: false
          description: >-
            Documentation source ids to scope the documentation half to, at most
            20. Applies to the `doc` type only. Not a fixed enum: ids reflect
            the documentation sites in the index and the set grows over time, so
            confirm an id resolves by sending it and reading the `sources` array
            on the response. Returns 400 with `sources cannot match any
            requested type; add doc or drop sources` when `doc` is not in
            `types`.
          schema:
            type: array
            maxItems: 20
            items:
              type: string
              minLength: 1
              maxLength: 512
        - name: skills
          in: query
          required: false
          description: Set to `only` to limit the search to indexed agent-skill files.
          schema:
            type: string
            enum:
              - only
        - name: passages
          in: query
          required: false
          description: Matched passages to return per result.
          schema:
            type: integer
            minimum: 1
            maximum: 5
            default: 1
        - name: language
          in: query
          required: false
          description: >-
            Repository primary language, such as `Rust`. Applies to repository
            results only; sending it with no `sources` scope returns no `doc`
            results. See [how the repository filters scope a
            search](/api-reference/endpoint/developer-search#how-the-repository-filters-scope-a-search).
          schema:
            type: string
            example: Rust
        - name: topic
          in: query
          required: false
          description: >-
            Repository topic, such as `async`. Applies to repository results
            only; sending it with no `sources` scope returns no `doc` results.
          schema:
            type: string
            example: async
        - name: license
          in: query
          required: false
          description: >-
            Repository license, such as `MIT`. Applies to repository results
            only; sending it with no `sources` scope returns no `doc` results.
          schema:
            type: string
            example: MIT
        - name: min_stars
          in: query
          required: false
          description: >-
            Lower bound on repository stars. Applies to repository results only;
            sending it with no `sources` scope returns no `doc` results.
          schema:
            type: integer
            minimum: 0
        - name: max_stars
          in: query
          required: false
          description: >-
            Upper bound on repository stars. Applies to repository results only;
            sending it with no `sources` scope returns no `doc` results.
          schema:
            type: integer
            minimum: 0
        - name: archived
          in: query
          required: false
          description: >-
            Include or exclude archived repositories. Applies to repository
            results only; sending it with no `sources` scope returns no `doc`
            results.
          schema:
            type: boolean
        - name: fork
          in: query
          required: false
          description: >-
            Include or exclude forks. Applies to repository results only;
            sending it with no `sources` scope returns no `doc` results.
          schema:
            type: boolean
      responses:
        '200':
          description: Ranked developer results with matched passages.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DeveloperSearchResponse'
              example:
                success: true
                results:
                  - id: issue:firecrawl/firecrawl#1234
                    type: issue
                    url: https://github.com/firecrawl/firecrawl/issues/1234
                    title: Retries are not applied to 429 responses
                    passages:
                      - text: >-
                          The client treats 429 as a terminal status, so the
                          backoff never runs.
                coverage:
                  doc: ok
                  issue: ok
                  pull_request: ok
                  readme: ok
                reranked: true
        '400':
          description: >-
            Invalid request, including a filter that cannot match any requested
            type
        '401':
          description: Missing or invalid bearer token
        '429':
          description: Rate limit exceeded
        '500':
          description: Internal server error
      security:
        - bearerAuth: []
components:
  schemas:
    DeveloperSearchResponse:
      type: object
      properties:
        success:
          type: boolean
        results:
          type: array
          items:
            $ref: '#/components/schemas/DeveloperSearchResult'
        coverage:
          type: object
          description: >-
            Outcome for each result type. Check this when an expected result
            type is missing: `skipped` means your `types` value did not ask for
            that type, while `degraded` or `unavailable` means the gap came from
            the index or from a filter, not from the query. A repository filter
            is one such cause — see [how the repository filters scope a
            search](/api-reference/endpoint/developer-search#how-the-repository-filters-scope-a-search).
          properties:
            doc:
              type: string
              enum:
                - ok
                - degraded
                - unavailable
                - skipped
            issue:
              type: string
              enum:
                - ok
                - degraded
                - unavailable
                - skipped
            pull_request:
              type: string
              enum:
                - ok
                - degraded
                - unavailable
                - skipped
            readme:
              type: string
              enum:
                - ok
                - degraded
                - unavailable
                - skipped
        reranked:
          type: boolean
          description: Whether the ranked list went through the reranking stage.
        repos:
          type: array
          description: >-
            Present only when `repos` was sent. Echoes each slug with whether it
            is indexed, plus a per-type breakdown under `types`.
          items:
            type: object
            properties:
              repo:
                type: string
              indexed:
                type: boolean
              types:
                type: object
                description: >-
                  Which result types are indexed for this repository: `issue`,
                  `pullRequest`, and `readme`.
                properties:
                  issue:
                    type: boolean
                  pullRequest:
                    type: boolean
                  readme:
                    type: boolean
          example:
            - repo: firecrawl/firecrawl
              indexed: true
              types:
                issue: true
                pullRequest: true
                readme: true
        sources:
          type: array
          description: >-
            Present only when `sources` was sent. Reports each id exactly as
            requested along with whether it is indexed. `indexed: true` means
            the source has a published generation, so documentation evidence
            from it may appear; `indexed: false` means nothing from that id can
            match, which distinguishes an id that is not in the index from a
            query that simply found nothing.
          items:
            type: object
            properties:
              source:
                type: string
              indexed:
                type: boolean
          example:
            - source: some-docs-site
              indexed: true
            - source: unknown-docs-site
              indexed: false
    DeveloperSearchResult:
      type: object
      properties:
        id:
          type: string
          description: Stable result id, such as `issue:owner/repo#123`.
          example: issue:firecrawl/firecrawl#1234
        type:
          type: string
          enum:
            - doc
            - issue
            - pull_request
            - readme
          description: Result kind.
        url:
          type: string
          format: uri
        title:
          type: string
          description: >-
            Frequently absent on `doc` results, where the source page carries no
            usable title. Fall back to `url`.
        passages:
          type: array
          description: Matched passages in markdown, so tables and code blocks survive.
          items:
            type: object
            properties:
              text:
                type: string
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
