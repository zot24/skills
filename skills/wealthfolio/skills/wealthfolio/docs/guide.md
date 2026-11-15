> Source: https://wealthfolio.app/docs/guide



Docs


Wealthfolio User Guide


# Wealthfolio User Guide

Comprehensive guide on using Wealthfolio to track and manage your investments.


Last updated November 12, 2026


This guide will walk you through the main features of Wealthfolio and how to use them effectively.

## Initial Setup

### Set Your Main Currency

1.  Go to the settings/General tab.
2.  Choose your preferred currency from the list provided.
3.  Confirm your selection.

### Add Your Accounts

1.  Go to **Settings → Accounts** and click **Add account**.
2.  Fill out the form – **Account Name**, **Account Group** (optional), **Account Type** (Securities, Cash, Credit Card, or Crypto), **Currency**, and **Tracking Mode** (Transactions or Holdings).
3.  Click **Save**, and repeat for each account.

See <a href="/docs/guide/accounts/" class="font-medium underline underline-offset-4">Accounts &amp; Portfolios</a> for the full field reference and account status (Active / Hidden / Archived).

## Managing Activities

Activities in Wealthfolio represent all your financial transactions, including buys, sells, dividends, deposits, withdrawals, and more. Properly managing these activities is crucial for accurate portfolio tracking.

### Supported Activities

Wealthfolio supports the following activity types to track your investments and their impact on your portfolio:


| Activity Type | Description | Impact |
|----|----|----|
| BUY | Purchase securities or other assets. | Decreases cash, increases holdings |
| SELL | Sell securities or other assets. | Increases cash, decreases holdings |
| DIVIDEND | Record dividend payments received from investments. | Increases cash |
| INTEREST | Track interest income earned, typically from cash balances or fixed-income securities. | Increases cash |
| DEPOSIT | Add funds to an account from an external source. | Increases cash |
| WITHDRAWAL | Remove funds from an account to an external source. | Decreases cash |
| TRANSFER_IN | Transfer cash or assets into this account. Internal: paired with TRANSFER_OUT from another Wealthfolio account, cost basis preserved. External (External flag): seeds an opening balance, gift, inheritance, or RSU at the cost basis you provide. | If cash: Increases cash. If assets: Increases holdings; cash may decrease by transaction fee. |
| TRANSFER_OUT | Transfer cash or assets out of this account. Internal: cost basis exported to the destination Wealthfolio account. External (External flag): assets leave Wealthfolio (write-off, crypto sent to untracked wallet); lots closed via FIFO with no realised gain. | If cash: Decreases cash. If assets: Decreases holdings; cash may decrease by transaction fee. |
| FEE | Record account-related fees or transaction charges not included in a buy/sell activity. | Decreases cash |
| TAX | Record tax payments related to investment activities (e.g., withholding tax on dividends, capital gains tax paid). | Decreases cash |
| SPLIT | Record stock splits or reverse splits. Adjusts the quantity and per-share cost basis of a holding. | Adjusts holdings (quantity and cost per share); no direct impact on cash or total value. |


### Managing Assets and Securities

An asset describes what you own, such as a stock, fund, cryptocurrency, or property. Your activities and account holdings record how much you own.

See <a href="/docs/guide/assets/" class="font-medium underline underline-offset-4">Assets &amp; Securities</a> for asset types, fields, classification, prices, logos, and how to edit or delete assets. For provider symbols and exchange suffixes, see <a href="/docs/concepts/market-data-and-fx/" class="font-medium underline underline-offset-4">Market Data &amp; FX</a>.

### Adding Activities Manually

This method is ideal for entering one-off trades or transactions as they occur.

1.  Click on “Activities” in the main sidebar of the app.
2.  Click **Add Activities**, then **Add Transaction**.
3.  Fill out the activity form:
    - Select the account from the dropdown menu.
    - Choose the activity type (`BUY`, `SELL`, `DIVIDEND`, `INTEREST`, `DEPOSIT`, `WITHDRAWAL`, `TRANSFER_IN`, `TRANSFER_OUT`, `CREDIT`, `SPLIT`, `FEE`, `TAX`).
    - Set the transaction date and time.
    - Enter the symbol of the security (if applicable).
    - Input the quantity (number of shares or units).
    - Enter the unit price.
    - Select the currency.
    - For a cash dividend or interest, enter the **Amount before tax** and the **Withholding tax**. Wealthfolio works out the **Received amount**. If your statement shows the amount after tax, type it into **Received amount** instead.
    - Enter fees and taxes, and check the final amount paid or received. Charges already applied to the amount are not deducted again. See <a href="/docs/concepts/activity-fields/" class="font-medium underline underline-offset-4">Activity Fields</a>.
4.  Review the entered information and click the form’s add button (for example **Add Buy** or **Add Dividend**) to save, or **Cancel** to discard.

#### CSV Import

