> Source: https://docs.umami.is/docs/api/reports



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Reports


Using reports through the api.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GET /api/reports
POST /api/reports
GET /api/reports/:reportId
POST /api/reports/:reportId
DELETE /api/reports/:reportId
POST /api/reports/attribution
POST /api/reports/breakdown
POST /api/reports/funnel
POST /api/reports/goal
POST /api/reports/journey
POST /api/reports/performance
POST /api/reports/retention
POST /api/reports/revenue
POST /api/reports/utm</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#filters" class="peer" data-card="">Filters</a>

All reports can now be filtered with the filters property in the request body.


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


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;type&quot;: &quot;attribution&quot;,
  &quot;filters&quot;: { &quot;os&quot;: &quot;Mac OS&quot;, &quot;device&quot;: &quot;desktop&quot; },
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-10-19T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-10-26T06:59:59.999Z&quot;,
    &quot;timezone&quot;: &quot;America/Los_Angeles&quot;,
    &quot;model&quot;: &quot;first-click&quot;,
    &quot;type&quot;: &quot;path&quot;,
    &quot;step&quot;: &quot;/&quot;
  }
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apireports" class="peer" data-card="">GET /api/reports</a>

Get all reports by website ID.

**Parameters**


| Parameter   | Type   | Description                                                                                                         |
|-------------|--------|---------------------------------------------------------------------------------------------------------------------|
| `websiteId` | string | Your website id.                                                                                                    |
| `type`      | string | Report type (`attribution` \| `breakdown` \| `funnel` \| `goal` \| `journey` \| `retention` \| `revenue` \| `utm`). |
| `page`      | number | (optional, default 1) Determines page.                                                                              |
| `pageSize`  | number | (optional) Determines how many results to return.                                                                   |


**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;data&quot;: [
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;type&quot;: &quot;goal&quot;,
      &quot;name&quot;: &quot;Visited /pricing&quot;,
      &quot;description&quot;: &quot;Test&quot;,
      &quot;parameters&quot;: {
        &quot;type&quot;: &quot;path&quot;,
        &quot;value&quot;: &quot;/pricing&quot;
      },
      &quot;createdAt&quot;: &quot;2025-07-23T17:28:55.192Z&quot;,
      &quot;updatedAt&quot;: &quot;2025-10-07T07:46:57.918Z&quot;
    },
    {
      &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;type&quot;: &quot;goal&quot;,
      &quot;name&quot;: &quot;Triggered live-demo-button&quot;,
      &quot;description&quot;: &quot;&quot;,
      &quot;parameters&quot;: {
        &quot;type&quot;: &quot;event&quot;,
        &quot;value&quot;: &quot;live-demo-button&quot;
      },
      &quot;createdAt&quot;: &quot;2025-10-07T07:46:24.120Z&quot;,
      &quot;updatedAt&quot;: &quot;2025-10-07T07:46:24.120Z&quot;
    }
  ],
  &quot;count&quot;: 2,
  &quot;page&quot;: 1,
  &quot;pageSize&quot;: 20
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireports" class="peer" data-card="">POST /api/reports</a>

Creates a report.

**Parameters**


| Parameter     | Type   | Description                                                                                                         |
|---------------|--------|---------------------------------------------------------------------------------------------------------------------|
| `websiteId`   | string | Your website id.                                                                                                    |
| `type`        | string | Report type (`attribution` \| `breakdown` \| `funnel` \| `goal` \| `journey` \| `retention` \| `revenue` \| `utm`). |
| `name`        | string | Name of report.                                                                                                     |
| `description` | string | (optional) Description of report.                                                                                   |
| `parameters`  | object | Parameters for report.                                                                                              |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;name&quot;: &quot;Triggered Login-button &quot;,
  &quot;parameters&quot;: { &quot;type&quot;: &quot;event&quot;, &quot;value&quot;: &quot;login-button-header&quot; },
  &quot;type&quot;: &quot;goal&quot;,
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;type&quot;: &quot;goal&quot;,
  &quot;name&quot;: &quot;Triggered Login-button &quot;,
  &quot;description&quot;: &quot;&quot;,
  &quot;parameters&quot;: {
    &quot;type&quot;: &quot;event&quot;,
    &quot;value&quot;: &quot;login-button-header&quot;
  },
  &quot;createdAt&quot;: &quot;2025-10-14T00:12:33.203Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-10-14T00:12:33.203Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apireportsreportid" class="peer" data-card="">GET /api/reports/:reportId</a>

