<!-- Authored for this skill. Not synced from upstream. -->

# Answer-first content

Search engines rank pages; answer engines quote passages. A page that wins both is written so any
section can be lifted out and still answer a question on its own. This guide is for the copy pass —
the `site-design-options` skill owns layout and voice, this owns findability.

## Before writing: the query map

For each page, list 3–8 real questions the visitor would type or ask an assistant. Sources, in order:
Search Console queries (once live), the owner's sales and support questions, "People also ask" and
autocomplete, competitor FAQ pages. Each page targets one primary intent.

| Page | Primary question | Secondary questions |
|---|---|---|
| `/` | What is Acme Widgets? | Who is it for? How much? |
| `/pricing` | How much does Acme cost? | Is there a free trial? Refunds? |
| `/calculator` | How many widgets do I need? | What does it cost for N units? |

## Writing rules

1. **Answer in the first two sentences** under each heading. Detail comes after.
2. **Headings are questions or plain claims** a person would search: "How much does a widget audit
   cost?" beats "Our approach".
3. **Name the entity.** "Acme Widgets audits factory lines in 48 hours" — not "We do it fast". Pronouns
   do not survive being quoted out of context.
4. **Numbers over adjectives.** Prices, durations, counts, percentages, dates. Answer engines prefer
   passages with specific, checkable facts.
5. **One idea per paragraph**, 2–4 sentences. Lists and tables for comparisons and steps.
6. **Show freshness.** A visible "Updated <date>" on pages with prices or facts that change, matching
   `dateModified` in the JSON-LD.
7. **Say who is behind it.** An about section or page with real names, location and contact. Trust
   signals matter to both Google and AI answers.
8. **Cite sources** for claims that are not the business's own (statistics, regulations), with links.
9. **Comparison content wins citations.** "Acme vs. doing it in-house" with an honest table is the
   kind of passage assistants quote.
10. **FAQ at the bottom** of money pages, 4–8 real questions, each answer self-contained, marked up as
    `FAQPage` ([structured-data](structured-data.md)).

## Consistency across the web

Answer engines cross-check. Keep the business name, one-line description, price and location
identical on the site, `llms.txt`, JSON-LD, social profiles and directory listings.

## Review loop

After launch, the `sites` review mode pulls Search Console queries and Umami behaviour. For each page:

- Queries with impressions but position > 10: add a section that answers that query directly.
- High impressions, low CTR: rewrite the title and description.
- Heatmaps show nobody reaches the answer: move it up.
- Ask an assistant the page's primary question with search on. If the answer misses or misstates the
  business, fix the passage it should have quoted.
