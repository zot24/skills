> Source: https://docs.umami.is/docs/api/sending-stats



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Sending stats


## <a href="#post-apisend" class="peer" data-card="">POST /api/send</a>

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
| `type`             | string | `event` is currently the only type available. |


**Sample payload**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;payload&quot;: {
    &quot;hostname&quot;: &quot;your-hostname&quot;,
    &quot;language&quot;: &quot;en-US&quot;,
    &quot;referrer&quot;: &quot;&quot;,
    &quot;screen&quot;: &quot;1920x1080&quot;,
    &quot;title&quot;: &quot;dashboard&quot;,
    &quot;url&quot;: &quot;/&quot;,
    &quot;website&quot;: &quot;your-website-id&quot;,
    &quot;name&quot;: &quot;event-name&quot;,
    &quot;data&quot;: {
      &quot;foo&quot;: &quot;bar&quot;
    }
  },
  &quot;type&quot;: &quot;event&quot;
}</code></pre>
</figure>

Note, for `/api/send` requests you do not need to send an authentication token.

Also, you need to send a proper `User-Agent` HTTP header or your request won't be registered.

**Sample response**

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>{
  &quot;cache&quot;: &quot;xxxxxxxxxxxxxxx&quot;,
  &quot;sessionId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;,
  &quot;visitId&quot;: &quot;xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx&quot;
}</code></pre>
</figure>

**Programmatically**

You can generate most of these values programmatically with JavaScript using the browser APIs. For example:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>const data = {
  payload: {
    hostname: window.location.hostname,
    language: navigator.language,
    referrer: document.referrer,
    screen: `${window.screen.width}x${window.screen.height}`,
    title: document.title,
    url: window.location.pathname,
    website: &#39;your-website-id&#39;,
    name: &#39;event-name&#39;,
  },
  type: &#39;event&#39;,
};</code></pre>
</figure>


<a href="/docs/api/authentication" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Authentication


Previous Page

<a href="/docs/api/admin" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Admin


Next Page


### On this page


<a href="#post-apisend" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">POST /api/send</a>


