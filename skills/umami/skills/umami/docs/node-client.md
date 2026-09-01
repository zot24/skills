> Source: https://docs.umami.is/docs/api/node-client



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Clients


# Node Client


Copy page


## Overview<a href="#overview" class="heading-anchor" aria-label="Permalink to “Overview”">#</a>

The Umami node client allows you to send data to Umami on the server side.

## Installation<a href="#installation" class="heading-anchor" aria-label="Permalink to “Installation”">#</a>


``` code-block
npm install @umami/node
```


## Usage<a href="#usage" class="heading-anchor" aria-label="Permalink to “Usage”">#</a>


``` code-block
import umami from '@umami/node';

umami.init({
  websiteId: '50429a93-8479-4073-be80-d5d29c09c2ec', // Your website id
  hostUrl: 'https://umami.mywebsite.com', // URL to your Umami instance
});

umami.track({ url: '/home' });
```


If using Umami Cloud, you can use `https://cloud.umami.is` as the host URL.

The properties you can send using the `.track` function are:

- **hostname**: Hostname of server
- **language**: Client language (eg. en-US)
- **referrer**: Page referrer
- **screen**: Screen dimensions (eg. 1920x1080)
- **title**: Page title
- **url**: Page url
- **name**: Event name (for custom events)
- **data**: Event data properties


<a href="/docs/api/api-client" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">API client</span></span></a><a href="/docs/cloud" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Overview</span></span></a>


On this page


