# Stage 2 — copy from a source of truth

Copy is the deliverable; the design carries it. Three passes, each by a different seat:

1. **Strategist** writes `<site>-copy-spec.md`. Give this to your strongest writer.
2. **Adversary** attacks the claim register and writes `<site>-copy-adversary-out.md`. Use a model
   from **another provider** — another vendor's coding agent (grok, codex, gemini) started on the spec
   path with the adversary task below. A different family catches what the writer's family misses.
   If none is reachable, use a fresh-context reviewer and tell the owner that the check was
   same-family.
3. **Reviser** applies exactly the fixes the adversary measured, in place. Copy the spec to
   `<site>-copy-spec.rev1.md` first; the revised spec carries a "Revision 2" log.

**A round** is one attack plus one revision. Run a second round only when the first verdict was
`NOT-FIT` or rows are still open after the revision; the second revision logs as "Revision 3". After
two rounds, stop and put what is still open to the owner.

All three are read-only on the site repo: the spec, the attack and the revision are the only files
written. The design stage reads the spec, and the build applies it byte for byte.

## What the strategist reads first

1. The census and the `CONTEXT.md` draft ([learn the site](learn-the-site.md)): every copy
   location, every claim with `file:line`, every place the docs and production disagree.
2. The copy itself, in the files the census names, plus metadata, share images, `llms.txt`,
   sitemap and robots.
3. Why the current copy reads as it does: the merged PRs that approved it (`gh pr view N
   --comments`). Improve an approved decision; to reverse one, name it and give the reason.
4. The knowledge base: the compiled layer first (`/wiki:query` in an llm-wiki hub), then the primary
   source behind it (the statute, the tariff, the official page). When a primary source is missing,
   add it with `/wiki:ingest` and `/wiki:compile` before citing it. Client or private case material
   is never a source or an example.

## The spec, section by section

`<specs>/<site>-copy-spec.md`. The section numbers are stable, because the adversary, the reviser and
the checks all cite them.

**Header.** The title, then (after revision) the `## Revision 2` log, then `## About this spec`:
provenance, how to use the spec, and the legends. The **hub legend** maps short keys to source paths
(`| Key | File |`, "line numbers as read on <date>"). The **repo legend** is one line
(`LC = lib/content.ts, P = app/page.tsx`). Citations take the form `KEY:line "quoted phrase"`.

### 1. Positioning

One page. Who the site is for and who it is not for, the one promise, the proof, and the voice.

### 2. Claim register

Every factual claim on the live pages today and every claim proposed, grouped by topic.

| ID | Claim | Where | Source | Status |
|---|---|---|---|---|
| R01 | <claim as worded> | `P:42`, `LC:17`, JSON-LD, `llms.txt` | `KEY:120 "<phrase>"` | supported |

- **Where** lists every surface the claim appears on, not only the first.
- **Status:** `supported`; `soften` (give the softer wording, which sections 3–5 then use);
  `unsupported` (removed); `owner fact`; `banned`. Mark changes in bold, and new rows `NEW`.
- **Owner facts** get their own subsection (`| ID | Claim | Where | Status |`). They are names,
  prices, policies and counts that only the owner knows. The knowledge base never supplies one. Each
  row reads `owner fact, asked: Q<n>; fallback F<n>`, and nothing ships on a guess.
- **Named qualifier.** When a headline claim needs a caveat, define the caveat once as a constant
  (`CAVEAT_<x>`). Every block that shows the headline claim also carries the caveat.
- **Banned list**, last: `| ID | Patterns | Why |`. Each pattern is a case-insensitive regex that the
  checks run on surfaces. List the paraphrases too, including revision 1's own overstated wordings,
  so that they cannot return.
- Price sites add a **variables table** (`| Name | Value now | Source | Changes when |`) and a price
  table that splits each line into its official part and the owner-set part.

### 3. Copy, page by page

The section is titled "section by section" when a design seat follows, and it adds a proposed page
order.

