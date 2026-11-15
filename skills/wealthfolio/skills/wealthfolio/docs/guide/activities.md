> Source: https://wealthfolio.app/docs/guide/activities



Docs


Add Activities


# Add Activities

Manual entry, CSV import, editing, subtypes, short trades, transfers, and the full activity lifecycle.


Last updated November 12, 2026

Activities are the atomic events that drive your portfolio: every trade, dividend, deposit, fee, and adjustment. This guide covers how to add them, edit them, and use the subtypes and trade intents that handle DRIP, staking, short positions, options, transfers, and option expiry cleanly.

For the conceptual model (what each type does to cash and holdings), see <a href="/docs/concepts/activity-types/" class="font-medium underline underline-offset-4">Activity Types</a>.

------------------------------------------------------------------------

## 1 · Add an activity manually

1.  **Activities** in the sidebar → **Add Activities** in the top right → **Add Transaction**.
2.  Pick the **category** (Trade, Cash, Income, Transfer, Adjustment).
3.  Pick the **type** (BUY, SELL, DIVIDEND, etc.) and, where available, the **subtype** or trade intent.
4.  Fill the form. Required fields are marked.
5.  **Add Activity.**

The form adapts to the activity type. For a trade, check the **final amount** against your statement. The suggested total includes the quantity, price, asset multiplier, fee, and tax. You can enter a different total when your statement requires it. For a cash activity, enter the final cash paid or received. For a dividend or interest payment, enter the amount before tax and the withholding tax: see <a href="#dividends-and-interest" class="font-medium underline underline-offset-4">Dividends and interest</a>.

See <a href="/docs/concepts/activity-fields/" class="font-medium underline underline-offset-4">Activity Fields</a> for what each field means.

### Inline edit on the activities list

For quick fixes, toggle the **grid icon** in the top-right of the activities list. Click any cell to edit; **✓** to save, **✗** to cancel. Useful for backfilling a missing fee or correcting a quantity without opening the full edit sheet.

After changing quantity, price, fee, or tax, check the final amount before saving. A custom total stays under your control in the form until you choose to use the calculated total again. Changing a currency label does not convert the entered numbers.

------------------------------------------------------------------------

## 2 · Subtypes and trade intents

Most activity types are direct: choose the type, fill the amount or quantity/price, and save. A few real-world events need a subtype or trade intent so Wealthfolio can apply the right accounting.


| If you need to log… | Use this in Wealthfolio | Key fields / gotchas |
|----|----|----|
| Normal stock/ETF/crypto buy | **BUY** | Symbol, quantity, unit price, currency, optional fee. Opens a long lot. |
| Normal sell from an existing long | **SELL** | Closes long lots FIFO. A plain sell does not open a short if you oversell. **Sell all** fills in the whole position. |
| Sell short stock/ETF | **SELL** → **Sell Short** | Opens a signed short lot. If you are currently long, split the trade first. |
| Buy to cover stock/ETF short | **BUY** → **Buy to Cover** | Reduces the oldest short lot first. Do not include excess quantity as cover. |
| Buy to open an option | **BUY** + asset **Option** + **Open** | Flip the asset toggle to **Option**, then fill Call/Put, strike, expiration. Multiplier auto-applied. |
| Sell / write a call or put to open | **SELL** + asset **Option** + **Open** | The step people miss: switch the asset toggle to **Option**. Covered calls, cash-secured puts, naked shorts. |
| Close an option | **BUY** or **SELL** + asset **Option** + **Close** | Buy to Close for short options, Sell to Close for long options. |
| Cash dividend or interest | **DIVIDEND** or **INTEREST** | Enter the **Amount before tax** and **Withholding tax**; the form works out the **Received amount**. |
| Dividend reinvestment | **DIVIDEND** → **DRIP** | Fill dividend amount, reinvested quantity, and reinvestment price. |
| Staking reward | **INTEREST** → **Staking Reward** | Fill token quantity and fair market value at receipt. |
| Bond coupon | **INTEREST** on the bond symbol | Select the bond in the optional Symbol field; income is attributed to the bond and included in total return. |
| Stock dividend in the same asset | **DIVIDEND** → **Dividend in Kind** | Use for additional units of the same asset; true spin-offs need a separate activity. |
| Option expired worthless | **ADJUSTMENT** → **Option Expiry** | Removes the option lot with no cash movement. |
| Fund switch, share class | **Fund conversion** | Same account and day, no fee. The new units keep the old ones’ cost and purchase dates; nothing is sold. |
| Bonus, rebate, refund, reimbursement | **CREDIT** with the matching credit subtype | Bonus counts as new capital; rebate/refund/reimbursement reduce costs instead. |


