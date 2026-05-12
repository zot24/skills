> Source: https://docs.umami.is/docs/api/realtime



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Realtime


Realtime data for your website.

**Endpoints**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GET /api/realtime/:websiteId</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#get-apirealtimewebsiteid" class="peer" data-card="">GET /api/realtime/:websiteId</a>

Realtime stats within the last 30 minutes.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;countries&quot;: {
    &quot;US&quot;: 9,
    &quot;FI&quot;: 3,
    &quot;IN&quot;: 3,
    &quot;VN&quot;: 1,
    &quot;CA&quot;: 3,
    &quot;TR&quot;: 1
  },
  &quot;urls&quot;: {
    &quot;/about&quot;: 1,
    &quot;/blog&quot;: 4,
    &quot;/blog/what-is-coming-in-umami-v3&quot;: 2,
    &quot;/&quot;: 43,
    &quot;/pricing&quot;: 6,
    &quot;/docs&quot;: 4
  },
  &quot;referrers&quot;: {
    &quot;umami.is&quot;: 31,
    &quot;google.com&quot;: 9,
    &quot;analytics.quickcv.io&quot;: 1,
    &quot;blog.vrecruiters.in&quot;: 2
  },
  &quot;events&quot;: [
    {
      &quot;__type&quot;: &quot;pageview&quot;,
      &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;eventName&quot;: &quot;&quot;,
      &quot;createdAt&quot;: &quot;2025-10-22T00:15:29Z&quot;,
      &quot;browser&quot;: &quot;chrome&quot;,
      &quot;os&quot;: &quot;Mac OS&quot;,
      &quot;device&quot;: &quot;desktop&quot;,
      &quot;country&quot;: &quot;US&quot;,
      &quot;urlPath&quot;: &quot;/docs/attribution&quot;,
      &quot;referrerDomain&quot;: &quot;umami.is&quot;
    },
    {
      &quot;__type&quot;: &quot;pageview&quot;,
      &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
      &quot;eventName&quot;: &quot;&quot;,
      &quot;createdAt&quot;: &quot;2025-10-22T00:15:17Z&quot;,
      &quot;browser&quot;: &quot;chrome&quot;,
      &quot;os&quot;: &quot;Mac OS&quot;,
      &quot;device&quot;: &quot;desktop&quot;,
      &quot;country&quot;: &quot;US&quot;,
      &quot;urlPath&quot;: &quot;/docs/pixels&quot;,
      &quot;referrerDomain&quot;: &quot;umami.is&quot;
    }
  ],
  &quot;series&quot;: {
    &quot;views&quot;: [
      {
        &quot;x&quot;: &quot;2025-10-21T23:45:00Z&quot;,
        &quot;y&quot;: 5
      },
      {
        &quot;x&quot;: &quot;2025-10-21T23:46:00Z&quot;,
        &quot;y&quot;: 7
      }
    ],
    &quot;visitors&quot;: [
      {
        &quot;x&quot;: &quot;2025-10-21T23:45:00Z&quot;,
        &quot;y&quot;: 3
      },
      {
        &quot;x&quot;: &quot;2025-10-21T23:46:00Z&quot;,
        &quot;y&quot;: 1
      }
    ]
  },
  &quot;totals&quot;: {
    &quot;views&quot;: 69,
    &quot;visitors&quot;: 42,
    &quot;events&quot;: 12,
    &quot;countries&quot;: 15
  },
  &quot;timestamp&quot;: 1761092151944
}</code></pre>
</figure>


<a href="/docs/api/website-stats" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Website statistics


Previous Page

<a href="/docs/api/reports" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Reports


Next Page


### On this page


<a href="#get-apirealtimewebsiteid" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">GET /api/realtime/:websiteId</a>


