# Sites

The orchestrator for landing pages and small websites on Cloudflare: one brief in, one live,
measured, indexed site out — inside the app's monorepo at `apps/web`.

## Flow

1. **Read the repo** — facts first, so the owner is asked only what the repo cannot answer
2. **Quick grill** — about five numbered questions with recommended answers → `site-brief.md`
3. **Plan** — `site-plan.md`, a checklist with evidence per step
4. **Scaffold** — the bundled Astro template into `apps/web`, draft PR
5. **Design and copy** — `site-design-options` (new-site entry), `DESIGN.md` locked
6. **Wire** — `cloudflare-domains`, Workers Builds, `umami`, Stripe, Resend email, `seo-geo`
7. **Launch gate** — serving, SEO, GEO, performance, tracking, a test purchase, no secrets
8. **Review mode** — Umami + Search Console + Bing → three actions

The agent stops only at the grill and before spending money.

## Commands

```bash
/sites:sites new            # full flow
/sites:sites grill          # brief only
/sites:sites scaffold       # template → apps/web, draft PR
/sites:sites wire umami
/sites:sites gate
/sites:sites review
```

## Template

`template/web` becomes `apps/web` (Astro 7, Cloudflare adapter, Tailwind 4 tokens from `DESIGN.md`,
SEO/GEO components, Umami, Stripe Checkout + webhook, Resend helper, Varlock schema). `template/root` holds the
pnpm + Turborepo files and the checks workflow for a repo that has none.

```bash
npx degit zot24/skills/skills/sites/template/web apps/web
```

## Depends on

zot24/skills: `cloudflare-domains`, `umami`, `search-engines`, `seo-geo`, `site-design-options`,
`1password-cli`. Official: cloudflare/skills, stripe/ai, resend/resend-skills.
