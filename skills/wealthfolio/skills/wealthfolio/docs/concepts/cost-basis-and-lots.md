> Source: https://wealthfolio.app/docs/concepts/cost-basis-and-lots



Docs


Cost Basis & Lots


# Cost Basis & Lots

How Wealthfolio tracks the cost basis of long and short lots, through splits, transfers, DRIPs, and partial sales.


Last updated November 12, 2026

Every share you buy creates a **long lot**; every explicit Sell Short creates a signed **short lot**. A lot is a unit of cost basis that follows that position until it’s closed. Lot accounting is what makes the difference between “you sold some Apple, here’s your gain” and “you sold these specific shares bought on this date at this price, here’s your gain and your remaining basis.”

This page covers how Wealthfolio’s lot tracking works, why we made the choices we did, and what to expect when activities touch your lots.

------------------------------------------------------------------------

## 1 · The mental model

Think of each `BUY` as opening a numbered lot:

``` mb-4
Lot #1:  2024-01-10  20 shares @ $150.00 cost basis = $3,000
Lot #2:  2024-04-15  10 shares @ $180.00 cost basis = $1,800
Lot #3:  2024-08-22   5 shares @ $200.00 cost basis = $1,000
                     -----------
Total:               35 shares                       $5,800
Average cost:                                        $165.71
```

The **average cost** line is a convenience display – total cost basis of your open lots divided by the shares you hold. It is *not* a moving-average accounting method: Wealthfolio doesn’t keep a running moving-average price, and the figure simply re-derives from whatever lots are still open. (See <a href="#9--why-not-lifo-weighted-average-or-specific-identification" class="font-medium underline underline-offset-4">the note for moving-average jurisdictions</a> below.)

Lots only exist when you track real activities. A **manually-entered holding** (a manual account snapshot) stores just a quantity and the average cost you type in – there’s no per-lot history behind it, so FIFO and realized-gain tracking only kick in once the position is built from actual `BUY` / `SELL` / `TRANSFER` activities.

Every `SELL`, **Buy to Cover**, or `TRANSFER_OUT` closes shares from one or more lots. Wealthfolio decides **which** lots to close using a method called **FIFO**.

------------------------------------------------------------------------

## 2 · FIFO: first in, first out

Wealthfolio closes the **oldest lot first**. Sell 25 shares from the position above and you’ll close all of Lot \#1 (20 shares) plus 5 shares from Lot \#2:

``` mb-4
Sell 25 shares @ $195

Closed:
  Lot #1: 20 shares × ($195 - $150) = $900 realized gain
  Lot #2:  5 shares × ($195 - $180) = $75 realized gain

Realized gain total: $975

Remaining:
  Lot #2:  5 shares  @ $180   = $900 cost basis
  Lot #3:  5 shares  @ $200   = $1,000 cost basis
  Total:  10 shares                   $1,900
```

Why FIFO?

- **Defensible.** It’s the default cost-basis method in most jurisdictions, so your Wealthfolio numbers will tend to match what your broker reports for tax purposes.
- **Simple to reason about.** No “which lots am I selling?” guessing. The oldest go first, period.
- **Stable.** Adding a backdated trade doesn’t reshuffle which shares were “sold” in later sales unless the backdate is actually earlier than those sales.

**Selling more than you hold?** A plain `SELL` still does not open or increase a short lot. Wealthfolio closes every available long lot, caps the position at zero, and flags the oversell. If you meant to open a short stock or ETF position, use **Sell Short** instead; that creates a signed negative lot. Use **Buy to Cover** to close short lots FIFO.

------------------------------------------------------------------------

## 3 · How activities change lots


