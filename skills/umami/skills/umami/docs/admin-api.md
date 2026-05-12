> Source: https://docs.umami.is/docs/api/admin



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Admin


Operations around admin management.

These endpoints are only available for self-hosted instances for **admin** users and not **Umami Cloud**.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GET /api/admin/users
GET /api/admin/websites
GET /api/admin/teams</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiadminusers" class="peer" data-card="">GET /api/admin/users</a>

Returns all users.

**Parameters**


| Parameter  | Type   | Description                                                   |
|------------|--------|---------------------------------------------------------------|
| `search`   | string | (optional) Search text.                                       |
| `page`     | number | (optional, default 1) Determines page.                        |
| `pageSize` | number | (optional, default 20) Determines how many results to return. |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;username&quot;: &quot;member&quot;,
      &quot;role&quot;: &quot;user&quot;,
      &quot;logoUrl&quot;: null,
      &quot;displayName&quot;: null,
      &quot;createdAt&quot;: &quot;2025-10-10T23:09:16.524Z&quot;,
      &quot;updatedAt&quot;: &quot;2025-10-10T23:09:16.524Z&quot;,
      &quot;deletedAt&quot;: null,
      &quot;_count&quot;: {
        &quot;websites&quot;: 0
      }
    },
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;username&quot;: &quot;admin&quot;,
      &quot;role&quot;: &quot;admin&quot;,
      &quot;logoUrl&quot;: null,
      &quot;displayName&quot;: null,
      &quot;createdAt&quot;: &quot;2025-09-15T17:47:16.421Z&quot;,
      &quot;updatedAt&quot;: null,
      &quot;deletedAt&quot;: null,
      &quot;_count&quot;: {
        &quot;websites&quot;: 1
      }
    }
  ],
  &quot;count&quot;: 2,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20,
  &quot;orderBy&quot;: &quot;createdAt&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiadminwebsites" class="peer" data-card="">GET /api/admin/websites</a>

Returns all websites.

**Parameters**


| Parameter  | Type   | Description                                                   |
|------------|--------|---------------------------------------------------------------|
| `search`   | string | (optional) Search text.                                       |
| `page`     | number | (optional, default 1) Determines page.                        |
| `pageSize` | number | (optional, default 20) Determines how many results to return. |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;name&quot;: &quot;My Website&quot;,
      &quot;domain&quot;: &quot;mywebsite.com&quot;,
      &quot;shareId&quot;: null,
      &quot;resetAt&quot;: null,
      &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;teamId&quot;: null,
      &quot;createdBy&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;createdAt&quot;: &quot;2025-09-16T19:59:32.957Z&quot;,
      &quot;updatedAt&quot;: &quot;2025-09-16T19:59:32.957Z&quot;,
      &quot;deletedAt&quot;: null,
      &quot;user&quot;: {
        &quot;username&quot;: &quot;admin&quot;,
        &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;
      },
      &quot;team&quot;: null
    }
  ],
  &quot;count&quot;: 1,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiadminteams" class="peer" data-card="">GET /api/admin/teams</a>

Returns all teams.

**Parameters**


| Parameter  | Type   | Description                                                   |
|------------|--------|---------------------------------------------------------------|
| `search`   | string | (optional) Search text.                                       |
| `page`     | number | (optional, default 1) Determines page.                        |
| `pageSize` | number | (optional, default 20) Determines how many results to return. |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;name&quot;: &quot;Umami Software, Inc&quot;,
      &quot;accessCode&quot;: &quot;xxxxxxxxxxxxxx&quot;,
      &quot;logoUrl&quot;: null,
      &quot;createdAt&quot;: &quot;2025-09-24T22:08:35.259Z&quot;,
      &quot;updatedAt&quot;: &quot;2025-09-24T22:08:35.259Z&quot;,
      &quot;deletedAt&quot;: null,
      &quot;members&quot;: [
        {
          &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;role&quot;: &quot;team-owner&quot;,
          &quot;createdAt&quot;: &quot;2025-09-24T22:08:35.302Z&quot;,
          &quot;updatedAt&quot;: &quot;2025-09-24T22:08:35.302Z&quot;,
          &quot;user&quot;: {
            &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
            &quot;username&quot;: &quot;admin&quot;
          }
        },
        {
          &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;teamId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
          &quot;role&quot;: &quot;team-member&quot;,
          &quot;createdAt&quot;: &quot;2025-10-10T23:41:09.030Z&quot;,
          &quot;updatedAt&quot;: &quot;2025-10-10T23:41:09.030Z&quot;,
          &quot;user&quot;: {
            &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
            &quot;username&quot;: &quot;member&quot;
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


<a href="/docs/api/sending-stats" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Sending stats


Previous Page

<a href="/docs/api/events" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Events


Next Page


### On this page


<a href="#get-apiadminusers" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/admin/users</a><a href="#get-apiadminwebsites" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/admin/websites</a><a href="#get-apiadminteams" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/admin/teams</a>


