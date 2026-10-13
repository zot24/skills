# Step 4 — scaffold apps/web

The template lives in this plugin at `template/`:

| Folder | Goes to | When |
|---|---|---|
| `template/web/` | `apps/web/` | always |
| `template/root/` | repo root | only when the repo has no pnpm workspace yet |

## Copy

From the plugin (installed) or from GitHub:

```bash
cp -R "${CLAUDE_PLUGIN_ROOT}/template/web" apps/web
# or
npx degit zot24/skills/skills/sites/template/web apps/web
```

For a repo with no workspace:

```bash
npx degit zot24/skills/skills/sites/template/root . --force   # package.json, pnpm-workspace.yaml, turbo.json, CI
```

When the repo already has a root `package.json`, merge by hand: add `apps/*` to the workspace
globs and copy only `.github/workflows/web-checks.yml`.

## Fill in

| File | Set |
|---|---|
| `apps/web/package.json` | `name` (e.g. `@<repo>/web`) |
| `apps/web/astro.config.mjs` | `SITE` — the production origin |
| `apps/web/wrangler.jsonc` | `name` (`<brand>-web`), `routes[0].pattern` (the apex) |
| `apps/web/src/content/site.json` | name, tagline, description, email, `sameAs`, conversion — from the brief |
| `apps/web/src/content/plans.json` | plans from the product's real prices (cite them in the copy spec) |
| `apps/web/.env` | `PUBLIC_UMAMI_HOST`, `PUBLIC_UMAMI_WEBSITE_ID` (after the umami step) |
| `apps/web/.env.schema` | the Stripe webhook item name for this brand |

`site-brief.md` and `site-plan.md` sit in `apps/web/` next to the code.

## Trim what the brief does not need

- **No payments** (the conversion is a sign-up, a call or a chat link): delete `src/pages/api/`,
  `src/pages/thanks.astro` and `stripe` from `package.json`; leave `plans.json` empty or delete the
  pricing section. `site.json` → `conversion.href` takes any URL, such as a `wa.me` link.
- **Several Umami websites** on one site: pass `websiteId` to `<Analytics />` in the layout for that
  section.
- **URLs end in `/`** on an existing site: set `trailingSlash: 'always'` (see [migrate](migrate.md)).

## Check, then open the PR

```bash
pnpm install
pnpm --filter ./apps/web build          # wrangler types + astro check + astro build
pnpm --filter ./apps/web audit:built
pnpm --filter ./apps/web design:lint
```

Commit on a branch `site/<brand>`, push, open a **draft** PR titled `feat(web): <brand> site`.
Drive it green; the PR grows as design and wiring land.

## What the template gives

- Astro 7, static output, the Cloudflare adapter (images compiled at build), React for islands,
  Tailwind 4 with tokens exported from `DESIGN.md`, `@astrojs/sitemap`
- `Seo.astro`, `JsonLd.astro` (`Organization`, `WebSite`, `Service` with offers), `Analytics.astro`
  (Umami tracker + recorder, production only)
- `robots.txt` and `llms.txt` endpoints built from content; preview builds get `noindex` and
  `Disallow: /` through `WORKERS_CI_BRANCH`
- `/api/checkout` (Checkout Session) and `/api/stripe-webhook` (verified with Web Crypto), `/thanks`
  with the Umami revenue event
- `.env.schema` for Varlock + 1Password; `.env` with public values only
- CI: DESIGN.md lint, tokens in sync, type check and build, built-page audit, Lighthouse