### Dividends and interest

For a cash dividend, a return of capital, or interest you receive, the form asks for the **Amount before tax** and the **Withholding tax** from your statement, and works out the **Received amount**. If your statement shows only the amount after tax, type it into **Received amount** instead, and the amount before tax is worked out. Wealthfolio saves the received amount as the activity’s amount and the withholding as its tax. This works the same on desktop and phones.

DRIP, Dividend in Kind, Staking Reward, and interest charged on a credit card keep their own fields.

### DRIP (Dividend Reinvestment)

Use **DIVIDEND** → subtype **DRIP**. Fill the dividend amount, reinvested share quantity, and reinvestment price. Wealthfolio records:

- The dividend income and matching purchase. They cancel in the same currency when no FX rate is supplied.
- A new lot for the reinvested shares, using the saved reinvested amount as its cost.

For a reinvestment in a different currency from your account, a supplied FX rate can change two cash balances. If the broker did not convert currencies, leave the rate blank. This also applies to staking rewards and dividends in kind. See the <a href="/docs/concepts/activity-fields/#reinvestments-and-fx-rates" class="font-medium underline underline-offset-4">reinvestment FX note</a>.

### Staking Reward

Use **INTEREST** → subtype **Staking Reward**. Fill the token quantity and fair market value at receipt. Wealthfolio records:

- The interest income at the token’s value on that date.
- The token acquisition (new lot opened), using the saved reward amount as its cost.

### Dividend in Kind

Use **DIVIDEND** → subtype **Dividend in Kind** for stock dividends paid as additional units of the same asset. Wealthfolio records the dividend income and opens a lot at the cost basis you provide from the broker notice.

For a true spin-off into a different ticker, record the received security as an External `TRANSFER_IN` using the broker-reported cost basis.

### Stock/ETF Short Positions

Use **SELL** → **Sell Short** to open or increase a short. Use **BUY** → **Buy to Cover** to reduce or close it.

Plain **SELL** is intentionally conservative: if you sell more than you hold, Wealthfolio does not automatically open a short. If a single broker trade flips from long to short, split it into two activities: a normal **SELL** for the long quantity, then **Sell Short** for the remainder.

To sell everything an account holds, use **Sell all** beside **Quantity** on the Sell form, on desktop or phone. It fills in the account’s whole position. It isn’t shown for **Sell Short** or for options.

### Options (calls & puts)

Options have first-class support in the Add Activity form. The step people miss is that you first choose **Buy** or **Sell**, then flip the **asset toggle from Stock to Option** – that’s what swaps the stock fields for the option contract fields (Call/Put, strike, expiration) and a **Position** toggle. If you never flip that toggle, you only ever see the stock form, which is why it can look like options aren’t supported.

The mental model: **Buy vs Sell** = the direction of your order. **Open vs Close** = whether you’re entering a new contract or exiting one you already hold. Wealthfolio combines the two into the intent shown on the submit button.


| What you did (broker language) | In Wealthfolio | Submit button reads |
|----|----|----|
| **Buy to Open** a call or put (BTO) | **Buy** + asset **Option** + **Open** | Buy to Open |
| **Sell to Open** / write a call or put (STO) | **Sell** + asset **Option** + **Open** | Sell to Open |
| **Buy to Close** a written option (BTC) | **Buy** + asset **Option** + **Close** | Buy to Close |
| **Sell to Close** a long option (STC) | **Sell** + asset **Option** + **Close** | Sell to Close |


**Selling a call or put to open (writing options) is `Sell` + asset `Option` + position `Open`.** That single combination covers covered calls, cash-secured puts, and any naked short option – you collect the premium as a credit and open a short option lot.

#### Step by step: write (sell to open) a call or put

