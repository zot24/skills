> Source: https://wealthfolio.app/docs/guide/health-center



Docs


Health Center


# Health Center

Find and fix portfolio data issues in Wealthfolio – orphan activities, negative balances, stale prices and FX rates, missing classifications – in one click.


Last updated November 12, 2026

The Health Center is the place to start when something looks off – a number doesn’t add up, a holding shows a strange spike, an account has negative cash. It runs a series of checks against your portfolio across six categories and proposes fixes for whatever it finds.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/app/health.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="The Health Center flags data-quality issues; here, everything checks out" /> <img src="https://assets.wealthfolio.app/images/screenshots/app/health-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="The Health Center flags data-quality issues; here, everything checks out" />
<figcaption>The Health Center flags data-quality issues; here, everything checks out</figcaption>
</figure>

------------------------------------------------------------------------

## 1 · What gets checked

Findings are grouped into severity tiers (`Info`, `Warning`, `Error`, `Critical`) and six categories: **Prices**, **FX Rates**, **Categories**, **Data**, **Accounts**, and **Settings**. Each finding shows its category.

### Prices

- **Stale price (warning)** – last quote is more than 24 hours old (configurable).
- **Stale price (critical)** – last quote is more than 72 hours old (configurable).
- **Quote sync errors** – a market-data provider returned an error for one or more assets on the last refresh. Triggers the **Retry Sync** auto-fix.
- **Valuation not updated** – an asset you value by hand, such as a property, a vehicle, or a manual loan, has a last value more than 90 days old, so net worth may be out of date. It’s a warning you can dismiss. It links to each asset’s values; with one asset, its **Update Value** button opens them. See <a href="/docs/guide/assets/#update-values-and-debts" class="font-medium underline underline-offset-4">Update values and debts</a>.

Both stale price findings trigger the **Sync Prices** auto-fix for the affected assets.

### FX Rates

- **Missing FX rate** – an activity in a non-base currency has no exchange rate for its date.
- **Stale FX rate (warning)** – last FX point for a currency pair is more than 24 hours old.
- **Stale FX rate (critical)** – last FX point is more than 72 hours old.

All three trigger the **Fetch Exchange Rates** auto-fix.

### Categories

- **Missing classification** – an asset has no sector / region / asset-class classification, so it doesn’t show up in allocation breakdowns.
- **Legacy classification** – also listed under Data; surfaces the **Migrate Classifications** auto-fix per-asset, plus a **Start Migration** action that processes all legacy classifications at once.

### Data

Things that don’t add up internally.

- **Orphan activity → account** – an activity references an account that no longer exists.
- **Orphan activity → asset** – an activity references an asset that no longer exists.
- **Negative position** – a holding shows a negative quantity (you’ve sold more shares than you bought; usually means a missing BUY or TRANSFER_IN).
- **Negative cash balance** – cash on an account has gone below zero. Usually means a BUY ran without a matching DEPOSIT or TRANSFER_IN.
- **Negative account balance** – the account’s total balance is negative, often a symptom of the issues above.
- **Legacy classification** – an asset is still using the pre-v2 classification scheme and should be migrated.
- **Incomplete transfer detected** – a transfer is missing its other side, so it counts as money entering or leaving your portfolio. Its **Match transfers** button opens the Match transfers page, where you link both sides or mark the transfer as external. See <a href="/docs/guide/activities/#match-transfers" class="font-medium underline underline-offset-4">Match transfers</a>.
- **Transaction could not be applied** – a transaction is left out of balances, holdings, and returns, for example because its currency has no exchange rate or a sale needs **Sell Short**.
- **Transaction sells more than was held** – a sale or move takes out more units than the account held. Only the units held are removed, and the rest has no cost basis.

Both name each activity (**Activity:** and its id) and say why.

### Accounts

- **Uninitialized tracking mode** – the account hasn’t been set to Holdings or Transactions mode yet. Affects how performance is computed.

### Settings

- **Missing timezone** – no timezone is set in General settings. Needed for daily-close performance math.
- **Invalid timezone** – the configured timezone string isn’t recognized.
- **Timezone mismatch** – your browser’s timezone differs from the app’s configured timezone. Dates follow the configured timezone.

