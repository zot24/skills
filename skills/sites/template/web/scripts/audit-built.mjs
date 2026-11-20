// Checks every built HTML page: a unique <title>, a description, a canonical on the production
// origin, exactly one <h1> and one JSON-LD block that parses. noindex pages skip SEO checks. A page
// whose canonical points at another page (a campaign copy) may share that page's title. Titles
// outside 30-60 chars are a warning, not a failure: an existing site keeps its indexed titles.
// Full audit: seo-geo skill, docs/audit.md.
import { readFileSync, readdirSync, statSync } from 'node:fs';
import { join } from 'node:path';

const root = new URL('../dist/client/', import.meta.url).pathname;
const walk = (dir) => readdirSync(dir).flatMap((f) => {
  const p = join(dir, f);
  return statSync(p).isDirectory() ? walk(p) : p.endsWith('.html') ? [p] : [];
});

const failures = [];
const warnings = [];
const titles = new Map();
const trim = (path) => path.replace(/(index)?\.html$/, '').replace(/\/$/, '') || '/';
for (const file of walk(root)) {
  const html = readFileSync(file, 'utf8');
  const page = file.slice(root.length - 1);
  const fail = (msg) => failures.push(`${page}: ${msg}`);
  const jsonld = [...html.matchAll(/<script type="application\/ld\+json">(.*?)<\/script>/gs)];
  if (jsonld.length !== 1) fail(`${jsonld.length} JSON-LD blocks`);
  for (const [, body] of jsonld) { try { JSON.parse(body); } catch { fail('JSON-LD does not parse'); } }
  if (/name="robots" content="noindex/.test(html)) continue;
  const title = html.match(/<title>(.*?)<\/title>/s)?.[1] ?? '';
  if (title.length < 30 || title.length > 60) warnings.push(`${page}: title is ${title.length} chars`);
  if (!/<meta name="description" content="[^"]{50,}"/.test(html)) fail('missing or short description');
  const canonical = html.match(/<link rel="canonical" href="(https:\/\/[^"]+)"/)?.[1];
  if (!canonical) fail('missing canonical');
  const alternate = canonical && trim(new URL(canonical).pathname) !== trim(page);
  if (!alternate) {
    if (titles.has(title)) fail(`duplicate title with ${titles.get(title)}`); else titles.set(title, page);
  }
  const h1 = (html.match(/<h1[\s>]/g) ?? []).length;
  if (h1 !== 1) fail(`${h1} h1 elements`);
}
if (warnings.length) console.warn(warnings.map((w) => `warning: ${w}`).join('\n'));
if (failures.length) { console.error(failures.join('\n')); process.exit(1); }
console.log('audit-built: all pages pass');
