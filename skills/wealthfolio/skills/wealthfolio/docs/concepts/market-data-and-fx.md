> Source: https://wealthfolio.app/docs/concepts/market-data-and-fx



Docs


Market Data & FX


# Market Data & FX

How Wealthfolio resolves symbols, fetches prices, and converts between currencies, and where to expect gain/loss to move when the FX rate moves.


Last updated November 12, 2026

### How symbols work

Wealthfolio stores each asset’s identifier as a **canonical ticker** (e.g. `RY`, `AAPL`, `BTC`) plus an optional **exchange MIC code** (`XTSE`, `XNAS`, `XLON`…). That pair is provider-agnostic; the same asset can be priced by Yahoo, Alpha Vantage, Börse Frankfurt, OpenFIGI, or a custom scraper, and Wealthfolio’s resolver translates the canonical pair into whatever format each provider expects.

When you add an asset you can type either:

- The bare ticker (`AAPL`): for US equities the MIC defaults to `XNAS`.
- A Yahoo-style suffix (`RY.TO`): Wealthfolio parses the suffix into a ticker + MIC.
- A MIC-qualified form (`RY @ XTSE`): same outcome.

If a specific provider expects a different symbol for an asset (one of your custom scrapers fetches `SHOP` as `SHOP-CA`, say), set a **per-provider override** on the asset’s Market data tab. The canonical symbol stays clean; the override is used only when querying that one provider.

### Built-in providers


| Provider | Covers | Symbol format |
|----|----|----|
| **Yahoo Finance** | Equities, ETFs, crypto, FX, commodities | Ticker + Yahoo suffix (`RY.TO`, `BTC-USD`, `EURUSD=X`) |
| **Alpha Vantage** | Equities, crypto, FX (BYO key) | Ticker + Alpha Vantage exchange code |
| **Finnhub** | Equities, company profiles (BYO key) | Bare ticker |
| **MarketData.app** | Equities (BYO key) | Bare ticker |
| **OpenFIGI** | Bonds, identifier lookup | ISIN (e.g. `US912797KL68`) |
| **Börse Frankfurt** | German exchange listings | `MIC:ticker` (e.g. `XETR:SAP`) |
| **Metal Price API** | Precious metals spot | Metal code |
| **US Treasury (Calculated)** | US Treasuries | CUSIP or ISIN |
| **Moscow Exchange** | Shares, ETFs, funds and depositary receipts on MOEX | MOEX security code, exchange `MISX` (e.g. `SBER`) |
| **AMFI** | Indian mutual funds | ISIN or AMFI scheme code (e.g. `122639`) |
| **Custom providers** | Anything you can hit with HTTP | User-defined template (<a href="/docs/guide/custom-providers/" class="font-medium underline underline-offset-4">guide</a>) |


**Settings → Market data** lists the built-in providers that are on, in the order they’re tried, each with arrows to move it and a switch. When more than one provider covers an asset, the higher one is tried first. **Add provider** lists the rest, with a search. Moscow Exchange and AMFI are off until you add them, and get no requests before that.

You pick the **preferred provider** per asset. If the preferred one is unhealthy or rate-limited, the resolver falls through to other capable providers.

#### Indian mutual funds (AMFI)

AMFI prices Indian mutual funds from AMFI’s daily NAVs, with no API key. After adding it, search for a fund’s ISIN or AMFI scheme code, such as `122639`, when you add a security or an activity, and pick AMFI’s result. The fund takes AMFI’s name for the scheme, plan and option.

For a fund you already track, choose **AMFI** as the **Preferred provider** on the fund’s **Market data** tab. AMFI finds the fund by its ISIN, or by a symbol that is an ISIN or a scheme code; otherwise, add an AMFI symbol mapping. A fund that has closed or merged is priced by its ISIN too. AMFI prices only the funds you choose it for or map a symbol for, so adding it doesn’t change how other securities are priced.

AMFI funds listed under a debt category, such as liquid, overnight, or money market funds, are classified as fixed income.

#### Moscow Exchange (MOEX)

