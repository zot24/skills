> Source: https://wealthfolio.app/docs/guide/retirement-planning



Docs


Retirement & FIRE Planning


# Retirement & FIRE Planning

Project your portfolio to retirement, find your FIRE number, and stress-test the plan.


Last updated November 12, 2026


The retirement planner is a first-class goal type that simulates your portfolio year by year, models the spending, income, taxes, and asset allocation that will apply in retirement, and tells you when (and whether) you can stop working. It powers both **traditional retirement planning** and **FIRE** (Financial Independence, Retire Early).

It is the most opinionated calculator in Wealthfolio – please read the <a href="#engine-assumptions" class="font-medium underline underline-offset-4">assumptions</a> and <a href="#limitations" class="font-medium underline underline-offset-4">limitations</a> sections below before acting on its output.

## Creating a Retirement Goal

On desktop, open **Goals** in the sidebar. On a phone, open **More → Goals**.

1.  Select **New Goal** and choose **Retirement**.
2.  Pick a **Planning Style**:
    - **Traditional** – you nominate a retirement age and the planner reports whether you’ll be funded by then.
    - **FIRE** – the planner finds when you become financially independent. Withdrawals start only at or after your desired retirement age, once you have the required capital.
3.  Enter your **birth month** and your **planned retirement age** (or **desired independence age**).
4.  Select **Create Goal**. Each profile can have one retirement goal that is not archived. Archive an existing retirement goal before creating another.

Retirement goals open into a two-tab workspace:

- **Overview** – the projection dashboard with the configurator sidebar.
- **What If** – Monte Carlo runs, stress tests, and sensitivity analysis.

To edit an existing plan, open **Goals → your retirement goal → Overview**, scroll to the relevant card, and select **Edit**. Select **Save** in that card to apply your changes, or **Cancel** to discard them. The help button beside the Overview and What If tabs opens the in-app **Retirement guide**.

**Contribution growth:** open **Projection Assumptions → Edit → Contribution growth per year**. Its default is 2%. Your starting **Monthly contribution** is configured separately under **Plan inputs → Edit**. Returns, fees, and inflation can be edited in either card; both edit the same assumptions.

## The Plan: What You Configure

The sections below explain the inputs and where to find them in Overview. Defaults are shown in the tables.

### Personal profile

Open **Plan inputs → Edit** to change your birth month, plan type, retirement age, planning horizon, and monthly contribution. Your current age is calculated from your birth month.


| Field | Unit | Default | Notes |
|----|----|----|----|
| Current age | years | from birth month |  |
| Retirement age / Desired retirement age | years | 65 (Traditional), 50 (FIRE) | Must be after your current age and before the planning horizon. Creation accepts up to 100; subsequent edits are bounded by the planning horizon. |
| Plan through age | years | 90 | The planning horizon; the sidebar control goes up to 110. |
| Monthly contribution | currency | 1,000 | The starting monthly amount you add to retirement; must be ≥ 0. |


### Investment assumptions

Open **Projection Assumptions → Edit** for the full set of assumptions, including volatility and contribution growth.


| Field                        | Unit | Default | Range   |
|------------------------------|------|---------|---------|
| Return before retirement     | %    | 5.77    | 0 – 50  |
| Return during retirement     | %    | 3.37    | 0 – 50  |
| Annual investment fee        | %    | 0.6     | 0 – 10  |
| Annual volatility            | %    | 12      | 0 – 100 |
| Inflation                    | %    | 2       | 0 – 20  |
| Contribution growth per year | %    | 2       | 0 – 25  |


The fee rate is subtracted from both pre-retirement and retirement returns to produce the **net** rate used in the projection.

Enter both returns as long-run **nominal compound annual rates (CAGR)**, before investment fees. These are the rates your money grows before adjusting for inflation, not the simple average of yearly returns. Inflation increases spending and inflation-linked income separately.

Contribution growth increases your monthly contribution each year. For example, a starting contribution of 1,000 per month and 2% growth becomes 1,020 per month in the second year. Set 0% to keep nominal contributions fixed. The control remains available in **Projection Assumptions → Edit** even when a 0% rate is hidden from the summary.

