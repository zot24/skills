> Source: https://docs.umami.is/docs/api/events



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Endpoints


# Events


Copy page


Operations around Events and Event data.

**Endpoints**


``` code-block
GET /api/websites/:websiteId/events
GET /api/websites/:websiteId/events/stats
GET /api/websites/:websiteId/event-data
GET /api/websites/:websiteId/event-data/:eventId
GET /api/websites/:websiteId/event-data/events
GET /api/websites/:websiteId/event-data/fields
GET /api/websites/:websiteId/event-data/properties
GET /api/websites/:websiteId/event-data/values
GET /api/websites/:websiteId/event-data/stats
GET /api/websites/:websiteId/event-data-pivot
```


------------------------------------------------------------------------

## Filters<a href="#filters" class="heading-anchor" aria-label="Permalink to “Filters”">#</a>

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

## GET /api/websites/:websiteId/events<a href="#get-apiwebsiteswebsiteidevents" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/events”">#</a>

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


``` code-block
{
  "data": [
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "websiteId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "createdAt": "2025-10-15T16:26:28Z",
      "hostname": "umami.is",
      "urlPath": "/docs/api",
      "urlQuery": "",
      "referrerPath": "",
      "referrerQuery": "",
      "referrerDomain": "",
      "country": "US",
      "city": "Scott",
      "device": "desktop",
      "os": "Mac OS",
      "browser": "chrome",
      "pageTitle": "API – Docs - Umami",
      "eventType": 1,
      "eventName": "",
      "hasData": 0
    },
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "websiteId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "createdAt": "2025-10-15T16:26:23Z",
      "hostname": "umami.is",
      "urlPath": "/docs/sessions",
      "urlQuery": "",
      "referrerPath": "/docs/distinct-ids",
      "referrerQuery": "",
      "referrerDomain": "umami.is",
      "country": "PL",
      "city": "Warsaw",
      "device": "desktop",
      "os": "Mac OS",
      "browser": "chrome",
      "pageTitle": "Sessions – Docs - Umami",
      "eventType": 2,
      "eventName": "login-button-header",
      "hasData": 0
    }
  ],
  "count": 2,
  "page": 1,
  "pageSize": 20
}
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/events/stats<a href="#get-apiwebsiteswebsiteideventsstats" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/events/stats”">#</a>

Gets aggregated event statistics within a given time range, with optional period comparison.

**Parameters**

| Parameter | Type   | Description                                     |
|-----------|--------|-------------------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date.             |
| `endAt`   | number | Timestamp (in ms) of end date.                  |
| `compare` | string | (optional) Comparison period (`prev` \| `yoy`). |
| `filters` | object | (optional) Can accept filter parameters.        |

**Sample response**


``` code-block
{
    "data": {
        "events": 753,
        "visitors": 607,
        "visits": 687,
        "uniqueEvents": 8,
        "comparison": {
            "events": 1809,
            "visitors": 1374,
            "visits": 1655,
            "uniqueEvents": 10
        }
    }
}
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/event-data<a href="#get-apiwebsiteswebsiteidevent-data" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/event-data”">#</a>

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


``` code-block
{
  "data": [
    {
      "websiteId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "eventId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "eventName": "button-click",
      "eventProperties": [
        {
          "dataKey": "id",
          "stringValue": "signup-btn",
          "numberValue": null,
          "dateValue": null,
          "dataType": 1,
          "createdAt": "2025-10-15T16:26:28Z"
        },
        {
          "dataKey": "name",
          "stringValue": "Sign Up",
          "numberValue": null,
          "dateValue": null,
          "dataType": 1,
          "createdAt": "2025-10-15T16:26:28Z"
        }
      ]
    },
    {
      "websiteId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "eventId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "eventName": "revenue-demo",
      "eventProperties": [
        {
          "dataKey": "currency",
          "stringValue": "USD",
          "numberValue": null,
          "dateValue": null,
          "dataType": 1,
          "createdAt": "2025-10-10T12:31:03Z"
        },
        {
          "dataKey": "revenue",
          "stringValue": "40.0000",
          "numberValue": 40,
          "dateValue": null,
          "dataType": 2,
          "createdAt": "2025-10-10T12:31:03Z"
        }
      ]
    }
  ],
  "count": 2,
  "page": 1,
  "pageSize": 20
}
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/event-data/:eventId<a href="#get-apiwebsiteswebsiteidevent-dataeventid" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/event-data/:eventId”">#</a>

Gets event-data for an individual event

**Sample response**


``` code-block
[
  {
    "websiteId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "eventId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "urlPath": "/",
    "eventName": "revenue-demo",
    "dataKey": "currency",
    "stringValue": "USD",
    "numberValue": null,
    "dateValue": null,
    "dataType": 1,
    "createdAt": "2025-10-10T12:31:03Z"
  },
  {
    "websiteId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "eventId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "urlPath": "/",
    "eventName": "revenue-demo",
    "dataKey": "revenue",
    "stringValue": "40.0000",
    "numberValue": 40,
    "dateValue": null,
    "dataType": 2,
    "createdAt": "2025-10-10T12:31:03Z"
  }
]
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/event-data/events<a href="#get-apiwebsiteswebsiteidevent-dataevents" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/event-data/events”">#</a>

