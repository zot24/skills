> Source: https://docs.umami.is/docs/api/sessions



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Sessions


Operations around Sessions and Session data.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GET /api/websites/:websiteId/sessions
GET /api/websites/:websiteId/sessions/stats
GET /api/websites/:websiteId/sessions/weekly
GET /api/websites/:websiteId/sessions/:sessionId
GET /api/websites/:websiteId/sessions/:sessionId/activity
GET /api/websites/:websiteId/sessions/:sessionId/properties
GET /api/websites/:websiteId/session-data/properties
GET /api/websites/:websiteId/session-data/values</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#filters" class="peer" data-card="">Filters</a>

All Endpoints marked with `filters` can now be filtered with the parameters below.

**Parameters**


| Parameter     | Type   | Description                                      |
|---------------|--------|--------------------------------------------------|
| `path`        | string | (optional) Name of URL.                          |
| `referrer`    | string | (optional) Name of referrer.                     |
| `title`       | string | (optional) Name of page title.                   |
| `query`       | string | (optional) Name of query parameter.              |
| `browser`     | string | (optional) Name of browser.                      |
| `os`          | string | (optional) Name of operating system.             |
| `device`      | string | (optional) Name of device (ex. Mobile).          |
| `country`     | string | (optional) Name of country.                      |
| `region`      | string | (optional) Name of region/state/province.        |
| `city`        | string | (optional) Name of city.                         |
| `hostname`    | string | (optional) Name of hostname.                     |
| `language`    | string | (optional) Visitor browser language (ex. en-US). |
| `tag`         | string | (optional) Name of tag.                          |
| `event`       | string | (optional) Name of event.                        |
| `distinctId`  | string | (optional) Name of distinct ID.                  |
| `utmSource`   | string | (optional) UTM source.                           |
| `utmMedium`   | string | (optional) UTM medium.                           |
| `utmCampaign` | string | (optional) UTM campaign name.                    |
| `utmContent`  | string | (optional) UTM content.                          |
| `utmTerm`     | string | (optional) UTM term.                             |
| `segment`     | uuid   | (optional) UUID of segment.                      |
| `cohort`      | uuid   | (optional) UUID of cohort.                       |


------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidsessions" class="peer" data-card="">GET /api/websites/:websiteId/sessions</a>

Gets website session details within a given time range.

**Parameters**


| Parameter  | Type   | Description                                                   |
|------------|--------|---------------------------------------------------------------|
| `startAt`  | number | Timestamp (in ms) of starting date.                           |
| `endAt`    | number | Timestamp (in ms) of end date.                                |
| `search`   | string | (optional) Search text.                                       |
| `page`     | number | (optional, default 1) Determines page.                        |
| `pageSize` | number | (optional, default 20) Determines how many results to return. |
| `filters`  | \-     | Can accept filter parameters.                                 |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;hostname&quot;: &quot;umami.is&quot;,
      &quot;browser&quot;: &quot;chrome&quot;,
      &quot;os&quot;: &quot;Mac OS&quot;,
      &quot;device&quot;: &quot;desktop&quot;,
      &quot;screen&quot;: &quot;1800x1169&quot;,
      &quot;language&quot;: &quot;en-US&quot;,
      &quot;country&quot;: &quot;SE&quot;,
      &quot;region&quot;: &quot;SE-AB&quot;,
      &quot;city&quot;: &quot;Stockholm&quot;,
      &quot;firstAt&quot;: &quot;2025-10-21T13:35:51Z&quot;,
      &quot;lastAt&quot;: &quot;2025-10-21T15:00:09Z&quot;,
      &quot;visits&quot;: 2,
      &quot;views&quot;: 18,
      &quot;createdAt&quot;: &quot;2025-10-21T15:00:09Z&quot;
    },
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;hostname&quot;: &quot;umami.is&quot;,
      &quot;browser&quot;: &quot;safari&quot;,
      &quot;os&quot;: &quot;Mac OS&quot;,
      &quot;device&quot;: &quot;desktop&quot;,
      &quot;screen&quot;: &quot;1512x982&quot;,
      &quot;language&quot;: &quot;en-IN&quot;,
      &quot;country&quot;: &quot;IN&quot;,
      &quot;region&quot;: &quot;IN-GJ&quot;,
      &quot;city&quot;: &quot;Bhavnagar&quot;,
      &quot;firstAt&quot;: &quot;2025-10-21T14:59:47Z&quot;,
      &quot;lastAt&quot;: &quot;2025-10-21T14:59:48Z&quot;,
      &quot;visits&quot;: 1,
      &quot;views&quot;: 1,
      &quot;createdAt&quot;: &quot;2025-10-21T14:59:48Z&quot;
    }
  ],
  &quot;count&quot;: 923,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidsessionsstats" class="peer" data-card="">GET /api/websites/:websiteId/sessions/stats</a>

