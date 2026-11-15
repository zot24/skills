> Source: https://wealthfolio.app/docs/addons



Docs


Wealthfolio Addon Development


# Wealthfolio Addon Development

Learn how to build addons for Wealthfolio to extend its functionality with custom tools and integrations.


Last updated November 12, 2026


Wealthfolio addons are TypeScript modules that extend the application’s functionality through a sandboxed runtime. This guide covers how to build, test, and distribute addons for Wealthfolio 3.7 and later. Existing 3.6 addons remain supported; see <a href="/docs/addons/v3-7-assets/" class="font-medium underline underline-offset-4">v3.7 compatibility and assets</a> before adopting the new asset API.


**New to addon development?** Start with our <a href="/docs/addons/getting-started/" class="font-medium underline underline-offset-4">Quick Start Guide</a> to create your first addon.


## What are Wealthfolio Addons?

Addons are TypeScript/React-based extensions that provide access to Wealthfolio’s financial data and UI system through a brokered API bridge.

**Technical Foundation**  
Each addon is an ES module that exports an `enable(ctx)` function. Wealthfolio loads the module inside a sandboxed iframe and passes an `AddonContext` object with access to APIs, route rendering, private packaged assets, events, logging, secrets, and network access.

**Integration Capabilities**  
Addons declare their pages and navigation in `manifest.json` (`contributes.routes` + `contributes.links`), so the host builds the sidebar and knows every route **without running addon code**. Routes must live under the addon’s own namespace, such as `/addons/hello-world-addon` for `hello-world-addon`. An addon with declared routes boots **lazily** – its `enable(ctx)` runs on the first visit to one of its routes, then renders inside its own iframe.

**Development Environment**  
Built with TypeScript, React, and modern web APIs. Includes hot-reload development server, comprehensive type definitions, and host-provided dependencies to keep addon bundles small.

## Architecture Overview

``` mb-4
┌─────────────────────────────────────────────────────────────────┐
│                    Wealthfolio Host Application                 │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │
│  │  Addon Runtime  │  │  Permission     │  │   API Bridge    │  │
│  │                 │  │   System        │  │                 │  │
│  │ • Load/Unload   │  │ • Detection     │  │ • Type Bridge   │  │
│  │ • Lifecycle     │  │ • Validation    │  │ • Domain APIs   │  │
│  │ • Context Mgmt  │  │ • Enforcement   │  │ • Scoped Access │  │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘  │
├─────────────────────────────────────────────────────────────────┤
│                        Individual Addons                        │
│ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ │
│ │   Addon A   │ │   Addon B   │ │   Addon C   │ │   Addon D   │ │
│ │             │ │             │ │             │ │             │ │
│ │ enable()    │ │ enable()    │ │ enable()    │ │ enable()    │ │
│ │ onDisable   │ │ onDisable   │ │ onDisable   │ │ onDisable   │ │
│ │ UI/Routes   │ │ UI/Routes   │ │ UI/Routes   │ │ UI/Routes   │ │
│ │ API Calls   │ │ API Calls   │ │ API Calls   │ │ API Calls   │ │
│ └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

## Basic Addon Structure

Every addon exports an enable function that receives a context object:

``` mb-4
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import type { AddonContext, AddonEnableFunction } from '@wealthfolio/addon-sdk';
import { Button } from '@wealthfolio/ui';

function MyAddonPage({ ctx }: { ctx: AddonContext }) {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-semibold">My Tool</h1>
      <Button onClick={() => ctx.api.toast.success('Hello from my addon')}>
        Show toast
      </Button>
    </div>
  );
}

// The host owns a single React root per addon and mounts the route `component`
// itself. Capture the context at enable time so the route wrapper can hand it
// down. (Do NOT call createRoot yourself – the host manages the lifecycle.)
let addonCtx: AddonContext | undefined;

const MyAddonRoute = () => (
  <QueryClientProvider client={addonCtx!.api.query.getClient() as QueryClient}>
    <MyAddonPage ctx={addonCtx!} />
  </QueryClientProvider>
);

const enable: AddonEnableFunction = async (ctx) => {
  addonCtx = ctx;

  // The sidebar entry and route are declared in manifest.json `contributes`, so
  // the host builds navigation before this addon boots. The runtime route `id`
  // MUST match `contributes.routes[].id`.
  ctx.router.add({
    id: 'my-addon',
    path: '/addons/my-addon',
    component: MyAddonRoute,
  });

  // Listen to events
  const unlistenPortfolio = await ctx.api.events.portfolio.onUpdateComplete(() => {
    // Handle portfolio updates
  });

  // Cleanup. The host owns the React root, so there is no root to unmount.
  ctx.onDisable(() => {
    addonCtx = undefined;
    unlistenPortfolio();
  });
};