- **3.1 Decisions kept, changed or reversed:** `| Decision (where: PR/commit) | This spec |`.
- **Strings**, in page order, under bold block headings:
  `| # | Current (file:line) | Proposed | Why | Claims |`. A kept string says `kept` or `kept, byte
  for byte`. A new string has Current `none`. A removed string says `removed`, or `Q<n> no:
  removed`. The Why column uses conversion, clarity, accuracy (R<n>), SEO, GEO or approved.
- **Metadata and share strings:** `| # | Current | Proposed | Why |`, with character counts.
- **Source links:** `| [n] | Label | href | Cited by | Phrase the fetched page must carry | If the
  fetch or the phrase fails |`.

A new or removed section says why it earns the change.

### 4. SEO

| § | Holds |
|---|---|
| 4.1 | `\| Intent \| Terms people type \| Where it is answered \|` |
| 4.2 | Title and meta description per page, with character counts. A title that cannot hold the caveat carries no number |
| 4.3 | The heading outline, as a code block |
| 4.4 | Canonical, `<html lang>`, trailing slash, apex vs www. hreflang only when a second language exists; then en, the new language and x-default together |
| 4.5 | Canonical, self-canonical or `noindex` for each secondary page, with reasons. The sitemap lists canonical URLs only |
| 4.6 | `sitemap.xml` and `robots.txt` in full. `lastmod` equals the recorded re-check date |
| 4.7 | JSON-LD in full. A preface says which owner answers it assumes, which fallback changes which field, and what it omits on purpose (offers, ratings, founder, address until the owner answers) |
| 4.8 | Open Graph and Twitter, `\| Tag \| Value \|` |
| 4.9 | Internal links and deep-link ids. Links to sibling sites are the owner's call |

Multilingual sites add translation keys per locale and a "what must be in the server HTML" list.

### 5. GEO

The GEO surfaces are what answer engines repeat, so they carry the same limits as the body.

- **5.1 Answer-first passages:** `| ID | Question it answers | Passage | Source |`. Each passage
  stands alone, names the entity, and dates any fact that moves. `llms.txt` uses them verbatim.
- **5.2 FAQ** as the questions people ask an assistant. The visible FAQ and the `FAQPage` JSON-LD
  come from one array.
- **5.3 One fact set:** `| Element | Page | Metadata | JSON-LD | llms.txt |`, with one row each for
  name, offer, headline fact, exceptions, contact, disclaimer, date and price.
- **5.4** The full proposed `llms.txt`: `# Name`, a `>` summary, topic sections, `## Questions
  people ask`, `## Sources` (only links that pass the liveness check), `## Notice`.

### 6. Owner questions

Only what the knowledge base and the repo cannot settle. The section opens with one rule: until
every question has an answer, check 0 fails.

```
**Q<n>. <Question>? (<row IDs>)** <What the repo shows, KEY:line. Why the sources cannot settle it.>
**Recommended:** <answer>. Strings: row <#> "<text>".
**Fallback (no / blank):** "<string that ships>", or set F<n>:
| String | F<n> text |
<Guard: "Before the answer, no <token> appears on any surface (check <k>).">
Answer: open.
```

Undoing an earlier deliberate removal is the owner's call, so it becomes a question here.

### 7. Later, not this job

New pages ranked by source depth times search value, one line each. Each new page needs its own
claim register. Language editions go here. When sibling sites share a niche, add **search terms per
site**: `| Site | Owns | Leaves to others |`, plus a "Contested" line. Each spec copies the other
sites' rows unchanged and refines only its own.

### 8. Acceptance checks

Statements a gates file runs against the built site — a file of checks, each with what it expects,
that a script runs and that exits non-zero when any check fails. **Every check must be able to
fail.**

- One run line (build, serve, fetch the listed URLs) and the defined terms. *Visible text* is the
  parsed DOM with script, style, hidden and `aria-hidden` removed. *Surfaces* are visible text,
  title, meta, JSON-LD string values, `llms.txt`, share-image text and the manifest, never code
  comments.
- **0. Answers recorded.** While any owner question reads "Answer: open", no other check runs. The
  build and the type check are a build gate, not a claim check.

Checks that bite:

1. Delete every chosen string from every surface. Only whitespace and punctuation remain, so a
   reworded or added sentence fails.
