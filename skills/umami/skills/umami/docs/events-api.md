> Source: https://docs.umami.is/docs/api/events



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Events


Operations around Events and Event data.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GET /api/websites/:websiteId/events
GET /api/websites/:websiteId/events/stats
GET /api/websites/:websiteId/event-data
GET /api/websites/:websiteId/event-data/:eventId
GET /api/websites/:websiteId/event-data/events
GET /api/websites/:websiteId/event-data/fields
GET /api/websites/:websiteId/event-data/properties
GET /api/websites/:websiteId/event-data/values
GET /api/websites/:websiteId/event-data/stats</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#filters" class="peer" data-card="">Filters</a>

All Endpoints marked with `filters` can now be filtered with the parameters below.


| Parameter     | Type   | Description                    |
|---------------|--------|--------------------------------|
| `path`        | string | Name of URL.                   |
| `referrer`    | string | Name of referrer.              |
| `title`       | string | Name of page title.            |
| `query`       | string | Name of query parameter.       |
| `browser`     | string | Name of browser.               |
| `os`          | string | Name of operating system.      |
| `device`      | string | Name of device (ex. Mobile).   |
| `country`     | string | Name of country.               |
| `region`      | string | Name of region/state/province. |
| `city`        | string | Name of city.                  |
| `language`    | string | Name of browser language.      |
| `hostname`    | string | Name of hostname.              |
| `tag`         | string | Name of tag.                   |
| `event`       | string | Name of event.                 |
| `distinctId`  | string | Name of distinct ID.           |
| `utmSource`   | string | UTM source.                    |
| `utmMedium`   | string | UTM medium.                    |
| `utmCampaign` | string | UTM campaign name.             |
| `utmContent`  | string | UTM content.                   |
| `utmTerm`     | string | UTM term.                      |
| `segment`     | uuid   | UUID of segment.               |
| `cohort`      | uuid   | UUID of cohort.                |


------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidevents" class="peer" data-card="">GET /api/websites/:websiteId/events</a>

Gets website event details within a given time range.

**Parameters**


| Parameter  | Type   | Description                                                   |
|------------|--------|---------------------------------------------------------------|
| `startAt`  | number | Timestamp (in ms) of starting date.                           |
| `endAt`    | number | Timestamp (in ms) of end date.                                |
| `search`   | string | (optional) Search text.                                       |
| `page`     | number | (optional, default 1) Determines page.                        |
| `pageSize` | number | (optional, default 20) Determines how many results to return. |
| `filters`  | object | Can accept filter parameters.                                 |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;createdAt&quot;: &quot;2025-10-15T16:26:28Z&quot;,
      &quot;hostname&quot;: &quot;umami.is&quot;,
      &quot;urlPath&quot;: &quot;/docs/api&quot;,
      &quot;urlQuery&quot;: &quot;&quot;,
      &quot;referrerPath&quot;: &quot;&quot;,
      &quot;referrerQuery&quot;: &quot;&quot;,
      &quot;referrerDomain&quot;: &quot;&quot;,
      &quot;country&quot;: &quot;US&quot;,
      &quot;city&quot;: &quot;Scott&quot;,
      &quot;device&quot;: &quot;desktop&quot;,
      &quot;os&quot;: &quot;Mac OS&quot;,
      &quot;browser&quot;: &quot;chrome&quot;,
      &quot;pageTitle&quot;: &quot;API – Docs - Umami&quot;,
      &quot;eventType&quot;: 1,
      &quot;eventName&quot;: &quot;&quot;,
      &quot;hasData&quot;: 0
    },
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;createdAt&quot;: &quot;2025-10-15T16:26:23Z&quot;,
      &quot;hostname&quot;: &quot;umami.is&quot;,
      &quot;urlPath&quot;: &quot;/docs/sessions&quot;,
      &quot;urlQuery&quot;: &quot;&quot;,
      &quot;referrerPath&quot;: &quot;/docs/distinct-ids&quot;,
      &quot;referrerQuery&quot;: &quot;&quot;,
      &quot;referrerDomain&quot;: &quot;umami.is&quot;,
      &quot;country&quot;: &quot;PL&quot;,
      &quot;city&quot;: &quot;Warsaw&quot;,
      &quot;device&quot;: &quot;desktop&quot;,
      &quot;os&quot;: &quot;Mac OS&quot;,
      &quot;browser&quot;: &quot;chrome&quot;,
      &quot;pageTitle&quot;: &quot;Sessions – Docs - Umami&quot;,
      &quot;eventType&quot;: 2,
      &quot;eventName&quot;: &quot;login-button-header&quot;,
      &quot;hasData&quot;: 0
    }
  ],
  &quot;count&quot;: 2,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteideventsstats" class="peer" data-card="">GET /api/websites/:websiteId/events/stats</a>

