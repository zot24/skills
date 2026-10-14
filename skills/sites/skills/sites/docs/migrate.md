# Existing site on another stack

Found in the dry run: many sites already exist — often Next.js on Vercel at the repo root, with
tracking, redirects and a locked look. Moving them is a migration, not a new build. The rules below
come first; every other step of the flow still applies.

## Where the site lives

| Repo shape | Site directory |
|---|---|
| Monorepo with an app | `apps/web` |
| The repo **is** the site (no app, or the app is retired) | the repo root — do not invent a monorepo |

Every guide's `apps/web` means "the site directory". In a site-only repo, build the Astro site in
`site-next/` on the branch, and move it to the root in the cutover commit, so the old site keeps
deploying from `main` until then.

## Keep what search engines and visitors already know

| Keep | How |
|---|---|
| Every URL | Snapshot first (`site-design-options` stage 1). Match `trailingSlash` to the old site (`'always'` when the old one ends URLs in `/`). Diff the new build's sitemap against the old one. |
| Every redirect | Port host and path redirects: path rules to `redirects` in `astro.config.mjs`, host rules (apex ↔ www, old domains) to Cloudflare Single Redirects. |
| The canonical host | Keep it, even when it is `www`. Set `SITE` and the custom domain route to that host and redirect the other one. |
| Tracking codes | Event names, data attributes, source codes in links — byte for byte. Several Umami website IDs (one per section) stay several: pass `websiteId` to `Analytics.astro`. |
| Share images | Per-page OG images are rebuilt as static PNGs at build time (or kept as files); never dropped. |
| The look | An existing `design.md` stays the lock. Convert it to the DESIGN.md format (tokens in front matter, its sections as prose) without changing a value. |
| `llms.txt`, JSON-LD, FAQ text | Carried over as content, then diffed against the snapshot. |

Remove what the new stack replaces (Vercel Analytics, platform headers, retired API routes) and list
each removal in the PR.

## Cutover

Building, previewing and diffing are reversible and run without asking. Moving production is not:

1. Branch build green, preview URL serves the full site, snapshot diff shows only planned changes.
2. Ask the owner for the cutover, with the plan below and the rollback.
3. On their yes: zone on Cloudflare (if DNS is elsewhere, the nameserver change is the owner's step),
   custom domain route on the Worker, redirects in place, old host left running.
4. Verify with the launch gate on the real domain within the hour.
5. Rollback: point the record back at the old host. Keep the old deployment for two weeks.

After cutover, re-submit the sitemap with `search-engines`; the properties themselves do not change.