### Expenses

Open **Retirement Spending → Edit** to add or expand spending items, each with:

- A **monthly amount** in today’s money.
- Optional **From age** and **To age** bounds (e.g. mortgage paid off at 65, healthcare from 67). From age is included; To age is excluded.
- An optional **custom inflation rate** that overrides the general inflation rate (useful for healthcare).
- A **Spending type**: **Must-have** (essential) or **Flexible** (discretionary).

The required-capital calculation includes all planned spending. Market-path success checks use essential spending and also require money remaining at the planning horizon; marking spending Flexible does not remove it from the projection.

### Income streams

Open **Retirement Income → Edit**, then select **Add retirement income** or **Add pension fund**. Expand an item to edit it. Public pensions such as Social Security or CPP/OAS are not added automatically.


| Field | Notes |
|----|----|
| Income type | **Income** for monthly pension or other income; **Fund** for a balance that provides an estimated payout |
| Start age | When the payout begins |
| Monthly income after tax | Income entered in today’s money; portfolio withdrawal taxes are modeled separately |
| Income growth | **Indexed** follows plan inflation; **Fixed** keeps the nominal payout unchanged |
| Custom annual growth | Optional override of the inflation adjustment |
| Current fund balance | Fund only – current balance |
| Monthly fund contribution | Fund only – contributions stop at retirement or the fund’s start age, whichever comes first |
| Fund return before payout | Fund only – inherits the plan’s pre-retirement return after fees unless explicitly set |
| Payout rate | Fund only – editable annual rate, default 3.5% |
| Payout mode | Fund only – **Annuity** models payments through the horizon; **Drawdown** uses the fund balance and stops payments when it is depleted |
| Fund return during payout | Drawdown only – inherits the plan’s retirement return after fees unless explicitly set |
| Monthly payout after tax | Fund only, when payments have already started – an entered payout takes precedence over the balance-derived estimate |


For a fund whose payments start in the future, the planner projects its balance to the start age and estimates the base monthly payout as `projected_balance × payout_rate ÷ 12`. The 3.5% default payout rate is configurable. For a fund already paying, an entered monthly payout takes precedence; otherwise the estimate uses its current balance.

With the default plan assumptions, an unset fund return before payout inherits 5.17% (5.77% minus the 0.6% fee). Explicit fund returns should be entered after the fund’s own fees; the plan’s investment fee is not deducted from them again.

An annuity removes the fund balance from pension assets when payments begin. A drawdown fund remains an asset while its balance lasts, and payments follow the income-growth setting until depletion. Its payout rate sets the initial payment; it is not recalculated as a percentage of the remaining balance each year.

### Tax profile *(optional)*

Open **Withdrawal Taxes → Edit** to set the effective withdrawal tax rates and any early-withdrawal penalty.


| Field | Unit | Notes |
|----|----|----|
| Taxable account rate | % | Effective rate on regular brokerage withdrawals |
| Tax-deferred account rate | % | Effective rate on 401(k) / Traditional IRA / RRSP withdrawals |
| Tax-free account rate | % | Usually 0 % (Roth IRA, TFSA, ISA) |
| Early withdrawal penalty | % | Extra penalty on tax-deferred withdrawals before the cutoff age |
| Penalty cutoff age | years | The age the extra penalty stops; ordinary withdrawal tax still applies |
| Account buckets | currency | Read-only balances derived from the funding accounts and tax-bucket classifications in **Account Shares** |


To change the bucket mix, edit the funding accounts and their classifications in **Account Shares**. The bucket balances drive the **withdrawal ordering**: taxable accounts are drawn down first, then tax-deferred, then tax-free.

### Funding

Like other goals, retirement is funded by allocating percentages of your existing accounts in **Account Shares**. A new retirement goal starts with every eligible account at 100 %, and an account you add to it also starts at 100 %. Accounts already linked to a DC income stream cannot also be added as plain funding sources for the same goal – they’re already part of the projection.

