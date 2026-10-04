# Stage 1 — learn the site, snapshot it

Read-only. Nothing in the site repo changes in this stage. Work in a worktree at `origin/main`, and
read the main checkout only through `git -C <repo>` read commands: it may hold someone's
unfinished branch.

The output is two things: a **census** (what the site is, in the repo's own words, with file and
line) and a **snapshot** (the SEO and GEO surface as it is served today). Every later stage cites
both. The redesign changes the look; the snapshot is how you prove it did not change what the site
says to search and answer engines by accident.

## The census

Write `<specs>/product-census.md` (the specs folder is per site repo, so the name does not collide).
Name the commit you read at the top.

| Section | What it holds |
|---|---|
| 1. Intent | What the site sells, to whom, and the one action a visit should end in, quoted from the repo |
| 2. Implementation | Stack, routes, the write paths (forms, calculators, chat links), stubbed or dead code |
| 3. UI | Every page as served: its sections in order, its calls to action, its interactive parts |
| 4. Docs vs code vs UI | Every place the README, `CLAUDE.md` or docs describe something production does not serve |
| 5. What not to do next | Traps a later seat must avoid (an owner's open branch, a stale funnel in the docs) |
| 6. Open work | Open PRs and issues with labels, unmerged branches, the main checkout's uncommitted edits — one line each, abandoned ones marked |

Then two lists inside the census, because the copy stage starts from them:

- **Where copy lives.** Every file, JSON, MDX or CMS entry that holds user-facing text, with paths.
- **Every factual claim.** Each claim about price, timing, law, tax, eligibility, counts or results,
  with `file:line`. A claim with no line is a claim nobody can check later.

Write for what production serves. When the docs describe a funnel that is not mounted, the census
says so and the copy stage writes for the live site.

If the repo has no `CONTEXT.md`, draft one to `<specs>/CONTEXT-draft.md` from what the repo
already says: terms and their agreed meanings, each with `file:line`. Where two sources disagree,
list both and do not choose.

**Done when:** every served page (from the sitemap, or crawled when there is none) appears in
section 3, and every factual claim on those pages has a `file:line` row.

## The live site

Fetch the live host read-only: the pages, `robots.txt`, `sitemap.xml`, `llms.txt`. Say whether the
live copy matches `origin/main`, where it is hosted (response headers), and every gap a search engine
or an answer engine would see: missing metadata, missing structured data, canonicals pointing at the
wrong page, missing hreflang, thin pages, a page body that only exists after hydration.

## The snapshot

Save under `<specs>/<site>-seo-snapshot/`, one folder per URL in the sitemap. With no sitemap, take
the URLs from the home page's internal links, followed one level deep, and say so. Use `curl -sL <url>`
with no JavaScript — that is what a crawler and most answer engines read.

For every URL:

- title, meta description, canonical, robots meta
- Open Graph and Twitter tags
- hreflang links
- the `h1` and `h2` text, and the visible body text from the server HTML
- internal links
- every `application/ld+json` block, saved as its own file and parsed once to prove it parses

Also save `sitemap.xml`, `robots.txt` and `llms.txt` as they are.

**Done when:** every URL (sitemap or crawled) has a folder, every JSON-LD block parses, and the
census names any page whose served HTML is missing its body or its structured data.

## Screenshots of today

Capture the live first screen at 1280×800 and 375×812, plus full-page versions. Block the site's
analytics script while you do (Playwright `page.route` on the tracker's URL), so the capture adds no
pageview. These go first in every mock-up index ([mock-ups](mock-ups.md)).

## Stop rules

- No deploy, no PR, no issue, no tracked-file change in this stage.
- Sending a URL to an outside validator (a rich-results tester) is the owner's call, not yours.
