# Stage 6 — lock the pick, structure the site

The owner picked one direction, and maybe asked for "a bit more sections" or a page that is not one
long scroll. Three deliverables, all written in the worktree or the specs folder and left uncommitted
until the build's first commit:

1. `design.md` and `references.md` at the worktree root: **the lock**.
2. `<specs>/<site>-ia.md`: the information architecture, with mocks of the home page and two inner
   pages.
3. The **unclear-copy list**, inside the IA, for the owner and the copywriter.

The other directions are now out. Keep one small, named part of a rejected direction only if it
clearly helps, and say which part.

## `design.md`

Layout skills leave the model's default palette and fonts in place. `design.md` overrides them, and
it keeps them through every later revamp. It is an agent-facing document, so write it with
`writing-for-agents`. Seed it from the mock that won and from the kept references'
`get_design_system` output, never from a shared gallery file: several sites seeded from one gallery
converge.

Open it with three things: the lock date, the owner's words, and one rule. **Any change to the look
edits this file first, and a section that departs from it is a defect.** Copy comes from the copy
spec, not from here.

| § | Holds |
|---|---|
| Idea | One line |
| Rules that settle most questions | Stated positively: the picks themselves |
| Forbidden | Each model default, listed after the pick that replaces it. A bare ban moves the model to the next default in line |
| Colour | `\| Token \| Hex \| Role \| Contrast \|`, `color-scheme` and `theme-color`, and where the accent may appear |
| Type | Families and their coverage (locales, symbols, figures), `\| Role \| Size \| Weight \| Line height \| Tracking \|`, measure, `tabular-nums` |
| Space | Base step, container padding (inline only), section rhythm, header height, radius, borders, the one shadow, 44 px targets |
| Templates | Page templates and the first-viewport rule |
| Components | Anatomy, variants and rules for each: header, buttons, the claim-and-caveat block, tiles, tables, FAQ, footer, mobile action bar, share image |
| Navigation | Desktop bar and its phone form |
| Icons and emoji | Where they appear and where they never do |
| The conversion action | Its one form, label and tracking code |
| Motion | `\| Interaction \| Motion \| Duration and easing \| Why \|`, from `emil-design-eng` and `apple-design`; reduced motion; a short "never" list |
| Mobile | The rules `mobile-native` gives for this direction, applied by name |
| Accessibility and speed | Contrast, focus, LCP, CLS and INP targets |
| Rendering contract | What must be in the server HTML |
| Tokens | A code block the build pastes, such as a Tailwind `@theme` |
| Build gates | Computed values, the tell scan, the claim rule, the fold, the rhythm, motion, server HTML |
| Not this site | The tells, by name |

Use `pick-ui-library` before you name a library. The usual answer is none, or at most one, and
installed equivalents stay rather than churn.

## `references.md`

The companion to `design.md`. It records where each borrowed part came from.

- Rules first: no slug appears in a sibling site's `references.md`; borrow structure, density and
  type, never brand, colour or imagery.
- **The study:** the calls, the proxies, the evidence packet, and the gravity position.
- **For each kept reference,** a heading `slug: URL (captured <date>)`, then: its axes, its real
  system (fonts, ramp, spacing), **Taken** (each item mapped to a `design.md` section), **Not taken**
  with the reason, and links to its screens.
- **Studied and not used:** `| Slug | Why not |`, and the references of rejected rounds, so that
  sibling sites do not reuse them either.

Add a `## Design` section to the site's `CLAUDE.md`. It says that the look is locked in `design.md`
(the pick and the date), that a change edits `design.md` first, where `references.md` is, which
vendored skills carry the motion rules, and the IA path ("not built until approved").

## The information architecture

Most owners who ask for "sections" mean short screens. Each screen does one job, and the long
scroll breaks into pages.

Write `<specs>/<site>-ia.md`:

1. **The page today.** Its height in screens at 1280 and at 375, its word count, and the y position
   of each section. These are the numbers that "too long" refers to.
2. **The page set:** `| URL | Page | Job | Owns the question | Title and H1 terms | Feeds from (copy
   rows) | Waits on | Phase |`. The home keeps the first-screen job: the claim and caveat, who it is
   for, the one action. Each inner page **owns one search question**. Each FAQ item lives on exactly
   one URL (`| FAQ | Owner URL |`), and any block that sits on two URLs on purpose says so.
3. **Separate URLs or anchored panels.** Recommend one in a table with rows for short screens, SEO,
   GEO, later pages, cost and risk. The usual answer is separate URLs. Each one gets its own title and
   H1 and can own a question cluster, and answer engines cite the exact URL. Closed panels hide their
   content from crawlers.
4. **Old links.** Keep old `/#anchor` ids on the home's link rows, or redirect them, so no shared
   link dies.
5. **Inner pages:** `| Page | H1 | Content in order | Conversion links (existing codes only) | JSON-LD |`,
   with titles and their character counts. Pages are self-canonical, and the sitemap carries
   `lastmod`. Organization and WebSite are shared by `@id`, and each page gets a WebPage. FAQPage goes
   only where its questions live. `llms.txt` gains a "Pages" list.
6. **Navigation.** A bar on desktop. On a phone, a tab row or a native `<details>` menu with no script
   and no hamburger. Add breadcrumbs and foot links. New labels are copywriter strings.
7. **Screens after the change:** `| Page | Desktop screens | Phone screens |` against today, with
   nothing required collapsed.
8. **Server HTML gate, per page.** `curl` with no JavaScript returns the headings, the lede, any price
   with its caveat, the FAQ answers, and one JSON-LD block that parses. Gate this before any inner page
   ships, because a client-render bailout hides the content from every crawler.
9. **Later pages** (guides, language editions): the index URL, when the nav entry appears (once two
   pages exist), and one owner per question.
10. **What this changes in the copy spec:** per-page intent, titles, outlines, canonicals, sitemap,
    JSON-LD and checks. The copy seat's next revision carries these.
11. **The unclear-copy list** (below).
12. **Owner questions**, prefixed (`IA-1`, `IA-2` …) so they do not collide with the copy spec's
    `Q` numbers. They go on the [decisions page](decisions-page.md).

## The unclear-copy list

Every place where the live copy is unclear or says too little. Write it as a list the people who
act on it can work through:

| # | The reader can't tell… | Live | Spec rev | Who acts |
|---|---|---|---|---|
| 1 | what the package includes | silent | silent | O (`Q6`) |
| 2 | what happens after the final step | one line | one line | C |
| 3 | how long the whole process takes | "fast" | removed | H |

**O** is the owner; name the open question. **C** is the copywriter. **H** means the knowledge
base needs a source and a register row before the copy can say anything.

## Mocks of the structure

Mock the home page and two inner pages in the locked direction, at desktop and phone width:
`ia-home.html`, `ia-<page>.html` and `ia-<page>.html` in `<specs>/<site>-mocks/`, all with the
[mock-up rules](mock-ups.md).
Use real copy where the spec has it. **Every string that still needs the owner's or the copywriter's
work is yellow** and labelled with its question id or `C`, so the owner sees what is still open.

`ia.html` is the index. It shows a `<pre>` URL tree with one line per page, a "What the yellow
means" legend, then the desktop and phone frames for each page. Count the yellow marks per page, for
the owner and for the copywriter separately, and put the counts in the report.

**Done when:** `design.md` and `references.md` exist, every inner page in the IA owns a question, the
three mocks pass the browser check, and every yellow string appears in the unclear-copy list or on
the decisions page.
