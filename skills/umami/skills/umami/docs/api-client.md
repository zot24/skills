> Source: https://docs.umami.is/docs/api/api-client



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# API client


## <a href="#overview" class="peer" data-card="">Overview</a>

Umami API Client is built in TypeScript and contains functions to call every API endpoint available in Umami.

## <a href="#requirements" class="peer" data-card="">Requirements</a>

- <a href="https://nodejs.org/" rel="noreferrer noopener" target="_blank">Node.js</a> version 18.18 or newer

## <a href="#installation" class="peer" data-card="">Installation</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>npm install @umami/api-client</code></pre>
</figure>

## <a href="#configure" class="peer" data-card="">Configure</a>

The following environment variables are required to call your own API.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>UMAMI_API_CLIENT_USER_ID
UMAMI_API_CLIENT_SECRET
UMAMI_API_CLIENT_ENDPOINT</code></pre>
</figure>

To access Umami Cloud, these environment variables are required.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>UMAMI_API_KEY
UMAMI_API_CLIENT_ENDPOINT</code></pre>
</figure>

More details on accessing Umami Cloud can be found under [API key](/docs/cloud/api-key).

## <a href="#usage" class="peer" data-card="">Usage</a>

Import the configured api-client and query using the available class methods.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>import { getClient } from &#39;@umami/api-client&#39;;

const client = getClient();

const { ok, data, status, error } = await client.getWebsites();</code></pre>
</figure>

The result will come back in the following format.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  ok: boolean;
  status: number;
  data?: T;
  error?: any;
}</code></pre>
</figure>

## <a href="#api-client-function-mapping" class="peer" data-card="">API Client function mapping</a>

### <a href="#me" class="peer" data-card="">Me</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>getMe() ⇒ GET /me
updateMyPassword(data) ⇒ POST /me/password
getMyWebsites() ⇒ GET /me/websites</code></pre>
</figure>

### <a href="#users" class="peer" data-card="">Users</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>getUsers() ⇒ GET /users
createUser(data) ⇒ POST /users
getUser(id) ⇒ GET /users/{id}
updateUser(id, data) ⇒ POST /users/{id}
deleteUser(id) ⇒ DEL /users/{id}
getUserWebsites(id) ⇒ GET /users/{id}/websites
getUserUsage(id, data) ⇒ GET /users/{id}/usage</code></pre>
</figure>

### <a href="#teams" class="peer" data-card="">Teams</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>getTeams() ⇒ GET /teams
createTeam(data) ⇒ POST /teams
joinTeam(data) ⇒ POST /teams/join
getTeam(id) ⇒ GET /teams/{id}
updateTeam(id) ⇒ POST /teams/{id}
deleteTeam(id) ⇒ DEL /teams/{id}
getTeamUsers(id) ⇒ GET /teams/{id}/users
deleteTeamUser(teamId, userId): DEL /teams/{teamId}/users/{userId}
getTeamWebsites(id) ⇒ GET /teams/{id}/websites
createTeamWebsites(id, data) ⇒ GET /teams/{id}/websites
deleteTeamWebsite(teamId, websiteId) ⇒ DEL /teams/{teamId}/websites/{websiteId}</code></pre>
</figure>

### <a href="#websites" class="peer" data-card="">Websites</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>getWebsites() ⇒ GET /websites
createWebsite(data) ⇒ POST /websites
getWebsite(id) ⇒ GET /websites/{id}
updateWebsite(id, data) ⇒ POST /websites/{id}
deleteWebsite(id) ⇒ DEL /websites/{id}
getWebsiteActive(id) ⇒ GET /websites/{id}/active
getWebsiteEvents(id, data) ⇒ GET /websites/{id}/events
getWebsiteMetrics(id, data) ⇒ GET /websites/{id}/metrics
getWebsitePageviews(id, data) ⇒ GET /websites/{id}/pageviews
resetWebsite(id) ⇒ GET /websites/{id}/reset
getWebsiteStats(id, data) ⇒ GET /websites/{id}/stats</code></pre>
</figure>

### <a href="#event-data" class="peer" data-card="">Event Data</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>getEventDataEvents(id, data) ⇒ GET /event-data/events
getEventDataFields(id, data) ⇒ GET /event-data/fields
getEventDataStats(id, data) ⇒ GET /event-data/stats</code></pre>
</figure>

## <a href="#environment-variables" class="peer" data-card="">Environment Variables</a>

**UMAMI_API_CLIENT_USER_ID = \<user uuid\>**

The `USER_ID` of the User performing the API calls. Permission restrictions will apply based on application settings.

**UMAMI_API_CLIENT_SECRET = \<random string\>**

A random string used to generate unique values. This needs to match the `APP_SECRET` used in the Umami application.

**UMAMI_API_CLIENT_ENDPOINT = \<API endpoint\>**

The endpoint of your Umami API. Example: `https://{yourserver}/api/`

**UMAMI_API_KEY = \<API Key string\>**

A unique string provided by Umami Cloud.


<a href="/docs/api/users" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Users


Previous Page

<a href="/docs/api/node-client" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Node Client


Next Page


### On this page


<a href="#overview" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Overview</a><a href="#requirements" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Requirements</a><a href="#installation" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Installation</a><a href="#configure" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Configure</a><a href="#usage" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Usage</a><a href="#api-client-function-mapping" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">API Client function mapping</a><a href="#me" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Me</a><a href="#users" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Users</a><a href="#teams" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Teams</a><a href="#websites" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Websites</a><a href="#event-data" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Event Data</a><a href="#environment-variables" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Environment Variables</a>


