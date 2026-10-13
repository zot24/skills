<!-- Authored for this skill. Not synced from upstream. -->

# Technical SEO on Astro + Cloudflare Workers

The plumbing every page needs. Most of it lives in one head component and the Astro config, so it is
written once per site (the `sites` skill's template ships it) and checked at launch.

## astro.config.mjs

```js
import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://acmewidgets.com',          // canonical origin: no trailing slash, no www
  trailingSlash: 'never',                   // pick one and keep it
  integrations: [sitemap({ filter: (page) => !page.includes('/thanks') })],
});
```

`site` drives canonicals and the sitemap. Leave thank-you, checkout-result and other thin pages out
of the sitemap and mark them `noindex`.

## The head component

```astro
---
// src/components/Seo.astro
interface Props { title: string; description: string; image?: string; noindex?: boolean; type?: 'website' | 'article' }
const { title, description, image = '/og/default.png', noindex = false, type = 'website' } = Astro.props;
const canonical = new URL(Astro.url.pathname, Astro.site);
const ogImage = new URL(image, Astro.site);
const isPreview = import.meta.env.PUBLIC_DEPLOY_ENV !== 'production';
---
<title>{title}</title>
<meta name="description" content={description} />
<link rel="canonical" href={canonical} />
{(noindex || isPreview) && <meta name="robots" content="noindex, nofollow" />}
<link rel="sitemap" href="/sitemap-index.xml" />
<meta property="og:type" content={type} />
<meta property="og:title" content={title} />
<meta property="og:description" content={description} />
<meta property="og:url" content={canonical} />
<meta property="og:image" content={ogImage} />
<meta name="twitter:card" content="summary_large_image" />
```

| Field | Rule |
|---|---|
| `title` | 50–60 characters, main keyword first, brand last (`Widget pricing calculator · Acme`) |
| `description` | 140–160 characters, says what the visitor gets, one number if possible |
| `canonical` | Always the production origin, even when served from `*.workers.dev` |
| `og:image` | 1200×630 PNG or JPG, under 300 KB, text readable at thumbnail size |
| One `h1` | Per page, matches the search intent, not the brand slogan |

## Preview builds must not index

Workers Builds sets `WORKERS_CI_BRANCH` at build time. Map it to a build-time constant:

```js
// astro.config.mjs
const branch = process.env.WORKERS_CI_BRANCH;
const deployEnv = !branch || branch === 'main' ? 'production' : 'preview';

export default defineConfig({
  // ...
  vite: { define: { 'import.meta.env.PUBLIC_DEPLOY_ENV': JSON.stringify(deployEnv) } },
});
```

Local builds count as production so the launch audit sees the real tags. Production is also reachable
on `<worker>.<account>.workers.dev`: the canonical tag handles that duplicate, or set
`"workers_dev": false` in `wrangler.jsonc` when previews are not needed.

## robots.txt

Generate it so the sitemap URL follows `site` and previews block everything:

```ts
// src/pages/robots.txt.ts
import type { APIRoute } from 'astro';
export const GET: APIRoute = ({ site }) => {
  if (import.meta.env.PUBLIC_DEPLOY_ENV !== 'production') {
    return new Response('User-agent: *\nDisallow: /\n');
  }
  return new Response(
    `User-agent: *\nAllow: /\n\nSitemap: ${new URL('sitemap-index.xml', site)}\n`,
  );
};
```

AI crawler groups go in the same file — see [ai-crawlers](ai-crawlers.md). If Cloudflare's managed
`robots.txt` is on, Cloudflare prepends its block to this file; check the live result, not the source.

## Performance

Core Web Vitals are a ranking signal and a conversion lever. Astro ships zero JS by default; keep it
that way:

- Islands load with `client:visible` or `client:idle`, never `client:load` below the fold.
- Images through `astro:assets` `<Image>` with `width`/`height`, `loading="eager"` and
  `fetchpriority="high"` only on the LCP image.
- Self-host fonts, `font-display: swap`, preload only the one used above the fold.
- Umami `data-performance="true"` reports field Web Vitals; Lighthouse in CI reports lab numbers.
- For deeper work, use the `web-perf` skill from cloudflare/skills.

Targets: LCP < 2.5 s, INP < 200 ms, CLS < 0.1, Lighthouse SEO 100, Performance ≥ 90 on mobile.

## Redirects and status codes

- www → apex is one Cloudflare Single Redirect (`cloudflare-domains` skill).
- Moved pages: `redirects` in `astro.config.mjs` emits 301s. Never let an old URL 404.
- A real `src/pages/404.astro` that returns status 404.

## Multi-language (only when needed)

One URL per language (`/es/...`), `hreflang` alternates on every page including itself, plus
`x-default`. Astro's i18n routing generates the paths; add the alternates in `Seo.astro`.
