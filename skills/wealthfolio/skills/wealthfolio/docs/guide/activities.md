> Source: https://wealthfolio.app/docs/guide/activities

Activities are the atomic events that drive your portfolio: every trade, dividend,
deposit, fee, and adjustment. This guide covers how to add them, edit them, and use the
subtypes that handle DRIP, staking, transfers, and option expiry cleanly.

For the conceptual model (what each type does to cash and holdings), see
[Activity Types](/docs/concepts/activity-types).

---

## 1 · Add an activity manually

1. **Activities** in the sidebar → **+ Add Manually** in the top right.
2. Pick the **category** (Trade, Cash, Income, Transfer, Adjustment).
3. Pick the **type** (BUY, SELL, DIVIDEND, etc.) and, where available, the **subtype**.
4. Fill the form. Required fields are marked.
5. **Add Activity.**

The form adapts to the activity type. You only see the fields that matter (no `unitPrice`
on a `DEPOSIT`, no `amount` on a plain `BUY`).

### Inline edit on the activities list

For quick fixes, toggle the **grid icon** in the top-right of the activities list. Click
any cell to edit; **✓** to save, **✗** to cancel. Useful for backfilling a missing fee or
correcting a quantity without opening the full edit sheet.

---

## 2 · Subactivities

Some activity types have subtypes that handle a multi-step real-world event with one
record. Wealthfolio expands them under the hood so cash and holdings update correctly.

### DRIP (Dividend Reinvestment)

Use **DIVIDEND** → subtype **DRIP**. Wealthfolio records:

- The dividend income (cash in, then cash out for the purchase; net zero on cash).
- A new lot opened at the DRIP price for the reinvested shares.

### Staking Reward

Use **INTEREST** → subtype **Staking Reward**. Wealthfolio records:

- The interest income at the token's value on that date.
- The token acquisition (new lot opened) for the reward amount.

### Dividend in Kind

Use **DIVIDEND** → subtype **Dividend in Kind**. For spin-offs and stock dividends.
Wealthfolio opens a lot in the new security at the cost basis you provide (from your
broker's notice).

### Option Expiry

Use **ADJUSTMENT** → subtype **Option Expiry**. Closes the option lot to zero and
realizes the premium paid as a loss. No cash changes hands.

### Credit subtypes (Bonus, Trading Rebate, Fee Refund)

Use **CREDIT** with the matching subtype. The subtype controls whether the credit counts
as new capital (Bonus) or as a cost reduction (Rebate / Refund).

Full reference: [Activity Type subtypes](/docs/concepts/activity-types#3--subtypes).

---

## 3 · Transfers between accounts

Cash and securities transfers between Wealthfolio accounts use a **pair** of activities:

1. `TRANSFER_OUT` on the **source** account: specify the symbol (or `$CASH-<CCY>`) and
   quantity / amount.
2. `TRANSFER_IN` on the **destination** account: same symbol and quantity / amount.

For securities transfers, the destination account inherits the source's cost basis, so
your gain/loss math stays correct. See
[How Transfers Work](/docs/concepts/activity-types#7--how-transfers-work).

### Same-day TRANSFER_OUT → TRANSFER_IN gotcha

If both activities are dated the same day, give the **OUT** an earlier timestamp than
the **IN**. Otherwise Wealthfolio may try to credit the destination before the lot
exists on the source side, and the OUT will silently fail to close any shares.

In the manual form: use the time field, not just the date.
In CSV: include the time in the `date` column (`2025-03-15T09:30:00`).

### Transferring from / to external accounts

If the other side isn't a Wealthfolio account, check the **External** flag on the
transfer form. The activity records a one-sided cash or asset move from / to an
untracked source.

- **External `TRANSFER_IN`:** seeds a position or cash from outside Wealthfolio.
  Provide the cost basis your broker reported. Useful for opening balances, gifts,
  inheritances, RSUs.
- **External `TRANSFER_OUT`:** removes a position or cash without recording a sale.
  Lots are closed via FIFO with no gain realised. Useful for crypto sent to a wallet
  you don't track, or writing off a worthless position.

### Transferring between two Wealthfolio accounts

Leave the **External** flag unchecked and pick the counterparty account. Wealthfolio
creates the matching `TRANSFER_OUT` / `TRANSFER_IN` pair and preserves the original
cost basis on the receiving side.

---

## 4 · Activity statuses

Each activity has a status that controls how it's used in calculations:

| Status      | What it means                                                                         |
| ----------- | ------------------------------------------------------------------------------------- |
| **Posted**  | The default; counted everywhere.                                                      |
| **Pending** | Broker-reported but incomplete (e.g. missing price on a DRIP). Excluded from metrics. |
| **Draft**   | You're staging this before commit. Hidden from totals.                                |
| **Void**    | Soft-deleted. Hidden everywhere, but the row remains so you can restore it.           |

The Connect importer uses `Pending` for activities that arrive partially specified. Fix
them up in Wealthfolio and bump them to `Posted` to make them count.

---

## 5 · Bulk edit and delete

Select multiple rows from the activities list (checkboxes on the left), then use the
bulk action menu:

- **Change account:** re-attribute the activities to a different account.
- **Change status:** set Posted / Pending / Draft / Void.
- **Delete:** removes the activities. Wealthfolio asks for confirmation first — the
  action is permanent, so double-check the selection before clicking.

Bulk-changing the type isn't supported. Wealthfolio doesn't know which fields to
preserve.

---

## 6 · CSV import (summary)

The CSV import flow is a separate guide because there's a lot to cover (broker recipes,
column mapping, troubleshooting): see [CSV Import](/docs/guide/csv-import).

The 30-second version:

1. **Activities → Import → Drop CSV file**.
2. Map columns and activity types.
3. Preview, confirm.

Mappings are saved per account; second import is one click.

```csv
date,symbol,quantity,activityType,unitPrice,currency,fee,amount
2024-01-01T15:02:36.329Z,MSFT,1,DIVIDEND,57.5,USD,0,57.5
2023-12-15T15:02:36.329Z,MSFT,30,BUY,368.60,USD,0,
2023-08-11T14:55:30.863Z,$CASH-USD,1,DEPOSIT,1,USD,0,600.03
```

**About the amount field:** for cash activities (`DIVIDEND`, `DEPOSIT`, `WITHDRAWAL`,
`TAX`, `FEE`, `INTEREST`, `TRANSFER_IN`, `TRANSFER_OUT`), `amount` is mandatory.
`quantity` and `unitPrice` are ignored.

<MdxVideo
  src="https://assets.wealthfolio.app/videos/import-csv.mp4"
  width="800"
  height="404"
  alt="CSV Import Demo"
/>

---

## 7 · Editing and deleting

- **Edit:** click any activity in the list to open the edit sheet. Synced (Connect)
  activities can't be edited directly. Add an `ADJUSTMENT` instead.
- **Delete:** click an activity → ⋯ menu → **Delete**. Wealthfolio asks for
  confirmation; deletion is permanent. If you want to keep the row but exclude it
  from calculations, set its **Status** to `Void` instead.
- **Backdated activities:** there's no restriction on inserting activities into the
  past. Wealthfolio recalculates all balances forward from the inserted date.

---

**Next step:** [Activity Types](/docs/concepts/activity-types) is the full reference for
every type, subtype, and the rules that govern them.