Gets a report by ID.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;type&quot;: &quot;goal&quot;,
  &quot;name&quot;: &quot;Triggered Login-button &quot;,
  &quot;description&quot;: &quot;&quot;,
  &quot;parameters&quot;: {
    &quot;type&quot;: &quot;event&quot;,
    &quot;value&quot;: &quot;login-button-header&quot;
  },
  &quot;createdAt&quot;: &quot;2025-10-14T00:12:33.203Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-10-14T00:12:33.203Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsreportid" class="peer" data-card="">POST /api/reports/:reportId</a>

Updates a report.

**Parameters**


| Parameter     | Type   | Description                                                                                                         |
|---------------|--------|---------------------------------------------------------------------------------------------------------------------|
| `websiteId`   | string | Your website id.                                                                                                    |
| `type`        | string | Report type (`attribution` \| `breakdown` \| `funnel` \| `goal` \| `journey` \| `retention` \| `revenue` \| `utm`). |
| `name`        | string | Name of report.                                                                                                     |
| `description` | string | (optional) Description of report.                                                                                   |
| `parameters`  | object | Parameters for report.                                                                                              |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;name&quot;: &quot;Triggered Login-button &quot;,
  &quot;parameters&quot;: { &quot;type&quot;: &quot;event&quot;, &quot;value&quot;: &quot;login-button-header&quot; },
  &quot;type&quot;: &quot;goal&quot;,
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;userId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;type&quot;: &quot;goal&quot;,
  &quot;name&quot;: &quot;Triggered Login-button &quot;,
  &quot;description&quot;: &quot;&quot;,
  &quot;parameters&quot;: {
    &quot;type&quot;: &quot;event&quot;,
    &quot;value&quot;: &quot;login-button-header&quot;
  },
  &quot;createdAt&quot;: &quot;2025-10-14T00:12:33.203Z&quot;,
  &quot;updatedAt&quot;: &quot;2025-10-14T00:12:33.203Z&quot;
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#delete-apireportsreportid" class="peer" data-card="">DELETE /api/reports/:reportId</a>

Deletes a report.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;ok&quot;: true
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsattribution" class="peer" data-card="">POST /api/reports/attribution</a>

See how users engage with your marketing and what drives conversions.

**Parameters**


| Parameter   | Type   | Description                                      |
|-------------|--------|--------------------------------------------------|
| `websiteId` | string | Your website id.                                 |
| `type`      | string | Report type (`attribution`).                     |
| `filters`   | object | Can accept filter parameters.                    |
| `startDate` | string | Start date.                                      |
| `endDate`   | string | End date.                                        |
| `model`     | string | Attribution model (`firstClick` \| `lastClick`). |
| `type`      | string | Conversion type (`path` \| `event`).             |
| `step`      | string | Conversion step.                                 |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;type&quot;: &quot;attribution&quot;,
  &quot;filters&quot;: { &quot;os&quot;: &quot;Mac OS&quot; },
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-10-19T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-10-26T06:59:59.999Z&quot;,
    &quot;model&quot;: &quot;first-click&quot;,
    &quot;type&quot;: &quot;path&quot;,
    &quot;step&quot;: &quot;/&quot;
  }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;referrer&quot;: [
    {
      &quot;name&quot;: &quot;google.com&quot;,
      &quot;value&quot;: 30082
    },
    {
      &quot;name&quot;: &quot;chatgpt.com&quot;,
      &quot;value&quot;: 1672
    }
  ],
  &quot;paidAds&quot;: [
    {
      &quot;name&quot;: &quot;Facebook / Meta&quot;,
      &quot;value&quot;: 106
    },
    {
      &quot;name&quot;: &quot;Google Ads&quot;,
      &quot;value&quot;: 6
    }
  ],
  &quot;utm_source&quot;: [
    {
      &quot;name&quot;: &quot;coolify.io&quot;,
      &quot;value&quot;: 465
    },
    {
      &quot;name&quot;: &quot;chatgpt.com&quot;,
      &quot;value&quot;: 338
    }
  ],
  &quot;utm_medium&quot;: [
    {
      &quot;name&quot;: &quot;referral&quot;,
      &quot;value&quot;: 75
    },
    {
      &quot;name&quot;: &quot;email&quot;,
      &quot;value&quot;: 16
    }
  ],
  &quot;utm_campaign&quot;: [
    {
      &quot;name&quot;: &quot;navigation&quot;,
      &quot;value&quot;: 60
    },
    {
      &quot;name&quot;: &quot;website_analytics&quot;,
      &quot;value&quot;: 8
    }
  ],
  &quot;utm_content&quot;: [
    {
      &quot;name&quot;: &quot;comparison-page&quot;,
      &quot;value&quot;: 1
    },
    {
      &quot;name&quot;: &quot;sidebar-cta&quot;,
      &quot;value&quot;: 1
    }
  ],
  &quot;utm_term&quot;: [
    {
      &quot;name&quot;: &quot;data analysis&quot;,
      &quot;value&quot;: 1
    },
    {
      &quot;name&quot;: &quot;0_df65b6d7c8-e2c14ebdc7-59136105&quot;,
      &quot;value&quot;: 1
    }
  ],
  &quot;total&quot;: {
    &quot;pageviews&quot;: 171481,
    &quot;visitors&quot;: 104727,
    &quot;visits&quot;: 138391
  }
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsbreakdown" class="peer" data-card="">POST /api/reports/breakdown</a>

