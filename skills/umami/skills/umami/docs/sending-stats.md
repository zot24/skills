> Source: https://docs.umami.is/docs/api/sending-stats



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


API


# Sending stats


Copy page


## POST /api/send<a href="#post-apisend" class="heading-anchor" aria-label="Permalink to “POST /api/send”">#</a>

To register an `event`, you need to send a `POST` to `/api/send` with the following data:

For **Umami Cloud** send a POST to `https://cloud.umami.is/api/send`.

**Parameters**

| Parameter          | Type   | Description                                   |
|--------------------|--------|-----------------------------------------------|
| `payload.hostname` | string | Name of host.                                 |
| `payload.screen`   | string | Screen resolution (ex. "1920x1080").          |
| `payload.language` | string | Language of visitor (ex. "en-US").            |
| `payload.url`      | string | Page URL.                                     |
| `payload.referrer` | string | Referrer URL.                                 |
| `payload.title`    | string | Page title.                                   |
| `payload.tag`      | string | Additional tag description.                   |
| `payload.id`       | string | Session identifier.                           |
| `payload.website`  | string | Website ID.                                   |
| `payload.name`     | string | Name of the event.                            |
| `payload.data`     | object | (optional) Additional data for the event.     |
| `type`             | string | One of `event`, `identify`, or `performance`. |

**Sample payload**


``` code-block
{
  "payload": {
    "hostname": "your-hostname",
    "language": "en-US",
    "referrer": "",
    "screen": "1920x1080",
    "title": "dashboard",
    "url": "/",
    "website": "your-website-id",
    "name": "event-name",
    "data": {
      "foo": "bar"
    }
  },
  "type": "event"
}
```


Note, for `/api/send` requests you do not need to send an authentication token.

Also, you need to send a proper `User-Agent` HTTP header or your request won't be registered.

**Sample response**


``` code-block
{
  "cache": "xxxxxxxxxxxxxxx",
  "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "visitId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```


**Programmatically**

You can generate most of these values programmatically with JavaScript using the browser APIs. For example:


``` code-block
const data = {
  payload: {
    hostname: window.location.hostname,
    language: navigator.language,
    referrer: document.referrer,
    screen: `${window.screen.width}x${window.screen.height}`,
    title: document.title,
    url: window.location.pathname,
    website: 'your-website-id',
    name: 'event-name',
  },
  type: 'event',
};
```


## POST /api/batch<a href="#post-apibatch" class="heading-anchor" aria-label="Permalink to “POST /api/batch”">#</a>

To send multiple events in a single request, POST a JSON **array** to `/api/batch`. Each element of the array has the same shape as an `/api/send` request body. Like `/api/send`, this endpoint does not require an authentication token but does require a valid `User-Agent` header.

**Sample payload**


``` code-block
[
  {
    "payload": {
      "hostname": "your-hostname",
      "url": "/page-1",
      "website": "your-website-id",
      "name": "event-name"
    },
    "type": "event"
  },
  {
    "payload": {
      "hostname": "your-hostname",
      "url": "/page-2",
      "website": "your-website-id",
      "name": "event-name"
    },
    "type": "event"
  }
]
```


Each item is forwarded to `/api/send`, so all `type` values and payload fields supported there are also supported here.

**Sample response**


``` code-block
{
  "size": 2,
  "processed": 2,
  "errors": 0,
  "details": [],
  "cache": "xxxxxxxxxxxxxxx"
}
```


If any items fail, `errors` is the failure count and `details` lists each failure along with its `index` in the submitted array.


<a href="/docs/api/authentication" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Authentication</span></span></a><a href="/docs/api/admin" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Admin</span></span></a>


On this page