export default enable;
```

## Permission System

Addons operate under a permission-based security model with three stages:

#### 1. Static Analysis

During installation, addon code is scanned for API usage patterns:

``` mb-4
// This pattern is detected:
const accounts = await ctx.api.accounts.getAll();
// Detected permission: accounts.getAll
```

#### 2. Permission Categories


| Category | Risk Level | Common Functions |
|----|----|----|
| `accounts` | High | getAll, create |
| `allocation-targets` | High | getAll, getDrift |
| `portfolio` | High | getHoldings, getHolding, update, recalculate |
| `activities` | High | getAll, search, create, update, saveMany, import |
| `market-data` | Low | searchTicker, syncHistory, sync, getProviders, fetchDividends |
| `assets` | Medium | getProfile, updateProfile, updateQuoteMode |
| `quotes` | Low | update, getHistory |
| `performance` | Medium | calculateHistory, calculateSummary, calculateAccountsSimple |
| `currency` | Low | getAll, update, add, getRatesForDates |
| `spending` | Medium | isEnabled, getCategories, getContext, getBudget, getReport, saveRule |
| `budgets` | High | upsertBudgetTarget |
| `financial-planning` | Medium | getAll, create, update, getFunding, saveFunding |
| `contribution-limits` | Medium | getAll, create, update, calculateDeposits |
| `settings` | Medium | get, update, backupDatabase |
| `files` | Medium | openCsvDialog, openSaveDialog |
| `snapshots` | High | getAll, getByDate, save, checkImport, importSnapshots |
| `events` | Low | onDrop, onUpdateComplete, onSyncComplete |
| `network` | High | request |
| `secrets` | High | set, get, use, delete |


Some `ctx.api.spending` functions sit in other categories: `searchCashActivities`, `assignCategory`, `unassignCategory`, and `setEvent` need `activities` grants, and `upsertBudgetTarget` needs a `budgets` grant. See the <a href="/docs/addons/api-reference/#spend-categorization-api" class="font-medium underline underline-offset-4">Spend Categorization API</a>.

**Baseline capabilities are implicit.** `ui` (sidebar/router/navigation), private packaged `assets`, `query`, `toast`, `logger`, and `storage` are granted to every addon and are **not** declared in `permissions`. Only the data domains above plus `files`, `network`, `secrets`, `events`, `snapshots`, and `settings` need a declaration.

#### 3. User Approval

During installation, users see both declared and detected permissions, plus declared network hosts. They can approve or reject the addon installation. Updates that add permissions require reinstall approval.

## Available APIs

The addon context provides access to host APIs through a sandbox bridge:

``` mb-4
interface AddonContext {
  ui: {
    root: HTMLElement;
  };
  sidebar: SidebarManager;
  router: RouterManager;
  assets: AddonAssets;
  onDisable(callback: () => void): void;
  api: {
    accounts: AccountsAPI;
    portfolio: PortfolioAPI;
    activities: ActivitiesAPI;
    market: MarketDataAPI;
    assets: AssetsAPI;
    allocationTargets: AllocationTargetsAPI;
    quotes: QuotesAPI;
    performance: PerformanceAPI;
    exchangeRates: ExchangeRatesAPI;
    spending: SpendingAPI;
    goals: GoalsAPI;
    contributionLimits: ContributionLimitsAPI;
    settings: SettingsAPI;
    files: FilesAPI;
    snapshots: SnapshotsAPI;
    events: EventsAPI;
    secrets: SecretsAPI;
    storage: StorageAPI;
    network: NetworkAPI;
    navigation: NavigationAPI;
    query: QueryAPI;
    toast: ToastAPI;
    logger: LoggerAPI;
  };
}
```

Formatting helpers and addon-owned translations are documented in the <a href="/docs/addons/localization/" class="font-medium underline underline-offset-4">Addon Localization guide</a>. The translation runtime requires Wealthfolio 3.8 or newer.

## Development Setup

### Required Packages

``` mb-4
npm install @wealthfolio/addon-sdk @wealthfolio/ui react react-dom
npm install -D @wealthfolio/addon-dev-tools typescript vite
```

### Core Dependencies

- **@wealthfolio/addon-sdk**: TypeScript types and API definitions
- **@wealthfolio/ui**: UI components based on shadcn/ui and Tailwind CSS
- **@wealthfolio/addon-dev-tools**: CLI and development server

### Development Server

The development tools include a hot-reload server:

``` mb-4
# Start development server
npm run dev:server

