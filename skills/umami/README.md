# Umami

Expert skill for deploying and managing [Umami](https://umami.is), a privacy-focused open-source web analytics platform.

## Features

- **Installation** — Docker Compose, source, and Umami Cloud setup
- **API Client** — `@umami/api-client` TypeScript package for all endpoints
- **Node Client** — `@umami/node` for server-side event tracking
- **Tracker Functions** — Client-side pageview and event tracking
- **Website Statistics** — Metrics, pageviews, active users, realtime data
- **Reports** — Attribution, funnel, retention, journey, revenue, UTM analysis
- **Team Management** — Multi-user team and website organization
- **Configuration** — Environment variables and deployment options

## Commands

```bash
/umami:umami setup              # Installation guide
/umami:umami configure           # Environment variables
/umami:umami api getWebsites     # API client usage
/umami:umami track purchase       # Event tracking
/umami:umami stats <websiteId>   # Website statistics
/umami:umami reports funnel       # Report creation
/umami:umami realtime            # Live visitor data
/umami:umami teams               # Team management
```

## Upstream Sources

- **Website**: https://umami.is
- **Documentation**: https://docs.umami.is
- **GitHub**: https://github.com/umami-software/umami
- **API Client**: https://www.npmjs.com/package/@umami/api-client
- **Node Client**: https://www.npmjs.com/package/@umami/node
