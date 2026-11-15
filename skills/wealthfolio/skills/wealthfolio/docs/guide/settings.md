> Source: https://wealthfolio.app/docs/guide/settings



Docs


Settings Reference


# Settings Reference

Configure Wealthfolio – base currency and timezone, language and region formats, accounts and portfolios, data, market-data and AI connections, and appearance.


Last updated November 12, 2026


Open **Settings** from the bottom of the sidebar. Options are grouped into **Preferences**, **Finance**, **Data**, **Connections**, and **Extensions**, plus **About**.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/app/settings.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Settings, grouped into Preferences, Finance, Data, Connections, and Extensions" /> <img src="https://assets.wealthfolio.app/images/screenshots/app/settings-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Settings, grouped into Preferences, Finance, Data, Connections, and Extensions" />
<figcaption>Settings, grouped into Preferences, Finance, Data, Connections, and Extensions</figcaption>
</figure>

## Preferences

### General

**Base currency** is the reporting currency for consolidated portfolio values. Changing it changes how those values are presented; it does not rewrite the currencies on your accounts, activities, or security quotes. Choose a currency and click **Save currency**. See <a href="/docs/concepts/market-data-and-fx/" class="font-medium underline underline-offset-4">Market Data &amp; FX</a> for how conversions work.

#### Language & region

These controls live on the **General** page and save when you change them:

- **Language** changes interface text independently of number and date formatting. Supported languages include English, French, German, Spanish, Brazilian Portuguese, Italian, Simplified Chinese, Traditional Chinese, Japanese, Korean, and Arabic.
- **Region & formats** controls date order, decimal separators, percentages, currency presentation, and 12- or 24-hour time. Choose System region, Canada, United States, United Kingdom, India, France, Germany, Austria, Switzerland, Spain, Mexico, Brazil, Portugal, China, Taiwan, Japan, South Korea, Italy, Romania, or Bulgaria. **System region** follows the locale reported by your browser or app environment, including regions without a dedicated option. Check the live date, number, currency, and time previews.
- **Timezone** controls local date and time display and date boundaries, including annual contribution periods. Select the timezone you want Wealthfolio to use.

Amount fields accept your region’s decimal separator. Changing the interface language alone does not change your financial formatting conventions.

#### Exchange rates

Review currency pairs, their rates, sources, and timestamps under **General**. To add a pair:

1.  Click **Add rate** and choose the **From** and **To** currencies.
2.  Choose a **Source**. For **Manual**, enter a rate greater than zero. For a market-data provider, Wealthfolio fetches the rate instead of asking you to enter it.
3.  Save the pair.

The direction matters: a rate of `1.35` from USD to CAD means USD 1 is CAD 1.35. You can edit a manual rate in the table. Provider rates are refreshed through market-data sync and cannot be edited inline. You can also delete a pair after confirming; if your holdings or activities need it, you may need to recreate it for accurate calculations.

Wealthfolio handles currency variants such as pence and pounds (`GBp` and `GBP`) automatically. You can’t add a pair in a quote unit such as `GBp`: the form asks you to enter the main currency’s rate instead, for example GBP/USD.

A crypto pair such as BTC/USD added before 3.13 can keep failing to update from Yahoo. To fix it, open the pair with the clock button in its row, choose **Edit** in the **⋮** menu, and on the **Market data** tab set its Yahoo **Symbol mapping** to `BTC-USD`.

See <a href="/docs/concepts/market-data-and-fx/" class="font-medium underline underline-offset-4">Market Data &amp; FX</a> for conversion behavior and <a href="/docs/guide/custom-providers/" class="font-medium underline underline-offset-4">Market Data Providers</a> for provider configuration.


Manual rates are not refreshed automatically. Review them periodically.


#### Automatic updates

Enable startup update checks for the desktop app. The switch saves immediately and controls checking for updates, not unattended installation. This section is hidden on mobile. Self-hosted deployments are updated through their hosting setup; see <a href="/docs/guide/self-hosting/" class="font-medium underline underline-offset-4">Self-hosting</a>.

### Appearance

Appearance is grouped into three cards. Changes save as you make them.

**Theme** shows eight themes: Classic, Signature, Ember, Cupertino, Newspaper, Cyber, Terminal, and Poster. Each is previewed as a small dashboard in your current mode. The **Light**, **Dark**, and **System** switch at the top of the card sets the mode; every theme has a light and a dark appearance.

- Picking a theme applies the font it suggests, if any, and never changes light or dark mode.
- Cyber and Terminal are made for dark mode. Pick one in light mode and you’re offered **Switch to dark**.
- The theme is saved on each device, so devices you sync can use different themes.
- New profiles start on Signature.

**Text and numbers**:

- **Font family**: Sans, Serif, or Mono. The row names the font your theme suggests, such as “Signature suggests Sans”. If you choose another, **Use theme defaults** goes back to the theme’s font.
- **Text size**: Small, Default, Large, or Extra large. It makes text and controls larger or smaller on this device. On iPhone and Android, the app starts from the system text size until you pick one.
- **Gain and loss colors**: Green up, red down (the default); Red up, green down; or Red up, blue down, for markets where red means a price went up. Gains, returns, day change, the treemap, and charts follow it; statuses, budgets, goals, and spending categories keep their own colours. It syncs across your devices; update them all to 3.12 or later before you change it, as a device on an older version misses the change.

**Navigation** (hidden on mobile):

- **Sidebar** or **Floating bar**: how you navigate on large screens.
- **Show menu bar**: show or hide the application menu bar. Only the Windows and Linux desktop app shows this switch.

## Finance

### Accounts

