> Source: https://wealthfolio.app/docs/concepts

## Account

| Field | Purpose |
|-------|---------|
| **Name** | Display label |
| **Group** | Collapses similar accounts (e.g. *RRSP*) |
| **Type** | *Securities · Cash · Crypto* |
| **Currency** | FX source for the account |
| **Default? / Active?** | Workflow helpers |

## Activity

All portfolio changes resolve into one of these actions.

| Type | Cash Δ | Holdings Δ | Notes |
|------|--------|------------|-------|
| **BUY**  | − | + | Fee optional |
| **SELL** | + | − | Gain tracked |
| **DIVIDEND** | + | 0 | Cash income |
| **INTEREST** | + | 0 | Cash income |
| **DEPOSIT / WITHDRAWAL** | ± | 0 | Cash only |
| **TRANSFER_IN / OUT** | ± | ± | Internal keeps cost basis; External seeds/removes positions (opening balances, gifts, write-offs) |
| **FEE / TAX** | − | 0 | Stand‑alone charges |
| **SPLIT** | 0 | qty/price adjust | No value change |

Cash legs post to the synthetic symbol `$CASH‑<CCY>` automatically.

## Symbol lookup

1. Exact ticker (`AAPL`, `BTC‑USD`).  
2. Ticker + suffix (`RY.TO`).  
3. First Yahoo Finance hit.  

Need to override? Use the **Universal Symbol ID**.

## FX rates

- Pulled every 6 h from the default market data provider.  
- View/edit: `Settings → General → Exchange Rates`.  
- Manual rates override auto values until you change them again.
