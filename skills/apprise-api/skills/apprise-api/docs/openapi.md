> Source: https://raw.githubusercontent.com/caronc/apprise-docs/master/locales/en/api/reference/openapi.md

---
title: OpenAPI Specification
description: OpenAPI (Swagger) specification for Apprise API.
sidebar:
  order: 3
---

Apprise API includes an OpenAPI 3 specification in `swagger.yaml` at the root of the repository [here](https://github.com/caronc/apprise-api/blob/master/swagger.yaml)

## Running Swagger UI

For local development or API exploration, you can bring up a standalone Swagger UI that reads the specification file without changing how the main Apprise API runs.

### Via Docker Compose

Use the provided swagger compose file in the repository:

```bash
docker compose -f docker-compose.swagger.yml up -d
```

Then browse to: `http://localhost:8001`
