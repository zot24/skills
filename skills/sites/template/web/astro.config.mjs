// @ts-check
import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';
import react from '@astrojs/react';
import sitemap from '@astrojs/sitemap';
import tailwindcss from '@tailwindcss/vite';

// Production origin: no trailing slash, no www. The sites skill sets it from site-brief.md.
const SITE = 'https://example.com';

// Workers Builds sets WORKERS_CI_BRANCH. Anything but the production branch is a preview:
// noindex meta + "Disallow: /" robots.txt. Local builds count as production.
const branch = process.env.WORKERS_CI_BRANCH;
const deployEnv = !branch || branch === 'main' ? 'production' : 'preview';

export default defineConfig({
  site: SITE,
  trailingSlash: 'never', // an existing site keeps its own: 'always' if its URLs end in /
  output: 'static', // pages prerender; API routes opt out with `export const prerender = false`
  // Images are optimised at build time; no runtime Images binding for a static site.
  adapter: cloudflare({ imageService: 'compile' }),
  integrations: [
    react(),
    sitemap({ filter: (page) => !/\/(thanks|404)(\/|$)/.test(page) }),
  ],
  vite: {
    plugins: [tailwindcss()],
    define: { 'import.meta.env.PUBLIC_DEPLOY_ENV': JSON.stringify(deployEnv) },
  },
});
