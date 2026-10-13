<!-- Authored for this skill. Not synced from upstream.
     Tracker attributes from https://docs.umami.is/docs/tracker-configuration,
     revenue events from https://docs.umami.is/docs/revenue. -->

# Add a site to a self-hosted Umami

The per-site flow for a self-hosted Umami whose dashboard stays on a private network and whose
collection endpoints are public under `umami.<site-domain>`. One Umami instance serves every site.

Inputs: the site domain (`acmewidgets.com`), and from the environment `UMAMI_URL` (the private
dashboard URL), `UMAMI_USERNAME`, `UMAMI_PASSWORD`. None of these go into the site repository.

## 1. Check the version

Replays need 3.1.0, heatmaps 3.2.0. There is no version endpoint; probe the recorder instead:

```bash
curl -s -o /dev/null -w "%{http_code}\n" "$UMAMI_URL/recorder.js"   # 200 → 3.1.0 or later
curl -s "$UMAMI_URL/api/config" | jq '{trackerScriptName}'          # custom tracker name, if set
```

For heatmaps, read the version in the dashboard footer or the host's app store. Below 3.2.0, set
up replays only and tell the owner an update unlocks heatmaps.

## 2. Public hostname

Use the `cloudflare-domains` skill (`docs/tunnel-hostnames.md`):
add `umami.acmewidgets.com` to the existing tunnel, the proxied CNAME, and the WAF allow-list. The
allow-list for Umami 3.4:

```
(http.host eq "umami.acmewidgets.com" and not (
  http.request.uri.path in {"/script.js" "/recorder.js" "/api/send" "/api/record"}
  or (http.request.method in {"GET" "OPTIONS"}
      and starts_with(http.request.uri.path, "/api/websites/")
      and ends_with(http.request.uri.path, "/recorder"))
))
```

Swap `/script.js` for the custom name when `trackerScriptName` is set.

## 3. Create the website

```bash
umami-cli auth login --server "$UMAMI_URL" --username "$UMAMI_USERNAME" --password-stdin <<< "$UMAMI_PASSWORD"
umami-cli websites list --search acmewidgets.com --json \
  | jq -r '.data[] | select(.domain=="acmewidgets.com") | .id'                  # reuse if present
umami-cli websites create --name "Acme Widgets" --domain acmewidgets.com
```

Never create a second website for a domain that already has one: the history stays with the old ID.

## 4. Turn on replays and heatmaps

See [replays and heatmaps](replays-heatmaps.md). Start at `sampleRate` 0.15 and `maskLevel`
`moderate`; use `strict` when the site shows personal data.

## 5. Inject the scripts

The website ID and the public hostname are not secrets: they ship in every page. Keep them in the
site's public config, for Astro as `PUBLIC_` variables in `wrangler.jsonc` `vars` or `.env`:

```astro
---
// src/components/Analytics.astro — render once in the base layout <head>
const host = import.meta.env.PUBLIC_UMAMI_HOST;          // https://umami.acmewidgets.com
const id = import.meta.env.PUBLIC_UMAMI_WEBSITE_ID;
const domains = import.meta.env.PUBLIC_UMAMI_DOMAINS;    // acmewidgets.com
---
{id && (
  <>
    <script is:inline defer src={`${host}/script.js`} data-website-id={id}
            data-domains={domains} data-performance="true" data-do-not-track="true"></script>
    <script is:inline defer src={`${host}/recorder.js`} data-website-id={id}></script>
  </>
)}
```

`data-domains` keeps preview deployments (`*.workers.dev`, PR previews) out of the stats.

| Attribute | Use |
|---|---|
| `data-domains` | Comma list of hostnames that may report |
| `data-performance="true"` | Core Web Vitals into the Performance report |
| `data-do-not-track="true"` | Honour the browser's Do Not Track |
| `data-exclude-search="true"` | Drop query strings (use when URLs carry tokens) |
| `data-exclude-hash="true"` | Drop `#fragments` |
| `data-tag` | Label all events, e.g. an A/B variant |
| `data-auto-track="false"` | Send everything by hand |
| `data-before-send` | Name of a window function that edits or drops a payload |
| `data-distinct-id` | Visitor ID set at load (3.4.0), 50 chars max |

## 6. Events that matter for a landing page

Name events with the [event taxonomy](event-taxonomy.md). Data attributes need no JavaScript:

```html
<a href="#pricing" data-umami-event="cta-click" data-umami-event-location="hero">See pricing</a>
```

Revenue (Umami 2.14+) needs both `revenue` and an ISO 4217 `currency`. Send it when the payment is
confirmed — the success page after Stripe Checkout, or server-side from the webhook with
`@umami/node`:

```js
umami.track('checkout-complete', { revenue: 49, currency: 'USD', plan: 'pro' });
```

## 7. Verify

```bash
curl -s -o /dev/null -w "%{http_code}\n" https://umami.acmewidgets.com/script.js     # 200
curl -s -o /dev/null -w "%{http_code}\n" https://umami.acmewidgets.com/recorder.js   # 200
curl -s -o /dev/null -w "%{http_code}\n" https://umami.acmewidgets.com/login         # 403
umami-cli realtime get <website-id>    # after opening the live site once
```

Then open the site with an ad blocker off and confirm the visit in realtime. A replay appears only
for a sampled session; set `sampleRate` to 1 while testing and back afterwards.