Dive deeper into your data by using segments and filters.

**Parameters**


| Parameter   | Type   | Description                   |
|-------------|--------|-------------------------------|
| `websiteId` | string | Your website id.              |
| `type`      | string | Report type (`breakdown`).    |
| `filters`   | object | Can accept filter parameters. |
| `startDate` | string | Start date.                   |
| `endDate`   | string | End date.                     |
| `fields`    | array  | List of column fields.        |


**Available Fields**

`path` \| `title` \| `query` \| `referrer` \| `browser` \| `os` \| `device` \| `country` \| `region` \| `city` \| `hostname` \| `tag` \| `event` \| `distinctId` \| `utmSource` \| `utmMedium` \| `utmCampaign` \| `utmContent` \| `utmTerm` \|

**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;type&quot;: &quot;breakdown&quot;,
  &quot;filters&quot;: {},
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-07-23T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-10-22T06:59:59.999Z&quot;,
    &quot;fields&quot;: [&quot;os&quot;, &quot;country&quot;]
  }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;views&quot;: 37856,
    &quot;visitors&quot;: 9229,
    &quot;visits&quot;: 13145,
    &quot;bounces&quot;: 8105,
    &quot;totaltime&quot;: 12985151,
    &quot;os&quot;: &quot;Mac OS&quot;,
    &quot;country&quot;: &quot;US&quot;
  },
  {
    &quot;views&quot;: 24399,
    &quot;visitors&quot;: 6628,
    &quot;visits&quot;: 10673,
    &quot;bounces&quot;: 7119,
    &quot;totaltime&quot;: 21398417,
    &quot;os&quot;: &quot;Windows 10&quot;,
    &quot;country&quot;: &quot;US&quot;
  },
  {
    &quot;views&quot;: 21561,
    &quot;visitors&quot;: 4916,
    &quot;visits&quot;: 6532,
    &quot;bounces&quot;: 3452,
    &quot;totaltime&quot;: 22984512,
    &quot;os&quot;: &quot;Mac OS&quot;,
    &quot;country&quot;: &quot;DE&quot;
  },
  {
    &quot;views&quot;: 12977,
    &quot;visitors&quot;: 2976,
    &quot;visits&quot;: 4180,
    &quot;bounces&quot;: 2440,
    &quot;totaltime&quot;: 9962317,
    &quot;os&quot;: &quot;Windows 10&quot;,
    &quot;country&quot;: &quot;DE&quot;
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsfunnel" class="peer" data-card="">POST /api/reports/funnel</a>

Understand the conversion and drop-off rate of users.

**Parameters**


| Parameter   | Type   | Description                                                                     |
|-------------|--------|---------------------------------------------------------------------------------|
| `websiteId` | string | Your website id.                                                                |
| `type`      | string | Report type (`funnel`).                                                         |
| `filters`   | object | Can accept filter parameters.                                                   |
| `startDate` | string | Start date.                                                                     |
| `endDate`   | string | End date.                                                                       |
| `steps`     | array  | Minimum two required. Each step has a `type` (`path` \| `event`) and a `value`. |
| `window`    | number | Window of days between funnel steps to be considered a conversion.              |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;type&quot;: &quot;funnel&quot;,
  &quot;filters&quot;: {},
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-07-23T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-10-22T06:59:59.999Z&quot;,
    &quot;steps&quot;: [
      { &quot;type&quot;: &quot;path&quot;, &quot;value&quot;: &quot;/&quot; },
      { &quot;type&quot;: &quot;event&quot;, &quot;value&quot;: &quot;live-demo-button&quot; }
    ],
    &quot;window&quot;: 60
  }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;type&quot;: &quot;path&quot;,
    &quot;value&quot;: &quot;/&quot;,
    &quot;visitors&quot;: 106594,
    &quot;previous&quot;: 0,
    &quot;dropped&quot;: 0,
    &quot;dropoff&quot;: null,
    &quot;remaining&quot;: 1
  },
  {
    &quot;type&quot;: &quot;event&quot;,
    &quot;value&quot;: &quot;live-demo-button&quot;,
    &quot;visitors&quot;: 10269,
    &quot;previous&quot;: 106594,
    &quot;dropped&quot;: 96325,
    &quot;dropoff&quot;: 0.9036624950747697,
    &quot;remaining&quot;: 0.09633750492523031
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsgoal" class="peer" data-card="">POST /api/reports/goal</a>

Track your goals for pageviews and events.

**Parameters**


| Parameter   | Type   | Description                          |
|-------------|--------|--------------------------------------|
| `websiteId` | string | Your website id.                     |
| `type`      | string | Report type (`goal`).                |
| `filters`   | object | Can accept filter parameters.        |
| `startDate` | string | Start date.                          |
| `endDate`   | string | End date.                            |
| `type`      | string | Conversion type (`path` \| `event`). |
| `value`     | string | Conversion step value.               |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;type&quot;: &quot;goal&quot;,
  &quot;filters&quot;: {},
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-07-23T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-10-22T06:59:59.999Z&quot;,
    &quot;type&quot;: &quot;event&quot;,
    &quot;value&quot;: &quot;live-demo-button&quot;
  }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;num&quot;: 11935,
  &quot;total&quot;: 50602
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsjourney" class="peer" data-card="">POST /api/reports/journey</a>

