> Source: https://wealthfolio.app/docs/concepts/performance-metrics

Wealthfolio employs several performance metrics and calculation methods to provide a comprehensive view of your portfolio's performance. Understanding these concepts is key to interpreting your financial progress accurately.

Every performance result Wealthfolio computes is built from a daily valuation series for the selected scope (a single account, a group of accounts, or your whole portfolio). For each day the engine knows your total value, your cost basis, and any external cash flows (deposits and withdrawals). All metrics below are derived from that series.

## Return Methods

Wealthfolio reports performance under one of several **return methods**, chosen automatically based on how the scope is tracked. The method tells you how the headline return was calculated.

*   **Time-Weighted (TWR):** Used for accounts you track by recording transactions (buys, sells, deposits, withdrawals). This is the default method for most accounts.
*   **Value Return:** Used for *holdings-only* accounts, where you track current positions and market value rather than a full transaction history. The return is measured from changes in unrealized gain/loss.
*   **Symbol Price-Based:** Used when measuring the performance of an individual symbol or asset directly from its price quotes.
*   **Not Applicable:** Returned when there isn't enough data to compute a meaningful return for the scope and period.

## Key Performance Metrics

Here are the primary metrics used throughout the application.

### 1. Time-Weighted Return (TWR)

*   **Definition:** Time-Weighted Return measures the compound growth rate of a portfolio while removing the distorting effects of cash inflows (deposits) and outflows (withdrawals). It reflects the performance of the underlying investments, independent of when you added or removed money.
*   **Use Case:** TWR is ideal for judging an investment strategy in isolation and for comparing performance across portfolios, because it is not affected by the timing or size of your cash flows.
*   **Calculation Insight:** Wealthfolio computes a daily return for each day in the period and geometrically links (compounds) them. Each day's return is `(End Value + Outflows − Start Value − Inflows) / (Start Value + Inflows)`. Days where the opening base is below one currency unit are excluded from the chain to avoid distortion, and flagged in the result's data quality.

### 2. Money-Weighted Return (IRR / XIRR)

*   **Definition:** Money-Weighted Return, expressed as an annualized Internal Rate of Return, accounts for the size and timing of every cash flow. It is the single rate that discounts all dated cash flows so their net present value equals zero.
*   **Use Case:** MWR reflects your *actual* personal rate of return, because it is sensitive to when money entered or left the portfolio. Two investors holding the same fund can have very different MWRs depending on their contribution timing.
*   **Calculation Insight:** Wealthfolio builds a dated cash-flow series — the opening value as an outflow, each deposit/withdrawal on its real date, and the closing value as an inflow — and solves for the rate using a bisection (XIRR) solver. Time is measured in years of `365.25` days. The result is reported both as an annualized rate and as a period rate scaled back to the selected window. MWR is unavailable when the cash flows never change sign.

### 3. Value Return (Simple Return)

*   **Definition:** A straightforward measure of gain or loss relative to the starting value, after backing out net cash flows: `(End Value − Start Value − Net Cash Flows) / Start Value`. For holdings-only accounts it is derived from the change in unrealized gain/loss relative to the starting market value (or to cost basis for an all-time view).
*   **Use Case:** Provides a quick, intuitive sense of overall return for the period.
*   **Limitations:** Because it does not account for *when* cash flows occurred, it can be misleading when there are large deposits or withdrawals mid-period. Prefer TWR or MWR in those cases.

### 4. Annualized Return

*   **Definition:** Annualized Return restates a period return as an equivalent compounded yearly rate, standardizing returns across different time spans for comparison.
*   **Use Case:** Lets you compare investments held for different lengths of time on a common yearly basis. Wealthfolio reports annualized versions of TWR, MWR, and Value Return.
*   **Calculation Insight:** Calculated as `(1 + Period Return)^(365.25 / Days) − 1`. Returns of −100% or worse are capped at −100%. For very short periods, annualizing magnifies noise and should be read with caution.

