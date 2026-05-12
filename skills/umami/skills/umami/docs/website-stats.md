> Source: https://docs.umami.is/docs/api/website-stats



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Website statistics


Operations around Website statistics.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GET /api/websites/:websiteId/active
GET /api/websites/:websiteId/daterange
GET /api/websites/:websiteId/events/series
GET /api/websites/:websiteId/metrics
GET /api/websites/:websiteId/metrics/expanded
GET /api/websites/:websiteId/pageviews
GET /api/websites/:websiteId/stats</code></pre>
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

**Unit Parameter**

The unit parameter buckets the data returned. The unit is automatically converted to the next largest applicable time unit if the maximum is exceeded.


| Unit     | Maximum           |
|----------|-------------------|
| `minute` | Up to 60 minutes. |
| `hour`   | Up to 30 days.    |
| `day`    | Up to 6 months.   |
| `month`  | No limit.         |
| `year`   | No limit.         |


------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidactive" class="peer" data-card="">GET /api/websites/:websiteId/active</a>

Gets the number of active users on a website.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;visitors&quot;: 5
}</code></pre>
</figure>

- `visitors`: Number of unique visitors within the last 5 minutes

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteiddaterange" class="peer" data-card="">GET /api/websites/:websiteId/daterange</a>

Gets the date range of available data for a website.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;startDate&quot;: &quot;2025-12-06T00:00:00Z&quot;,
    &quot;endDate&quot;: &quot;2026-03-11T21:00:00Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteideventsseries" class="peer" data-card="">GET /api/websites/:websiteId/events/series</a>

Gets events within a given time range.

**Parameters**


| Parameter  | Type   | Description                                       |
|------------|--------|---------------------------------------------------|
| `startAt`  | number | Timestamp (in ms) of starting date.               |
| `endAt`    | number | Timestamp (in ms) of end date.                    |
| `unit`     | string | Time unit (`year` \| `month` \| `hour` \| `day`). |
| `timezone` | string | Timezone (ex. America/Los_Angeles).               |
| `filters`  | object | Can accept filter parameters.                     |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;x&quot;: &quot;live-demo-button&quot;,
    &quot;t&quot;: &quot;2023-04-12T22:00:00Z&quot;,
    &quot;y&quot;: 1
  },
  {
    &quot;x&quot;: &quot;get-started-button&quot;,
    &quot;t&quot;: &quot;2023-04-12T22:00:00Z&quot;,
    &quot;y&quot;: 5
  },
  {
    &quot;x&quot;: &quot;get-started-button&quot;,
    &quot;t&quot;: &quot;2023-04-12T23:00:00Z&quot;,
    &quot;y&quot;: 4
  },
  {
    &quot;x&quot;: &quot;live-demo-button&quot;,
    &quot;t&quot;: &quot;2023-04-12T23:00:00Z&quot;,
    &quot;y&quot;: 4
  },
  {
    &quot;x&quot;: &quot;social-Discord&quot;,
    &quot;t&quot;: &quot;2023-04-13T00:00:00Z&quot;,
    &quot;y&quot;: 1
  }
]</code></pre>
</figure>


| Field | Description       |
|-------|-------------------|
| `x`   | Event name.       |
| `t`   | Timestamp.        |
| `y`   | Number of events. |


------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidmetrics" class="peer" data-card="">GET /api/websites/:websiteId/metrics</a>

Gets metrics for a given time range.

**Parameters**


| Parameter | Type   | Description                                      |
|-----------|--------|--------------------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date.              |
| `endAt`   | number | Timestamp (in ms) of end date.                   |
| `type`    | string | Metrics type.                                    |
| `filters` | object | Can accept filter parameters.                    |
| `limit`   | number | (optional, default 500) Number of rows returned. |
| `offset`  | number | (optional, default 0) Number of rows to skip.    |


**Available Types**

`path` \| `entry` \| `exit` \| `title` \| `query` \| `referrer` \| `channel` \| `domain` \| `country` \| `region` \| `city` \| `browser` \| `os` \| `device` \| `language` \| `screen` \| `event` \| `hostname` \| `tag` \| `distinctId`

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;x&quot;: &quot;Mac OS&quot;,
    &quot;y&quot;: 1918
  },
  {
    &quot;x&quot;: &quot;Windows 10&quot;,
    &quot;y&quot;: 1413
  },
  {
    &quot;x&quot;: &quot;iOS&quot;,
    &quot;y&quot;: 464
  },
  {
    &quot;x&quot;: &quot;Android OS&quot;,
    &quot;y&quot;: 301
  },
  {
    &quot;x&quot;: &quot;Linux&quot;,
    &quot;y&quot;: 296
  },
  {
    &quot;x&quot;: &quot;Windows 7&quot;,
    &quot;y&quot;: 29
  },
  {
    &quot;x&quot;: &quot;Chrome OS&quot;,
    &quot;y&quot;: 12
  }
]</code></pre>
</figure>


| Field | Description                             |
|-------|-----------------------------------------|
| `x`   | Unique value, depending on metric type. |
| `y`   | Number of visitors.                     |


## <a href="#get-apiwebsiteswebsiteidmetricsexpanded" class="peer" data-card="">GET /api/websites/:websiteId/metrics/expanded</a>

Gets expanded metrics for a given time range.

**Parameters**


| Parameter | Type   | Description                                      |
|-----------|--------|--------------------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date.              |
| `endAt`   | number | Timestamp (in ms) of end date.                   |
| `type`    | string | Metrics type.                                    |
| `filters` | object | Can accept filter parameters.                    |
| `limit`   | number | (optional, default 500) Number of rows returned. |
| `offset`  | number | (optional, default 0) Number of rows to skip.    |


**Available Types**

