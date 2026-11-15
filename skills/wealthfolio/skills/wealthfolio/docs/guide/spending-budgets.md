> Source: https://wealthfolio.app/docs/guide/spending-budgets



Docs


Spending & Budgets


# Spending & Budgets

Track cash flow alongside your investments. Categorize transactions, build budgets, mark life events, and read narrative spending insights.


Last updated November 12, 2026


Spending & Budgets, introduced in **3.5**, brings your day-to-day cash flow into Wealthfolio, right next to your investments. Categorize transactions automatically, set budgets that fit how you actually spend, tag life events, and read spending insights that explain where your money went.

> Everything here is computed locally from activities already in your accounts. Nothing about your spending leaves your device.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-overview.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Spending overview with categories, budget progress, and trends" /> <img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-overview-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Spending overview with categories, budget progress, and trends" />
<figcaption>Spending overview with categories, budget progress, and trends</figcaption>
</figure>

## Transaction amounts

A transaction’s amount is the cash actually paid or received, with fees and taxes already applied. Those charge fields do not reduce cash a second time. After the 3.8 upgrade, check **Activities → Needs review** for older amounts that need comparison with your statement. Correcting an amount can also change historical spending totals. See <a href="/docs/concepts/activity-fields/" class="font-medium underline underline-offset-4">Activity Fields</a>.

## Choosing spending accounts

Spending features work across the accounts you opt in. You can include multiple **cash** and **credit-card** accounts; their activities are aggregated into one cash-flow view.

- **Charges** (withdrawals, fees, interest) count as spending.
- **Refunds / credits** reduce spending.
- **Credit-card payments** move money between your own accounts, so they stay visible without double-counting as spending.
- Money moving from a cash account into an investing account is classified as **Saving**, kept in its own bucket rather than counted as spend.
- A linked transfer between two credit cards or loans doesn’t count as **Saved**, even when the other account isn’t in Spending. A transfer from a card to an investment account still counts. After the 3.13 update, past months with such a transfer show less saved.
- Money brought back from a savings or investment account by a linked transfer counts against saving. Totals show **Net saved**: what went to savings minus what came back, negative when more came back.
- Transfers between your spending accounts stay neutral.
- Credits imported into a cash account without a subtype are listed in **Activities → Spending**. They change the balance but count as neither spending nor income.

A deposit or withdrawal that is really a transfer between your own accounts can become one. Use **Make it a transfer…** in the transaction’s row menu, or under **Transfer** in its edit sheet. Pick the matching activity in the other account, within 7 days, or choose **Create it in another account**. The pair then stops counting as an expense and an income.

The edit sheet’s type list no longer has Transfer In and Transfer Out. To change only the type, use **Change to Transfer In** or **Change to Transfer Out** instead. The transaction becomes an external transfer, and **Change to Deposit** or **Change to Withdrawal** turns it back. A linked transfer has to be unlinked first.


Credit cards are fully supported. Track card spending, payments, and transfers in one place without inflating your totals.


## Categorizing transactions

Every transaction can be assigned to a category. You set up rules once, and Wealthfolio categorizes new transactions for you, with AI to help with whatever’s left.

### Categories

Manage categories in **Settings → Spending tracker**. The category picker shows them as a tree, each parent followed by its own children, with their icons. Category fields and transaction rows and cards show the icon too.

- **Move a category** under another parent, or to the top level, from its edit dialog: change **Parent category**, or pick **None (top level)**. Its transactions keep their category, and reports and budgets count it under its new parent. A category with subcategories can’t be moved, and a top-level category with budget targets can’t be moved until you remove them.
- **Delete** a category you never used. Deleting one you’ve used merges it into another category of the same kind (expense, income, or savings): pick it under **Move into…**, check the review, then press **Move and delete**. Its transactions, split lines, rules, and budget amounts move over, and the review shows each budget as **Current** + **Added** = **New total**. Past reports use the new category, and the merge can’t be undone. Some merges are blocked until you fix the cause, for example a category with subcategories or with saved rollover settings.

### Rules

A rule matches a transaction’s description and assigns a category. Each rule has:


| Setting    | Options                                                 |
|------------|---------------------------------------------------------|
| Match type | `contains`, `starts with`, `exact`, or `regex`          |
| Pattern    | The text or expression to match against the description |
| Priority   | Higher-priority rules win when several rules match      |
| Scope      | All accounts or a specific account                      |
| Taxonomy   | Spending category, income source, or savings category   |


