> Source: https://docs.umami.is/docs/api/authentication



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


API


# Authentication


Copy page


Self-hosted Umami supports two ways to authenticate API requests. **API keys** are the recommended method. Username and password authentication is still supported as an alternative.

For **Umami Cloud**, API keys are the only authentication method. See [API key](/docs/cloud/api-key).

## API keys (recommended)<a href="#api-keys-recommended" class="heading-anchor" aria-label="Permalink to “API keys (recommended)”">#</a>

API keys are long-lived credentials that are ideal for programmatic access. They don't expire and can be revoked individually.

### Create a key<a href="#create-a-key" class="heading-anchor" aria-label="Permalink to “Create a key”">#</a>

Generate a key from the app by clicking your profile icon, selecting **Settings**, and navigating to **API keys**. Click **Create key** and save the value — it is only shown once.

You can also create, list, and delete keys programmatically:

- [Create an API key](/docs/api-reference/create-my-api-key)
- [List my API keys](/docs/api-reference/get-my-api-keys)
- [Delete an API key](/docs/api-reference/delete-my-api-key)

### Using your key<a href="#using-your-key" class="heading-anchor" aria-label="Permalink to “Using your key”">#</a>

Pass the key with an `Authorization` header using the Bearer authentication scheme.


request


``` code-block
Authorization: Bearer <api-key>
```


For example, with `curl` it would look like this:


``` code-block
curl https://{yourserver}/api/websites \
   -H "Accept: application/json" \
   -H "Authorization: Bearer <api-key>"
```


## Username and password (alternative)<a href="#username-and-password-alternative" class="heading-anchor" aria-label="Permalink to “Username and password (alternative)”">#</a>

If you prefer, you can still authenticate by exchanging your username and password for a temporary token.

### POST /api/auth/login<a href="#post-apiauthlogin" class="heading-anchor" aria-label="Permalink to “POST /api/auth/login”">#</a>

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

### POST /api/auth/verify<a href="#post-apiauthverify" class="heading-anchor" aria-label="Permalink to “POST /api/auth/verify”">#</a>

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