Retirement can share accounts with <a href="/docs/guide/goals/#funding-a-goal" class="font-medium underline underline-offset-4">savings goals</a>. An active savings goal sets its share of an account aside, and Retirement counts what’s left, up to its own share. With a savings goal holding 30 % of an account, a retirement share of 100 % counts 70 %, and the account shows **Counting 70%**. Savings goals together still can’t pass 100 % of an account; Retirement’s share never limits them. Each account share shows its amount beside the percentage.

Savings goals keep their own money, so the retirement projection leaves it out. **Plan inputs** shows what active savings goals plan to add each month beside your monthly contribution (**Savings goals also plan …/mo**), so you enter only what goes to retirement and the same money isn’t entered twice. Goals past their target date aren’t included.

> **Upgrading from 3.11.** Existing goals count the same money after the update. If you sync devices, update all of them before a savings goal shares an account with Retirement. Until it updates, a device on 3.11 counts that money in Retirement too, sees more than 100 % of the account in use, and refuses to save funding on that account or reactivate a goal that uses it.

## What the Dashboard Shows

The Overview tab renders three primary visualisations:

**Portfolio trajectory chart** – your projected balance year by year (**Projected**), coloured by whether the plan is on track, and a dashed **Required** line. Before the goal age, Required is the balance needed to reach the goal after crediting remaining planned contributions and investment growth. After the goal age, it shows the capital needed to fund the remaining retirement schedule. Crossing the pre-goal line does not by itself mean you could retire immediately. A vertical line marks your chosen retirement age; in FIRE mode, a second line marks the projected FI age when it differs.

Each active savings goal with a target date inside the chart’s age range appears as a marker at its target date, coloured by its status. Savings goals keep their own money, so the projection leaves it out. Select **Savings goals** in the legend to show or hide the markers, or select a marker to open that goal.

**Retirement spending coverage** – opens in **At retirement**, showing spending and funding at the projected retirement start age, or your chosen age if no start is projected. Choose **Over time** for a chart that stacks retirement income, portfolio withdrawals, and unfunded spending against a planned-spending line. Taxes are shown separately in the chart tooltip.

**Year-by-Year Snapshot** – age, year, phase, ending portfolio value, annual contributions, retirement income, planned spending, and portfolio withdrawals. A pension-fund balance is shown when applicable. Taxes, required capital, and surplus/shortfall are not separate table columns.

The dashboard opens in **Today’s value**. Use the value-mode toggle to switch projected amounts between today’s purchasing power and **Nominal** (future-dollar) values. Plan inputs remain the assumptions you entered. Hiding balances hides the planner’s amounts too.

To save the year-by-year projection, choose **Export projection** in the goal’s **⋮** menu. The CSV file has one row per year, with amounts in each year’s currency, not adjusted for inflation. It leaves out Monte Carlo runs, stress tests, and sensitivity maps. <a href="/docs/guide/data-export/" class="font-medium underline underline-offset-4">Data export</a> doesn’t include projections, so this is the only way to save one.

### KPIs

- **FI age** – first age your portfolio reaches the required capital.
- **Retirement start age** – when withdrawals actually begin under your selected mode.
- **Funded at retirement** – whether your portfolio meets or exceeds the required capital at the retirement start.
- **Portfolio at goal age** – projected balance in the selected value mode.
- **Shortfall / surplus** – gap between projected portfolio and required capital.
- **Coast FIRE amount** – minimum *today’s* balance needed to reach the goal with **zero further contributions**.
- **Coast reached** – whether your current portfolio meets the coast amount.
- **Funded through age** – the age before the first portfolio depletion or material shortfall in planned spending; the horizon age if neither occurs.
- **Failure age** / **spending shortfall age** – first age the portfolio is depleted, or the first age total planned spending is materially under-funded.
- **Required additional monthly contribution** – extra savings needed to close the gap.
- **Suggested goal age** – if your target age isn’t reachable, the earliest age that is.

## What If

The What If tab runs the same plan through stochastic and stress scenarios:

