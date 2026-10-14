# Stripe

One Stripe account for every brand; products per brand. Use the official `stripe-best-practices`
and `stripe-docs` skills (stripe/ai) for API details — this page says which pattern a site uses.

## Pick the pattern

| The site sells | Use | Code |
|---|---|---|
| A fixed price (a service, a one-off product, a plan) | **Payment Link** | none: `paymentLink` in `plans.json` |
| Quantities, computed prices, metadata from a form | **Checkout Session** | `/api/checkout` in the template |
| Subscriptions with self-serve management | Checkout Session (subscription mode) + Customer Portal link | `/api/checkout`, portal link in the app |

Payment Links are the default: no server code, nothing to secure, and Stripe hosts the page.

## Products per brand

Name and tag every object so one account stays readable:

- Product name: `<Brand> — <Plan>`.
- Product and price `metadata.brand = <brand>`, `metadata.site = <domain>`.
- Payment Link `after_completion` redirects to `https://<domain>/thanks?session_id={CHECKOUT_SESSION_ID}`.
- Statement descriptor suffix per brand where the account allows it.

Create in **test mode** first, with the Stripe CLI or API (keys from the vault):

```bash
stripe products create --name "Acme — Audit" -d "metadata[brand]=acme" -d "metadata[site]=acmewidgets.com"
stripe prices create --product prod_... --unit-amount 14900 --currency usd
stripe payment_links create -d "line_items[0][price]=price_..." -d "line_items[0][quantity]=1" \
  -d "after_completion[type]=redirect" \
  -d "after_completion[redirect][url]=https://acmewidgets.com/thanks?session_id={CHECKOUT_SESSION_ID}"
```

Put the link URL (or the price ID for Checkout) in `plans.json`. Prices on the page and in JSON-LD
come from `plans.json`, so they cannot drift from what Stripe charges as long as the amount matches —
the launch gate checks that.

## Webhook

Needed for Checkout Sessions and for anything that must happen after payment (email, provisioning).

```bash
stripe webhook_endpoints create --url https://acmewidgets.com/api/stripe-webhook \
  -d "enabled_events[]=checkout.session.completed"
```

Store the signing secret in the vault as this brand's webhook item, then `wrangler secret put
STRIPE_WEBHOOK_SECRET`. Fulfilment code must be idempotent: Stripe retries.

## Revenue in Umami

`/thanks` retrieves the session on the server and fires `checkout-complete` with `revenue` and
`currency` only when `payment_status` is `paid`. That needs `STRIPE_SECRET_KEY` on the Worker even
for Payment Links.

## Going live

After the launch gate's test purchase passes: recreate products, prices, links and the webhook in
live mode (IDs differ), update `plans.json`, swap the Worker secrets to live keys, run one real
purchase and refund it.
