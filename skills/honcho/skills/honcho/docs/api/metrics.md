> Source: https://honcho.dev/docs/v2/api-reference/endpoint/metrics.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Metrics

> Prometheus metrics endpoint


## OpenAPI

````yaml get /metrics
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
  version: 2.5.1
servers:
  - url: http://localhost:8000
    description: Local Development Server
  - url: https://demo.honcho.dev
    description: Demo Server
  - url: https://api.honcho.dev
    description: Production SaaS Platform
security: []
paths:
  /metrics:
    get:
      summary: Metrics
      description: Prometheus metrics endpoint
      operationId: metrics_metrics_get
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema: {}

````