| Activity | Effect on lots |
|----|----|
| `BUY` | Opens a new long lot using the saved final amount as its cost, including fees and taxes. |
| `SELL` | Closes shares from the oldest long lot(s) first. Fee reduces proceeds. Plain sells do not open short lots. |
| `SELL` (Sell Short) | Opens or extends a signed short lot for stocks and ETFs. |
| `BUY` (Buy to Cover) | Closes shares from the oldest short lot(s) first. |
| `SPLIT` | Adjusts quantity and per-share cost on every existing lot. Total cost basis is unchanged. |
| `DIVIDEND` (DRIP subtype) | Opens a new lot using the saved reinvested amount as its cost. |
| `DIVIDEND in Kind` | Opens a new lot for additional units of the same security at the broker-reported cost basis. |
| `TRANSFER_IN` | Restores the original lots (cost basis preserved) when paired with a `TRANSFER_OUT` from another Wealthfolio account. With the **External** flag, opens a single lot at the cost basis you provide. |
| `TRANSFER_OUT` | Closes lots oldest-first; no gain is realised. Internal: basis travels to the destination account. External: basis simply leaves Wealthfolio with the asset. |
| `ADJUSTMENT` (Option Expiry) | Closes the option lot to zero, realizing the premium paid as a loss. |
| `DEPOSIT` / `WITHDRAWAL` / `INTEREST` / `FEE` / `TAX` / cash `DIVIDEND` | No effect on lots. These move your cash balance only – cost basis lives entirely in share lots. |


------------------------------------------------------------------------

## 4 · Worked example: BUY → SPLIT → SELL

You buy, the stock splits, you sell. What does each activity do to your basis?

``` mb-4
2024-01-10   BUY 10 @ $400
   Lot #1: 10 shares, cost $400/share, total cost $4,000

2024-06-01   SPLIT 4-for-1
   Lot #1: 40 shares, cost $100/share, total cost $4,000

2024-09-15   SELL 25 @ $120
   Closes 25 shares from Lot #1
   Cost basis closed: 25 × $100 = $2,500
   Proceeds:          25 × $120 = $3,000
   Realized gain:                  $500

   Remaining Lot #1: 15 shares, cost $100/share, total cost $1,500
```

Notice that the SPLIT didn’t realize a gain; it just rebalanced the lot. The realized gain on the SELL uses the **post-split** per-share cost.

------------------------------------------------------------------------

### Final amounts and trade costs

For a normal long purchase, the saved final amount becomes the lot’s cost. For a sale, the final amount is the proceeds used to calculate the gain or loss against the cost of the shares sold. Fees and taxes already included in the total are not deducted again. A custom amount can therefore change both cash and gains, even if quantity and price stay the same. See <a href="/docs/concepts/activity-fields/" class="font-medium underline underline-offset-4">Activity Fields</a>.

## 5 · Transfers preserve cost basis

When you move shares between two Wealthfolio accounts:

``` mb-4
Account A (Brokerage)        Account B (Roth IRA – *don't actually do this*)

Lot:  100 shares @ $150      –

         ↓ TRANSFER_OUT 50 shares

Lot:   50 shares @ $150      Lot: 50 shares @ $150
                             (received via TRANSFER_IN)
```

Both halves of the lot share the original cost basis. Wealthfolio doesn’t realize a gain; moving shares isn’t selling them.

For transfers from **external** accounts (not another Wealthfolio account), a standalone `TRANSFER_IN` opens a single new lot at whatever cost basis you provide. Set it to your broker’s “transferred-in basis” if you have it, or to the average cost as of the transfer date.

------------------------------------------------------------------------

## 6 · DRIP and dividend-in-kind

A `DIVIDEND` with the **DRIP** subtype does two things in one activity:

1.  Records the dividend income at the cash amount.
2.  Opens a new lot for the reinvested shares using the saved reinvested amount as its cost.

That new lot starts the FIFO clock on those shares from the DRIP date. Relevant for short-vs-long-term capital gains tax in some jurisdictions.

A `DIVIDEND in Kind` opens a lot for additional units of the same security at the cost basis your broker reports. For a true spin-off into a different ticker, record the received security as an External `TRANSFER_IN` using the broker-reported basis.

------------------------------------------------------------------------

## 7 · Fractional shares

Lots are tracked to 8 decimal places. DRIP fractions, crypto satoshis, and broker fractional-share programs are all first-class.

------------------------------------------------------------------------

## 8 · Cost basis and currency