# Available on localhost:3001
# Auto-discovered by Wealthfolio
```

``` mb-4
Development Server Structure:
├─ /health                         # Health check
├─ /status                         # Build status and generation
├─ /runtime-package                # Manifest, runtime files, asset metadata
├─ /runtime-files                  # JavaScript and CSS
└─ /runtime-assets/:id?generation= # Lazy asset bytes
```

Wealthfolio 3.7 requires `@wealthfolio/addon-dev-tools` 3.7 or newer. Runtime packages are immutable generations, so hot reload cannot mix asset metadata from one build with bytes from another. A 404 or 405 for `/runtime-package` means the development server must be upgraded and restarted.

## Project Structure

``` mb-4
hello-world-addon/
├── src/
│   ├── addon.tsx           # Main addon entry point
│   ├── components/         # React components
│   ├── hooks/              # React hooks
│   ├── pages/              # Addon pages
│   ├── utils/              # Utility functions
│   └── types/              # Type definitions
├── assets/                 # Private static assets (optional)
├── dist/                   # Built files (generated)
├── manifest.json           # Addon metadata and permissions
├── package.json            # NPM package configuration
├── vite.config.ts          # Build configuration
├── tsconfig.json           # TypeScript configuration
└── README.md               # Documentation
```

### Manifest File

``` mb-4
{
  "id": "my-addon",
  "name": "My Addon",
  "version": "1.0.0",
  "main": "dist/addon.js",
  "description": "Addon description",
  "author": "Your Name",
  "sdkVersion": "3.8.0",
  "minWealthfolioVersion": "3.8.0",
  "enabled": true,
  "contributes": {
    "routes": [{ "id": "my-addon" }],
    "links": {
      "sidebar": [
        {
          "id": "my-addon",
          "route": "my-addon",
          "label": "My Addon",
          "icon": "squares-four",
          "order": 100
        }
      ]
    }
  },
  "permissions": [],
  "hostDependencies": {
    "@wealthfolio/addon-sdk": "^3.8.0",
    "@wealthfolio/ui": "^3.8.0",
    "react": "^19.2.0",
    "react-dom": "^19.2.0"
  }
}
```

A **route** (`contributes.routes`) is a durable addon page the host can render before the addon boots; a **link** (`contributes.links`, only the `"sidebar"` slot is consumed today) places a declared route in a host slot. The runtime `router.add({ id })` must use the same `id` as its declared route. Navigation and the baseline `ui` capability need no `permissions` entry.

Set `minWealthfolioVersion` to the oldest Wealthfolio release that has every API and shared library your addon uses. New addons from the templates declare `3.13.0`, the first release that shares Lucide 1.x. An addon that uses a Lucide 1.x icon must declare `3.13.0` or newer, so it can’t be installed on a host that only has Lucide 0.561.

## Packaged Assets

Wealthfolio 3.7 indexes non-JavaScript/CSS files below `assets/**` and `dist/assets/**` automatically. JavaScript and CSS in those roots remain runtime modules and styles. There is no manifest asset list and no asset permission.

``` mb-4
export default async function enable(ctx: AddonContext) {
  const logoUrl = await ctx.assets.getUrl('assets/logo.png');
  const configBlob = await ctx.assets.getBlob('assets/config.json');
  const config = JSON.parse(await configBlob.text());

  ctx.api.logger.debug(`Loaded ${ctx.assets.list().length} assets`);
}
```

`ctx.assets` contains files private to the addon package. It is unrelated to `ctx.api.assets`, which manages financial instruments. `getUrl()` returns a sandbox-local Blob URL that is cached for the addon lifetime and revoked on reload or disable; do not persist it.

Local CSS `url(...)` references are rewritten relative to the stylesheet. `data:` and `blob:` URLs are preserved. Remote CSS URLs and `@import` are rejected, and JavaScript/JSX strings are not rewritten, so components must call `getUrl()` explicitly. Package remote images, fonts, media, and Wasm rather than fetching them in the opaque iframe.

See <a href="/docs/addons/v3-7-assets/" class="font-medium underline underline-offset-4">v3.7 compatibility and assets</a> for package limits, failure behavior, and the development-tools migration.

## Lifecycle Management

### Installation Process

``` mb-4
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│             │    │             │    │             │    │             │
│  ZIP File   │───▶│   Extract   │───▶│  Validate   │───▶│  Analyze    │
│             │    │             │    │             │    │ Permissions │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                                                                   │
┌─────────────┐    ┌─────────────┐    ┌─────────────┐              │
│             │    │             │    │             │              │
│   Running   │◀───│   Enable    │◀───│    Load     │◀─────────────┘
│             │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘
```

1.  **Extract**: Unzip addon package and read files
2.  **Validate**: Check manifest.json structure and compatibility
3.  **Analyze Permissions**: Scan code for API usage patterns
4.  **Approve**: User reviews permissions and requested network hosts
5.  **Load**: Create sandbox iframe with scoped APIs
6.  **Enable**: Call addon’s enable function
7.  **Running**: Addon functionality is active

### Lazy Activation

Addons that declare `contributes.routes` boot **lazily**: the host reads the manifest and builds the sidebar and route table without executing any addon code, then calls `enable(ctx)` only when one of the addon’s routes is first visited. Because navigation comes from the manifest, a route survives reloads and deep links even before the addon has run.

Sandbox failures degrade gracefully rather than crashing the host – blocked storage, an unknown API call, or an unavailable route surface as a toast plus an inline panel in the addon’s frame, and errors in one addon never affect another.

### Context Isolation

Each addon runs in its own sandboxed iframe and receives an isolated context. Host APIs are exposed through a broker; addons do not receive host React globals, the raw host context, or another addon’s context.

``` mb-4
// Addon "my-addon" accessing its own secrets
await ctx.api.secrets.set('api-key', 'value');
const apiKey = await ctx.api.secrets.get('api-key');
```

Secrets are stored in the OS keyring under the addon’s own scope. Other addons cannot read them.

## UI Components

Addons have access to Wealthfolio’s UI component library:

``` mb-4
import { Button, Card, Dialog, Input, Table } from '@wealthfolio/ui';
import { AmountDisplay, GainAmount, CurrencyInput } from '@wealthfolio/ui/financial';
import { TrendUp, CurrencyDollar } from '@phosphor-icons/react';

function MyComponent() {
  return (
    <Card className="p-6">
      <div className="flex items-center space-x-2">
        <TrendUp className="h-4 w-4" />
        <span>Portfolio Growth</span>
      </div>

      <div className="mt-4">
        <AmountDisplay value={1234.56} currency="USD" />
        <GainAmount value={123.45} percentage={5.2} />
      </div>
    </Card>
  );
}
```

Available libraries:

- All Radix UI components
- **Financial components** (`components/financial`) for amounts, gains, and currency inputs
- Lucide React and Phosphor icons – for rendering **inside your own page** (any icon you like)
- Tailwind CSS utilities
- Recharts for data visualization
- React Query for data fetching
- date-fns for date manipulation

From Wealthfolio 3.13, the host shares `lucide-react` 1.x (was 0.561). Lucide 1.0 removed the brand icons, such as `Github`, `Twitter`, and `Youtube`, with their `*Icon` and `Lucide*` names. An addon that imports one from the host’s `lucide-react` fails to load, so bundle your own icon instead. Other icon names still work, including deprecated aliases such as `Trash2` and `Loader2`.

Wealthfolio 3.13 also shares Recharts 3.10.1, so charts with default animation stop animating when the system asks for reduced motion. In 3.13, `@wealthfolio/ui` adds `ExternalLink`, a link that opens through the `openUrl` you give it or its `ExternalLinkProvider`, and `useNumericDraft`, for editing a number field in the user’s region format.


The **sidebar** icon is different: it’s named by a string from a curated set (typed as `AddonIconName`), not a component you import. See <a href="/docs/addons/api-reference/#sidebar-icons" class="font-medium underline underline-offset-4">Sidebar icons</a> for the full list.


## Build and Distribution

### Build Configuration

Use the addon dev tools template when possible. It configures host dependencies so common libraries are provided by Wealthfolio instead of bundled into every addon.

``` mb-4
// vite.config.ts
export default defineConfig({
  plugins: [react()],
  build: {
    target: ['chrome107', 'edge107', 'firefox104', 'safari16'],
    lib: {
      entry: 'src/addon.tsx',
      fileName: () => 'addon.js',
      formats: ['es'],
    },
    rollupOptions: {
      external: [
        'react',
        'react-dom',
        'react-dom/client',
        '@wealthfolio/addon-sdk',
        '@wealthfolio/ui',
      ],
    },
  },
});
```

### Package Scripts

``` mb-4
{
  "scripts": {
    "build": "vite build",
    "dev": "vite build --watch",
    "dev:server": "wealthfolio-addon dev",
    "clean": "rm -rf dist",
    "package": "zip -r $npm_package_name-$npm_package_version.zip manifest.json dist/ assets/ README.md -x \"*.map\"",
    "bundle": "pnpm clean && pnpm build && pnpm package",
    "lint": "tsc --noEmit",
    "type-check": "tsc --noEmit"
  }
}
```

## Error Handling

### Addon Failures

- Errors are logged but don’t affect other addons
- Host application continues normally
- Users see error notifications

### Permission Violations

- `PermissionError` thrown for unauthorized API calls
- API calls are blocked
- Errors are logged for debugging

## Security Model

- Each addon runs in a sandboxed iframe with a brokered API bridge
- The iframe has an opaque origin; direct browser storage, filesystem paths, and top-level navigation are unavailable
- Routes are limited to the addon’s own `/addon/<namespace>` or `/addons/<namespace>` path
- Manifest permissions are enforced at runtime
- Static analysis detects additional API usage during installation
- Network access is brokered by the backend and limited to approved HTTPS hosts
- Secrets are stored in the OS keyring and scoped by addon ID
- Bearer authorization headers are injected by the backend from add-on-scoped secrets
- Addon network requests are audited locally
- Brokered network responses are text; package binary resources with the addon

## Publishing

Users can install addons directly from ZIP files. To publish your addon in the Wealthfolio Store, contact **<a href="mailto:wealthfolio@teymz.com" class="font-medium underline underline-offset-4">wealthfolio@teymz.com</a>**.

## Quick Start


### 🏃‍♂️ Quick Start

Create your first addon


<a href="/docs/addons/getting-started/" class="absolute inset-0"><span class="sr-only">View</span></a>


### 📖 API Reference

Explore available APIs


<a href="/docs/addons/api-reference/" class="absolute inset-0"><span class="sr-only">View</span></a>


### 📦 v3.7 Assets

Package images, fonts, media, configuration, and Wasm


<a href="/docs/addons/v3-7-assets/" class="absolute inset-0"><span class="sr-only">View</span></a>


### 💡 Examples

See real addon implementations


<a href="https://github.com/wealthfolio/wealthfolio-addons/tree/main/official" class="absolute inset-0"><span class="sr-only">View</span></a>


### 🏪 Addon Store

Explore available addons


<a href="https://wealthfolio.app/addons/" class="absolute inset-0"><span class="sr-only">View</span></a>


<a href="/docs/guide/self-hosting/pikapods/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">PikaPods</a> <a href="/docs/addons/getting-started/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Getting Started</a>


On this page

- <a href="#what-are-wealthfolio-addons" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">What are Wealthfolio Addons?</a>
- <a href="#architecture-overview" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Architecture Overview</a>
- <a href="#basic-addon-structure" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Basic Addon Structure</a>
- <a href="#permission-system" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Permission System</a>
  - <span class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground"></span>
- <a href="#available-apis" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Available APIs</a>
- <a href="#development-setup" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Development Setup</a>
  - <a href="#required-packages" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Required Packages</a>
  - <a href="#core-dependencies" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Core Dependencies</a>
  - <a href="#development-server" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Development Server</a>
- <a href="#project-structure" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Project Structure</a>
  - <a href="#manifest-file" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Manifest File</a>
- <a href="#packaged-assets" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Packaged Assets</a>
- <a href="#lifecycle-management" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Lifecycle Management</a>
  - <a href="#installation-process" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Installation Process</a>
  - <a href="#lazy-activation" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Lazy Activation</a>
  - <a href="#context-isolation" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Context Isolation</a>
- <a href="#ui-components" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">UI Components</a>
- <a href="#build-and-distribution" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Build and Distribution</a>
  - <a href="#build-configuration" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Build Configuration</a>
  - <a href="#package-scripts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Package Scripts</a>
- <a href="#error-handling" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Error Handling</a>
  - <a href="#addon-failures" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Addon Failures</a>
  - <a href="#permission-violations" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Permission Violations</a>
- <a href="#security-model" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Security Model</a>
- <a href="#publishing" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Publishing</a>
- <a href="#quick-start" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Quick Start</a>


