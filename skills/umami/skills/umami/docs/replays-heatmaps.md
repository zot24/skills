<!-- Authored for this skill. Not synced from upstream.
     Sources: https://docs.umami.is/docs/replays, https://docs.umami.is/docs/heatmaps,
     umami-software/umami v3.4.0 (src/recorder/index.js, src/lib/recorder.ts,
     src/app/api/websites/[websiteId]/route.ts). -->

# Session replays and heatmaps

Both features ship in Umami itself — no third-party recorder. Replays arrived in **3.1.0**, heatmaps
in **3.2.0**. Both use one extra script, `recorder.js`, next to the normal tracker.

## How it fits together

| Piece | Path on the Umami host | Auth |
|---|---|---|
| Tracker | `/script.js` (or `TRACKER_SCRIPT_NAME`) | none |
| Pageviews, events, Web Vitals | `POST /api/send` (or `COLLECT_API_ENDPOINT`) | none |
| Recorder | `/recorder.js` | none |
| Recorder settings | `GET /api/websites/<id>/recorder` | none, read-only |
| Replay and heatmap data | `POST /api/record` | none |

The recorder fetches its settings first. When the website has neither feature on, it records nothing,
so the tag is safe to ship before the features are enabled.

## Enable per website (API)

The dashboard path is **Websites → Edit → Replays & Heatmaps**. The same switch is the `replayConfig`
object on the website update endpoint. Umami merges it with the stored config, so send only the
keys you change. `umami-cli websites update` does not expose it yet — use the API with the CLI's
session token or a fresh login token:

```bash
TOKEN=$(curl -s -X POST "$UMAMI_URL/api/auth/login" -H "Content-Type: application/json" \
  -d "{\"username\":\"$UMAMI_USERNAME\",\"password\":\"$UMAMI_PASSWORD\"}" | jq -r .token)

curl -s -X POST "$UMAMI_URL/api/websites/$WEBSITE_ID" \
  -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{
  "replayConfig": {
    "replayEnabled": true,
    "heatmapEnabled": true,
    "sampleRate": 0.15,
    "heatmapSampleRate": 0.15,
    "maskLevel": "moderate",
    "maxDuration": 300000
  }
}'

curl -s "$UMAMI_URL/api/websites/$WEBSITE_ID/recorder" | jq   # public view of the result
```

| Key | Meaning | Default |
|---|---|---|
| `replayEnabled` | Record sessions | off |
| `heatmapEnabled` | Collect clicks and scroll depth | off |
| `sampleRate` | Share of sessions recorded, 0–1 | `0.15` |
| `heatmapSampleRate` | Share of sessions in heatmaps, 0–1 | `0.15` |
| `maskLevel` | `moderate` masks inputs; `strict` masks inputs and all text | `moderate` |
| `maxDuration` | Recording cap in ms | `300000` |
| `blockSelector` | CSS selector left out of recordings | none |

Use `strict` on any page that shows personal or payment data. Add `blockSelector` for embedded
checkout or account widgets. Replays are kept 30 days. Nothing is backfilled: only sessions that start
after enabling are recorded.

## The tag

Same website ID as the tracker:

```html
<script defer src="https://umami.acmewidgets.com/recorder.js"
        data-website-id="<website-id>"></script>
```

## Heatmap page previews

The heatmap view loads the page in an iframe behind the click overlay. A page that refuses framing
still gets a heatmap, drawn on a blank canvas. To get the preview, the site must allow the origin the
dashboard is opened from:

```text
Content-Security-Policy: frame-ancestors 'self' <dashboard-origin>;
```

and must not send `X-Frame-Options`. When the dashboard sits on a private network, its origin is a
private hostname: do not commit it, and remember a response header shows it to every visitor. Default
is to skip the header and live with the blank canvas; if the owner wants previews, inject the origin at
build time from an environment variable.

## Public exposure

When the Umami host is public only for collection (see `cloudflare-domains` → tunnel hostnames), the
allow-list must cover every row of the table above, or replays and heatmaps fail silently. A blocked
`/api/record` or `/api/websites/<id>/recorder` shows up as zero recordings, not as an error.