Understand how users navigate through your website.

**Parameters**


| Parameter   | Type   | Description                               |
|-------------|--------|-------------------------------------------|
| `websiteId` | string | Your website id.                          |
| `type`      | string | Report type (`journey`).                  |
| `filters`   | object | Can accept filter parameters.             |
| `startDate` | string | Start date.                               |
| `endDate`   | string | End date.                                 |
| `steps`     | number | Number of steps from 3 to 7.              |
| `startStep` | string | Starting step URL or event name.          |
| `endStep`   | string | (optional) Ending step URL or event name. |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;86d4095c-a2a8-4fc8-9521-103e858e2b41&quot;,
  &quot;type&quot;: &quot;journey&quot;,
  &quot;filters&quot;: {},
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-07-23T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-10-22T06:59:59.999Z&quot;,
    &quot;steps&quot;: 3,
    &quot;startStep&quot;: &quot;/&quot;,
    &quot;endStep&quot;: &quot;/pricing&quot;
  }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;items&quot;: [&quot;/&quot;, &quot;/pricing&quot;, null, null],
    &quot;count&quot;: 6433
  },
  {
    &quot;items&quot;: [&quot;/&quot;, &quot;live-demo-button&quot;, &quot;/pricing&quot;, null],
    &quot;count&quot;: 918
  },
  {
    &quot;items&quot;: [&quot;/&quot;, &quot;/features&quot;, &quot;/pricing&quot;, null],
    &quot;count&quot;: 857
  },
  {
    &quot;items&quot;: [&quot;/&quot;, &quot;/pricing&quot;, null],
    &quot;count&quot;: 434
  },
  {
    &quot;items&quot;: [&quot;/&quot;, &quot;/pricing&quot;, null],
    &quot;count&quot;: 306
  },
  {
    &quot;items&quot;: [&quot;/&quot;, &quot;/docs&quot;, &quot;/pricing&quot;, null],
    &quot;count&quot;: 257
  },
  {
    &quot;items&quot;: [&quot;/&quot;, &quot;get-started-button&quot;, &quot;/pricing&quot;, null],
    &quot;count&quot;: 237
  },
  {
    &quot;items&quot;: [&quot;/&quot;, &quot;login-button-header&quot;, &quot;/pricing&quot;, null],
    &quot;count&quot;: 102
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsperformance" class="peer" data-card="">POST /api/reports/performance</a>

Get Core Web Vitals performance metrics for a given date range.

**Parameters**


| Parameter   | Type   | Description                                                                 |
|-------------|--------|-----------------------------------------------------------------------------|
| `websiteId` | string | Your website id.                                                            |
| `type`      | string | Report type (`performance`).                                                |
| `filters`   | object | Can accept filter parameters.                                               |
| `startDate` | string | Start date.                                                                 |
| `endDate`   | string | End date.                                                                   |
| `unit`      | string | (optional) Time unit (`year` \| `month` \| `hour` \| `day`).                |
| `timezone`  | string | (optional) Timezone (ex. America/Los_Angeles).                              |
| `metric`    | string | (optional) Metric to focus on (`lcp` \| `inp` \| `cls` \| `fcp` \| `ttfb`). |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;type&quot;: &quot;performance&quot;,
  &quot;filters&quot;: {},
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-10-01T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-10-22T06:59:59.999Z&quot;,
    &quot;timezone&quot;: &quot;America/Los_Angeles&quot;,
    &quot;metric&quot;: &quot;lcp&quot;
  }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;chart&quot;: [
        {
            &quot;t&quot;: &quot;2026-03-11T16:00:00Z&quot;,
            &quot;p50&quot;: 24748,
            &quot;p75&quot;: 24748,
            &quot;p95&quot;: 24748
        },
        {
            &quot;t&quot;: &quot;2026-03-11T17:00:00Z&quot;,
            &quot;p50&quot;: 920,
            &quot;p75&quot;: 920,
            &quot;p95&quot;: 920
        },
        {
            &quot;t&quot;: &quot;2026-03-11T21:00:00Z&quot;,
            &quot;p50&quot;: 1408,
            &quot;p75&quot;: 1408,
            &quot;p95&quot;: 1408
        }
    ],
    &quot;summary&quot;: {
        &quot;lcp&quot;: {
            &quot;p50&quot;: 1408,
            &quot;p75&quot;: 13078,
            &quot;p95&quot;: 22413.9
        },
        &quot;inp&quot;: {
            &quot;p50&quot;: 48,
            &quot;p75&quot;: 56,
            &quot;p95&quot;: 86.3
        },
        &quot;cls&quot;: {
            &quot;p50&quot;: 0.0015,
            &quot;p75&quot;: 0.0067,
            &quot;p95&quot;: 0.0231
        },
        &quot;fcp&quot;: {
            &quot;p50&quot;: 720,
            &quot;p75&quot;: 10264,
            &quot;p95&quot;: 17899.1
        },
        &quot;ttfb&quot;: {
            &quot;p50&quot;: 274.7,
            &quot;p75&quot;: 9062.2,
            &quot;p95&quot;: 16092.2
        },
        &quot;count&quot;: 28
    },
    &quot;pages&quot;: [
        {
            &quot;name&quot;: &quot;/analytics/websites&quot;,
            &quot;p50&quot;: 1408,
            &quot;p75&quot;: 1408,
            &quot;p95&quot;: 1408,
            &quot;count&quot;: 1
        },
    ],
    &quot;pageTitles&quot;: [
        {
            &quot;name&quot;: &quot;Websites | Umami&quot;,
            &quot;p50&quot;: 1408,
            &quot;p75&quot;: 13078,
            &quot;p95&quot;: 22413.9,
            &quot;count&quot;: 8
        },
        {
            &quot;name&quot;: &quot;Pixels | Umami&quot;,
            &quot;p50&quot;: null,
            &quot;p75&quot;: null,
            &quot;p95&quot;: null,
            &quot;count&quot;: 2
        },
        {
            &quot;name&quot;: &quot;Settings | Umami&quot;,
            &quot;p50&quot;: null,
            &quot;p75&quot;: null,
            &quot;p95&quot;: null,
            &quot;count&quot;: 1
        },
        {
            &quot;name&quot;: &quot;Board | Umami&quot;,
            &quot;p50&quot;: null,
            &quot;p75&quot;: null,
            &quot;p95&quot;: null,
            &quot;count&quot;: 6
        },
        {
            &quot;name&quot;: &quot;Links | Umami&quot;,
            &quot;p50&quot;: null,
            &quot;p75&quot;: null,
            &quot;p95&quot;: null,
            &quot;count&quot;: 2
        },
        {
            &quot;name&quot;: &quot;Boards | Umami&quot;,
            &quot;p50&quot;: null,
            &quot;p75&quot;: null,
            &quot;p95&quot;: null,
            &quot;count&quot;: 2
        },
        {
            &quot;name&quot;: &quot;Design Board | Umami&quot;,
            &quot;p50&quot;: null,
            &quot;p75&quot;: null,
            &quot;p95&quot;: null,
            &quot;count&quot;: 3
        },
        {
            &quot;name&quot;: &quot;Edit Link | Umami&quot;,
            &quot;p50&quot;: null,
            &quot;p75&quot;: null,
            &quot;p95&quot;: null,
            &quot;count&quot;: 1
        },
        {
            &quot;name&quot;: &quot;Edit Pixel | Umami&quot;,
            &quot;p50&quot;: null,
            &quot;p75&quot;: null,
            &quot;p95&quot;: null,
            &quot;count&quot;: 1
        },
        {
            &quot;name&quot;: &quot;Edit Board | Umami&quot;,
            &quot;p50&quot;: null,
            &quot;p75&quot;: null,
            &quot;p95&quot;: null,
            &quot;count&quot;: 2
        }
    ],
    &quot;devices&quot;: [
        {
            &quot;name&quot;: &quot;laptop&quot;,
            &quot;p50&quot;: 12834,
            &quot;p75&quot;: 18791,
            &quot;p95&quot;: 23556.6,
            &quot;count&quot;: 27
        },
        {
            &quot;name&quot;: &quot;desktop&quot;,
            &quot;p50&quot;: 1408,
            &quot;p75&quot;: 1408,
            &quot;p95&quot;: 1408,
            &quot;count&quot;: 1
        }
    ],
    &quot;browsers&quot;: [
        {
            &quot;name&quot;: &quot;chrome&quot;,
            &quot;p50&quot;: 1408,
            &quot;p75&quot;: 13078,
            &quot;p95&quot;: 22413.9,
            &quot;count&quot;: 28
        }
    ]
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsretention" class="peer" data-card="">POST /api/reports/retention</a>

