<!-- Authored for this skill. Not synced from upstream. -->

# New domain playbook

The order an agent follows to take a domain from "idea" to "serving a Worker with email, redirects and
indexing hints". Every step is an API call or a `wrangler` command. Only step 2 spends money.

All calls use:

```bash
CF=https://api.cloudflare.com/client/v4
AUTH=(-H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" -H "Content-Type: application/json")
```

`CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` come from 1Password through Varlock — see
[secrets](secrets.md). Never echo either value.

## 1. Search and check

```bash
curl -s "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/registrar/domain-search?q=acme%20widgets&limit=5" "${AUTH[@]}"
curl -s -X POST "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/registrar/domain-check" "${AUTH[@]}" \
  -d '{"domains":["acmewidgets.com","acmewidgets.dev"]}'
```

Run the check again right before registering: availability and price change.
`extension_not_supported_via_api` means the TLD is dashboard-only — tell the user, do not retry.

## 2. Register — the money gate

Registration charges the account's default payment method immediately and is **not refundable**.
There is no approval step on Cloudflare's side.

**Stop and ask the user once**, showing the exact domain, the yearly price and the renewal price from
the check response. Register only after an explicit yes for that domain.

```bash
curl -s -X POST "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/registrar/registrations" "${AUTH[@]}" \
  -H "Prefer: respond-async" -d '{"domain_name":"acmewidgets.com"}'
# 202 → poll; stop on action_required or failed and read error.code
curl -s "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/registrar/registrations/acmewidgets.com/registration-status" "${AUTH[@]}"
```

Details: [registrar-api](registrar-api.md). A domain registered at Cloudflare is already a zone in the
account; a domain bought elsewhere must be added as a zone and its nameservers changed first.

## 3. Zone ID

```bash
ZONE=$(curl -s "$CF/zones?name=acmewidgets.com" "${AUTH[@]}" | jq -r '.result[0].id')
```

## 4. Point the apex at the Worker

Prefer a Worker **custom domain** over hand-made DNS records: it creates the DNS record and the
certificate for you. In the site's `wrangler.jsonc`:

```jsonc
"routes": [{ "pattern": "acmewidgets.com", "custom_domain": true }]
```

`wrangler deploy` then attaches it. Details: [workers-custom-domains](workers-custom-domains.md).

## 5. www → apex

A redirect needs a proxied record to exist for `www`. Create a placeholder, then one Single Redirect:

```bash
curl -s -X POST "$CF/zones/$ZONE/dns_records" "${AUTH[@]}" \
  -d '{"type":"AAAA","name":"www","content":"100::","proxied":true,"ttl":1}'
```

Then add the rule to the `http_request_dynamic_redirect` entry point (create it if absent, otherwise
update it and **keep the rules already there**) — see [redirects](redirects.md).

## 6. HTTPS and DNSSEC

```bash
curl -s -X PATCH "$CF/zones/$ZONE/settings/always_use_https" "${AUTH[@]}" -d '{"value":"on"}'
```

DNSSEC: Cloudflare Registrar domains enable it in one step — see [dnssec](dnssec.md).

## 7. Email

Forward `hello@` (or a catch-all) to the owner's inbox with Email Routing — see
[email-routing](email-routing.md). Do it before launch: Search Console and Stripe both send mail to
the domain.

## 8. Crawler Hints (IndexNow)

Turn on Crawler Hints so Bing, Yandex and other IndexNow engines hear about changed pages. The
documented switch is the dashboard (**Caching → Configuration → Crawler Hints**); see
[crawler-hints](crawler-hints.md). Google does not take part in IndexNow.

## 9. Hostnames for self-hosted services

A service on a home server (a self-hosted Umami, for example) gets its public hostname through the
existing Cloudflare Tunnel — see [tunnel-hostnames](tunnel-hostnames.md).

## Verify

```bash
dig +short acmewidgets.com
curl -sI https://www.acmewidgets.com | grep -i '^location'   # → https://acmewidgets.com/
curl -sI http://acmewidgets.com | grep -i '^location'        # → https://
```