Moscow Exchange prices shares, ETFs, funds and depositary receipts traded on MOEX, with delayed quotes and daily history, delisted securities included, and no API key. With it on, a new Moscow Exchange security is priced by MOEX instead of a foreign listing with the same ticker. A MOEX symbol is the security code with no prefix or suffix, such as `SBER` or `AFLT`, on the Moscow Exchange (`MISX`). Bonds and dividends aren’t covered.

#### US Treasuries

US Treasury (Calculated) calculates US Treasury bond prices from yield curve data published by the US Treasury Department. Treasury notes and bonds added by CUSIP or ISIN get their terms from TreasuryDirect, so their price can be calculated.

### Yahoo Finance suffix table

Yahoo is the default provider for most users, so its suffix convention is the one you’ll see most often. The mappings:


| Exchange                 | Suffix | Example       |
|--------------------------|--------|---------------|
| NASDAQ / NYSE (US)       | *none* | `AAPL`        |
| Toronto Stock Exchange   | `.TO`  | `RY.TO`       |
| TSX Venture (Canada)     | `.V`   | `WELL.V`      |
| London Stock Exchange    | `.L`   | `HSBA.L`      |
| Euronext Amsterdam       | `.AS`  | `IWDA.AS`     |
| Euronext Paris           | `.PA`  | `MC.PA`       |
| Euronext Brussels        | `.BR`  | `KBC.BR`      |
| Xetra (Germany)          | `.DE`  | `SAP.DE`      |
| SIX Swiss Exchange       | `.SW`  | `NESN.SW`     |
| Borsa Italiana           | `.MI`  | `ENI.MI`      |
| BME (Madrid)             | `.MC`  | `SAN.MC`      |
| Hong Kong Stock Exchange | `.HK`  | `0700.HK`     |
| Tokyo Stock Exchange     | `.T`   | `7203.T`      |
| Shanghai                 | `.SS`  | `601398.SS`   |
| Shenzhen                 | `.SZ`  | `000333.SZ`   |
| Australia (ASX)          | `.AX`  | `BHP.AX`      |
| New Zealand (NZX)        | `.NZ`  | `FPH.NZ`      |
| Bovespa (São Paulo)      | `.SA`  | `PETR4.SA`    |
| BMV (Mexico)             | `.MX`  | `WALMEX.MX`   |
| Stockholm                | `.ST`  | `VOLV-B.ST`   |
| Helsinki                 | `.HE`  | `NOKIA.HE`    |
| Oslo                     | `.OL`  | `EQNR.OL`     |
| Copenhagen               | `.CO`  | `NOVO-B.CO`   |
| Warsaw                   | `.WA`  | `PKO.WA`      |
| Vienna                   | `.VI`  | `EBS.VI`      |
| Johannesburg             | `.JO`  | `MTN.JO`      |
| Tel Aviv (TASE)          | `.TA`  | `TEVA.TA`     |
| BSE (India)              | `.BO`  | `RELIANCE.BO` |
| NSE (India)              | `.NS`  | `RELIANCE.NS` |


For comprehensive market coverage and potential data delays, consult <a href="https://help.yahoo.com/kb/finance-for-web/sln2310.html" class="font-medium underline underline-offset-4">Yahoo Finance’s market coverage docs</a>.

#### Custom Assets

You can also track assets that do not have automatic market prices. See <a href="/docs/guide/assets/" class="font-medium underline underline-offset-4">Assets &amp; Securities</a> for manual pricing, asset details, classification, and the differences between securities and alternative assets.

## Symbol lookup

1.  Exact ticker (`AAPL`, `BTC-USD`).
2.  Ticker + suffix (`RY.TO`).
3.  First Yahoo Finance hit.

With AMFI on, a fund’s ISIN or AMFI scheme code also finds AMFI’s result. With Moscow Exchange on, search also includes MOEX listings.

## FX rates

- Pulled with the other market data from the default market data provider.
- View/edit and add manual rates via `Settings→General→Exchange Rates`.
- Manual rates you define take precedence over automatically fetched market data for the specified currency pairs and will be used by the system until you modify or remove them.
- Crypto pairs such as BTC/USD are fetched with Yahoo’s crypto symbol (`BTC-USD`). A pair added before 3.13 keeps the old symbol and fails to sync. To fix it, open the pair’s history from Settings → General → Exchange rates, choose **Edit**, and under **Market data** → **Symbol mapping** set its Yahoo symbol to `BTC-USD`.
- A property, vehicle, liability, or other alternative asset in a currency other than your base currency gets its exchange rate fetched too.