Measure your website stickiness by tracking how often users return.

**Parameters**


| Parameter   | Type   | Description                         |
|-------------|--------|-------------------------------------|
| `websiteId` | string | Your website id.                    |
| `type`      | string | Report type (`retention`).          |
| `filters`   | object | Can accept filter parameters.       |
| `startDate` | string | Start date.                         |
| `endDate`   | string | End date.                           |
| `timezone`  | string | Timezone (ex. America/Los_Angeles). |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;86d4095c-a2a8-4fc8-9521-103e858e2b41&quot;,
  &quot;type&quot;: &quot;retention&quot;,
  &quot;filters&quot;: {},
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-10-01T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-11-01T06:59:59.999Z&quot;,
    &quot;timezone&quot;: &quot;America/Los_Angeles&quot;
  }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>[
  {
    &quot;date&quot;: &quot;2025-10-01T07:00:00Z&quot;,
    &quot;day&quot;: 0,
    &quot;visitors&quot;: 1499,
    &quot;returnVisitors&quot;: 1499,
    &quot;percentage&quot;: 100
  },
  {
    &quot;date&quot;: &quot;2025-10-01T07:00:00Z&quot;,
    &quot;day&quot;: 1,
    &quot;visitors&quot;: 1499,
    &quot;returnVisitors&quot;: 151,
    &quot;percentage&quot;: 10.073382254836558
  },
  {
    &quot;date&quot;: &quot;2025-10-01T07:00:00Z&quot;,
    &quot;day&quot;: 2,
    &quot;visitors&quot;: 1499,
    &quot;returnVisitors&quot;: 83,
    &quot;percentage&quot;: 5.537024683122081
  },
  {
    &quot;date&quot;: &quot;2025-10-01T07:00:00Z&quot;,
    &quot;day&quot;: 3,
    &quot;visitors&quot;: 1499,
    &quot;returnVisitors&quot;: 45,
    &quot;percentage&quot;: 3.002001334222815
  }
]</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsrevenue" class="peer" data-card="">POST /api/reports/revenue</a>

