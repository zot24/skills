# Stage 3 — design directions, then stop

The design director builds nothing in the app. The stage ends with three directions in a file, the
mock-ups of [stage 4](mock-ups.md), and a stop: the owner picks by looking.

Write `<specs>/<site>-design-directions.md`. Open it with the seat, the date, the worktree and
commit, what changed on disk (`| Where | What | Git state |`), every outside contact (all
read-only), and the copy revision used. Carry strings **by copy-spec row ID**, never by wording,
while the copy is still being revised.

## Step 0 — harness

- Check that the Inspo MCP is connected (`/mcp` lists `inspo`). When it is not, run the study live
  (step 3, point 7) and say so in the calls table.
- Copy Emil Kowalski's skills into the worktree's `.claude/skills/` and keep the entries already
  there. Read `emil-design-eng`, `apple-design`, `mobile-native` and `pick-ui-library` before you
  shape a direction.
- Motion stays out until the build.

## Step 1 — business intent, in the site's `CLAUDE.md`

Write this first. Without it, every later skill asks about style alone, and every revamp loses what
the site is for. It is an agent-facing document, so write it with `writing-for-agents`. Keep
anything already in the file.

```markdown
## Business context (read before any design or copy work)

<date>, from the copy spec §1. The claim register is the only source for facts.

**What it is.** …
**Who it is for.** …
**Who it is not for.** … (an off-audience visitor learns from the hero that the page is not for them)
**Why they arrive.** The search intents, answer engines, links, and the one question they come with.
**What one visit must achieve.** The one conversion, and what they must see before it.
**Voice.** …
**What must never break.** The claim with its caveat, facts in the server HTML, URLs, ids, analytics calls.
**Sister sites.** Do not borrow their look or components; do not target their search terms.
```

Note any stale section further down the file (an old funnel the docs still describe) rather than
deleting it. The edit stays uncommitted until the build's first commit.

## Step 2 — the plan

- **The stack stays.** List it.
- The page order: `| # | Section | Copy it carries (rows) | Conversion code |`.
- The single conversion action, and the photo slots with what each photo must and must not show.
- The build order once the direction is locked: one commit per section, screenshots at 1280 and 375.
- The one string that pins the layout: the longest headline or fallback that every direction must
  hold.

When a finding binds every direction, write it down once before the study. Examples: a font that
lacks a glyph the copy needs (currency symbols, a script for one locale), a tabular-figure problem,
or the live site already using a tell.

## Step 3 — references through Inspo, within the study budget

**The budget is the rule:** one `recommend`, one or two `search_screens`, then `get_screen` and
`get_design_system` on the **three to five** references you keep. Each extra search adds results the
model must choose between, and leaves it less sure which style to pick.

1. `get_filters` first. A value outside its vocabulary errors. Read the industry list. When the
   site's niche is missing, choose **proxy industries** per audience — for example fintech for
   costs and business-to-business, travel for travellers, saas or agency for partner pages, media,
   education or non-profit for an independent reference. Judge proxies on structure, density and
   type, and never take their domain look.
2. `recommend`, once. Write the brief as audience + job + register, not as the category name. Add
   `vibe`, `mode`, `pageType` and `color` when they are known. Keep its **evidence packet** (the
   share of paper bands, display classes and accents among its matches). Its macrostructure pick may
   come from another register, so treat the pick as a suggestion.
3. `search_screens`, once or twice, with `industry`, `macrostructure` and the measured axes
   `paperBand`, `displayClass` and `accentHue`. Narrow combinations return zero rows. When that
   happens, drop the macrostructure or the device filter rather than spending a third search.
4. For each reference you keep: `get_screen` for every viewport, including the 375 px pair, and
   `get_design_system` for the real fonts, palette and type ramp. `find_components` crops a hero or a
   pricing block when one part is all you need.
5. **Pop-up check.** Open every capture. When a cookie, consent or sticky disclosure bar covers the
   design, drop the reference or take another page of the site (`get_site_pages`). Never let the
   agent fill the hidden part from its defaults. A site's own announcement bar is UI, not a pop-up.
6. **Measured is an average.** A capture measured as mid paper can render white. Decide paper
   against the allocation row and the tells, never by inheriting it from a reference.
7. When Inspo holds none of the sites the owner names, study them live. Read the HTML and CSS, take
   Playwright shots at both widths, save them to `<specs>/<site>-design-refs/`, and run the same
   pop-up check.

Log the study in the directions file:

