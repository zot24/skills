> Source: https://wealthfolio.app/docs/guide/custom-providers

Custom providers let you connect Wealthfolio to virtually any market data source — whether that's a paid API service, a free public API, or a website you want to scrape. You define a URL pattern, tell Wealthfolio where to find the price in the response, and the app handles the rest — fetching, parsing, and storing quotes alongside the built-in providers.

**Common use cases:**

- **Connect to paid data APIs** — Use services like Twelve Data, Polygon.io, or Alpha Vantage Pro with your own API key, passing it via authentication headers.
- **Add free public APIs** — CoinGecko for crypto, ExchangeRate API for currencies, or any other free JSON API.
- **Scrape websites** — Extract prices from web pages like FT.com, Euronext, or Borsa Italiana using CSS selectors.
- **Cover niche assets** — Regional bonds, private funds, illiquid ETFs, or anything the built-in providers don't support.

## Overview

A custom provider is a reusable, named configuration that:

- Fetches data from a URL you specify (JSON API, HTML page, HTML table, or CSV)
- Extracts prices (and optionally dates, currency, high/low/volume) using path expressions
- Supports URL templates with variables like `{SYMBOL}`, `{CURRENCY}`, `{FROM}`, `{TO}`
- Appears in the provider dropdown when editing any asset
- Runs automatically during market data sync

Each provider can have two sources:

| Source | Purpose | Required |
|--------|---------|----------|
| **Latest** | Fetches the current price | Yes |
| **Historical** | Fetches a date range of prices for backfilling | No |

Having separate sources lets you point at different API endpoints for real-time vs. historical data — a common pattern with most data APIs.

## Supported Formats

| Format | Best for | Extraction method |
|--------|----------|-------------------|
| **JSON** | REST APIs (CoinGecko, Twelve Data, etc.) | JSONPath expressions (`$.data.price`) |
| **HTML** | Web pages with a single visible price | CSS selectors (`.price-value`, `#quote`) |
| **HTML Table** | Pages with tabular historical data (FT.com, etc.) | Table & column index (`0:4` = first table, 5th column) |
| **CSV** | APIs that return CSV downloads | Column name or index (`close`, `3`) |

## Creating a Custom Provider

1. Go to **Settings > Market Data**.
2. Click **Add Custom Provider**.
3. Fill in the provider details:
   - **Name** — A display name (e.g., "CoinGecko", "FT London").
   - **Code** — Auto-generated from the name. Lowercase letters, numbers, and hyphens only. Must be unique and cannot use reserved names (yahoo, finnhub, etc.).
   - **Description** — Optional note for your reference.

### Configuring a Source

Each source (Latest / Historical) is configured in its own tab:

