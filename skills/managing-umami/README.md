# Managing Umami

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
/managing-umami:managing-umami setup              # Installation guide
/managing-umami:managing-umami configure           # Environment variables
/managing-umami:managing-umami api getWebsites     # API client usage
/managing-umami:managing-umami track purchase       # Event tracking
/managing-umami:managing-umami stats <websiteId>   # Website statistics
/managing-umami:managing-umami reports funnel       # Report creation
/managing-umami:managing-umami realtime            # Live visitor data
/managing-umami:managing-umami teams               # Team management
```

## Upstream Sources

- **Website**: https://umami.is
- **Documentation**: https://docs.umami.is
- **GitHub**: https://github.com/umami-software/umami
- **API Client**: https://www.npmjs.com/package/@umami/api-client
- **Node Client**: https://www.npmjs.com/package/@umami/node