- a calls table, `| Call | Arguments | Result |`, with an honest budget line ("budget 1–2, ran 2;
  the empty one added nothing");
- the pop-up check, `| Reference | Banner or overlay | Verdict |`;
- the kept table, `| Slug | Industry | Measured axes | Real fonts and ramp | Screens |`;
- the references seen and not kept, with one reason each;
- **shared tells:** a hue that two references share is that genre's tell, so no direction uses it;
- **category gravity:** "the packet says <display class> N%". Each direction goes with it or
  against it, as a position and not as a template.

## Tells to design against

Defaults that read as generated, each with what to do instead. A direction keeps a tell only when it
chooses it on purpose and says so.

| Tell | Instead |
|---|---|
| Warm cream or off-white paper (check the live site: its paper may already be this) | Paper chosen against the allocation row, named by hex |
| Purple or blue on white; warm orange on cream | An accent taken from the site's own world, checked against the sister sites |
| Instrument Serif with italics and numbered sections; Inter; Geist (the framework template's face) | Faces from the kept references' real systems, checked for every glyph the copy uses |
| Huge full-width headline text in place of imagery; a wordmark filling the first viewport | A headline sized to leave the claim, caveat and action on the first screen |
| Three equal cards, a 3×2 grid, six equal step boxes | A table, a numbered list with hairlines, or one tile that leads |
| Counters, laurels or avatars with no register row | Proof the claim register carries, or none |
| A screenshot of the product UI as the hero (an unreadable stamp at 375 px) | The real component, rendered |

## Constraints every direction carries

List them once, numbered, before the directions: the claim-and-caveat unit (one element, no
entrance animation on it, and the share image paints the caveat whenever it paints the claim), the
photo rules, text stays text, the tells avoided, the mobile baseline, analytics untouched, and fonts
already taken by sister sites. `design.md` restates them positively at the lock.

## Step 4 — three directions

The three must be **genuinely different**: every pair differs on at least two of the four axes
(macrostructure, paper, display class, accent), and one of the two is macrostructure or display
class. Directions that differ only in colour are colourways. Say which directions stay inside the site's allocation row and
which leave it, and on which axis. Leaving the row is an owner question.

Each direction states:

| Field | Holds |
|---|---|
| Name and idea | A short name, one paragraph, and why it fits this audience |
| Axes | macrostructure · paper (hex) · display class · body face · accent (hue), in-row or leaves-row |
| Gravity | with or against the category, and any change to the section order |
| References | each slug, what is taken from it, and what is not taken (and why) |
| Palette | `\| Token \| Hex \| Role \| Contrast \|`: paper, surface, line, ink, muted, accent, on-accent |
| Fonts | licence, source, glyph and figure checks |
| Type ramp | `\| Role \| Size (1280 / 375) \| Weight \| Line height \| Tracking \|` |
| Hero at 1280×800 | numbered composition, later replaced by the measured positions from the mock |
| First screen | how the claim and its caveat sit together; the product, when it is the point |
| Below the fold | a non-card shape for each repeated section |
| Mobile at 375 | what changes, and what stays on the first screen |
| Distinct from sister sites | "X instead of Y" for each sister |
| Risk and copy needs | what the build or the copywriter must solve |

Then a **side by side** with directions as columns and these rows: allocation row, vibe,
macrostructure, paper, display class and faces, accent, what the first screen leads with, the
claim–caveat bond, first section after the hero, photos needed, references, copy cost, build risk,
mock-up. End with the nearest pair and why they still differ.

Then **owner questions**: the pick, plus anything a direction needs (photo source, a metadata change
such as `theme-color`, a row it leaves). Pass them through `unslop`.

Then build the mock-ups ([stage 4](mock-ups.md)). The stop comes with their index, because the
owner picks by looking.

## Several sites in one niche

Before any site's stage 3 starts, whoever runs all the sites (the parent, under a tower) writes one
**allocation table**, so that the sites cannot converge on one register:

| Site | Macrostructure | Paper | Display class | Accent | Vibe | Proxy industries |
|---|---|---|---|---|---|---|
| <site A> | stat-led or long-document | light | roman serif or mono numerals | neutral | serious | fintech, media |
| <site B> | feature-stack, product first | mid | grotesk sans | warm, not cream | warm | travel, ecommerce |
| <site C> | photographic | dark | condensed or geometric | chromatic | loud or luxe | travel, creator |
| <site D> | split or bento | light | swiss grotesk | cool | technical | fintech, saas |

- Check `macrostructureCoverage` in `get_filters` before you commit a site to a rare shape. A thin
  shape means fewer references, not a wrong choice.
- Run one brief, one Inspo study and one reference set per site. No reference slug appears in two
  sites' `references.md`; grep the sister files to prove it.
- Share facts, never components. One shared template is how several sites become one.
- Give each site one voice, written from its `CLAUDE.md` business section.
- Every site's task carries what the other sites have taken: their rows, then their chosen faces and
  looks once they lock.
- When the owner moves a site off its row, name the sister row it now sits nearest and list how it
  stays distinct.
- **Distinctness gate:** two sites fail when paper band, display class **and** hero composition all
  match. Run it on first-screen screenshots after each pick and before each build, and check the
  nearest pair first.
