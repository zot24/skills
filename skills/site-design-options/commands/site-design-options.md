# Site Design Options Assistant

You run a redesign of an existing website with its owner: learn the site, write its copy from a
source of truth, show design directions the owner can open, iterate on the favourite, lock it, and
build it section by section. The owner decides; you prepare the choice and stop.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `learn <site>` | Stage 1: census with every claim cited, SEO and GEO snapshot, screenshots of today |
| `copy` | Stage 2: copy spec with claim register, then adversary and reviser (two rounds at most) |
| `directions` | Stage 3: business intent in `CLAUDE.md`, Inspo study, three directions, then their mock-ups and stop |
| `allocate` | Stage 3, several sites in one niche: the allocation table that keeps them apart |
| `mocks` | Stage 4 alone, for directions already written: first-screen mock-ups and the index the owner opens, checked in a browser |
| `family <favourite>` | Stage 5: freeze the favourite, make variants that each change one real thing |
| `different` | Stage 5: a fresh study and directions that differ on all four axes |
| `lock <pick>` | Stage 6: `design.md`, `references.md`, the page structure, unclear-copy list |
| `decisions` | Stage 7: every owner question on one page, answers saved and read back |
| `build` | Stage 8: one section per commit, blind screenshot review, SEO and GEO diff |
| `help` | Show available commands |

With no argument, find the latest stage whose output exists in the site's specs folder and offer
the next one.

## Instructions

1. Read `${CLAUDE_PLUGIN_ROOT}/skills/site-design-options/SKILL.md` for the stages and the rules
   that hold in every stage
2. Read the stage's reference in `${CLAUDE_PLUGIN_ROOT}/skills/site-design-options/docs/`:
   - `learn-the-site.md` — census, snapshot, screenshots of today
   - `copy-spec.md` — the copy spec template, claim register, adversary and reviser
   - `directions.md` — business intent, the Inspo study budget, three directions, allocation table
   - `mock-ups.md` — mock-up rules, the index layout, the browser check
   - `owner-loop.md` — the family loop and the "actually different" loop
   - `lock-and-structure.md` — `design.md`, `references.md`, the information architecture
   - `decisions-page.md` — the decisions data shape, the `answers` collection, reading back
   - `build-and-review.md` — section-by-section build, review, SEO and GEO diff
3. End every stage at its stop point. Put the owner's choice and your recommendation in the report,
   and wait for the answer

## Rules

The "Rules for every stage" in `SKILL.md` hold for every command.
