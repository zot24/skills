<!-- Source: https://docs.umami.is/docs/tracker-functions -->

# Tracker Functions

Client-side tracking methods available via the Umami script tag.

## Script Tag

```html
<script defer src="https://your-umami.com/script.js" data-website-id="your-id"></script>
```

## umami.track()

### Pageview (auto-collected)
```javascript
umami.track();
// Collects: hostname, language, referrer, screen, title, url, website
```

### Custom payload
```javascript
umami.track({ website: 'id', url: '/home', title: 'Home' });
```

### Override with defaults preserved
```javascript
umami.track(props => ({ ...props, url: '/home', title: 'Home' }));
```

### Named event
```javascript
umami.track('signup-button');
```

### Event with data
```javascript
umami.track('signup-button', { name: 'newsletter', id: 123 });
```

### Timestamp override
```javascript
umami.track(props => ({
  ...props,
  name: 'event-name',
  timestamp: 1771523787  // UNIX seconds
}));
```

## umami.identify()

### Assign unique ID to session
```javascript
umami.identify('user-123');
```

### ID with metadata
```javascript
umami.identify('user-123', { name: 'Bob', email: 'bob@example.com' });
```

### Metadata only (no ID)
```javascript
umami.identify({ name: 'Bob', email: 'bob@example.com' });
```

## Event Data Constraints

| Type | Limit |
|------|-------|
| Numbers | 4 decimal places |
| Strings | 500 characters max |
| Arrays | 500 chars (converted to string) |
| Objects | 50 properties |
