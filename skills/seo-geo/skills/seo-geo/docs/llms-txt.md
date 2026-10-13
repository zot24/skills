<!-- Authored for this skill. Not synced from upstream. Spec: llms-txt-spec.md (synced). -->

# llms.txt

`/llms.txt` is a Markdown map of the site for agents: what it is, then links to the pages worth
reading. Agents that fetch a site on a person's behalf read it first when it exists. It is cheap, so
every site ships one. It is not a ranking factor in Google.

## Format (from the spec)

- `# Name` — the only required part.
- `> summary` — one blockquote with the key facts.
- Optional paragraphs or lists with more detail (no headings).
- `## Section` headings, each a list of `- [name](url): notes`.
- A section named `## Optional` holds links an agent can skip.

## Generate it

Build it from the same content the pages use so it never drifts:

```ts
// src/pages/llms.txt.ts
import type { APIRoute } from 'astro';
import { getCollection } from 'astro:content';

export const GET: APIRoute = async ({ site }) => {
  const pages = await getCollection('pages');           // or a hand-written list
  const url = (p: string) => new URL(p, site).toString();
  const body = [
    '# Acme Widgets',
    '',
    '> Acme Widgets sells custom widgets for small factories. Plans start at $49/month. Ships worldwide from Spain.',
    '',
    '- Founded 2024, team of 4',
    '- Contact: hello@acmewidgets.com',
    '',
    '## Product',
    ...pages.filter((p) => p.data.section === 'product')
      .map((p) => `- [${p.data.title}](${url(p.data.path)}): ${p.data.description}`),
    '',
    '## Pricing',
    `- [Pricing](${url('/pricing')}): plans, what each includes, refund policy`,
    '',
    '## Optional',
    `- [Changelog](${url('/changelog')})`,
  ].join('\n');
  return new Response(body, { headers: { 'Content-Type': 'text/markdown; charset=utf-8' } });
};
```

## What goes in the summary

The facts an answer engine needs to describe the business in one sentence: what it is, who it is for,
price or price range, location or reach, and what makes it different. Specific numbers beat
adjectives. Use the same wording as the home page `h1` and meta description.

## Markdown versions of pages (optional)

The spec suggests `page.md` next to `page` with a `Link: <...>; rel="alternate"; type="text/markdown"`
header. For a landing site with a handful of pages, `llms.txt` with good summaries is enough. Add
Markdown twins only for documentation-like sections.

## Check

```bash
curl -s https://acmewidgets.com/llms.txt | head -20
curl -sI https://acmewidgets.com/llms.txt | grep -i content-type
```