Get currency for given range. Needed for Revenue and optional in Attribution reports.

**Parameters**


| Parameter   | Type   | Description                                     |
|-------------|--------|-------------------------------------------------|
| `websiteId` | string | Your website id.                                |
| `type`      | string | Report type (`revenue`).                        |
| `filters`   | object | Can accept filter parameters.                   |
| `startDate` | string | Start date.                                     |
| `endDate`   | string | End date.                                       |
| `timezone`  | string | Timezone (ex. America/Los_Angeles).             |
| `currency`  | string | Currency code (ISO 4217).                       |
| `compare`   | string | (optional) Comparison period (`prev` \| `yoy`). |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;86d4095c-a2a8-4fc8-9521-103e858e2b41&quot;,
  &quot;type&quot;: &quot;revenue&quot;,
  &quot;filters&quot;: {},
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-07-23T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-10-22T06:59:59.999Z&quot;,
    &quot;timezone&quot;: &quot;America/Los_Angeles&quot;,
    &quot;currency&quot;: &quot;USD&quot;
  }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
    &quot;chart&quot;: [
        {
            &quot;x&quot;: &quot;revenue-demo&quot;,
            &quot;t&quot;: &quot;2026-03-11T08:00:00Z&quot;,
            &quot;y&quot;: 70,
            &quot;count&quot;: 2
        },
        {
            &quot;x&quot;: &quot;revenue-demo&quot;,
            &quot;t&quot;: &quot;2026-03-11T09:00:00Z&quot;,
            &quot;y&quot;: 40,
            &quot;count&quot;: 2
        },
        {
            &quot;x&quot;: &quot;revenue-demo&quot;,
            &quot;t&quot;: &quot;2026-03-11T10:00:00Z&quot;,
            &quot;y&quot;: 80,
            &quot;count&quot;: 2
        },
        {
            &quot;x&quot;: &quot;revenue-demo&quot;,
            &quot;t&quot;: &quot;2026-03-11T11:00:00Z&quot;,
            &quot;y&quot;: 70,
            &quot;count&quot;: 2
        },
        {
            &quot;x&quot;: &quot;revenue-demo&quot;,
            &quot;t&quot;: &quot;2026-03-11T12:00:00Z&quot;,
            &quot;y&quot;: 50,
            &quot;count&quot;: 3
        },
        {
            &quot;x&quot;: &quot;revenue-demo&quot;,
            &quot;t&quot;: &quot;2026-03-11T13:00:00Z&quot;,
            &quot;y&quot;: 10,
            &quot;count&quot;: 1
        }
    ],
    &quot;total&quot;: {
        &quot;sum&quot;: 320,
        &quot;count&quot;: 12,
        &quot;unique_count&quot;: 12,
        &quot;total_sessions&quot;: 1300,
        &quot;average&quot;: 26.666666666666668,
        &quot;arpu&quot;: 0.24615384615384617,
        &quot;comparison&quot;: {
            &quot;sum&quot;: 2470,
            &quot;count&quot;: 66,
            &quot;unique_count&quot;: 66,
            &quot;total_sessions&quot;: 2994,
            &quot;average&quot;: 37.42424242424242,
            &quot;arpu&quot;: 0.8249832999331997
        }
    },
    &quot;country&quot;: [
        {
            &quot;name&quot;: &quot;GB&quot;,
            &quot;value&quot;: 100
        },
        {
            &quot;name&quot;: &quot;FR&quot;,
            &quot;value&quot;: 100
        },
        {
            &quot;name&quot;: &quot;DE&quot;,
            &quot;value&quot;: 60
        },
        {
            &quot;name&quot;: &quot;US&quot;,
            &quot;value&quot;: 40
        },
        {
            &quot;name&quot;: &quot;CN&quot;,
            &quot;value&quot;: 20
        }
    ],
    &quot;region&quot;: [
        {
            &quot;country&quot;: &quot;FR&quot;,
            &quot;name&quot;: &quot;FR-IDF&quot;,
            &quot;value&quot;: 100
        },
        {
            &quot;country&quot;: &quot;GB&quot;,
            &quot;name&quot;: &quot;GB-ENG&quot;,
            &quot;value&quot;: 100
        },
        {
            &quot;country&quot;: &quot;DE&quot;,
            &quot;name&quot;: &quot;DE-HE&quot;,
            &quot;value&quot;: 60
        },
        {
            &quot;country&quot;: &quot;US&quot;,
            &quot;name&quot;: &quot;US-CA&quot;,
            &quot;value&quot;: 40
        },
        {
            &quot;country&quot;: &quot;CN&quot;,
            &quot;name&quot;: &quot;CN-GD&quot;,
            &quot;value&quot;: 20
        }
    ],
    &quot;referrer&quot;: [
        {
            &quot;name&quot;: &quot;chatgpt.com&quot;,
            &quot;value&quot;: 100
        },
        {
            &quot;name&quot;: &quot;github.com&quot;,
            &quot;value&quot;: 100
        },
        {
            &quot;name&quot;: &quot;google.com&quot;,
            &quot;value&quot;: 60
        },
        {
            &quot;name&quot;: &quot;reddit.com&quot;,
            &quot;value&quot;: 60
        }
    ],
    &quot;channel&quot;: [
        {
            &quot;name&quot;: &quot;referral&quot;,
            &quot;value&quot;: 100
        },
        {
            &quot;name&quot;: &quot;organicSearch&quot;,
            &quot;value&quot;: 100
        },
        {
            &quot;name&quot;: &quot;paidSearch&quot;,
            &quot;value&quot;: 60
        },
        {
            &quot;name&quot;: &quot;organicSocial&quot;,
            &quot;value&quot;: 60
        }
    ]
}</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#post-apireportsutm" class="peer" data-card="">POST /api/reports/utm</a>

