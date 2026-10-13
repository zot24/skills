<!-- Authored for this skill. Commands come from Cloudflare's cf CLI; see the cf-cli skill. -->

# Email Routing

Forward mail for the domain to the owner's existing inbox. No mailbox is created; Cloudflare adds the
MX and SPF records itself. Sending from the domain is a separate service: the `sites` skill uses
Resend for it, on `send.<domain>`, so the two never collide.

## 1. Enable on the zone (adds MX + SPF)

```bash
cf dns records list -z "$D" --type MX | jq 'length'   # anything but 0: ask the owner first
cf email-routing enable -z "$D"
cf email-routing settings get -z "$D" | jq '{enabled, status}'
```

Existing MX records mean mail already goes somewhere else. Enabling moves it: ask before doing that.

## 2. Destination address (account level, verified once)

The owner's address is private: read it from the environment (`OWNER_EMAIL`), never from the repo.

```bash
cf email-routing addresses list | jq '.[] | {email, verified}'
cf email-routing addresses create --body "$(jq -nc --arg e "$OWNER_EMAIL" '{email:$e}')"
```

Cloudflare mails a verification link to that address. A rule that forwards to an unverified address
drops mail silently, so tell the owner to click it, then check `verified` is set. Reuse a verified
address for every site; never ask for it again.

## 3. Forward info@

```bash
cf email-routing rules create -z "$D" --body "$(jq -nc --arg to "info@$D" --arg e "$OWNER_EMAIL" '{
  name: "info", enabled: true,
  matchers: [{type: "literal", field: "to", value: $to}],
  actions:  [{type: "forward", value: [$e]}] }')"
```

Or a catch-all, for sites that list several addresses:

```bash
cf email-routing rules catch-all update -z "$D" --body "$(jq -nc --arg e "$OWNER_EMAIL" '{
  enabled: true, matchers: [{type: "all"}], actions: [{type: "forward", value: [$e]}] }')"
```

## Check

Mail `info@<domain>` from another account; it arrives in the owner's inbox within a minute.
