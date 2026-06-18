> Source: https://wealthfolio.app/docs/concepts/tracking-modes

Wealthfolio offers two ways to track your investment accounts. The choice comes down to how much detail you want to maintain and what metrics matter to you.

---

## Why Two Modes?

Maintaining a complete transaction history takes effort. Every buy, sell, dividend, deposit, and withdrawal must be recorded accurately with correct dates and amounts. Some users want this level of detail for precise performance analytics and tax reporting. Others just want to track their net worth without the bookkeeping overhead.

Wealthfolio lets you choose the approach that fits your needs. You can use different modes for different accounts within the same portfolio.

---

## The Two Modes


<Card>
  <div className="mb-2 flex items-center gap-3">
    <div className="flex h-10 w-10 items-center justify-center rounded-md bg-blue-500/10 text-blue-600 dark:text-blue-400">
      <ListChecks className="h-5 w-5" aria-hidden="true" />
    </div>
    <div>
      <h4 className="m-0 text-lg font-semibold">Transactions Mode</h4>
      <p className="m-0 text-sm text-muted-foreground">Performance Tracking</p>
    </div>
  </div>
  <p className="mb-3 text-sm">
    Track every trade for full performance analytics. Wealthfolio calculates your current holdings
    from this activity history.
  </p>
  <p className="mb-2 text-sm font-medium">Best for:</p>
  <ul className="mb-3 space-y-1 text-sm">
    <li>Accounts where you have records of every trade</li>
    <li>When you want detailed performance and tax reports</li>
    <li>When you need cost basis and capital gains tracking</li>
    <li>Accounts synced with a broker (transactions are imported automatically)</li>
  </ul>
  <p className="mb-2 text-sm font-medium">What you get:</p>
  <ul className="mb-3 space-y-1 text-sm">
    <li>Total return over time</li>
    <li>Gains & cashflow attribution</li>
    <li>Complete performance analytics</li>
    <li>Tax lot tracking and cost basis</li>
  </ul>
  <p className="text-xs text-muted-foreground">
    <strong>Note:</strong> Requires tracking all transactions. Gaps in history will lead to
    incorrect balances and returns.
  </p>
</Card>

<Card>
  <div className="mb-2 flex items-center gap-3">
    <div className="flex h-10 w-10 items-center justify-center rounded-md bg-green-500/10 text-green-600 dark:text-green-400">
      <Camera className="h-5 w-5" aria-hidden="true" />
    </div>
    <div>
      <h4 className="m-0 text-lg font-semibold">Holdings Mode</h4>
      <p className="m-0 text-sm text-muted-foreground">Value Tracking</p>
    </div>
  </div>
  <p className="mb-3 text-sm">
    Enter or import your current positions directly—how many shares of each security you hold. No
    trade history needed.
  </p>
  <p className="mb-2 text-sm font-medium">Best for:</p>
  <ul className="mb-3 space-y-1 text-sm">
    <li>Simple net worth tracking without bookkeeping overhead</li>
    <li>Accounts where you don't want to track every transaction</li>
    <li>401(k), pension, or external platforms</li>
    <li>Fast setup and low maintenance</li>
  </ul>
  <p className="mb-2 text-sm font-medium">What you get:</p>
  <ul className="mb-3 space-y-1 text-sm">
    <li>Net worth & allocation</li>
    <li>Value & unrealized P&L</li>
    <li>Price-based performance</li>
  </ul>
  <p className="text-xs text-muted-foreground">
    <strong>Note:</strong> Requires maintaining holdings/positions as they change. No
    cashflow-adjusted performance.
  </p>
</Card>


---

## Comparison

|                          | Transactions             | Holdings              |
| ------------------------ | ------------------------ | --------------------- |
| Holdings come from       | Your trade history       | Direct entry          |
| Performance tracking     | Full (cashflow-adjusted) | Price changes only    |
| Total return calculation | Yes                      | No                    |
| Setup effort             | More (enter all trades)  | Less (enter balances) |
| Maintenance              | Record new trades        | Update positions      |

---

## Choosing the Right Mode

### Choose Transactions if:

- You have complete transaction history (or can get it via CSV export or broker sync)
- You want to track true investment performance including dividends, contributions, and withdrawals
- You need tax reporting features like cost basis and capital gains
- You're setting up broker sync (transactions are imported automatically)

### Choose Holdings if:

- You only know your current positions, not how you got there
- It's an old account and reconstructing history isn't practical
- It's a retirement account (401k, pension) where transaction details aren't accessible
- You just want to track net worth without detailed performance metrics
- You want the fastest possible setup

---

## Switching Between Modes

You can change an account's tracking mode at any time in account settings. However, switching from Holdings to Transactions has important implications:

  <Card className="border-orange-200 bg-orange-50/50 dark:border-orange-800 dark:bg-orange-900/20">
    <div className="flex items-start gap-3">
      <AlertTriangle
        className="mt-0.5 h-5 w-5 shrink-0 text-orange-600 dark:text-orange-400"
        aria-hidden="true"
      />
      <div>
        <p className="mb-2 font-medium text-orange-800 dark:text-orange-200">
          Switching from Holdings to Transactions
        </p>
        <p className="mb-2 text-sm text-orange-700 dark:text-orange-300">
          Your account value and performance history will be rebuilt entirely from transactions.
          Holdings snapshots will no longer be used.
        </p>
        <p className="mb-1 text-sm font-medium text-orange-800 dark:text-orange-200">
          Before switching, make sure:
        </p>
        <ul className="space-y-1 text-sm text-orange-700 dark:text-orange-300">
          <li>All buys, sells, deposits & withdrawals are recorded</li>
          <li>Dates, quantities & prices are accurate</li>
          <li>There are no gaps in your transaction history</li>
        </ul>
      </div>
    </div>
  </Card>

Switching from Transactions to Holdings is simpler—your transaction history is preserved but holdings will be managed through snapshots going forward.

---

## How It Affects Your Workflow

### With Transactions Mode

1. **Adding data:** Record individual trades (BUY, SELL), income (DIVIDEND, INTEREST), and cash movements (DEPOSIT, WITHDRAWAL)
2. **Importing:** Use CSV import or broker sync to bring in transaction history
3. **Holdings:** Calculated automatically from your transaction history
4. **Updates:** Record new trades as they happen

### With Holdings Mode

1. **Adding data:** Enter your current positions directly (symbol, quantity, optionally price paid)
2. **Importing:** Import holdings snapshots showing positions at a point in time
3. **Holdings:** What you enter is what you see
4. **Updates:** Periodically update positions when they change, or sync automatically

---

## Frequently Asked Questions

**Can I use both modes in the same portfolio?**  
Yes. Each account has its own tracking mode. Use Transactions for your main brokerage and Holdings for your 401(k)—they'll all roll up into your portfolio totals.

**What if I have partial transaction history?**  
Use Transfer Holdings (TRANSFER_IN activity type) to bring in positions at a point in time, then record new transactions going forward. This lets you start with accurate holdings without needing to reconstruct every historical trade. See [Activity Types](/docs/concepts/activity-types) for details.

**Will I lose data if I switch modes?**  
No data is deleted. When switching modes, Wealthfolio recalculates your holdings and performance based on the new mode's rules. Your transaction records and holdings snapshots are preserved.

**Which mode is better for broker sync?**  
It depends on your broker's data accuracy. Holdings mode is recommended for simple, accurate tracking. Transactions mode can require reviewing imported transactions for ambiguous activity types that may need manual correction.
