# New site — the entry when there is no site yet

The eight stages assume a live site to learn from and protect. A new site has neither, so stage 1
changes and a few rules read differently. Everything else — cite or cut, the owner picks, the
product on the first screen, yellow means open, freeze the favourite — holds unchanged.

Use this entry when the `sites` skill hands over a `site-brief.md`, or when the owner asks for a
site that does not exist yet. The site lands in the app's monorepo at `apps/web`, started from the
`site-starter` template; this skill owns how it looks and what it says, not the plumbing.

## Stage 1N — learn the brief and the product

Read-only, like stage 1. Inputs, in order of authority:

1. **The owner's answers** — `site-brief.md` (goal, audience, the one conversion, domain, payments)
   and anything the owner said since. Owner facts come only from here.
2. **The product** — the app in the same monorepo (`apps/app`, `packages/`): what it does, its real
   prices and limits in code, its names for things. Cite with `file:line`.
3. **Brand assets** — logo, colours or fonts already in `packages/`, an existing `DESIGN.md`, the app's
   own theme. A new site that clashes with its own app is a defect.
4. **Primary sources** for any outside claim (laws, rates, statistics), added to llm-wiki before
   citing, as in stage 2.

Write `<specs>/product-census.md` with the same sections as stage 1, adapted:

| Section | What it holds for a new site |
|---|---|
| 1. Intent | The brief's goal, audience and conversion, quoted |
| 2. Implementation | The starter's routes and slots; the app's public entry points (sign-up URL, checkout, API the site may read) |
| 3. UI | The pages the brief implies, each with its one job — a proposal, marked as such |
| 4. Brief vs product | Every place the brief promises something the product does not do yet |
| 5. What not to do next | Traps: a price that lives in two places, a feature behind a flag |
| 6. Open work | Open PRs and issues in the monorepo that touch the product's public face |

Then the two lists stage 2 starts from — **where copy will live** (content collections under
`apps/web/src/content/`) and **every factual claim** the site is likely to make, each with its source.

### The field instead of the snapshot

There is no "today" to protect, so the snapshot becomes a short study of the field: two or three sites
the owner names, or the top results for the brief's main query. For each, record read-only with
`curl -sL`: title, description, `h1`, the visible offer and price, JSON-LD types, `llms.txt`, and
screenshots at 1280×800 and 375×812. Save under `<specs>/field/`.

This is for positioning and for what search and answer engines already return — not a style source.
Directions still come from the Inspo study in stage 3.

**Done when:** every page in the proposed UI has one job, every likely claim has a source or an owner
question, and the field folder holds every named site.

## What changes in the later stages

| Stage | For a new site |
|---|---|
| 2 Copy | Same spec. SEO and GEO sections start from the brief's main query and the field study, using the `seo-geo` skill's answer-first rules (`docs/answer-first-content.md`) when installed |
| 3 Directions | Same. The allocation table also applies when the owner runs several brands |
| 4 Mock-ups | **Brief first** replaces "today first": the index opens with the brief's positioning line and the conversion, then the field screenshots at the same widths, then the directions |
| 5 Owner loop | Same |
| 6 Lock | The lock is `apps/web/DESIGN.md` in the [DESIGN.md format](#designmd-for-a-new-site), plus `references.md`. The IA is the page list from stage 1N, each page owning one search question |
| 7 Decisions | Same; brief answers count as answered questions |
| 8 Build | Builds into the starter's Astro components, one section per commit. The SEO and GEO diff becomes the `seo-geo` audit on the preview URL, since there is no `main` snapshot to diff against |

## DESIGN.md for a new site

New sites use Google's DESIGN.md format so the starter's CI can lint it and export the tokens:
YAML front matter for tokens, then prose sections. Sections, when present, appear in this order:
Overview, Colors, Typography, Layout, Elevation & Depth, Shapes, Components, Do's and Don'ts.

Map the lock's content onto it:

| Lock content (see [lock and structure](lock-and-structure.md)) | DESIGN.md place |
|---|---|
| Lock date, owner's words, the one rule, Idea | `## Overview` |
| Colour table, `color-scheme`, accent rules | `colors:` tokens + `## Colors` |
| Type families, ramp, measure, `tabular-nums` | `typography:` tokens + `## Typography` |
| Space, container, rhythm, header height | `spacing:` tokens + `## Layout` |
| The one shadow, borders | `## Elevation & Depth` |
| Radius | `rounded:` tokens + `## Shapes` |
| Components, conversion action, navigation, icons | `components:` tokens + `## Components` |
| Rules that settle most questions, Forbidden, Not this site, Motion, Mobile, Accessibility, Rendering contract, Build gates | `## Do's and Don'ts` and extra sections after it (unknown sections are kept) |

Gates before the lock is done:

```bash
npx @google/design.md lint apps/web/DESIGN.md                       # exit 0, no errors
npx @google/design.md export --format css-tailwind apps/web/DESIGN.md > apps/web/src/styles/theme.css
```

The exported `@theme` block is the Tokens section's code: the build imports it rather than pasting
values by hand. A change to the look edits `DESIGN.md` first and re-exports.

## Hand-back

When stage 8's PR is open, report to the `sites` skill (or the owner): the PR, the preview URL, the
`seo-geo` audit result, and any owner question still yellow. Domain, analytics, search engines and
payments are wired by `sites`, not here.
