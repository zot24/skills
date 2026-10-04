# Stage 4 — mock-ups the owner can open

Owners choose by looking. A paragraph describing a hero means less than one frame of it beside
today's page. So every direction becomes a static HTML file, and one `index.html` shows them
all side by side at desktop and phone width.

The mock-ups live in `<specs>/<site>-mocks/`. The app is untouched.

## What a mock-up is

- **The first screen and the next section.** Show the hero and whatever follows it (the price table,
  the calculator, the proof). The whole page waits for the build.
- **One plain HTML file per direction:** `d1.html` … `d3.html`. Variants get a letter suffix, for
  example `d2a.html`. A frozen favourite becomes `<fav>-original.html`.
- **Inline CSS.** Google Fonts are the only outside request, and a system-font direction makes
  none.
- **No scripts, no tracking, no storage, and no network call but the Google Fonts stylesheet.**
  Links are `href="#"`.
- **One exception: an interactive product.** A calculator or quote builder gets a small inline
  script. Keep its numbers in one shared engine file that a generator inlines into each version, so
  the versions cannot drift apart. Add a `<noscript>` line. Then click through it in a browser and
  compare every total with the catalog sums.
- **Real copy.** Use the copy spec's latest revision, carried by row ID. Where an owner question is
  open, show its **fallback**: the fallback is what ships, and it is often the longest string.
- **Open strings in yellow.** Mark every string that waits on the owner or the copywriter, and label
  it with its question id:

  ```html
  <mark class="open" data-q="Q4">string waiting on the owner</mark>
  <mark class="open" data-q="C">string the copywriter must write</mark>
  <style>
    mark.open{background:#FFF34F;outline:1.5px dashed #8a7a00}
    mark.open::after{content:attr(data-q);font:600 10px/1 monospace;margin-left:4px}
  </style>
  ```

  Pick a yellow that no palette uses, so the mark never reads as design. Use `[brackets]` for text
  that does not exist yet.
- **Photos as labelled blocks.** Real photos stay out until the owner supplies them. Use a striped
  block with `role="img"` and a label that says what the photo must show and must not show.
- **A corner tag on every mock:** `Mock-up · <direction> · copy: <revision> · grey block = photo ·
  links off`, set `aria-hidden`.
- `<meta name="robots" content="noindex,nofollow">` on every file.

Borrow a reference's way of building, never its brand: no names, logos or layouts copied one to
one. Borrow a table's form without its verdict words, because a verdict is a new claim.

## The index

`index.html` has no script and uses a system font. It shows:

1. A lede. It says that each frame is the real page at its true viewport, scaled down; that the
   viewer can scroll inside a frame or open the file at full size; which copy revision the mocks use;
   and what yellow and grey mean.
2. **Today first.** Screenshots of the live site at 1280×800 and 375×812, taken read-only with the
   analytics script blocked, and links to the full-page versions. When the owner's test is "different
   from today", every version sits beside today's screenshot at the same width, with a short list of
   what changed in layout, type and colour.
3. The current round first (the new directions, or the favourite and its family). Each gets a
   heading, a one-paragraph idea, an axes line (macrostructure · paper · faces · accent), a link that
   opens the file at full size, and the desktop and phone frames. Family cards add `Changed` and
   `Gives up`.
4. Earlier rounds further down, under "kept for comparison". Retired directions are listed, not
   framed.

Frames are iframes at their true size, scaled with a transform, so each one is the real page:

```css
.frame{--w:1280px;--h:800px;--s:.5;width:calc(var(--w)*var(--s));height:calc(var(--h)*var(--s));
  overflow:hidden;border:1px solid #d9dcda}
.frame.phone{--w:375px;--h:812px;--s:.7;border-radius:18px}
.frame iframe{display:block;width:var(--w);height:var(--h);border:0;
  transform:scale(var(--s));transform-origin:0 0}
.frame img{display:block;width:100%;height:100%;object-fit:cover;object-position:top}
@media (max-width:760px){.frame{--s:.26}.frame.phone{--s:.44}}
```

Give each iframe a `title` and `loading="lazy"`. A `#big:target` rule can raise the scale without a
script. For the "actually different" round, open with a **thumbnail strip**: every candidate's
desktop first screen at about 20%, headed "Can you tell these apart?"

## Check every file in a real browser

Run Playwright with the installed Chrome at 1280×800 and 375×812. Headless Chrome's
`--window-size` will not lay out below about 500 px and clips the page. Use Playwright's viewport, or
a 375 px iframe harness.

Check and record:

- exactly one `h1`, with the spec's text;
- the claim and its caveat inside one block, both above the fold at both widths. Measure the bottom
  of the claim and of the call to action against the 800 and 812 folds, and record those numbers;
- no horizontal overflow at 375;
- no scripts, apart from the calculator exception, and no console errors;
- no banned strings, and every visible string of four words or more traceable to the spec. A small
  script that lists strings missing from the spec pays for itself;
- the chosen fonts draw every glyph the copy uses, such as currency signs and locale scripts;
- the calculator totals match the catalog;
- the index loads every frame.

Write a **Checked in a real browser** section in the directions file: a results table
(`| Mock | Desktop: claim / CTA bottom | Phone: claim / CTA bottom |`), then what you fixed while
checking, then what you did not check (Safari, real phones, screen readers).

Keep helper scripts (screenshots, generator, string check) in `<specs>/<site>-mocks/src/`, not in the
scratchpad. A new session may clear the scratchpad.

## Render traps seen before

- Full-page screenshots leave off-screen iframes blank. Capture each frame scrolled into view.
- In a one-file mock, class names collide. A shared `.bar` once hid a component's own bars.
- A flex container's `gap` splits a sentence's inline spans. Give running text its own plain
  element.
- Text plus inline marks inside one grid item splits into cells. Wrap the text in a single span.
- `hgroup` holds only headings and `p`. Put a decorative emoji after the `h1` with `::after`.
- Table rows restyled as a grid on mobile lose their semantics in WebKit. Add explicit ARIA table
  roles, and use `order` when the total must come after the fee cells.
- A mono figure is about `characters × 0.6em` wide. Size a large total from that before you place
  it.
- `tnum` can widen separators. Check the font file, then a render.
- A mid-lightness accent on mid-lightness paper fails 3:1. Put its fills on white or give them an ink
  edge.
- A docked bottom bar hides the bottom of a first-screen card. Lead each card with the number that
  matters.

When a mock and the directions text disagree, the mock wins. Fold the change back into the text.

**Done when:** every mock passes the checks at both widths and the index opens with today's site.

**Stop.** Report the directions, the owner questions, one path to open (`index.html`) and one
recommendation. The owner picks.