------------------------------------------------------------------------

## 2 · Running checks

Open **Settings → Health Center** (or **Tools → Health Center** from the menu on mobile). Checks run on demand; click **Run all checks** or pick a category.

Each finding shows:

- A description of what’s wrong.
- The affected account, asset, or activity (with a **View** link to jump to it).
- A **Fix** button when an auto-fix is available.
- A **Dismiss** button to acknowledge expected findings. Dismissals are tied to the data’s current hash, so the issue re-surfaces automatically if the underlying data changes.

------------------------------------------------------------------------

## 3 · Auto-fixes

The auto-fix actions Wealthfolio knows how to execute:


| Action ID | Label | What it does |
|----|----|----|
| `sync_prices` | Sync Prices | Re-fetches the latest quotes for the affected assets. |
| `fetch_fx` | Fetch Exchange Rates | Pulls missing or stale FX rates for the affected currency pairs. |
| `retry_sync` | Retry Sync | Retries the last failed market-data sync for the affected assets. |
| `migrate_classifications` | Migrate Classifications | Upgrades legacy asset classifications for the listed assets. |
| `migrate_legacy_classifications` | Start Migration | Kicks off a portfolio-wide migration of legacy classifications. |


If an issue doesn’t have an auto-fix, it still includes a **Navigate** action that takes you to the right page to fix it manually (e.g. an asset detail page for a missing classification, or the Activities page filtered to a specific account for orphan activities).

------------------------------------------------------------------------

## 4 · Configuring thresholds

The default thresholds are tuned for typical use:


| Setting                     | Default            |
|-----------------------------|--------------------|
| Stale price → Warning       | 24h                |
| Stale price → Critical      | 72h                |
| Stale FX → Warning          | 24h                |
| Stale FX → Critical         | 72h                |
| Market-value escalation     | 30%                |
| Classification warn → error | 5% of portfolio MV |


These live in the Health Center configuration and can be adjusted if your portfolio needs different sensitivity.

------------------------------------------------------------------------

## 5 · When to run it

Good moments to open the Health Center:

- After a big CSV import – catches mapping mistakes early.
- When a metric on the dashboard looks wrong.
- After upgrading to a new major version – schema changes occasionally surface pre-existing data quirks.
- Periodically if you have many accounts – even a few stale quotes or missing FX points can throw off totals.

------------------------------------------------------------------------

After the 3.8 activity upgrade, also check **Activities → Needs review**. That queue contains amounts that need comparison with your statement. It is separate from Health Center checks. See <a href="/docs/concepts/activity-fields/" class="font-medium underline underline-offset-4">Activity Fields</a>.

## 6 · What it doesn’t do

The Health Center checks **internal consistency** – does the data Wealthfolio has add up? It can’t:

- Validate against your broker. If your broker shipped wrong data, the Health Center won’t know. Compare against a brokerage statement.
- Predict the future. A stale-quote check tells you the price is old, not what the right price is.
- Fix classification meaning. It can migrate legacy classifications and flag missing ones, but it doesn’t decide that AAPL belongs to the Technology sector – you do.

------------------------------------------------------------------------

**Next step:** If the Health Center keeps flagging the same issue and you can’t tell what’s causing it, post in <a href="https://discord.gg/WDMCY6aPWK" class="font-medium underline underline-offset-4">Discord</a> with a screenshot of the finding.


<a href="/docs/guide/custom-providers/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Market Data Providers</a> <a href="/docs/guide/settings/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Settings</a>


On this page

- <a href="#1--what-gets-checked" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1 · What gets checked</a>
  - <a href="#prices" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Prices</a>
  - <a href="#fx-rates" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">FX Rates</a>
  - <a href="#categories" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Categories</a>
  - <a href="#data" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Data</a>
  - <a href="#accounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Accounts</a>
  - <a href="#settings" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Settings</a>
- <a href="#2--running-checks" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2 · Running checks</a>
- <a href="#3--auto-fixes" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3 · Auto-fixes</a>
- <a href="#4--configuring-thresholds" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">4 · Configuring thresholds</a>
- <a href="#5--when-to-run-it" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">5 · When to run it</a>
- <a href="#6--what-it-doesnt-do" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">6 · What it doesn't do</a>