`path` \| `entry` \| `exit` \| `title` \| `query` \| `referrer` \| `channel` \| `domain` \| `country` \| `region` \| `city` \| `browser` \| `os` \| `device` \| `language` \| `screen` \| `event` \| `hostname` \| `tag` \| `distinctId`

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;name&quot;: &quot;Mac OS&quot;,
    &quot;pageviews&quot;: 74020,
    &quot;visitors&quot;: 16982,
    &quot;visits&quot;: 24770,
    &quot;bounces&quot;: 15033,
    &quot;totaltime&quot;: 149156302
  },
  {
    &quot;name&quot;: &quot;Windows 10&quot;,
    &quot;pageviews&quot;: 52252,
    &quot;visitors&quot;: 12858,
    &quot;visits&quot;: 20089,
    &quot;bounces&quot;: 12720,
    &quot;totaltime&quot;: 137208105
  },
  {
    &quot;name&quot;: &quot;iOS&quot;,
    &quot;pageviews&quot;: 10029,
    &quot;visitors&quot;: 4364,
    &quot;visits&quot;: 5139,
    &quot;bounces&quot;: 3578,
    &quot;totaltime&quot;: 23482267
  },
  {
    &quot;name&quot;: &quot;Android OS&quot;,
    &quot;pageviews&quot;: 8147,
    &quot;visitors&quot;: 3122,
    &quot;visits&quot;: 3854,
    &quot;bounces&quot;: 2610,
    &quot;totaltime&quot;: 20347972
  },
  {
    &quot;name&quot;: &quot;Linux&quot;,
    &quot;pageviews&quot;: 12462,
    &quot;visitors&quot;: 3000,
    &quot;visits&quot;: 4278,
    &quot;bounces&quot;: 2630,
    &quot;totaltime&quot;: 26331069
  }
]</code></pre>
</figure>


| Field       | Description                                      |
|-------------|--------------------------------------------------|
| `name`      | Unique value, depending on metric type.          |
| `pageviews` | Page hits.                                       |
| `visitors`  | Number of unique visitors.                       |
| `visits`    | Number of unique visits.                         |
| `bounces`   | Number of visitors who only visit a single page. |
| `totaltime` | Time spent on the website.                       |


------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidpageviews" class="peer" data-card="">GET /api/websites/:websiteId/pageviews</a>

Gets pageviews within a given time range.

**Parameters**


| Parameter  | Type   | Description                                       |
|------------|--------|---------------------------------------------------|
| `startAt`  | number | Timestamp (in ms) of starting date.               |
| `endAt`    | number | Timestamp (in ms) of end date.                    |
| `unit`     | string | Time unit (`year` \| `month` \| `hour` \| `day`). |
| `timezone` | string | Timezone (ex. America/Los_Angeles).               |
| `compare`  | string | (optional) Comparison period (`prev` \| `yoy`).   |
| `filters`  | object | Can accept filter parameters.                     |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;pageviews&quot;: [
    {
      &quot;x&quot;: &quot;2025-10-19T07:00:00Z&quot;,
      &quot;y&quot;: 4129
    },
    {
      &quot;x&quot;: &quot;2025-10-20T07:00:00Z&quot;,
      &quot;y&quot;: 6105
    },
    {
      &quot;x&quot;: &quot;2025-10-21T07:00:00Z&quot;,
      &quot;y&quot;: 4936
    }
  ],
  &quot;sessions&quot;: [
    {
      &quot;x&quot;: &quot;2025-10-19T07:00:00Z&quot;,
      &quot;y&quot;: 1397
    },
    {
      &quot;x&quot;: &quot;2025-10-20T07:00:00Z&quot;,
      &quot;y&quot;: 1880
    },
    {
      &quot;x&quot;: &quot;2025-10-21T07:00:00Z&quot;,
      &quot;y&quot;: 1469
    }
  ]
}</code></pre>
</figure>

- `x`: Timestamp.
- `y`: Number of pageviews or visitors.

------------------------------------------------------------------------

## <a href="#get-apiwebsiteswebsiteidstats" class="peer" data-card="">GET /api/websites/:websiteId/stats</a>

Gets summarized website statistics.

**Parameters**


| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `filters` | object | Can accept filter parameters.       |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;pageviews&quot;: 15171,
  &quot;visitors&quot;: 4415,
  &quot;visits&quot;: 5680,
  &quot;bounces&quot;: 3567,
  &quot;totaltime&quot;: 809968,
  &quot;comparison&quot;: {
    &quot;pageviews&quot;: 38675,
    &quot;visitors&quot;: 10568,
    &quot;visits&quot;: 14595,
    &quot;bounces&quot;: 9364,
    &quot;totaltime&quot;: 2182387
  }
}</code></pre>
</figure>


| Field       | Description                                      |
|-------------|--------------------------------------------------|
| `pageviews` | Page hits.                                       |
| `visitors`  | Number of unique visitors.                       |
| `visits`    | Number of unique visits.                         |
| `bounces`   | Number of visitors who only visit a single page. |
| `totaltime` | Time spent on the website.                       |


<a href="/docs/api/websites" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Websites


Previous Page

<a href="/docs/api/realtime" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Realtime


Next Page


### On this page


<a href="#filters" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Filters</a><a href="#get-apiwebsiteswebsiteidactive" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/active</a><a href="#get-apiwebsiteswebsiteiddaterange" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/daterange</a><a href="#get-apiwebsiteswebsiteideventsseries" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/events/series</a><a href="#get-apiwebsiteswebsiteidmetrics" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/metrics</a><a href="#get-apiwebsiteswebsiteidmetricsexpanded" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/metrics/expanded</a><a href="#get-apiwebsiteswebsiteidpageviews" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/pageviews</a><a href="#get-apiwebsiteswebsiteidstats" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/websites/:websiteId/stats</a>


