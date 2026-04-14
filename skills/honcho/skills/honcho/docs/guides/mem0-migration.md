<!-- Source: https://docs.honcho.dev/v3/guides/migrations/mem0 -->

# Mem0 to Honcho Migration

## Overview

Honcho distinguishes itself from Mem0 by reasoning about stored data rather than simply storing it.

## Key Differentiators

- **Reasoning capability**: Honcho reasons about stored data, not just retrieves it
- **Compounding insights**: Extracts insights that build progressively with interactions
- **Performance**: Superior retrieval accuracy with faster inference times
- **Pricing model**: Charges for ingestion only, not data access
- **Multi-peer functionality**: Advanced session configuration and peer-to-peer representation queries

## Migration Paths

### Quick Migration

Import existing Mem0 memories as "conclusions" in Honcho. Batch create conclusions (up to 100 at a time):

1. Export memories from Mem0 using its API
2. Initialize a Honcho client with an API key
3. Batch create conclusions

### Comprehensive Migration

Import raw messages to preserve conversational context, enabling Honcho to build more accurate user profiles and generate session summaries.

## API Comparison

- Identity management: `user_id` parameters become `peer` objects
- Message addition: Becomes session-scoped and triggers reasoning
- Search: Expands to include semantic peer queries

## Honcho Exclusive Features (No Mem0 Equivalent)

- `peer.chat()` for reasoning-based queries
- Biographical profiles via `peer.get_card()`
- Cached psychological analysis through `session.representation()`
- Automated session summaries
- Configurable observation settings for privacy control

New Honcho accounts receive $100 in credits to begin testing.
