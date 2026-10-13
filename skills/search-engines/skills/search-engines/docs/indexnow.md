<!-- Authored for this skill. Not synced from upstream.
     Protocol: https://www.indexnow.org/documentation -->

# IndexNow

One ping tells Bing, Yandex, Naver, Seznam and the other participating engines that a URL changed.
Google does not take part — Search Console and the sitemap cover Google.

## Default: Cloudflare Crawler Hints

On a Cloudflare-proxied zone (a Worker custom domain is proxied), turn on **Crawler Hints** with the
`cloudflare-domains` skill. Cloudflare then sends IndexNow pings for changed pages by itself, with its
own key. Nothing to add to the site. This is the default for every site.

## Manual pings (optional)

Use these when a launch or a big content change should be announced at once, or when the zone is not
on Cloudflare.

1. Make a key: 8–128 characters, `a-z`, `A-Z`, `0-9`, `-`.
   ```bash
   KEY=$(openssl rand -hex 16)
   ```
2. Host it at the site root as `public/$KEY.txt`, containing only the key. The key is public by
   design; it proves you control the host.
3. Ping:
   ```bash
   curl -s -o /dev/null -w "%{http_code}\n" -X POST https://api.indexnow.org/indexnow \
     -H "Content-Type: application/json; charset=utf-8" -d "{
     \"host\": \"acmewidgets.com\",
     \"key\": \"$KEY\",
     \"keyLocation\": \"https://acmewidgets.com/$KEY.txt\",
     \"urlList\": [\"https://acmewidgets.com/\", \"https://acmewidgets.com/pricing\"]
   }"
   ```

| Code | Meaning |
|---|---|
| 200 | Accepted |
| 202 | Accepted, key check pending |
| 400 | Bad request |
| 403 | Key not found at `keyLocation` |
| 422 | URL does not belong to `host`, or the key does not match |
| 429 | Too many requests — slow down |

Ping only URLs that changed. Up to 10,000 URLs per request. Pinging unchanged pages repeatedly gets a
host throttled.
