> Source: https://docs.umami.is/docs/api/realtime



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Endpoints


# Realtime


Copy page


Realtime data for your website.

**Endpoints**


``` code-block
GET /api/realtime/:websiteId
```


------------------------------------------------------------------------

## GET /api/realtime/:websiteId<a href="#get-apirealtimewebsiteid" class="heading-anchor" aria-label="Permalink to “GET /api/realtime/:websiteId”">#</a>

Realtime stats within the last 30 minutes.

**Sample response**


``` code-block
{
  "countries": {
    "US": 9,
    "FI": 3,
    "IN": 3,
    "VN": 1,
    "CA": 3,
    "TR": 1
  },
  "urls": {
    "/about": 1,
    "/blog": 4,
    "/blog/what-is-coming-in-umami-v3": 2,
    "/": 43,
    "/pricing": 6,
    "/docs": 4
  },
  "referrers": {
    "umami.is": 31,
    "google.com": 9,
    "analytics.quickcv.io": 1,
    "blog.vrecruiters.in": 2
  },
  "events": [
    {
      "__type": "pageview",
      "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "eventName": "",
      "createdAt": "2025-10-22T00:15:29Z",
      "browser": "chrome",
      "os": "Mac OS",
      "device": "desktop",
      "country": "US",
      "urlPath": "/docs/attribution",
      "referrerDomain": "umami.is"
    },
    {
      "__type": "pageview",
      "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "eventName": "",
      "createdAt": "2025-10-22T00:15:17Z",
      "browser": "chrome",
      "os": "Mac OS",
      "device": "desktop",
      "country": "US",
      "urlPath": "/docs/pixels",
      "referrerDomain": "umami.is"
    }
  ],
  "series": {
    "views": [
      {
        "x": "2025-10-21T23:45:00Z",
        "y": 5
      },
      {
        "x": "2025-10-21T23:46:00Z",
        "y": 7
      }
    ],
    "visitors": [
      {
        "x": "2025-10-21T23:45:00Z",
        "y": 3
      },
      {
        "x": "2025-10-21T23:46:00Z",
        "y": 1
      }
    ]
  },
  "totals": {
    "views": 69,
    "visitors": 42,
    "events": 12,
    "countries": 15
  },
  "timestamp": 1761092151944
}
```


<a href="/docs/api/website-stats" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Website statistics</span></span></a><a href="/docs/api/reports" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Reports</span></span></a>


On this page


