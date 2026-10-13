# Email — Resend on the site's domain

Every site sends from `info@<domain>` through Resend and receives `info@<domain>` through Cloudflare
Email Routing. Everything below runs from the CLI or the API; the agent does it without asking.

| Direction | Service | Who sets it up |
|---|---|---|
| Out: `info@<domain>` → visitors (receipts, form replies, notifications) | Resend | this doc |
| In: visitors → `info@<domain>` → the owner's inbox | Cloudflare Email Routing | `cloudflare-domains` → email |

The two do not collide: Resend's records live on `send.<domain>` and `resend._domainkey.<domain>`,
Email Routing owns the root MX.

## Tools

- `resend` CLI (`npm i -g resend-cli`), driven by Resend's own `resend-cli` skill: load it before
  running `resend` (non-interactive flags, `-q` for JSON, `--yes` on deletes).
- `scripts/resend-dns.sh` in this skill: the one step Resend does not do — writing its DNS records
  into Cloudflare, with Cloudflare's `cf` CLI.
- Content and deliverability rules: Resend's `email-best-practices` and `react-email` skills.

Auth for the setup runs is the account's full-access key, `RESEND_API_KEY` from the vault through
Varlock. It never goes into the site; the site gets its own key below.

## Setup, per site

```bash
cd apps/web
D=acmewidgets.com

# 1. Domain on Resend (root domain, so the sender can be info@$D). Region is fixed after creation.
varlock run -- resend domains create --name "$D" --region eu-west-1 -q | jq '{id, status}'

# 2. Records into Cloudflare, DMARC p=none if the zone has none, then verify and wait.
varlock run -- "$SITES_SKILL/scripts/resend-dns.sh" "$D"   # SITES_SKILL = this skill's folder

# 3. Tracking off: opens and clicks hurt deliverability on transactional mail.
varlock run -- resend domains update <domain-id> --no-open-tracking --no-click-tracking -q

# 4. A key that can only send, only from this domain. Shown once: piped straight into the vault
#    as an item template on stdin, so it never hits the screen or a process argument.
varlock run -- sh -c 'resend api-keys create --name "site-$0" --permission sending_access \
  --domain-id "$1" -q | jq --arg t "resend-$0" \
  "{title: \$t, category: \"API_CREDENTIAL\", fields: [{id: \"credential\", type: \"CONCEALED\", value: .token}]}" \
  | op item create --vault "$OP_VAULT" >/dev/null' "$D" <domain-id>
```

Then add `RESEND_SITE_KEY=op("op://${OP_VAULT}/resend-<domain>/credential")` to `.env.schema` and
push it to the Worker:

```bash
varlock run -- sh -c 'printf %s "$RESEND_SITE_KEY" | npx wrangler secret put RESEND_API_KEY'
```

Region: `eu-west-1` unless the brief's audience is mostly in the Americas (`us-east-1`,
`sa-east-1`) or Asia (`ap-northeast-1`).

If `domains create` says another Resend account already verified the domain, use
`resend domains claim` (Resend's skill has the lifecycle), then run the script again.

## In the site

`src/lib/email.ts` sends through Resend's REST API with `fetch` (no SDK on the Worker). The sender
comes from `site.json` → `email`. Use it only from server routes (`prerender = false`), for example in
the Stripe webhook (the template sends a thank-you there) or behind a form endpoint. Pass an idempotency key derived from
the event (the Stripe event ID) so retries never send twice.

## Check

| Check | Command | Pass |
|---|---|---|
| Domain | `resend domains get <id> -q \| jq .status` | `verified` |
| DMARC | `dig +short TXT _dmarc.<domain>` | one `v=DMARC1` record |
| Out | `resend emails send --from "info@<domain>" --to <owner address from env> --subject test --text test -q` | arrives, not in spam, SPF and DKIM pass in the headers |
| In | mail `info@<domain>` from another account | arrives in the owner's inbox |

Later, in review mode: `resend logs` and bounce and complaint counts. Bounces above 4% or complaints
above 0.08% stop marketing sends until fixed.