1.  **Activities → Add Activities → Add Transaction.**
2.  Pick the **Sell** activity type.
3.  Under **Asset & Account**, switch the asset toggle from **Stock** to **Option**.
4.  In **Option Contract**, search the symbol (type a ticker, an option contract, or paste an OCC symbol), pick **Call** or **Put**, and set the **Strike Price** and **Expiration**. Wealthfolio shows the resolved contract (e.g. `Dec 19 $150 CALL`).
5.  Choose the account, then in the **Trade** section set **Position** to **Open**.
6.  Enter the number of **Contracts** and the **Premium/Share**. Add any **Fee** / **Tax**.
7.  Confirm with the button – it reads **Sell to Open** – and Wealthfolio records the credit.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/docs/activities/activity-sell-to-open.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Add Activity form with Sell selected, the asset toggle set to Option, a Call contract with strike and expiration, and Position set to Open" /> <img src="https://assets.wealthfolio.app/images/screenshots/docs/activities/activity-sell-to-open-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Add Activity form with Sell selected, the asset toggle set to Option, a Call contract with strike and expiration, and Position set to Open" />
<figcaption>Sell + asset Option + Position Open = Sell to Open: writing an AAPL Dec 19 $150 call for $1.25/share premium</figcaption>
</figure>

Enter the **Premium/Share** *per share* (e.g. `1.25`), not the `$125` total. Wealthfolio applies the **asset’s contract multiplier** (usually 100) and suggests the final total. For 1 contract at `$1.25`, that is a `$125.00` credit before fees and taxes. Check the final amount against your statement. The multiplier field sets up a new asset; it does not override the multiplier of an existing asset.

Closing later is the mirror image: **Buy** + asset **Option** + **Close** (Buy to Close) to buy the contract back, or let it expire (below).

#### Buying options to open

Going long a call or put is **Buy** + asset **Option** + **Open** (Buy to Open) – you pay the premium as a debit. Close it later with **Sell** + asset **Option** + **Close** (Sell to Close). Same contract fields, multiplier, and per-share premium rules apply.

#### When an option expires worthless

Use **ADJUSTMENT** → subtype **Option Expiry**. It closes the option lot to zero with no cash movement – the premium is realized (a loss for a long option you paid for, or the full premium kept as gain for a short option you wrote). Use this instead of a Buy/Sell to Close when nothing traded because the contract simply expired.

#### When an option is assigned or exercised

Assignment/exercise is two events: the option contract goes away and shares change hands. Record them as two activities:

1.  Close the option leg – **Option Expiry** (ADJUSTMENT) removes the contract, or a **Close Position** trade if your broker showed a closing price.
2.  Record the resulting stock trade at the **strike price**: a **BUY** if you were assigned on a short put or exercised a long call, a **SELL** if assigned on a short call or exercised a long put.

#### Importing options from a broker CSV

If your broker’s CSV uses **BTO / STO / BTC / STC** (or “Buy to Open”, “Sell to Open”, etc.) labels, map them to the matching type + intent in the activity type/subtype mapping step of the import. See <a href="/docs/guide/csv-import/" class="font-medium underline underline-offset-4">CSV Import</a>.

### Fund conversion

Choose **Fund conversion** to record units of one fund becoming units of another in the same account. Pick the account and date, then the fund and quantity that leave under **From** and the fund and quantity that arrive under **To**. Wealthfolio saves two linked rows, **Conversion Out** and **Conversion In**; editing, duplicating, or deleting either one changes both. For a *traspaso*, use the day the new units arrive. See <a href="/docs/concepts/activity-types/#fund-conversions" class="font-medium underline underline-offset-4">Fund Conversions</a> for the rules.

### Credit subtypes (Bonus, Trading Rebate, Fee Refund, Reimbursement)

Use **CREDIT** with the matching subtype. The subtype controls whether the credit counts as new capital (Bonus) or as a cost reduction (Rebate / Refund / Reimbursement).

Full reference: <a href="/docs/concepts/activity-types/#3--subtypes" class="font-medium underline underline-offset-4">Activity Type subtypes</a>.

------------------------------------------------------------------------

## 3 · Transfers between accounts

Cash and securities transfers between Wealthfolio accounts use a **pair** of activities:

1.  `TRANSFER_OUT` on the **source** account: specify the symbol (or `$CASH-<CCY>`) and quantity / amount.
2.  `TRANSFER_IN` on the **destination** account: same symbol and quantity / amount.

For securities transfers, the destination account inherits the source’s cost basis, so your gain/loss math stays correct. See <a href="/docs/concepts/activity-types/#7--how-transfers-work" class="font-medium underline underline-offset-4">How Transfers Work</a>.

### Same-day TRANSFER_OUT → TRANSFER_IN gotcha

