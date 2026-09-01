> Source: https://docs.umami.is/docs/api/authentication



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


API


# Authentication


Copy page


The following authentication method is only for self-hosted Umami. For **Umami Cloud**, you simply need to generate an [API key](/docs/cloud/api-key).

## POST /api/auth/login<a href="#post-apiauthlogin" class="heading-anchor" aria-label="Permalink to “POST /api/auth/login”">#</a>

First you need to get a *token* in order to make API requests. You need to make a `POST` request to the `/api/auth/login` endpoint with the following data:


``` code-block
{
  "username": "your-username",
  "password": "your-password"
}
```


If successful you should get a response like the following:


``` code-block
{
  "token": "eyTMjU2IiwiY...4Q0JDLUhWxnIjoiUE_A",
  "user": {
    "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "username": "admin",
    "role": "admin",
    "createdAt": "2000-00-00T00:00:00.000Z",
    "isAdmin": true
  }
}
```


Save the token value and send an `Authorization` header with all your data requests with the value `Bearer <token>`. Your request header should look something like this:


request


``` code-block
Authorization: Bearer eyTMjU2IiwiY...4Q0JDLUhWxnIjoiUE_A
```


For example, with `curl` it would look like this:


``` code-block
curl https://{yourserver}/api/websites \
   -H "Accept: application/json" \
   -H "Authorization: Bearer <token>"
```


The authorization token is expected with every API call that requires permissions.

------------------------------------------------------------------------

## POST /api/auth/verify<a href="#post-apiauthverify" class="heading-anchor" aria-label="Permalink to “POST /api/auth/verify”">#</a>

You can verify if the token is still valid.

**Sample response**


``` code-block
{
  "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "username": "admin",
  "role": "admin",
  "createdAt": "2000-00-00T00:00:00.000Z",
  "isAdmin": true,
  "teams": []
}
```


<a href="/docs/api" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Overview</span></span></a><a href="/docs/api/sending-stats" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Sending stats</span></span></a>


On this page


