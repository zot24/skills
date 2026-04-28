> Source: https://docs.umami.is/docs/api/teams



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Teams


Operations around Team management.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GET /api/teams
POST /api/teams
POST /api/teams/join
GET /api/teams/:teamId
POST /api/teams/:teamId
DELETE /api/teams/:teamId
GET /api/teams/:teamId/users
POST /api/teams/:teamId/users
GET /api/teams/:teamId/users/:userId
POST /api/teams/:teamId/users/:userId
DELETE /api/teams/:teamId/users/:userId
GET /api/teams/:teamId/websites</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiteams" class="peer" data-card="">GET /api/teams</a>

Returns all teams.

**Parameters**


| Parameter  | Type   | Description                                       |
|------------|--------|---------------------------------------------------|
| `page`     | number | (optional, default 1) Determines page.            |
| `pageSize` | number | (optional) Determines how many results to return. |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;name&quot;: &quot;Umami Software&quot;,
      &quot;accessCode&quot;: &quot;xxxxxxxxxx&quot;,
      &quot;logoUrl&quot;: null,
      &quot;createdAt&quot;: &quot;2025-01-06T23:46:38.169Z&quot;,
      &quot;updatedAt&quot;: &quot;2025-02-14T17:38:27.607Z&quot;,
      &quot;deletedAt&quot;: null,
      &quot;members&quot;: [
        {
          &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;role&quot;: &quot;team-owner&quot;,
          &quot;createdAt&quot;: &quot;2025-01-06T23:46:38.169Z&quot;,
          &quot;updatedAt&quot;: &quot;2025-01-06T23:46:38.169Z&quot;,
          &quot;user&quot;: {
            &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
            &quot;username&quot;: &quot;[email protected]&quot;
          }
        },
        {
          &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;role&quot;: &quot;team-member&quot;,
          &quot;createdAt&quot;: &quot;2025-01-06T23:46:38.169Z&quot;,
          &quot;updatedAt&quot;: &quot;2025-01-06T23:46:38.169Z&quot;,
          &quot;user&quot;: {
            &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
            &quot;username&quot;: &quot;[email protected]&quot;
          }
        }
      ],
      &quot;_count&quot;: {
        &quot;websites&quot;: 1,
        &quot;members&quot;: 2
      }
    }
  ],
  &quot;count&quot;: 1,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apiteams" class="peer" data-card="">POST /api/teams</a>

Creates a team.

**Parameters**


| Parameter | Type   | Description      |
|-----------|--------|------------------|
| `name`    | string | The team's name. |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;name&quot;: &quot;marketing&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;name&quot;: &quot;marketing&quot;,
    &quot;accessCode&quot;: &quot;team_KBmjrm5KcDZSArah&quot;,
    &quot;logoUrl&quot;: null,
    &quot;createdAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
    &quot;updatedAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
    &quot;deletedAt&quot;: null
  },
  {
    &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;role&quot;: &quot;team-owner&quot;,
    &quot;createdAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
    &quot;updatedAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apiteamsjoin" class="peer" data-card="">POST /api/teams/join</a>

Join a team.

**Parameters**


| Parameter    | Type   | Description             |
|--------------|--------|-------------------------|
| `accessCode` | string | The team's access code. |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;accessCode&quot;: &quot;xxwtoY8pzKjDIUQi&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;role&quot;: &quot;team-member&quot;,
  &quot;createdAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
  &quot;updatedAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiteamsteamid" class="peer" data-card="">GET /api/teams/:teamId</a>

Get a team.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;name&quot;: &quot;Umami Software&quot;,
  &quot;accessCode&quot;: &quot;xxxxxxxxxxx&quot;,
  &quot;logoUrl&quot;: null,
  &quot;createdAt&quot;: &quot;2024-02-17T06:27:50.130Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-02-14T17:37:50.306Z&quot;,
  &quot;deletedAt&quot;: null,
  &quot;members&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;role&quot;: &quot;team-owner&quot;,
      &quot;createdAt&quot;: &quot;2024-02-17T06:27:50.130Z&quot;,
      &quot;updatedAt&quot;: &quot;2024-02-17T06:27:50.130Z&quot;
    },
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;role&quot;: &quot;team-member&quot;,
      &quot;createdAt&quot;: &quot;2024-02-29T17:47:21.354Z&quot;,
      &quot;updatedAt&quot;: &quot;2024-02-29T17:47:21.354Z&quot;
    }
  ]
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apiteamsteamid" class="peer" data-card="">POST /api/teams/:teamId</a>

Update a team.

**Parameters**


| Parameter    | Type   | Description                        |
|--------------|--------|------------------------------------|
| `name`       | string | (optional) The team's name.        |
| `accessCode` | string | (optional) The team's access code. |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;name&quot;: &quot;Marketing&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;name&quot;: &quot;Marketing&quot;,
  &quot;accessCode&quot;: &quot;xxxxxxxxxxx&quot;,
  &quot;logoUrl&quot;: null,
  &quot;createdAt&quot;: &quot;2025-10-07T07:42:06.112Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-10-10T22:41:22.191Z&quot;,
  &quot;deletedAt&quot;: null
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#delete-apiteamsteamid" class="peer" data-card="">DELETE /api/teams/:teamId</a>

