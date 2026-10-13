# Step 1 — read the repo

Before any question, learn what the repo already says. Every fact found here is one question the
owner does not have to answer. Read-only.

## What to find

| Fact | Where to look |
|---|---|
| Monorepo shape | `pnpm-workspace.yaml`, `turbo.json`, `package.json` workspaces, `apps/`, `packages/` |
| Existing site | `apps/web`, `site/`, `www/`, `landing/`, an Astro or Next config, a `wrangler.jsonc` with routes |
| The product | `apps/app` or the main package: README, pricing in code, plan names, sign-up URL, auth provider |
| Brand | logo files, colours and fonts in a theme, an existing `DESIGN.md`, app `tailwind` tokens |
| Domains | `wrangler.jsonc` routes, `CNAME`, env files, README links, `site` in an Astro config |
| Analytics | Umami script tags or website IDs; any GA or other tracker to remove |
| Payments | Stripe usage in the app (product and price IDs, webhooks), Payment Links in content |
| Search | `robots.txt`, sitemap, verification files (`google*.html`, `BingSiteAuth.xml`) |
| Project rules | `CLAUDE.md`, `AGENTS.md`, `CONTEXT.md`, contributing guides, PR template |
| Open work | open PRs and issues touching the site, unmerged branches |

```bash
git -C "$REPO" ls-files | grep -Ei '(^apps/|^packages/|wrangler|astro.config|DESIGN.md|robots|sitemap)' | head -100
rg -n --hidden -g '!node_modules' -i 'stripe\.(prices|products|checkout)|price_[A-Za-z0-9]{8,}|buy\.stripe\.com' "$REPO" | head
rg -n -g '!node_modules' -i 'umami|data-website-id|gtag\(|googletagmanager' "$REPO" | head
```

If the domain is known, read the live site too: `curl -sI`, `robots.txt`, `sitemap-index.xml` or
`sitemap.xml`, `llms.txt`, and who serves it (`server`, `cf-ray` headers).

## Output

Write the facts to the top of `apps/web/site-brief.md` under **Known from the repo**, each with
`file:line` or the URL. The grill asks only about what this list leaves open.

When the repo already has a site on another stack (Next.js, a static export), record its URLs: the
build must keep every one of them or 301 it.
