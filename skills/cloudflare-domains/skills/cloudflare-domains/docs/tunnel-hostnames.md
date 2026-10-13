<!-- Authored for this skill. Commands come from Cloudflare's cf CLI; see the cf-cli skill. -->

# Public hostnames on an existing tunnel

For a service on a home server behind a **remote-managed** Cloudflare Tunnel (installed with a token,
configured from the dashboard or API). Typical use: a self-hosted Umami served at
`umami.<site-domain>` for each site.

## 1. Find the tunnel

```bash
cf tunnels list | jq '.[] | select(.deleted_at == null) | {id, name, status}'
```

The tunnel ID is the owner's private configuration: read it from the environment (`CF_TUNNEL_ID`) or
ask once. Never commit it.

## 2. Add the ingress rule — read, merge, write back

`cf tunnels config update` replaces the whole ingress list, and dropping an entry takes another
service offline. Always:

```bash
H=umami.acmewidgets.com
cf tunnels config get "$CF_TUNNEL_ID" > /tmp/tunnel-before.json     # keep for rollback
jq '.config.ingress' /tmp/tunnel-before.json                         # find the service address

NEW=$(jq --arg h "$H" --arg s "http://umami:3000" '
  .config | .ingress = ([.ingress[] | select(.hostname != null and .hostname != $h)]
                       + [{hostname: $h, service: $s}]
                       + [.ingress[] | select(.hostname == null)])' /tmp/tunnel-before.json)  # catch-all last

cf tunnels config update "$CF_TUNNEL_ID" --body "$(jq -nc --argjson c "$NEW" '{config: $c}')"
```

The `service` is the address the connector reaches on the home network. Copy it from an existing
ingress entry for the same app rather than guessing.

## 3. DNS record

```bash
cf dns records create -z acmewidgets.com --body "$(jq -nc --arg t "$CF_TUNNEL_ID.cfargotunnel.com" \
  '{type: "CNAME", name: "umami", content: $t, proxied: true, ttl: 1}')"
```

Use a single-level subdomain: a multi-level one (`a.b.example.com`) needs an Advanced Certificate.

## 4. Expose only what the public needs

A tracker hostname must serve its script and collection endpoints to every visitor, but its admin UI
should not be on the internet. Add one WAF custom rule (phase `http_request_firewall_custom`) with
action `block`, using the same add-don't-replace pattern as [redirects](redirects.md). For Umami, save
this expression as `waf.txt`:

```
(http.host eq "umami.acmewidgets.com" and not (
  http.request.uri.path in {"/script.js" "/recorder.js" "/api/send" "/api/record"}
  or (http.request.method in {"GET" "OPTIONS"}
      and starts_with(http.request.uri.path, "/api/websites/")
      and ends_with(http.request.uri.path, "/recorder"))
))
```

```bash
RULE=$(jq -nc --arg e "$(cat waf.txt)" --arg h "$H" \
  '{description: "lock \($h)", expression: $e, action: "block"}')
if RS=$(cf rulesets entrypoint get http_request_firewall_custom -z acmewidgets.com 2>/dev/null | jq -er .id); then
  cf rulesets rules create "$RS" -z acmewidgets.com --body "$RULE"
else
  cf rulesets entrypoint update http_request_firewall_custom -z acmewidgets.com --rules "[$RULE]"
fi
```

`/api/record` and `/api/websites/<id>/recorder` carry session replays and heatmaps (Umami 3.1+);
leave them out and recording fails with no error. The owner reaches the dashboard over their private
network instead. Confirm the public paths against the `umami` skill first: a custom
`TRACKER_SCRIPT_NAME` renames `/script.js`.

## Check

```bash
curl -s -o /dev/null -w "%{http_code}\n" https://umami.acmewidgets.com/script.js   # 200
curl -s -o /dev/null -w "%{http_code}\n" https://umami.acmewidgets.com/login       # 403
```

Rollback: `cf tunnels config update "$CF_TUNNEL_ID" --body "$(jq -c '{config}' /tmp/tunnel-before.json)"`.
