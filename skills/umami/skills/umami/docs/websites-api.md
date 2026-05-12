> Source: https://docs.umami.is/docs/api/websites



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Websites


Operations around Website management and statistics.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GET /api/websites
POST /api/websites
GET /api/websites/:websiteId
POST /api/websites/:websiteId
DELETE /api/websites/:websiteId
POST /api/websites/:websiteId/reset</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsites" class="peer" data-card="">GET /api/websites</a>

Returns all user websites.

**Parameters**


| Parameter      | Type    | Description                                                   |
|----------------|---------|---------------------------------------------------------------|
| `includeTeams` | boolean | Set to true to include websites where you are the team owner. |
| `search`       | string  | (optional) Search text.                                       |
| `page`         | number  | (optional, default 1) Determines page.                        |
| `pageSize`     | number  | (optional) Determines how many results to return.             |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;name&quot;: &quot;Example&quot;,
      &quot;domain&quot;: &quot;example.com&quot;,
      &quot;shareId&quot;: null,
      &quot;resetAt&quot;: null,
      &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;teamId&quot;: null,
      &quot;createdBy&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;createdAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
      &quot;updatedAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
      &quot;deletedAt&quot;: null,
      &quot;user&quot;: {
        &quot;username&quot;: &quot;[email protected]&quot;,
        &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;
      }
    }
  ],
  &quot;count&quot;: 1,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 10
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apiwebsites" class="peer" data-card="">POST /api/websites</a>

Creates a website.

**Parameters**


| Parameter | Type   | Description                                                              |
|-----------|--------|--------------------------------------------------------------------------|
| `name`    | string | The name of the website in Umami.                                        |
| `domain`  | string | The full domain of the tracked website.                                  |
| `shareId` | string | (optional) A unique string to enable a share URL. Set `null` to unshare. |
| `teamId`  | string | (optional) The ID of the team the website will be created under.         |
| `id`      | string | (optional) Force a UUID assignment to the website.                       |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;name&quot;: &quot;Test&quot;,
  &quot;domain&quot;: &quot;example.com&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;name&quot;: &quot;Test&quot;,
  &quot;domain&quot;: &quot;example.com&quot;,
  &quot;shareId&quot;: null,
  &quot;resetAt&quot;: null,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: null,
  &quot;createdBy&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;createdAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
  &quot;updatedAt&quot;: &quot;0000-00-00T00:00:00.000Z&quot;,
  &quot;deletedAt&quot;: null
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteid" class="peer" data-card="">GET /api/websites/:websiteId</a>

Gets a website by ID.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;name&quot;: &quot;Example&quot;,
  &quot;domain&quot;: &quot;example.com&quot;,
  &quot;shareId&quot;: null,
  &quot;resetAt&quot;: null,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: null,
  &quot;createdBy&quot;: &quot;133660ed-e51c-4ed9-84aa-c86654460cae&quot;,
  &quot;createdAt&quot;: &quot;2025-10-10T22:01:06.201Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-10-10T22:02:02.220Z&quot;,
  &quot;deletedAt&quot;: null
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apiwebsiteswebsiteid" class="peer" data-card="">POST /api/websites/:websiteId</a>

Updates a website.

**Parameters**


| Parameter | Type   | Description                                                              |
|-----------|--------|--------------------------------------------------------------------------|
| `name`    | string | The name of the website in Umami.                                        |
| `domain`  | string | The full domain of the tracked website.                                  |
| `shareId` | string | (optional) A unique string to enable a share URL. Set `null` to unshare. |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;name&quot;: &quot;Test&quot;,
  &quot;domain&quot;: &quot;domain.com&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;name&quot;: &quot;Example&quot;,
  &quot;domain&quot;: &quot;example.com&quot;,
  &quot;shareId&quot;: null,
  &quot;resetAt&quot;: null,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: null,
  &quot;createdBy&quot;: &quot;133660ed-e51c-4ed9-84aa-c86654460cae&quot;,
  &quot;createdAt&quot;: &quot;2025-10-10T22:01:06.201Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-10-10T22:02:02.220Z&quot;,
  &quot;deletedAt&quot;: null
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#delete-apiwebsiteswebsiteid" class="peer" data-card="">DELETE /api/websites/:websiteId</a>

Deletes a website.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;ok&quot;: true
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apiwebsiteswebsiteidreset" class="peer" data-card="">POST /api/websites/:websiteId/reset</a>

Resets a website by removing all data related to the website.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;ok&quot;: true
}</code></pre>
</figure>


<a href="/docs/api/pixels" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Pixels


Previous Page

<a href="/docs/api/website-stats" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Website statistics


Next Page


### On this page


<a href="#get-apiwebsites" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites</a><a href="#post-apiwebsites" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/websites</a><a href="#get-apiwebsiteswebsiteid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId</a><a href="#post-apiwebsiteswebsiteid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/websites/:websiteId</a><a href="#delete-apiwebsiteswebsiteid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">DELETE /api/websites/:websiteId</a><a href="#post-apiwebsiteswebsiteidreset" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/websites/:websiteId/reset</a>