- **Market paths (Monte Carlo)** – randomised return and inflation paths based on your assumptions. The default is 5,000 paths; you can run 10,000 or 100,000. Reports the share of paths where money lasts, plus a median line and 10th–90th percentile bands.
- **What moves the plan?** – two sensitivity maps compare **Contribution × Return** and **Retirement age × Spending** (**Desired age × Spending** in FIRE mode). Each cell changes a pair of assumptions and shows the resulting outcome.
- **Stress tests** – six preset checks: lower returns, higher inflation, higher spending, earlier retirement, lower savings, and a market crash near retirement.
- **Early market crash paths** – compares sequence-of-returns scenarios around retirement, showing how crash timing affects the money left and whether the plan survives.

A Monte Carlo path counts as successful when essential spending is funded throughout retirement, within the engine’s small funding tolerance, and the portfolio finishes above zero at the planning horizon. FIRE paths must also reach FI. This success measure differs from the deterministic required-capital target, which includes all planned spending.

## How the Engine Works

The retirement engine is a **deterministic year-by-year simulation** with an optional **Monte Carlo overlay**. There is no separate “4 % rule” calculator – the FIRE number falls out of the simulation.

### The deterministic projection

Year by year, from current age to the horizon age:

1.  **Accumulation phase** – the portfolio grows at the **net pre-retirement return** (gross minus fees). Monthly contributions are added during the year and grow with the contribution-growth rate annually. Contributions stop at the retirement start age.
2.  **Retirement transition** – Traditional mode starts retirement at the chosen retirement age, even if underfunded. FIRE mode waits until both the desired retirement age has been reached and the portfolio can fund retirement from that age. Reaching FI earlier does not start withdrawals early.
3.  **Retirement phase** – the portfolio grows at the **net retirement return**. Each year, expenses (less income streams) are withdrawn following the bucket order: taxable → tax-deferred → tax-free. Withdrawals are grossed up to cover the relevant tax rate; tax-deferred withdrawals before the cutoff age also pay the early-withdrawal penalty.
4.  **Readiness checks** – the dashboard reports portfolio depletion and material gaps in total planned spending. A spending shortfall is material when it exceeds the greater of \$1 or 0.1% of that year’s spending gap after retirement income.

Enter retirement spending and ordinary monthly income in **today’s money**. Investment returns grow the nominal portfolio after fees; inflation increases spending and indexed income separately. Contributions grow at the contribution-growth rate, rather than automatically following inflation. The engine calculates nominal amounts internally, and the dashboard initially converts them to **Today’s value**.

### How “required capital” is found

The engine binary-searches for the smallest starting balance at a retirement age that funds all planned spending through the horizon, within a small funding tolerance, and leaves a positive ending balance. This includes flexible spending as well as essential spending. The result at your chosen age is the **FIRE number** for your plan; before that age, the dashed Required line also credits future contributions.

### How Monte Carlo works

Returns each year are drawn from a lognormal distribution calibrated to your mean return and volatility (the median of the lognormal is anchored to the deterministic return so the median MC path matches the deterministic line). Inflation is drawn each year with a -0.25 correlation to returns. Paths are evaluated in parallel (default 5,000); success is the share of paths that meet the success criteria above.

## Engine Assumptions

These are baked into the model and worth knowing before you trust the output:

- **Input units** – spending and ordinary monthly income are entered in today’s money. Portfolio returns and contribution growth are nominal annual rates; inflation is applied separately to spending and indexed income.
- **Deterministic return path** – the central projection uses constant returns. Volatility only feeds the Monte Carlo / What If tab.
- **Annual ledger** – withdrawals, contributions, and growth are settled once per year. The model isn’t designed for sub-annual planning.
- **Withdrawal ordering** – strictly taxable → tax-deferred → tax-free. There is no smart Roth-conversion or tax-bracket-aware optimisation.
- **Fund payouts** – 3.5% per year is the editable default payout rate. Annuity payments continue through the horizon; drawdown payments stop if the fund is depleted.
- **Return / inflation correlation** – -0.25, hard-coded.
- **Contribution routing** – future contributions are added to the existing tax buckets in the same proportion as the current bucket balances. Per-account contribution routing isn’t modelled.
- **No rebalancing modelling** – buckets aren’t rebalanced; their proportions drift only as withdrawals deplete them.
- **Required-capital search** – the engine expands the search range as needed. If it cannot find feasible capital, the target is reported as unavailable.

