# Step 7 — launch gate

Every line passes before the site is called live and before search engines are told about it. Run it
on the production domain after the PR merges and Workers Builds deploys. Report only failures, each
with the fix.

```bash
SITE=https://acmewidgets.com
```

| Area | Check | Pass |
|---|---|---|
| Serving | `curl -sI $SITE/` | 200 over HTTPS, `cf-ray` header |
| Redirects | `curl -sI http://acmewidgets.com/` and `https://www.acmewidgets.com/` | 301 to `$SITE/` |
| Errors | `curl -s -o /dev/null -w '%{http_code}' $SITE/nope` | 404 |
| Indexable | `seo-geo` audit → crawlability | no `noindex`, robots allows, sitemap 200 |
| Pages | `seo-geo` audit → every page in the sitemap | titles, canonicals, one `h1`, one JSON-LD |
| GEO | `/llms.txt`, AI bot user agents | 200; Search and Agent bots not blocked |
| Performance | Lighthouse mobile on `$SITE/` | Performance ≥ 0.9, SEO 1.0, Accessibility ≥ 0.9 |
| Design | `pnpm --filter ./apps/web design:lint` | 0 errors |
| Tracking | open the site, then `umami-cli realtime get <id>` | the visit appears |
| Tracker host | `curl -sI https://umami.acmewidgets.com/script.js`, `/login` | 200, 403 |
| Events | click the main CTA once | the event appears in Umami |
| Payments | one purchase per plan with test card `4242 4242 4242 4242` | lands on `/thanks`, webhook 200 in Stripe, `checkout-complete` with revenue in Umami |
| Prices | `plans.json` vs Stripe prices | every amount and currency equal |
| Email out | [email](email.md) → Check: domain, DMARC, test send from `info@` | `verified`, lands in inbox with SPF and DKIM pass |
| Email in | mail `info@` from another account | arrives in the owner's inbox |
| Secrets | `git grep -nE 'sk_(live|test)_|whsec_|re_[A-Za-z0-9]{8}|op://[^<$]'` in `apps/web` | nothing |
| Brief | every `Open` item in `site-brief.md` | answered, or its fallback string ships |

When every line passes: switch Stripe to live ([stripe](stripe.md) → Going live), run the
`search-engines` launch playbook, mark the plan, and tell the owner the site is live with the URL.
