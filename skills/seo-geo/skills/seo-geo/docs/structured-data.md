<!-- Authored for this skill. Not synced from upstream. Vocabulary: https://schema.org -->

# Structured data (JSON-LD)

Structured data tells search engines and AI systems what the page is about in a form they do not have
to guess. It feeds rich results in Google and entity understanding in answer engines.

## Rules

- JSON-LD in a `<script type="application/ld+json">`, one graph per page.
- Describe only what the visible page shows. Prices, ratings and FAQs in the markup must appear on the
  page — mismatches are a manual-action risk.
- Stable `@id`s (`https://acmewidgets.com/#org`) so pages reference the same entities.
- No fake reviews or ratings, ever.

## Component

```astro
---
// src/components/JsonLd.astro
const { graph } = Astro.props;   // array of schema.org nodes
---
<script type="application/ld+json"
  set:html={JSON.stringify({ '@context': 'https://schema.org', '@graph': graph }).replace(/</g, '\\u003c')} />
```

## Site-wide nodes (every page)

```js
const site = 'https://acmewidgets.com';
export const org = {
  '@type': 'Organization',
  '@id': `${site}/#org`,
  name: 'Acme Widgets',
  url: site,
  logo: `${site}/logo.png`,
  sameAs: ['https://x.com/acmewidgets', 'https://github.com/acmewidgets'],
};
export const website = {
  '@type': 'WebSite',
  '@id': `${site}/#website`,
  url: site,
  name: 'Acme Widgets',
  publisher: { '@id': `${site}/#org` },
};
```

`sameAs` links the brand to its profiles: one of the strongest entity signals for AI answers. List
every official profile and keep names identical everywhere.

## Page types

| Page | Type | Key properties |
|---|---|---|
| SaaS / app landing | `SoftwareApplication` | `applicationCategory`, `operatingSystem`, `offers` |
| Service landing | `Service` | `provider` → org, `areaServed`, `offers` |
| Product with a price | `Product` + `Offer` | `offers.price`, `priceCurrency`, `availability` |
| Calculator / tool | `WebApplication` | `applicationCategory`, `isAccessibleForFree` |
| Article / guide | `Article` | `headline`, `datePublished`, `dateModified`, `author` |
| FAQ section | `FAQPage` | `mainEntity[]` of `Question` + `acceptedAnswer` |
| Any deep page | `BreadcrumbList` | `itemListElement[]` with `position`, `name`, `item` |

Google shows FAQ rich results only for a few authoritative sites, but `FAQPage` markup still helps
answer engines match questions to answers. Keep it when the page has a real FAQ.

Example for a paid service with a Stripe Payment Link:

```js
{
  '@type': 'Service',
  '@id': 'https://acmewidgets.com/#service',
  name: 'Widget audit',
  provider: { '@id': 'https://acmewidgets.com/#org' },
  areaServed: 'Worldwide',
  offers: { '@type': 'Offer', price: '149.00', priceCurrency: 'USD', url: 'https://acmewidgets.com/#pricing' },
}
```

Prices come from the same source as the visible pricing table (a content collection), never typed
twice.

## Validate

- Syntax and types: `https://validator.schema.org/` (paste the URL).
- Google eligibility: Rich Results Test, `https://search.google.com/test/rich-results`.
- After launch: Search Console → Enhancements shows errors per type.

In CI, a cheap check is that every built page has exactly one parseable JSON-LD block:

```bash
for f in $(find dist -name '*.html'); do
  n=$(grep -c 'application/ld+json' "$f"); [ "$n" = 1 ] || echo "$f: $n JSON-LD blocks"
done
```
