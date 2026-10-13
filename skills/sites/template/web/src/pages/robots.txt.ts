// Rules: seo-geo skill, docs/technical-seo.md and docs/ai-crawlers.md.
import type { APIRoute } from 'astro';

export const GET: APIRoute = ({ site }) => {
  if (import.meta.env.PUBLIC_DEPLOY_ENV !== 'production') {
    return new Response('User-agent: *\nDisallow: /\n');
  }
  // Search, agent and training bots allowed (the sites default for marketing pages).
  // To block training, add the groups from docs/ai-crawlers.md here.
  return new Response(
    [
      'User-agent: *',
      'Content-Signal: search=yes, ai-input=yes, ai-train=yes',
      'Allow: /',
      '',
      `Sitemap: ${new URL('sitemap-index.xml', site)}`,
      '',
    ].join('\n'),
  );
};
