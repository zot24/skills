---
name: site-design-options
description: Redesigns an existing website with its owner — learns the site, writes cited copy, shows design directions as mock-ups the owner opens, iterates on the favourite, locks design.md and the page structure, then builds section by section. Use when the owner asks to redesign a site or rewrite its copy, SEO and GEO with the look; wants design options or mock-ups to choose from; asks for more versions of a favourite or "actually different" ones; or wants a site's design locked or its open questions gathered. Also triggers on copy spec, claim register, design.md, information architecture, decisions page.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# site-design-options

You prepare choices for a site owner and stop. The owner chooses by **looking** — at mock-ups in a
browser, beside today's site — not by reading descriptions. Eight stages; each ends on a file you can
point at. Three end on a **stop** where the owner decides, and the last on a PR the owner merges.

## The stages

| # | Stage | Writes | Done when |
|---|---|---|---|
| 1 | [Learn the site](docs/learn-the-site.md) | census, SEO/GEO snapshot, screenshots of today | every sitemap URL snapshotted; every claim has `file:line` |
| 2 | [Copy from a source of truth](docs/copy-spec.md) | copy spec, adversary report, revision | every factual string has a register row; the adversary's fixes are carried to every surface (two rounds at most) |
| 3 | [Directions](docs/directions.md) | `CLAUDE.md` business section, directions file | three directions, study budget kept and logged; go straight to 4 |
| 4 | [Mock-ups](docs/mock-ups.md) | one HTML file per direction, `index.html` | every file checked in a real browser at 1280 and 375 — **stop** |
| 5 | [The owner's loop](docs/owner-loop.md) | variants beside the frozen favourite | favourite's hash unchanged; each variant names its one change — **stop**, repeat as asked |
| 6 | [Lock and structure](docs/lock-and-structure.md) | `design.md`, `references.md`, IA, inner-page mocks | each inner page owns one search question; every open string is yellow and listed |
| 7 | [One decisions page](docs/decisions-page.md) | decisions JSON, an Artifact page | every owner question on it once; answers read back — **stop** |
| 8 | [Build and review](docs/build-and-review.md) | one commit per section, a PR | blind review passes; the SEO/GEO diff shows only planned changes |

Stage 7 runs as soon as questions pile up (usually after the first mock-ups) and is republished
as new ones arrive; stages 6 and 8 start from its answers.

Specs, mock-ups and reports live in one ignored specs folder per site repo: `<repo>/.tower/specs/`
under a tower, otherwise `<repo>/.design-specs/` listed in `.git/info/exclude` so no tracked
`.gitignore` changes. Before stage 8 nothing is committed to the site repo: edits to `CLAUDE.md`,
and the new `design.md` and `references.md`, wait in the worktree for the build's first commit.

## Rules for every stage

- **Cite or cut.** Every factual string — price, timing, law, count, result — has a claim-register
  row with a source a reader can open. Where the source is silent, the copy says less. Owner facts
  come only from the owner; until answered, the fallback string ships.
- **The owner picks.** At a stop, put the choice and your one recommendation in the report, then
  wait. You never pick a direction, a favourite or a lock.
- **Today first.** Every mock-up index opens with today's site at the same widths, so a change in
  layout, type and colour is visible, not claimed.
- **The product on the first screen.** When the product is interactive (a calculator, a quote
  builder), every direction puts the working tool on the first screen. A static picture of it reads
  as "no calculator".
- **Claim and caveat are one element.** A headline claim and its required caveat sit in one block at
  every width, with nothing between them.
- **Yellow means open.** Every string waiting on the owner or the copywriter is highlighted in
  yellow with its question id, in every mock.
- **Freeze the favourite.** Copy it, make it read-only, record its hash; variants are new files.
- **Measure in a real render.** Fit, fold and totals are checked in a browser, never estimated.
- **Owner-facing words go through `unslop`** — questions, labels, index notes, reports.
- **Hard limits:** no client or private case material; mock-ups make no network call but the Google
  Fonts stylesheet, and carry no tracking; merge, deploy or outside validators only on the owner's
  word.

## Roles

Under a tower each stage is a seat; alone, you play every role but the adversary.

| Role | Stage | Note |
|---|---|---|
| Strategist | 2 | the strongest writer — copy is the deliverable |
| Adversary | 2 | a model from another provider; same-family fallback is reported to the owner |
| Reviser | 2 | applies the measured fixes, never widens |
| Design director | 3–6 | Inspo, directions, mock-ups, the lock |
| Collector | 7 | gathers every owner question across specs |
| Build seat, blind reviewer | 8 | the reviewer never saw the build |

## Other skills and tools, by stage

| Use | Stage | For |
|---|---|---|
| llm-wiki: `/wiki:query`, `/wiki:ingest`, `/wiki:compile` | 2 | find a claim's source; add a missing primary source before citing it |
| Inspo MCP | 3, 5, 8 | real-site references within the study budget; component crops while building |
| `writing-for-agents` | 3, 6 | the site's `CLAUDE.md` business section and `design.md` are agent-facing |
| `emil-design-eng`, `apple-design`, `mobile-native`, `pick-ui-library` | 3–6 | shaping directions; `design.md`'s component and motion rules |
| `emil-prototype` | 4–5 | only when the owner asks to flip through live variants |
| `review-animations`, `break-ui`, `mobile-native` | 8 | the blind reviewer, on the built pages |
| `unslop` | 2–7 | every owner-facing line; user-invoked, so read `~/.claude/skills/unslop/SKILL.md` and apply it |
| `artifact-capabilities`, `artifact-design` | 7 | the decisions page and its `answers` collection |
| Playwright with the system Chrome | 1, 4–6, 8 | screenshots at 1280×800 and 375×812 |

Emil Kowalski's skills come from `github.com/emilkowalski/skills`; a tower may stage a pinned copy
(`~/tower/.tower/vendor/emil-skills-<sha>/`). Copy them into the site worktree's `.claude/skills/`,
per site rather than user-wide; the build commits them with their licence.

## Common workflows

- **One site:** 1 → 2 → 3 → 4, stop; 5 as often as the owner asks; 6 and 7, stop; 8.
- **Several sites in one niche:** stages 1–2 per site, then one [allocation
  table](docs/directions.md#several-sites-in-one-niche) before any stage 3; every brief carries what
  the others took, and the distinctness gate runs before each build.
- **Owner turns:** "keep that one, more options from it" → the [family
  loop](docs/owner-loop.md#the-family-loop). "Actually different" → the [fresh-study
  loop](docs/owner-loop.md#the-actually-different-loop). "I don't see the product" or "it looks
  like before" → the product on the first screen, today's screenshot beside every version.