2. Every sentence that matches a locked-topic regex equals a chosen string, so a paraphrase fails.
3. Every source URL, fetched with browser headers and one retry, returns 200 with the required
   phrase. Otherwise the no-link fallback ships, and a shipped dead link fails.
4. Until the owner answers the price question, any currency token on any surface fails.

Checks that cannot fail, and the fix for each:

- "Appears in the HTML" also passes on JSON-LD, comments or hidden nodes. Require visible text in
  the named block.
- "Every constant is in the spec" passes a build that changed nothing. Use check 1.
- A substring ban misses paraphrases and also hits "do not say" comments. Use regexes, run on
  surfaces only, matched on token boundaries ("0%" must not match inside "10%").
- A disclaimer count passes while the share image states the result. Require the qualifier in the
  same block as every headline number.
- FAQ parity passes when both copies are wrong. Require JSON-LD strings to equal the corrected
  sentences.
- A date locked to the review day passes. Require the date to equal a recorded re-check; with no
  re-check, no date line ships.
- A check that only compares the build to the spec passes a false spec. Pair it with a check
  against the source.

## The adversary

The task: assume the spec has errors, because a wrong claim can cost a reader money or legal trouble.

1. Check every register row: open each cited line and give a verdict — **holds**, **overstated**
   (give the honest wording), **misread** (quote what the line says), **unsupported**, or **stale**
   (cite the newer source). Where a row cites a compiled article, also check the article's primary
   source.
2. List strings that no row carries, or that say more than their row, in sections 3, 4.7, 4.8 and 5.
3. Check the banned list and the caveat line. Name the risky phrasing the list misses: guarantees,
   "legal" used as a promise, implied outcomes, numbers without a date.
4. Flag owner facts that the spec states as fact.
5. Name each acceptance check that cannot fail, and say how to make it bite.

The report: an opening paragraph (what was read, what was opened behind the compiled layer, link
checks with HTTP codes), then `## Summary` as `| Row | Verdict | Fix |`, then one section per task
item. It closes with one line: `VERDICT: FIT`, `VERDICT: FIT-WITH-FIXES` or `VERDICT: NOT-FIT`. A
`NOT-FIT` sends the reviser back to the primary sources first.

## The reviser

1. Read the spec and the attack in full.
2. For every row that is not *holds*, apply the Fix, or wording at least as careful that you can
   cite. Then **carry the change to every surface the row appears on**: the strings, JSON-LD, Open
   Graph, the share image, the answer-first passages, the FAQ and `llms.txt`. A claim that changed in
   the register but not on a surface is a defect.
3. Keep owner facts out of shipped strings. Each gets a question with a recommended answer and a
   fallback string.
4. Rewrite the checks the adversary says cannot fail.
5. Do not widen the spec. Where you disagree with a fix, keep the more careful wording and say why.

The **Revision 2 log** goes at the top of the spec. It holds:

- the input and its verdict;
- the lines re-read and the links fetched, with status codes;
- `| Row | Old status | New status | Why |`;
- where this revision is more careful than the Fix;
- what did not change, and why;
- the owner questions now open, ending "The build waits for all N (check 0)".

## Copy rules worth keeping

- Use the source's own modal verbs ("up to", "may", "can be extended"). "Lasts", "allows" and
  "will" overstate them.
- Every moving number carries its date. A converted currency carries its rate and date in the same
  sentence. A fee shown without its total reads as the price, so print the total beside it.
- An internal spreadsheet total can hide bundles, fines or unofficial lines. Rebuild prices from
  the primary source, the official price list.
- Cite a source only if the page fetched that day carries the claim's distinctive words. Official
  sites may refuse bare requests: use browser headers and a retry, then archive captures, and log the
  status codes.
- Keep distinct facts apart even when they share a label. Name the members, not the umbrella.
- When the owner's own sources point two ways, the page does not take the more flattering one.
- Read every locale's strings, including bundled ones that never render. Delete dormant code that
  holds invented social proof; never mount it.
- Name the entity and the place in the first screen and in the title. Keep one clock, so that timing
  claims match on every surface.
- Each sibling site owns its search terms. Drop claims that belong to another site's lane.
