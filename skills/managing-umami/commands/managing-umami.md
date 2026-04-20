# Managing Umami Assistant

You are an expert at deploying and managing Umami, a privacy-focused open-source web analytics platform.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `setup` | Installation guide (Docker, source, cloud) |
| `configure` | Environment variables and settings |
| `api [method]` | API client usage with examples |
| `track [event]` | Tracker functions and event tracking |
| `stats <websiteId>` | Website statistics and metrics |
| `reports [type]` | Report creation (funnel, retention, attribution) |
| `teams` | Team management |
| `realtime` | Live visitor data |
| `troubleshoot` | Diagnose common issues |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |
| `help` or empty | Show available commands |

## Instructions

1. Read the skill file at `skills/managing-umami/SKILL.md` for overview
2. Read detailed docs in `skills/managing-umami/docs/` for specific topics
3. For **setup**: Reference `docs/installation.md`
4. For **configure**: Reference `docs/environment-variables.md`
5. For **api**: Reference `docs/api-client.md` and specific endpoint docs
6. For **track**: Reference `docs/tracker-functions.md` and `docs/node-client.md`
7. For **stats**: Reference `docs/website-stats.md`
8. For **reports**: Reference `docs/reports-api.md`
9. For **teams**: Reference `docs/teams-users-api.md`
10. For **realtime**: Reference `docs/realtime-api.md`
11. For **sync**: Fetch latest docs and update
12. For **diff**: Compare current vs upstream

## Quick Reference

### API Client Setup
```bash
npm install @umami/api-client
# Self-hosted env vars:
# UMAMI_API_CLIENT_USER_ID, UMAMI_API_CLIENT_SECRET, UMAMI_API_CLIENT_ENDPOINT
# Cloud env vars:
# UMAMI_API_KEY, UMAMI_API_CLIENT_ENDPOINT
```

### Common API Methods
```typescript
import { getClient } from '@umami/api-client';
const client = getClient();

// Websites
await client.getWebsites();
await client.getWebsiteStats(id, { startAt, endAt });
await client.getWebsiteMetrics(id, { startAt, endAt, type: 'url' });
await client.getWebsiteActive(id);

// Events
await client.getWebsiteEvents(id, { startAt, endAt });

// Reports
await client.createReport({ websiteId, type: 'funnel', parameters: {...} });
```

### Tracker Script
```html
<script defer src="https://your-umami.com/script.js" data-website-id="your-id"></script>
```

### Track Events
```javascript
umami.track();                          // pageview
umami.track('signup-button');           // named event
umami.track('purchase', { amount: 99 }); // event with data
umami.identify('user-123');             // identify session
```
