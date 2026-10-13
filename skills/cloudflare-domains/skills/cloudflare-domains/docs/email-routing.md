<!-- Authored for this skill. Not synced from upstream.
     Endpoints follow the Cloudflare API reference (developers.cloudflare.com/api, "Email Routing").
     Cloudflare moved the Email Routing guides under Email Service; check the API reference
     if a call returns 404. -->

# Email Routing

Forward mail for the new domain to the owner's existing inbox. No mailbox is created; Cloudflare adds
the MX and SPF records itself.

## 1. Enable on the zone (adds MX + SPF)

```bash
curl -s -X POST "$CF/zones/$ZONE/email/routing/dns" "${AUTH[@]}"
curl -s "$CF/zones/$ZONE/email/routing" "${AUTH[@]}" | jq '.result | {enabled, status}'
```

If the zone already has MX records from another provider, stop and ask the owner: enabling replaces
where mail goes.

## 2. Destination address (account level, verified once)

```bash
curl -s -X POST "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/email/routing/addresses" "${AUTH[@]}" \
  -d '{"email":"owner@example.com"}'
```

Cloudflare emails a verification link to that address. A rule that forwards to an unverified address
silently drops mail, so tell the owner to click it, then check `verified` is set:

```bash
curl -s "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/email/routing/addresses" "${AUTH[@]}" \
  | jq '.result[] | {email, verified}'
```

Reuse an already verified address across every site; never ask for it again.

## 3. Rules

A named address:

```bash
curl -s -X POST "$CF/zones/$ZONE/email/routing/rules" "${AUTH[@]}" -d '{
  "name": "hello",
  "enabled": true,
  "matchers": [{ "type": "literal", "field": "to", "value": "hello@acmewidgets.com" }],
  "actions":  [{ "type": "forward", "value": ["owner@example.com"] }]
}'
```

Or a catch-all, for landing pages that list several addresses:

```bash
curl -s -X PUT "$CF/zones/$ZONE/email/routing/rules/catch_all" "${AUTH[@]}" -d '{
  "enabled": true,
  "matchers": [{ "type": "all" }],
  "actions":  [{ "type": "forward", "value": ["owner@example.com"] }]
}'
```

## Sending mail

Email Routing only receives. Sending from the domain (contact-form replies, receipts) is Cloudflare
Email Service — the official `cloudflare-email-service` skill in cloudflare/skills covers it.
