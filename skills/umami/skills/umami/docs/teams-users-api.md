> Source: https://docs.umami.is/docs/api/teams



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Endpoints


# Teams


Copy page


Operations around Team management.

**Endpoints**


``` code-block
GET /api/teams
POST /api/teams
POST /api/teams/join
GET /api/teams/:teamId
POST /api/teams/:teamId
DELETE /api/teams/:teamId
GET /api/teams/:teamId/users
POST /api/teams/:teamId/users
GET /api/teams/:teamId/users/:userId
POST /api/teams/:teamId/users/:userId
DELETE /api/teams/:teamId/users/:userId
GET /api/teams/:teamId/websites
```


------------------------------------------------------------------------

## GET /api/teams<a href="#get-apiteams" class="heading-anchor" aria-label="Permalink to “GET /api/teams”">#</a>

Returns all teams.

**Parameters**

| Parameter  | Type   | Description                                       |
|------------|--------|---------------------------------------------------|
| `page`     | number | (optional, default 1) Determines page.            |
| `pageSize` | number | (optional) Determines how many results to return. |

**Sample response**


``` code-block
{
  "data": [
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "name": "Umami Software",
      "accessCode": "xxxxxxxxxx",
      "logoUrl": null,
      "createdAt": "2025-01-06T23:46:38.169Z",
      "updatedAt": "2025-02-14T17:38:27.607Z",
      "deletedAt": null,
      "members": [
        {
          "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "role": "team-owner",
          "createdAt": "2025-01-06T23:46:38.169Z",
          "updatedAt": "2025-01-06T23:46:38.169Z",
          "user": {
            "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "username": "[email protected]"
          }
        },
        {
          "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "role": "team-member",
          "createdAt": "2025-01-06T23:46:38.169Z",
          "updatedAt": "2025-01-06T23:46:38.169Z",
          "user": {
            "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "username": "[email protected]"
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


------------------------------------------------------------------------

## POST /api/teams<a href="#post-apiteams" class="heading-anchor" aria-label="Permalink to “POST /api/teams”">#</a>

Creates a team.

**Parameters**

| Parameter | Type   | Description      |
|-----------|--------|------------------|
| `name`    | string | The team's name. |

**Request body**


``` code-block
{
  "name": "marketing"
}
```


**Sample response**


``` code-block
[
  {
    "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "name": "marketing",
    "accessCode": "team_KBmjrm5KcDZSArah",
    "logoUrl": null,
    "createdAt": "0000-00-00T00:00:00.000Z",
    "updatedAt": "0000-00-00T00:00:00.000Z",
    "deletedAt": null
  },
  {
    "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "role": "team-owner",
    "createdAt": "0000-00-00T00:00:00.000Z",
    "updatedAt": "0000-00-00T00:00:00.000Z"
  }
]
```


------------------------------------------------------------------------

## POST /api/teams/join<a href="#post-apiteamsjoin" class="heading-anchor" aria-label="Permalink to “POST /api/teams/join”">#</a>

Join a team.

**Parameters**

| Parameter    | Type   | Description             |
|--------------|--------|-------------------------|
| `accessCode` | string | The team's access code. |

**Request body**


``` code-block
{
  "accessCode": "xxwtoY8pzKjDIUQi"
}
```


**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "role": "team-member",
  "createdAt": "0000-00-00T00:00:00.000Z",
  "updatedAt": "0000-00-00T00:00:00.000Z"
}
```


------------------------------------------------------------------------

## GET /api/teams/:teamId<a href="#get-apiteamsteamid" class="heading-anchor" aria-label="Permalink to “GET /api/teams/:teamId”">#</a>

Get a team.

**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "name": "Umami Software",
  "accessCode": "xxxxxxxxxxx",
  "logoUrl": null,
  "createdAt": "2024-02-17T06:27:50.130Z",
  "updatedAt": "2025-02-14T17:37:50.306Z",
  "deletedAt": null,
  "members": [
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "role": "team-owner",
      "createdAt": "2024-02-17T06:27:50.130Z",
      "updatedAt": "2024-02-17T06:27:50.130Z"
    },
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "role": "team-member",
      "createdAt": "2024-02-29T17:47:21.354Z",
      "updatedAt": "2024-02-29T17:47:21.354Z"
    }
  ]
}
```


------------------------------------------------------------------------

## POST /api/teams/:teamId<a href="#post-apiteamsteamid" class="heading-anchor" aria-label="Permalink to “POST /api/teams/:teamId”">#</a>

Update a team.

**Parameters**

| Parameter    | Type   | Description                        |
|--------------|--------|------------------------------------|
| `name`       | string | (optional) The team's name.        |
| `accessCode` | string | (optional) The team's access code. |

**Request body**


``` code-block
{
  "name": "Marketing"
}
```


**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "name": "Marketing",
  "accessCode": "xxxxxxxxxxx",
  "logoUrl": null,
  "createdAt": "2025-10-07T07:42:06.112Z",
  "updatedAt": "2025-10-10T22:41:22.191Z",
  "deletedAt": null
}
```


