> Source: https://docs.umami.is/docs/api/links



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Endpoints


# Links


Copy page


Operations around Links management.

**Endpoints**


``` code-block
GET /api/links
POST /api/links
GET /api/links/:linkId
POST /api/links/:linkId
DELETE /api/links/:linkId
```


------------------------------------------------------------------------

## GET /api/links<a href="#get-apilinks" class="heading-anchor" aria-label="Permalink to “GET /api/links”">#</a>

Returns all user links.

**Parameters**

| Parameter  | Type   | Description                                       |
|------------|--------|---------------------------------------------------|
| `search`   | string | (optional) Search text.                           |
| `page`     | number | (optional, default 1) Determines page.            |
| `pageSize` | number | (optional) Determines how many results to return. |

**Sample response**


``` code-block
{
  "data": [
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "name": "umami",
      "url": "https://www.umami.is",
      "slug": "xxxxxxxx",
      "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "teamId": null,
      "createdAt": "2025-10-27T18:49:39.383Z",
      "updatedAt": "2025-10-27T18:49:39.383Z",
      "deletedAt": null
    }
  ],
  "count": 1,
  "page": 1,
  "pageSize": 20
}
```


------------------------------------------------------------------------

## POST /api/links<a href="#post-apilinks" class="heading-anchor" aria-label="Permalink to “POST /api/links”">#</a>

Creates a link.

**Parameters**

| Parameter | Type   | Description                                                   |
|-----------|--------|---------------------------------------------------------------|
| `name`    | string | The link's name.                                              |
| `url`     | string | The link's destination URL.                                   |
| `slug`    | string | The link's URL slug (minimum 8 characters).                   |
| `teamId`  | string | (optional) The ID of the team the link will be created under. |

**Request body**


``` code-block
{
  "name": "umami",
  "url": "https://www.umami.is",
  "slug": "umami123"
}
```


**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "name": "umami",
  "url": "https://www.umami.is",
  "slug": "umami123",
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": null,
  "createdAt": "2025-10-27T18:49:39.383Z",
  "updatedAt": "2025-10-27T18:49:39.383Z",
  "deletedAt": null
}
```


------------------------------------------------------------------------

## GET /api/links/:linkId<a href="#get-apilinkslinkid" class="heading-anchor" aria-label="Permalink to “GET /api/links/:linkId”">#</a>

Gets a link by ID.

**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "name": "umami",
  "url": "https://www.umami.is",
  "slug": "xxxxxxxx",
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": null,
  "createdAt": "2025-10-27T18:49:39.383Z",
  "updatedAt": "2025-10-27T18:49:39.383Z",
  "deletedAt": null
}
```


------------------------------------------------------------------------

## POST /api/links/:linkId<a href="#post-apilinkslinkid" class="heading-anchor" aria-label="Permalink to “POST /api/links/:linkId”">#</a>

Updates a link.

**Parameters**

| Parameter | Type   | Description                                            |
|-----------|--------|--------------------------------------------------------|
| `name`    | string | (optional) The link's name.                            |
| `url`     | string | (optional) The link's destination URL.                 |
| `slug`    | string | (optional) The link's URL slug (minimum 8 characters). |

**Request body**


``` code-block
{
  "name": "umami",
  "url": "https://www.umami.is"
}
```


**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "name": "umami",
  "url": "https://www.umami.is",
  "slug": "xxxxxxxx",
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": null,
  "createdAt": "2025-10-27T18:49:39.383Z",
  "updatedAt": "2025-10-30T23:06:01.824Z",
  "deletedAt": null
}
```


------------------------------------------------------------------------

## DELETE /api/links/:linkId<a href="#delete-apilinkslinkid" class="heading-anchor" aria-label="Permalink to “DELETE /api/links/:linkId”">#</a>

Deletes a link.

**Sample response**


``` code-block
{
  "ok": true
}
```


<a href="/docs/api/events" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Events</span></span></a><a href="/docs/api/me" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Me</span></span></a>


On this page