Track your campaigns through UTM parameters.

**Parameters**


| Parameter   | Type   | Description                   |
|-------------|--------|-------------------------------|
| `websiteId` | string | Your website id.              |
| `type`      | string | Report type (`utm`).          |
| `filters`   | object | Can accept filter parameters. |
| `startDate` | string | Start date.                   |
| `endDate`   | string | End date.                     |


**Request body**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;websiteId&quot;: &quot;86d4095c-a2a8-4fc8-9521-103e858e2b41&quot;,
  &quot;type&quot;: &quot;utm&quot;,
  &quot;filters&quot;: {},
  &quot;parameters&quot;: {
    &quot;startDate&quot;: &quot;2025-10-14T07:00:00.000Z&quot;,
    &quot;endDate&quot;: &quot;2025-10-22T06:59:59.999Z&quot;
  }
}</code></pre>
</figure>

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;utm_source&quot;: [
    {
      &quot;utm&quot;: &quot;chatgpt.com&quot;,
      &quot;views&quot;: 341
    },
    {
      &quot;utm&quot;: &quot;coolify.io&quot;,
      &quot;views&quot;: 235
    },
    {
      &quot;utm&quot;: &quot;openalternative.co&quot;,
      &quot;views&quot;: 89
    },
    {
      &quot;utm&quot;: &quot;facebook&quot;,
      &quot;views&quot;: 28
    }
  ],
  &quot;utm_medium&quot;: [
    {
      &quot;utm&quot;: &quot;cpc&quot;,
      &quot;views&quot;: 28
    },
    {
      &quot;utm&quot;: &quot;referral&quot;,
      &quot;views&quot;: 26
    }
  ],
  &quot;utm_campaign&quot;: [
    {
      &quot;utm&quot;: &quot;website_analytics&quot;,
      &quot;views&quot;: 28
    },
    {
      &quot;utm&quot;: &quot;navigation&quot;,
      &quot;views&quot;: 16
    }
  ],
  &quot;utm_term&quot;: [
    {
      &quot;utm&quot;: &quot;0_df65b6d7c8-e2c14ebdc7-59136105&quot;,
      &quot;views&quot;: 1
    }
  ],
  &quot;utm_content&quot;: [
    {
      &quot;utm&quot;: &quot;comparison-page&quot;,
      &quot;views&quot;: 1
    },
    {
      &quot;utm&quot;: &quot;sidebar-cta&quot;,
      &quot;views&quot;: 1
    }
  ]
}</code></pre>
</figure>


<a href="/docs/api/realtime" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Realtime


Previous Page

<a href="/docs/api/sessions" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Sessions


Next Page


### On this page


<a href="#filters" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Filters</a><a href="#get-apireports" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/reports</a><a href="#post-apireports" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports</a><a href="#get-apireportsreportid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/reports/:reportId</a><a href="#post-apireportsreportid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/:reportId</a><a href="#delete-apireportsreportid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">DELETE /api/reports/:reportId</a><a href="#post-apireportsattribution" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/attribution</a><a href="#post-apireportsbreakdown" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/breakdown</a><a href="#post-apireportsfunnel" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/funnel</a><a href="#post-apireportsgoal" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/goal</a><a href="#post-apireportsjourney" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/journey</a><a href="#post-apireportsperformance" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/performance</a><a href="#post-apireportsretention" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/retention</a><a href="#post-apireportsrevenue" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/revenue</a><a href="#post-apireportsutm" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/reports/utm</a>