### Levels of Currency

The application handles currencies at four distinct levels to provide accurate and flexible financial tracking:

1.  **Base Currency**: This is the primary currency for your entire portfolio. All aggregated reports and overall wealth summaries are presented in this currency. You set this once, typically when you first set up the application.
2.  **Account Currency**: Each account (e.g., a specific bank account, brokerage account) can have its own designated currency. This is the currency in which the account itself is denominated. For example, you might have a USD-denominated brokerage account and a EUR-denominated bank account.
3.  **Asset/Holding Currency**: This refers to the currency in which a specific asset or holding is traded or valued. For instance, if you own shares of a company listed on the Tokyo Stock Exchange, the asset currency would likely be JPY. A listing quoted in a currency other than its exchange’s usual one, such as a USD-traded London ETF, keeps that currency after its profile is fetched.
4.  **Activity Currency**: This is the currency used for a specific transaction or activity, such as a buy/sell order, dividend payment, or fee. For example, if you buy US stocks using your CAD bank account, the activity of purchasing might involve a CAD to USD conversion, and the activity currency for the purchase itself would be USD.

Enter **unit price, amount, fee, and tax in the activity currency**. An asset quoted in USD can still have a trade entered in CAD if the broker reports its trade details in CAD. The asset quote currency does not change how the trade total is calculated.

An activity’s **FX rate** converts activity currency to account currency. For example, a USD activity in a CAD account uses `1.36` when USD 1 = CAD 1.36. This is separate from conversion to your portfolio’s base currency.

For a BUY or SELL, a positive supplied FX rate books cash in the account currency. Without it, cash stays in the activity currency. Other cash activities, such as deposits and dividends, keep their activity currency even when an FX rate is supplied. That rate can still affect contribution reporting. The cash balance shown in account or base currency uses available exchange-rate data. See <a href="/docs/concepts/activity-fields/" class="font-medium underline underline-offset-4">Activity Fields</a> for examples.

### Automatic Currency Unit Normalization

Wealthfolio automatically handles minor currency units and normalizes them to their major currency equivalents. This means you don’t need to manually configure exchange rates for these conversions.

Conversions look up a minor unit through its major currency’s rate. A manual rate in a minor unit, such as GBp/USD, is refused with a message to enter the major currency’s rate (GBP/USD) instead.

For example, market data from sources like Yahoo Finance often provides prices for securities traded on the London Stock Exchange (LSE) in pence (GBp or GBX, where GBX is the official currency code for Penny Sterling) rather than pounds (GBP). The application automatically recognizes these minor units and converts them to the major currency (GBP) using the correct conversion factor.

#### Supported Minor Currency Units

The system automatically normalizes the following minor currency units:

- **GBp, GBX** (Pence) → **GBP** (British Pound) at 0.01 conversion factor
- **ZAc, ZAC** (South African Cents) → **ZAR** (South African Rand) at 0.01 conversion factor
- **ILA** (Agorot) → **ILS** (Israeli New Shekel) at 0.01 conversion factor
- **KWF** (Fils) → **KWD** (Kuwaiti Dinar) at 0.001 conversion factor
- **USX** (US Cents) → **USD** (US Dollar) at 0.01 conversion factor

