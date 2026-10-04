# Stage 8 — build section by section, review with screenshots

Starts only after the lock ([lock and structure](lock-and-structure.md)) and the owner's answers
([decisions page](decisions-page.md)). The stack stays as it is: changing it puts every URL and every
piece of metadata at risk.

## Branch and first commit

Work on a branch in a worktree, so the live site is untouched until review. The first commit holds
the inputs, so every later diff is the build alone:

- the site's `CLAUDE.md` with its business section
- `design.md` and `references.md`
- the design skills the seats used, vendored into `.claude/skills/` with their licence file

From here on, a change to the look starts as an edit to `design.md`. A section that departs from it
is a defect, however good it looks.

## One section per commit

**Order:** nav and hero, then the main proof or content, then the product (pricing, calculator),
then the FAQ, then the closing action and footer. Inner pages follow the IA's phase order.

For each section:

1. Pull the matching component crops from Inspo (`find_components` with `type` set to hero,
   pricing, faq, cta, stat, nav, footer…; `find_reference_components` then `get_reference_jsx` for an
   archetype's source).
2. Build it against `design.md` and the copy spec's strings, byte for byte.
3. Screenshot at 1280×800 and 375×812.
4. Compare with the locked mock-up, the reference crop, the tokens, and the live site before the
   change.
5. Commit. Commits are the rollback points.

Two layout rules hold everywhere: the hero fits the first viewport (an oversized headline eating it
is the commonest failure), and sections keep 80–160 px of vertical rhythm (a padding shorthand can
zero it silently — check the computed value).

Motion comes last and is optional. Use Emil Kowalski's `emil-design-eng` and `apple-design` for
what to animate, and keep to `design.md`'s motion rules. Scroll-driven video pages stay out unless
the owner asks: they cost mobile load time and move meaning out of the text crawlers read.

## Review

**Reviewers who never saw the build.** Give them only the screenshots, `design.md`,
`references.md`, the chosen direction and the copy spec. An agent reviewing its own work anchors on
what it made. Review each section as it lands, then the whole site once the last section is in.

The reviewer runs:

- `review-animations` on every motion, `break-ui` with worst-case data (the longest fallback
  strings, missing fields, long names), `mobile-native` on the phone build.
- **Tokens:** computed `background-color` on `body`, `font-family` on `h1` and body text, and the
  primary button's accent match `design.md`.
- **Tell scan:** fail on cream or off-white paper, Inter or Instrument Serif, a 3-equal-card grid, a
  hero that overflows the first screen, a mid-page section with zero vertical padding — unless
  `design.md` chose it on purpose.
- **Accessibility:** contrast 4.5:1 body, 3:1 large text and UI; one `h1`, headings in order, `lang`
  set; every input labelled, focus visible, the whole flow by keyboard; tap targets 24 px minimum,
  44 preferred; `prefers-reduced-motion` respected. Run axe or Lighthouse.
- **Speed:** mobile Lighthouse LCP under 2.5 s, CLS under 0.1, INP under 200 ms; at most two families
  plus a mono, `font-display: swap`, the display face preloaded; sized modern images, no autoplay
  video in the mobile hero.

## SEO and GEO diff against the snapshot

Take the same snapshot as [stage 1](learn-the-site.md) on the branch and diff it against the one on
`main`. Refuse the merge when:

- a sitemap URL stops resolving without a 301;
- a title, description or canonical changes without being in the copy spec;
- a JSON-LD type disappears or stops parsing;
- FAQ text on the page no longer matches the `FAQPage` answers;
- copy that was in the served HTML is now only in the hydrated DOM (`curl` the page; do not assume
  a client component renders on the server).

Keep answer-first paragraphs, figures with units and dates, and the FAQ as visible text. Update
`llms.txt` when copy or URLs move. Splitting one page into several URLs moves any per-page tracking
codes: keep the codes byte for byte and tell pages apart by the analytics page path.

Build-time traps seen before: share-image renderers (`next/og`) cannot read `woff2`, so ship a `ttf`
or `woff` copy of the display face; a claim check that tests a substring ("0%") also matches a
longer token ("10%"), so match on token boundaries.

## Distinctness gate (several sites in one niche)

Run the [distinctness gate](directions.md#several-sites-in-one-niche) on the built first screens
before the merge; rework the later site when it fails.

## Merge

Through a reviewed pull request, by the owner's word. Merge, push to production and deploy are
the owner's, never a seat's.

**Done when:** every section has its commit and its two screenshots, the reviewer's checks pass, and
the SEO and GEO diff shows only the changes the copy spec planned.