Each lot’s cost basis is stored in the **asset’s own currency**. A lot of a USD-listed stock carries a USD cost basis; a EUR-listed stock carries EUR – regardless of your account’s base currency. If you enter a trade in a different currency than the asset, Wealthfolio converts it at the trade’s FX rate and remembers the rate it used.

What matters for tax: when you **sell**, the realized gain reported in your base currency is built from two different FX rates –

- **Cost basis** is converted at the **acquisition-date** rate.
- **Proceeds** are converted at the **disposal-date** rate.

``` mb-4
Buy  10 shares @ $100   when 1 EUR = 1.10 USD  → basis  €909
Sell 10 shares @ $100   when 1 EUR = 1.00 USD  → proceeds €1,000

Realized gain (EUR): €91  – even though the price in USD never moved.
```

In other words, **currency movement is folded into your realized gain**, not broken out separately. The share price can be flat in its local currency and you’ll still show a gain or loss in your base currency from the FX swing. This is the standard treatment in most jurisdictions, but it’s worth knowing before you reconcile against a broker statement denominated in the asset’s currency.

------------------------------------------------------------------------

## 9 · Why not LIFO, weighted-average, or specific-identification?

FIFO is opinionated by design – but it’s the starting point, not the end state. **Additional cost-basis methods will be added in future versions.** The most-requested alternatives on the roadmap:

- **LIFO (last in, first out):** common in certain US tax strategies. Not implemented yet; planned for a future version.
- **Weighted-average / moving-average cost (WAC – called ACB in Canada, *gleitender Durchschnittspreis* in Austria/Germany):** several jurisdictions require a moving average rather than FIFO. Canada uses ACB by default; Austria taxes realized gains on a moving average. The “average cost” shown on a holding is *not* this method – it’s a display figure derived from your open FIFO lots, so after a partial sale it reflects the remaining lots rather than a running moving average. Until WAC ships, your Wealthfolio realized-gain numbers will diverge from a moving-average tax calculation, so you’ll need to reconcile manually in the meantime.
- **Specific identification:** picking which lots to close on each sale. Powerful for tax-loss harvesting, but adds a lot of UI complexity. Planned.

The honest answer: we’d rather ship FIFO well first and add the other methods in later versions than ship three half-finished accounting modes at once. Vote on what should come next in <a href="https://github.com/wealthfolio/wealthfolio/discussions" class="font-medium underline underline-offset-4">GitHub Discussions</a>.

------------------------------------------------------------------------

## 10 · Where to see your lots

Open any holding from the **Holdings** page. The asset detail view has a **Lots** tab that shows every open lot, its purchase date, original cost, and current unrealized gain/loss.

The same view powers the **realized vs. unrealized** breakdown on the Performance page.

------------------------------------------------------------------------

**Next step:** <a href="/docs/concepts/performance-metrics/" class="font-medium underline underline-offset-4">Performance Metrics</a> walks through how realized and unrealized gains combine into the TWR and MWR numbers on your dashboard.


<a href="/docs/concepts/activity-fields/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Activity Fields</a> <a href="/docs/concepts/performance-metrics/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Performance Metrics</a>


On this page

- <a href="#1--the-mental-model" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1 · The mental model</a>
- <a href="#2--fifo-first-in-first-out" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2 · FIFO: first in, first out</a>
- <a href="#3--how-activities-change-lots" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3 · How activities change lots</a>
- <a href="#4--worked-example-buy--split--sell" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">4 · Worked example: BUY → SPLIT → SELL</a>
  - <a href="#final-amounts-and-trade-costs" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Final amounts and trade costs</a>
- <a href="#5--transfers-preserve-cost-basis" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">5 · Transfers preserve cost basis</a>
- <a href="#6--drip-and-dividend-in-kind" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">6 · DRIP and dividend-in-kind</a>
- <a href="#7--fractional-shares" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">7 · Fractional shares</a>
- <a href="#8--cost-basis-and-currency" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">8 · Cost basis and currency</a>
- <a href="#9--why-not-lifo-weighted-average-or-specific-identification" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">9 · Why not LIFO, weighted-average, or specific-identification?</a>
- <a href="#10--where-to-see-your-lots" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">10 · Where to see your lots</a>