When prices are quoted in these minor units, the application automatically converts them to the major currency for accurate valuation and reporting. This resolves common discrepancies without requiring manual intervention, as previously discussed in community threads (see <a href="https://github.com/wealthfolio/wealthfolio/issues/107" class="font-medium underline underline-offset-4">GitHub Issue #107</a> and <a href="https://github.com/wealthfolio/wealthfolio/issues/134" class="font-medium underline underline-offset-4">GitHub Issue #134</a>).

The currency conversion processes exchange rates with the following logic:

- **Historical Data**: The system stores and utilizes historical exchange rates.
- **Daily Rate Selection**: For a given currency pair (e.g., USD/EUR) on a specific day, if multiple rate entries exist, the system selects the rate with the latest timestamp of that day. This ensures the most up-to-date daily rate is used.
- **Automatic Rate Derivation**:
  - **Inverse Rates**: If a rate such as USD to EUR is provided, the converter automatically calculates and makes available the inverse rate (EUR to USD).
  - **Transitive Rates**: The system can derive rates through a common currency. For instance, if rates for USD to EUR and EUR to GBP are known, the rate for USD to GBP can be automatically calculated.
  - **Identity Rates**: Converting a currency to itself (e.g., CAD to CAD) is treated as a 1:1 conversion.
- **Rate Lookup Options**:
  - **Specific Date Lookup**: You can request an exchange rate for a precise date.
  - **Nearest Date Lookup**: If an exchange rate is not available for the exact specified date, the system can find and use the rate from the closest available date. It considers both past and future dates relative to your request and selects the one chronologically nearest.
- **Currency Code Handling**: Currency codes (e.g., “USD”, “cad”, “Eur”) are processed while preserving their original casing for lookups and storage.

## FX and gain/loss

Multi-currency portfolios surface a subtle question: when your base currency is CAD and you hold a USD stock, is your gain in **USD** (the security’s currency) or **CAD** (your reporting currency)? Wealthfolio reports both, and they can diverge significantly when FX rates move.

### Worked example

You’re a Canadian investor. Base currency: **CAD**.

``` mb-4
2024-01-10   BUY 10 AAPL @ $180 USD
             FX rate on trade date: 1 USD = 1.35 CAD
             Cost basis stored:
               $1,800 USD   (asset currency)
               $2,430 CAD   (converted at the trade-date rate)

2024-12-15   AAPL spot price: $240 USD
             Today's FX rate: 1 USD = 1.40 CAD

             Current value:
               $2,400 USD                        = unrealized gain $600 USD
               $3,360 CAD (10 × $240 × 1.40)    = unrealized gain $930 CAD
```

The USD gain is \$600 (\$240 - \$180) × 10. The CAD gain is \$930, bigger because the USD strengthened against the CAD over the holding period. **The same trade looks different depending on which currency you look through.**

This is how every multi-currency tracker works, but it surprises people because the gain moves even when the share price hasn’t.

### ”My gain changed but I didn’t do anything”

The most common reasons your base-currency gain moved without any trade activity:

- **FX rate moved.** Even if the underlying stock is flat, your CAD-denominated gain changes as USD/CAD moves.
- **Quote source changed currency unit.** Yahoo sometimes flips between GBp (pence) and GBP (pounds) for UK stocks. Wealthfolio normalizes the common units (see below). If it didn’t catch one, manually override the asset currency.
- **A new historical quote backfilled.** When a missing day’s price arrives, the gain recalculates.

### Manual FX rates

To pin a rate (e.g. you know your broker used 1.378, not the public mid-market): **Settings → General → Exchange rates → Add rate**. Your rate replaces the fetched rate for that date and forward, until you remove it.

Enter the rate in the major currency. A rate in a minor unit such as GBp, GBX, ZAc, ILA, KWF, or USX is refused: for a London listing priced in pence, add the GBP rate.


<a href="/docs/concepts/performance-metrics/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Performance Metrics</a> <a href="/docs/guide/dashboards/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Dashboards</a>


On this page

- <span class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground"></span>
  - <a href="#how-symbols-work" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">How symbols work</a>
  - <a href="#built-in-providers" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Built-in providers</a>
  - <a href="#yahoo-finance-suffix-table" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Yahoo Finance suffix table</a>
- <a href="#symbol-lookup" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Symbol lookup</a>
- <a href="#fx-rates" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">FX rates</a>
  - <a href="#levels-of-currency" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Levels of Currency</a>
  - <a href="#automatic-currency-unit-normalization" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Automatic Currency Unit Normalization</a>
- <a href="#fx-and-gainloss" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">FX and gain/loss</a>
  - <a href="#worked-example" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Worked example</a>
  - <a href="#my-gain-changed-but-i-didnt-do-anything" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">"My gain changed but I didn't do anything"</a>
  - <a href="#manual-fx-rates" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Manual FX rates</a>