### 5. Volatility

*   **Definition:** Volatility measures how much returns fluctuate — the standard deviation of returns. Higher volatility means larger swings in value in either direction.
*   **Use Case:** A common proxy for risk. Higher volatility generally indicates a riskier, less predictable investment.
*   **Calculation Insight:** Wealthfolio takes the daily **log returns**, computes their sample standard deviation, then annualizes by multiplying by the square root of `365.25` (calendar days per year). At least two valid daily returns are required.

### 6. Maximum Drawdown

*   **Definition:** Maximum Drawdown is the largest peak-to-trough percentage decline in value over the period.
*   **Use Case:** Captures the worst loss an investor would have lived through, a tangible measure of downside risk.
*   **Calculation Insight:** The engine tracks the running peak of cumulative return and records the largest drop from any peak to a subsequent low. Alongside the drawdown percentage it reports the **peak date**, **trough date**, **recovery date** (when value returned to the prior peak, if it did), and the **drawdown duration** in days.

### 7. Performance Attribution

*   **Definition:** Attribution breaks the period's total change in value into its economic drivers, so you can see *why* your value moved, not just by how much.
*   **Components:** Contributions, distributions, income (e.g. dividends), realized P&L, unrealized P&L change, FX effect (currency movement for non-base-currency holdings), fees, taxes, and a **residual** that captures anything not explained by the other components.
*   **Calculation Insight:** Each component is computed on a best-effort basis from your activities, lot disposals, and daily valuations. The residual is the difference between the actual change in value and the sum of the explained components; if it grows beyond a small tolerance, the result is flagged as partially unreliable in the data quality.

### 8. Gain/Loss Amount

*   **Definition:** The absolute monetary gain or loss for the scope over the period.
*   **Calculation Insight:** `Total Value − Net Contribution`. This is the headline figure shown on account and portfolio cards.

### 9. Cumulative Return & Portfolio Weight

*   **Cumulative Return:** A simple percentage of gain over money put in, calculated as `Total Gain/Loss / Net Contribution`. Used on account summary cards for a fast read of overall return.
*   **Portfolio Weight:** The share of total portfolio value an account represents — `Account Value (base currency) / Total Portfolio Value (base currency)` — useful for understanding allocation and concentration.

## Data Quality

Because returns depend on the completeness of your data, every performance result carries a **data quality** status:

*   **OK:** The result was computed cleanly with no caveats.
*   **Partial:** The result is usable but carries warnings — for example, cash flows had to be inferred from net-contribution deltas, FX provenance was incomplete, or the attribution residual exceeded tolerance.
*   **No Data:** There wasn't enough valuation history to compute the metric.
*   **Not Applicable:** The metric doesn't apply to this scope or period (for example, TWR when no period opens with a positive value of at least one currency unit).

When a result is Partial, Wealthfolio surfaces the specific warnings and "not applicable" reasons so you can judge how much to trust the numbers.

## Multi-Currency Handling

When a scope spans more than one currency, Wealthfolio can compute returns on a base-currency basis. Currency movements are isolated into the **FX effect** attribution component, so you can separate genuine investment performance from gains or losses caused purely by exchange-rate changes. See [Market Data & FX](/docs/concepts/market-data-and-fx) for how rates are sourced.

## Understanding the Differences

*   **TWR vs. MWR:** TWR judges investment strategy in isolation from cash-flow timing; MWR tells you your actual personal rate of return, influenced by when you added or withdrew funds.
*   **History vs. Summary:** A full performance history gives a deep dive with a return series, risk metrics, and attribution. A performance summary gives a quick, high-level gain/loss and return figure.
*   **Symbol vs. Account Performance:** Symbol performance is based purely on price quotes from market data (dividends are excluded unless the quote series is total-return adjusted). Account performance incorporates your actual transactions, cash flows, holdings, fees, and taxes.

By understanding these metrics and how they are calculated, you can gain deeper insight into your investment journey with Wealthfolio.
