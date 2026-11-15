> Source: https://wealthfolio.app/docs/addons/api-reference



Docs


Addon API Reference


# Addon API Reference

Complete reference for Wealthfolio addon APIs.


Last updated November 12, 2026


# API Reference

Complete reference for APIs available to Wealthfolio addons. Data and privileged host APIs require appropriate permissions in `manifest.json`; baseline UI, navigation, packaged assets, query, storage, toast, and logging capabilities do not.

## Context Overview

The `AddonContext` is provided to your addon’s `enable` function:

``` mb-4
export interface AddonContext {
  ui: {
    root: HTMLElement;
  };
  sidebar: SidebarManager;
  router: RouterManager;
  assets: AddonAssets;
  onDisable(callback: () => void): void;
  api: HostAPI;
}
```

Basic usage:

``` mb-4
export default async function enable(ctx: AddonContext) {
  const accounts = await ctx.api.accounts.getAll();
  ctx.api.logger.info(`Loaded ${accounts.length} accounts`);

  // UI integration
  ctx.sidebar.addItem({
    /* ... */
  });
  ctx.router.add({
    /* ... */
  });

  const logoUrl = await ctx.assets.getUrl('assets/logo.png');
  ctx.api.logger.debug(`Loaded private asset ${logoUrl}`);

  // Cleanup
  ctx.onDisable(() => {
    // cleanup code
  });
}
```

## Packaged Assets API

`ctx.assets` exposes private non-JavaScript/CSS files indexed from `assets/**` and `dist/assets/**`. JavaScript and CSS in those roots remain runtime modules and styles. No manifest asset list or permission is required. This API was added in Wealthfolio 3.7, so addons using it must set `minWealthfolioVersion` to `3.7.0` or newer.

``` mb-4
interface AddonAsset {
  path: string;
  mimeType: string;
  size: number;
}

interface AddonAssets {
  list(): readonly AddonAsset[];
  has(path: string): boolean;
  getBlob(path: string): Promise<Blob>;
  getUrl(path: string): Promise<string>;
}
```

### `list(): readonly AddonAsset[]`

Lists public logical paths and metadata. Host filesystem paths and internal opaque identifiers are never exposed.

### `has(path: string): boolean`

Checks a normalized logical package path. Invalid and traversing paths return `false`.

### `getBlob(path: string): Promise<Blob>`

Loads asset bytes lazily and verifies them against the indexed package generation. Concurrent calls share a load; failed calls may be retried.

``` mb-4
const configBlob = await ctx.assets.getBlob('assets/config.json');
const config = JSON.parse(await configBlob.text());

const wasmBlob = await ctx.assets.getBlob('dist/assets/module.wasm');
await WebAssembly.instantiate(await wasmBlob.arrayBuffer());
```

### `getUrl(path: string): Promise<string>`

Returns a cached Blob URL scoped to the current addon sandbox. Wealthfolio revokes it automatically on reload or disable; never persist it in storage.

``` mb-4
const logoUrl = await ctx.assets.getUrl('assets/logo.png');
const fontUrl = await ctx.assets.getUrl('dist/assets/font.woff2');
```

Packaged CSS resolves local `url(...)` values relative to the CSS file. Root-relative values resolve from the package root, while `data:` and `blob:` values are preserved. Remote CSS URLs and `@import` are rejected. JavaScript and JSX asset strings are not rewritten, so use `getUrl()` for images, fonts, media, and other URL consumers.

Package limits are 256 entries across code and assets, 5 MiB per file, and 25 MiB total. Asset roots must be directories and symlinks are rejected.

Blob URLs may be used by images, fonts, media elements, and WebAssembly. Worker and service-worker entry points, popups, direct network access, and remote CSS imports are intentionally unavailable inside the addon sandbox.


`ctx.assets` is the private package registry. The similarly named `ctx.api.assets` domain below reads and updates financial instruments.


## API Domains

The API is organized into host-brokered domains:


| Domain | Description | Key Functions |
|----|----|----|
| **Accounts** | Account management | `getAll`, `create` |
| **Portfolio** | Holdings and valuations | `getHoldings`, `getIncomeSummary`, `update`, `recalculate` |
| **Activities** | Trading transactions | `getAll`, `create`, `import`, `search`, `update` |
| **Market** | Market data and symbols | `searchTicker`, `sync`, `getProviders`, `fetchDividends` |
| **Performance** | Performance metrics | `calculateHistory`, `calculateSummary` |
| **Packaged Assets** | Private package files | `list`, `has`, `getBlob`, `getUrl` |
| **Financial Assets** | Asset profiles | `getProfile`, `updateProfile`, `updateQuoteMode` |
| **Allocation Targets** | Targets and drift | `getAll`, `getDrift` |
| **Quotes** | Price quotes | `update`, `getHistory` |
| **Goals** | Financial goals | `getAll`, `create`, `update`, `getFunding`, `saveFunding` |
| **Contribution Limits** | Investment limits | `getAll`, `create`, `update`, `calculateDeposits` |
| **Exchange Rates** | Currency rates | `getAll`, `update`, `add`, `getRatesForDates` |
| **Spending** | Spending and budgets | `getContext`, `getBudget`, `getReport`, `searchCashActivities`, `assignCategory` |
| **Settings** | App configuration | `get`, `update`, `backupDatabase` |
| **Files** | File operations | `openCsvDialog`, `openSaveDialog` |
| **Snapshots** | Holdings snapshots | `getAll`, `getByDate`, `save`, `checkImport`, `importSnapshots`, `delete` |
| **Events** | Real-time events | `onUpdateComplete`, `onSyncComplete`, `onDrop` |
| **Secrets** | Secure storage | `get`, `set`, `delete` |
| **Storage** | Durable key-value store | `get`, `set`, `delete` |
| **Network** | Brokered HTTPS requests | `request` |
| **Logger** | Logging operations | `error`, `info`, `warn`, `debug`, `trace` |
| **Navigation** | Route navigation | `navigate` |
| **Query** | React Query integration | `getClient`, `invalidateQueries`, `refetchQueries` |
| **Toast** | User notifications | `success`, `error`, `warning`, `info` |


## Accounts API

Read and create user accounts.

### `getAll(): Promise<Account[]>`

Retrieves all user accounts.

``` mb-4
const accounts = await ctx.api.accounts.getAll();

interface Account {
  id: string;
  name: string;
  accountType: AccountType;
  group?: string;
  currency: string;
  isDefault: boolean;
  isActive: boolean;
  isArchived: boolean;
  trackingMode: 'TRANSACTIONS' | 'HOLDINGS' | 'NOT_SET';
  createdAt: Date;
  updatedAt: Date;
  platformId?: string;
  accountNumber?: string;
  meta?: string;
  provider?: string;
  providerAccountId?: string;
}
```

`Account` has no balance. Wealthfolio 3.13 removed `balance` from the SDK type; the app never returned it. For account values, use `portfolio.getLatestValuations()`, which needs the `portfolio` permission.

#### `create(account: unknown): Promise<Account>`

Creates a new account. The SDK currently exposes the input as `unknown`; the host validates the payload at runtime.

``` mb-4
const newAccount = await ctx.api.accounts.create({
  name: 'My Investment Account',
  accountType: 'SECURITIES',
  currency: 'USD',
  isDefault: false,
  isActive: true,
  trackingMode: 'TRANSACTIONS',
});
```


**Data Validation**: Account creation validates required fields and business rules at runtime. Keep `accountType`, `currency`, and `trackingMode` aligned with Wealthfolio’s account model.


------------------------------------------------------------------------

## Portfolio API

Access portfolio data, holdings, and performance information with real-time updates.

### Methods

#### `getHoldings(accountId: string): Promise<Holding[]>`

Gets all holdings for a specific account with current valuations. From Wealthfolio 3.13, it fails while any account’s calculation is pending or has failed.

``` mb-4
const holdings = await ctx.api.portfolio.getHoldings('account-123');

// Example holding structure
interface Holding {
  id: string;
  holdingType: HoldingType;
  accountId: string;
  instrument?: Instrument | null;
  assetKind?: AssetKind | null;
  quantity: number;
  openDate?: string | Date | null;
  lots?: Lot[] | null;
  localCurrency: string;
  baseCurrency: string;
  fxRate?: number | null;
  marketValue: MonetaryValue;
  costBasis?: MonetaryValue | null;
  price?: number | null;
  unrealizedGain?: MonetaryValue | null;
  unrealizedGainPct?: number | null;
  realizedGain?: MonetaryValue | null;
  realizedGainPct?: number | null;
  totalGain?: MonetaryValue | null;
  totalGainPct?: number | null;
  income?: MonetaryValue | null;
  totalReturn?: MonetaryValue | null;
  totalReturnPct?: number | null;
  returnBasis?: MonetaryValue | null;
  dayChange?: MonetaryValue | null;
  dayChangePct?: number | null;
  prevCloseValue?: MonetaryValue | null;
  weight: number | null;
  asOfDate: string;
}

interface MonetaryValue {
  local: number | null;
  base: number | null;
}
```

