> Source: https://docs.umami.is/docs/api/api-client



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Clients


# API client


Copy page


## Overview<a href="#overview" class="heading-anchor" aria-label="Permalink to “Overview”">#</a>

Umami API Client is built in TypeScript and contains functions to call every API endpoint available in Umami.

## Requirements<a href="#requirements" class="heading-anchor" aria-label="Permalink to “Requirements”">#</a>

- [Node.js](https://nodejs.org/) version 18.18 or newer

## Installation<a href="#installation" class="heading-anchor" aria-label="Permalink to “Installation”">#</a>


``` code-block
npm install @umami/api-client
```


## Configure<a href="#configure" class="heading-anchor" aria-label="Permalink to “Configure”">#</a>

The following environment variables are required to call your own API.


``` code-block
UMAMI_API_CLIENT_USER_ID
UMAMI_API_CLIENT_SECRET
UMAMI_API_CLIENT_ENDPOINT
```


To access Umami Cloud, these environment variables are required.


``` code-block
UMAMI_API_KEY
UMAMI_API_CLIENT_ENDPOINT
```


More details on accessing Umami Cloud can be found under [API key](/docs/cloud/api-key).

## Usage<a href="#usage" class="heading-anchor" aria-label="Permalink to “Usage”">#</a>

Import the configured api-client and query using the available class methods.


``` code-block
import { getClient } from '@umami/api-client';

const client = getClient();

const { ok, data, status, error } = await client.getWebsites();
```


The result will come back in the following format.


``` code-block
{
  ok: boolean;
  status: number;
  data?: T;
  error?: any;
}
```


## API Client function mapping<a href="#api-client-function-mapping" class="heading-anchor" aria-label="Permalink to “API Client function mapping”">#</a>

### Me<a href="#me" class="heading-anchor" aria-label="Permalink to “Me”">#</a>


``` code-block
getMe() ⇒ GET /me
updateMyPassword(data) ⇒ POST /me/password
getMyWebsites() ⇒ GET /me/websites
```


### Users<a href="#users" class="heading-anchor" aria-label="Permalink to “Users”">#</a>


``` code-block
getUsers() ⇒ GET /users
createUser(data) ⇒ POST /users
getUser(id) ⇒ GET /users/{id}
updateUser(id, data) ⇒ POST /users/{id}
deleteUser(id) ⇒ DEL /users/{id}
getUserWebsites(id) ⇒ GET /users/{id}/websites
getUserUsage(id, data) ⇒ GET /users/{id}/usage
```


### Teams<a href="#teams" class="heading-anchor" aria-label="Permalink to “Teams”">#</a>


``` code-block
getTeams() ⇒ GET /teams
createTeam(data) ⇒ POST /teams
joinTeam(data) ⇒ POST /teams/join
getTeam(id) ⇒ GET /teams/{id}
updateTeam(id, data) ⇒ POST /teams/{id}
deleteTeam(id) ⇒ DEL /teams/{id}
getTeamUsers(id) ⇒ GET /teams/{id}/users
deleteTeamUser(teamId, userId) ⇒ DEL /teams/{teamId}/users/{userId}
getTeamWebsites(id) ⇒ GET /teams/{id}/websites
createTeamWebsites(id, data) ⇒ POST /teams/{id}/websites
deleteTeamWebsite(teamId, websiteId) ⇒ DEL /teams/{teamId}/websites/{websiteId}
```


### Websites<a href="#websites" class="heading-anchor" aria-label="Permalink to “Websites”">#</a>


``` code-block
getWebsites() ⇒ GET /websites
createWebsite(data) ⇒ POST /websites
getWebsite(id) ⇒ GET /websites/{id}
updateWebsite(id, data) ⇒ POST /websites/{id}
deleteWebsite(id) ⇒ DEL /websites/{id}
getWebsiteActive(id) ⇒ GET /websites/{id}/active
getWebsiteEvents(id, data) ⇒ GET /websites/{id}/events
getWebsiteMetrics(id, data) ⇒ GET /websites/{id}/metrics
getWebsitePageviews(id, data) ⇒ GET /websites/{id}/pageviews
resetWebsite(id) ⇒ POST /websites/{id}/reset
getWebsiteStats(id, data) ⇒ GET /websites/{id}/stats
```


### Event Data<a href="#event-data" class="heading-anchor" aria-label="Permalink to “Event Data”">#</a>


``` code-block
getEventDataEvents(id, data) ⇒ GET /event-data/events
getEventDataFields(id, data) ⇒ GET /event-data/fields
getEventDataStats(id, data) ⇒ GET /event-data/stats
```


## Environment Variables<a href="#environment-variables" class="heading-anchor" aria-label="Permalink to “Environment Variables”">#</a>

**UMAMI_API_CLIENT_USER_ID = \<user uuid\>**

The `USER_ID` of the User performing the API calls. Permission restrictions will apply based on application settings.

**UMAMI_API_CLIENT_SECRET = \<random string\>**

A random string used to generate unique values. This needs to match the `APP_SECRET` used in the Umami application.

**UMAMI_API_CLIENT_ENDPOINT = \<API endpoint\>**

The endpoint of your Umami API. Example: `https://{yourserver}/api/`

**UMAMI_API_KEY = \<API Key string\>**

A unique string provided by Umami Cloud.


<a href="/docs/api/users" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Users</span></span></a><a href="/docs/api/node-client" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Node Client</span></span></a>


On this page


