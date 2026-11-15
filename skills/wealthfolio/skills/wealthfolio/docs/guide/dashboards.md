> Source: https://wealthfolio.app/docs/guide/dashboards



Docs


Portfolio Dashboards


# Portfolio Dashboards

A tour of the home dashboard. What every card means and how to read it.


Last updated November 12, 2026


The home dashboard is the at-a-glance view of your portfolio. This page walks through each card so you know what you’re looking at, and where to dig in.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/investments/dashboard.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="The home dashboard: total portfolio value, accounts, and top holdings" /> <img src="https://assets.wealthfolio.app/images/screenshots/investments/dashboard-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="The home dashboard: total portfolio value, accounts, and top holdings" />
<figcaption>The home dashboard: total portfolio value, accounts, and top holdings</figcaption>
</figure>

------------------------------------------------------------------------

## 1 · The cards

### Total Portfolio Value

The headline number. Sums **all** accounts converted to your base currency at today’s FX rate. Click the eye icon beside it to hide the value (handy for screenshots). The Net Worth and Spending tabs have the same button, and so does Portfolio value on **Insights → Overview**.

Below the headline are the gain and the return over the selected period, followed by the period.

Hover the change percentages for a tooltip explaining the metric (TWR vs. MWR; see <a href="/docs/concepts/performance-metrics/" class="font-medium underline underline-offset-4">Performance Metrics</a>).

### Accounts Summary

One row per account, with current value and the day’s change. Click any row to drill into that account’s holdings and activities.

Account groups (if you’ve set any up) roll up underneath their group name. Handy for “Spouse RRSP”, “Joint Taxable”, etc.

### Top Holdings

The top 5–10 positions by current market value, with allocation percentage. Click any row to open the asset detail page (lots, price history, dividends).

To see every position, use the **Holdings** page from the sidebar.

### Holdings page

The full position list, with a few controls worth knowing:

- **Open / Closed** – the view control before the search box. **Open** is the default and shows what you currently hold. **Closed** shows disposed positions with cost basis, sale proceeds, realized P&L, and realized return in place of the market-value columns (option expiries included). A closed position stays separate from an open one in the same asset, even when a long and a short net to zero.
- **Type filter** – stocks, ETFs, bonds, and **cash**, which carries its own portfolio weight on desktop and mobile.
- **Quantity labels** follow the instrument: *shares* for stocks, *units* for ETFs and mutual funds, *bonds* for debt securities, *contracts* for options.
- **Search** matches instrument name in both views, and sorting is preserved when you switch to a view that doesn’t have the column you sorted by.
- **Columns** – on desktop, this menu also moves columns up or down, and the order is saved per profile. **Reset column order** puts them back.
- **Currency button** – when your holdings use more than one currency, it switches values between your base currency and each asset’s own (**Show values in Asset Currency**). Both views use the same recorded cost.
- **Missing values** – a value that can’t be worked out shows ”—” instead of 0 and is left out of totals and weights. If an account’s calculation fails or is still running, only that account’s holdings are left out, and a notice says the totals are incomplete.

For sector, region, and currency cuts, open **Insights → Overview**.

The mobile app carries the same controls. See the <a href="/docs/guide/mobile/" class="font-medium underline underline-offset-4">Mobile guide</a>.

### Asset Allocation

A donut chart broken down by asset class (Equity, Fixed Income, Cash, Crypto, Alternative). Hover any slice for the dollar value and percentage.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/portfolio-insights/overview.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Asset allocation with class, region, and sector breakdowns" /> <img src="https://assets.wealthfolio.app/images/screenshots/portfolio-insights/overview-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Asset allocation with class, region, and sector breakdowns" />
<figcaption>Asset allocation with class, region, and sector breakdowns</figcaption>
</figure>

Drill further on **Insights → Overview**: its Accounts, Classes, Regions, and Sectors cards break the portfolio down, and its **Holdings** donut shows your seven largest holdings, the rest, and cash. Its Breakdown card groups the portfolio by allocation, account, sector, region, risk, security type, currency, or your own groups. The views sit on one row, and those that don’t fit are under **More**.

### Net Worth Chart

Historical net worth over time, with toggleable account inclusion. Useful for spotting trends and the impact of major contributions.

The chart follows the period buttons under it: 1D, 1W, 1M, 3M, 6M, YTD, 1Y, 5Y, and ALL. The calendar button beside them picks a custom range, or any completed month or calendar year from its **Month** and **Year** tabs. A year is compared with the year before.

The **Previous period** and **Next period** arrows beside the period name, at the top of the Investments, Net Worth, and Spending tabs, step through the period you picked: 3M steps back three months at a time, and Next stops at the latest period.

The dashboard’s Investments, Net Worth, and Spending tabs share one time period with the Spending and Performance tabs of **Insights**. Pick a period on any of them and the others follow, or show the nearest period they offer, so a single month, a year, or a custom range carries over too. Links that name a period still open on that period, and Insights’ Income tab keeps its own.

### Net Worth dashboard

Switch to the **Net Worth** tab at the top of the home view for your full financial picture – not just investments, but property, vehicles, collectibles, precious metals, cash, and liabilities. Refreshed in 3.5, it adds:

