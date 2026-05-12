> Source: https://docs.umami.is/docs/api/share



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Share


Operations around Share page management.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>POST /api/share
GET /api/share/id/:shareId
POST /api/share/id/:shareId
DELETE /api/share/id/:shareId
GET api/websites/:websiteId/shares
POST api/websites/:websiteId/shares</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apishare" class="peer" data-card="">POST /api/share</a>

Creates a share page.

**Parameters**


| Parameter    | Type   | Description                                                  |
|--------------|--------|--------------------------------------------------------------|
| `entityId`   | string | ID of entity to be added (websiteId, pixelId, linkId, etc.). |
| `shareType`  | number | `website: 1` \| `link: 2` \| `pixel: 3` \| `board: 4`        |
| `name`       | string | Name of the share page.                                      |
| `slug`       | string | Slug of the share page.                                      |
| `parameters` | object | Parameters for share page.                                   |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;entityId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;shareType&quot;: 1,
    &quot;name&quot;: &quot;My Share Page&quot;,
    &quot;slug&quot;: &quot;abc123defg&quot;,
    &quot;parameters&quot;: { &quot;overview&quot;: true, &quot;events&quot;: true}
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;entityId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;name&quot;: &quot;My Share Page&quot;,
    &quot;shareType&quot;: 1,
    &quot;slug&quot;: &quot;abc123defg&quot;,
    &quot;parameters&quot;: {
        &quot;events&quot;: true,
        &quot;overview&quot;: true
    },
    &quot;createdAt&quot;: &quot;2026-01-30T06:03:51.718Z&quot;,
    &quot;updatedAt&quot;: &quot;2026-01-30T06:03:51.718Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apishareidshareid" class="peer" data-card="">GET /api/share/id/:shareId</a>

Gets a share page by ID.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;entityId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;name&quot;: &quot;My Share Page&quot;,
    &quot;shareType&quot;: 1,
    &quot;slug&quot;: &quot;abc123defg&quot;,
    &quot;parameters&quot;: {
        &quot;events&quot;: true,
        &quot;overview&quot;: true
    },
    &quot;createdAt&quot;: &quot;2026-01-30T06:03:51.718Z&quot;,
    &quot;updatedAt&quot;: &quot;2026-01-30T06:06:32.197Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apishareidshareid" class="peer" data-card="">POST /api/share/id/:shareId</a>

Updates a share page.

**Parameters**


| Parameter    | Type   | Description                |
|--------------|--------|----------------------------|
| `name`       | string | Name of the share page.    |
| `slug`       | string | Slug of the share page.    |
| `parameters` | object | Parameters for share page. |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;name&quot;: &quot;My Updated Share Page&quot;,
    &quot;slug&quot;: &quot;abc123defg&quot;,
    &quot;parameters&quot;: { &quot;overview&quot;: true, &quot;events&quot;: true, &quot;funnel&quot;: true, &quot;utm&quot;: true}
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;entityId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;name&quot;: &quot;My Updated Share Page&quot;,
    &quot;shareType&quot;: 1,
    &quot;slug&quot;: &quot;abc123defg&quot;,
    &quot;parameters&quot;: {
        &quot;utm&quot;: true,
        &quot;events&quot;: true,
        &quot;funnel&quot;: true,
        &quot;overview&quot;: true
    },
    &quot;createdAt&quot;: &quot;2026-01-30T06:03:51.718Z&quot;,
    &quot;updatedAt&quot;: &quot;2026-01-30T06:09:05.640Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#delete-apishareidshareid" class="peer" data-card="">DELETE /api/share/id/:shareId</a>

Deletes a share page.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;ok&quot;: true
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidshares" class="peer" data-card="">GET api/websites/:websiteId/shares</a>

Gets all share pages that belong to a website.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;data&quot;: [
        {
            &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
            &quot;entityId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
            &quot;name&quot;: &quot;Umami Live Demo&quot;,
            &quot;shareType&quot;: 1,
            &quot;slug&quot;: &quot;xxxxxxxxxxxxxx&quot;,
            &quot;parameters&quot;: {
                &quot;utm&quot;: false,
                &quot;goals&quot;: true,
                &quot;events&quot;: true,
                &quot;compare&quot;: false,
                &quot;funnels&quot;: true,
                &quot;revenue&quot;: false,
                &quot;journeys&quot;: false,
                &quot;overview&quot;: true,
                &quot;realtime&quot;: false,
                &quot;sessions&quot;: true,
                &quot;breakdown&quot;: false,
                &quot;retention&quot;: false,
                &quot;attribution&quot;: false
            },
            &quot;createdAt&quot;: &quot;2026-01-29T18:51:40.489Z&quot;,
            &quot;updatedAt&quot;: &quot;2026-01-29T18:51:40.489Z&quot;
        }
    ],
    &quot;count&quot;: 1,
    &quot;page&quot;: 1,
    &quot;pageSize&quot;: 20
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apiwebsiteswebsiteidshares" class="peer" data-card="">POST api/websites/:websiteId/shares</a>

Creates a share page belonging to a website.

**Parameters**


| Parameter    | Type   | Description                |
|--------------|--------|----------------------------|
| `name`       | string | Name of the share page.    |
| `parameters` | object | Parameters for share page. |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;name&quot;: &quot;My Websites Share Page&quot;,
    &quot;parameters&quot;: { &quot;utm&quot;: true, &quot;goals&quot;: true, &quot;events&quot;: true }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;entityId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;name&quot;: &quot;My Websites Share Page&quot;,
    &quot;shareType&quot;: 1,
    &quot;slug&quot;: &quot;xxxxxxxxx&quot;,
    &quot;parameters&quot;: {
        &quot;utm&quot;: false,
        &quot;goals&quot;: true,
        &quot;events&quot;: true
    },
    &quot;createdAt&quot;: &quot;2026-01-30T06:03:51.718Z&quot;,
    &quot;updatedAt&quot;: &quot;2026-01-30T06:09:05.640Z&quot;
}</code></pre>
</figure>


<a href="/docs/api/sessions" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Sessions


Previous Page

<a href="/docs/api/teams" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Teams


Next Page


### On this page


<a href="#post-apishare" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/share</a><a href="#get-apishareidshareid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/share/id/:shareId</a><a href="#post-apishareidshareid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/share/id/:shareId</a><a href="#delete-apishareidshareid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">DELETE /api/share/id/:shareId</a><a href="#get-apiwebsiteswebsiteidshares" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET api/websites/:websiteId/shares</a><a href="#post-apiwebsiteswebsiteidshares" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST api/websites/:websiteId/shares</a>


