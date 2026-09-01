> Source: https://docs.umami.is/docs/tracker-functions



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Tracking


# Tracker functions


Copy page


The Umami tracker exposes a function that you can call on your website if you want more control over your tracking. By default everything is automatically collected, but you can disable automatic pageviews using `data-auto-pageview="false"` and send them yourself with `umami.track()`. Use `data-auto-track="false"` only if you want to disable tracker initialization entirely. See [Tracker configuration](/docs/tracker-configuration).

## Functions<a href="#functions" class="heading-anchor" aria-label="Permalink to “Functions”">#</a>


``` code-block
// Tracks the current page
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
umami.identify(data: object);
```


## Pageviews<a href="#pageviews" class="heading-anchor" aria-label="Permalink to “Pageviews”">#</a>


Track a page view.


``` code-block
umami.track();
```


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


``` code-block
umami.track({ website: 'e676c9b4-11e4-4ef1-a4d7-87001773e9f2', url: '/home', title: 'Home page' });
```


The above will only send the properties `website`, `url` and `title`. If you want to include existing properties, pass in a function:


``` code-block
umami.track(props => ({ ...props, url: '/home', title: 'Home page' }));
```


## Events<a href="#events" class="heading-anchor" aria-label="Permalink to “Events”">#</a>


Track an event with a given name.


``` code-block
umami.track('signup-button');
```


## Event Data<a href="#event-data" class="heading-anchor" aria-label="Permalink to “Event Data”">#</a>


Track an event with dynamic data.


``` code-block
umami.track('signup-button', { plan: 'newsletter', id: 123 });
```


When tracking events, the default properties are included in the payload. This is equivalent to running:


``` code-block
umami.track(props => ({
  ...props,
  name: 'signup-button',
  data: {
    plan: 'newsletter',
    id: 123,
  },
}));
```


## Event Data Limits<a href="#event-data-limits" class="heading-anchor" aria-label="Permalink to “Event Data Limits”">#</a>

Event Data can work with any JSON data. There are a few rules in place to maintain performance.

| Data Type | Limit                                                   |
|-----------|---------------------------------------------------------|
| Numbers   | Max precision of 4.                                     |
| Strings   | Max length of 500.                                      |
| Arrays    | Converted to a string, max length of 500.               |
| Objects   | Max of 50 properties. Arrays are considered 1 property. |

## Overriding Event Timestamps<a href="#overriding-event-timestamps" class="heading-anchor" aria-label="Permalink to “Overriding Event Timestamps”">#</a>

You can override the event timestamp by adding a UNIX timestamp in seconds to the payload:


``` code-block
umami.track(props => ({
  ...props,
  name: 'signup-button',
  timestamp: 1771523787, // new Date().getTime() / 1000
}));
```


## Sessions<a href="#sessions" class="heading-anchor" aria-label="Permalink to “Sessions”">#</a>


Pass in your own ID to identify a user.


``` code-block
umami.identify('unique_id');
```


## Session Data<a href="#session-data" class="heading-anchor" aria-label="Permalink to “Session Data”">#</a>


Save data about the current session.


``` code-block
umami.identify('unique_id', { name: 'Bob', email: '[email protected]' });
```


To save data without a unique ID, pass in only a JSON object.


``` code-block
umami.identify({ name: 'Bob', email: '[email protected]' });
```


<a href="/docs/exclude-my-own-visits" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Exclude my own visits</span></span></a><a href="/docs/tracker-configuration" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Tracker configuration</span></span></a>


On this page