You can start from **rule presets** (a library of common merchant/category rules), then tweak them. Presets are available for the United States, Canada, the United Kingdom, Spain, Germany, France, the Netherlands, Australia, New Zealand, Sweden, and Italy. The Italy preset, for Italian banks, covers supermarkets, utilities, telecom and home internet, streaming, fuel, transport, tolls and parking, healthcare, shopping, taxes and PagoPA, bank fees, and income. Refunds aren’t filed as spending.

Rules can be **re-run** against all transactions or only the uncategorized ones, and Wealthfolio tracks how each assignment was made (rule, AI suggestion, or your own override).

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-rules.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Categorization rules with match types, priorities, and presets" /> <img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-rules-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Categorization rules with match types, priorities, and presets" />
<figcaption>Categorization rules with match types, priorities, and presets</figcaption>
</figure>

### AI suggestions

For transactions no rule covers, the AI assistant can propose categories. Review the proposals, accept the ones that look right, and optionally turn them into reusable rules. See the <a href="/docs/guide/ai-assistant/" class="font-medium underline underline-offset-4">AI Assistant</a> guide for setup.


A single transaction can hold more than one assignment. For example, it can be split across a spending category and a savings category, each with its own weight.


Recategorizing or editing a split transaction shows what happens to the split, and asks before removing it. To give a split transaction a single category again, use **Replace splits with one category** in the split editor.

### Editing many transactions in a grid

**Activities → Spending** has the same view switch as the Investments tab: **View mode** shows the list and **Edit mode** a grid. In the grid, change the date, account, type, category, amount, currency, or comment of many rows, paste or fill across cells, then **Save** them together. Phones and narrow screens keep the list.

## Budgets

Open **Budgets** to plan a month and watch actuals fill in against your targets.

### Groups and targets

Categories are organized into **budget groups**: Needs, Wants, Savings, Giving, Personal, and Other by default, each with its own colour and icon. You can budget at two levels:

- **Category targets**: a monthly target per category.
- **Group buffer**: an extra amount at the group level. The group total is the sum of its category targets plus its buffer.

Any group except Other can be deleted with **Delete group** in the group’s menu, built-in groups included. Its categories and monthly buffers move to a group you pick, and monthly budgets add up instead of replacing the other group’s. **Reset to defaults** brings the built-in groups back.

### Savings goals

Savings categories appear in Budgets and in the default plan (**Settings → Spending tracker → Default monthly budget plan**), each with a **Savings goal**. The goal fills with the money you moved to savings that month, and groups and totals show what you saved. A savings goal never shows as overspent. You can move a savings category to another group, and roll an unmet goal into the next month.

### Monthly periods, rollovers, and copy

- Budgets are scoped to a month (a `YYYY-MM` period). Default targets apply to every month, and you can **override** any single month.
- **Rollover** carries an unused or overspent balance forward into the next month. Enable it per category or per group.
- **Remove rollover setting**, in the group’s menu, clears a group’s saved rollover after a confirmation. Rollover balances are recalculated for all months, and categories and targets are kept. A group can’t be deleted until its rollover setting is removed.
- **Copy last month** clones a previous month’s plan into the current one in a click, so you don’t rebuild your budget every month.

The budget snapshot shows, per category and group: the target, the actual spend, the remaining amount (`target − actual`), and an **overspent** flag when you’ve gone over.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-budget.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Budget editor with groups, category targets, and rollover settings" /> <img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-budget-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Budget editor with groups, category targets, and rollover settings" />
<figcaption>Budget editor with groups, category targets, and rollover settings</figcaption>
</figure>

## Life events

Mark events like a vacation, a wedding, or a home renovation on a timeline and tag the transactions that belong to them. Each event then totals up its true cost.

- Events are date-ranged (a start and end date) and colour-tagged. Several event types are seeded, and you can create your own.
- Tag any transaction to an event to include it in that event’s total.
- An event summary shows the total spent, the transaction count, a breakdown by category, and a day-by-day spending chart.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-events.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Events timeline with a per-event spending breakdown" /> <img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-events-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Events timeline with a per-event spending breakdown" />
<figcaption>Events timeline with a per-event spending breakdown</figcaption>
</figure>

## Spending insights

