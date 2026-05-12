> Source: https://docs.umami.is/docs/api/authentication



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Authentication


The following authentication method is only for self-hosted Umami. For **Umami Cloud**, you simply need to generate an [API key](/docs/cloud/api-key).

## <a href="#post-apiauthlogin" class="peer" data-card="">POST /api/auth/login</a>

First you need to get a *token* in order to make API requests. You need to make a `POST` request to the `/api/auth/login` endpoint with the following data:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;username&quot;: &quot;your-username&quot;,
  &quot;password&quot;: &quot;your-password&quot;
}</code></pre>
</figure>

If successful you should get a response like the following:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;token&quot;: &quot;eyTMjU2IiwiY...4Q0JDLUhWxnIjoiUE_A&quot;,
  &quot;user&quot;: {
    &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
    &quot;username&quot;: &quot;admin&quot;,
    &quot;role&quot;: &quot;admin&quot;,
    &quot;createdAt&quot;: &quot;2000-00-00T00:00:00.000Z&quot;,
    &quot;isAdmin&quot;: true
  }
}</code></pre>
</figure>

Save the token value and send an `Authorization` header with all your data requests with the value `Bearer <token>`. Your request header should look something like this:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>Authorization: Bearer eyTMjU2IiwiY...4Q0JDLUhWxnIjoiUE_A</code></pre>
</figure>

For example, with `curl` it would look like this:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>curl https://{yourserver}/api/websites
   -H &quot;Accept: application/json&quot;
   -H &quot;Authorization: Bearer &lt;token&gt;&quot;</code></pre>
</figure>

The authorization token is expected with every API call that requires permissions.

------------------------------------------------------------------------

## <a href="#post-apiauthverify" class="peer" data-card="">POST /api/auth/verify</a>

You can verify if the token is still valid.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;id&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;username&quot;: &quot;admin&quot;,
  &quot;role&quot;: &quot;admin&quot;,
  &quot;createdAt&quot;: &quot;2000-00-00T00:00:00.000Z&quot;,
  &quot;isAdmin&quot;: true,
  &quot;teams&quot;: []
}</code></pre>
</figure>


<a href="/docs/api" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Overview


Previous Page

<a href="/docs/api/sending-stats" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Sending stats


Next Page


### On this page


<a href="#post-apiauthlogin" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/auth/login</a><a href="#post-apiauthverify" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/auth/verify</a>