------------------------------------------------------------------------

## DELETE /api/teams/:teamId<a href="#delete-apiteamsteamid" class="heading-anchor" aria-label="Permalink to “DELETE /api/teams/:teamId”">#</a>

Delete a team.

**Sample response**


``` code-block
{
  "ok": true
}
```


------------------------------------------------------------------------

## GET /api/teams/:teamId/users<a href="#get-apiteamsteamidusers" class="heading-anchor" aria-label="Permalink to “GET /api/teams/:teamId/users”">#</a>

Get all users that belong to a team.

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
      "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "role": "team-owner",
      "createdAt": "2025-10-10T22:34:46.736Z",
      "updatedAt": "2025-10-10T22:34:46.736Z",
      "user": {
        "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "username": "[email protected]"
      }
    },
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "role": "team-member",
      "createdAt": "2025-10-10T22:37:38.587Z",
      "updatedAt": "2025-10-10T22:37:38.587Z",
      "user": {
        "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "username": "[email protected]"
      }
    }
  ],
  "count": 2,
  "page": 1,
  "pageSize": 20
}
```


------------------------------------------------------------------------

## POST /api/teams/:teamId/users<a href="#post-apiteamsteamidusers" class="heading-anchor" aria-label="Permalink to “POST /api/teams/:teamId/users”">#</a>

Add a user to a team.

**Parameters**

| Parameter | Type   | Description                                                               |
|-----------|--------|---------------------------------------------------------------------------|
| `userId`  | string | ID of user to be added.                                                   |
| `role`    | string | Team role for user (`team-member` \| `team-view-only` \| `team-manager`). |

**Request body**


``` code-block
{
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "role": "team-member"
}
```


**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "role": "team-member",
  "createdAt": "0000-00-00T00:00:00.000Z",
  "updatedAt": "0000-00-00T00:00:00.000Z"
}
```


------------------------------------------------------------------------

## GET /api/teams/:teamId/users/:userId<a href="#get-apiteamsteamidusersuserid" class="heading-anchor" aria-label="Permalink to “GET /api/teams/:teamId/users/:userId”">#</a>

Get a user belonging to a team.

**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "role": "team-owner",
  "createdAt": "0000-00-00T00:00:00.000Z",
  "updatedAt": "0000-00-00T00:00:00.000Z"
}
```


------------------------------------------------------------------------

## POST /api/teams/:teamId/users/:userId<a href="#post-apiteamsteamidusersuserid" class="heading-anchor" aria-label="Permalink to “POST /api/teams/:teamId/users/:userId”">#</a>

Update a user's role on a team.

**Parameters**

| Parameter | Type   | Description                                                               |
|-----------|--------|---------------------------------------------------------------------------|
| `role`    | string | Team role for user (`team-member` \| `team-view-only` \| `team-manager`). |

**Request body**


``` code-block
{
  "role": "team-member"
}
```


**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "role": "team-member",
  "createdAt": "0000-00-00T00:00:00.000Z",
  "updatedAt": "0000-00-00T00:00:00.000Z"
}
```


------------------------------------------------------------------------

## DELETE /api/teams/:teamId/users/:userId<a href="#delete-apiteamsteamidusersuserid" class="heading-anchor" aria-label="Permalink to “DELETE /api/teams/:teamId/users/:userId”">#</a>

Remove a user from a team.

**Sample response**


``` code-block
{
  "ok": true
}
```


------------------------------------------------------------------------

## GET /api/teams/:teamId/websites<a href="#get-apiteamsteamidwebsites" class="heading-anchor" aria-label="Permalink to “GET /api/teams/:teamId/websites”">#</a>

Get all websites that belong to a team.

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
      "name": "aol",
      "domain": "aol.com",
      "shareId": "xxxxxxxxxxxx",
      "resetAt": null,
      "userId": null,
      "teamId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "createdBy": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "createdAt": "2020-07-19T06:53:33.482Z",
      "updatedAt": "2024-06-24T05:00:00.279Z",
      "deletedAt": null,
      "createUser": {
        "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "username": "[email protected]"
      }
    }
  ],
  "count": 1,
  "page": 1,
  "pageSize": 20
}
```


<a href="/docs/api/share" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Share</span></span></a><a href="/docs/api/users" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Users</span></span></a>


On this page


