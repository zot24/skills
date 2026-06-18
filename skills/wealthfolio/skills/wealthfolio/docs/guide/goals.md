> Source: https://wealthfolio.app/docs/guide/goals

The Goals feature turns Wealthfolio into a planning tool: pick a goal, link the accounts that fund it, and the app projects your progress and tells you whether you're on track.

> Looking for the retirement planner or FIRE calculator? See
> [Retirement Planning](/docs/guide/retirement-planning).
> For tax-advantaged contribution caps (RRSP, TFSA, IRA, 401(k)…), see
> [Contribution Limits](/docs/guide/contribution-limits).

## The Goals Dashboard

Open `Goals` from the sidebar to see every goal at a glance.

The dashboard summarises:

- **Saved** — total current value across all active goals.
- **Target** — sum of every goal's target amount.
- **Overall** — combined progress percentage.
- **On track** — number of goals projected to hit their target.

Each goal is shown as a card with a cover image, a title, the target date and time remaining, the current saved amount, the remaining amount, and a colour-coded progress bar:

- **Green** — On track (projected to reach the target).
- **Amber** — At risk (projected between 90 % and 100 % of the target).
- **Red** — Off track (projected below 90 % of the target).
- **Grey** — Not applicable (no target or no target date).

Archived goals are collapsed under the **Archived (n)** toggle so the dashboard stays focused on what's still active.

## Creating a Goal

Click **+ New Goal**. Six templates are available:

| Template | Default target | Notes |
| --- | --- | --- |
| Retirement | — | Opens the [retirement planner](/docs/guide/retirement-planning). One per portfolio. |
| Education | 50,000 | Save-up goal. |
| Home Purchase | 100,000 | Save-up goal. |
| Car Purchase | 40,000 | Save-up goal. |
| Wedding | 30,000 | Save-up goal. |
| Savings Goal | 10,000 | Generic save-up goal. |

For non-retirement goals, the wizard asks for:

1. **Title** (required).
2. **Description** (optional).
3. **Target amount** in your base currency.
4. **Target date**.

Retirement goals have their own setup flow — see the [Retirement Planning](/docs/guide/retirement-planning) guide.

## Funding a Goal

Goals don't hold money themselves — they reference your real accounts.

In the goal's **Funding** section, allocate a percentage of each account to the goal:

- A single account can fund **multiple goals** as long as the combined share across all *active* goals stays at or under **100 %**.
- Eligible account types are **investment / securities**, **cash**, and **cryptocurrency** accounts.
- Accounts that already feed a Defined-Contribution income stream in a retirement plan cannot also be linked as a generic funding source for that goal — the income stream already accounts for them.

The current value of each goal is the share-weighted sum of the linked account balances, recomputed automatically when balances change.

## Goal Lifecycle

A goal can be in one of three states:

- **Active** — counts toward the dashboard totals and progress.
- **Completed** — keeps the goal in the dashboard but marks it done.
- **Archived** — hides the goal from the active list (still recoverable).

Use the **⋮** menu on the goal detail page to edit the title, description, or status, or to delete the goal entirely.

## The Save-Up Calculator

Every non-retirement goal opens into a Save-Up workspace with a hero card, a projection chart, and a milestones panel.

### Inputs

The sidebar lets you tune four levers:

| Lever | Unit | Default | Range |
| --- | --- | --- | --- |
| Target amount | base currency | template default | 0 – 1,000,000,000,000 |
| Target date | calendar date | — | within 100 years |
| Monthly contribution | base currency | 0 | 0 – 1,000,000,000 |
| Expected annual return | percent | 5 % | -20 % – 50 % |

The **current value** is read-only — it comes from the funding allocation.

### Outputs

The calculator returns:

- **Progress** — current value ÷ target, capped at 100 %.
- **Health status** — `on_track`, `at_risk`, or `off_track`.
- **Projected value at target date** — what you'll likely have on the target date if you keep contributing.
- **Required monthly contribution** — what you'd need to deposit each month to reach the target on time.
- **Projected completion date** — the first month your balance is expected to reach the target.
- **Trajectory** — month-by-month projection in three scenarios: *pessimistic* (return − 2 %), *nominal* (your input), and *optimistic* (return + 2 %), drawn against the target line.

Milestones (25 %, 50 %, 75 %, 100 %) show when each step is expected to be hit under the nominal scenario.

### How the projection works

The save-up engine runs a deterministic month-by-month simulation:

1. The current balance is grown daily at `annual_return ÷ 365`.
2. Your monthly contribution is added at the end of each calendar month.
3. The simulation runs forward to the target date (or up to 100 years for the completion-date search).
4. The required monthly contribution is solved by bisection (50 iterations, ±$0.01 accuracy) so it is always the *minimum* deposit that hits the target by the target date.

### Assumptions and limitations

The save-up calculator deliberately keeps the model simple. It does **not** account for:

- **Volatility** — returns are treated as a constant rate, not a distribution. The optimistic / pessimistic bands are a fixed ±2 % spread, not statistical confidence intervals.
- **Inflation** — every figure is nominal. If you want today's-money equivalence, lower your expected return by your assumed inflation rate.
- **Taxes and fees** — the model assumes a net-of-everything return. Use a return that already nets out fees and tax drag.
- **Irregular contributions** — only a single recurring monthly amount is supported.
- **Account-level returns** — the same expected return is applied to the whole goal balance regardless of how the underlying accounts are actually invested.

For more sophisticated retirement modelling — Monte Carlo runs, glide paths, tax buckets, multiple income streams — use the [retirement planner](/docs/guide/retirement-planning) instead.