If both activities are dated the same day, give the **OUT** an earlier timestamp than the **IN**. Otherwise Wealthfolio may try to credit the destination before the lot exists on the source side, and the OUT will silently fail to close any shares.

In the manual form: use the time field, not just the date. In CSV: include the time in the `date` column (`2025-03-15T09:30:00`).

### Transferring from / to external accounts

If the other side isn’t a Wealthfolio account, check the **External** flag on the transfer form. The activity records a one-sided cash or asset move from / to an untracked source.

- **External `TRANSFER_IN`:** seeds a position or cash from outside Wealthfolio. Provide the cost basis your broker reported. Useful for opening balances, gifts, inheritances, RSUs.
- **External `TRANSFER_OUT`:** removes a position or cash without recording a sale. Lots are closed via FIFO with no gain realised. Useful for crypto sent to a wallet you don’t track, or writing off a worthless position.

### Transferring between two Wealthfolio accounts

Leave the **External** flag unchecked and pick the counterparty account. Wealthfolio creates the matching `TRANSFER_OUT` / `TRANSFER_IN` pair and preserves the original cost basis on the receiving side.

To pair a transfer that isn’t linked yet, choose **Link transfer…** in its row menu and pick the other side from the suggested matches or a search. The sheet shows the activity beside the selected match and points out the fields that differ.

### Match transfers

When the two sides of a transfer were recorded separately, for example by an import or broker sync, link them on **Match transfers**. On desktop, open it from **Activities → Add Activities → Match transfers**. The Health Center’s **Incomplete transfer detected** issue opens it too, with **Review transfers**.

- **Ready to link** lists pairs that match exactly on the same day. **Link all N pairs** links them all.
- **Needs a look** groups the rest by reason, such as **Arrived on a different day** or **No other side found**. Each row has **Link**, **Mark as external**, **Find match**, or **Skip**.

### Turn a deposit or withdrawal into a transfer

If a deposit or withdrawal is really money moving between two of your accounts, choose **Make it a transfer…** in its row menu, on the Activities or Spending page. Pick the matching activity in the other account from the suggestions or a search, or choose **Create it in another account**, then **Convert to transfer**. The two rows become a linked transfer.

To change only the row’s type, open it and use **Change to Transfer In** or **Change to Transfer Out** (and **Change to Deposit** or **Change to Withdrawal** to go back). The amount, date, account, notes, and category are kept. A row changed into a transfer is marked external; use **Link transfer…** to pair it with another account. A linked transfer has to be unlinked with **Unlink transfer** before it can change back.

------------------------------------------------------------------------

## 4 · Activity statuses

Each activity has a status that controls how it’s used in calculations:


| Status | What it means |
|----|----|
| **Posted** | The default; counted everywhere. |
| **Pending** | Broker-reported but incomplete (e.g. missing price on a DRIP). Excluded from metrics. |
| **Draft** | You’re staging this before commit. Hidden from totals. |
| **Void** | Soft-deleted. Hidden everywhere, but the row remains so you can restore it. |


### Needs review

**Needs review** is a separate flag, not a status. A Posted activity with this flag still affects your balances. Draft, Pending, and Void activities do not count.

Open **Activities → Needs review**, compare each flagged row with your statement, and confirm the type, asset, currency, and final amount. An incomplete imported cash amount can leave the activity as Draft. Complete its details and set it to Posted when ready. Clearing the review flag alone does not change its status.

After the 3.8 upgrade, some older activities may need review because their saved total could not be checked or because fees were previously applied differently. See <a href="/changelog/3_8_0/" class="font-medium underline underline-offset-4">the migration notes</a>.

------------------------------------------------------------------------

## 5 · Bulk edit and delete

Select multiple rows from the activities list (checkboxes on the left), then use the bulk action menu:

- **Change account:** re-attribute the activities to a different account.
- **Change status:** set Posted / Pending / Draft / Void.
- **Delete:** removes the activities. Wealthfolio asks for confirmation first – the action is permanent, so double-check the selection before clicking.

Bulk-changing the type isn’t supported. Wealthfolio doesn’t know which fields to preserve.

------------------------------------------------------------------------

## 6 · CSV import (summary)

The CSV import flow is a separate guide because there’s a lot to cover (broker recipes, column mapping, troubleshooting): see <a href="/docs/guide/csv-import/" class="font-medium underline underline-offset-4">CSV Import</a>.

