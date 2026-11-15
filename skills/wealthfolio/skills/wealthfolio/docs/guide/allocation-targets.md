> Source: https://wealthfolio.app/docs/guide/allocation-targets



Docs


Allocation Targets & Rebalancing


# Allocation Targets & Rebalancing

Define a target portfolio, see how far each holding has drifted, and work out adjustments in the rebalancing worksheet.


Last updated November 12, 2026


Allocation Targets, introduced in **3.5**, lets you define the portfolio you *want*, see how far your actual holdings have **drifted** from it, and work out the **adjustments** that would bring it back to target in the **rebalancing worksheet**.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/allocation/overview.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Allocation targets overview: current vs. target with drift" /> <img src="https://assets.wealthfolio.app/images/screenshots/allocation/overview-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Allocation targets overview: current vs. target with drift" />
<figcaption>Allocation targets overview: current vs. target with drift</figcaption>
</figure>

The feature has three parts: an **Overview** of your current versus target allocation, a **Targets** editor, and the **rebalancing worksheet**.

## Setting targets

In the **Targets** editor, create a target by choosing an allocation type, a starting point, and the weights you want.

### Allocation type

Target by any of these taxonomies:

- **Asset Classes** (e.g. stocks / bonds / commodities)
- **Industries** (GICS sectors)
- **Risk Category** (Low / Medium / High)
- **Regions** (continents / geographies)
- **Custom Groups**

### Starting point

Begin from **example weights** or **Build from scratch**. Example weights are named by their weights alone, such as **60% Equity / 40% Fixed Income**. They aren’t recommendations, and Wealthfolio hasn’t assessed whether they fit you. The built-in examples are:


| Taxonomy | Example weights |
|----|----|
| Asset Classes | Equity / Fixed Income at 90/10, 80/20, 60/40, 40/60 or 20/80; 30 % Equity, 55 % Fixed Income, 15 % Commodities; 25 % each in Equity, Fixed Income, Cash and Commodities |
| Industries | 40 % Health Care, 35 % Consumer Staples, 25 % Utilities; about 9 % in each of the 11 sectors; a mix led by 39 % Information Technology |
| Risk Category | Low / Medium / High at 70/25/5, 30/50/20 or 10/30/60 |
| Regions | 20 % in each of the five regions; 67 % Americas, 16 % Europe, 14 % Asia, 2 % Oceania, 1 % Africa; 42 % Europe, 40 % Asia, 13 % Americas, 3 % Oceania, 2 % Africa |


You can also start from your **current holdings** and adjust from there. Target weights must total **100 %**.

### Scope

A target applies to a scope: **all accounts**, a **custom portfolio**, or a **single account**.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/allocation/model.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Target editor with the preset picker and weight sliders" /> <img src="https://assets.wealthfolio.app/images/screenshots/allocation/model-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Target editor with the preset picker and weight sliders" />
<figcaption>Target editor with the preset picker and weight sliders</figcaption>
</figure>

## Reading drift

The **Overview** shows how far you’ve strayed from your target.

- **Drift** is your current allocation minus your target, in percentage points.
- Each category is **Overweight**, **Underweight**, **In band**, or **Not targeted**.
- The **tolerance band** defines how much drift is acceptable. A new target uses a **Hybrid** band: each category’s band scales with its target weight (relative factor 20 %, from 5 % to 50 %), and an absolute floor of 1 % (from 0.5 % to 10 %) sets its minimum width. **Absolute** uses the same fixed band, from 0.5 % to 10 %, for every category. Categories inside the band need no action; categories outside it are flagged.
- The **largest gaps** card surfaces the most out-of-band categories first, and a holdings table shows current %, target %, and drift per holding.
- Categories use your theme’s chart colours, and each keeps the colour it has on the Insights donuts.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/allocation/drift.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Drift drivers card highlighting the largest out-of-band gaps" /> <img src="https://assets.wealthfolio.app/images/screenshots/allocation/drift-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Drift drivers card highlighting the largest out-of-band gaps" />
<figcaption>Drift drivers card highlighting the largest out-of-band gaps</figcaption>
</figure>

## Rebalancing worksheet

The rebalancing worksheet replaced the Rebalance planner in **3.12**. It works out how far each category is from its target and calculates adjustments to your positions, which you can edit and then review by account. Nothing is submitted or executed, and fees and taxes aren’t included.

To open it, go to **Insights → Overview**, choose **Details** on the **Target allocation** card, then **Open rebalancing →** under **Largest gaps**. The first time, a dialog titled **How the rebalancing worksheet works** explains what it does.

The worksheet has three steps: **Setup**, **Adjust positions**, and **Review**. You can switch between them at any time. Wealthfolio keeps your inputs and edits on this device, for each target and account scope.

### Setup

