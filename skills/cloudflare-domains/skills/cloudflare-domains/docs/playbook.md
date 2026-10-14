<!-- Authored for this skill. Commands come from Cloudflare's cf CLI; see the cf-cli skill. -->

# New domain playbook

The order an agent follows to take a domain from "idea" to "serving a Worker with email, redirects and
indexing hints". Only step 2 spends money. Run every command through Varlock so the token never shows
(see [secrets](secrets.md)); `D` is the domain.

```bash
D=acmewidgets.com
```

## 1. Search and check

```bash
cf registrar registrations search --query "acme widgets"
cf registrar registrations check "$D" acmewidgets.dev
```

Check again right before registering: availability and price change.
`extension_not_supported_via_api` means the TLD is dashboard-only: tell the owner, do not retry.

## 2. Register — the money gate

Registration charges the account's default payment method at once and is **not refundable**.
Cloudflare has no approval step of its own.

**Stop and ask the owner once**, with the exact domain, the first-year price and the renewal price
from the check. Register only after an explicit yes for that domain.

```bash
cf registrar registrations create "$D" --help    # fields differ per TLD
cf registrar registrations create "$D" --dry-run # show the request
cf registrar registrations create "$D"           # after the yes
cf registrar registrations get-registration-status "$D"   # poll; stop on action_required or failed
```

A domain registered at Cloudflare is already a zone in the account. A domain bought elsewhere:
`cf zones create`, then the owner changes the nameservers at the old registrar, then continue.

## 3. Point the apex at the Worker

Use a Worker **custom domain**: it creates the DNS record and the certificate. In the site's
`wrangler.jsonc`:

```jsonc
"routes": [{ "pattern": "acmewidgets.com", "custom_domain": true }]
```

The next `wrangler deploy` (or Workers Builds run) attaches it.

## 4. www → apex

See [redirects](redirects.md): a proxied placeholder record for `www`, then one redirect rule.

## 5. HTTPS, DNSSEC, Crawler Hints

```bash
cf zones settings edit always_use_https -z "$D" --body '{"value":"on"}'
cf dns dnssec edit -z "$D" --body '{"status":"active"}'
```

DNSSEC on a Cloudflare Registrar domain needs nothing else; for a domain registered elsewhere, give
the owner the DS record from `cf dns dnssec get -z "$D"`.

Crawler Hints (IndexNow pings to Bing and others when pages change) is documented as a dashboard
switch (Caching → Configuration). Try `cf zones settings get crawler_hints -z "$D"`; if it answers,
turn it on with `cf zones settings edit crawler_hints -z "$D" --body '{"value":"on"}'`, otherwise ask
the owner to flip it once. Google does not use IndexNow.

## 6. Email

Forward `info@<domain>` to the owner's inbox with Email Routing: see [email-routing](email-routing.md).
Do it before launch: Search Console, Stripe and Resend all send mail to the domain.

## 7. Hostnames for self-hosted services

A service on a home server (a self-hosted Umami, for example) gets its public hostname through the
existing Cloudflare Tunnel: see [tunnel-hostnames](tunnel-hostnames.md).

## Verify

```bash
dig +short "$D"
curl -sI "https://www.$D/" | grep -i '^location'   # → https://acmewidgets.com/
curl -sI "http://$D/" | grep -i '^location'        # → https://
cf email-routing settings get -z "$D" | jq '{enabled, status}'
```
