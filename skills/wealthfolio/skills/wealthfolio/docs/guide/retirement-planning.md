> Source: https://wealthfolio.app/docs/guide/retirement-planning

The retirement planner is a first-class goal type that simulates your portfolio year by year, models the spending, income, taxes, and asset allocation that will apply in retirement, and tells you when (and whether) you can stop working. It powers both **traditional retirement planning** and **FIRE** (Financial Independence, Retire Early).

It is the most opinionated calculator in Wealthfolio — please read the [assumptions](#engine-assumptions) and [limitations](#limitations) sections below before acting on its output.

## Creating a Retirement Goal

1. Open `Goals → + New Goal` and choose **Retirement**.
2. Pick a **Planning Style**:
   - **Traditional** — you nominate a retirement age and the planner reports whether you'll be funded by then.
   - **FIRE** — the planner finds the earliest age at which you become financially independent, and only "starts withdrawals" once you actually have the required capital.
3. Enter your **birth month** and your **planned retirement age** (or **desired independence age**).
4. Save. Only one retirement goal is allowed per portfolio.

Retirement goals open into a two-tab workspace:

- **Overview** — the projection dashboard with the configurator sidebar.
- **What If** — Monte Carlo runs, stress tests, and sensitivity analysis.

## The Plan: What You Configure

The configurator sidebar groups inputs into the sections below. Defaults are shown in parentheses.

### Personal profile

| Field | Unit | Default | Notes |
| --- | --- | --- | --- |
| Current age | years | from birth month | |
| Target retirement age | years | — | Must be > current age, ≤ 120. |
| Planning horizon age | years | 90 | The age the plan must still be funded through. |

### Investment assumptions

| Field | Unit | Default | Range |
| --- | --- | --- | --- |
| Pre-retirement annual return | % | 5.77 | -99 – 99 |
| Retirement annual return | % | 3.37 | -99 – 99 |
| Annual investment fee rate | % | 0.6 | 0 – 5 |
| Annual volatility | % | 12 | 0 – 100 |
| Inflation rate | % | 2 | -20 – 50 |
| Monthly contribution | currency | — | 0 – 1,000,000,000 |
| Contribution growth rate | % | 0 | -20 – 20 |

The fee rate is subtracted from both pre-retirement and retirement returns to produce the **net** rate used in the projection.

### Expenses

You add **expense buckets**, each with:

- A **monthly amount** in today's money.
- An optional **start age** and **end age** (e.g. mortgage paid off at 65, healthcare from 67).
- An optional **custom inflation rate** that overrides the general inflation rate (useful for healthcare).
- An **essential** flag — essential expenses must be funded for the plan to count as successful; discretionary expenses are nice-to-have.

### Income streams

Add Social Security, pensions, annuities, or any DC fund that pays out in retirement.

| Field | Notes |
| --- | --- |
| Stream type | **DB** (defined benefit, fixed payout) or **DC** (defined contribution, accumulating fund) |
| Start age | When the payout begins |
| Monthly amount | Payout in today's money (DB), or override for DC payouts |
| Adjust for inflation | If on, the stream tracks general inflation; otherwise nominal |
| Annual growth rate | Optional override of the inflation adjustment |
| Current value | DC only — current fund balance |
| Monthly contribution | DC only — ongoing contributions during accumulation |
| Accumulation return | DC only — return while the fund is accumulating (default 4 %) |

For DC funds without an explicit monthly amount, the planner estimates the payout as `accumulated_balance × 3.5 % ÷ 12`. This 3.5 % rate is **baked in** and not configurable.

### Tax profile *(optional)*

| Field | Unit | Notes |
| --- | --- | --- |
| Taxable withdrawal rate | % | Effective rate on regular brokerage withdrawals |
| Tax-deferred withdrawal rate | % | Effective rate on 401(k) / Traditional IRA / RRSP withdrawals |
| Tax-free withdrawal rate | % | Usually 0 % (Roth IRA, TFSA, ISA) |
| Early withdrawal penalty rate | % | Extra penalty on tax-deferred withdrawals before `penalty_age` |
| Early withdrawal penalty age | years | The age the penalty stops (e.g. 59 for IRAs) |
| Withdrawal bucket balances | currency | Initial split of your portfolio across taxable / tax-deferred / tax-free |

The bucket balances drive the **withdrawal ordering**: taxable accounts are drawn down first, then tax-deferred, then tax-free.

### Funding

Like other goals, retirement is funded by allocating percentages of your existing accounts. Accounts already linked to a DC income stream cannot also be added as plain funding sources for the same goal — they're already part of the projection.

## What the Dashboard Shows

The Overview tab renders three primary visualisations:

**Portfolio trajectory chart** — your projected balance year by year, split into the accumulation phase (blue) and the retirement phase (orange). Behind it, faded bands show the 10th / 25th / 50th / 75th / 90th percentiles from the Monte Carlo run, and a dashed line shows the **required capital glide path** — the minimum balance you need to be at each age to fund the rest of the plan. A marker shows the **FIRE milestone** (the earliest age you cross the required capital) and the **retirement start** (when withdrawals actually begin).

**Coverage chart** — a stacked area showing where each year's spending comes from: essential expenses on the bottom, discretionary above, then income streams stacked on top, with portfolio withdrawals filling whatever is left.

**Snapshot table** — a year-by-year breakdown: portfolio value, contributions, withdrawals, taxes paid, required capital, surplus or shortfall.

A **value mode toggle** switches every figure between **nominal** (future-dollar) and **today's money** display.

### KPIs

- **Progress to FIRE target** — % of required capital you have at the goal age.
- **FI age** — first age your portfolio reaches the required capital.
- **Retirement start age** — when withdrawals actually begin under your selected mode.
- **Funded at retirement** — whether your portfolio meets or exceeds the required capital at the retirement start.
- **Portfolio at goal age** — projected nominal balance.
- **Shortfall / surplus** — gap between projected portfolio and required capital.
- **Coast FIRE amount** — minimum *today's* balance needed to reach the goal with **zero further contributions**.
- **Coast reached** — whether your current portfolio meets the coast amount.
- **Funded through age** — the latest age the plan still covers essential spending.
- **Failure age** / **spending shortfall age** — first age the portfolio depletes, or the first age essential spending is materially under-funded.
- **Required additional monthly contribution** — extra savings needed to close the gap.
- **Suggested goal age** — if your target age isn't reachable, the earliest age that is.

## What If

The What If tab runs the same plan through stochastic and stress scenarios:

- **Monte Carlo** — randomised paths (return draws from a lognormal distribution calibrated to your input return and volatility, inflation correlated -0.25 to returns). Default is 5,000 paths and you can dial it up to 500,000. Reports a **success rate** plus the percentile bands shown on the trajectory chart.
- **Sensitivity** — sweeps a single parameter (return, contribution, retirement age…) and shows how the outcome moves.
- **Sequence-of-returns risk (SORR)** — stress-tests the early retirement years where a market drop hurts the most.

A Monte Carlo run is considered successful when, in every year: essential spending was fully funded, and the portfolio remained above zero at the planning horizon. (FIRE plans additionally require that FI was reached.)

## How the Engine Works

The retirement engine is a **deterministic year-by-year simulation** with an optional **Monte Carlo overlay**. There is no separate "4 % rule" calculator — the FIRE number falls out of the simulation.

### The deterministic projection

Year by year, from current age to the horizon age:

1. **Accumulation phase** — the portfolio grows at the **net pre-retirement return** (gross minus fees). Monthly contributions are added during the year and grow with the contribution-growth rate annually. Contributions stop at the retirement start age.
2. **FIRE transition** — the simulation switches to the retirement phase the first time *either* of these is true: the portfolio reaches the required capital glide-path target (FIRE mode), or you hit your target retirement age (Traditional mode forces it).
3. **Retirement phase** — the portfolio grows at the **net retirement return**. Each year, expenses (less income streams) are withdrawn following the bucket order: taxable → tax-deferred → tax-free. Withdrawals are grossed up to cover the relevant tax rate; tax-deferred withdrawals before `penalty_age` also pay the early-withdrawal penalty.
4. The plan **succeeds** as long as no year shows a material shortfall (gap larger than the greater of $1 or 0.1 % of the year's spending).

All inputs are interpreted in **today's money (real terms)** — inflation is then applied annually to expenses and income streams, and outputs are reported in nominal dollars by default. Use the value-mode toggle to flip back to today's money.

### How "required capital" is found

The engine binary-searches for the smallest starting balance at the retirement age that lets the year-by-year ledger run from there to the horizon without a material shortfall. This is the **FIRE number** for your plan and the basis of the dashed glide-path line.

### How Monte Carlo works

Returns each year are drawn from a lognormal distribution calibrated to your mean return and volatility (the median of the lognormal is anchored to the deterministic return so the median MC path matches the deterministic line). Inflation is drawn each year with a -0.25 correlation to returns. Paths are evaluated in parallel (default 5,000); success is the share of paths that meet the success criteria above.

## Engine Assumptions

These are baked into the model and worth knowing before you trust the output:

- **Real terms inputs** — every rate and amount you enter is treated as today's money. Inflation is then applied internally.
- **Deterministic return path** — the central projection uses constant returns. Volatility only feeds the Monte Carlo / What If tab.
- **Annual ledger** — withdrawals, contributions, and growth are settled once per year. The model isn't designed for sub-annual planning.
- **Withdrawal ordering** — strictly taxable → tax-deferred → tax-free. There is no smart Roth-conversion or tax-bracket-aware optimisation.
- **DC pension default draw rate** — 3.5 % per year, hard-coded.
- **Return / inflation correlation** — -0.25, hard-coded.
- **Contribution routing** — future contributions are added to the existing tax buckets in the same proportion as the current bucket balances. Per-account contribution routing isn't modelled.
- **No rebalancing modelling** — buckets aren't rebalanced; their proportions drift only as withdrawals deplete them.
- **Inflation guardrail** — the cumulative inflation factor is clamped to a minimum of 0.01 to prevent divide-by-zero blow-ups in extreme deflation scenarios.
- **Search ceiling** — the required-capital binary search is capped at $1 trillion. Any plan that needs more than that is reported as unreachable.

## Limitations

The planner is a strong directional tool, not a financial advisor. Specifically, it does not model:

- **Tax brackets, marginal rates, or capital gains** — only flat effective rates per bucket.
- **Roth conversions, RMDs, or IRMAA** — withdrawal ordering is fixed.
- **Healthcare-specific accounts** (HSA, FSA) other than as a generic tax-free bucket.
- **Social Security claiming strategy** — only a fixed start age and amount.
- **Variable spending strategies** (guardrails, CAPE-based, Guyton-Klinger) — every year withdraws the planned schedule, no more, no less.
- **Survivor / spousal planning** — single-life model.
- **Currency mix during retirement** — the whole plan runs in your base currency.
- **Rebalancing trades or transaction costs** — only aggregate fees via the fee rate.
- **Estate planning** — what's left at the horizon age is just reported, not modelled forward.

If your situation needs any of the above with precision, treat the planner's output as a sanity check rather than a final answer.

## FIRE Mode in Detail

FIRE in Wealthfolio is not a separate calculator — it's a mode of the retirement planner. Under FIRE mode:

- **The FIRE number** is the required capital the engine solves for at your target age.
- **FI age** is the first year the projected portfolio crosses the required capital glide path.
- **Coast FIRE** is the minimum balance you'd need *today* to ride to the goal with zero further contributions: `required_capital ÷ (1 + accumulation_return)^years_to_goal`.
- **Lean FIRE / Fat FIRE** aren't separate switches — model them by adjusting your expense buckets (lower = lean, higher = fat) and re-running.

Even in FIRE mode the planner won't start drawing down before your target retirement age; reaching FI early just unlocks the *option* to retire, it doesn't force the simulation to do so.

## Related

- [Goals & Save-Up Planner](/docs/guide/goals) — for non-retirement goals.
- [Contribution Limits](/docs/guide/contribution-limits) — track yearly room on retirement accounts.
- [Performance Metrics](/docs/concepts/performance-metrics) — how returns are computed from your real history.
