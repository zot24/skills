> Source: https://docs.umami.is/docs/api/websites



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Endpoints


# Websites


Copy page


Operations around Website management and statistics.

**Endpoints**


``` code-block
GET /api/websites
POST /api/websites
GET /api/websites/:websiteId
POST /api/websites/:websiteId
DELETE /api/websites/:websiteId
POST /api/websites/:websiteId/reset
GET /api/websites/:websiteId/recorder
```


------------------------------------------------------------------------

## GET /api/websites<a href="#get-apiwebsites" class="heading-anchor" aria-label="Permalink to “GET /api/websites”">#</a>

Returns all user websites.

**Parameters**

| Parameter      | Type    | Description                                                   |
|----------------|---------|---------------------------------------------------------------|
| `includeTeams` | boolean | Set to true to include websites where you are the team owner. |
| `search`       | string  | (optional) Search text.                                       |
| `page`         | number  | (optional, default 1) Determines page.                        |
| `pageSize`     | number  | (optional) Determines how many results to return.             |

**Sample response**


``` code-block
{
  "data": [
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "name": "Example",
      "domain": "example.com",
      "shareId": null,
      "resetAt": null,
      "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "teamId": null,
      "createdBy": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "createdAt": "0000-00-00T00:00:00.000Z",
      "updatedAt": "0000-00-00T00:00:00.000Z",
      "deletedAt": null,
      "user": {
        "username": "[email protected]",
        "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      }
    }
  ],
  "count": 1,
  "page": 1,
  "pageSize": 10
}
```


------------------------------------------------------------------------

## POST /api/websites<a href="#post-apiwebsites" class="heading-anchor" aria-label="Permalink to “POST /api/websites”">#</a>

Creates a website.

**Parameters**

| Parameter | Type   | Description                                                              |
|-----------|--------|--------------------------------------------------------------------------|
| `name`    | string | The name of the website in Umami.                                        |
| `domain`  | string | The full domain of the tracked website.                                  |
| `shareId` | string | (optional) A unique string to enable a share URL. Set `null` to unshare. |
| `teamId`  | string | (optional) The ID of the team the website will be created under.         |
| `id`      | string | (optional) Force a UUID assignment to the website.                       |

**Request body**


``` code-block
{
  "name": "Test",
  "domain": "example.com"
}
```


**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "name": "Test",
  "domain": "example.com",
  "shareId": null,
  "resetAt": null,
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": null,
  "createdBy": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "createdAt": "0000-00-00T00:00:00.000Z",
  "updatedAt": "0000-00-00T00:00:00.000Z",
  "deletedAt": null
}
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId<a href="#get-apiwebsiteswebsiteid" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId”">#</a>

Gets a website by ID.

**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "name": "Example",
  "domain": "example.com",
  "shareId": null,
  "resetAt": null,
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": null,
  "createdBy": "133660ed-e51c-4ed9-84aa-c86654460cae",
  "createdAt": "2025-10-10T22:01:06.201Z",
  "updatedAt": "2025-10-10T22:02:02.220Z",
  "deletedAt": null
}
```


------------------------------------------------------------------------

## POST /api/websites/:websiteId<a href="#post-apiwebsiteswebsiteid" class="heading-anchor" aria-label="Permalink to “POST /api/websites/:websiteId”">#</a>

Updates a website.

**Parameters**

| Parameter      | Type   | Description                                                              |
|----------------|--------|--------------------------------------------------------------------------|
| `name`         | string | The name of the website in Umami.                                        |
| `domain`       | string | The full domain of the tracked website.                                  |
| `shareId`      | string | (optional) A unique string to enable a share URL. Set `null` to unshare. |
| `replayConfig` | object | (optional) Session recording and heatmap configuration.                  |

**`replayConfig` fields**

| Field               | Type    | Description                                          |
|---------------------|---------|------------------------------------------------------|
| `replayEnabled`     | boolean | Enable or disable session replay recording.          |
| `heatmapEnabled`    | boolean | Enable or disable heatmap data collection.           |
| `sampleRate`        | number  | Fraction of sessions to record for replay (0–1).     |
| `heatmapSampleRate` | number  | Fraction of sessions to record for heatmaps (0–1).   |
| `maskLevel`         | string  | PII masking level: `strict` or `moderate`.           |
| `maxDuration`       | number  | Maximum recording duration in seconds.               |
| `blockSelector`     | string  | CSS selector for elements to exclude from recording. |

**Request body**


``` code-block
{
  "name": "Test",
  "domain": "domain.com",
  "replayConfig": {
    "replayEnabled": true,
    "sampleRate": 0.5
  }
}
```


**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "name": "Example",
  "domain": "example.com",
  "shareId": null,
  "resetAt": null,
  "userId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "teamId": null,
  "recorderEnabled": true,
  "replayConfig": {
    "replayEnabled": true,
    "heatmapEnabled": false,
    "sampleRate": 0.5,
    "heatmapSampleRate": 0,
    "maskLevel": "moderate",
    "maxDuration": 3600,
    "blockSelector": ""
  },
  "createdBy": "133660ed-e51c-4ed9-84aa-c86654460cae",
  "createdAt": "2025-10-10T22:01:06.201Z",
  "updatedAt": "2025-10-10T22:02:02.220Z",
  "deletedAt": null
}
```


------------------------------------------------------------------------

## DELETE /api/websites/:websiteId<a href="#delete-apiwebsiteswebsiteid" class="heading-anchor" aria-label="Permalink to “DELETE /api/websites/:websiteId”">#</a>

Deletes a website.

**Sample response**


``` code-block
{
  "ok": true
}
```


------------------------------------------------------------------------

## POST /api/websites/:websiteId/reset<a href="#post-apiwebsiteswebsiteidreset" class="heading-anchor" aria-label="Permalink to “POST /api/websites/:websiteId/reset”">#</a>

Resets a website by removing all data related to the website.

**Sample response**


``` code-block
{
  "ok": true
}
```


------------------------------------------------------------------------

## GET /api/websites/:websiteId/recorder<a href="#get-apiwebsiteswebsiteidrecorder" class="heading-anchor" aria-label="Permalink to “GET /api/websites/:websiteId/recorder”">#</a>

Returns the recorder configuration for a website. Used by the tracker to initialize session replay and heatmap collection. This endpoint requires no authentication and is publicly accessible.

If the website does not exist or recording is disabled, returns `{ "enabled": false }`.

**Sample response**


``` code-block
{
  "enabled": true,
  "replayEnabled": true,
  "heatmapEnabled": false,
  "sampleRate": 0.15,
  "heatmapSampleRate": 0.15,
  "maskLevel": "moderate",
  "maxDuration": 300000,
  "blockSelector": ""
}
```


<a href="/docs/api/pixels" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Pixels</span></span></a><a href="/docs/api/website-stats" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Website statistics</span></span></a>


On this page


