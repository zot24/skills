> Source: https://wealthfolio.app/docs/concepts/tracking-modes



Docs


Tracking Modes


# Tracking Modes

Understand the two ways to track your investment accounts in Wealthfolio.


Last updated November 12, 2026

Wealthfolio offers two ways to track your investment accounts. The choice comes down to how much detail you want to maintain and what metrics matter to you.

------------------------------------------------------------------------

## Why Two Modes?

Maintaining a complete transaction history takes effort. Every buy, sell, dividend, deposit, and withdrawal must be recorded accurately with correct dates and amounts. Some users want this level of detail for precise performance analytics and tax reporting. Others just want to track their net worth without the bookkeeping overhead.

Wealthfolio lets you choose the approach that fits your needs. You can use different modes for different accounts within the same portfolio.

------------------------------------------------------------------------

## The Two Modes


#### Transactions Mode

Performance Tracking


Track every trade for full performance analytics. Wealthfolio calculates your current holdings from this activity history.

Best for:

- Accounts where you have records of every trade
- When you want detailed performance and tax reports
- When you need cost basis and capital gains tracking
- Accounts synced with a broker (transactions are imported automatically)

What you get:

- Total return over time
- Gains & cashflow attribution
- Complete performance analytics
- Tax lot tracking and cost basis

**Note:** Requires tracking all transactions. Gaps in history will lead to incorrect balances and returns.


#### Holdings Mode

Value Tracking


Enter or import your current positions directly – how many shares of each security you hold. No trade history needed.

Best for:

- Simple net worth tracking without bookkeeping overhead
- Accounts where you don’t want to track every transaction
- 401(k), pension, or external platforms
- Fast setup and low maintenance

What you get:

- Net worth & allocation
- Value & unrealized P&L
- Price-based performance

**Note:** Requires maintaining holdings/positions as they change. No cashflow-adjusted performance.


------------------------------------------------------------------------

## Comparison


|                          | Transactions             | Holdings              |
|--------------------------|--------------------------|-----------------------|
| Holdings come from       | Your trade history       | Direct entry          |
| Performance tracking     | Full (cashflow-adjusted) | Price changes only    |
| Total return calculation | Yes                      | No                    |
| Setup effort             | More (enter all trades)  | Less (enter balances) |
| Maintenance              | Record new trades        | Update positions      |


------------------------------------------------------------------------

## Choosing the Right Mode

### Choose Transactions if:

- You have complete transaction history (or can get it via CSV export or broker sync)
- You want to track true investment performance including dividends, contributions, and withdrawals
- You need tax reporting features like cost basis and capital gains
- You’re setting up broker sync (transactions are imported automatically)

### Choose Holdings if:

- You only know your current positions, not how you got there
- It’s an old account and reconstructing history isn’t practical
- It’s a retirement account (401k, pension) where transaction details aren’t accessible
- You just want to track net worth without detailed performance metrics
- You want the fastest possible setup

------------------------------------------------------------------------

## Switching Between Modes

You can change an account’s tracking mode at any time in account settings. However, switching from Holdings to Transactions has important implications:


Switching from Holdings to Transactions

Your account value and performance history will be rebuilt entirely from transactions. Holdings snapshots will no longer be used.

Before switching, make sure:

- All buys, sells, deposits & withdrawals are recorded
- Dates, quantities & prices are accurate
- There are no gaps in your transaction history


Switching from Transactions to Holdings is simpler – your transaction history is preserved but holdings will be managed through snapshots going forward.

------------------------------------------------------------------------

## How It Affects Your Workflow

### With Transactions Mode

1.  **Adding data:** Record individual trades (BUY, SELL), income (DIVIDEND, INTEREST), and cash movements (DEPOSIT, WITHDRAWAL)
2.  **Importing:** Use CSV import or broker sync to bring in transaction history
3.  **Holdings:** Calculated automatically from your transaction history
4.  **Updates:** Record new trades as they happen

### With Holdings Mode

1.  **Adding data:** Enter your current positions directly (symbol, quantity, optionally price paid)
2.  **Importing:** Import holdings snapshots showing positions at a point in time
3.  **Holdings:** What you enter is what you see
4.  **Updates:** Periodically update positions when they change, or sync automatically

------------------------------------------------------------------------

## Frequently Asked Questions

**Can I use both modes in the same portfolio?**  
Yes. Each account has its own tracking mode. Use Transactions for your main brokerage and Holdings for your 401(k) – they’ll all roll up into your portfolio totals.

**What if I have partial transaction history?**  
Use Transfer Holdings (TRANSFER_IN activity type) to bring in positions at a point in time, then record new transactions going forward. This lets you start with accurate holdings without needing to reconstruct every historical trade. See <a href="/docs/concepts/activity-types/" class="font-medium underline underline-offset-4">Activity Types</a> for details.

**Will I lose data if I switch modes?**  
No data is deleted. When switching modes, Wealthfolio recalculates your holdings and performance based on the new mode’s rules. Your transaction records and holdings snapshots are preserved.

**Which mode is better for broker sync?**  
It depends on your broker’s data accuracy. Holdings mode is recommended for simple, accurate tracking. Transactions mode can require reviewing imported transactions for ambiguous activity types that may need manual correction.


<a href="/docs/quick-start/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Quick Start</a> <a href="/docs/concepts/activity-types/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Activity Types</a>


On this page

- <a href="#why-two-modes" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Why Two Modes?</a>
- <a href="#the-two-modes" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">The Two Modes</a>
- <a href="#comparison" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Comparison</a>
- <a href="#choosing-the-right-mode" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Choosing the Right Mode</a>
  - <a href="#choose-transactions-if" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Choose Transactions if:</a>
  - <a href="#choose-holdings-if" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Choose Holdings if:</a>
- <a href="#switching-between-modes" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Switching Between Modes</a>
- <a href="#how-it-affects-your-workflow" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">How It Affects Your Workflow</a>
  - <a href="#with-transactions-mode" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">With Transactions Mode</a>
  - <a href="#with-holdings-mode" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">With Holdings Mode</a>
- <a href="#frequently-asked-questions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Frequently Asked Questions</a>