Gets event data names, properties, and counts

**Parameters**

| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `event`   | string | (optional) Event name filter.       |
| `filters` | object | Can accept filter parameters.       |

**Sample response**


``` code-block
[
  {
    "eventName": "button-click",
    "propertyName": "id",
    "dataType": 1,
    "total": 4
  },
  {
    "eventName": "button-click",
    "propertyName": "name",
    "dataType": 1,
    "total": 4
  },
  {
    "eventName": "track-product",
    "propertyName": "price",
    "dataType": 2,
    "total": 2
  }
]
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/event-data/fields<a href="#get-apiwebsiteswebsiteidevent-datafields" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/event-data/fields”">#</a>

Gets event data property and value counts within a given time range.

**Parameters**

| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `filters` | object | Can accept filter parameters.       |

**Sample response**


``` code-block
[
  {
    "propertyName": "age",
    "dataType": 2,
    "value": "33",
    "total": 1
  },
  {
    "propertyName": "age",
    "dataType": 2,
    "value": "31",
    "total": 4
  },
  {
    "propertyName": "gender",
    "dataType": 1,
    "value": "female",
    "total": 4
  },
  {
    "propertyName": "gender",
    "dataType": 1,
    "value": "male",
    "total": 1
  }
]
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/event-data/properties<a href="#get-apiwebsiteswebsiteidevent-dataproperties" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/event-data/properties”">#</a>

Gets event name and property counts for a website.

**Parameters**

| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `filters` | object | Can accept filter parameters.       |

**Sample response**


``` code-block
[
  {
    "eventName": "revenue-demo",
    "propertyName": "revenue",
    "total": 122
  },
  {
    "eventName": "revenue-demo",
    "propertyName": "currency",
    "total": 122
  }
]
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/event-data/values<a href="#get-apiwebsiteswebsiteidevent-datavalues" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/event-data/values”">#</a>

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


``` code-block
[
  {
    "value": "Male",
    "total": 28
  },
  {
    "value": "Female",
    "total": 26
  }
]
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/event-data/stats<a href="#get-apiwebsiteswebsiteidevent-datastats" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/event-data/stats”">#</a>

Gets aggregated website events, properties, and records within a given time range.

**Parameters**

| Parameter | Type   | Description                         |
|-----------|--------|-------------------------------------|
| `startAt` | number | Timestamp (in ms) of starting date. |
| `endAt`   | number | Timestamp (in ms) of end date.      |
| `filters` | object | Can accept filter parameters.       |

**Sample response**


``` code-block
[
  {
    "events": 16,
    "properties": 13,
    "records": 26
  }
]
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/event-data-pivot<a href="#get-apiwebsiteswebsiteidevent-data-pivot" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/event-data-pivot”">#</a>

Gets event data for a website in a pivoted format, with each row representing an event and its properties as parallel arrays.

**Parameters**

| Parameter   | Type   | Description                                                   |
|-------------|--------|---------------------------------------------------------------|
| `startAt`   | number | Timestamp (in ms) of starting date.                           |
| `endAt`     | number | Timestamp (in ms) of end date.                                |
| `eventName` | string | Event name to pivot on.                                       |
| `page`      | number | (optional, default 1) Determines page.                        |
| `pageSize`  | number | (optional, default 20) Determines how many results to return. |
| `filters`   | object | Can accept filter parameters.                                 |

**Sample response**


``` code-block
{
  "data": [
    {
      "eventId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "eventName": "signup",
      "urlPath": "/register",
      "createdAt": "2025-10-15T16:26:28Z",
      "propertyKeys": ["plan", "source"],
      "propertyValues": ["pro", "organic"]
    }
  ],
  "count": 100,
  "page": 1,
  "pageSize": 20
}
```


<a href="/docs/api/admin" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Admin</span></span></a><a href="/docs/api/links" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Links</span></span></a>


On this page


