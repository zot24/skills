> Source: https://docs.umami.is/docs/api/api-client



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Clients


# API client


Copy page


Call the Umami API from TypeScript or JavaScript with the @umami/api-client package, on a self-hosted instance or Umami Cloud.


## Overview<a href="#overview" class="heading-anchor" aria-label="Permalink to “Overview”">#</a>

The Umami API client is built in TypeScript and contains functions to call every API endpoint available in Umami.

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


## API client function mapping<a href="#api-client-function-mapping" class="heading-anchor" aria-label="Permalink to “API client function mapping”">#</a>

### Me<a href="#me" class="heading-anchor" aria-label="Permalink to “Me”">#</a>


``` code-block
getMe() ⇒ GET /me
updateMyPassword(data) ⇒ POST /me/password
getMyWebsites(params) ⇒ GET /me/websites
```


### Users<a href="#users" class="heading-anchor" aria-label="Permalink to “Users”">#</a>


``` code-block
createUser(data) ⇒ POST /users
getUser(userId) ⇒ GET /users/{userId}
updateUser(userId, data) ⇒ POST /users/{userId}
deleteUser(userId) ⇒ DELETE /users/{userId}
getUserWebsites(userId, params) ⇒ GET /users/{userId}/websites
```


### Teams<a href="#teams" class="heading-anchor" aria-label="Permalink to “Teams”">#</a>


``` code-block
getTeams(params) ⇒ GET /teams
createTeam(data) ⇒ POST /teams
joinTeam(data) ⇒ POST /teams/join
getTeam(teamId) ⇒ GET /teams/{teamId}
updateTeam(teamId, data) ⇒ POST /teams/{teamId}
deleteTeam(teamId) ⇒ DELETE /teams/{teamId}
getTeamUsers(teamId, params) ⇒ GET /teams/{teamId}/users
deleteTeamUser(teamId, userId) ⇒ DELETE /teams/{teamId}/users/{userId}
getTeamWebsites(teamId, params) ⇒ GET /teams/{teamId}/websites
```


### Websites<a href="#websites" class="heading-anchor" aria-label="Permalink to “Websites”">#</a>


``` code-block
getWebsites(params) ⇒ GET /websites
createWebsite(data) ⇒ POST /websites
getWebsite(websiteId) ⇒ GET /websites/{websiteId}
updateWebsite(websiteId, data) ⇒ POST /websites/{websiteId}
deleteWebsite(websiteId) ⇒ DELETE /websites/{websiteId}
getWebsiteActive(websiteId) ⇒ GET /websites/{websiteId}/active
getWebsiteEvents(websiteId, params) ⇒ GET /websites/{websiteId}/events
getWebsiteMetrics(websiteId, params) ⇒ GET /websites/{websiteId}/metrics
getWebsitePageviews(websiteId, params) ⇒ GET /websites/{websiteId}/pageviews
resetWebsite(websiteId) ⇒ POST /websites/{websiteId}/reset
getWebsiteStats(websiteId, params) ⇒ GET /websites/{websiteId}/stats
```


### Event data<a href="#event-data" class="heading-anchor" aria-label="Permalink to “Event data”">#</a>


``` code-block
getEventDataEvents(websiteId, params) ⇒ GET /websites/{websiteId}/event-data/events
getEventDataFields(websiteId, params) ⇒ GET /websites/{websiteId}/event-data/fields
getEventDataStats(websiteId, params) ⇒ GET /websites/{websiteId}/event-data/stats
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


<a href="/docs/api-reference/get-website-values" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">List website filter values</span></span></a><a href="/docs/api/node-client" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Node Client</span></span></a>


On this page


