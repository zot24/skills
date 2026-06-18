> Source: https://wealthfolio.app/docs/guide

This guide will walk you through the main features of Wealthfolio and how to use them effectively.

## Initial Setup

### Set Your Main Currency

1. Go to the settings/General tab.
2. Choose your preferred currency from the list provided.
3. Confirm your selection.

### Add Your Accounts

1. Navigate to the settings/Accounts tab.
2. Click "Add Account" and fill out the form:

| Field | Description |
| --- | --- |
| Account Name | Enter a descriptive name for your account |
| Account Group | Enter a group to organize your accounts (e.g. 401k, RRSP, Cash Savings) |
| Account Type | Select from Securities, Cash, or Crypto |
| Account Currency | Choose the currency for this account |
| Is Default | Check this box if you want this to be your default account |
| Is Active | Ensure this is checked to include the account in your portfolio |

3. Click "Save" to add the account.
4. Repeat for each account you want to track.

## Managing Activities

Activities in Wealthfolio represent all your financial transactions, including buys, sells,
dividends, deposits, withdrawals, and more. Properly managing these activities is crucial for
accurate portfolio tracking.

### Supported Activities
Wealthfolio supports the following activity types to track your investments and their impact on your portfolio:

| Activity Type   | Description                                                                                                         | Impact                                                                                   |
|-----------------|---------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| BUY             | Purchase securities or other assets.                                                                                | Decreases cash, increases holdings                                                       |
| SELL            | Sell securities or other assets.                                                                                    | Increases cash, decreases holdings                                                       |
| DIVIDEND        | Record dividend payments received from investments.                                                                 | Increases cash                                                                           |
| INTEREST        | Track interest income earned, typically from cash balances or fixed-income securities.                              | Increases cash                                                                           |
| DEPOSIT         | Add funds to an account from an external source.                                                                    | Increases cash                                                                           |
| WITHDRAWAL      | Remove funds from an account to an external source.                                                                 | Decreases cash                                                                           |
| TRANSFER_IN     | Transfer cash or assets into this account. Internal: paired with TRANSFER_OUT from another Wealthfolio account, cost basis preserved. External (External flag): seeds an opening balance, gift, inheritance, or RSU at the cost basis you provide. | If cash: Increases cash. If assets: Increases holdings; cash may decrease by transaction fee. |
| TRANSFER_OUT    | Transfer cash or assets out of this account. Internal: cost basis exported to the destination Wealthfolio account. External (External flag): assets leave Wealthfolio (write-off, crypto sent to untracked wallet); lots closed via FIFO with no realised gain. | If cash: Decreases cash. If assets: Decreases holdings; cash may decrease by transaction fee. |
| FEE             | Record account-related fees or transaction charges not included in a buy/sell activity.                             | Decreases cash                                                                           |
| TAX             | Record tax payments related to investment activities (e.g., withholding tax on dividends, capital gains tax paid).  | Decreases cash                                                                           |
| SPLIT           | Record stock splits or reverse splits. Adjusts the quantity and per-share cost basis of a holding.                    | Adjusts holdings (quantity and cost per share); no direct impact on cash or total value.   |

### Supported Securities

Wealthfolio uses Universal Symbol objects, which can be identified by either a ticker or a Universal
Symbol ID. When you input a ticker, the system returns the first matching result. We primarily
adhere to the Yahoo Finance ticker format for consistency and accuracy.

Here are some examples to illustrate the ticker format:

- For stocks traded on the Toronto Stock Exchange (TSX), append `.TO` to the ticker. For instance,
  `RY.TO` for Royal Bank of Canada.
- For stocks traded on the London Stock Exchange (LSE), use `.L` at the end. For example, `HSBA.L`
  for HSBC Holdings.
- Stocks traded on NASDAQ or NYSE typically don't require a suffix. For example, `AAPL` for Apple
  Inc.

To ensure the most accurate results, always use the ticker with the appropriate suffix for the
exchange where the security is traded. For comprehensive information about market coverage and
potential data delays, please consult the Yahoo Finance Market Coverage documentation.

### Adding Activities Manually

This method is ideal for entering one-off trades or transactions as they occur.

1. Click on "Activities" in the main sidebar of the app.
2. Click "Add Activity" to record a new transaction.
3. Fill out the activity form:
   - Select the account from the dropdown menu.
   - Choose the activity type (`BUY`, `SELL`, `DIVIDEND`, `INTEREST`, `DEPOSIT`, `WITHDRAWAL`,
     `TRANSFER_IN`, `TRANSFER_OUT`, `CONVERSION_IN`, `CONVERSION_OUT`, `FEE`, `TAX`).
   - Set the transaction date and time.
   - Enter the symbol of the security (if applicable).
   - Input the quantity (number of shares or units).
   - Enter the unit price.
   - Select the currency.
   - Add any fees associated with the transaction.
