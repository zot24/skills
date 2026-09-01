> Source: https://docs.umami.is/docs/api/admin



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Endpoints


# Admin


Copy page


Operations around admin management.

These endpoints are only available for self-hosted instances for **admin** users and not **Umami Cloud**.

**Endpoints**


``` code-block
GET /api/admin/users
GET /api/admin/websites
GET /api/admin/teams
```


------------------------------------------------------------------------

## GET /api/admin/users<a href="#get-apiadminusers" class="heading-anchor" aria-label="Permalink to “GET /api/admin/users”">#</a>

Returns all users.

**Parameters**

| Parameter  | Type   | Description                                                   |
|------------|--------|---------------------------------------------------------------|
| `search`   | string | (optional) Search text.                                       |
| `page`     | number | (optional, default 1) Determines page.                        |
| `pageSize` | number | (optional, default 20) Determines how many results to return. |

**Sample response**


``` code-block
{
  "data": [
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "username": "member",
      "role": "user",
      "logoUrl": null,
      "displayName": null,
      "createdAt": "2025-10-10T23:09:16.524Z",
      "updatedAt": "2025-10-10T23:09:16.524Z",
      "deletedAt": null,
      "_count": {
        "websites": 0
      }
    },
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "username": "admin",
      "role": "admin",
      "logoUrl": null,
      "displayName": null,
      "createdAt": "2025-09-15T17:47:16.421Z",
      "updatedAt": null,
      "deletedAt": null,
      "_count": {
        "websites": 1
      }
    }
  ],
  "count": 2,
  "page": 1,
  "pageSize": 20,
  "orderBy": "createdAt"
}
```


------------------------------------------------------------------------

## GET /api/admin/websites<a href="#get-apiadminwebsites" class="heading-anchor" aria-label="Permalink to “GET /api/admin/websites”">#</a>

Returns all websites.

**Parameters**

| Parameter  | Type   | Description                                                   |
|------------|--------|---------------------------------------------------------------|
| `search`   | string | (optional) Search text.                                       |
| `page`     | number | (optional, default 1) Determines page.                        |
| `pageSize` | number | (optional, default 20) Determines how many results to return. |

**Sample response**


``` code-block
{
  "data": [
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "name": "My Website",
      "domain": "mywebsite.com",
      "shareId": null,
      "resetAt": null,
      "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "teamId": null,
      "createdBy": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "createdAt": "2025-09-16T19:59:32.957Z",
      "updatedAt": "2025-09-16T19:59:32.957Z",
      "deletedAt": null,
      "user": {
        "username": "admin",
        "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      },
      "team": null
    }
  ],
  "count": 1,
  "page": 1,
  "pageSize": 20
}
```


------------------------------------------------------------------------

## GET /api/admin/teams<a href="#get-apiadminteams" class="heading-anchor" aria-label="Permalink to “GET /api/admin/teams”">#</a>

Returns all teams.

**Parameters**

| Parameter  | Type   | Description                                                   |
|------------|--------|---------------------------------------------------------------|
| `search`   | string | (optional) Search text.                                       |
| `page`     | number | (optional, default 1) Determines page.                        |
| `pageSize` | number | (optional, default 20) Determines how many results to return. |

**Sample response**


``` code-block
{
  "data": [
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "name": "Umami Software, Inc",
      "accessCode": "xxxxxxxxxxxxxx",
      "logoUrl": null,
      "createdAt": "2025-09-24T22:08:35.259Z",
      "updatedAt": "2025-09-24T22:08:35.259Z",
      "deletedAt": null,
      "members": [
        {
          "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "role": "team-owner",
          "createdAt": "2025-09-24T22:08:35.302Z",
          "updatedAt": "2025-09-24T22:08:35.302Z",
          "user": {
            "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "username": "admin"
          }
        },
        {
          "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "role": "team-member",
          "createdAt": "2025-10-10T23:41:09.030Z",
          "updatedAt": "2025-10-10T23:41:09.030Z",
          "user": {
            "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "username": "member"
          }
        }
      ],
      "_count": {
        "websites": 1,
        "members": 2
      }
    }
  ],
  "count": 1,
  "page": 1,
  "pageSize": 20
}
```


<a href="/docs/api/sending-stats" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Sending stats</span></span></a><a href="/docs/api/events" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Events</span></span></a>


On this page


