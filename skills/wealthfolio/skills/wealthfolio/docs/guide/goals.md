> Source: https://wealthfolio.app/docs/guide/goals



Docs


Goals & Save-Up Planner


# Goals & Save-Up Planner

Set savings targets, fund them from your accounts, and project when you'll get there.


Last updated November 12, 2026


The Goals feature turns Wealthfolio into a planning tool: pick a goal, link the accounts that fund it, and the app projects your progress and tells you whether you’re on track.

> Looking for the retirement planner or FIRE calculator? See <a href="/docs/guide/retirement-planning/" class="font-medium underline underline-offset-4">Retirement Planning</a>. For tax-advantaged contribution caps (RRSP, TFSA, IRA, 401(k)…), see <a href="/docs/guide/contribution-limits/" class="font-medium underline underline-offset-4">Contribution Limits</a>.

## The Goals Dashboard

Open `Goals` from the sidebar to see every goal at a glance.

The dashboard summarises:

- **Saved** – total current value across all active goals.
- **Target** – sum of every goal’s target amount.
- **Overall** – combined progress percentage.
- **On track** – number of goals projected to hit their target.

Each goal is shown as a card with a cover image, a title, the target date and time remaining, the current saved amount, the remaining amount, and a colour-coded progress bar:

- **Green** – On track (projected to reach the target).
- **Amber** – At risk (projected between 90 % and 100 % of the target).
- **Red** – Off track (projected below 90 % of the target).
- **Grey** – Not applicable (no target or no target date).

A goal shows the same status on its card, on the **Goals** card of the main Dashboard, and on its own page.

Archived goals are collapsed under the **Archived (n)** toggle so the dashboard stays focused on what’s still active.

## Creating a Goal

Click **+ New Goal**. Six templates are available:


| Template | Default target | Notes |
|----|----|----|
| Retirement | – | Opens the <a href="/docs/guide/retirement-planning/" class="font-medium underline underline-offset-4">retirement planner</a>. One non-archived retirement goal per profile. |
| Education | 50,000 | Save-up goal. |
| Home Purchase | 100,000 | Save-up goal. |
| Car Purchase | 40,000 | Save-up goal. |
| Wedding | 30,000 | Save-up goal. |
| Savings Goal | 10,000 | Generic save-up goal. |


For non-retirement goals, the wizard asks for:

1.  **Title** (required).
2.  **Description** (optional).
3.  **Target amount** in your base currency.
4.  **Target date**.

Retirement goals have their own setup flow – see the <a href="/docs/guide/retirement-planning/" class="font-medium underline underline-offset-4">Retirement Planning</a> guide.

## Funding a Goal

Goals don’t hold money themselves – they reference your real accounts.

In the goal’s **Account Shares** section, allocate a percentage of each account to the goal:

- An *active* savings goal sets its share of an account aside. A single account can fund **multiple savings goals**, but their combined share can’t pass **100 %**. A goal’s share is released when it’s completed or archived.
- **Retirement** can share an account with savings goals. Its share is an upper limit: it counts what active savings goals leave free, up to that share. With a savings goal holding 30 % of an account, a retirement share of 100 % counts 70 %. See <a href="/docs/guide/retirement-planning/#funding" class="font-medium underline underline-offset-4">Retirement Planning → Funding</a>.
- Each account share shows its amount beside the percentage.
- Eligible account types are **investment / securities**, **cash**, and **cryptocurrency** accounts.
- Accounts that already feed a Defined-Contribution income stream in a retirement plan cannot also be linked as a generic funding source for that goal – the income stream already accounts for them.

The current value of each goal is the share-weighted sum of the linked account balances, recomputed automatically when balances change.

## Goal Lifecycle

A goal can be in one of three states:

- **Active** – counts toward the dashboard totals and progress.
- **Completed** – keeps the goal in the dashboard but marks it done.
- **Archived** – hides the goal from the active list (still recoverable).

Use the **⋮** menu on the goal detail page to edit the title, description, or status, or to delete the goal entirely.

## The Save-Up Calculator

Every non-retirement goal opens into a Save-Up workspace with a hero card, a projection chart, and a milestones panel.

### Inputs

The **Savings Inputs** card in the sidebar lets you tune four levers:


| Lever                  | Unit          | Default          | Range                 |
|------------------------|---------------|------------------|-----------------------|
| Target amount          | base currency | template default | 0 – 1,000,000,000,000 |
| Target date            | calendar date | –                | within 100 years      |
| Monthly contribution   | base currency | 0                | 0 – 1,000,000,000     |
| Expected annual return | percent       | 5 %              | 0 % – 50 %            |


An expected return above 12 % shows a high-return warning. Until you save these inputs, the goal is projected with no monthly contribution and a 5 % expected return.

The **current value** is read-only – it comes from the funding allocation.

### Outputs

The calculator returns:

