> Source: https://wealthfolio.app/docs/concepts/activity-types

Activities are the atomic events that drive portfolio state in Wealthfolio—every trade, cash
movement, fee, or corporate action is recorded as an **activity**. Accurate performance,
cash-flow, and tax reporting all start with choosing the right activity type.

---

## 1 · Activity Types at a Glance

| Type               | Typical Use Case                                 | Cash Impact          | Holdings Impact             |
| ------------------ | ------------------------------------------------ | -------------------- | --------------------------- |
| **BUY**            | Purchase a security.                             | ↓ cash               | ↑ quantity                  |
| **SELL**           | Sell a security you hold.                        | ↑ cash               | ↓ quantity                  |
| **SPLIT**          | Stock split or reverse split.                    | —                    | qty & unit cost adjusted    |
| **DIVIDEND**       | Cash dividend on a security.                     | ↑ cash               | —                           |
| **INTEREST**       | Interest on cash or fixed-income.                | ↑ cash               | —                           |
| **CREDIT**         | Cash credit (bonus, rebate, refund).             | ↑ cash               | —                           |
| **DEPOSIT**        | Funds added from outside Wealthfolio.            | ↑ cash               | —                           |
| **WITHDRAWAL**     | Funds sent to an external account.               | ↓ cash               | —                           |
| **TRANSFER_IN**    | Move cash or securities **into** this account. With the **External** flag, also covers opening balances, gifts, and inheritances.   | ↑ cash or ↑ quantity | ↑ quantity (for securities) |
| **TRANSFER_OUT**   | Move cash or securities **out of** this account. With the **External** flag, also covers write-offs and crypto sent to untracked wallets. | ↓ cash or ↓ quantity | ↓ quantity (for securities) |
| **FEE**            | Standalone brokerage or platform fee.            | ↓ cash               | —                           |
| **TAX**            | Tax deducted from the account.                   | ↓ cash               | —                           |
| **ADJUSTMENT**     | Non-trade correction (see subtypes).             | Depends on subtype   | Depends on subtype          |

---

## 2 · Activity Types in Detail

### Trading Activities

| Type      | What It Does                                                                                                 | Cash Impact                                         | Holdings Impact                                               |
| --------- | ------------------------------------------------------------------------------------------------------------ | --------------------------------------------------- | ------------------------------------------------------------- |
| **BUY**   | Purchase a security (stock, ETF, bond, crypto, option, etc.).                                                | Cash decreases by total cost (qty x price + fees)   | Position quantity increases; a new cost-basis lot is created  |
| **SELL**  | Sell a security you hold.                                                                                    | Cash increases by net proceeds (qty x price - fees) | Position quantity decreases (oldest lots sold first via FIFO) |
| **SPLIT** | Record a stock split or reverse split. Adjusts share count and per-share cost so total value stays the same. | No change                                           | Quantity and unit cost adjusted; total cost basis unchanged   |

### Income Activities

| Type         | What It Does                                                              | Cash Impact                       | Holdings Impact |
| ------------ | ------------------------------------------------------------------------- | --------------------------------- | --------------- |
| **DIVIDEND** | Cash dividend paid on a security you hold.                                | Cash increases by dividend amount | No change       |
| **INTEREST** | Interest earned on cash balances or fixed-income holdings.                | Cash increases by interest amount | No change       |
| **CREDIT**   | A cash credit applied to your account (see subtypes below for specifics). | Cash increases by credit amount   | No change       |

### Cash Flow Activities

| Type           | What It Does                                                                                 | Cash Impact    | Holdings Impact |
| -------------- | -------------------------------------------------------------------------------------------- | -------------- | --------------- |
| **DEPOSIT**    | Money you add to your brokerage account from an external source (bank transfer, wire, etc.). | Cash increases | No change       |
| **WITHDRAWAL** | Money you take out of your brokerage account to an external destination.                     | Cash decreases | No change       |

### Transfer Activities

Transfers come in two flavors, controlled by an **External** flag on the activity:

- **Internal** (External unchecked): paired with a matching activity on another
  Wealthfolio account. Cost basis travels between accounts. No new capital enters
  or leaves your tracked portfolio.
- **External** (External checked): one-sided. The other side of the move lives
  outside Wealthfolio. Used for opening balances, gifts/inheritances received,
  RSUs vested, write-offs, crypto sent to untracked wallets, etc.

