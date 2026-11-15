> Source: https://wealthfolio.app/docs/concepts



Docs


Core Concepts


# Core Concepts

Objects Wealthfolio uses under the hood.


Last updated November 12, 2026


## Account


| Field | Purpose |
|----|----|
| **Name** | Display label (2–50 characters) |
| **Group** | Collapses similar accounts on the dashboard (e.g. *RRSP*) |
| **Type** | *Securities · Cash · Credit Card · Crypto* |
| **Currency** | The account’s currency; set at creation, converted to your base currency for totals |
| **Tracking mode** | *Transactions* (record every activity) or *Holdings* (snapshots) |
| **Status** | *Active*, *Hidden* (stays in totals), or *Archived* (removed, restorable) |


## Activity

All portfolio changes resolve into one of these actions.


| Type | Cash Δ | Holdings Δ | Notes |
|----|----|----|----|
| **BUY** | − | \+ | Fee optional |
| **SELL** | \+ | − | Gain tracked |
| **DIVIDEND** | \+ | 0 | Cash income |
| **INTEREST** | \+ | 0 | Cash income |
| **DEPOSIT / WITHDRAWAL** | ± | 0 | Cash only |
| **TRANSFER_IN / OUT** | ± | ± | Internal keeps cost basis; External seeds/removes positions (opening balances, gifts, write-offs) |
| **FEE / TAX** | − | 0 | Stand-alone charges |
| **SPLIT** | 0 | qty/price adjust | No value change |


Cash legs post to the synthetic symbol `$CASH-<CCY>` automatically. The saved amount is the cash actually paid or received, with fees and taxes already applied. See <a href="/docs/concepts/activity-fields/" class="font-medium underline underline-offset-4">Activity Fields</a> for field meanings and special cases.

## Symbol lookup

1.  Exact ticker (`AAPL`, `BTC-USD`).
2.  Ticker + suffix (`RY.TO`).
3.  First Yahoo Finance hit.

Need to override? Use the **Universal Symbol ID**.

## FX rates

- Pulled every 6 h from the default market data provider.
- View/edit: `Settings → General → Exchange Rates`.
- Manual rates override auto values until you change them again.


<a href="/docs/quick-start/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Quick Start</a>


On this page

- <a href="#account" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Account</a>
- <a href="#activity" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Activity</a>
- <a href="#symbol-lookup" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Symbol lookup</a>
- <a href="#fx-rates" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">FX rates</a>