Gets summarized website session statistics.

**Parameters**


| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `filters` | \-     | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;pageviews&quot;: {
    &quot;value&quot;: 2924
  },
  &quot;visitors&quot;: {
    &quot;value&quot;: 905
  },
  &quot;visits&quot;: {
    &quot;value&quot;: 1050
  },
  &quot;countries&quot;: {
    &quot;value&quot;: 84
  },
  &quot;events&quot;: {
    &quot;value&quot;: 517
  }
}</code></pre>
</figure>

- `pageviews`: Pages hits
- `visitors`: Number of unique visitors
- `visits`: Number of unique visits
- `bounces`: Number of visitors who only visit a single page
- `totaltime`: Time spent on the website

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidsessionsweekly" class="peer" data-card="">GET /api/websites/:websiteId/sessions/weekly</a>

Get collected count of sessions by hour of weekday.

**Parameters**


| Parameter  | Type   | Description                         |
|------------|--------|-------------------------------------|
| `startAt`  | number | Timestamp (in ms) of start date.    |
| `endAt`    | number | Timestamp (in ms) of end date.      |
| `timezone` | string | Timezone (ex. America/Los_Angeles). |
| `filters`  | \-     | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 58, 57, 65, 53, 58, 135],
  [117, 124, 132, 127, 135, 142, 141, 138, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidsessionssessionid" class="peer" data-card="">GET /api/websites/:websiteId/sessions/:sessionId</a>

Gets session details for a individual session

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;distinctId&quot;: &quot;&quot;,
  &quot;browser&quot;: &quot;chrome&quot;,
  &quot;os&quot;: &quot;Mac OS&quot;,
  &quot;device&quot;: &quot;desktop&quot;,
  &quot;screen&quot;: &quot;1800x1169&quot;,
  &quot;language&quot;: &quot;en-US&quot;,
  &quot;country&quot;: &quot;SE&quot;,
  &quot;region&quot;: &quot;SE-AB&quot;,
  &quot;city&quot;: &quot;Stockholm&quot;,
  &quot;firstAt&quot;: &quot;2025-10-21T13:35:51Z&quot;,
  &quot;lastAt&quot;: &quot;2025-10-21T15:00:09Z&quot;,
  &quot;visits&quot;: 2,
  &quot;views&quot;: 18,
  &quot;events&quot;: 12,
  &quot;totaltime&quot;: 1609
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidsessionssessionidactivity" class="peer" data-card="">GET /api/websites/:websiteId/sessions/:sessionId/activity</a>

Gets session activity for a individual session

**Parameters**


| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;createdAt&quot;: &quot;2025-10-21T15:00:09Z&quot;,
    &quot;urlPath&quot;: &quot;/blog&quot;,
    &quot;urlQuery&quot;: &quot;&quot;,
    &quot;referrerDomain&quot;: &quot;umami.is&quot;,
    &quot;eventId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;eventType&quot;: 1,
    &quot;eventName&quot;: &quot;&quot;,
    &quot;visitId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;hasData&quot;: 0
  },
  {
    &quot;createdAt&quot;: &quot;2025-10-21T14:56:30Z&quot;,
    &quot;urlPath&quot;: &quot;/docs&quot;,
    &quot;urlQuery&quot;: &quot;&quot;,
    &quot;referrerDomain&quot;: &quot;umami.is&quot;,
    &quot;eventId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;eventType&quot;: 1,
    &quot;eventName&quot;: &quot;&quot;,
    &quot;visitId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;hasData&quot;: 0
  },
  {
    &quot;createdAt&quot;: &quot;2025-10-21T14:56:30Z&quot;,
    &quot;urlPath&quot;: &quot;/&quot;,
    &quot;urlQuery&quot;: &quot;&quot;,
    &quot;referrerDomain&quot;: &quot;umami.is&quot;,
    &quot;eventId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;eventType&quot;: 1,
    &quot;eventName&quot;: &quot;&quot;,
    &quot;visitId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;hasData&quot;: 0
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidsessionssessionidproperties" class="peer" data-card="">GET /api/websites/:websiteId/sessions/:sessionId/properties</a>

Gets session properties for a individual session

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;dataKey&quot;: &quot;email&quot;,
    &quot;dataType&quot;: 1,
    &quot;stringValue&quot;: &quot;[email protected]&quot;,
    &quot;numberValue&quot;: null,
    &quot;dateValue&quot;: null,
    &quot;createdAt&quot;: &quot;2025-10-22T02:28:17Z&quot;
  },
  {
    &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;dataKey&quot;: &quot;id&quot;,
    &quot;dataType&quot;: 1,
    &quot;stringValue&quot;: &quot;910bfde0-21dd-4d24-804d-716035e92ddc&quot;,
    &quot;numberValue&quot;: null,
    &quot;dateValue&quot;: null,
    &quot;createdAt&quot;: &quot;2025-10-22T02:28:17Z&quot;
  },
  {
    &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;dataKey&quot;: &quot;name&quot;,
    &quot;dataType&quot;: 1,
    &quot;stringValue&quot;: &quot;Bob Aol&quot;,
    &quot;numberValue&quot;: null,
    &quot;dateValue&quot;: null,
    &quot;createdAt&quot;: &quot;2025-10-22T02:28:17Z&quot;
  }
]</code></pre>
</figure>