Gets aggregated event statistics within a given time range, with optional period comparison.

**Parameters**


| Parameter | Type   | Description                                     |
|-----------|--------|-------------------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date.             |
| `endAt`   | number | Timestamp (in ms) of end date.                  |
| `compare` | string | (optional) Comparison period (`prev` \| `yoy`). |
| `filters` | object | (optional) Can accept filter parameters.        |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;data&quot;: {
        &quot;events&quot;: 753,
        &quot;visitors&quot;: 607,
        &quot;visits&quot;: 687,
        &quot;uniqueEvents&quot;: 8,
        &quot;comparison&quot;: {
            &quot;events&quot;: 1809,
            &quot;visitors&quot;: 1374,
            &quot;visits&quot;: 1655,
            &quot;uniqueEvents&quot;: 10
        }
    }
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidevent-data" class="peer" data-card="">GET /api/websites/:websiteId/event-data</a>

Gets event data for a website within a given time range, grouped by event.

**Parameters**


| Parameter  | Type   | Description                                                   |
|------------|--------|---------------------------------------------------------------|
| `startAt`  | number | Timestamp (in ms) of starting date.                           |
| `endAt`    | number | Timestamp (in ms) of end date.                                |
| `page`     | number | (optional, default 1) Determines page.                        |
| `pageSize` | number | (optional, default 20) Determines how many results to return. |
| `filters`  | object | Can accept filter parameters.                                 |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;eventId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;eventName&quot;: &quot;button-click&quot;,
      &quot;eventProperties&quot;: [
        {
          &quot;dataKey&quot;: &quot;id&quot;,
          &quot;stringValue&quot;: &quot;signup-btn&quot;,
          &quot;numberValue&quot;: null,
          &quot;dateValue&quot;: null,
          &quot;dataType&quot;: 1,
          &quot;createdAt&quot;: &quot;2025-10-15T16:26:28Z&quot;
        },
        {
          &quot;dataKey&quot;: &quot;name&quot;,
          &quot;stringValue&quot;: &quot;Sign Up&quot;,
          &quot;numberValue&quot;: null,
          &quot;dateValue&quot;: null,
          &quot;dataType&quot;: 1,
          &quot;createdAt&quot;: &quot;2025-10-15T16:26:28Z&quot;
        }
      ]
    },
    {
      &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;eventId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;eventName&quot;: &quot;revenue-demo&quot;,
      &quot;eventProperties&quot;: [
        {
          &quot;dataKey&quot;: &quot;currency&quot;,
          &quot;stringValue&quot;: &quot;USD&quot;,
          &quot;numberValue&quot;: null,
          &quot;dateValue&quot;: null,
          &quot;dataType&quot;: 1,
          &quot;createdAt&quot;: &quot;2025-10-10T12:31:03Z&quot;
        },
        {
          &quot;dataKey&quot;: &quot;revenue&quot;,
          &quot;stringValue&quot;: &quot;40.0000&quot;,
          &quot;numberValue&quot;: 40,
          &quot;dateValue&quot;: null,
          &quot;dataType&quot;: 2,
          &quot;createdAt&quot;: &quot;2025-10-10T12:31:03Z&quot;
        }
      ]
    }
  ],
  &quot;count&quot;: 2,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidevent-dataeventid" class="peer" data-card="">GET /api/websites/:websiteId/event-data/:eventId</a>

