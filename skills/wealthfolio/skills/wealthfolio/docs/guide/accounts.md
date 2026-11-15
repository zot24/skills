> Source: https://wealthfolio.app/docs/guide/accounts



Docs


Accounts & Portfolios


# Accounts & Portfolios

Add and configure accounts, organize them into groups, and build portfolios – named reporting scopes across accounts.


Last updated November 12, 2026

Accounts are where your money lives; portfolios are how you slice across them. Both are managed under **Settings → Accounts** and **Settings → Portfolios**.

## Accounts

Open **Settings → Accounts** to see every account, search, and filter by **All / Active / Hidden / Archived**. Click **Add account** to create one.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/app/accounts.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Settings → Accounts: your accounts with type, group, and tracking mode" /> <img src="https://assets.wealthfolio.app/images/screenshots/app/accounts-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Settings → Accounts: your accounts with type, group, and tracking mode" />
<figcaption>Settings → Accounts: your accounts with type, group, and tracking mode</figcaption>
</figure>

### Add an account

1.  Open **Settings → Accounts** and click **Add account**.
2.  Fill in the fields below, then click **Save**.


| Field | Description |
|----|----|
| Account name | Display name, 2–50 characters (e.g. “Joint Brokerage”, “RRSP”). |
| Account group | Optional label to organize accounts (e.g. `401k`, `RRSP`, `Cash Savings`). Same-group accounts collapse together on the dashboard. |
| Account number | Optional. An IBAN or account number; for a card, only the last 4 digits. See <a href="#account-numbers" class="font-medium underline underline-offset-4">Account numbers</a>. |
| Account type | **Securities**, **Cash**, **Credit card**, or **Crypto**. |
| Cash classification | Cash accounts only – **Cash** or **Fixed income**. Sets how the balance counts in allocation reports. |
| Currency | The account’s currency. Set when you create the account and fixed afterward; balances convert to your base currency for totals. |
| Tracking mode | **Transactions** (record every trade) or **Holdings** (add balances as snapshots). Credit cards always use Transactions. See <a href="/docs/concepts/tracking-modes/" class="font-medium underline underline-offset-4">Tracking Modes</a>. |


### Account numbers

A manual account can have an account number, such as an IBAN or the last 4 digits of a card. Add, change, or clear it when you add or edit the account. **Settings → Accounts** and the account page show its last 4 characters, and the account page has a button that copies the whole number.

Accounts synced through Connect keep the number their broker sends, so it can’t be changed in Wealthfolio. <a href="/docs/guide/csv-import/" class="font-medium underline underline-offset-4">CSV import</a> matches a file’s account column against these numbers, with or without spaces.

### Account status

An account is **Active**, **Hidden**, or **Archived**. Set the last two with **Hide this account** and **Archive this account** when you edit an account.

- **Active** – included everywhere: dashboard totals, performance, and reports.
- **Hidden** – tucked out of your account lists but still counted in Total and history.
- **Archived** – removed from the portfolio and totals without deleting its history. Restore it anytime.

Deleting an account is permanent and removes all of its activities – archive instead if you just want it out of the way.

## Account groups

A **group** is a free-text label on an account. Accounts that share a group roll up under one heading on the home dashboard (handy for “Spouse RRSP”, “Joint Taxable”, or “401k”). Groups are display-only – they don’t change any calculations.

## Portfolios

A **portfolio** is a named **reporting scope** across a chosen set of accounts. Where groups just tidy up the dashboard, a portfolio becomes a first-class lens you can select anywhere the account picker appears – the **Dashboard**, **Performance**, **Insights**, **Income**, and **Holdings**.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/app/portfolios.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Settings → Portfolios: named reporting scopes across accounts" /> <img src="https://assets.wealthfolio.app/images/screenshots/app/portfolios-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Settings → Portfolios: named reporting scopes across accounts" />
<figcaption>Settings → Portfolios: named reporting scopes across accounts</figcaption>
</figure>

### Creating a portfolio

1.  Go to **Settings → Portfolios** and click **Add portfolio**.
2.  Give it a **name** (e.g. “Retirement”, “Taxable”, “FIRE pot”) and an optional **description**.
3.  **Select the accounts** that belong to it. An account can appear in any number of portfolios.
4.  Click **Save**. The portfolio now appears in the account selector across the app.

Reorder portfolios by dragging; edit or delete one from its **⋮** menu. If a portfolio references an account you later delete, Wealthfolio flags it so you can clean up the link.

### Using a portfolio

Open the **account selector** at the top of the Dashboard (or Performance, Insights, Income, Holdings) and pick a portfolio instead of *All accounts* or a single account. Every number on the page – value, returns, allocation, income – is then computed for just that subset.

This is how you answer questions like *“how are my retirement accounts doing together?”* or *“what’s my taxable allocation?”* without merging or moving anything.


Portfolios are purely a reporting overlay. Adding an account to a portfolio doesn’t move any holdings or change your overall totals – it just gives you another way to look at them.


------------------------------------------------------------------------

**Next:** <a href="/docs/guide/dashboards/" class="font-medium underline underline-offset-4">Dashboards</a> shows how each card reads, and <a href="/docs/concepts/tracking-modes/" class="font-medium underline underline-offset-4">Tracking Modes</a> explains transactions vs. holdings accounts.


<a href="/docs/guide/csv-import/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">CSV Import</a> <a href="/docs/guide/spending-budgets/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Spending &amp; Budgets</a>


On this page

- <a href="#accounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Accounts</a>
  - <a href="#add-an-account" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Add an account</a>
  - <a href="#account-numbers" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Account numbers</a>
  - <a href="#account-status" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Account status</a>
- <a href="#account-groups" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Account groups</a>
- <a href="#portfolios" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Portfolios</a>
  - <a href="#creating-a-portfolio" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Creating a portfolio</a>
  - <a href="#using-a-portfolio" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Using a portfolio</a>


