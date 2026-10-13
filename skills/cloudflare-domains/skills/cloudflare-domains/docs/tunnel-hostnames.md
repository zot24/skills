<!-- Authored for this skill. Not synced from upstream. -->

# Public hostnames on an existing tunnel

For a service that runs on a home server behind a **remote-managed** Cloudflare Tunnel (installed
with a token, configured from the dashboard or API). Typical use: a self-hosted analytics instance
served at `umami.<site-domain>` for each site.

Upstream references: [remote-tunnel-api](remote-tunnel-api.md) and
[tunnel-dns-records](tunnel-dns-records.md).

## 1. Find the tunnel

```bash
curl -s "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/cfd_tunnel?is_deleted=false" "${AUTH[@]}" \
  | jq '.result[] | {id, name, status}'
```

The tunnel's name or ID is the owner's private configuration: read it from the environment
(`CF_TUNNEL_ID`) or ask once. Never commit it.

## 2. Add the ingress rule — read, insert, write back

`PUT .../configurations` **replaces the whole ingress list**. Dropping an entry takes another service
offline. Always:

```bash
CFG=$(curl -s "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/cfd_tunnel/$CF_TUNNEL_ID/configurations" "${AUTH[@]}")
echo "$CFG" | jq '.result.config.ingress'          # keep this output for rollback

NEW=$(echo "$CFG" | jq --arg h "umami.acmewidgets.com" --arg s "http://umami:3000" '
  .result.config
  | .ingress = ([.ingress[] | select(.hostname != null and .hostname != $h)]
               + [{hostname: $h, service: $s}]
               + [.ingress[] | select(.hostname == null)])')   # catch-all stays last

curl -s -X PUT "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/cfd_tunnel/$CF_TUNNEL_ID/configurations" "${AUTH[@]}" \
  -d "{\"config\": $NEW}"
```

The `service` is the address the tunnel connector reaches on the home network. Copy it from an existing
ingress entry for the same app rather than guessing.

## 3. DNS record

```bash
curl -s -X POST "$CF/zones/$ZONE/dns_records" "${AUTH[@]}" -d "{
  \"type\": \"CNAME\", \"name\": \"umami\", \"proxied\": true, \"ttl\": 1,
  \"content\": \"$CF_TUNNEL_ID.cfargotunnel.com\"
}"
```

Use a single-level subdomain: a multi-level one (`a.b.example.com`) needs an Advanced Certificate.

## 4. Expose only what the public needs

A tracker hostname must serve its script and collection endpoint to every visitor, but its admin UI
should not be on the internet. Add a WAF custom rule on the hostname that blocks everything except the
public paths (see [waf-custom-rules-api](waf-custom-rules-api.md); same read-before-write rule as
redirects, phase `http_request_firewall_custom`). For Umami:

```
(http.host eq "umami.acmewidgets.com" and not (
  http.request.uri.path in {"/script.js" "/recorder.js" "/api/send" "/api/record"}
  or (http.request.method in {"GET" "OPTIONS"}
      and starts_with(http.request.uri.path, "/api/websites/")
      and ends_with(http.request.uri.path, "/recorder"))
))
```

with action `block`. `/api/record` and `/api/websites/<id>/recorder` carry session replays and
heatmaps (Umami 3.1+); leave them out and recording fails with no error. The owner reaches the
dashboard over their private network instead. Confirm the public paths against the `umami` skill
before applying: a custom `TRACKER_SCRIPT_NAME` renames `/script.js`.

## Check

```bash
curl -s -o /dev/null -w "%{http_code}\n" https://umami.acmewidgets.com/script.js   # 200
curl -s -o /dev/null -w "%{http_code}\n" https://umami.acmewidgets.com/login       # 403
```
