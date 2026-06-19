> Source: https://wealthfolio.app/docs/guide/settings

Open **Settings** from the bottom of the sidebar. Options are grouped into **Preferences**,
**Finance**, **Data**, **Connections**, and **Extensions**, plus **About**.

<MdxScreenshot
  src="https://assets.wealthfolio.app/images/screenshots/app/settings.png"
  caption="Settings, grouped into Preferences, Finance, Data, Connections, and Extensions"
/>

## Preferences

### General

- **Base Currency** — the currency every total and report is converted to. All balances and
  transactions are converted using market exchange rates (see [Exchange rates](#exchange-rates)).
- **Timezone** — the timezone used for dates, daily buckets, and yearly contribution-limit
  boundaries.
- **Automatic Updates** — when enabled, Wealthfolio checks for app updates on startup.

#### Exchange rates

Exchange rates are added and refreshed automatically from your market-data providers. The
**General** page lists the current rates so you can review them, and lets you **add a custom
rate** for any pair the providers don't cover:

1. Click **Add rate**.
2. Choose the **From** and **To** currencies and enter the **rate**.
3. Save.

Wealthfolio also handles currency variants automatically — for example pence vs. pounds
(`GBp` ↔ `GBP`, 100 : 1) for securities priced in cents.

<Callout icon="⚠️" type="warning">
  Manually added rates aren't auto-updated, so review them periodically.
</Callout>

### Appearance

- **Theme** — Light, Dark, or follow your system.
- **Font** — choose Mono, Serif, or Sans for the interface.

## Finance

### Accounts

Add, edit, group, hide, or archive your accounts, and set tracking mode and currency. See the
[Accounts & Portfolios](/docs/guide/accounts) guide.

### Portfolios

Build **named reporting scopes** across a set of accounts, then select them from the account
picker anywhere in the app. See [Accounts & Portfolios](/docs/guide/accounts#portfolios).

### Contribution Limits

Track contribution room for tax-advantaged accounts (IRA, 401(k), TFSA, RRSP…). See
[Contribution Limits](/docs/guide/contribution-limits).

### Spending Tracker

Opt accounts into spending, manage categorization rules, budgets, and life events. See
[Spending & Budgets](/docs/guide/spending-budgets).

## Data

### Securities

Review and manage the instruments in your portfolio — tickers, custom/alternative assets, and
their data settings.

### Classifications

Edit the taxonomies (asset class, industry/sector, region, risk, and custom groups) that power
[Portfolio Insights](/docs/guide/dashboards) and
[Allocation Targets](/docs/guide/allocation-targets). AI can help fill in missing tags.

### Backup & Export

Export your data or back up your local database. See [Export & Backup](/docs/guide/data-export).

## Connections

### Wealthfolio Connect

Optional, end-to-end-encrypted brokerage and device sync. See
[Connect & Broker Sync](/docs/guide/connect-broker-sync).

### Market Data

Choose which built-in providers are active and add your own. See
[Market Data Providers](/docs/guide/custom-providers).

### AI Providers

Connect an AI provider (or a local model) and pick a default model for the
[AI Assistant](/docs/guide/ai-assistant).

## Extensions

### Add-ons

Install and manage community add-ons that extend Wealthfolio. See [Add-ons](/docs/addons).

## About

App version, links, and update controls.