Spending insights is the **Spending** tab in **Insights**, next to **Overview**, **Performance**, and **Income**, with the same cards and period selector as the other tabs. It shows only when spending is turned on. It reads like a short narrative in three stages.

The period buttons are 1W, This month, 3M, 6M, YTD, and 1Y. The **Previous period** and **Next period** arrows step through the period you picked, and the calendar’s **Month** and **Year** tabs jump to any completed month or calendar year. **Last month** is gone: press **Previous period** from **This month**, or pick the month under **Month**.

To see last period’s bars beside this period’s, use **Compare to prior period** on the dashboard’s Spending tab. See <a href="/docs/guide/dashboards/#spending" class="font-medium underline underline-offset-4">Portfolio Dashboards</a>.

### 1 · Where I am

- **Pace**: your trailing 7-day average daily spend, days elapsed and remaining, and projected total for the period, compared against your budgeted pace. A health status reads `on track`, `approaching`, `over`, or `cashflow negative`.
- **Spent this period**: the period total with a change versus the previous period, plus the category breakdown and top movers. A calendar month is compared with the whole previous month.
- **Net cash flow**: income minus outflow minus net saved, over time.
- **Money flow**: where your money came from and where it went. Money brought back from savings shows as **From savings** beside income, and money moved to savings as **To savings**.
- **Breakdown**: a hierarchical category table of actual versus budget.

### 2 · What changed

- A plain-language headline (“You spent \$X this period vs. \$Y last period”) with the percentage change.
- **Category movers**: what is new, what ended, and which categories rose or fell the most, ranked by impact.
- Per-category sparklines and a table of the biggest increases and decreases.

### 3 · When & where

- A **weekday × hour heatmap** of the last several weeks; click any cell to see the transactions in that time slot.
- The **events** timeline, with each event expandable to its category breakdown and daily spend.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-insights.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Narrative insights: pace, cashflow, and the category breakdown" /> <img src="https://assets.wealthfolio.app/images/screenshots/spending/spending-insights-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Narrative insights: pace, cashflow, and the category breakdown" />
<figcaption>Narrative insights: pace, cashflow, and the category breakdown</figcaption>
</figure>

### Multi-currency

Spending is reported in your base currency. When transactions span several currencies, amounts are **FX-converted** using rates from the period-end date, and the page notes this. Native (original- currency) totals remain available so nothing is hidden behind the conversion.

### Drilling in

Almost every number is clickable:

- A **category** row opens a filtered transaction list (including its subcategories).
- A **heatmap** cell opens the transactions for that weekday and hour.
- An **event** opens its breakdown by category and daily spend.

## Related

- <a href="/docs/guide/activities/" class="font-medium underline underline-offset-4">Activities</a>: how transactions get into Wealthfolio.
- <a href="/docs/guide/ai-assistant/" class="font-medium underline underline-offset-4">AI Assistant</a>: AI category suggestions and assisted import.
- <a href="/docs/guide/allocation-targets/" class="font-medium underline underline-offset-4">Allocation Targets &amp; Rebalancing</a>: the other major 3.5 module.


<a href="/docs/guide/accounts/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Accounts &amp; Portfolios</a> <a href="/docs/guide/allocation-targets/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Allocation Targets &amp; Rebalancing</a>


On this page

- <a href="#transaction-amounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Transaction amounts</a>
- <a href="#choosing-spending-accounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Choosing spending accounts</a>
- <a href="#categorizing-transactions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Categorizing transactions</a>
  - <a href="#categories" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Categories</a>
  - <a href="#rules" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Rules</a>
  - <a href="#ai-suggestions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">AI suggestions</a>
  - <a href="#editing-many-transactions-in-a-grid" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Editing many transactions in a grid</a>
- <a href="#budgets" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Budgets</a>
  - <a href="#groups-and-targets" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Groups and targets</a>
  - <a href="#savings-goals" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Savings goals</a>
  - <a href="#monthly-periods-rollovers-and-copy" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Monthly periods, rollovers, and copy</a>
- <a href="#life-events" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Life events</a>
- <a href="#spending-insights" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Spending insights</a>
  - <a href="#1--where-i-am" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1 · Where I am</a>
  - <a href="#2--what-changed" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2 · What changed</a>
  - <a href="#3--when--where" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3 · When &amp; where</a>
  - <a href="#multi-currency" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Multi-currency</a>
  - <a href="#drilling-in" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Drilling in</a>
- <a href="#related" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Related</a>


