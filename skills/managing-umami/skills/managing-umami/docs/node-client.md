<!-- Source: https://docs.umami.is/docs/api/node-client -->

# Umami Node Client

Server-side event tracking for Node.js applications.

## Installation

```bash
npm install @umami/node
```

## Setup

```javascript
import umami from '@umami/node';

umami.init({
  websiteId: '50429a93-8479-4073-be80-d5d29c09c2ec',
  hostUrl: 'https://umami.mywebsite.com',
});
```

For Umami Cloud, use `https://cloud.umami.is` as the host URL.

## Track Method

```javascript
umami.track({ url: '/home' });
```

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `hostname` | string | Server hostname |
| `language` | string | Client language (e.g., `en-US`) |
| `referrer` | string | Page referrer |
| `screen` | string | Screen dimensions (e.g., `1920x1080`) |
| `title` | string | Page title |
| `url` | string | Page URL |
| `name` | string | Event name (for custom events) |
| `data` | object | Additional event data properties |

## Examples

```javascript
// Track a pageview
umami.track({ url: '/home', title: 'Home Page' });

// Track a custom event
umami.track({ url: '/checkout', name: 'purchase', data: { amount: 99.99 } });

// Track with full context
umami.track({
  hostname: 'mysite.com',
  language: 'en-US',
  url: '/api/webhook',
  name: 'webhook-received',
  data: { source: 'stripe' }
});
```
