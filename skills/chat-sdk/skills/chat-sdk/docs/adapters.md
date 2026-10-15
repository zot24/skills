> Source: https://chat-sdk.dev/docs/adapters.md

---
title: Overview
description: Overview of Chat SDK adapters, adapter tiers, and where to find platform, state, and catalog guides.
docs_index: /llms.txt
lastUpdated: 2026-10-14
type: overview
prerequisites:
  - /docs/getting-started
---

> For an index of all documentation, see [/llms.txt](/llms.txt).

Adapters connect Chat SDK to messaging platforms and state backends. Install only the adapters you need, then register them on your `Chat` instance.

## Adapter tiers

| Tier            | Who maintains it           |
| --------------- | -------------------------- |
| Official        | Vercel (`@chat-adapter/*`) |
| Vendor-official | The platform vendor        |
| Community       | Third-party developers     |

Browse all three tiers on the [Adapters](/adapters) listing page. To ship your own, start with [Building an adapter](/docs/contributing/building), then list it as a [community](/docs/contributing/publishing#listing-on-chat-sdkdev) or [vendor-official](/docs/contributing/vendor-official) adapter.

These guides cover the details:

- [Adapter Catalog](/docs/adapter-catalog) covers `@chat-adapter/catalog`, a static package that lists every adapter with its capabilities and setup requirements, for websites, setup screens, and build scripts.
- [Platform Adapters](/docs/platform-adapters) covers webhook verification, message parsing, feature support by platform, and bots that run on several platforms.
- [State Adapters](/docs/state-adapters) covers subscriptions, distributed locking, and caching.

---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