| Type             | What It Does                                                                                                                                                                                                   | Cash Impact                | Holdings Impact                              |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- | -------------------------------------------- |
| **TRANSFER_IN**  | Move cash or securities **into** this account. Internal: paired with `TRANSFER_OUT` from another Wealthfolio account, cost basis preserved. External: opens a new lot at the cost basis you provide.            | Cash or position increases | Position quantity increases (for securities) |
| **TRANSFER_OUT** | Move cash or securities **out of** this account. Internal: cost basis exported to the destination Wealthfolio account. External: lots closed via FIFO with no gain realised (the asset leaves your portfolio). | Cash or position decreases | Position quantity decreases (for securities) |

### Expense Activities

| Type    | What It Does                                                                                                                | Cash Impact    | Holdings Impact |
| ------- | --------------------------------------------------------------------------------------------------------------------------- | -------------- | --------------- |
| **FEE** | A stand-alone brokerage or platform fee not tied to a specific trade (e.g., annual account fee, custody fee, advisory fee). | Cash decreases | No change       |
| **TAX** | A tax charge deducted from your account (e.g., dividend withholding tax, capital gains tax).                                | Cash decreases | No change       |

### Position Adjustment Activities

| Type           | What It Does                                                  | Cash Impact        | Holdings Impact    |
| -------------- | ------------------------------------------------------------- | ------------------ | ------------------ |
| **ADJUSTMENT** | A non-trade correction or transformation (see subtypes below). | Depends on subtype | Depends on subtype |

---

## 3 · Subtypes

Some activity types have **subtypes** that provide more specific behavior. When you select a subtype, Wealthfolio automatically handles the underlying mechanics for you.

### Dividend Subtypes

| Subtype                          | Parent Type | What It Does                                                                                                                                           | Example                                                                                            |
| -------------------------------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------- |
| **DRIP** (Dividend Reinvestment) | DIVIDEND    | Dividend is automatically reinvested to buy more shares of the same security. Wealthfolio records both the dividend income and the resulting purchase. | You own 100 shares of AAPL. A $50 dividend is paid and automatically used to buy 0.25 more shares. |
| **Dividend in Kind**             | DIVIDEND    | Dividend paid as shares of a different security rather than cash (e.g., a spinoff).                                                                    | A company spins off a division and you receive shares of the new company as a dividend.            |

### Interest Subtypes

| Subtype            | Parent Type | What It Does                                                                                                                      | Example                                                    |
| ------------------ | ----------- | --------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **Staking Reward** | INTEREST    | Crypto staking income received as additional tokens. Wealthfolio records the interest income and the resulting token acquisition. | You stake 10 ETH and receive 0.05 ETH as a staking reward. |

### Credit Subtypes

| Subtype            | Parent Type | What It Does                                                     | Counts as New Capital? | Example                                                |
| ------------------ | ----------- | ---------------------------------------------------------------- | ---------------------- | ------------------------------------------------------ |
| **Bonus**          | CREDIT      | An external cash credit like a sign-up bonus or referral reward. | Yes (like a deposit)   | Your broker gives you a $100 welcome bonus.            |
| **Trading Rebate** | CREDIT      | A rebate on trading costs (e.g., maker rebate, volume discount). | No (reduces costs)     | You receive a $5 maker rebate for providing liquidity. |
| **Fee Refund**     | CREDIT      | A reversal or correction of a previously charged fee.            | No (reverses a cost)   | Your broker refunds an erroneous $25 service charge.   |

### Adjustment Subtypes

| Subtype           | Parent Type | What It Does                                                                           | Example                                                                                                                |
| ----------------- | ----------- | -------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **Option Expiry** | ADJUSTMENT  | Removes a worthless expired option contract from your holdings. No cash changes hands. | Your call option on TSLA expires out of the money. The position is removed and the premium paid is realized as a loss. |

---

## 4 · Quick-Start Cheat-Sheet

| Scenario                           | Recommended Activities                                         | Why                                                            |
| ---------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------- |
| **Setting up for the first time**  | External `TRANSFER_IN` for each position + `DEPOSIT` for cash  | Fastest way to seed your current portfolio snapshot            |
| **Day-to-day trading**             | `BUY`, `SELL`, `DIVIDEND`, `INTEREST`                          | Full profit/loss tracking and cash reconciliation              |
| **Moving between accounts**        | `TRANSFER_OUT` from source + `TRANSFER_IN` to destination       | Preserves cost basis; avoids phantom gains or losses           |
| **Standalone charges**             | `FEE` for account fees, `TAX` for tax deductions               | Keeps expenses explicit and separate from trades               |
| **Received a gift or inheritance** | External `TRANSFER_IN`                                         | Records the position without implying a purchase               |
| **Writing off a worthless stock**  | External `TRANSFER_OUT`                                        | Removes the position without needing sale proceeds             |
| **Stock split (e.g., 4-for-1)**    | `SPLIT`                                                        | Adjusts quantity and per-share cost; total value unchanged     |
| **Dividend reinvestment (DRIP)**   | `DIVIDEND` with DRIP subtype                                   | Automatically records both the dividend and the share purchase |
| **Crypto staking rewards**         | `INTEREST` with Staking Reward subtype                         | Records token income and acquisition in one step               |
| **Broker sign-up bonus**           | `CREDIT` with Bonus subtype                                    | Tracks the bonus as new capital entering your portfolio        |
| **Option expired worthless**       | `ADJUSTMENT` with Option Expiry subtype                        | Cleanly removes the position and realizes the loss             |
| **Fee refund from broker**         | `CREDIT` with Fee Refund subtype                               | Reverses the fee without inflating your capital contributions  |