From Wealthfolio 3.13, `weight` and a `MonetaryValue`’s `local` and `base` can be `null` when the host can’t value them. Check for `null` before doing arithmetic. `AmountDisplay` and `GainAmount` from `@wealthfolio/ui` accept `null` or `undefined` and show ”—”.

#### `getHolding(accountId: string, assetId: string): Promise<Holding | null>`

Gets a specific holding with detailed information.

``` mb-4
const holding = await ctx.api.portfolio.getHolding('account-123', 'asset-456');
```

#### `update(): Promise<void>`

Triggers a portfolio update/recalculation across all accounts.

``` mb-4
await ctx.api.portfolio.update();
```

#### `recalculate(): Promise<void>`

Forces a complete portfolio recalculation from scratch.

``` mb-4
await ctx.api.portfolio.recalculate();
```

#### `getIncomeSummary(): Promise<IncomeSummary[]>`

Gets comprehensive income summary across all accounts.

``` mb-4
const income = await ctx.api.portfolio.getIncomeSummary();
```

From Wealthfolio 3.13, each `IncomeByAsset` in `byAsset` has an optional `dividendIncome`: the part of the asset’s `income` that is dividends. `income` still counts every income type. Older hosts leave `dividendIncome` out.

#### `getHistoricalValuations(accountId?: string, startDate?: string, endDate?: string): Promise<AccountValuation[]>`

Gets historical portfolio valuations for charts and analysis.

``` mb-4
const history = await ctx.api.portfolio.getHistoricalValuations(
  'account-123', // optional, omit for all accounts
  '2024-01-01',
  '2024-12-31'
);
```

#### `getLatestValuations(accountIds: string[]): Promise<AccountValuation[]>`

Gets latest valuations for a set of accounts.

``` mb-4
const valuations = await ctx.api.portfolio.getLatestValuations(['account-1', 'account-2']);
```

------------------------------------------------------------------------

## Activities API

Manage trading activities, transactions, and data imports with advanced search capabilities.

### Methods

#### `getAll(accountId?: string): Promise<ActivityDetails[]>`

Gets all activities, optionally filtered by account.

``` mb-4
// All activities across all accounts
const allActivities = await ctx.api.activities.getAll();

// Activities for specific account
const accountActivities = await ctx.api.activities.getAll('account-123');
```

#### `search(page: number, pageSize: number, filters: ActivitySearchFilters, searchKeyword: string, sort?: ActivitySort): Promise<ActivitySearchResponse>`

Advanced search with pagination and filters.

``` mb-4
const results = await ctx.api.activities.search(
  0, // zero-based page index
  50, // pageSize
  {
    // filters
    accountIds: ['account-123'],
    activityTypes: ['BUY'],
    symbol: 'AAPL',
  },
  'AAPL', // searchKeyword
  { id: 'date', desc: true } // sort
);
```

### Amount, charges, and review

From 3.8, `amount` is the final cash magnitude, with fees and taxes already applied. A BUY amount includes its fees; a DIVIDEND or INTEREST amount is net of withholding. Runtime readers use the saved total without deducting charges again. All monetary inputs use the activity currency; `fxRate` is expressed as account-currency units per activity-currency unit. A positive supplied rate books BUY/SELL cash in account currency. Without it, trade cash stays in activity currency. Non-trade cash stays in activity currency even with an FX rate; that rate can still affect contribution reporting.

- On create/import, omitted trade totals can be derived from quantity, price, the asset multiplier, fee, and tax. Gross trade totals can be converted to final totals.
- Import mismatches preserve the total and set `needsReview`. Missing totals that cannot be derived leave imported rows as Draft for review.
- On manual create/update, `needsReview: false` confirms a custom total. Set it only after the user has checked that amount; do not use it as a default to suppress review.
- On update, omitting `amount` while changing trade details can recalculate it. Send the intended final amount explicitly when preserving a custom total. Clearing the amount requests calculation from the trade details. A currency-only edit does not convert it.
- `status` controls inclusion in calculations. `needsReview` is independent.

See <a href="/docs/concepts/activity-fields/" class="font-medium underline underline-offset-4">Activity Fields</a> for field meanings and exceptions.

#### `create(activity: ActivityCreate): Promise<Activity>`

Creates a new activity with validation. Wealthfolio 3.8 adds optional `status` and `needsReview` fields to `ActivityCreate`.

``` mb-4
const activity = await ctx.api.activities.create({
  accountId: 'account-123',
  activityType: 'BUY',
  activityDate: '2026-09-04',
  asset: { symbol: 'AAPL' },
  quantity: 100,
  unitPrice: 150.5,
  currency: 'USD',
  status: 'POSTED',
});
```

#### `update(activity: ActivityUpdate): Promise<Activity>`

Updates an existing activity with conflict detection. Wealthfolio 3.8 adds the optional `status` and `needsReview` fields. Omit `asset` to preserve the current asset association; pass `asset: {}` to clear it.

``` mb-4
const updated = await ctx.api.activities.update({
  ...editableActivity, // ActivityUpdate
  quantity: 150,
  unitPrice: 145.75,
  needsReview: false,
});
```

Addons using the review fields or asset patch semantics must set `minWealthfolioVersion` to `3.8.0` or newer.

#### `saveMany(request: ActivityBulkMutationRequest): Promise<ActivityBulkMutationResult>`

Efficiently creates, updates, or deletes multiple activities in a single transaction.

``` mb-4
const result = await ctx.api.activities.saveMany({
  creates: [
    {
      accountId: 'account-123',
      activityType: 'DIVIDEND',
      activityDate: '2026-09-04',
      amount: 25,
      currency: 'USD',
    },
  ],
  updates: [],
  deleteIds: [],
});
```

#### `import(activities: ActivityImport[]): Promise<ImportActivitiesResult>`

Imports validated activities with duplicate detection.

``` mb-4
const imported = await ctx.api.activities.import(checkedActivities);
```

From Wealthfolio 3.12, an import can record a <a href="/docs/concepts/activity-types/#fund-conversions" class="font-medium underline underline-offset-4">fund conversion</a>: two `ADJUSTMENT` rows, one with subtype `CONVERSION_OUT` for the fund and units that leave and one with `CONVERSION_IN` for the fund and units that arrive, sharing a `sourceGroupId`. Both rows go in the same import; a conversion row without its other row fails the import. Other rows ignore `sourceGroupId`.

``` mb-4
const conversion: ActivityImport[] = [
  {
    accountId: 'account-123',
    activityType: 'ADJUSTMENT',
    subtype: 'CONVERSION_OUT',
    date: '2026-10-15',
    symbol: 'FUND-A',
    quantity: 100,
    currency: 'EUR',
    sourceGroupId: 'switch-fund-a-fund-b',
    isValid: true,
    isDraft: false,
  },
  {
    accountId: 'account-123',
    activityType: 'ADJUSTMENT',
    subtype: 'CONVERSION_IN',
    date: '2026-10-15',
    symbol: 'FUND-B',
    quantity: 80,
    currency: 'EUR',
    sourceGroupId: 'switch-fund-a-fund-b',
    isValid: true,
    isDraft: false,
  },
];

const checked = await ctx.api.activities.checkImport(conversion);
const result = await ctx.api.activities.import(checked);
```

From Wealthfolio 3.13, an `ActivityImport` row takes three optional fields. Older hosts ignore them.

- `charges`: labelled lines that break the row’s `fee` and `tax` down as the statement listed them, such as commission and stamp duty. Each line is a `fee` or a `tax`, with a free-text label and an amount in the row’s currency. The lines must add up to both totals, or the row is rejected and `checkImport` flags it. They are stored in the activity’s `metadata.charges` and change no calculation. If a later edit changes a total without new lines, the stored lines are dropped.
- `sourceRecordId`: your own ID for the transaction the row records, such as a statement reference. A row with one is a duplicate of the activity your addon imported with the same ID into the same account, whatever its values or comment, and is skipped. Identical transactions with different IDs import separately. Keep each ID the same in every import and different for every separate transaction. A row with an ID also matches, by its values, an activity imported before you sent IDs. IDs are trimmed, and blank IDs count as absent. The activity stores the ID as `addon:<your addon id>:<ID>`. Matching by ID is limited to your addon, but the values fallback can match any import without an ID in the account, including CSV imports and other addons’ imports.
- `metadata`: details to keep with the activity, stored in its metadata under `addons[<your addon id>]`.

