> Source: https://wealthfolio.app/docs/concepts/market-data-and-fx

### How symbols work

Wealthfolio stores each asset's identifier as a **canonical ticker** (e.g. `RY`,
`AAPL`, `BTC`) plus an optional **exchange MIC code** (`XTSE`, `XNAS`, `XLON`…). That
pair is provider-agnostic; the same asset can be priced by Yahoo, Alpha Vantage,
Börse Frankfurt, OpenFIGI, or a custom scraper, and Wealthfolio's resolver translates
the canonical pair into whatever format each provider expects.

When you add an asset you can type either:

- The bare ticker (`AAPL`): for US equities the MIC defaults to `XNAS`.
- A Yahoo-style suffix (`RY.TO`): Wealthfolio parses the suffix into a ticker + MIC.
- A MIC-qualified form (`RY @ XTSE`): same outcome.

If a specific provider expects a different symbol for an asset (one of your custom
scrapers fetches `SHOP` as `SHOP-CA`, say), set a **per-provider override** on the
asset's Market Data tab. The canonical symbol stays clean; the override is used only
when querying that one provider.

### Built-in providers

| Provider | Covers | Symbol format |
| --- | --- | --- |
| **Yahoo Finance** | Equities, ETFs, crypto, FX, commodities | Ticker + Yahoo suffix (`RY.TO`, `BTC-USD`, `EURUSD=X`) |
| **Alpha Vantage** | Equities, crypto, FX (BYO key) | Ticker + Alpha Vantage exchange code |
| **Finnhub** | Equities, company profiles (BYO key) | Bare ticker |
| **MarketData.app** | Equities (BYO key) | Bare ticker |
| **OpenFIGI** | Bonds, identifier lookup | ISIN (e.g. `US912797KL68`) |
| **Börse Frankfurt** | German exchange listings | `MIC:ticker` (e.g. `XETR:SAP`) |
| **Metal Price API** | Precious metals spot | Metal code |
| **US Treasury Calc** | US Treasuries | CUSIP |
| **Custom providers** | Anything you can hit with HTTP | User-defined template ([guide](/docs/guide/custom-providers)) |

You pick the **preferred provider** per asset. If the preferred one is unhealthy or
rate-limited, the resolver falls through to other capable providers.

### Yahoo Finance suffix table

Yahoo is the default provider for most users, so its suffix convention is the one
you'll see most often. The mappings:

| Exchange                 | Suffix | Example       |
| ------------------------ | ------ | ------------- |
| NASDAQ / NYSE (US)       | _none_ | `AAPL`        |
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

For comprehensive market coverage and potential data delays, consult
[Yahoo Finance's market coverage docs](https://help.yahoo.com/kb/finance-for-web/sln2310.html).

#### Custom Assets

You can also record custom assets without an automatic ticker lookup. This is useful for tracking assets where market data is not automatically available or for assets you wish to price manually. For such custom assets, you will need to regularly update their price information through the asset's page, typically in a "Quote" or "Pricing" section.

## Symbol lookup

1. Exact ticker (`AAPL`, `BTC-USD`).
2. Ticker + suffix (`RY.TO`).
3. First Yahoo Finance hit.

## FX rates

- Pulled with the other market data from the default market data provider.
- View/edit and add manual rates via `Settings→General→Exchange Rates`.
- Manual rates you define take precedence over automatically fetched market data for the specified currency pairs and will be used by the system until you modify or remove them.

### Levels of Currency

The application handles currencies at four distinct levels to provide accurate and flexible financial tracking:

1.  **Base Currency**: This is the primary currency for your entire portfolio. All aggregated reports and overall wealth summaries are presented in this currency. You set this once, typically when you first set up the application.
2.  **Account Currency**: Each account (e.g., a specific bank account, brokerage account) can have its own designated currency. This is the currency in which the account itself is denominated. For example, you might have a USD-denominated brokerage account and a EUR-denominated bank account.
3.  **Asset/Holding Currency**: This refers to the currency in which a specific asset or holding is traded or valued. For instance, if you own shares of a company listed on the Tokyo Stock Exchange, the asset currency would likely be JPY.
4.  **Activity Currency**: This is the currency used for a specific transaction or activity, such as a buy/sell order, dividend payment, or fee. For example, if you buy US stocks using your CAD bank account, the activity of purchasing might involve a CAD to USD conversion, and the activity currency for the purchase itself would be USD.

The system uses the FX rates to convert between these different currency levels as needed for calculations, reporting, and displaying values consistently.

### Automatic Currency Unit Normalization

Wealthfolio automatically handles minor currency units and normalizes them to their major currency equivalents. This means you don't need to manually configure exchange rates for these conversions.

For example, market data from sources like Yahoo Finance often provides prices for securities traded on the London Stock Exchange (LSE) in pence (GBp or GBX, where GBX is the official currency code for Penny Sterling) rather than pounds (GBP). The application automatically recognizes these minor units and converts them to the major currency (GBP) using the correct conversion factor.

#### Supported Minor Currency Units

The system automatically normalizes the following minor currency units:

- **GBp, GBX** (Pence) → **GBP** (British Pound) at 0.01 conversion factor
- **ZAc, ZAC** (South African Cents) → **ZAR** (South African Rand) at 0.01 conversion factor
- **ILA** (Agorot) → **ILS** (Israeli New Shekel) at 0.01 conversion factor
- **KWF** → **KWD** (Kuwaiti Dinar) at 0.01 conversion factor

When prices are quoted in these minor units, the application automatically converts them to the major currency for accurate valuation and reporting. This resolves common discrepancies without requiring manual intervention, as previously discussed in community threads (see [GitHub Issue #107](https://github.com/wealthfolio/wealthfolio/issues/107) and [GitHub Issue #134](https://github.com/wealthfolio/wealthfolio/issues/134)).

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
- **Currency Code Handling**: Currency codes (e.g., "USD", "cad", "Eur") are processed while preserving their original casing for lookups and storage.

## FX and gain/loss

Multi-currency portfolios surface a subtle question: when your base currency is CAD and
you hold a USD stock, is your gain in **USD** (the security's currency) or **CAD** (your
reporting currency)? Wealthfolio reports both, and they can diverge significantly when
FX rates move.

### Worked example

You're a Canadian investor. Base currency: **CAD**.

```
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

The USD gain is $600 ($240 - $180) × 10. The CAD gain is $930, bigger because the
USD strengthened against the CAD over the holding period. **The same trade looks
different depending on which currency you look through.**

This is how every multi-currency tracker works, but it surprises people because the gain
moves even when the share price hasn't.

### "My gain changed but I didn't do anything"

The most common reasons your base-currency gain moved without any trade activity:

- **FX rate moved.** Even if the underlying stock is flat, your CAD-denominated gain
  changes as USD/CAD moves.
- **Quote source changed currency unit.** Yahoo sometimes flips between GBp (pence) and
  GBP (pounds) for UK stocks. Wealthfolio normalizes the common units (see below). If
  it didn't catch one, manually override the asset currency.
- **A new historical quote backfilled.** When a missing day's price arrives, the gain
  recalculates.

### Manual FX rates

To pin a rate (e.g. you know your broker used 1.378, not the public mid-market):
**Settings → General → Exchange Rates → Add manual rate**. Your rate replaces the
fetched rate for that date and forward, until you remove it.
