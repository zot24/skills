<!-- Authored for this skill. Commands come from Cloudflare's cf CLI; see the cf-cli skill. -->

# www → apex redirect

One Single Redirect rule in the zone's `http_request_dynamic_redirect` phase.

## 1. A proxied record for www

The request only reaches the rule if `www` resolves through Cloudflare:

```bash
cf dns records create -z "$D" --body '{"type":"AAAA","name":"www","content":"100::","proxied":true,"ttl":1}'
```

## 2. Add the rule next to the ones already there

`cf rulesets entrypoint update` replaces every rule in the phase, so use it only when the phase has no
entry point yet. Otherwise add one rule with `cf rulesets rules create`.

```bash
RULE=$(jq -nc --arg d "$D" '{
  description: "www to apex",
  expression: "(http.host eq \"www.\($d)\")",
  action: "redirect",
  action_parameters: { from_value: {
    status_code: 301,
    target_url: { expression: "concat(\"https://\($d)\", http.request.uri.path)" },
    preserve_query_string: true } } }')

if RS=$(cf rulesets entrypoint get http_request_dynamic_redirect -z "$D" 2>/dev/null | jq -er .id); then
  cf rulesets entrypoint get http_request_dynamic_redirect -z "$D" \
    | jq -e --arg d "$D" '.rules // [] | any(.description == "www to apex")' >/dev/null \
    || cf rulesets rules create "$RS" -z "$D" --body "$RULE"
else
  cf rulesets entrypoint update http_request_dynamic_redirect -z "$D" --rules "[$RULE]"
fi
```

The same pattern adds any other redirect (an old domain, a moved path); change the description so the
duplicate check still works.

## Check

```bash
curl -sI "https://www.$D/pricing?ref=x" | grep -i '^location'
# location: https://acmewidgets.com/pricing?ref=x
```