1. **Choose a format** — JSON, HTML, HTML Table, or CSV.
2. **Enter the URL** — Use template variables to make it dynamic (see [URL Template Variables](#url-template-variables)).
3. **Set the price path** — Tells Wealthfolio where to find the price value in the response.
4. **Click "Test"** — Fetches a sample response so you can verify extraction works.
5. **Optionally configure** date path, currency path, headers, factor, and other advanced options.

### Using Templates

To get started quickly, click the template dropdown and select a pre-configured provider. Templates fill in the URL, format, extraction paths, and a test symbol automatically.

**Available latest templates:**

| Template | Format | Description |
|----------|--------|-------------|
| CoinGecko | JSON | Free crypto prices (use coin ID: bitcoin, ethereum...) |
| ExchangeRate API | JSON | Free currency exchange rates |
| FT.com | HTML | LSE ETFs & equities |
| Euronext | HTML | EU funds & equities (ISIN-MIC) |
| Twelve Data | JSON | Stocks, crypto, FX (requires API key) |
| Borsa Italiana | HTML | Italian bonds & stocks |

**Available historical templates:**

| Template | Format | Description |
|----------|--------|-------------|
| Twelve Data (JSON) | JSON | Full OHLCV time series |
| Twelve Data (CSV) | CSV | Same data in CSV format |
| FT.com | HTML Table | LSE historical price tables |
| CoinGecko | JSON | Daily crypto price history |

### Testing Your Configuration

After entering a URL and price path, click **Test** to validate the setup:

- For **JSON** responses: The raw JSON is displayed with clickable numeric values. Click any value to auto-populate the price path field.
- For **HTML** responses: Detected numeric elements are listed with their CSS selectors and nearby labels.
- For **HTML Table** responses: All detected tables are shown with column roles auto-detected (date, close, high, low, volume).
- For **CSV** responses: Parsed rows and columns are previewed.

The test panel shows the **extracted price**, **date**, and **currency** so you can confirm everything looks correct before saving.

## Managing Custom Providers

All your custom providers are listed in **Settings > Market Data** alongside the built-in providers.

### Enable / Disable

Each provider has an **enable toggle**. Disabled providers are ignored during sync — they won't be tried for any asset, even if set as that asset's preferred provider. This is useful for temporarily pausing a provider without deleting its configuration.

### Priority

Use the **priority slider** to control the order in which providers are tried when no preferred provider is set on an asset. Lower numbers = higher priority. Custom providers can be interleaved with built-in providers in any order you like.

Note: If an asset has a **Preferred Provider** set, that always overrides the global priority order for that asset.

### Editing and Deleting

- Click **Edit** to modify a provider's sources, URL, paths, or headers.
- Click **Delete** to permanently remove a provider.

<Callout icon="⚠️" type="warning">
You cannot delete a provider that is still assigned to one or more assets. First change those assets' preferred provider to something else (or "Auto"), then delete.
</Callout>

## URL Template Variables

Use these variables in your URL — they are replaced at runtime with values from the asset being fetched:

| Variable | Replaced with | Example |
|----------|--------------|---------|
| `{SYMBOL}` | The asset's ticker symbol | `AAPL`, `bitcoin`, `VWCE` |
| `{ISIN}` | The asset's ISIN code | `IE00BK5BQT80` |
| `{CURRENCY}` | Currency hint (uppercase) | `EUR`, `USD` |
| `{currency}` | Currency hint (lowercase) | `eur`, `usd` |
| `{MIC}` | Exchange MIC code | `XETR`, `XAMS` |
| `{TODAY}` | Current date (YYYY-MM-DD) | `2026-03-30` |
| `{FROM}` | Start of date range (YYYY-MM-DD) | `2025-01-01` |
| `{TO}` | End of date range (YYYY-MM-DD) | `2026-03-30` |
| `{DATE:format}` | Current date with custom format | `{DATE:%Y%m%d}` → `20260330` |

**Example URL:**

```
https://api.coingecko.com/api/v3/simple/price?ids={SYMBOL}&vs_currencies={currency}
```

For an asset with symbol `bitcoin` and currency `EUR`, this becomes:

```
https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eur
```

## Extraction Paths

### JSON — JSONPath

Use [JSONPath](https://goessner.net/articles/JsonPath/) expressions to extract values from JSON responses.

**Single value (latest price):**

```
$.bitcoin.eur           → { "bitcoin": { "eur": 62500 } }
$.price                 → { "price": 152.30 }
$.data[0].close         → { "data": [{ "close": 152.30 }] }
```

**Array of values (historical):**

```
$.prices[*][1]          → { "prices": [[1711843200000, 62500], [1711929600000, 63100]] }
$.values[*].close       → { "values": [{ "close": 152 }, { "close": 153 }] }
```

Template variables work inside paths too:

```
$.{SYMBOL}.{currency}   → resolves to $.bitcoin.eur
```

### HTML — CSS Selectors

Use standard CSS selectors to target elements on a web page:

```
.mod-tearsheet-overview__quote .mod-ui-data-list__value
#header-instrument-price
.summary-value strong
```

The text content of the matched element is parsed as a number.

### HTML Table — Table Coordinates

Use the format `table_index:column_index` (both zero-based):

```
0:4    → First table on the page, 5th column (e.g., "Close")
0:0    → First table, 1st column (e.g., "Date")
1:2    → Second table, 3rd column
```

When testing an HTML table source, Wealthfolio auto-detects column roles (date, close, high, low, volume) based on header text — in English, German, French, Spanish, and Italian.

### CSV — Column Names or Indices

Reference columns by their header name or zero-based index:

```
close       → Column named "close" (case-insensitive)
datetime    → Column named "datetime"
4           → 5th column by index
```

## Advanced Options

Each source configuration has a set of advanced options that let you handle edge cases in how data is returned by different APIs and websites.

### Authentication Headers

If the API requires authentication, add custom HTTP headers as a JSON object:

```json
{
  "Authorization": "apikey YOUR_API_KEY",
  "Accept": "application/json"
}
```

Common header patterns:

| API style | Header example |
|-----------|---------------|
| API key in header | `{"Authorization": "apikey abc123"}` |
| Bearer token | `{"Authorization": "Bearer abc123"}` |
| Custom header | `{"X-Api-Key": "abc123"}` |
| Multiple headers | `{"Authorization": "Bearer abc123", "Accept": "application/json"}` |

<Callout icon="🔒" type="warning">
**Secure storage for secrets:** Prefix any sensitive value with `__SECRET__` (e.g., `__SECRET__my_api_key`) and Wealthfolio will store it in your OS keyring (macOS Keychain, Windows Credential Manager, Linux Secret Service) rather than in the database. Non-secret headers like `Accept` are stored in the database as-is. At runtime, `__SECRET__` placeholders are resolved transparently.
</Callout>

### Factor

Multiply the extracted price by a constant number. Set this when the raw value from the API doesn't match the unit you need:

| Scenario | Factor | Why |
|----------|--------|-----|
| API returns pence (GBX), you need pounds (GBP) | `0.01` | 1 pence = 0.01 pounds |
| API returns basis points | `0.0001` | 1 bp = 0.0001 |
| API returns percentage, you need decimal | `0.01` | 5% → 0.05 |
| NAV reported per 1000 units | `0.001` | Scale to per-unit |

Leave empty (or `1`) to use the raw extracted value.

### Invert

When enabled, the final result becomes `1 / extracted_price`. This is applied **after** the factor.

Typical use case: your source provides USD/EUR (how many euros per dollar) but your asset tracks EUR/USD (how many dollars per euro). Enable **Invert** to flip the rate.

### Currency Path

A path expression (JSONPath or CSS selector, depending on format) to extract the currency code from the response. If the API response includes the currency of the quoted price, point this path to it. Otherwise leave it empty — the asset's own currency is used.

```
$.currency          → { "price": 152.30, "currency": "USD" }
$.meta.currency     → { "meta": { "currency": "EUR" }, "price": 62500 }
```

### Locale

Controls how numbers with commas and dots are interpreted:

| Source value | Auto-detect result | With locale `de` |
|--------------|--------------------|-------------------|
| `1,234.56` | 1234.56 (US format) | 1234.56 (US format) |
| `1.234,56` | 1234.56 (European) | 1234.56 (European) |
| `1.234` | 1.234 (ambiguous → US) | 1234 (European: dot = thousands) |

Auto-detect works in most cases. Set an explicit locale (`de`, `fr`, `es`, `it`) when the source consistently uses European formatting and you want to eliminate ambiguity — especially for values without a decimal part like `1.234` which could mean either 1.234 or 1234.

The parser also strips currency symbols (`$`, `€`, `£`, `¥`, `₹`, `%`, etc.) automatically before parsing.

### Date Format

For historical sources, Wealthfolio needs to parse dates from the response. It auto-detects these formats:

| Format | Example | Auto-detected? |
|--------|---------|----------------|
| ISO 8601 | `2026-03-30` or `2026-03-30T12:00:00Z` | Yes |
| Unix seconds | `1711843200` | Yes |
| Unix milliseconds | `1711843200000` | Yes |
| Day serial (Excel) | `45381` | Yes |

If the API returns dates in a different format, set a custom format string using [chrono syntax](https://docs.rs/chrono/latest/chrono/format/strftime/index.html):

| Date example | Format string |
|-------------|---------------|
| `30/03/2026` | `%d/%m/%Y` |
| `Mar 30, 2026` | `%b %d, %Y` |
| `20260330` | `%Y%m%d` |
| `30-Mar-2026` | `%d-%b-%Y` |

### Date Timezone

Specify a timezone when the source returns dates without timezone info and you need them interpreted in a specific zone. Uses IANA timezone names:

- `Europe/Berlin`
- `America/New_York`
- `Asia/Tokyo`

Leave empty to use UTC (the default).

### Default Price

A fallback price returned when the HTTP request fails entirely (network error, timeout, server error after retry). This does **not** apply when the request succeeds but the extraction path finds no value.

Useful for:
- Private/internal APIs that may be intermittently unavailable
- Sources behind VPNs where connectivity is unreliable
- Assets with a known stable value (e.g., a money market fund at ~1.00)

### Optional OHLCV Paths

For historical sources, you can extract additional market data beyond the closing price. Each uses the same path syntax as the price path for the selected format:

| Field | What it captures | Path example (JSON) |
|-------|-----------------|---------------------|
| **High path** | Daily high price | `$.values[*].high` |
| **Low path** | Daily low price | `$.values[*].low` |
| **Volume path** | Trading volume | `$.values[*].volume` |

These are optional — if omitted, only the closing price is stored.

For **HTML Table** format, use the same `table_index:column_index` syntax:

```
High path:   0:2
Low path:    0:3
Volume path: 0:5
```

For **CSV** format, use column names:

```
High path:   high
Low path:    low
Volume path: volume
```

### All Advanced Options at a Glance

| Option | Purpose | When to use |
|--------|---------|-------------|
| **Headers** | Custom HTTP headers (auth, accept, etc.) | API requires authentication |
| **Factor** | Multiply price by a constant | Price in wrong unit (pence, basis points) |
| **Invert** | Compute 1/price | FX pair is inverted vs. what you need |
| **Currency path** | Extract currency from response | API returns multi-currency data |
| **Locale** | Force European number parsing | Source uses comma as decimal separator |
| **Date format** | Custom date parsing | Non-standard date format in response |
| **Date timezone** | Interpret dates in a timezone | Source has no timezone info |
| **Default price** | Fallback on request failure | Unreliable or private sources |
| **OHLCV paths** | Extract high, low, volume | You want full candle data |

## Configuring Market Data per Asset

The **Market Data** tab on each asset lets you control exactly how prices are fetched for that specific asset. You can set a preferred provider, override the symbol sent to each provider, and switch between automatic and manual pricing.

### Preferred Provider

By default, Wealthfolio uses **Auto** — it tries providers in priority order until one succeeds (see [How Provider Resolution Works](#how-provider-resolution-works)). You can override this per asset:

1. Open the asset detail page and click **Edit**.
2. Go to the **Market Data** tab.
3. In the **Preferred Provider** dropdown, select a provider.

The dropdown is divided into two groups:

- **Built-in** — Yahoo, Alpha Vantage, Finnhub, etc.
- **Custom** — Any custom providers you've created.

When you select a provider, it becomes the **first** provider tried for this asset. If it fails, the system still falls through to other providers in priority order.

### Symbol Mapping (Overrides)

Different providers often use different symbols for the same asset. For example, Shopify trades on the Toronto Stock Exchange:

- Yahoo Finance expects `SHOP.TO`
- Alpha Vantage expects `SHOP`
- A custom CoinGecko provider expects `shopify-token`

By default, Wealthfolio applies built-in rules to derive the correct symbol per provider (e.g., appending `.TO` for Yahoo when the exchange MIC is `XTSE`). When these rules don't work, you can set explicit overrides:

1. In the **Market Data** tab, find the **Symbol Mapping** section.
2. Click **Add**.
3. Select the **Provider** and enter the **Symbol** that provider expects.
4. Add as many mappings as needed — one per provider.

Each mapping tells that specific provider to use your custom symbol instead of the default. Other providers are unaffected.

**Example:** An asset with ticker `VWCE` on Euronext Amsterdam (`XAMS`):

| Provider | Default symbol (from rules) | Override needed? |
|----------|----------------------------|------------------|
| Yahoo | `VWCE.AS` (auto-derived) | No |
| Custom: Euronext | `VWCE` | Yes — set to `IE00BK5BQT80-XAMS` |
| Custom: FT.com | `VWCE` | Yes — set to `VWCE` |

### Automatic vs. Manual Pricing

The **Automatic Updates** toggle controls whether prices sync from providers:

- **On** (default): Prices are fetched automatically during each sync cycle. The Preferred Provider and Symbol Mapping settings apply.
- **Off**: Automatic syncing is disabled. You enter and maintain prices manually. Existing manual quotes are preserved.

<Callout icon="⚠️" type="warning">
Switching from manual back to automatic may overwrite your manually entered quotes on the next sync.
</Callout>

## How Provider Resolution Works

When Wealthfolio needs a price for an asset, it follows a structured resolution process to determine which provider to query and what symbol to send.

### Step 1: Order Providers by Priority

Providers are sorted to determine the order in which they are tried:

1. **Preferred provider** (if set on the asset) — always tried first.
2. **Custom priority** — providers you've reordered in Settings > Market Data.
3. **Default priority** — the provider's built-in priority.

If no preferred provider is set, the app uses the global priority order from your settings.

### Step 2: Resolve the Symbol

For each provider (in order), the app resolves what symbol to send using a two-step chain:

1. **Check asset-level overrides** — If you've set a symbol mapping for this specific provider on this asset, use it. This is the highest precedence.
2. **Apply built-in rules** — If no override exists, derive the symbol using rules based on the asset type and exchange:
   - **Equities**: Ticker + exchange suffix (e.g., `SHOP` on `XTSE` → `SHOP.TO` for Yahoo)
   - **Crypto**: Provider-specific format (e.g., `BTC-USD` for Yahoo, `bitcoin` for CoinGecko)
   - **FX pairs**: Provider-specific format (e.g., `EURUSD=X` for Yahoo)
   - **Bonds**: ISIN code directly
   - **Custom providers**: Use the asset's ticker (or symbol override) as-is, inserted into the URL template via `{SYMBOL}`

### Step 3: Fetch with Fallback

The app tries each provider in order:

1. Resolve the symbol for this provider.
2. Fetch the quote.
3. **If successful** — store the quote and stop.
4. **If failed** — classify the error:
   - *Auth/not found (401, 403, 404)* — stop immediately, don't try other providers for this error type.
   - *Rate limited or server error (429, 5xx)* — mark provider as temporarily unreliable, try the next provider.
   - *Network/timeout* — try the next provider.
5. If all providers fail, the asset has no price for this sync cycle.

### How Custom Providers Fit In

Custom providers participate in this same resolution chain. When an asset's preferred provider is set to a custom provider:

1. The app routes the request to the single internal `CUSTOM_SCRAPER` engine.
2. The engine looks up the provider configuration by its code (e.g., `coingecko`).
3. It resolves the symbol: first checking for a symbol override keyed as `CUSTOM:coingecko`, then falling back to the asset's default ticker.
4. It expands the URL template, fetches the response, and extracts the price.

This means you can have multiple custom providers (CoinGecko, FT.com, Euronext) and assign different ones to different assets — they all use the same underlying engine but with different configurations.

### Resolution Example

Consider an asset: **VWCE** (Vanguard FTSE All-World ETF) on Euronext Amsterdam.

| Setting | Value |
|---------|-------|
| Ticker | `VWCE` |
| Exchange (MIC) | `XAMS` |
| Preferred provider | Custom: Euronext |
| Symbol mapping | `CUSTOM:euronext` → `IE00BK5BQT80-XAMS` |

**Resolution:**

1. **Preferred provider: Euronext (custom)** — tried first
   - Symbol override found: `IE00BK5BQT80-XAMS`
   - URL: `https://live.euronext.com/en/ajax/getDetailedQuote/IE00BK5BQT80-XAMS`
   - Fetches successfully → done.

2. **If Euronext fails → Yahoo (next in priority)**
   - No override → built-in rules: `VWCE` + `XAMS` suffix → `VWCE.AS`
   - Fetches from Yahoo with `VWCE.AS`

3. **If Yahoo fails → Alpha Vantage (next)**
   - No override → built-in rules: `VWCE`
   - And so on...

## Examples

### Example 1: CoinGecko (Crypto)

Fetch crypto prices using CoinGecko's free API.

**Latest source:**
- Format: JSON
- URL: `https://api.coingecko.com/api/v3/simple/price?ids={SYMBOL}&vs_currencies={currency}`
- Price path: `$.{SYMBOL}.{currency}`

**Historical source:**
- Format: JSON
- URL: `https://api.coingecko.com/api/v3/coins/{SYMBOL}/market_chart?vs_currency={currency}&days=365&interval=daily`
- Price path: `$.prices[*][1]`
- Date path: `$.prices[*][0]`

**Asset setup:** Set the asset's symbol override to the CoinGecko coin ID (e.g., `bitcoin`, `ethereum`, `solana`).

---

### Example 2: FT.com (LSE ETFs)

Scrape latest prices from the Financial Times website and historical data from their table page.

**Latest source:**
- Format: HTML
- URL: `https://markets.ft.com/data/etfs/tearsheet/summary?s={SYMBOL}:LSE:GBX`
- Price path: `.mod-tearsheet-overview__quote .mod-ui-data-list__value`

**Historical source:**
- Format: HTML Table
- URL: `https://markets.ft.com/data/etfs/tearsheet/historical?s={SYMBOL}:LSE:GBX`
- Price path: `0:4` (Close column)
- Date path: `0:0` (Date column)
- High path: `0:2`
- Low path: `0:3`

---

### Example 3: Twelve Data (Stocks with API Key)

Use Twelve Data's API for stocks, crypto, and FX with your API key.

**Latest source:**
- Format: JSON
- URL: `https://api.twelvedata.com/price?symbol={SYMBOL}`
- Price path: `$.price`
- Headers: `{"Authorization": "apikey YOUR_API_KEY"}`

**Historical source:**
- Format: JSON
- URL: `https://api.twelvedata.com/time_series?symbol={SYMBOL}&interval=1day&start_date={FROM}&end_date={TO}&format=JSON`
- Price path: `$.values[*].close`
- Date path: `$.values[*].datetime`
- High/Low/Volume paths: `$.values[*].high`, `$.values[*].low`, `$.values[*].volume`
- Headers: `{"Authorization": "apikey YOUR_API_KEY"}`

---

### Example 4: Euronext (EU Funds)

Scrape fund prices from the Euronext live data endpoint.

**Latest source:**
- Format: HTML
- URL: `https://live.euronext.com/en/ajax/getDetailedQuote/{SYMBOL}`
- Price path: `#header-instrument-price`

**Asset setup:** Set the asset's symbol override to the ISIN-MIC format (e.g., `NL0015000GU4-XAMS`).

---

### Example 5: ExchangeRate API (Currency Rates)

Fetch free currency exchange rates.

**Latest source:**
- Format: JSON
- URL: `https://open.er-api.com/v6/latest/{SYMBOL}`
- Price path: `$.rates.EUR`

**Asset setup:** Set the asset's symbol to the base currency code (e.g., `USD`). Adjust the price path to your target currency.

## Recipe Gallery

Real-world configurations the community has shared. Each is a starting point; adapt to
your needs.

### Precious metals (spot price via Yahoo)

Track physical gold, silver, etc. via Yahoo's commodity futures symbols.

- Format: JSON
- URL: `https://query1.finance.yahoo.com/v8/finance/chart/{SYMBOL}`
- Price path: `$.chart.result[0].meta.regularMarketPrice`
- Asset symbols: `GC=F` (gold), `SI=F` (silver), `PL=F` (platinum), `PA=F` (palladium).
- Currency: USD per troy ounce.

### Argentinian CEDEARs (underlying + FX)

CEDEARs are receipts for foreign stocks priced in ARS. Track the underlying in USD via
Yahoo and apply your ARS/USD exchange rate via Wealthfolio's FX settings.

- Format: JSON
- URL: `https://query1.finance.yahoo.com/v8/finance/chart/{SYMBOL}`
- Price path: `$.chart.result[0].meta.regularMarketPrice`
- Asset symbol: the underlying ticker (e.g. `AAPL`). Set the asset's CEDEAR ratio in
  notes for your own reference.
- Currency: USD on the asset; Wealthfolio converts to your ARS base.

### Central bank reference rates (ECB)

Daily ECB reference rates for EUR pairs.

- Format: HTML Table
- URL: `https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/{SYMBOL}.xml.en.html`
- Asset symbol: the target currency code (e.g. `USD`).
- Table index: 0
- Column index: 1 (the rate column)

### UK mutual funds (FT.com scraping)

Many UK OEICs / unit trusts don't have Yahoo tickers. The Financial Times publishes
them publicly.

- Format: HTML
- URL: `https://markets.ft.com/data/funds/tearsheet/summary?s={SYMBOL}`
- Price selector: `.mod-ui-data-list__value` (first match; inspect with DevTools to
  confirm the exact selector for your fund's page)
- Asset symbol: the fund's ISIN.
- Currency: GBP (typically).

### CoinGecko (crypto with full history)

Built-in crypto coverage is fine for top symbols, but CoinGecko has long historical
ranges that other providers don't.

- Format: JSON (Latest)
- URL: `https://api.coingecko.com/api/v3/simple/price?ids={SYMBOL}&vs_currencies=usd`
- Price path: `$.{SYMBOL}.usd`
- Asset symbol: CoinGecko's coin ID (`bitcoin`, `ethereum`, etc.).

- Format: JSON (Historical)
- URL: `https://api.coingecko.com/api/v3/coins/{SYMBOL}/market_chart/range?vs_currency=usd&from={START_TS}&to={END_TS}`
- Path: `$.prices[*]` (returns `[timestamp_ms, price]` arrays).

### Local / self-hosted scraper

Run your own scraping endpoint (Node, Python, whatever) and point Wealthfolio at it.
A reverse proxy in front of the endpoint is the most robust setup (Wealthfolio resolves
a hostname instead of a hardcoded LAN IP, and your TLS terminates there).

- Format: JSON
- URL: `https://internal.example.com/price?symbol={SYMBOL}` (behind your proxy) or
  `http://192.168.1.50:8080/price?symbol={SYMBOL}` if you're using a direct LAN IP.
- Price path: whatever your endpoint returns (e.g. `$.price`).

---

## Limitations

- **No JavaScript execution** — Pages that require JavaScript to load content (SPAs, dynamic widgets) are not supported. The scraper fetches raw HTML only.
- **No XPath** — HTML extraction uses CSS selectors, not XPath.
- **No XML/RSS** — Only JSON, HTML, HTML table, and CSV formats are supported.
- **No GraphQL** — Only REST-style HTTP GET/POST endpoints are supported.
- **Global sync interval** — Custom providers run on the same sync schedule as built-in providers. Per-provider intervals are not supported.
- **Rate limiting + circuit breaker** — A built-in rate limiter caps requests per minute and a circuit breaker backs off after repeated failures. Exact values match the provider category (the default in `crates/market-data` is 60 requests/min with a 100ms minimum delay; some providers tighten that).
- **HTTP timeouts** — Requests have a finite timeout. Long-running endpoints will fail rather than block the sync queue.

## Troubleshooting

**"No price extracted" after testing**
- Verify the URL returns data by opening it in a browser.
- For JSON: Check that your JSONPath matches the response structure. Use the clickable values in the test preview to auto-populate the correct path.
- For HTML: The CSS selector may not match. Use browser DevTools to inspect the element and copy its selector.
- For HTML Table: Verify the table and column indices. The test preview shows all detected tables.

**Provider not appearing in asset dropdown**
- Make sure the provider is **enabled** in Settings > Market Data.
- Confirm it was saved successfully (check for validation errors).

**Prices not updating during sync**
- The asset must have its **Preferred Provider** set to your custom provider.
- Check that "Automatic Updates" is enabled on the asset's Market Data tab.
- If only a "Latest" source is configured, only the current price is fetched each sync — historical backfill requires a "Historical" source.

**Authentication errors (401/403)**
- Double-check your API key in the headers JSON.
- Some APIs require specific header formats (e.g., `Bearer TOKEN` vs. `apikey TOKEN`).

**European number formats not parsed correctly**
- If the source returns numbers like `1.234,56`, set the **Locale** to `de`, `fr`, `es`, or `it` to force European decimal parsing.