---

## 5 · Workflow Styles

### Simple (Holdings-Only)

- Use External `TRANSFER_IN` / `TRANSFER_OUT` to set up your current positions.
- Adjust cash once with `DEPOSIT` / `WITHDRAWAL`.
- **Good for:** Quick onboarding, backfilling missing history, or when you only care about tracking portfolio value over time.

### Full (Transaction-Level)

1. Seed each account with a `DEPOSIT`.
2. Record every `BUY`, `SELL`, `DIVIDEND`, `INTEREST`.
3. Mirror transfers between accounts with `TRANSFER_IN` / `TRANSFER_OUT`.
4. Log ad-hoc expenses via `FEE` and `TAX`.

- **Good for:** Precise time-weighted and money-weighted returns, cash-flow analysis, and tax reporting.

You can freely mix the two styles — for example, backfill long-held shares with an External `TRANSFER_IN`, then switch to `BUY`/`SELL` going forward.

---

## 6 · How Fees Work

Fees can be recorded in two ways, depending on the situation:

| Method                      | When to Use                                                               | How It Works                                                                                                                                 |
| --------------------------- | ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| **Inline fee on a trade**   | The fee is part of a BUY or SELL order                                    | Add the fee amount directly on the BUY/SELL activity. For buys, the fee increases your cost basis. For sells, the fee reduces your proceeds. |
| **Standalone FEE activity** | The fee is not tied to a specific trade (account fee, advisory fee, etc.) | Create a separate `FEE` activity. Cash is reduced by the fee amount.                                                                         |

<Callout icon="!" type="warning">
  **Never double-count fees.** If your broker statement shows a $10 commission on a BUY order,
  either include it as the fee on the BUY activity *or* create a separate FEE activity — not both.
</Callout>

---

## 7 · How Transfers Work

Transfers come in two flavors:

### Cash Transfers

Record a `TRANSFER_OUT` on the source account and a `TRANSFER_IN` on the destination account for the same amount. No security/symbol is needed.

### Securities Transfers

When you transfer a stock or other holding between accounts, Wealthfolio preserves the original cost basis:

1. `TRANSFER_OUT` on the source account (specify the security and quantity)
2. `TRANSFER_IN` on the destination account (same security and quantity)

The receiving account inherits the original purchase cost, so your gain/loss calculations remain accurate.

<Callout icon="i" type="info">
  **Tip:** If the transfer is from an external source (not another Wealthfolio account), a
  `TRANSFER_IN` by itself is fine — you don't need a matching `TRANSFER_OUT`.
</Callout>

---

## 8 · Key Rules & Gotchas

| Topic                          | What to Know                                                                                                                                     | Why It Matters                                                                 |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| **Lot selection**              | FIFO (First In, First Out) is the default method. When you sell, the oldest shares are sold first.                                               | Affects your realized profit/loss and tax calculations.                        |
| **Fractional shares**          | Quantities support up to eight decimal places.                                                                                                   | You can accurately track fractional share purchases and crypto holdings.       |
| **Retroactive entries**        | Activities can be inserted for any past date — Wealthfolio recalculates all balances automatically.                                              | You can backfill historical trades at any time without breaking anything.      |
| **Multi-currency**             | Currency conversion uses the exchange rate on the trade date.                                                                                    | Keeps cross-currency returns and cash balances matching your broker statement. |
| **Options multiplier**         | For options, the price is per-share but each contract covers multiple shares (typically 100). The multiplier is applied automatically.           | Ensures correct cost basis for option positions.                               |
| **Inline fees vs. standalone** | `BUY`/`SELL` can include an inline fee, or you can log a separate `FEE`. Never do both for the same charge.                                      | Avoids double-counting expenses.                                               |
| **CSV import format**          | CSV files must be UTF-8 encoded with ISO-8601 dates (`2025-03-15`), decimal points (not commas), and headers matching the expected column names. | Prevents import errors.                                                        |

---

**Next step:** Import or create activities manually or via CSV uploader, then view the timeline
in the **Activities** tab to verify that cash and positions reconcile as expected.
