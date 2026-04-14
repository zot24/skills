<!-- Source: https://docs.honcho.dev/changelog/introduction -->

# Changelog

Documents all notable changes to the Honcho API and SDKs following Semantic Versioning.

## Honcho API

### v3.0.6 (Current)

**Changed:**
- Tightened transaction scopes across search, agent tools, queue manager, and webhook delivery
- Search refactored to two-phase pattern
- Queue manager transaction scope reduced to critical sections

**Fixed:**
- Session leakage in non-session-scoped dialectic chat calls

**Added:**
- Health check endpoint (`/health`)

### v3.0.5

**Fixed:** Explicit rollback on all transactions to force connection closure

### v3.0.4

**Added:** JSONB metadata validation (100 key limit, max depth 5)
**Fixed:** Soft-deleted documents leaking into representation derivation, SQL injection fix, NUL byte crashes, memory leak fix

### v3.0.3

**Added:** Consolidated session context, observation validation, peer card hard cap (40 facts), embedding pre-computation, benchmarks
**Changed:** Workspace deletion now async (202 Accepted), Redis caching uses plain-dict, FastAPI upgraded to 0.131.0
**Fixed:** JWT timestamp bug, session cache invalidation, backup provider failover

### v3.0.0

**Added:** Agentic Dreamer, Agentic Dialectic, reasoning levels, Prometheus tracking, n8n integration, Cloud Events, external vector store support
**Changed:** Observations renamed to Conclusions, API route renaming, deriver buffers representation tasks

### v2.5.0

**Added:** Message level configurations, CRUD for observations, peer level get_context, set peer card, manual dreaming trigger

### v2.4.0

**Added:** Unified Representation class, vllm client, Prometheus metrics, workspace delete, dreaming feature (WIP)

### v2.3.0

**Added:** getSummaries endpoint, Peer Card feature
**Changed:** Session peer limit based on observers, custom created_at timestamps

### v2.2.0

**Added:** Arbitrary filters, combined full-text and semantic search, webhook support, MCP server

### v2.0.0

**Major rewrite:** Peer-centric architecture, workspaces replace apps, peers replace users, batch operations, centralized configuration

### v1.0.0

**Added:** JWT authentication, configurable logging, hybrid memory architecture

## Python SDK (Current: v2.1.1)

- v2.1.0: Added created_at, is_active properties, getMessage, pagination params
- v2.0.0: Observations renamed to Conclusions, ConclusionScope, major refactoring
- v1.6.0: Metadata/configuration fields, session clone, ObservationScope

## TypeScript SDK (Current: v2.1.1)

- v2.1.0: Added createdAt, isActive properties, getMessage, pagination controls
- v2.0.0: Observations renamed to Conclusions, ConclusionScope, major refactoring
- v1.6.0: Metadata/configuration fields, session clone, ObservationScope

## Support

- GitHub Issues: https://github.com/plastic-labs/honcho/issues
- Discord: http://discord.gg/honcho
- GitHub Releases: https://github.com/plastic-labs/honcho/tags
