# site-design-options Skill

Redesign an existing website with its owner. The agent learns the site, writes its copy from cited
sources, shows design directions the owner can open in a browser, iterates on the favourite, locks
the look and the page structure, and only then builds — one section per commit.

The owner decides at every stop. The agent prepares the choice, recommends one answer, and waits.

## What This Skill Covers

- **Learn the site first** — a census of what the site sells and to whom, every factual claim with
  file and line, and a snapshot of the SEO and GEO surface (title, meta, canonical, JSON-LD,
  `llms.txt`, server-rendered text) before anything changes
- **Copy from a source of truth** — a copy spec built on a claim register, every string current vs
  proposed, SEO and GEO sections, owner questions with fallbacks, acceptance checks that can fail;
  then an adversary from another provider attacks the register and a reviser applies the measured
  fixes, two rounds at most
- **Design directions, then stop** — business intent written into the site's `CLAUDE.md`, real-site
  references through the Inspo MCP within a study budget, three genuinely different directions, and
  an allocation table when several sites share a niche
- **Mock-ups the owner can open** — static first-screen HTML at desktop and phone width, beside a
  screenshot of today's site, real copy, open strings in yellow, no tracking, checked in a real
  browser
- **The owner's loop** — freeze the favourite and vary one real thing per variant; or run a fresh
  study for directions that differ on all four axes
- **Lock and structure** — `design.md`, `references.md`, a page structure where each page owns a
  search question, and the list of unclear copy for the owner and the copywriter
- **One decisions page** — every owner question across specs on one page, recommended answers
  pre-selected, answers saved and read back
- **Build and review** — section by section, blind screenshot review, SEO and GEO diff against the
  snapshot

## Usage

```
/site-design-options:site-design-options learn example.com
/site-design-options:site-design-options copy
/site-design-options:site-design-options directions
/site-design-options:site-design-options allocate
/site-design-options:site-design-options mocks
/site-design-options:site-design-options family d2
/site-design-options:site-design-options different
/site-design-options:site-design-options lock d2b
/site-design-options:site-design-options decisions
/site-design-options:site-design-options build
```

Or in plain words: "redesign this site — show me three directions before you build anything".

## Documentation

- [Learn the site](./skills/site-design-options/docs/learn-the-site.md)
- [Copy spec](./skills/site-design-options/docs/copy-spec.md)
- [Directions](./skills/site-design-options/docs/directions.md)
- [Mock-ups](./skills/site-design-options/docs/mock-ups.md)
- [Owner's loop](./skills/site-design-options/docs/owner-loop.md)
- [Lock and structure](./skills/site-design-options/docs/lock-and-structure.md)
- [Decisions page](./skills/site-design-options/docs/decisions-page.md)
- [Build and review](./skills/site-design-options/docs/build-and-review.md)

## What it calls

The skill names these and says when to use each; it does not copy them.

- [Emil Kowalski's design skills](https://github.com/emilkowalski/skills) — `emil-design-eng`,
  `apple-design`, `mobile-native`, `pick-ui-library` while designing; `emil-prototype` for live
  variants on request; `review-animations`, `break-ui`, `mobile-native` when reviewing the build
- The Inspo MCP for real-site references (`recommend`, `search_screens`, `get_screen`,
  `get_design_system`, `find_components`)
- `unslop` for every owner-facing line, `writing-for-agents` for the site's `CLAUDE.md` and
  `design.md`, the llm-wiki commands for the knowledge base behind the claim register, and
  `artifact-capabilities` for the decisions page

## Why it exists

The way of working was used on four sites in one niche on one day. The owner chose by opening
mock-ups, not by reading descriptions; asked for a family around one favourite on one site and for
"actually different" looks on another; and on a third pointed out that the calculator — the reason
people visit — was missing from the first screen. Each of those turns is a step here.

## Sources

No upstream. `sync.json` carries an empty `sources` array and the skill is listed in `EXEMPT_SYNC`.