``` mb-4
interface ActivityCharge {
  category: 'fee' | 'tax';
  label: string;
  amount: number | string;
}

const rows: ActivityImport[] = [
  {
    accountId: 'account-123',
    activityType: 'BUY',
    date: '2026-11-03',
    symbol: 'FUND-A',
    quantity: 20,
    unitPrice: 30,
    fee: 4.9,
    tax: 2.4,
    currency: 'EUR',
    charges: [
      { category: 'fee', label: 'Commission', amount: 4.9 },
      { category: 'tax', label: 'Stamp duty', amount: 2.4 },
    ],
    sourceRecordId: 'statement-2026-11-0042',
    metadata: { statementPage: 3 },
    isValid: true,
    isDraft: false,
  },
];

const checked = await ctx.api.activities.checkImport(rows);
const result = await ctx.api.activities.import(checked);
```

#### `checkImport(activities: ActivityImport[]): Promise<ActivityImport[]>`

Validates activities before import with error reporting.

``` mb-4
const validated = await ctx.api.activities.checkImport(activities);
```

#### `getImportMapping(accountId: string, contextKind?: string): Promise<ImportMappingData>`

Gets import mapping configuration for an account. `contextKind` defaults to `"ACTIVITY"`.

``` mb-4
const mapping = await ctx.api.activities.getImportMapping('account-123');
```

#### `saveImportMapping(mapping: ImportMappingData): Promise<ImportMappingData>`

Save import mapping configuration.

``` mb-4
const savedMapping = await ctx.api.activities.saveImportMapping(mapping);
```

### Activity Types Reference


| Type           | Use Case               | Cash Impact    | Holdings Impact    |
|----------------|------------------------|----------------|--------------------|
| `BUY`          | Purchase securities    | Decreases cash | Increases quantity |
| `SELL`         | Dispose of securities  | Increases cash | Decreases quantity |
| `SPLIT`        | Stock split            | No change      | Adjusts quantity   |
| `DIVIDEND`     | Cash dividend received | Increases cash | No change          |
| `INTEREST`     | Interest earned        | Increases cash | No change          |
| `DEPOSIT`      | Add funds              | Increases cash | No change          |
| `WITHDRAWAL`   | Remove funds           | Decreases cash | No change          |
| `TRANSFER_IN`  | Assets moved in        | Varies         | Increases quantity |
| `TRANSFER_OUT` | Assets moved out       | Varies         | Decreases quantity |
| `FEE`          | Brokerage fees         | Decreases cash | No change          |
| `TAX`          | Taxes paid             | Decreases cash | No change          |
| `CREDIT`       | Account credit         | Increases cash | No change          |
| `ADJUSTMENT`   | Manual adjustment      | Varies         | Varies             |
| `UNKNOWN`      | Unclassified activity  | Varies         | Varies             |


------------------------------------------------------------------------

## Market Data API

Access market data, search symbols, and sync with external providers.

### Methods

> Throughout the Market, Assets, and Quotes APIs, `assetId` is Wealthfolio’s opaque asset ID, not its ticker symbol. Obtain it from an `Asset` or `Holding.instrument`. `fetchDividends()` is the exception: it accepts a ticker symbol.

#### `searchTicker(query: string): Promise<SymbolSearchResult[]>`

Search for ticker symbols across multiple data providers.

``` mb-4
const results = await ctx.api.market.searchTicker('AAPL');
```

#### `syncHistory(): Promise<void>`

Syncs historical market data for all portfolio holdings.

``` mb-4
await ctx.api.market.syncHistory();
```

#### `sync(assetIds: string[], refetchAll: boolean, refetchRecentDays?: number): Promise<void>`

Syncs market data for specific assets with cache control.

``` mb-4
// Sync latest data (uses cache if recent)
await ctx.api.market.sync(['asset-uuid-1', 'asset-uuid-2'], false);

// Force refresh all data
await ctx.api.market.sync(['asset-uuid-1', 'asset-uuid-2'], true);

// Force-refresh only the most recent seven days
await ctx.api.market.sync(['asset-uuid-1'], true, 7);
```

#### `getProviders(): Promise<MarketDataProviderInfo[]>`

Gets available market data providers and their status.

``` mb-4
const providers = await ctx.api.market.getProviders();
```

#### `fetchDividends(symbol: string, options?: FetchDividendsOptions): Promise<DividendEvent[]>`

Fetches dividend history for a symbol.

``` mb-4
const dividends = await ctx.api.market.fetchDividends('AAPL', {
  startDate: '2024-01-01',
  endDate: '2024-12-31',
});
```

------------------------------------------------------------------------

## Assets API

Access and manage asset profiles and data sources.

### Methods

#### `getProfile(assetId: string): Promise<Asset>`

Gets detailed asset profile information.

``` mb-4
const asset = await ctx.api.assets.getProfile('asset-uuid-1');
```

#### `updateProfile(payload: UpdateAssetProfile): Promise<Asset>`

Updates asset profile information.

``` mb-4
const updatedAsset = await ctx.api.assets.updateProfile({
  id: 'asset-uuid-1',
  name: 'Apple Inc.',
  kind: 'INVESTMENT',
  // ... displayCode, notes, quoteMode, providerConfig
});
```

#### `updateQuoteMode(assetId: string, quoteMode: string): Promise<Asset>`

Switches an asset between market-fetched and manual quotes (`MARKET` or `MANUAL`).

``` mb-4
const asset = await ctx.api.assets.updateQuoteMode('asset-uuid-1', 'MANUAL');
```

------------------------------------------------------------------------

## Allocation Targets API

Read the user’s <a href="/docs/guide/allocation-targets/" class="font-medium underline underline-offset-4">allocation targets</a> and compare holdings with them. The API is read-only: users create and edit targets in Wealthfolio. Weights and drift are in basis points (10000 = 100%).

This API requires Wealthfolio 3.13 or newer. Addons using it must set `minWealthfolioVersion` to `3.13.0` or newer. Both functions are in the high-risk `allocation-targets` category, and each needs its own grant:

``` mb-4
{
  "permissions": [
    {
      "category": "allocation-targets",
      "functions": ["getAll", "getDrift"],
      "purpose": "Show how holdings compare with your targets"
    }
  ]
}
```

### Methods

#### `getAll(): Promise<AllocationTarget[]>`

Gets the user’s targets, archived ones excluded, each with its scope, range settings, and category weights. Several targets can share a scope. Category IDs differ between installs, so use a weight’s `categoryKey` to tell categories apart.

``` mb-4
const targets = await ctx.api.allocationTargets.getAll();

type AllocationTargetScopeType = 'all' | 'portfolio' | 'account';
type AllocationBandType = 'absolute' | 'hybrid';

interface AllocationTargetWeight {
  /** Category id within the target's taxonomy. */
  categoryId: string;
  /** The category's stable key, e.g. `REAL_ESTATE`; ids differ between installs. */
  categoryKey: string;
  categoryName: string;
  targetBps: number;
}

interface AllocationTarget {
  id: string;
  name: string;
  scopeType: AllocationTargetScopeType;
  /** Account id or portfolio id; null when `scopeType` is `'all'`. */
  scopeId: string | null;
  /** Taxonomy the weights' categories belong to, e.g. `asset_classes`. */
  taxonomyId: string;
  /** Absolute range in bps; for `'hybrid'` bands, the floor of the range. */
  driftBandBps: number;
  bandType: AllocationBandType;
  /** Relative part of a hybrid range, in bps of the category's target. */
  relativeFactorBps: number;
  allowSells: boolean;
  wholeSharesOnly: boolean;
  /** Decimal string in the base currency. */
  minTradeAmount: string;
  maxTurnoverBps: number | null;
  weights: AllocationTargetWeight[];
  createdAt: string;
  updatedAt: string;
}
```

#### `getDrift(targetId: string): Promise<AllocationDrift | null>`

Compares current holdings with a target, by category of the target’s taxonomy, over the target’s own scope. Values are in the base currency. Returns `null` when no live target has that ID. It values holdings live, so call it when you need it rather than on a timer.

``` mb-4
const drift = await ctx.api.allocationTargets.getDrift(targets[0].id);

type AllocationDriftStatus = 'in_band' | 'underweight' | 'overweight' | 'not_targeted';

interface AllocationDriftRow {
  categoryId: string;
  categoryName: string;
  currentBps: number;
  targetBps: number;
  driftBps: number;
  currentValue: number;
  targetValue: number;
  valueDelta: number;
  /** Range applied to this category after resolving a hybrid band. */
  effectiveBandBps: number;
  status: AllocationDriftStatus;
  isCash: boolean;
}

interface AllocationDrift {
  targetId: string;
  scopeType: AllocationTargetScopeType;
  scopeId: string | null;
  baseCurrency: string;
  totalValue: number;
  maxDriftBps: number;
  outOfBandCount: number;
  deployableCash: number;
  rows: AllocationDriftRow[];
}
```

