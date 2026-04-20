<!-- Source: https://docs.umami.is/docs/api/api-client -->

# Umami API Client

TypeScript-built client providing functions for every available Umami API endpoint.

## Installation

```bash
npm install @umami/api-client
```

**Requirements:** Node.js 18.18 or newer

## Configuration

### Self-Hosted

```env
UMAMI_API_CLIENT_USER_ID=<uuid-of-user>
UMAMI_API_CLIENT_SECRET=<random-string-matching-APP_SECRET>
UMAMI_API_CLIENT_ENDPOINT=https://your-umami.com/api/
```

### Umami Cloud

```env
UMAMI_API_KEY=<your-api-key>
UMAMI_API_CLIENT_ENDPOINT=https://api.umami.is/
```

## Usage

```typescript
import { getClient } from '@umami/api-client';

const client = getClient();

const { ok, data, status, error } = await client.getWebsites();
```

### Response Format

```typescript
{
  ok: boolean;
  status: number;
  data?: T;
  error?: any;
}
```

## API Methods

### Me
- `getMe()` → GET /me
- `updateMyPassword(data)` → POST /me/password
- `getMyWebsites()` → GET /me/websites

### Users
- `getUsers()` / `createUser(data)` / `getUser(id)` / `updateUser(id, data)` / `deleteUser(id)`
- `getUserWebsites(id)` / `getUserUsage(id, data)`

### Teams
- `getTeams()` / `createTeam(data)` / `joinTeam(data)` / `getTeam(id)` / `updateTeam(id)` / `deleteTeam(id)`
- `getTeamUsers(id)` / `deleteTeamUser(teamId, userId)`
- `getTeamWebsites(id)` / `createTeamWebsites(id, data)` / `deleteTeamWebsite(teamId, websiteId)`

### Websites
- `getWebsites()` / `createWebsite(data)` / `getWebsite(id)` / `updateWebsite(id, data)` / `deleteWebsite(id)`
- `getWebsiteActive(id)` / `getWebsiteEvents(id, data)` / `getWebsiteMetrics(id, data)`
- `getWebsitePageviews(id, data)` / `resetWebsite(id)` / `getWebsiteStats(id, data)`

### Event Data
- `getEventDataEvents(id, data)` / `getEventDataFields(id, data)` / `getEventDataStats(id, data)`