## <a href="#get-apiwebsiteswebsiteidsession-dataproperties" class="peer" data-card="">GET /api/websites/:websiteId/session-data/properties</a>

Gets session data counts by property name

**Parameters**


| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `filters` | \-     | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;propertyName&quot;: &quot;id&quot;,
    &quot;total&quot;: 1039
  },
  {
    &quot;propertyName&quot;: &quot;region&quot;,
    &quot;total&quot;: 1039
  },
  {
    &quot;propertyName&quot;: &quot;name&quot;,
    &quot;total&quot;: 1039
  },
  {
    &quot;propertyName&quot;: &quot;email&quot;,
    &quot;total&quot;: 1039
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidsession-datavalues" class="peer" data-card="">GET /api/websites/:websiteId/session-data/values</a>

Gets session data counts for a given property

**Parameters**


| Parameter      | Type   | Description                         |
|----------------|--------|-------------------------------------|
| `startAt`      | number | Timestamp (in ms) of starting date. |
| `endAt`        | number | Timestamp (in ms) of end date.      |
| `propertyName` | string | Property name.                      |
| `filters`      | \-     | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;value&quot;: &quot;EU&quot;,
    &quot;total&quot;: 626
  },
  {
    &quot;value&quot;: &quot;US&quot;,
    &quot;total&quot;: 462
  }
]</code></pre>
</figure>


<a href="/docs/api/reports" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Reports


Previous Page

<a href="/docs/api/share" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Share


Next Page


### On this page


<a href="#filters" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Filters</a><a href="#get-apiwebsiteswebsiteidsessions" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/sessions</a><a href="#get-apiwebsiteswebsiteidsessionsstats" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/sessions/stats</a><a href="#get-apiwebsiteswebsiteidsessionsweekly" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/sessions/weekly</a><a href="#get-apiwebsiteswebsiteidsessionssessionid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/sessions/:sessionId</a><a href="#get-apiwebsiteswebsiteidsessionssessionidactivity" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/sessions/:sessionId/activity</a><a href="#get-apiwebsiteswebsiteidsessionssessionidproperties" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/sessions/:sessionId/properties</a><a href="#get-apiwebsiteswebsiteidsession-dataproperties" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/session-data/properties</a><a href="#get-apiwebsiteswebsiteidsession-datavalues" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/session-data/values</a>


