import { getEntry, getCollection } from 'astro:content';

export async function getSite() {
  const entry = await getEntry('site', 'main');
  if (!entry) throw new Error('src/content/site.json needs an entry with id "main"');
  return entry.data;
}

export async function getPlans() {
  return (await getCollection('plans')).map((p) => ({ id: p.id, ...p.data }));
}

export const isProduction = import.meta.env.PUBLIC_DEPLOY_ENV === 'production';
