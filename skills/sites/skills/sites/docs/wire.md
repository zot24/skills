# Step 6 — wire the site

Each block hands off to the skill that owns it, then records evidence in `site-plan.md`. Blocks are
independent; run them in this order when doing them one after another.

## 1. Domain

`cloudflare-domains` → `setup <domain>`. For a new domain the money gate applies: show the domain,
first-year price and renewal price, and wait for an explicit yes. Then: zone, Worker custom domain
(already declared in `wrangler.jsonc`), www → apex, Always Use HTTPS, DNSSEC, Email Routing for the
brief's contact address, Crawler Hints.

## 2. Workers Builds

Connecting a repo to a Worker needs the Cloudflare Workers & Pages GitHub app on the repo's owner,
which only the owner can install. Check first: `GET /accounts/{id}/builds/workers/{script}/triggers`
lists a Worker's existing connection, and an account where every Worker returns `[]` has none yet.
The Builds API (`/builds/repos/connections`, `/builds/triggers`) can create the trigger once the app
is installed; otherwise ask the owner to open Workers & Pages → Create → Import a repository, pick
the repo, and set:

| Setting | Value |
|---|---|
| Worker name | the `name` in `apps/web/wrangler.jsonc` |
| Root directory | `apps/web` |
| Build command | `pnpm build` |
| Deploy command | `npx wrangler deploy` |
| Non-production branch builds | on (preview command default) |
| Build watch paths | include `apps/web/*`, `packages/*`, `pnpm-lock.yaml` |
| Runtime secrets | `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET`, `RESEND_API_KEY` (Settings → Variables & Secrets) |

Then verify from the PR: the Cloudflare check run appears and posts a preview URL. The preview must
serve `Disallow: /` at `/robots.txt`.

Secrets can also go up from the agent:

```bash
cd apps/web
varlock run -- sh -c 'printf %s "$STRIPE_SECRET_KEY" | npx wrangler secret put STRIPE_SECRET_KEY'
```

## 3. Umami

`umami` → `site <domain>`: public hostname `umami.<domain>` on the tunnel with the five-path WAF rule,
website created with `umami-cli`, replays and heatmaps on, then put the website ID in
`apps/web/.env` (`PUBLIC_UMAMI_WEBSITE_ID`). The template's `Analytics.astro` does the rest.

## 4. Stripe

See [stripe](stripe.md). Test mode until the launch gate.

## 5. SEO + GEO

`seo-geo` → `setup` is already in the template; this block fills content-dependent parts: page titles
and descriptions from the copy spec, JSON-LD types per page, `sameAs` profiles, the robots training
choice from the brief, and the Cloudflare AI bot policies (Search and Agent allowed).

## 6. Email

See [email](email.md): Resend domain, DNS into Cloudflare, a sending-only key on the Worker, and
`info@<domain>` routed to the owner by block 1.

## 7. Other services

When the brief needs something the stack does not cover (a database beyond D1, queues), prefer
Cloudflare first (D1, KV, R2, Queues). Anything else needs a CLI or an API the agent can drive; if
neither exists, say so in the plan before choosing it. Any paid tier goes through the money gate.
