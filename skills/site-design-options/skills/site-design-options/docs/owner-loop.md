# Stage 5 — the owner's loop

After the mock-ups the owner answers in one of a few ways. Each answer has its own loop, and each loop
ends where stage 4 ends: a rebuilt `index.html`, a browser check, a report with one path to open, and
a **stop**. Repeat the loop as often as the owner asks.

| The owner says | Loop |
|---|---|
| "I pick 2" | Go to [lock and structure](lock-and-structure.md) |
| "I like 2, give me more options from it" | [The family loop](#the-family-loop) |
| "I want something actually different, but keep the one I like" | [The "actually different" loop](#the-actually-different-loop) |
| "I want the feel of <named sites>" | [A named taste](#a-named-taste) |
| "I don't see the calculator" or "it looks like what we had" | [The product on the first screen](#the-product-on-the-first-screen) |

Record the owner's words verbatim and with the date at the top of each round's section in the
directions file. Owner examples ("for example, a version that groups the packages differently") are
examples, not orders. Build the ones that serve the copy spec best, and say why you skipped any.

## Freeze the favourite

Do this before anything else in any loop that keeps a favourite:

```bash
cp d2.html d2-original.html
chmod a-w d2.html d2-original.html
shasum -a 256 d2.html d2-original.html > frozen.sha256
# ... the round's work ...
shasum -a 256 -c frozen.sha256     # at the end; any FAILED line is a defect
```

The favourite's section in the directions file stays unchanged too. A later round freezes the
family members it keeps in the same way.

## The family loop

The owner liked one direction and wants alternatives built from it. Make three variants, for example
`d2a.html`, `d2b.html` and `d2c.html`.

1. **List what every variant keeps.** These are the favourite's essentials: its idea, its key
   component, the number that is largest on the page, its single action, and its palette family.
2. **Each variant changes one real thing:** the layout of the main component, how strong the product
   moment is, how many taps away the answers sit, how the proof is shown. A change of colours alone
   is a **colourway**, and the owner compares choices, not colourways.
3. Make each variant change a different part of the page, so the owner can say "2b's header with
   2c's tiles".
4. Generate the variants from the favourite's own `<style>` block (a small script that reads it),
   so the differences are structure, not drift. Add no new colour or face unless that is the one
   change.
5. Per variant, write: the idea, what it learned from, **what changed from the favourite**, the hero
   composition, the measured positions, and **what it gives up** compared with the favourite,
   including any call it needs from the copywriter.
6. Write a comparison table with the favourite and the variants as columns, and these rows: the one
   change, the key number above the fold, copy needs, and what it combines with.
7. Rebuild the index with the favourite first, then the variants three across, then the earlier
   directions further down.

When the owner asked for a family "in the style of" a body of work, run a wider live study of that
work first. Give each variant a different strength of it, for example a data table, a founder's
voice, or a product landing with proof. Borrow the way of building, never the brand.

## The "actually different" loop

The owner wants looks that differ from the favourite and from each other, not more of the same.

1. Freeze the favourite and its whole family.
2. **Run a fresh Inspo study** within the same budget: one `recommend` and one or two searches.
   Aim it at other macrostructures and type classes, for example `macrostructure=conversational-faq`
   or `displayClass=slab-serif`, and at new proxy industries (booking, food ordering, telecom plans,
   fare pages, price comparison). Map each proxy onto Inspo's real industries, and say where none
   fits.
3. **Split all four axes.** Each new direction takes a different macrostructure, display type class,
   paper and accent from the favourite and from each other. No palette uses the review-mark yellow.
4. Every direction still keeps the essentials: the clear price or claim, the total or caveat in
   view, the one action, and the copy spec's strings.
5. **Stay clear of the sister sites' chosen looks.** Read their locked faces and devices first. For
   each sister, write one line: "<this> instead of <their look>; no <their device>". Retire earlier
   directions that now sit near a sister's pick.
6. Write a side by side with only `| | Macrostructure | Paper | Display class | Accent | Hero |`,
   then the gate.
7. **Thumbnail test.** Open the index with a strip of every candidate's desktop first screen at
   about 20%. When two cannot be told apart at that size, they are not different. Rework one.

## A named taste

The owner names sites whose feel they want ("simple, like <maker>'s sites").

1. Study the named sites. Use Inspo if it holds them. If it does not, use read-only fetches and
   Playwright shots at both widths, saved to `<specs>/<site>-design-refs/`. Note what makes them work
   (density, type sizes, icon use, how price and proof sit, the single action) and what you will not
   copy (names, logos, one-to-one layouts).
2. Add it as a new direction in the same shape as the others, with a mock-up. A taste often leaves
   the site's allocation row. That is the owner's call and it stands. Say which sister row it now
   sits nearest, and how it stays distinct.
3. Watch the pattern's trap. Simple maker sites lean on live counters and social proof. Every number
   still needs a register row, so drop any proof without one.

## The product on the first screen

The owner found the product missing or the page unchanged. Every new version fixes both.

1. Keep the part of the liked direction the owner named, such as its device or its accent.
2. Make three versions, each a different way to put the **working** product at the centre of the
   first screen, or one short scroll below a one-line answer at most. Examples: the product itself is
   the figure, a split screen with controls on one side, a phone-first compact tool.
3. Use the copy spec's values, and put unconfirmed prices in yellow.
4. Show today's live page first, then every version beside it at both widths. Each version lists
   what changed in layout, type and colour. All three must change, not only details.
5. Click through every version and check that the totals add up.

From here on, every new direction starts with the product on its first screen.