------------------------------------------------------------------------

## Quotes API

Manage price quotes and historical data.

### Methods

#### `update(assetId: string, quote: Quote): Promise<void>`

Updates quote information for an asset.

``` mb-4
await ctx.api.quotes.update('asset-uuid-1', {
  id: 'quote-uuid-1',
  createdAt: '2024-12-01T00:00:00Z',
  dataSource: 'MANUAL',
  timestamp: '2024-12-01T00:00:00Z',
  assetId: 'asset-uuid-1',
  open: 150,
  high: 151,
  low: 149,
  volume: 0,
  close: 150.5,
  adjclose: 150.5,
  currency: 'USD',
});
```

#### `getHistory(assetId: string): Promise<Quote[]>`

Gets historical quotes for an asset.

``` mb-4
const history = await ctx.api.quotes.getHistory('asset-uuid-1');
```

------------------------------------------------------------------------

## Performance API

Calculate portfolio and account performance metrics with historical analysis.

### Methods

#### `calculateHistory(itemType: 'account' | 'symbol', itemId: string, startDate?: string, endDate?: string): Promise<PerformanceResult>`

Calculates detailed performance history for charts and analysis.

``` mb-4
const history = await ctx.api.performance.calculateHistory(
  'account',
  'account-123',
  '2024-01-01',
  '2024-12-31'
);
```

#### `calculateSummary(args: { itemType: 'account' | 'symbol'; itemId: string; startDate?: string | null; endDate?: string | null; }): Promise<PerformanceResult>`

Calculates comprehensive performance summary with key metrics.

``` mb-4
const summary = await ctx.api.performance.calculateSummary({
  itemType: 'account',
  itemId: 'account-123',
  startDate: '2024-01-01',
  endDate: '2024-12-31',
});
```

#### `calculateAccountsSimple(accountIds: string[]): Promise<SimplePerformanceResult[]>`

Calculates simple performance metrics for multiple accounts efficiently.

``` mb-4
const performance = await ctx.api.performance.calculateAccountsSimple([
  'account-123',
  'account-456',
]);
```

------------------------------------------------------------------------

## Exchange Rates API

Manage currency exchange rates for multi-currency portfolios.

### Methods

#### `getAll(): Promise<ExchangeRate[]>`

Gets all exchange rates.

``` mb-4
const rates = await ctx.api.exchangeRates.getAll();
```

#### `update(updatedRate: ExchangeRate): Promise<ExchangeRate>`

Updates an existing exchange rate.

``` mb-4
const updatedRate = await ctx.api.exchangeRates.update({
  id: 'rate-123',
  fromCurrency: 'USD',
  toCurrency: 'EUR',
  rate: 0.85,
  source: 'MANUAL',
  timestamp: '2024-12-01T00:00:00Z',
});
```

#### `add(newRate: Omit<ExchangeRate, 'id'>): Promise<ExchangeRate>`

Adds a new exchange rate.

``` mb-4
const newRate = await ctx.api.exchangeRates.add({
  fromCurrency: 'USD',
  toCurrency: 'GBP',
  rate: 0.75,
  source: 'MANUAL',
  timestamp: '2024-12-01T00:00:00Z',
});
```

#### `getRatesForDates(pairs: ExchangeRateDateQuery[]): Promise<ExchangeRateDateResult[]>`

Gets one resolved rate for each requested currency pair and date. Dates must use `YYYY-MM-DD`. Resolution follows Wealthfolio’s normal FX rules, including normalized currencies, inverse and triangulated rates, nearest-date lookup, and the latest-rate fallback. Results preserve input order; a pair that cannot be resolved returns `rate: null` and an `error` without failing the batch.

This method requires Wealthfolio 3.8 or newer. Addons using it must set `minWealthfolioVersion` to `3.8.0` or newer.

``` mb-4
const results = await ctx.api.exchangeRates.getRatesForDates([
  { fromCurrency: 'USD', toCurrency: 'EUR', date: '2026-09-04' },
  { fromCurrency: 'CAD', toCurrency: 'JPY', date: '2026-09-04' },
]);
```

------------------------------------------------------------------------

## Spend Categorization API

Classify activities into Wealthfolio’s expense, income, or savings taxonomies using reusable categorization rules. Rules continue to apply to future matching imports. Addons can also read Spending reports, transactions, events, and budgets, assign categories and events, and set budget targets.

This API requires Wealthfolio 3.8 or newer. `getReport()` and `searchCashActivities()` require 3.9, and the context, budget, event, and category assignment functions require 3.12. Each function needs its own grant, in the category below. Declare only the functions your addon calls. Grants an addon already has don’t expand to new functions.


| Category | Risk Level | Functions |
|----|----|----|
| `spending` | Medium | `isEnabled`, `getCategories`, `getContext`, `getBudget`, `getEvents`, `getEventTypes`, `getReport`, `getRules`, `saveRule`, `deleteRule`, `rerunRules` |
| `activities` | High | `searchCashActivities`, `assignCategory`, `unassignCategory`, `setEvent` |
| `budgets` | High | `upsertBudgetTarget` |


The functions are all called on `ctx.api.spending`. For example, an addon that reads the budget and assigns categories declares:

``` mb-4
{
  "permissions": [
    {
      "category": "spending",
      "functions": ["getBudget"],
      "purpose": "Show this month's budget"
    },
    {
      "category": "activities",
      "functions": ["assignCategory"],
      "purpose": "Categorize imported card transactions"
    }
  ]
}
```

### Methods

#### `isEnabled(): Promise<boolean>`

Returns whether Spending is enabled. Categories and stored rules remain available while Spending is disabled, but `rerunRules()` returns `0` until Spending is enabled.

#### `getCategories(kind?: SpendCategoryKind): Promise<SpendCategory[]>`

Lists selectable categories with their display paths. Omit `kind` to load all three taxonomies.

``` mb-4
const categories = await ctx.api.spending.getCategories('expense');
```

#### `getRules(): Promise<CategorizationRule[]>`

Lists the rules created by the current addon through `saveRule()`.

``` mb-4
const rules = await ctx.api.spending.getRules();
```

#### `saveRule(rule: CategorizationRuleInput): Promise<CategorizationRule>`

Creates or updates a rule identified by the addon’s stable `ruleKey`. Reusing the same key updates the existing rule instead of creating a duplicate.

``` mb-4
const saved = await ctx.api.spending.saveRule({
  ruleKey: 'my-addon-rule-1',
  name: 'Groceries via MyBank',
  pattern: 'MYBANK GROCERY',
  matchType: 'contains',
  kind: 'expense',
  categoryId: 'cat_groceries',
  activityType: 'WITHDRAWAL',
  accountId: 'account-123',
});
```

#### `deleteRule(ruleKey: string): Promise<void>`

Deletes the rule created with this `ruleKey`. This is a no-op when the rule does not exist.

``` mb-4
await ctx.api.spending.deleteRule('my-addon-rule-1');
```

#### `rerunRules(onlyUncategorized?: boolean): Promise<number>`

Re-runs all categorization rules and returns the number of matching activities. The argument defaults to `true`, preserving existing assignments. Passing `false` may replace rule-, AI-, history-, or import-sourced assignments; manual assignments are always preserved.

``` mb-4
const matched = await ctx.api.spending.rerunRules();
```

### Context, reports, and transactions

#### `getContext(): Promise<SpendingContext>`

Returns whether Spending is enabled, the IDs of the accounts it covers, and the IDs of the categories excluded from it. `accountIds` is empty while Spending is off. Reading it never enables Spending or adds an account.

``` mb-4
const { enabled, accountIds, excludedCategoryIds } = await ctx.api.spending.getContext();
```

#### `getReport(request: SpendingReportRequest): Promise<SpendingReport>`

Returns income, outflow, and saving totals with category breakdowns for an inclusive RFC3339 date range. `current` covers the range and `prior` the same length of time just before it. Amounts are in `baseCurrency`, with exchange rates taken at each period’s end.

From Wealthfolio 3.12, each `SpendingPeriodSummary` has an optional `fromSavings`, the money brought back from savings, and `net` adds it: `income - outflow - saved + fromSavings`.

``` mb-4
const report = await ctx.api.spending.getReport({
  startDate: '2026-10-01T00:00:00Z',
  endDate: '2026-10-31T23:59:59Z',
});
```

#### `searchCashActivities(request: CashActivitySearchRequest): Promise<CashActivitySearchResponse>`

