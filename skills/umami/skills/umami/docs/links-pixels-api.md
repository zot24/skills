> Source: https://docs.umami.is/docs/api/links



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Links


Operations around Links management.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GET /api/links
POST /api/links
GET /api/links/:linkId
POST /api/links/:linkId
DELETE /api/links/:linkId</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apilinks" class="peer" data-card="">GET /api/links</a>

Returns all user links.

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
      &quot;name&quot;: &quot;umami&quot;,
      &quot;url&quot;: &quot;https://www.umami.is&quot;,
      &quot;slug&quot;: &quot;xxxxxxxx&quot;,
      &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;teamId&quot;: null,
      &quot;createdAt&quot;: &quot;2025-10-27T18:49:39.383Z&quot;,
      &quot;updatedAt&quot;: &quot;2025-10-27T18:49:39.383Z&quot;,
      &quot;deletedAt&quot;: null
    }
  ],
  &quot;count&quot;: 1,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apilinks" class="peer" data-card="">POST /api/links</a>

Creates a link.

**Parameters**


| Parameter | Type   | Description                                                   |
|-----------|--------|---------------------------------------------------------------|
| `name`    | string | The link's name.                                              |
| `url`     | string | The link's destination URL.                                   |
| `slug`    | string | The link's URL slug (minimum 8 characters).                   |
| `teamId`  | string | (optional) The ID of the team the link will be created under. |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;name&quot;: &quot;umami&quot;,
  &quot;url&quot;: &quot;https://www.umami.is&quot;,
  &quot;slug&quot;: &quot;umami123&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;name&quot;: &quot;umami&quot;,
  &quot;url&quot;: &quot;https://www.umami.is&quot;,
  &quot;slug&quot;: &quot;umami123&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: null,
  &quot;createdAt&quot;: &quot;2025-10-27T18:49:39.383Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-10-27T18:49:39.383Z&quot;,
  &quot;deletedAt&quot;: null
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apilinkslinkid" class="peer" data-card="">GET /api/links/:linkId</a>

Gets a link by ID.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;name&quot;: &quot;umami&quot;,
  &quot;url&quot;: &quot;https://www.umami.is&quot;,
  &quot;slug&quot;: &quot;xxxxxxxx&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: null,
  &quot;createdAt&quot;: &quot;2025-10-27T18:49:39.383Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-10-27T18:49:39.383Z&quot;,
  &quot;deletedAt&quot;: null
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apilinkslinkid" class="peer" data-card="">POST /api/links/:linkId</a>

Updates a link.

**Parameters**


| Parameter | Type   | Description                                            |
|-----------|--------|--------------------------------------------------------|
| `name`    | string | (optional) The link's name.                            |
| `url`     | string | (optional) The link's destination URL.                 |
| `slug`    | string | (optional) The link's URL slug (minimum 8 characters). |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;name&quot;: &quot;umami&quot;,
  &quot;url&quot;: &quot;https://www.umami.is&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;name&quot;: &quot;umami&quot;,
  &quot;url&quot;: &quot;https://www.umami.is&quot;,
  &quot;slug&quot;: &quot;xxxxxxxx&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;teamId&quot;: null,
  &quot;createdAt&quot;: &quot;2025-10-27T18:49:39.383Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-10-30T23:06:01.824Z&quot;,
  &quot;deletedAt&quot;: null
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#delete-apilinkslinkid" class="peer" data-card="">DELETE /api/links/:linkId</a>

Deletes a link.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;ok&quot;: true
}</code></pre>
</figure>


<a href="/docs/api/events" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Events


Previous Page

<a href="/docs/api/me" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Me


Next Page


### On this page


<a href="#get-apilinks" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/links</a><a href="#post-apilinks" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/links</a><a href="#get-apilinkslinkid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/links/:linkId</a><a href="#post-apilinkslinkid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/links/:linkId</a><a href="#delete-apilinkslinkid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">DELETE /api/links/:linkId</a>


