> Source: https://docs.umami.is/docs/api/share



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Endpoints


# Share


Copy page


Operations around Share page management.

**Endpoints**


``` code-block
POST /api/share
GET /api/share/id/:shareId
POST /api/share/id/:shareId
DELETE /api/share/id/:shareId
GET /api/websites/:websiteId/shares
POST /api/websites/:websiteId/shares
```


------------------------------------------------------------------------

## POST /api/share<a href="#post-apishare" class="heading-anchor" aria-label="Permalink to “POST /api/share”">#</a>

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


``` code-block
{
    "entityId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "shareType": 1,
    "name": "My Share Page",
    "slug": "abc123defg",
    "parameters": { "overview": true, "events": true}
}
```


**Sample response**


``` code-block
{
    "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "entityId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "name": "My Share Page",
    "shareType": 1,
    "slug": "abc123defg",
    "parameters": {
        "events": true,
        "overview": true
    },
    "createdAt": "2026-01-30T06:03:51.718Z",
    "updatedAt": "2026-01-30T06:03:51.718Z"
}
```


------------------------------------------------------------------------

## GET /api/share/id/:shareId<a href="#get-apishareidshareid" class="heading-anchor" aria-label="Permalink to “GET /api/share/id/:shareId”">#</a>

Gets a share page by ID.

**Sample response**


``` code-block
{
    "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "entityId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "name": "My Share Page",
    "shareType": 1,
    "slug": "abc123defg",
    "parameters": {
        "events": true,
        "overview": true
    },
    "createdAt": "2026-01-30T06:03:51.718Z",
    "updatedAt": "2026-01-30T06:06:32.197Z"
}
```


------------------------------------------------------------------------

## POST /api/share/id/:shareId<a href="#post-apishareidshareid" class="heading-anchor" aria-label="Permalink to “POST /api/share/id/:shareId”">#</a>

Updates a share page.

**Parameters**

| Parameter    | Type   | Description                |
|--------------|--------|----------------------------|
| `name`       | string | Name of the share page.    |
| `slug`       | string | Slug of the share page.    |
| `parameters` | object | Parameters for share page. |

**Request body**


``` code-block
{
    "name": "My Updated Share Page",
    "slug": "abc123defg",
    "parameters": { "overview": true, "events": true, "funnel": true, "utm": true}
}
```


**Sample response**


``` code-block
{
    "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "entityId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "name": "My Updated Share Page",
    "shareType": 1,
    "slug": "abc123defg",
    "parameters": {
        "utm": true,
        "events": true,
        "funnel": true,
        "overview": true
    },
    "createdAt": "2026-01-30T06:03:51.718Z",
    "updatedAt": "2026-01-30T06:09:05.640Z"
}
```


------------------------------------------------------------------------

## DELETE /api/share/id/:shareId<a href="#delete-apishareidshareid" class="heading-anchor" aria-label="Permalink to “DELETE /api/share/id/:shareId”">#</a>

Deletes a share page.

**Sample response**


``` code-block
{
  "ok": true
}
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/shares<a href="#get-apiwebsiteswebsiteidshares" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/shares”">#</a>

Gets all share pages that belong to a website.

**Sample response**


``` code-block
{
    "data": [
        {
            "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "entityId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "name": "Umami Live Demo",
            "shareType": 1,
            "slug": "xxxxxxxxxxxxxx",
            "parameters": {
                "utm": false,
                "goals": true,
                "events": true,
                "compare": false,
                "funnels": true,
                "revenue": false,
                "journeys": false,
                "overview": true,
                "realtime": false,
                "sessions": true,
                "breakdown": false,
                "retention": false,
                "attribution": false
            },
            "createdAt": "2026-01-29T18:51:40.489Z",
            "updatedAt": "2026-01-29T18:51:40.489Z"
        }
    ],
    "count": 1,
    "page": 1,
    "pageSize": 20
}
```


------------------------------------------------------------------------

## POST /api/websites/:websiteId/shares<a href="#post-apiwebsiteswebsiteidshares" class="heading-anchor" aria-label="Permalink to “POST /api/websites/:websiteId/shares”">#</a>

Creates a share page belonging to a website.

**Parameters**

| Parameter    | Type   | Description                |
|--------------|--------|----------------------------|
| `name`       | string | Name of the share page.    |
| `parameters` | object | Parameters for share page. |

**Request body**


``` code-block
{
    "name": "My Websites Share Page",
    "parameters": { "utm": true, "goals": true, "events": true }
}
```


**Sample response**


``` code-block
{
    "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "entityId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "name": "My Websites Share Page",
    "shareType": 1,
    "slug": "xxxxxxxxx",
    "parameters": {
        "utm": false,
        "goals": true,
        "events": true
    },
    "createdAt": "2026-01-30T06:03:51.718Z",
    "updatedAt": "2026-01-30T06:09:05.640Z"
}
```


<a href="/docs/api/sessions" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Sessions</span></span></a><a href="/docs/api/teams" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Teams</span></span></a>


On this page