Searches activities in the accounts enabled for Spending, with their cash-flow bucket, category assignments, splits, and spending amounts. Page with `offset` and `limit`. `net` covers the whole filtered result and is present only on the first page.

Split amounts (`ActivitySplit.amount`, typed `string | number`) are exact decimal strings; Wealthfolio 3.11.0 returned numbers. Add them with decimal arithmetic, not `+`.

``` mb-4
const page = await ctx.api.spending.searchCashActivities({
  startDate: '2026-10-01T00:00:00Z',
  endDate: '2026-10-31T23:59:59Z',
  status: 'uncategorized',
  limit: 50,
});
```

#### `assignCategory(activityId: string, kind: SpendCategoryKind, categoryId: string): Promise<void>`

Sets an activity’s category in the `expense`, `income`, or `saving` taxonomy. It is saved as a manual assignment, so re-running rules never replaces it. An activity that has splits is refused, so its splits are never lost.

``` mb-4
await ctx.api.spending.assignCategory('activity-123', 'expense', 'cat_groceries');
```

#### `unassignCategory(activityId: string, kind: SpendCategoryKind): Promise<void>`

Clears an activity’s category in that taxonomy. It doesn’t clear split allocations.

``` mb-4
await ctx.api.spending.unassignCategory('activity-123', 'expense');
```

### Events and budgets

#### `getEvents(): Promise<SpendingEvent[]>`

Lists the user’s Spending events, each with its name, `eventTypeId`, and start and end dates.

``` mb-4
const events = await ctx.api.spending.getEvents();
```

#### `getEventTypes(): Promise<EventType[]>`

Lists event types. Built-in types have a stable `key`; types the user created have `key: null`.

``` mb-4
const eventTypes = await ctx.api.spending.getEventTypes();
```

#### `setEvent(activityId: string, eventId: string | null): Promise<void>`

Tags an activity with an event, or removes its tag when `eventId` is `null`. Pass `null` explicitly; the argument can’t be omitted. An event’s dates don’t restrict which activities it can tag.

``` mb-4
await ctx.api.spending.setEvent('activity-123', 'event-456');
await ctx.api.spending.setEvent('activity-123', null);
```

#### `getBudget(periodKey?: string): Promise<BudgetSnapshot>`

Returns the budget for a month (`YYYY-MM`), or for `'default'`, the default targets months inherit. Omit `periodKey` for the current month. `state` holds the stored groups, targets, and rollover settings; `computed` holds the rows and totals, in `computed.currency`. Reading the budget changes nothing, and the snapshot is empty while Spending is off.

``` mb-4
const budget = await ctx.api.spending.getBudget('2026-10');
```

From Wealthfolio 3.13, the budget keeps spending and savings apart. `computed.totals.spending*` and a group row’s `plannedTotal`, `actual`, `remaining`, and `overspent` count spending only: expense categories and group buffers. Savings categories report in `savingsPlanned` and `savingsActual` on the totals, and in `savingsTargetTotal` and `savingsActual` on each group row. A savings category is never overspent. The plan’s total allocation is `spendingPlanned + savingsPlanned`. Older hosts don’t return the savings fields.

#### `upsertBudgetTarget(target: NewBudgetTarget, periodKey?: string): Promise<BudgetSnapshot>`

Creates or updates a budget target, then returns the budget for `periodKey` (the current month when omitted). `target.periodKey` is `'default'` or a month (`YYYY-MM`). A default target applies to every month that inherits it, past months included; a month’s own target wins over it. `amount` is a decimal string. A `category` target names `taxonomyId` and `categoryId` only; a `group_buffer` target names `groupId` only.

``` mb-4
const budget = await ctx.api.spending.upsertBudgetTarget({
  periodKey: 'default',
  targetType: 'category',
  taxonomyId: category.taxonomyId, // a SpendCategory from getCategories('expense')
  categoryId: category.categoryId,
  amount: '450.00',
});
```

------------------------------------------------------------------------

## Contribution Limits API

Manage investment contribution limits and calculations.

### Methods

#### `getAll(): Promise<ContributionLimit[]>`

Gets all contribution limits.

``` mb-4
const limits = await ctx.api.contributionLimits.getAll();
```

From Wealthfolio 3.13, `ContributionLimit` has an optional `isRecurring`: the limit repeats every year. Set on the latest limit of a group, it makes Wealthfolio show the later years with the same amount until the user saves or edits one.

#### `create(newLimit: NewContributionLimit): Promise<ContributionLimit>`

Creates a new contribution limit.

``` mb-4
const limit = await ctx.api.contributionLimits.create({
  groupName: 'RRSP',
  contributionYear: 2024,
  limitAmount: 30000,
});
```

#### `update(id: string, updatedLimit: NewContributionLimit): Promise<ContributionLimit>`

Updates an existing contribution limit.

``` mb-4
const updatedLimit = await ctx.api.contributionLimits.update('limit-123', {
  groupName: 'RRSP',
  contributionYear: 2024,
  limitAmount: 31000,
});
```

#### `calculateDeposits(limitId: string): Promise<DepositsCalculation>`

Calculates deposits for a specific contribution limit. From Wealthfolio 3.13, it leaves out contributions the user excluded from that limit on its details page.

``` mb-4
const deposits = await ctx.api.contributionLimits.calculateDeposits('limit-123');
```

------------------------------------------------------------------------

## Goals API

Manage financial goals and funding rules.

### Methods

#### `getAll(): Promise<Goal[]>`

Gets all goals.

``` mb-4
const goals = await ctx.api.goals.getAll();
```

#### `create(goal: unknown): Promise<Goal>`

Creates a new goal.

``` mb-4
const goal = await ctx.api.goals.create({
  goalType: 'retirement',
  title: 'Retirement Fund',
  targetAmount: 500000,
  targetDate: '2040-01-01',
});
```

#### `update(goal: Goal): Promise<Goal>`

Updates an existing goal’s editable inputs. Wealthfolio calculates health, progress, and projection fields; values sent for them are ignored.

``` mb-4
const updatedGoal = await ctx.api.goals.update({
  ...existingGoal,
  targetAmount: 600000,
});
```

#### `getFunding(goalId: string): Promise<GoalAllocation[]>`

Gets funding rules for a specific goal. From Wealthfolio 3.12, savings goals can take part of an account that Retirement uses. `getFunding()` returns Retirement’s share as set, not what Retirement counts after savings goals, so the shares on one account can add up to more than 100%.

``` mb-4
const funding = await ctx.api.goals.getFunding('goal-123');
```

#### `saveFunding(goalId: string, rules: GoalAllocation[]): Promise<GoalAllocation[]>`

Saves funding rules for a specific goal.

``` mb-4
const savedFunding = await ctx.api.goals.saveFunding('goal-123', [
  {
    id: 'allocation-123',
    goalId: 'goal-123',
    accountId: 'account-456',
    sharePercent: 50,
  },
  // ... other funding rules
]);
```

`getAllocations()` and `updateAllocations()` still exist as deprecated compatibility shims. Prefer `getFunding(goalId)` and `saveFunding(goalId, rules)` for new addons.

------------------------------------------------------------------------

## Settings API

Manage application settings and configuration.

### Methods

#### `get(): Promise<Settings>`

Gets application settings.

``` mb-4
const settings = await ctx.api.settings.get();
```

#### `update(settingsUpdate: Partial<Settings>): Promise<Settings>`

Updates application settings.

``` mb-4
const updatedSettings = await ctx.api.settings.update({
  ...currentSettings,
  baseCurrency: 'EUR',
  // ... other settings
});
```

#### `backupDatabase(): Promise<{ filename: string }>`

Creates a database backup.

``` mb-4
const backup = await ctx.api.settings.backupDatabase();
```

### Theme, text size, and gain and loss colours

Addon pages follow the user’s theme, text size, and gain and loss colours, and update when the user changes them. Wealthfolio sets each one as an attribute on the addon page’s `<html>`, and `settings.get()` returns them as optional `Settings` fields. Hosts without a setting leave its field out.


| Setting | `Settings` field | `<html>` attribute | Values |
|----|----|----|----|
| Theme | `themeId` | `data-theme` | `classic`, `signature`, `ember`, `cupertino`, `newspaper`, `cyber`, `terminal`, `poster` |
| Text size | `textSize` | `data-text-size` | `small`, `default`, `large`, `extra-large` |
| Gain and loss colours | `gainColors` | `data-gain-colors` | `green-up` (the default), `red-up`, `red-up-blue-down` |


``` mb-4
const { themeId, textSize, gainColors } = await ctx.api.settings.get();
```