- **Accounts to change**: the accounts the worksheet may change, from the account scope you’re viewing. All are selected at first. Each account funds only its own changes; nothing moves between accounts. Next to each account, set the cash it deploys, or add a **Deposit** for cash you haven’t recorded yet.
- **Cash to deploy**: the total to invest. Choose **25%**, **50%**, **75%**, or **All** of the cash the selected accounts record, or type an amount. A total is spread as the same share of each account’s cash.
- **Rebalance**: while it’s off, the worksheet only adds (“Cash only. Nothing is reduced.”). Turn it on to also reduce categories above target: the cash is used first, then reductions fund the rest. It’s available only when the target allows reductions (see **Rebalance settings** below).
- **Gap to target**: each category’s current and target percentage, the amount to add (+) or reduce (−) to reach the target, and which securities would take it.
- **Securities**: choose **Change** to leave a security out of increases (**Increase**) or, with Rebalance on, out of reductions (**Reduce**) for this run. You can also add a security you don’t hold; it gets no calculated amount, so you set it in Adjust positions.

Choose **Next: Adjust positions** to calculate. Each category’s gap is split across its eligible securities in proportion to what you already hold of each, and a security in several categories gets one combined amount. If the cash doesn’t cover every gap, each increase is scaled by the same share, and the worksheet says so. Before the first calculation, you can choose **Enter adjustments yourself** instead to start without calculated amounts.

### Adjust positions

Each position shows its weight now and after the change. Edit or remove any line: enter the amount to add or reduce (**Adjustment (+/−)**), or switch to **Projected %** and enter the share of the portfolio you want the position to have. **Add position** adds another security.

- **Portfolio impact** shows each category’s current, projected, and target weight, and how many categories are still outside their target range.
- **Funding left** shows the cash each account has left after the changes, or how much it lacks. You can add a shortfall as a deposit.
- An increase goes to the only account that can take it, or to the only one that already holds the security. When several accounts could take it, Wealthfolio doesn’t pick one: open the position and place the amount under **Account allocation**. Reductions come from the accounts that hold the security.
- Amounts that can’t be placed on a security (no eligible security, nothing held in the category, or no usable price) appear as **Unresolved amounts** and are left out of the projection.

If you change Setup, or prices move more than 1 % after the calculation, the worksheet says so and offers **Recalculate from target**. Your edits stay until you recalculate. **Reset to calculated adjustments** in the ⋯ menu discards your edits.

### Review

**Review adjustments** groups the lines by account. Each line shows its amount and an estimated quantity, and each account shows its total and the cash it has left, or **Funding needed** with the amount it lacks. A line with something to fix, such as an amount not yet placed in accounts, stays under **Not in the review yet** until you fix it.


The worksheet uses your recorded holdings, prices, and exchange rates. It doesn’t choose investments or recommend changes, and actual results may differ because prices can change and fees, taxes, and execution aren’t included. The full text is under **About this preview** in the worksheet.


### Rebalance settings

Each target’s **Rebalance settings**, in the target editor, shape the worksheet:


| Setting | What it does |
|----|----|
| **Reductions** | **Allowed** offers **Rebalance** in the worksheet. With **Not allowed**, the worksheet only invests cash, and no position can be reduced, even by hand. |
| **Quantities** | **Whole units** rounds calculated quantities down to whole units; **Fractional** allows fractions of a unit. |
| **Minimum line size** | Calculated lines below this amount are flagged, not removed. |
| **Max turnover %** | Limits the calculated reductions to this share of the portfolio. Later edits past it are flagged, not blocked. Leave it empty for no limit. |


When you edit a saved target that allows reductions, **Never reduced** lists protected assets and accounts. The calculation never reduces those holdings, even above target.

## Exporting

From **Review**, once every adjustment is in the review:

- **Export CSV**: saves `rebalancing-worksheet-{date}.csv`. It has one row per line (account, security, whether it’s as calculated or edited, increase or reduce, amount, estimated quantity, price, category, and price date), any unresolved amounts, each account’s total and cash left, then what the worksheet was calculated from, its warnings, and its limitations. Numbers use your decimal separator; where that’s a comma, columns are separated by semicolons.
- **Copy for spreadsheet**: copies the same table to paste into a spreadsheet.

Wealthfolio doesn’t place trades for you. Take the adjustments to your broker and make the trades there.

## Related

- <a href="/docs/guide/dashboards/" class="font-medium underline underline-offset-4">Dashboards</a>: asset-allocation donut and Holdings → Insights cuts.
- <a href="/docs/guide/spending-budgets/" class="font-medium underline underline-offset-4">Spending &amp; Budgets</a>: the other major 3.5 module.


<a href="/docs/guide/spending-budgets/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Spending &amp; Budgets</a> <a href="/docs/guide/goals/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Goals &amp; Save-Up Planner</a>


On this page

- <a href="#setting-targets" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Setting targets</a>
  - <a href="#allocation-type" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Allocation type</a>
  - <a href="#starting-point" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Starting point</a>
  - <a href="#scope" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Scope</a>
- <a href="#reading-drift" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Reading drift</a>
- <a href="#rebalancing-worksheet" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Rebalancing worksheet</a>
  - <a href="#setup" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Setup</a>
  - <a href="#adjust-positions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Adjust positions</a>
  - <a href="#review" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Review</a>
  - <a href="#rebalance-settings" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Rebalance settings</a>
- <a href="#exporting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Exporting</a>
- <a href="#related" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Related</a>


