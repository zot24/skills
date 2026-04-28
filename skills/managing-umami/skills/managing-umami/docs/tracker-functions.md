> Source: https://docs.umami.is/docs/tracker-functions



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Tracker functions


The Umami tracker exposes a function that you can call on your website if you want more control over your tracking. By default everything is automatically collected, but you can disable this using `data-auto-track="false"` and sending the data yourself. See [Tracker configuration](/docs/tracker-configuration).

## <a href="#functions-v200" class="peer" data-card="">Functions <code>v2.0.0</code></a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>// Tracks the current page
umami.track();

// Custom payload
umami.track(payload: object);

// Custom event
umami.track(event_name: string);

// Custom event with data
umami.track(event_name: string, data: object);

// Assign ID to current session
umami.identify(unique_id: string);

// Session data
umami.identify(unique_id: string, data: object);

// Session data without ID
umami.identify(data: object);</code></pre>
</figure>

## <a href="#pageviews-v200" class="peer" data-card="">Pageviews <code>v2.0.0</code></a>

Track a page view.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.track();</code></pre>
</figure>

By default the tracker automatically collects the following properties:


| Property   | Description                        |
|------------|------------------------------------|
| `hostname` | Hostname of server                 |
| `language` | Browser language                   |
| `referrer` | Page referrer                      |
| `screen`   | Screen dimensions (e.g. 1920x1080) |
| `title`    | Page title                         |
| `url`      | Page URL                           |
| `website`  | Website ID (required)              |


If you wish to send your own custom payload, pass in an object to the function:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.track({ website: &#39;e676c9b4-11e4-4ef1-a4d7-87001773e9f2&#39;, url: &#39;/home&#39;, title: &#39;Home page&#39; });</code></pre>
</figure>

The above will only send the properties `website`, `url` and `title`. If you want to include existing properties, pass in a function:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.track(props =&gt; ({ ...props, url: &#39;/home&#39;, title: &#39;Home page&#39; }));</code></pre>
</figure>

## <a href="#events-v200" class="peer" data-card="">Events <code>v2.0.0</code></a>

Track an event with a given name.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.track(&#39;signup-button&#39;);</code></pre>
</figure>

## <a href="#event-data-v200" class="peer" data-card="">Event Data <code>v2.0.0</code></a>

Track an event with dynamic data.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.track(&#39;signup-button&#39;, { name: &#39;newsletter&#39;, id: 123 });</code></pre>
</figure>

When tracking events, the default properties are included in the payload. This is equivalent to running:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.track(props =&gt; ({
  ...props,
  name: &#39;signup-button&#39;,
  data: {
    name: &#39;newsletter&#39;,
    id: 123,
  },
}));</code></pre>
</figure>

## <a href="#event-data-limits" class="peer" data-card="">Event Data Limits</a>

Event Data can work with any JSON data. There are a few rules in place to maintain performance.


| Data Type | Limit                                                   |
|-----------|---------------------------------------------------------|
| Numbers   | Max precision of 4.                                     |
| Strings   | Max length of 500.                                      |
| Arrays    | Converted to a string, max length of 500.               |
| Objects   | Max of 50 properties. Arrays are considered 1 property. |


## <a href="#overriding-event-timestamps" class="peer" data-card="">Overriding Event Timestamps</a>

You can override the event timestamp by adding a UNIX timestamp in seconds to the payload:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.track(props =&gt; ({
  ...props,
  name: &#39;signup-button&#39;,
  timestamp: 1771523787, // new Date().getTime() / 1000
}));</code></pre>
</figure>

## <a href="#sessions" class="peer" data-card="">Sessions</a>

`v2.13.0`

Pass in your own ID to identify a user.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.identify(&#39;unique_id&#39;);</code></pre>
</figure>

## <a href="#session-data-v2130" class="peer" data-card="">Session Data <code>v2.13.0</code></a>

Save data about the current session.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.identify(&#39;unique_id&#39;, { name: &#39;Bob&#39;, email: &#39;[email protected]&#39; });</code></pre>
</figure>

To save data without a unique ID, pass in only a JSON object.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>umami.identify({ name: &#39;Bob&#39;, email: &#39;[email protected]&#39; });</code></pre>
</figure>


<a href="/docs/track-outbound-links" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Track outbound links


Previous Page

<a href="/docs/tracker-configuration" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Tracker configuration


Next Page


### On this page


<a href="#functions-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Functions <code>v2.0.0</code></a><a href="#pageviews-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Pageviews <code>v2.0.0</code></a><a href="#events-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Events <code>v2.0.0</code></a><a href="#event-data-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Event Data <code>v2.0.0</code></a><a href="#event-data-limits" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Event Data Limits</a><a href="#overriding-event-timestamps" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Overriding Event Timestamps</a><a href="#sessions" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Sessions</a><a href="#session-data-v2130" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Session Data <code>v2.13.0</code></a>