- **Progress** – current value ÷ target, capped at 100 %.
- **Health status** – **On track** when the projected value at the target date reaches the target, **At risk** when it reaches at least 90 % of it, **Off track** below that. The page shows **Reached** once the saved amount meets the target, and **Setup needed** until the goal has a target amount and a target date.
- **Projected value at target date** – the balance the projection reaches on the target date with your monthly contribution and expected return.
- **Required monthly contribution** – the smallest whole monthly amount that reaches the target by the target date (**Needed** in the **Monthly plan** card).
- **Projected completion date** – the first month-end at which the projected balance reaches the target (**Finish** in the **Monthly plan** card), or today if you’ve already reached it.
- **Trajectory** – the projected balance from today to the target date in three scenarios: *pessimistic* (return − 2 %, not below 0 %), *nominal* (your input), and *optimistic* (return + 2 %). A dashed line (**Needed to stay on track** in the legend) shows the balance needed at each point to still reach the target by the target date with your planned contribution. The nominal line sits on or above it when the goal is on track.

Milestones (25 %, 50 %, 75 %, 100 %) show the month the nominal projection first reaches each step. A step you’ve already saved shows **Reached**; one the projection doesn’t reach by the target date shows **Not reached**.

The status, projected value, required contribution, completion date, chart, and milestones all come from one projection, so they always agree.

To save the projection, choose **Export projection** in the goal’s **⋮** menu. You get a CSV file with the projected, optimistic, and pessimistic balances, the target amount, and the **Needed to stay on track** balance for each date. <a href="/docs/guide/data-export/" class="font-medium underline underline-offset-4">Data export</a> doesn’t include projections, so this is the only way to save one.

### How the projection works

The save-up engine runs one deterministic simulation from today, recording the balance at each month-end and on the target date:

1.  The expected return is a yearly rate, as in the retirement planner. Over `d` days the balance grows by `(1 + annual_return)^(d ÷ 365)`, so a 5 % return grows the balance 5 % a year.
2.  Your monthly contribution lands at each calendar month-end after today, up to and including the target date. A target date that isn’t a month-end gets no contribution for its month: a goal due on the 30th doesn’t count that month’s contribution. Money you’ve already saved is in the current value.
3.  The projected value at the target date is the simulated balance on that date. The health status compares it with the target.
4.  The required monthly contribution is solved directly, because the final balance grows in a straight line with the contribution: the shortfall without contributions is divided by what one unit a month grows to by the target date, rounded up to a whole unit, and checked against the simulation. It is 0 when the current balance already grows to the target, and the whole shortfall when no month-end falls before the target date.
5.  The completion-date search runs past the target date: three times the time to the target date (at least 10 years, at most 100), or 50 years for a goal with no target date. If the projection misses the target date, the completion date is the first month-end after it at which the balance reaches the target.
6.  The optimistic and pessimistic scenarios repeat the simulation at your return + 2 % and − 2 % (not below 0 %).
7.  The dashed line works backwards from the target on the target date: each step removes the planned contribution and discounts the balance at the expected return.

> **Upgrading from 3.11.** A savings goal can show a different status, projected value, or monthly amount after the update. A 5 % return used to grow the balance about 5.13 % a year and now grows it 5 %, contributions follow the month-end rule above, and a goal with no saved plan assumes 5 % instead of 7 %.

### Assumptions and limitations

The save-up calculator deliberately keeps the model simple. It does **not** account for:

- **Volatility** – returns are treated as a constant rate, not a distribution. The optimistic / pessimistic bands are a fixed ±2 % spread, not statistical confidence intervals.
- **Inflation** – every figure is nominal. If you want today’s-money equivalence, lower your expected return by your assumed inflation rate.
- **Taxes and fees** – the model assumes a net-of-everything return. Use a return that already nets out fees and tax drag.
- **Irregular contributions** – only a single recurring monthly amount is supported.
- **Account-level returns** – the same expected return is applied to the whole goal balance regardless of how the underlying accounts are actually invested.

For more sophisticated retirement modelling – Monte Carlo runs, glide paths, tax buckets, multiple income streams – use the <a href="/docs/guide/retirement-planning/" class="font-medium underline underline-offset-4">retirement planner</a> instead.


<a href="/docs/guide/allocation-targets/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Allocation Targets &amp; Rebalancing</a> <a href="/docs/guide/retirement-planning/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Retirement &amp; FIRE Planning</a>


On this page

- <a href="#the-goals-dashboard" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">The Goals Dashboard</a>
- <a href="#creating-a-goal" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Creating a Goal</a>
- <a href="#funding-a-goal" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Funding a Goal</a>
- <a href="#goal-lifecycle" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Goal Lifecycle</a>
- <a href="#the-save-up-calculator" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">The Save-Up Calculator</a>
  - <a href="#inputs" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Inputs</a>
  - <a href="#outputs" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Outputs</a>
  - <a href="#how-the-projection-works" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">How the projection works</a>
  - <a href="#assumptions-and-limitations" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Assumptions and limitations</a>