Delete a team.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;ok&quot;: true
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiteamsteamidusers" class="peer" data-card="">GET /api/teams/:teamId/users</a>

Get all users that belong to a team.

**Parameters**


| Parameter  | Type   | Description                                       |
|------------|--------|---------------------------------------------------|
| `search`   | string | (optional) Search text.                           |
| `page`     | number | (optional, default 1) Determines page.            |
| `pageSize` | number | (optional) Determines how many results to return. |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;role&quot;: &quot;team-owner&quot;,
      &quot;createdAt&quot;: &quot;2025-10-10T22:34:46.736Z&quot;,
      &quot;updatedAt&quot;: &quot;2025-10-10T22:34:46.736Z&quot;,
      &quot;user&quot;: {
        &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
        &quot;username&quot;: &quot;[email protected]&quot;
      }
    },
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;role&quot;: &quot;team-member&quot;,
      &quot;createdAt&quot;: &quot;2025-10-10T22:37:38.587Z&quot;,
      &quot;updatedAt&quot;: &quot;2025-10-10T22:37:38.587Z&quot;,
      &quot;user&quot;: {
        &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
        &quot;username&quot;: &quot;[email protected]&quot;
      }
    }
  ],
  &quot;count&quot;: 2,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apiteamsteamidusers" class="peer" data-card="">POST /api/teams/:teamId/users</a>

Add a user to a team.

**Parameters**


| Parameter | Type   | Description                                                               |
|-----------|--------|---------------------------------------------------------------------------|
| `userId`  | string | ID of user to be added.                                                   |
| `role`    | string | Team role for user (`team-member` \| `team-view-only` \| `team-manager`). |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;role&quot;: &quot;team-member&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;role&quot;: &quot;team-member&quot;,
  &quot;createdAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
  &quot;updatedAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiteamsteamidusersuserid" class="peer" data-card="">GET /api/teams/:teamId/users/:userId</a>

Get a user belonging to a team.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;role&quot;: &quot;team-owner&quot;,
  &quot;createdAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
  &quot;updatedAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apiteamsteamidusersuserid" class="peer" data-card="">POST /api/teams/:teamId/users/:userId</a>

Update a user's role on a team.

**Parameters**


| Parameter | Type   | Description                                                               |
|-----------|--------|---------------------------------------------------------------------------|
| `role`    | string | Team role for user (`team-member` \| `team-view-only` \| `team-manager`). |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;role&quot;: &quot;team-member&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;role&quot;: &quot;team-member&quot;,
  &quot;createdAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
  &quot;updatedAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#delete-apiteamsteamidusersuserid" class="peer" data-card="">DELETE /api/teams/:teamId/users/:userId</a>

Remove a user from a team.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;ok&quot;: true
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiteamsteamidwebsites" class="peer" data-card="">GET /api/teams/:teamId/websites</a>

Get all websites that belong to a team.

**Parameters**


| Parameter  | Type   | Description                                       |
|------------|--------|---------------------------------------------------|
| `search`   | string | (optional) Search text.                           |
| `page`     | number | (optional, default 1) Determines page.            |
| `pageSize` | number | (optional) Determines how many results to return. |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;name&quot;: &quot;aol&quot;,
      &quot;domain&quot;: &quot;aol.com&quot;,
      &quot;shareId&quot;: &quot;xxxxxxxxxxxx&quot;,
      &quot;resetAt&quot;: null,
      &quot;userId&quot;: null,
      &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;createdBy&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;createdAt&quot;: &quot;2020-07-19T06:53:33.482Z&quot;,
      &quot;updatedAt&quot;: &quot;2024-06-24T05:00:00.279Z&quot;,
      &quot;deletedAt&quot;: null,
      &quot;createUser&quot;: {
        &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
        &quot;username&quot;: &quot;[email protected]&quot;
      }
    }
  ],
  &quot;count&quot;: 1,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20
}</code></pre>
</figure>


<a href="/docs/api/share" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Share


Previous Page

<a href="/docs/api/users" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Users


Next Page


### On this page


<a href="#get-apiteams" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/teams</a><a href="#post-apiteams" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/teams</a><a href="#post-apiteamsjoin" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/teams/join</a><a href="#get-apiteamsteamid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/teams/:teamId</a><a href="#post-apiteamsteamid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/teams/:teamId</a><a href="#delete-apiteamsteamid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">DELETE /api/teams/:teamId</a><a href="#get-apiteamsteamidusers" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/teams/:teamId/users</a><a href="#post-apiteamsteamidusers" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/teams/:teamId/users</a><a href="#get-apiteamsteamidusersuserid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/teams/:teamId/users/:userId</a><a href="#post-apiteamsteamidusersuserid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/teams/:teamId/users/:userId</a><a href="#delete-apiteamsteamidusersuserid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">DELETE /api/teams/:teamId/users/:userId</a><a href="#get-apiteamsteamidwebsites" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/teams/:teamId/websites</a>


