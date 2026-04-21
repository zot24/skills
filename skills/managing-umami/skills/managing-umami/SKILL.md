---
name: managing-umami
description: Deploy, configure, and manage Umami — open-source privacy-focused web analytics with API client, tracker functions, event tracking, website statistics, reports, and team management. Includes umami-cli Rust CLI tool for terminal-based management. Use when setting up web analytics, tracking pageviews, or working with Umami. Triggers on mentions of Umami, umami-cli, web analytics, pageviews, event tracking, privacy analytics, Google Analytics alternative.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Managing Umami

Expert at deploying and managing Umami, a privacy-focused open-source web analytics platform.

## Overview

- **Self-hosted analytics** — GDPR-compliant, no cookies, lightweight tracker (~2KB)
- **API Client** — `@umami/api-client` TypeScript package for all API endpoints
- **Node Client** — `@umami/node` for server-side event tracking
- **Tracker** — Client-side `umami.track()` and `umami.identify()` functions
- **Reports** — Attribution, funnel, retention, journey, revenue, and UTM analysis
- **Realtime** — Live visitor data with 30-minute rolling window

## CLI Tool (umami-cli)

A Rust CLI for managing self-hosted Umami instances from the terminal. Covers auth, websites, stats, events, sessions, reports, realtime, teams, users, admin, shares, links, and pixels.

- **GitHub**: https://github.com/zot24/umami-cli
- **Language**: Rust (requires `cargo`)

### Install globally

```bash
# From source (clone first)
cargo install --path .

# Or directly from GitHub
cargo install --git https://github.com/zot24/umami-cli.git
```

After install, `umami-cli` is available globally via `~/.cargo/bin/`.

### CLI subcommands

```
umami-cli auth       # Login, logout, verify
umami-cli websites   # Manage websites
umami-cli stats      # View website statistics
umami-cli events     # Manage and track events
umami-cli sessions   # View session data
umami-cli reports    # Run and manage reports
umami-cli realtime   # View realtime analytics
umami-cli teams      # Manage teams
umami-cli users      # User management
umami-cli admin      # Admin operations (self-hosted only)
umami-cli shares     # Manage share pages
umami-cli links      # Manage tracked links
umami-cli pixels     # Manage tracking pixels
```

## Quick Start

```bash
# Docker Compose (recommended for the Umami server)
git clone https://github.com/umami-software/umami.git
cd umami
docker-compose up -d
# Access at http://localhost:3000 (admin/umami)
```

```typescript
// API Client
import { getClient } from '@umami/api-client';
const client = getClient();
const { ok, data } = await client.getWebsites();
```

## Core Concepts

**Authentication** — Self-hosted uses `POST /api/auth/login` for bearer tokens. Cloud uses API keys. The API client handles auth via environment variables.

**Tracking** — Add `<script src="/script.js" data-website-id="...">` to pages. Use `umami.track()` for pageviews and custom events, `umami.identify()` for session data.

**API Client Config** — Set `UMAMI_API_CLIENT_USER_ID`, `UMAMI_API_CLIENT_SECRET`, and `UMAMI_API_CLIENT_ENDPOINT` for self-hosted. Set `UMAMI_API_KEY` and `UMAMI_API_CLIENT_ENDPOINT` for Cloud.

## Documentation Index

### Setup & Configuration
- **[Installation](docs/installation.md)** — Docker, source, and cloud setup
- **[Environment Variables](docs/environment-variables.md)** — Full configuration reference
- **[Authentication](docs/authentication.md)** — Login, tokens, API keys

### Client Libraries
- **[API Client](docs/api-client.md)** — `@umami/api-client` TypeScript client with all methods
- **[Node Client](docs/node-client.md)** — `@umami/node` server-side tracking

### Tracking & Events
- **[Tracker Functions](docs/tracker-functions.md)** — Client-side `umami.track()` and `umami.identify()`
- **[Event Taxonomy](docs/event-taxonomy.md)** ��� Naming conventions, categories, central registry pattern
- **[Auto-Enrichment](docs/auto-enrichment.md)** — Enhanced trackEvent with auto device/geo context
- **[Implementation Patterns](docs/implementation-patterns.md)** — Forms, CTAs, sections, funnels, privacy, Next.js
- **[Sending Stats](docs/sending-stats.md)** — Direct POST /api/send (no auth required)

### Analytics & Optimization
- **[Funnel Design](docs/funnel-design.md)** — B2C, B2B, SaaS, e-commerce, onboarding funnel templates with benchmarks
- **[Journey Analysis](docs/journey-analysis.md)** — User journey archetypes, geographic/language variations, multi-visit patterns

### API Reference
- **[Websites API](docs/websites-api.md)** — Website CRUD operations
- **[Website Statistics](docs/website-stats.md)** — Metrics, pageviews, active users
- **[Events API](docs/events-api.md)** — Event tracking and data retrieval
- **[Sessions API](docs/sessions-api.md)** — Session data and activity
- **[Reports API](docs/reports-api.md)** — Attribution, funnel, retention, journey, revenue, UTM
- **[Realtime API](docs/realtime-api.md)** — Live visitor data (30-min window)
- **[Teams & Users](docs/teams-users-api.md)** — Team, user, and me endpoints
- **[Admin API](docs/admin-api.md)** — Admin-only endpoints (self-hosted)
- **[Share API](docs/share-api.md)** — Share page management
- **[Links & Pixels](docs/links-pixels-api.md)** — URL shortening and tracking pixels

## Common Workflows

### Get website stats for last 7 days
```typescript
const client = getClient();
const now = Date.now();
const weekAgo = now - 7 * 24 * 60 * 60 * 1000;
const { data } = await client.getWebsiteStats('website-id', {
  startAt: weekAgo, endAt: now
});
```

### Track custom event from server
```typescript
import umami from '@umami/node';
umami.init({ websiteId: 'your-id', hostUrl: 'https://your-umami.com' });
umami.track({ url: '/api/checkout', name: 'purchase', data: { amount: 99 } });
```

### Create a funnel report
```typescript
const { data } = await client.createReport({
  websiteId: 'id', type: 'funnel',
  parameters: { startDate: '...', endDate: '...', urls: ['/signup', '/onboard', '/activate'] }
});
```

## Upstream Sources

- **Website**: https://umami.is
- **Documentation**: https://docs.umami.is
- **GitHub**: https://github.com/umami-software/umami
- **API Client**: https://www.npmjs.com/package/@umami/api-client
- **Node Client**: https://www.npmjs.com/package/@umami/node

## Sync & Update

When user runs `sync`: fetch latest from upstream, update docs/.
When user runs `diff`: compare current vs upstream, report changes.
