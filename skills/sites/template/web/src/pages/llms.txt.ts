// Rules: seo-geo skill, docs/llms-txt.md. Built from the same content as the pages.
import type { APIRoute } from 'astro';
import { getSite, getPlans } from '../lib/site';

export const GET: APIRoute = async ({ site: origin }) => {
  const site = await getSite();
  const plans = await getPlans();
  const url = (path: string) => new URL(path, origin).toString();
  const body = [
    `# ${site.name}`,
    '',
    `> ${site.description}`,
    '',
    `- Contact: ${site.email}`,
    '',
    '## Pricing',
    ...plans.map((p) => `- [${p.name}](${url('/#pricing')}): ${p.price} ${p.currency}${p.interval === 'once' ? '' : ` per ${p.interval}`}`),
    '',
  ].join('\n');
  return new Response(body, { headers: { 'Content-Type': 'text/markdown; charset=utf-8' } });
};