The 30-second version:

1.  **Activities → Import → Drop CSV file**.
2.  Map columns and activity types.
3.  Preview, confirm.

Mappings are saved per account; second import is one click.

``` mb-4
date,symbol,quantity,activityType,unitPrice,currency,fee,amount
2024-01-01T15:02:36.329Z,MSFT,1,DIVIDEND,57.5,USD,0,57.5
2023-12-15T15:02:36.329Z,MSFT,30,BUY,368.60,USD,0,
2023-08-11T14:55:30.863Z,$CASH-USD,1,DEPOSIT,1,USD,0,600.03
```

**About the amount field:** use the final total, with fees and taxes already applied. Missing trade totals can be calculated during import. Plain cash and income rows need an amount; quantity and price are not a substitute. Security transfers move shares, while DRIP, staking, and in-kind income also use quantity and price. See the <a href="/docs/guide/csv-import/" class="font-medium underline underline-offset-4">CSV Import guide</a> for the full rules.


Your browser does not support HTML5 video. Here is a <a href="https://assets.wealthfolio.app/videos/import-csv.mp4" data-astro-cid-4itgdthg="">link to the video</a> instead.


------------------------------------------------------------------------

## 7 · Editing and deleting

- **Edit:** click any activity in the list to open the edit sheet. Synced activities can also be corrected; user changes are tracked so broker sync can protect them. Check the final amount and review flag before saving.
- **Delete:** click an activity → ⋯ menu → **Delete**. Wealthfolio asks for confirmation; deletion is permanent. If you want to keep the row but exclude it from calculations, set its **Status** to `Void` instead.
- **More details:** click an activity → ⋯ menu → **More details** to see its details. When an import or add-on supplies labelled fee and tax lines, such as commission and stamp duty, they’re listed under the fee and tax. They don’t change any calculation.
- **Backdated activities:** there’s no restriction on inserting activities into the past. Wealthfolio recalculates all balances forward from the inserted date.

------------------------------------------------------------------------

**Next step:** <a href="/docs/concepts/activity-types/" class="font-medium underline underline-offset-4">Activity Types</a> is the full reference for every type, subtype, and the rules that govern them.


<a href="/docs/guide/dashboards/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Dashboards</a> <a href="/docs/guide/assets/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Assets &amp; Securities</a>


On this page

- <a href="#1--add-an-activity-manually" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1 · Add an activity manually</a>
  - <a href="#inline-edit-on-the-activities-list" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Inline edit on the activities list</a>
- <a href="#2--subtypes-and-trade-intents" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2 · Subtypes and trade intents</a>
  - <a href="#dividends-and-interest" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Dividends and interest</a>
  - <a href="#drip-dividend-reinvestment" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">DRIP (Dividend Reinvestment)</a>
  - <a href="#staking-reward" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Staking Reward</a>
  - <a href="#dividend-in-kind" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Dividend in Kind</a>
  - <a href="#stocketf-short-positions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Stock/ETF Short Positions</a>
  - <a href="#options-calls--puts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Options (calls &amp; puts)</a>
  - <a href="#fund-conversion" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Fund conversion</a>
  - <a href="#credit-subtypes-bonus-trading-rebate-fee-refund-reimbursement" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Credit subtypes (Bonus, Trading Rebate, Fee Refund, Reimbursement)</a>
- <a href="#3--transfers-between-accounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3 · Transfers between accounts</a>
  - <a href="#same-day-transfer_out--transfer_in-gotcha" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Same-day TRANSFER_OUT → TRANSFER_IN gotcha</a>
  - <a href="#transferring-from--to-external-accounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Transferring from / to external accounts</a>
  - <a href="#transferring-between-two-wealthfolio-accounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Transferring between two Wealthfolio accounts</a>
  - <a href="#match-transfers" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Match transfers</a>
  - <a href="#turn-a-deposit-or-withdrawal-into-a-transfer" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Turn a deposit or withdrawal into a transfer</a>
- <a href="#4--activity-statuses" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">4 · Activity statuses</a>
  - <a href="#needs-review" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Needs review</a>
- <a href="#5--bulk-edit-and-delete" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">5 · Bulk edit and delete</a>
- <a href="#6--csv-import-summary" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">6 · CSV import (summary)</a>
- <a href="#7--editing-and-deleting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">7 · Editing and deleting</a>


