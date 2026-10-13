# Step 3 — the plan

Turn the brief into a checklist the agent works through and the owner can read. It lives in the repo
so any later agent picks up where the last one stopped.

Write `apps/web/site-plan.md`:

```markdown
# Site plan — <name>

Brief: site-brief.md (<date>). Owner stops: grill (done), money gate (<pending|done|n/a>).

| # | Step | Skill | State | Evidence |
|---|---|---|---|---|
| 1 | Scaffold apps/web from the template | sites | ○ | |
| 2 | Draft PR open, checks green | sites | ○ | |
| 3 | Copy spec, directions, mock-ups | site-design-options (1N–4) | ○ | |
| 4 | Owner picks, DESIGN.md locked | site-design-options (5–7) | ○ | |
| 5 | Sections built | site-design-options (8) | ○ | |
| 6 | Domain registered or confirmed | cloudflare-domains | ○ | |
| 7 | Worker custom domain, www redirect, HTTPS, DNSSEC, email | cloudflare-domains | ○ | |
| 8 | Workers Builds connected, preview per PR | sites (wire) | ○ | |
| 9 | Umami website, scripts, replays, heatmaps | umami | ○ | |
| 10 | Stripe products (test mode), links or checkout | sites (stripe) | ○ | |
| 10b | Resend domain, DNS, sending key on the Worker | sites (email) | ○ | |
| 11 | SEO + GEO setup, AI bot policies | seo-geo | ○ | |
| 12 | Launch gate | sites | ○ | |
| 13 | Search Console, Bing, IndexNow | search-engines | ○ | |
| 14 | Stripe live mode | sites (stripe) | ○ | |
```

States: `○` not started, `✱` in progress, `✓` done, `–` not needed (say why in Evidence).
Evidence is a link, a command's output line, or a `file:line` — never "done".

## Ordering rules

- Design (3–5) and wiring (6–11) run in parallel: wiring needs only the scaffold.
- The domain step (6) waits for the money gate when a purchase is involved; everything else proceeds.
- Search engines (13) run after the launch gate, on the live domain: submitting a half-built site
  wastes the first crawl.
- Stripe live mode (14) is last, after a real test-mode purchase passed the gate.

## Existing site

Mark what already exists as `✓` with its evidence from [read-the-repo](read-the-repo.md). A step that
exists but is wrong (GA instead of Umami, no sitemap) stays `○` with a note.