Add, edit, group, hide, or archive your accounts, and set tracking mode and currency. See the <a href="/docs/guide/accounts/" class="font-medium underline underline-offset-4">Accounts &amp; Portfolios</a> guide.

### Portfolios

Build **named reporting scopes** across a set of accounts, then select them from the account picker anywhere in the app. See <a href="/docs/guide/accounts/#portfolios" class="font-medium underline underline-offset-4">Accounts &amp; Portfolios</a>.

### Contribution limits

Track contribution room for tax-advantaged accounts (IRA, 401(k), TFSA, RRSP…). See <a href="/docs/guide/contribution-limits/" class="font-medium underline underline-offset-4">Contribution Limits</a>.

### Spending tracker

Opt accounts into spending, manage categorization rules, budgets, and life events. The **Default monthly budget plan** includes savings categories, each with a **Savings goal**. Deleting a category you’ve used merges it into another one, with its transactions, rules, and budgets. See <a href="/docs/guide/spending-budgets/" class="font-medium underline underline-offset-4">Spending &amp; Budgets</a>.

## Data

### Securities

Review and manage the instruments in your portfolio, including their details and data settings. See <a href="/docs/guide/assets/" class="font-medium underline underline-offset-4">Assets &amp; Securities</a> for the full guide.

### Classifications

Edit the classifications (asset class, industry/sector, region, risk, and custom groups) that power <a href="/docs/guide/dashboards/" class="font-medium underline underline-offset-4">Portfolio Insights</a> and <a href="/docs/guide/allocation-targets/" class="font-medium underline underline-offset-4">Allocation Targets</a>. AI can help fill in missing tags. See <a href="/docs/guide/assets/#classify-your-assets" class="font-medium underline underline-offset-4">Classify your assets</a> for assignments, weights, and custom classifications.

### Backup & export

Use the **Backups** tab to create, export, or restore a database backup, including an unencrypted `.db` export. The **Data export** tab saves 23 datasets as CSV or JSON, one at a time or all at once with **Export all** (a ZIP of CSV files, or one JSON file). Desktop and iOS support restore in the app. Web mode lets you create, download, and delete server backups; restoration requires stopping the server. See <a href="/docs/guide/data-export/" class="font-medium underline underline-offset-4">Export &amp; Backup</a> for steps and platform differences.

## Connections

### Wealthfolio Connect

Connect a brokerage to import holdings and activities, or sync your data between devices. Device sync uses end-to-end encryption. See <a href="/docs/guide/connect-broker-sync/" class="font-medium underline underline-offset-4">Connect &amp; Broker Sync</a>.

### Market data

**Built-in providers** lists the providers that are on, in the order they’re tried: when more than one covers an asset, the higher one is tried first. Use the arrows beside a provider to move it, and its switch to turn it off; a move saves right away. Open a provider’s settings to enter an API key and review sync status or errors. **Add provider** lists the other built-in providers, with a search. AMFI (Indian mutual funds) and Moscow Exchange are off until you add them.

Custom providers have their own **Custom providers** card. You can also override the provider or symbol for an individual security. See <a href="/docs/guide/custom-providers/" class="font-medium underline underline-offset-4">Market Data Providers</a>.

### AI providers

Connect a hosted provider or local model, enable the providers and models available in the chat picker, and control each provider’s data access. **Data access** includes **Spending**, which lets the assistant read your spending reports, budgets, transactions, and events. It’s on by default; a selection you saved yourself before 3.13 doesn’t include it. Advanced options include custom endpoints and provider tuning. See <a href="/docs/guide/ai-assistant/#provider-settings" class="font-medium underline underline-offset-4">AI provider settings</a> for keys, model capabilities, and save behavior.

### AI agent access

Start or stop the MCP server, configure auto-start and audit logging, and create or revoke scoped access tokens. Spending tools have their own permissions: **View spending**, **Organize spending**, and **Manage budgets**. **Accounts — write** lets an agent create and change accounts, and **Holdings — write** lets it save holdings snapshots and add alternative assets and liabilities. Choose **Edit permissions** on a token to change what it can do without creating a new one. After you add a write scope, reconnect the agent so it finds the new tools. Desktop and web controls differ; this entry is hidden in mobile Settings. See <a href="/docs/guide/mcp-server/" class="font-medium underline underline-offset-4">MCP Server</a>.

## Extensions

### Add-ons

Install and manage community add-ons that extend Wealthfolio. See <a href="/docs/addons/" class="font-medium underline underline-offset-4">Add-ons</a>.

## About

Review the app version and project links. Desktop update controls let you check for a new release; update availability depends on your platform.


<a href="/docs/guide/health-center/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Health Center</a> <a href="/docs/guide/data-export/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Export &amp; Backup</a>


On this page

- <a href="#preferences" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Preferences</a>
  - <a href="#general" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">General</a>
  - <a href="#appearance" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Appearance</a>
- <a href="#finance" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Finance</a>
  - <a href="#accounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Accounts</a>
  - <a href="#portfolios" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Portfolios</a>
  - <a href="#contribution-limits" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Contribution limits</a>
  - <a href="#spending-tracker" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Spending tracker</a>
- <a href="#data" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Data</a>
  - <a href="#securities" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Securities</a>
  - <a href="#classifications" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Classifications</a>
  - <a href="#backup--export" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Backup &amp; export</a>
- <a href="#connections" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Connections</a>
  - <a href="#wealthfolio-connect" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Wealthfolio Connect</a>
  - <a href="#market-data" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Market data</a>
  - <a href="#ai-providers" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">AI providers</a>
  - <a href="#ai-agent-access" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">AI agent access</a>
- <a href="#extensions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Extensions</a>
  - <a href="#add-ons" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Add-ons</a>
- <a href="#about" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">About</a>