4. Review the entered information and click "Add Activity" to save, or "Cancel" to discard.

#### CSV Import

Wealthfolio provides a flexible CSV import feature that allows you to easily map your data fields
and save mappings for future use:

1. Ensure your CSV file includes column headers in the first row.
2. Click on the "Import CSV" option
3. Drop your CSV file or click to select it
4. The import wizard will guide you through mapping your CSV columns:
   - Match your CSV columns to Wealthfolio fields (date, symbol, quantity, etc.)
   - Map your activity types to Wealthfolio's supported types (BUY, SELL, DIVIDEND, etc.)
   - Map any non standard ticker symbol to ensure they match Yahoo Finance format.
5. Review the mapped data preview, errors, and make any necessary adjustments.
6. Save the mapping for this account to streamline future imports
7. Confirm the import if everything looks correct

Your column mappings will be saved for the selected account, making future imports faster and
more consistent.

<MdxImage
  src="https://assets.wealthfolio.app/images/docs/csv-mapping.webp"
  width="718"
  height="404"
  alt="CSV import Mapping"
/>

The application will also check the ticker symbols and notify you of any errors. You can filter the
error and view the details by clicking on the error icon.

<MdxImage
  src="https://assets.wealthfolio.app/images/docs/import.webp"
  width="718"
  height="404"
  alt="CSV import errors"
/>


Here is an example of default CSV format:

```
date,symbol,quantity,activityType,unitPrice,currency,fee
2024-03-01T15:02:36.329Z,MSFT,1,DIVIDEND,57.5,USD,0
2024-02-15T15:02:36.329Z,MSFT,30,BUY,368.6046511627907,USD,0
2024-06-05T09:15:22.456Z,$CASH-USD,1,INTEREST,180.5,USD,0
2024-04-02T11:20:15.321Z,$CASH-USD,1,WITHDRAWAL,1000,USD,0
2024-05-18T13:45:30.789Z,AAPL,5,SELL,210.75,USD,0
2024-01-07T09:10:20.987Z,MSFT,30,BUY,360.75,USD,9.99
2024-01-23T11:40:50.456Z,AMZN,15,BUY,170.00,CAD,9.99
2024-01-18T13:55:05.789Z,AAPL,1,DIVIDEND,50.25,USD,9.99
2024-01-11T15:10:20.321Z,AAPL,10,BUY,189.60,USD,9.99
2023-02-12T16:25:35.654Z,TSLA,20,BUY,212.50,USD,9.99
2023-01-15T12:10:20.456Z,SHOP,25,BUY,61.23,USD,9.99
2023-01-18T15:55:05.654Z,NVDA,12,BUY,52.40,USD,9.99
2023-03-11T14:55:30.863Z,$CASH-USD,100000,DEPOSIT,1,USD,0
```

## Dashboards Overview

The dashboards provides a quick snapshot of your portfolio:

**Total portfolio value and accounts breakdown** 

<MdxImage
  src="https://assets.wealthfolio.app/images/landing/wf-home.webp"
  width="718"
  height="404"
  alt="Wealthfolio Dashboard"
/>

**Asset allocation** 

<MdxImage
  src="https://assets.wealthfolio.app/images/landing/holdings-charts.webp"
  width="718"
  height="404"
  alt="Wealthfolio Holdings"
/>


**Income Dashboard** 

<MdxImage
  src="https://assets.wealthfolio.app/images/landing/income.webp"
  width="718"
  height="404"
  alt="Wealthfolio Income"
/>

/>

## Tracking Performance

- View performance charts for individual investments or your entire portfolio.
- Set up custom date ranges to analyze specific periods.
- Monitor your overall gain/loss percentage and amount.

For more detailed information on specific features or troubleshooting, please refer to our
[FAQ section](/docs/faq).

## Tracking Contribution Limits

Wealthfolio helps you track your contribution limits for tax-advantaged accounts like IRAs, 401(k)s,
or TFSAs. You can set contribution limits for each account and track your available contribution
room. To do this:

1. Go to the settings/Limits tab.
2. Click on "Add Limit".
3. Create a the contribution limit with an identifiable name (e.g. `2025 RRSP` or `2025 Roth IRA`),
   Year and set the contribution limit in base currency.
4. Save the limit
5. Select all accounts you want to track for this limit and click "Save selected accounts".
6. You can now track your contribution limits and available contribution room in each account page
   or in the limits settings page.

<MdxImage
  src="https://assets.wealthfolio.app/images/landing/contribution-limits.webp"
  width="718"
  height="404"
  alt="Wealthfolio Contribution Limits"
/>
