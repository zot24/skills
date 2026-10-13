# Step 2 — the quick grill

A short interview in the style of Matt Pocock's grilling skills: numbered questions, each with the
agent's recommended answer, so the owner can reply "yes" to accept or give a different answer. Quick
mode only — about five questions, all in one message.

## Rules

- Ask only what [read-the-repo](read-the-repo.md) left open. A known fact is stated, not asked.
- One decision per question. Each has a recommendation and the reason in one line.
- Show every open question at once, in full. When answers leave something open, ask the follow-ups
  in one more message, again all of them.
- An answer that changes an earlier one wins; note it in the brief.

## The questions

Pick from these; drop any the repo answers.

1. **Goal.** What should a visit end in? ➡️ Recommended: the one action the product needs most (a
   sign-up, a purchase, a booking), named from the repo.
2. **Audience.** Who is it for, in one line, and in which language(s)? ➡️ Recommended: from the app's
   README and copy.
3. **The one conversion.** Which button, and where does it go? ➡️ Recommended: the app's sign-up URL
   or a Stripe Payment Link.
4. **Domain.** Use an existing domain, or search for a new one? ➡️ Recommended: an existing one if the
   repo names it; otherwise "search", with three candidates and prices after the grill (money gate).
5. **Payments.** Does the site take money itself? ➡️ Recommended: Payment Links for fixed prices;
   Checkout on the Worker only for quantities or computed prices.
6. **Proof.** What can the site claim — customers, numbers, press? ➡️ Recommended: only what the
   owner confirms; the copy says less where there is no source.
7. **AI training bots.** Allow models to train on the site? ➡️ Recommended: yes for marketing pages;
   no if the site sells its content.

## Output: `apps/web/site-brief.md`

```markdown
# Site brief — <name>

Updated <date>. Owner answers are quoted; everything else cites the repo.

## Known from the repo
- Product: … (`apps/app/README.md:3`)
- Pricing: … (`apps/app/src/billing/plans.ts:12`)

## Answers
1. Goal: "…"
2. Audience: "…"
3. Conversion: "…" → <url or Payment Link>
4. Domain: <domain> (existing | to buy: <price>/yr, approved <date>)
5. Payments: Payment Links | Checkout
6. Proof: "…"
7. AI training bots: allow | block

## Open
- Q6 follow-up: …
```

The brief is the source of truth for owner facts in every later step. `site-design-options` reads it
as stage 1N's first input.