- **Theme:** there are eight themes, and new profiles start on `signature`. Addon pages get the theme’s colours through the host’s CSS variables. For charts, `--investments` is the portfolio value line and `--series-1` to `--series-8` are for lines compared on one axis. `--net-worth`, `--spending-accent`, `--spending-deep`, and `--spending-mid` are chart tokens too. `chartSliceColor(index)` from `@wealthfolio/ui` gives the colour for the item at a position in a composition, as the host’s donuts and breakdown lists use. Classic’s `--chart-*` and `--heatmap-*` values changed in 3.12, so addon charts that read them change colour in Classic.
- **Text size:** it scales the root font size. Sizes in `rem` grow with it; sizes in `px` don’t.
- **Gain and loss colours:** use `--gain` and `--loss` instead of `--success` and `--destructive` for a price or value going up or down. Each has `-subtle`, `-subtle-foreground`, and `-subtle-border` variants. `GainAmount`, `GainPercent`, and `AmountDisplay` already follow them.

``` mb-4
.price-up {
  color: var(--gain);
}

.price-down {
  color: var(--loss);
}
```

------------------------------------------------------------------------

## Files API

Handle file operations and dialogs.

### Methods

#### `openCsvDialog(): Promise<null | string | string[]>`

Opens a CSV file selection dialog.

``` mb-4
const files = await ctx.api.files.openCsvDialog();
if (files) {
  // Process selected files
}
```

#### `openSaveDialog(fileContent: Uint8Array | Blob | string, fileName: string): Promise<unknown>`

Opens a file save dialog.

``` mb-4
const result = await ctx.api.files.openSaveDialog(fileContent, 'export.csv');
```

------------------------------------------------------------------------

## Snapshots API

Manage holdings snapshots for accounts that use holdings tracking mode.

### Methods

#### `getAll(accountId: string, dateFrom?: string, dateTo?: string): Promise<SnapshotInfo[]>`

Gets snapshots for an account, optionally filtered by date range.

``` mb-4
const snapshots = await ctx.api.snapshots.getAll('account-123', '2024-01-01', '2024-12-31');
```

#### `getByDate(accountId: string, date: string): Promise<Holding[]>`

Gets holdings from a snapshot date.

``` mb-4
const holdings = await ctx.api.snapshots.getByDate('account-123', '2024-12-31');
```

#### `save(accountId: string, holdings: SnapshotHoldingInput[], cashBalances: Record<string, string>, snapshotDate?: string): Promise<void>`

Saves a holdings snapshot.

``` mb-4
await ctx.api.snapshots.save(
  'account-123',
  [{ symbol: 'AAPL', quantity: '10', currency: 'USD' }],
  { USD: '250.00' },
  '2024-12-31'
);
```

#### `checkImport(accountId: string, snapshots: SnapshotInput[]): Promise<CheckSnapshotImportResult>`

Validates snapshot import data before saving.

``` mb-4
const preview = await ctx.api.snapshots.checkImport('account-123', parsedSnapshots);
```

#### `importSnapshots(accountId: string, snapshots: SnapshotInput[]): Promise<SnapshotImportResult>`

Imports validated snapshots.

``` mb-4
const imported = await ctx.api.snapshots.importSnapshots('account-123', parsedSnapshots);
```

#### `delete(accountId: string, date: string): Promise<void>`

Deletes a snapshot for a date.

``` mb-4
await ctx.api.snapshots.delete('account-123', '2024-12-31');
```

------------------------------------------------------------------------

## Secrets API

Securely store and retrieve sensitive data like API keys and tokens. Secrets are stored in the OS keyring and scoped to your addon ID.

### Methods

#### `set(key: string, value: string): Promise<void>`

Stores a secret value encrypted and scoped to your addon.

``` mb-4
// Store API key securely
await ctx.api.secrets.set('api-key', 'your-secret-api-key');

// Store user credentials
await ctx.api.secrets.set('auth-token', userAuthToken);
```

#### `get(key: string): Promise<string | null>`

Retrieves a secret value (returns null if not found).

``` mb-4
const apiKey = await ctx.api.secrets.get('api-key');
if (apiKey) {
  // Use the value locally inside this addon only.
  // For HTTP Authorization headers, prefer ctx.api.network.request({ auth }).
}
```

#### `delete(key: string): Promise<void>`

Permanently deletes a secret.

``` mb-4
await ctx.api.secrets.delete('old-api-key');
```


**Security Note**: Secrets are scoped by addon ID. Other addons cannot access your secrets, and you cannot access theirs. For brokered network auth, declare `secrets.use` and pass `auth: { type: 'bearer' | 'basic', secretKey: '...' }`; Wealthfolio injects the `Authorization` header on the backend.


------------------------------------------------------------------------

## Storage API

Durable per-addon key-value storage. Use this instead of `localStorage`, which is unavailable in the sandboxed (opaque-origin) iframe and throws. Values are opaque strings owned by your addon: storage survives addon updates, is cleared on uninstall, replicates across paired devices, and is scoped so no other addon can read it. Storage is a **baseline capability** – it needs no `permissions` entry.

### Methods

#### `get(key: string): Promise<string | null>`

Retrieves a stored value (resolves to `null` if not set).

``` mb-4
const raw = await ctx.api.storage.get('prefs');
const prefs = raw ? JSON.parse(raw) : defaults;
```

#### `set(key: string, value: string): Promise<void>`

Stores a string value. Keys are ≤ 128 characters and limited to the charset `[A-Za-z0-9_.:-]`. Values are capped at roughly 250 KB each – because storage replicates across a user’s paired devices, `set` rejects an oversized value instead of failing to sync later. Use many small keys rather than one large blob, and keep device-local caches out of storage.

``` mb-4
await ctx.api.storage.set('prefs', JSON.stringify(prefs));
```

#### `delete(key: string): Promise<void>`

Permanently deletes a stored value.

``` mb-4
await ctx.api.storage.delete('prefs');
```

------------------------------------------------------------------------

## Network API

Send brokered HTTPS requests to hosts declared in `manifest.json`. The addon iframe has an opaque origin and is intentionally network-free; do not use direct browser `fetch` for addon integrations. The broker enforces approved hosts and injects authorization without exposing the secret value to request-building code.

### Manifest

``` mb-4
{
  "permissions": [
    {
      "category": "network",
      "functions": ["request"],
      "purpose": "Fetch market data from api.example.com"
    },
    {
      "category": "secrets",
      "functions": ["use"],
      "purpose": "Inject the user's API token into brokered requests"
    }
  ],
  "network": {
    "allowedHosts": ["api.example.com"]
  }
}
```

`allowedHosts` is declared by the addon. `approvedHosts` is managed by Wealthfolio after the user approves hosts during install or update.

### `request(request: NetworkRequest): Promise<NetworkResponse>`

``` mb-4
const response = await ctx.api.network.request({
  url: 'https://api.example.com/v1/quotes',
  method: 'GET',
  headers: {
    Accept: 'application/json',
  },
  auth: {
    type: 'bearer',
    secretKey: 'api-token',
  },
});

if (response.status === 200) {
  const payload = JSON.parse(response.body);
}
```

`auth.type` selects the scheme Wealthfolio injects:

- `'bearer'` → `Authorization: Bearer <secret>`
- `'basic'` → `Authorization: Basic <secret>`. Store the already base64-encoded `user:pass` string as the secret; the broker only prefixes the scheme. This is the way to reach APIs like <a href="https://www.simplefin.org" class="font-medium underline underline-offset-4">SimpleFin Bridge</a> whose access URLs embed credentials – extract `user:pass` at setup, base64-encode it, and save it with `ctx.api.secrets.set`.

Network requests are constrained:

