<!-- Authored for this skill. Not synced from upstream. -->

# www → apex redirect

One Single Redirect rule in the zone's `http_request_dynamic_redirect` entry point. The upstream
reference is [single-redirects-api](single-redirects-api.md); the rule itself mirrors
[redirect-www-to-root](redirect-www-to-root.md).

## Never clobber existing rules

`PUT` on an entry point **replaces every rule in it**. Always read first:

```bash
curl -s "$CF/zones/$ZONE/rulesets/phases/http_request_dynamic_redirect/entrypoint" "${AUTH[@]}"
```

- `404` → no entry point yet: create it with `PUT` containing only the new rule.
- `200` → it exists: add the rule with `POST .../rulesets/<ruleset_id>/rules` (appends one rule), or
  `PUT` the full list with the existing rules kept.

## The rule

```bash
curl -s -X PUT "$CF/zones/$ZONE/rulesets/phases/http_request_dynamic_redirect/entrypoint" "${AUTH[@]}" -d '{
  "rules": [{
    "description": "www to apex",
    "expression": "(http.host eq \"www.acmewidgets.com\")",
    "action": "redirect",
    "action_parameters": {
      "from_value": {
        "status_code": 301,
        "target_url": { "expression": "concat(\"https://acmewidgets.com\", http.request.uri.path)" },
        "preserve_query_string": true
      }
    }
  }]
}'
```

The `www` hostname needs a proxied DNS record (the `AAAA 100::` placeholder in the
[playbook](playbook.md)), or the request never reaches the rule.

## Check

```bash
curl -sI "https://www.acmewidgets.com/pricing?ref=x" | grep -i '^location'
# location: https://acmewidgets.com/pricing?ref=x
```
