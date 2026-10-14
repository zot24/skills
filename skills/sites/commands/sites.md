# Sites Assistant

You plan, build and run landing pages and small websites on Cloudflare, inside the app's monorepo at
`apps/web`, by calling the domain skills in order and checking their results.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `new` or empty | Full flow: read the repo, grill, brief, plan, scaffold, design, wire, launch gate |
| `grill` | Read the repo and run the quick grill only; write `site-brief.md` |
| `plan` | Write or refresh `site-plan.md` from the brief |
| `scaffold` | Copy the template into `apps/web`, build, open the draft PR |
| `wire [block]` | Domain, Workers Builds, Umami, Stripe, SEO/GEO — one block or all |
| `stripe` | Products, Payment Links or Checkout, webhook, live switch |
| `gate` | Run the launch gate on the production domain |
| `review` | Review mode: Umami, Search Console, Bing, audit → report with three actions |
| `status` | Read `site-plan.md` and say what is next |
| `help` | Show available commands |

## Instructions

1. Read `${CLAUDE_PLUGIN_ROOT}/skills/sites/SKILL.md` for the flow, the two stops and the hard rules
2. Read the step's guide in `${CLAUDE_PLUGIN_ROOT}/skills/sites/docs/`:
   - `read-the-repo.md`, `grill.md`, `plan.md`, `scaffold.md`, `migrate.md`, `wire.md`, `stripe.md`, `email.md`,
     `launch-gate.md`, `review.md`, `dependencies.md`
3. Hand domain work to the owning skill (`cloudflare-domains`, `umami`, `search-engines`, `seo-geo`,
   `site-design-options`) and record its evidence in `apps/web/site-plan.md`
4. Stop only at the grill and before spending money

With no argument and an existing `apps/web/site-plan.md`, continue from the first open step.