- HTTPS only
- Host must match a declared and user-approved host
- Local, private, link-local, and metadata IPs are blocked
- Redirects are disabled
- Request bodies are limited to 1 MB
- Response bodies are limited to 2 MB
- Response bodies are text. Package binary images, fonts, media, and Wasm with `ctx.assets` instead
- `Authorization` cannot be supplied in `headers`; use `auth.secretKey`
- Supported methods: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`, `HEAD`

------------------------------------------------------------------------

## Logger API

Provides logging functionality with automatic addon prefix.

### Methods

#### `error(message: string): void`

Logs an error message.

``` mb-4
ctx.api.logger.error('Failed to fetch data from API');
```

#### `info(message: string): void`

Logs an informational message.

``` mb-4
ctx.api.logger.info('Data sync completed successfully');
```

#### `warn(message: string): void`

Logs a warning message.

``` mb-4
ctx.api.logger.warn('API rate limit approaching');
```

#### `debug(message: string): void`

Logs a debug message.

``` mb-4
ctx.api.logger.debug('Processing 100 activities');
```

#### `trace(message: string): void`

Logs a trace message for detailed debugging.

``` mb-4
ctx.api.logger.trace('Entering function processActivity');
```

------------------------------------------------------------------------

## Event System

Listen to real-time events for responsive addon behavior.

The listener methods return promises. Inside `enable(ctx)`, keep `enable` synchronous and store cleanup functions when the listener promises resolve:

``` mb-4
export default function enable(ctx: AddonContext) {
  let unlistenPortfolio: (() => void) | undefined;

  void ctx.api.events.portfolio
    .onUpdateComplete(() => {
      refreshPortfolioData();
    })
    .then((unlisten) => {
      unlistenPortfolio = unlisten;
    });

  ctx.onDisable(() => {
    unlistenPortfolio?.();
  });
}
```

### Portfolio Events

#### `onUpdateStart(callback: EventCallback): Promise<UnlistenFn>`

Fires when portfolio update starts.

``` mb-4
const unlistenStart = await ctx.api.events.portfolio.onUpdateStart((event) => {
  console.log('Portfolio update started');
  showLoadingIndicator();
});
```

#### `onUpdateComplete(callback: EventCallback): Promise<UnlistenFn>`

Fires when portfolio calculations are updated.

``` mb-4
const unlistenPortfolio = await ctx.api.events.portfolio.onUpdateComplete((event) => {
  console.log('Portfolio updated:', event.payload);
  // Refresh your addon's data
  refreshPortfolioData();
});

// Clean up on disable
ctx.onDisable(() => {
  unlistenPortfolio();
});
```

#### `onUpdateError(callback: EventCallback): Promise<UnlistenFn>`

Fires when portfolio update encounters an error.

``` mb-4
const unlistenError = await ctx.api.events.portfolio.onUpdateError((event) => {
  console.error('Portfolio update failed:', event.payload);
  showErrorMessage();
});
```

### Market Events

#### `onSyncStart(callback: EventCallback): Promise<UnlistenFn>`

Fires when market data sync starts.

``` mb-4
const unlistenSyncStart = await ctx.api.events.market.onSyncStart(() => {
  console.log('Market sync started');
  showSyncIndicator();
});
```

#### `onSyncComplete(callback: EventCallback): Promise<UnlistenFn>`

Fires when market data sync is completed.

``` mb-4
const unlistenMarket = await ctx.api.events.market.onSyncComplete(() => {
  console.log('Market data updated!');
  // Update price displays
  updatePriceDisplays();
});
```

### Import Events

#### `onDropHover(callback: EventCallback): Promise<UnlistenFn>`

Fires when files are hovered over for import.

``` mb-4
const unlistenHover = await ctx.api.events.import.onDropHover((event) => {
  console.log('File hover detected');
  showDropZone();
});
```

#### `onDrop(callback: EventCallback): Promise<UnlistenFn>`

Fires when files are dropped for import.

``` mb-4
const unlistenImport = await ctx.api.events.import.onDrop((event) => {
  console.log('File dropped:', event.payload);
  // Trigger import workflow
  handleFileImport(event.payload.files);
});
```

#### `onDropCancelled(callback: EventCallback): Promise<UnlistenFn>`

Fires when file drop is cancelled.

``` mb-4
const unlistenCancel = await ctx.api.events.import.onDropCancelled(() => {
  console.log('File drop cancelled');
  hideDropZone();
});
```

------------------------------------------------------------------------

## Navigation API

Navigate programmatically within the Wealthfolio application.

### Methods

#### `navigate(route: string): Promise<void>`

Navigate to a specific route in the application.

``` mb-4
// Navigate to a specific account
await ctx.api.navigation.navigate('/accounts/account-123');

// Navigate to portfolio overview
await ctx.api.navigation.navigate('/portfolio');

// Navigate to activities page
await ctx.api.navigation.navigate('/activities');

// Navigate to settings
await ctx.api.navigation.navigate('/settings');
```


**Navigation Routes**: The navigation API uses the same route structure as the main application. Common routes include `/accounts`, `/portfolio`, `/activities`, `/goals`, and `/settings`.


------------------------------------------------------------------------

## Query API

Access an addon-owned React Query client and ask the host to refresh selected caches.

### Methods

#### `getClient(): unknown`

Gets the sandbox’s addon-local QueryClient as an opaque bridge value. Cast it to the exported `QueryClient` type before using TanStack Query methods. This is not the raw host QueryClient.

``` mb-4
import type { QueryClient } from '@wealthfolio/addon-sdk';

const queryClient = ctx.api.query.getClient() as QueryClient;

// Use standard React Query methods
const accounts = await queryClient.fetchQuery({
  queryKey: ['accounts'],
  queryFn: () => ctx.api.accounts.getAll(),
});
```

When the addon calls `invalidateQueries` or `refetchQueries` with a string or string-array query key (directly or in a TanStack Query filters object), Wealthfolio mirrors that request to the host cache. Host-originated invalidations do not mutate the addon cache automatically; subscribe to relevant domain events when the addon must react to changes made elsewhere.

#### `invalidateQueries(queryKey: string | string[]): void`

Invalidates queries to trigger refetch.

``` mb-4
// Invalidate specific query
ctx.api.query.invalidateQueries(['accounts']);

// Invalidate multiple related queries
ctx.api.query.invalidateQueries(['portfolio', 'holdings']);

// Invalidate all account-related queries
ctx.api.query.invalidateQueries(['accounts']);
```

#### `refetchQueries(queryKey: string | string[]): void`

Triggers immediate refetch of queries.

``` mb-4
// Refetch portfolio data
ctx.api.query.refetchQueries(['portfolio']);

// Refetch multiple queries
ctx.api.query.refetchQueries(['accounts', 'holdings']);
```

### Integration with Events

Combine Query API with event listeners for reactive data updates:

``` mb-4
export default async function enable(ctx: AddonContext) {
  // Invalidate relevant queries when portfolio updates
  const unlistenPortfolio = await ctx.api.events.portfolio.onUpdateComplete(() => {
    ctx.api.query.invalidateQueries(['portfolio', 'holdings', 'performance']);
  });

  // Invalidate market data queries when sync completes
  const unlistenMarket = await ctx.api.events.market.onSyncComplete(() => {
    ctx.api.query.invalidateQueries(['quotes', 'assets']);
  });

  ctx.onDisable(() => {
    unlistenPortfolio();
    unlistenMarket();
  });
}
```

------------------------------------------------------------------------

## UI Integration APIs

### Sidebar API

Prefer declaring sidebar entries in `manifest.json` under `contributes.links.sidebar` (see below) – the host renders them without booting your addon and they survive reloads. The runtime `addItem` API is still available for **dynamic** items an addon adds while running.

#### Declarative (preferred)

``` mb-4
"contributes": {
  "routes": [{ "id": "my-addon" }],
  "links": {
    "sidebar": [
      { "id": "my-addon", "route": "my-addon", "label": "My Addon", "icon": "wallet", "order": 100 }
    ]
  }
}
```

A **route** is a durable addon page (host-renderable before the addon boots – the lazy-activation surface); a **link** is a placement in a host slot (only `"sidebar"` is consumed today) that references a declared `route` id of the same addon. The runtime `router.add({ id })` **must** equal `contributes.routes[].id`. Omit `path` for the root at `/addons/<manifest.id>`; nested routes use a relative suffix such as `reports/:year`. Absolute paths, traversal, queries, and fragments are rejected in the manifest.

#### `addItem(config: SidebarItemConfig): SidebarItemHandle`

For dynamic, runtime-added entries:

``` mb-4
const sidebarItem = ctx.sidebar.addItem({
  id: 'my-addon',
  label: 'My Addon',
  route: '/addons/my-addon',
  icon: 'wallet', // Optional – an AddonIconName (see below)
  order: 100, // Lower numbers appear first
});

// Remove when addon is disabled
ctx.onDisable(() => {
  sidebarItem.remove();
});
```

#### Sidebar icons

The `icon` field is typed as `AddonIconName` from `@wealthfolio/addon-sdk`. Import that type for autocomplete and a compile-time error on any invalid name:

``` mb-4
import type { AddonIconName } from '@wealthfolio/addon-sdk';

