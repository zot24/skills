---
name: sites
description: Plans, builds and runs a landing page or small website on Cloudflare end to end, inside the app's monorepo at apps/web — reads the repo, runs a quick grill, writes site-brief.md and a plan, hands design and copy to site-design-options, then wires the domain, Umami (with heatmaps and replays), Google Search Console and Bing, Stripe, Resend email and Workers Builds deploys, and runs a launch gate and a later review mode. Ships an Astro starter template. Use when someone wants a new landing page, marketing site or product site, wants an existing one launched or reviewed, or asks to "set up the site" for a project. Triggers on landing page, website, marketing site, launch the site, new site, site brief, apps/web, site review, site starter.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# sites

One brief in, one live, measured, indexed site out. This skill owns the questions, the brief, the
plan, the launch gate and review mode. Every domain task belongs to a skill that also works alone;
`sites` calls them in order and checks their results.

## Two stops, nothing else

The agent does every reversible step itself. It stops only:

1. **At the grill** — about five questions, each with a recommended answer; "yes" accepts.
2. **Before money** — a domain purchase, a paid plan. Show the item and the price, wait for an
   explicit yes. Registration is not refundable.

Everything else — DNS, Umami website, Search Console, Stripe test products, the PR — runs without
asking, and the plan file records it.

## The flow

| # | Step | Guide | Ends on |
|---|---|---|---|
| 1 | Read the repo | [read-the-repo](docs/read-the-repo.md) | facts list, no questions yet |
| 2 | Quick grill | [grill](docs/grill.md) | `apps/web/site-brief.md` |
| 3 | Plan | [plan](docs/plan.md) | `apps/web/site-plan.md` checklist |
| 4 | Scaffold | [scaffold](docs/scaffold.md) | `apps/web` from the template, builds green |
| 5 | Design and copy | `site-design-options` → new-site entry | locked `DESIGN.md`, copy spec, sections built |
| 6 | Wire | [wire](docs/wire.md) | domain, Umami, Stripe, email, search engines, Workers Builds |
| 7 | Launch gate | [launch-gate](docs/launch-gate.md) | every check green, live URL |
| 8 | Review (later, on demand) | [review](docs/review.md) | one report, at most three actions |

On an existing site, start at step 1 and skip what already exists: the plan marks those steps done
with the evidence. A site on another stack (Next.js, Vercel) is a migration: read
[migrate](docs/migrate.md) before step 3 — URLs, redirects, tracking codes and the locked look carry
over, and the production cutover waits for the owner's yes.

## Skills it calls

| Skill | For | Source |
|---|---|---|
| `cloudflare-domains` | search, money gate, DNS, redirect, email, tunnel hostname | zot24/skills |
| `umami` | website, scripts, replays, heatmaps, revenue events | zot24/skills |
| `search-engines` | Search Console, Bing, IndexNow, monitoring | zot24/skills |
| `seo-geo` | head tags, JSON-LD, AI crawlers, llms.txt, audit | zot24/skills |
| `site-design-options` | copy spec, directions, mock-ups, DESIGN.md lock, build | zot24/skills |
| `cf-cli`, `wrangler`, `workers-best-practices`, `web-perf` | Cloudflare API, Workers config, deploys, performance | cloudflare/skills |
| `stripe-best-practices`, `stripe-docs` | products, Checkout, webhooks | stripe/ai |
| `resend-cli`, `resend`, `email-best-practices` | email domain, keys, sending | resend/resend-skills |
| `1password-cli` | secrets when Varlock is not set up | zot24/skills |

Install the official ones as dependencies, never copy them: see [dependencies](docs/dependencies.md).

## Defaults

| Decision | Default |
|---|---|
| Where | `apps/web` in the app's pnpm + Turborepo monorepo; the repo root when the repo is the site; nothing else |
| Stack | Astro (static pages, React islands, content collections), one Worker with static assets |
| Not Astro when | The "site" is really an app: logins, dashboards, most pages behind data. Use TanStack Start on Workers (`npm create cloudflare@latest -- <name> --framework=tanstack-start`, the `wrangler` skill for config) and keep the marketing pages in Astro |
| Deploy | Cloudflare Workers Builds; GitHub Actions only for checks |
| Analytics | The owner's self-hosted Umami at `umami.<domain>`; no Google Analytics, no fallback |
| Conversion | Whatever the brief names: a sign-up link, a chat link, or Stripe. Payments are optional |
| Email | Resend, sending from `info@<domain>`; Cloudflare Email Routing forwards `info@` to the owner |
| Payments | Stripe Payment Links for fixed prices; Checkout Session + webhook on the Worker for dynamic ones; one Stripe account, products per brand |
| Secrets | 1Password through Varlock (`.env.schema`), `op` CLI fallback |
| Look | Free per site, locked in `apps/web/DESIGN.md` |

## Hard rules

- **No private data in a public repo.** Vault names, account and tunnel IDs, private hostnames and
  personal emails come from the environment. The committed `.env` holds only public values.
- **Facts from the repo, not from questions.** Never ask what the repo or the app already answers.
- **Test mode until launch.** Stripe test keys and test products until the launch gate passes.
- **One PR per site** for `apps/web`, opened as a draft at scaffold and driven to green.

## Template

`template/` in this plugin is the starter: `web/` becomes `apps/web`, `root/` holds the monorepo files
for a repo that has none yet. See [scaffold](docs/scaffold.md).
