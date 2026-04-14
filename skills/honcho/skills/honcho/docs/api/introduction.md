<!-- Source: https://docs.honcho.dev/v3/api-reference/introduction -->

# API Reference Introduction

## Overview

This documentation covers all available API endpoints in the Honcho Server with CRUD operations for core primitives. See the Architecture documentation for more details on these primitives.

## Important Recommendation

We strongly recommend using the official SDKs instead of calling these APIs directly. The SDKs provide superior error handling, type safety, and overall developer experience.

**Recommended SDKs:**
- Python SDK (available on PyPI): `pip install honcho-ai`
- TypeScript SDK (available on npm): `npm install @honcho-ai/sdk`

## When to Reference This API

The API reference proves most helpful for:
- Debugging SDK functionality
- Creating integrations in unsupported programming languages
- Exploring the underlying data structure design

## Base URLs

- Production: `https://api.honcho.dev`
- Local Development: `http://localhost:8000`
