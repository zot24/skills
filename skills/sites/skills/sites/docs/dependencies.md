# Dependencies

`sites` calls other skills; it never copies them.

## From zot24/skills

Installed together with zskills:

```bash
zskills marketplace add zot24/skills
zskills install sites cloudflare-domains umami search-engines seo-geo site-design-options 1password-cli
```

## Official skills

| Source | Skills used | Install |
|---|---|---|
| cloudflare/skills | `cf-cli`, `wrangler`, `workers-best-practices`, `web-perf` | `/plugin marketplace add cloudflare/skills` |
| stripe/ai | `stripe-best-practices`, `stripe-docs` | `/plugin marketplace add stripe/ai` |
| resend/resend-skills | `resend-cli`, `resend`, `email-best-practices`, `react-email` | `npx skills add resend/resend-skills` |

If a dependency is missing, say which one and keep going with the docs it would have provided
(developers.cloudflare.com, docs.stripe.com, resend.com/docs) rather than guessing.

## Tools on the machine

| Tool | Used for | Check |
|---|---|---|
| `pnpm`, Node 22+ | build | `pnpm -v` |
| `wrangler` | deploys, secrets, types | in `apps/web` devDependencies |
| `cf` | Cloudflare API: domains, DNS, rules, email routing, tunnels | `cf --version` (`npm i -g cf`, Node 22.18+) |
| `umami-cli` | Umami websites | `umami-cli --version` |
| `stripe` CLI | products, links, webhooks | `stripe --version` |
| `resend` CLI | email domain, keys, test sends | `resend --version` (`npm i -g resend-cli`) |
| `gcloud` | Search Console token | `gcloud --version` |
| `varlock` or `op` | secrets | `varlock --version` / `op --version` |
| `jq`, `curl` | API calls | — |