## Limitations

The planner is a strong directional tool, not a financial advisor. Specifically, it does not model:

- **Tax brackets, marginal rates, or capital gains** – only flat effective rates per bucket.
- **Roth conversions, RMDs, or IRMAA** – withdrawal ordering is fixed.
- **Healthcare-specific accounts** (HSA, FSA) other than as a generic tax-free bucket.
- **Social Security claiming strategy** – only a fixed start age and amount.
- **Variable spending strategies** (guardrails, CAPE-based, Guyton-Klinger) – every year withdraws the planned schedule, no more, no less.
- **Survivor / spousal planning** – single-life model.
- **Currency mix during retirement** – the whole plan runs in your base currency.
- **Rebalancing trades or transaction costs** – only aggregate fees via the fee rate.
- **Estate planning** – what’s left at the horizon age is just reported, not modelled forward.

If your situation needs any of the above with precision, treat the planner’s output as a sanity check rather than a final answer.

## FIRE Mode in Detail

FIRE in Wealthfolio is not a separate calculator – it’s a mode of the retirement planner. Under FIRE mode:

- **The FIRE number** is the required capital the engine solves for at your target age.
- **FI age** is the first modeled age at which the accumulating portfolio reaches the capital needed to retire at that age. It can be earlier than your desired retirement age, and is distinct from crossing the pre-goal Required line that credits future contributions.
- **Coast FIRE** is the minimum balance you’d need *today* to ride to the goal with zero further contributions: `required_capital ÷ (1 + accumulation_return)^years_to_goal`.
- **Lean FIRE / Fat FIRE** aren’t separate switches – model them by adjusting your expense buckets (lower = lean, higher = fat) and re-running.

Even in FIRE mode the planner won’t start drawing down before your target retirement age; reaching FI early just unlocks the *option* to retire, it doesn’t force the simulation to do so.

## Related

- <a href="/docs/guide/goals/" class="font-medium underline underline-offset-4">Goals &amp; Save-Up Planner</a> – for non-retirement goals.
- <a href="/docs/guide/contribution-limits/" class="font-medium underline underline-offset-4">Contribution Limits</a> – track yearly room on retirement accounts.
- <a href="/docs/concepts/performance-metrics/" class="font-medium underline underline-offset-4">Performance Metrics</a> – how returns are computed from your real history.


<a href="/docs/guide/goals/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Goals &amp; Save-Up Planner</a> <a href="/docs/guide/contribution-limits/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Contribution Limits</a>


On this page

- <a href="#creating-a-retirement-goal" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Creating a Retirement Goal</a>
- <a href="#the-plan-what-you-configure" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">The Plan: What You Configure</a>
  - <a href="#personal-profile" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Personal profile</a>
  - <a href="#investment-assumptions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Investment assumptions</a>
  - <a href="#expenses" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Expenses</a>
  - <a href="#income-streams" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Income streams</a>
  - <a href="#tax-profile-optional" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Tax profile (optional)</a>
  - <a href="#funding" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Funding</a>
- <a href="#what-the-dashboard-shows" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">What the Dashboard Shows</a>
  - <a href="#kpis" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">KPIs</a>
- <a href="#what-if" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">What If</a>
- <a href="#how-the-engine-works" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">How the Engine Works</a>
  - <a href="#the-deterministic-projection" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">The deterministic projection</a>
  - <a href="#how-required-capital-is-found" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">How "required capital" is found</a>
  - <a href="#how-monte-carlo-works" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">How Monte Carlo works</a>
- <a href="#engine-assumptions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Engine Assumptions</a>
- <a href="#limitations" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Limitations</a>
- <a href="#fire-mode-in-detail" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">FIRE Mode in Detail</a>
- <a href="#related" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Related</a>