- A richer **breakdown** of assets and liabilities, with expandable hierarchical categories and tap-to-expand detail drawers (mortgages net against the property they finance). In a drawer, each item opens its own page, and a liability’s drawer has **View details**.
- **Velocity** and **Momentum** cards – how quickly your net worth is accelerating over the trailing year, and this period versus the equal window just before it.
- A **Needs attention** card that lists, among other things, assets you value by hand that haven’t been updated in 90 days. They also raise a Health Center warning under **Prices**, which shows in the health badge beside the total.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/networth/dashboard.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="The Net Worth dashboard: breakdown of assets and liabilities, velocity, and momentum" /> <img src="https://assets.wealthfolio.app/images/screenshots/networth/dashboard-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="The Net Worth dashboard: breakdown of assets and liabilities, velocity, and momentum" />
<figcaption>The Net Worth dashboard: breakdown of assets and liabilities, velocity, and momentum</figcaption>
</figure>

### Spending

New in 3.5: track day-to-day cash flow alongside your investments. Categorize transactions, build budgets, and read narrative spending insights. See the <a href="/docs/guide/spending-budgets/" class="font-medium underline underline-offset-4">Spending &amp; Budgets</a> guide.

The Spending tab’s period buttons are 1W, This month, 3M, 6M, YTD, and 1Y. To see how this period compares with the one before, turn on **Compare to prior period** in the tab’s ⋯ menu. Last period’s bars then sit beside this period’s, and the tooltip shows both date ranges and the difference. Click either bar to open its transactions.

Spending insights are on the **Spending** tab of **Insights**, next to Overview, Performance, and Income. The tab shows only when spending is turned on.

### Goal Progress

If you’ve configured savings goals or a retirement target (<a href="/docs/guide/goals/" class="font-medium underline underline-offset-4">Goals</a> / <a href="/docs/guide/retirement-planning/" class="font-medium underline underline-offset-4">Retirement Planning</a>), this card shows progress relative to the deadline:

- 🟢 **On track:** projected to meet the goal on time.
- 🟡 **At risk:** projection is tight; small adjustments needed.
- 🔴 **Off track:** current pace won’t meet the deadline.

### Income Dashboard

Tucked into the **Income** tab of **Insights**: dividend and interest income by period, with breakdowns by account and asset.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/income/summary.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="The Income dashboard: dividends and interest over time" /> <img src="https://assets.wealthfolio.app/images/screenshots/income/summary-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="The Income dashboard: dividends and interest over time" />
<figcaption>The Income dashboard: dividends and interest over time</figcaption>
</figure>

------------------------------------------------------------------------

## 2 · Reading the performance numbers

The ”%” on the dashboard and account rows is **MWR** (money-weighted return) by default. It captures the impact of your timing decisions. The total portfolio also shows TWR when you drill into **Performance**.

**Insights → Performance** gives each number its own tile: the return, the money-weighted return, volatility, maximum drawdown, and the gain or loss. Annualized return shows only for ranges of a year or more. A value that can’t be worked out reads N/A, and the ⚠ button beside it says why. Compare two or more items and a **Compared series** table appears under the chart: click a name to make it the main line, or hide a line without removing it.

If you’ve never thought about TWR vs. MWR, the <a href="/docs/concepts/performance-metrics/" class="font-medium underline underline-offset-4">Performance Metrics</a> concept doc explains both with worked examples.

------------------------------------------------------------------------

## 3 · Date range and base currency

- **Date range** (the period buttons under the chart) controls the chart and the change figures. It’s shared with the Net Worth and Spending tabs and with Insights’ Spending and Performance tabs.
- **Base currency** (Settings → General) controls what currency every total is converted to. Changing it doesn’t move any data; only the display conversion.

------------------------------------------------------------------------

## 4 · When numbers look off

Start with the <a href="/docs/guide/health-center/" class="font-medium underline underline-offset-4">Health Center</a>. It flags negative cash, stale quotes, and suspect spikes that often explain “why did this jump.” If you can’t find the cause, the <a href="/docs/faq/#performance-metrics" class="font-medium underline underline-offset-4">FAQ</a> walks through the common “why does my number look wrong” cases.


<a href="/docs/concepts/market-data-and-fx/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Market Data &amp; FX</a> <a href="/docs/guide/activities/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Activities</a>


On this page

- <a href="#1--the-cards" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1 · The cards</a>
  - <a href="#total-portfolio-value" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Total Portfolio Value</a>
  - <a href="#accounts-summary" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Accounts Summary</a>
  - <a href="#top-holdings" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Top Holdings</a>
  - <a href="#holdings-page" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Holdings page</a>
  - <a href="#asset-allocation" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Asset Allocation</a>
  - <a href="#net-worth-chart" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Net Worth Chart</a>
  - <a href="#net-worth-dashboard" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Net Worth dashboard</a>
  - <a href="#spending" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Spending</a>
  - <a href="#goal-progress" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Goal Progress</a>
  - <a href="#income-dashboard" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Income Dashboard</a>
- <a href="#2--reading-the-performance-numbers" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2 · Reading the performance numbers</a>
- <a href="#3--date-range-and-base-currency" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3 · Date range and base currency</a>
- <a href="#4--when-numbers-look-off" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">4 · When numbers look off</a>


