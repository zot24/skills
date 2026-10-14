# SEO + GEO

Expert skill for making Astro sites on Cloudflare easy to find in search and easy to quote in AI
answers.

## Features

- **Technical SEO** — head component, canonicals, sitemap, robots.txt, preview builds kept out of the index
- **Structured data** — JSON-LD graph per page, `Organization` with `sameAs`, page types, validation
- **AI crawlers** — Cloudflare AI bot policies and robots.txt in agreement, with verification
- **llms.txt** — generated from the site's content
- **Answer-first content** — query map and writing rules for passages assistants quote
- **Audit** — scripted checks with pass criteria, Lighthouse

## Commands

```bash
/seo-geo:seo-geo audit https://acmewidgets.com
/seo-geo:seo-geo setup
/seo-geo:seo-geo schema /pricing
/seo-geo:seo-geo ai-bots acmewidgets.com
/seo-geo:seo-geo llms
/seo-geo:seo-geo copy /pricing
/seo-geo:seo-geo sync
```

## Sources

Synced from [cloudflare/cloudflare-docs](https://github.com/cloudflare/cloudflare-docs) (AI bot
policies, managed robots.txt, AI Crawl Control), [withastro/docs](https://github.com/withastro/docs)
(sitemap) and [AnswerDotAI/llms-txt](https://github.com/AnswerDotAI/llms-txt) (spec). The guides are
authored for this skill.
