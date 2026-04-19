<!-- Source: https://docs.immich.app/docs/api -->

# Immich API

## Overview

Immich uses the OpenAPI standard. Full API documentation is published at https://api.immich.app/.

## Authentication

All API requests require an API key passed via the `x-api-key` header:

```bash
curl -H "x-api-key: YOUR_API_KEY" http://localhost:2283/api/ENDPOINT
```

API keys are created in the web UI under user Settings > API Keys.

## Common Endpoints

```bash
# Server info
curl -H "x-api-key: $KEY" http://localhost:2283/api/server/about

# List all assets
curl -H "x-api-key: $KEY" http://localhost:2283/api/assets

# Search by metadata
curl -H "x-api-key: $KEY" http://localhost:2283/api/search/metadata \
  -H "Content-Type: application/json" \
  -d '{"originalFileName": "photo.jpg"}'

# Get asset info
curl -H "x-api-key: $KEY" http://localhost:2283/api/assets/{id}

# Upload an asset
curl -H "x-api-key: $KEY" http://localhost:2283/api/assets \
  -F "assetData=@/path/to/photo.jpg" \
  -F "deviceAssetId=unique-id" \
  -F "deviceId=CLI" \
  -F "fileCreatedAt=2024-01-01T00:00:00.000Z" \
  -F "fileModifiedAt=2024-01-01T00:00:00.000Z"

# List albums
curl -H "x-api-key: $KEY" http://localhost:2283/api/albums

# Create album
curl -H "x-api-key: $KEY" http://localhost:2283/api/albums \
  -H "Content-Type: application/json" \
  -d '{"albumName": "My Album"}'
```

## SDKs

- **TypeScript SDK**: `open-api/typescript-sdk/client`
- **Dart SDK**: `mobile/openapi`

## OpenAPI Spec

The `immich-openapi-specs.json` file is auto-generated. Developers use `@nestjs/swagger` decorators and run `make open-api` to update client SDKs.