Wealthfolio provides a flexible CSV import feature that allows you to easily map your data fields and save mappings for future use:

1.  Check the column headers. Use the upload settings to skip any description rows above them.
2.  Click on the “Import CSV” option
3.  Drop your CSV file or click to select it
4.  The import wizard will guide you through mapping your CSV columns:
    - Match your CSV columns to Wealthfolio fields (date, symbol, quantity, etc.)
    - Map your activity types to Wealthfolio’s supported types (BUY, SELL, DIVIDEND, etc.)
    - Review symbols and exchanges to select the correct assets.
5.  Review the mapped data preview, errors, and make any necessary adjustments.
6.  Save the mapping for this account to streamline future imports
7.  Confirm the import if everything looks correct

Your column mappings will be saved for the selected account, making future imports faster and more consistent.

<img src="https://assets.wealthfolio.app/images/docs/csv-mapping.webp" class="h-full w-full overflow-hidden object-cover dark:hidden" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="CSV import Mapping" /><img src="https://assets.wealthfolio.app/images/docs/csv-mapping-dark.webp" class="hidden h-full w-full overflow-hidden object-cover dark:block" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="CSV import Mapping" />

The application will also check the ticker symbols and notify you of any errors. You can filter the error and view the details by clicking on the error icon.

<img src="https://assets.wealthfolio.app/images/docs/import.webp" class="h-full w-full overflow-hidden object-cover dark:hidden" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="CSV import errors" /><img src="https://assets.wealthfolio.app/images/docs/import-dark.webp" class="hidden h-full w-full overflow-hidden object-cover dark:block" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="CSV import errors" />

Here is an example of default CSV format:

``` mb-4
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

<img src="https://assets.wealthfolio.app/images/landing/wf-home.webp" class="h-full w-full overflow-hidden object-cover dark:hidden" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="Wealthfolio Dashboard" /><img src="https://assets.wealthfolio.app/images/landing/wf-home-dark.webp" class="hidden h-full w-full overflow-hidden object-cover dark:block" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="Wealthfolio Dashboard" />

**Asset allocation**

<img src="https://assets.wealthfolio.app/images/landing/holdings-charts.webp" class="h-full w-full overflow-hidden object-cover dark:hidden" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="Wealthfolio portfolio insights: allocation and holdings composition" /><img src="https://assets.wealthfolio.app/images/landing/holdings-charts-dark.webp" class="hidden h-full w-full overflow-hidden object-cover dark:block" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="Wealthfolio portfolio insights: allocation and holdings composition" />

**Income Dashboard**

<img src="https://assets.wealthfolio.app/images/landing/income.webp" class="h-full w-full overflow-hidden object-cover dark:hidden" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="Wealthfolio Income" /><img src="https://assets.wealthfolio.app/images/landing/income-dark.webp" class="hidden h-full w-full overflow-hidden object-cover dark:block" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="Wealthfolio Income" />

## Tracking Performance

- View performance charts for individual investments or your entire portfolio.
- Set up custom date ranges to analyze specific periods.
- Monitor your overall gain/loss percentage and amount.

For more detailed information on specific features or troubleshooting, please refer to our <a href="/docs/faq/" class="font-medium underline underline-offset-4">FAQ section</a>.

## Tracking Contribution Limits

Wealthfolio helps you track your contribution limits for tax-advantaged accounts like IRAs, 401(k)s, or TFSAs. Go to **Settings → Contribution limits**, click **Add limit**, and set the cap, its year or dates, and the accounts that count. Each limit shows how much room you’ve used and how much is left. See <a href="/docs/guide/contribution-limits/" class="font-medium underline underline-offset-4">Contribution Limits</a> for the details page, repeating limits, and which activities count.

<img src="https://assets.wealthfolio.app/images/landing/contribution-limits.webp" class="h-full w-full overflow-hidden object-cover dark:hidden" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="Wealthfolio Contribution Limits" /><img src="https://assets.wealthfolio.app/images/landing/contribution-limits-dark.webp" class="hidden h-full w-full overflow-hidden object-cover dark:block" loading="lazy" decoding="async" data-fetchpriority="auto" width="718" height="404" alt="Wealthfolio Contribution Limits" />


<a href="/docs/quick-start/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Quick Start</a>


On this page

- <a href="#initial-setup" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Initial Setup</a>
  - <a href="#set-your-main-currency" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Set Your Main Currency</a>
  - <a href="#add-your-accounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Add Your Accounts</a>
- <a href="#managing-activities" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Managing Activities</a>
  - <a href="#supported-activities" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Supported Activities</a>
  - <a href="#managing-assets-and-securities" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Managing Assets and Securities</a>
  - <a href="#adding-activities-manually" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Adding Activities Manually</a>
- <a href="#dashboards-overview" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Dashboards Overview</a>
- <a href="#tracking-performance" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Tracking Performance</a>
- <a href="#tracking-contribution-limits" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Tracking Contribution Limits</a>


