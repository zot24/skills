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
deploying from `main` until then. Until the cutover:

- **No route in `wrangler.jsonc`.** Comment out `routes` with a note. A deploy from `main` with the
  custom domain route takes the hostname from the old host before the owner said yes.
- **Checks and builds point at `site-next`.** Copy `web-checks.yml` with its paths and
  `working-directory` set to `site-next` (and `cache-dependency-path: site-next/pnpm-lock.yaml`);
  the Workers Builds root directory is `site-next`. Commit `site-next/pnpm-lock.yaml`.
- **The lock moves into the site directory.** Convert the root `design.md` to `site-next/DESIGN.md`
  and delete the root file in the cutover commit, so one lock exists.

## Keep what search engines and visitors already know

| Keep | How |
|---|---|
| Every URL | Snapshot first (`site-design-options` stage 1). Match `trailingSlash` to the old site (`'always'` when the old one ends URLs in `/`). Diff the new build's sitemap against the old one. |
| The sitemap URL | Keep the one Search Console and Bing already read. When it is `/sitemap.xml`, drop `@astrojs/sitemap` and write a `src/pages/sitemap.xml.ts` endpoint, and pass `sitemap="/sitemap.xml"` to `Seo.astro`. |
| Every redirect | Port host and path redirects: path rules to `public/_redirects` (Workers static assets read it; `astro.config.mjs` `redirects` cannot send a splat such as `/packages/*` to a fixed page), host rules (apex ↔ www, old domains) to Cloudflare Single Redirects. |
| The canonical host | Keep it, even when it is `www`. Set `SITE` and the custom domain route to that host and redirect the other one. |
| Tracking codes | Event names, data attributes, source codes in links — byte for byte. Several Umami website IDs (one per section) stay several: pass `websiteId` to `Analytics.astro`. |
| Share images | Per-page OG images are rebuilt as static PNGs at build time (or kept as files); never dropped. Next.js serves them at extension-less URLs (`/opengraph-image`): keep the URLs and set `Content-Type: image/png` for them in `public/_headers`. |
| JSON-LD | A site with its own full graphs passes them as `graph` with `siteGraph={false}` to `Base.astro`, so Organization and WebSite are not emitted twice. Dates come from `import.meta.env.PUBLIC_BUILD_DATE`: `new Date()` at module scope runs inside workerd at prerender and returns 1970-01-01. |
| The look | An existing `design.md` stays the lock. Convert it to the DESIGN.md format (tokens in front matter, its sections as prose) without changing a value. |
| `llms.txt`, JSON-LD, FAQ text | Carried over as content, then diffed against the snapshot. |

Remove what the new stack replaces (Vercel Analytics, platform headers, retired API routes) and list
each removal in the PR.

## Prove it is the same site

When the live site cannot be fetched (a locked-down network) or to compare before any deploy, build
the old site from `main` locally and serve both builds. Then compare, per page:

- Screenshots at 1280×800 and 375×812, pixel by pixel. A pure port is pixel-identical; any changed
  pixel is either a planned change listed in the PR or a bug.
- Visible text, link targets, element ids, headings, head tags and JSON-LD, extracted from the HTML.
- `robots.txt`, the sitemap and `llms.txt`, byte for byte (ignore `lastmod`).

Values that live only in the old host's settings (Vercel `NEXT_PUBLIC_*` env: Umami website IDs and
script URL) are not in the repo. Read them from the live HTML, or ask in the grill; until then the
new build ships without them.

## Cutover

Building, previewing and diffing are reversible and run without asking. Moving production is not:

1. Branch build green, preview URL serves the full site, snapshot diff shows only planned changes.
2. Ask the owner for the cutover, with the plan below and the rollback.
3. On their yes: zone on Cloudflare (if DNS is elsewhere, the nameserver change is the owner's step),
   custom domain route on the Worker (when the zone is already on Cloudflare, it replaces the record
   that points at the old host), redirects in place, old host left running.
4. Verify with the launch gate on the real domain within the hour.
5. Rollback: point the record back at the old host. Keep the old deployment for two weeks.

After cutover, re-submit the sitemap with `search-engines`; the properties themselves do not change.