Gets event-data for a individual event

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;eventId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;urlPath&quot;: &quot;/&quot;,
    &quot;eventName&quot;: &quot;revenue-demo&quot;,
    &quot;dataKey&quot;: &quot;currency&quot;,
    &quot;stringValue&quot;: &quot;USD&quot;,
    &quot;numberValue&quot;: null,
    &quot;dateValue&quot;: null,
    &quot;dataType&quot;: 1,
    &quot;createdAt&quot;: &quot;2025-10-10T12:31:03Z&quot;
  },
  {
    &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;eventId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;urlPath&quot;: &quot;/&quot;,
    &quot;eventName&quot;: &quot;revenue-demo&quot;,
    &quot;dataKey&quot;: &quot;revenue&quot;,
    &quot;stringValue&quot;: &quot;40.0000&quot;,
    &quot;numberValue&quot;: 40,
    &quot;dateValue&quot;: null,
    &quot;dataType&quot;: 2,
    &quot;createdAt&quot;: &quot;2025-10-10T12:31:03Z&quot;
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidevent-dataevents" class="peer" data-card="">GET /api/websites/:websiteId/event-data/events</a>

Gets event data names, properties, and counts

**Parameters**


| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `event`   | string | (optional) Event name filter.       |
| `filters` | object | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;eventName&quot;: &quot;button-click&quot;,
    &quot;propertyName&quot;: &quot;id&quot;,
    &quot;dataType&quot;: 1,
    &quot;total&quot;: 4
  },
  {
    &quot;eventName&quot;: &quot;button-click&quot;,
    &quot;propertyName&quot;: &quot;name&quot;,
    &quot;dataType&quot;: 1,
    &quot;total&quot;: 4
  },
  {
    &quot;eventName&quot;: &quot;track-product&quot;,
    &quot;propertyName&quot;: &quot;price&quot;,
    &quot;dataType&quot;: 2,
    &quot;total&quot;: 2
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidevent-datafields" class="peer" data-card="">GET /api/websites/:websiteId/event-data/fields</a>

Gets event data property and value counts within a given time range.

**Parameters**


| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `filters` | object | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;propertyName&quot;: &quot;age&quot;,
    &quot;dataType&quot;: 2,
    &quot;value&quot;: &quot;33&quot;,
    &quot;total&quot;: 1
  },
  {
    &quot;propertyName&quot;: &quot;age&quot;,
    &quot;dataType&quot;: 2,
    &quot;value&quot;: &quot;31&quot;,
    &quot;total&quot;: 4
  },
  {
    &quot;propertyName&quot;: &quot;gender&quot;,
    &quot;dataType&quot;: 1,
    &quot;value&quot;: &quot;female&quot;,
    &quot;total&quot;: 4
  },
  {
    &quot;propertyName&quot;: &quot;gender&quot;,
    &quot;dataType&quot;: 1,
    &quot;value&quot;: &quot;male&quot;,
    &quot;total&quot;: 1
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidevent-dataproperties" class="peer" data-card="">GET /api/websites/:websiteId/event-data/properties</a>

Gets event name and property counts for a website.

**Parameters**


| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `filters` | object | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;eventName&quot;: &quot;revenue-demo&quot;,
    &quot;propertyName&quot;: &quot;revenue&quot;,
    &quot;total&quot;: 122
  },
  {
    &quot;eventName&quot;: &quot;revenue-demo&quot;,
    &quot;propertyName&quot;: &quot;currency&quot;,
    &quot;total&quot;: 122
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidevent-datavalues" class="peer" data-card="">GET /api/websites/:websiteId/event-data/values</a>

Gets event data counts for a given event and property

**Parameters**


| Parameter      | Type   | Description                         |
|----------------|--------|-------------------------------------|
| `startAt`      | number | Timestamp (in ms) of starting date. |
| `endAt`        | number | Timestamp (in ms) of end date.      |
| `event`        | string | Event name.                         |
| `propertyName` | string | Property name.                      |
| `filters`      | object | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;value&quot;: &quot;Male&quot;,
    &quot;total&quot;: 28
  },
  {
    &quot;value&quot;: &quot;Female&quot;,
    &quot;total&quot;: 26
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidevent-datastats" class="peer" data-card="">GET /api/websites/:websiteId/event-data/stats</a>

Gets aggregated website events, properties, and records within a given time range.

**Parameters**


| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `filters` | object | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;events&quot;: 16,
    &quot;properties&quot;: 13,
    &quot;records&quot;: 26
  }
]</code></pre>
</figure>


<a href="/docs/api/admin" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Admin


Previous Page

<a href="/docs/api/links" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Links


Next Page


### On this page


<a href="#filters" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Filters</a><a href="#get-apiwebsiteswebsiteidevents" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/events</a><a href="#get-apiwebsiteswebsiteideventsstats" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/events/stats</a><a href="#get-apiwebsiteswebsiteidevent-data" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/event-data</a><a href="#get-apiwebsiteswebsiteidevent-dataeventid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/event-data/:eventId</a><a href="#get-apiwebsiteswebsiteidevent-dataevents" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/event-data/events</a><a href="#get-apiwebsiteswebsiteidevent-datafields" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/event-data/fields</a><a href="#get-apiwebsiteswebsiteidevent-dataproperties" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/event-data/properties</a><a href="#get-apiwebsiteswebsiteidevent-datavalues" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/event-data/values</a><a href="#get-apiwebsiteswebsiteidevent-datastats" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/event-data/stats</a>