const icon: AddonIconName = 'wallet'; // ✓
// const icon: AddonIconName = 'spinner'; // ✗ type error
```

Icons come from a curated set of <a href="https://phosphoricons.com" class="font-medium underline underline-offset-4">Phosphor</a> icons (duotone weight) that Wealthfolio bundles and renders – the sidebar is host UI, so an addon **names** an icon rather than shipping one. Matching is case- and separator-insensitive (`'ChartLine'`, `'chart-line'`, and `'chartline'` are equivalent), and an unknown or omitted name renders a neutral `caret-right` fallback.


This applies only to the **sidebar** icon. Inside your own route/page you render with your own React, so you can use any icon there – Lucide, Phosphor, or your own SVGs. From Wealthfolio 3.13, the host shares `lucide-react` 1.x, which has no brand icons such as `Github`, `Twitter`, or `Youtube`. An addon that imports one from the host’s `lucide-react` fails to load, so bundle your own icon instead.


The 80 supported names, by group (preview every glyph at <a href="https://phosphoricons.com" class="font-medium underline underline-offset-4">phosphoricons.com</a>):

- **Money & finance** – `wallet`, `coins`, `dollar`, `dollar-circle`, `bank`, `credit-card`, `piggy-bank`, `receipt`, `invoice`, `hand-coins`, `vault`, `chart-line-up`, `chart-line`, `trend-up`, `trend-down`, `percent`, `scales`, `calculator`
- **Charts & analytics** – `chart-bar`, `chart-pie`, `chart-pie-slice`, `chart-donut`, `gauge`, `target`, `presentation`
- **Assets** – `house`, `buildings`, `car`, `airplane`, `bicycle`, `diamond`, `bitcoin`, `storefront`, `briefcase`, `package`, `cube`
- **General** – `star`, `heart`, `gift`, `trophy`, `medal`, `lightning`, `sparkle`, `bell`, `tag`, `bookmark`, `flag`, `fire`, `rocket`, `lightbulb`, `graduation-cap`, `barbell`, `fork-knife`, `coffee`, `wine`, `shopping-cart`, `shopping-bag`, `basket`
- **Time & place** – `calendar`, `calendar-dots`, `calendar-check`, `clock`, `hourglass`, `globe`, `map-pin`, `compass`
- **Productivity** – `folder`, `files`, `notebook`, `clipboard-text`, `list-checks`, `sliders`, `wrench`, `toolbox`, `puzzle-piece`, `plugs-connected`, `app-window`, `squares-four`, `stack`, `kanban`

### Router API

Register the renderer for your addon’s pages. The host owns a single React root per addon and mounts the route’s `component` itself, so hand it a component rather than managing a root by hand.

#### `add(route: RouteConfig): void`

``` mb-4
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import type { AddonContext, AddonEnableFunction } from '@wealthfolio/addon-sdk';
import { MyPage } from './pages/MyPage';

let addonCtx: AddonContext | undefined;

const MyRoute = () => (
  <QueryClientProvider client={addonCtx!.api.query.getClient() as QueryClient}>
    <MyPage ctx={addonCtx!} />
  </QueryClientProvider>
);

const enable: AddonEnableFunction = (ctx) => {
  addonCtx = ctx;
  ctx.router.add({ id: 'my-addon', path: '/addons/my-addon', component: MyRoute });
  ctx.onDisable(() => {
    addonCtx = undefined;
  });
};

export default enable;
```

Provide **exactly one** of `component` (preferred – the host manages mount/unmount in its single root) or `render` (a legacy imperative escape hatch given the container element); if both are set, `component` wins. Do **not** call `createRoot` yourself – a per-route root leaves an orphaned tree whose re-renders never reach the DOM. The component receives the current route as a `{ location }` prop (`AddonRouteLocation` with `pathname/search/hash/params`); the sandbox has **no** react-router provider, so `useLocation()` / `useParams()` are unavailable.

When a route is also declared in `manifest.json` `contributes.routes`, the runtime `router.add({ id })` **must use the same `id`** – a mismatch renders a blank “route is not available” page. Runtime `router.add` still works for routes an addon adds dynamically while running.


Addon routes must stay inside the addon’s namespace. For an addon with id `my-addon`, use `/addons/my-addon` or `/addon/my-addon`. For ids ending in `-addon`, Wealthfolio also allows the stripped slug, for example `swingfolio-addon` can use `/addons/swingfolio`.


------------------------------------------------------------------------

## Error Handling

### Best Practices

Host API failures reject their promise with an error. Handle failures at the user action boundary and show a useful message without exposing financial data.

``` mb-4
try {
  const accounts = await ctx.api.accounts.getAll();
} catch (error) {
  const message = error instanceof Error ? error.message : String(error);
  ctx.api.logger.error(`Unable to load accounts: ${message}`);
  ctx.api.toast.error('Unable to load accounts');
}
```

------------------------------------------------------------------------

## Advanced Usage

### Batch Operations

``` mb-4
// Efficient batch processing
const activities = await Promise.all([
  ctx.api.activities.getAll('account-1'),
  ctx.api.activities.getAll('account-2'),
  ctx.api.activities.getAll('account-3'),
]);

// Batch create
const newActivities = await ctx.api.activities.saveMany({
  creates: [
    {
      accountId: 'account-1',
      activityType: 'DEPOSIT',
      activityDate: '2026-09-04',
      amount: 1000,
      currency: 'USD',
    },
  ],
});
```

### Real-time Updates

``` mb-4
export default async function enable(ctx: AddonContext) {
  // Listen for multiple events
  const unsubscribers = await Promise.all([
    ctx.api.events.portfolio.onUpdateComplete(() => refreshData()),
    ctx.api.events.market.onSyncComplete(() => updatePrices()),
    ctx.api.events.import.onDrop((event) => handleImport(event)),
  ]);

  // Clean up all listeners
  ctx.onDisable(() => {
    unsubscribers.forEach((unsub) => unsub());
  });
}
```

### Caching Strategies

``` mb-4
// Simple in-memory cache
const cache = new Map();
let unlistenPortfolio: (() => void) | undefined;

void ctx.api.events.portfolio
  .onUpdateComplete(() => {
    cache.delete('accounts');
  })
  .then((unlisten) => {
    unlistenPortfolio = unlisten;
  });

async function getCachedAccounts() {
  if (cache.has('accounts')) {
    return cache.get('accounts');
  }

  const accounts = await ctx.api.accounts.getAll();
  cache.set('accounts', accounts);

  return accounts;
}

ctx.onDisable(() => {
  unlistenPortfolio?.();
  cache.clear();
});
```

------------------------------------------------------------------------

## TypeScript Support

Full TypeScript definitions are provided for all APIs:

``` mb-4
import type {
  AddonContext,
  Account,
  Activity,
  Holding,
  PerformanceResult,
  PerformanceSummary,
  // ... and many more
} from '@wealthfolio/addon-sdk';

// Type-safe API usage
const accounts: Account[] = await ctx.api.accounts.getAll();
const holdings: Holding[] = await ctx.api.portfolio.getHoldings(accounts[0].id);
```

## Performance Tips

1.  **Use batch operations** when possible
2.  **Implement caching** for expensive operations
3.  **Listen to relevant events only**
4.  **Clean up resources** in disable function
5.  **Use React.memo** for expensive components
6.  **Debounce user inputs** for search/filter

------------------------------------------------------------------------

**Ready to build?** Check out the <a href="/docs/addons/getting-started/" class="font-medium underline underline-offset-4">Getting Started guide</a> to see these APIs in action!


<a href="/docs/addons/localization/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Localization</a> <a href="/docs/faq/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">FAQ</a>


On this page

- <a href="#api-reference" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">API Reference</a>
  - <a href="#context-overview" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Context Overview</a>
  - <a href="#packaged-assets-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Packaged Assets API</a>
  - <a href="#api-domains" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">API Domains</a>
  - <a href="#accounts-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Accounts API</a>
  - <a href="#portfolio-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Portfolio API</a>
  - <a href="#activities-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Activities API</a>
  - <a href="#market-data-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Market Data API</a>
  - <a href="#assets-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Assets API</a>
  - <a href="#allocation-targets-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Allocation Targets API</a>
  - <a href="#quotes-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Quotes API</a>
  - <a href="#performance-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Performance API</a>
  - <a href="#exchange-rates-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Exchange Rates API</a>
  - <a href="#spend-categorization-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Spend Categorization API</a>
  - <a href="#contribution-limits-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Contribution Limits API</a>
  - <a href="#goals-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Goals API</a>
  - <a href="#settings-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Settings API</a>
  - <a href="#files-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Files API</a>
  - <a href="#snapshots-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Snapshots API</a>
  - <a href="#secrets-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Secrets API</a>
  - <a href="#storage-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Storage API</a>
  - <a href="#network-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Network API</a>
  - <a href="#logger-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Logger API</a>
  - <a href="#event-system" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Event System</a>
  - <a href="#navigation-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Navigation API</a>
  - <a href="#query-api" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Query API</a>
  - <a href="#ui-integration-apis" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">UI Integration APIs</a>
  - <a href="#error-handling" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Error Handling</a>
  - <a href="#advanced-usage" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Advanced Usage</a>
  - <a href="#typescript-support" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">TypeScript Support</a>
  - <a href="#performance-tips" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Performance Tips</a>


