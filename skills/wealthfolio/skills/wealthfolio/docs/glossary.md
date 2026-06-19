> Source: https://wealthfolio.app/docs/glossary

A short reference for the terms used across Wealthfolio's app and docs. Use it when a
metric or concept is unfamiliar — every entry links out to the deeper concept doc
where applicable.

---

## Performance & returns

### TWR — Time-Weighted Return

The return of your underlying investments with the impact of contributions and
withdrawals stripped out. Comparable to a benchmark (e.g. SPY). Wealthfolio shows
TWR at the **total portfolio** level by default. See
[Performance Metrics](/docs/concepts/performance-metrics).

### MWR — Money-Weighted Return

The return of *you as an investor* — includes the impact of when you bought and
sold (timing decisions). Equivalent to the IRR of your cash flows. Wealthfolio
shows MWR at the **per-account** level by default.

### Modified Dietz

A simplified MWR approximation that's faster to compute and stable across daily
recompute. Wealthfolio uses Modified Dietz under the hood for per-account return.

### Realised gain / loss

The profit or loss locked in when you sell. Computed as proceeds minus the cost
basis of the lots closed by the sale.

### Unrealised gain / loss

The on-paper profit or loss on positions you still hold — current market value
minus cost basis. Becomes realised when you sell.

### Drawdown

The peak-to-trough decline of your portfolio over a period, expressed as a
percentage of the peak. Useful for sizing how rough a downturn was.

### Maximum drawdown (Max DD)

The largest drawdown observed over the whole period being analysed.

### Volatility

The standard deviation of returns over a period. Higher numbers = bumpier ride.
Wealthfolio computes daily volatility and annualises it for reporting.

### Annualised return

A return rate normalised to a one-year period, so 3-month, 5-year, and YTD
returns can be compared apples-to-apples.

### Benchmark

A reference portfolio (often a broad index like SPY or VTI) you compare your own
return to. Lets you ask "did I beat the market?"

---

## Cost basis & lots

### Cost basis

What you paid for a position, used to compute realised gain/loss when you sell. In
Wealthfolio, cost basis is tracked at the **lot** level.

### Lot

A single unit of cost basis — usually one BUY (or one DRIP, one staking reward).
Selling closes lots in FIFO order. See
[Cost Basis & Lots](/docs/concepts/cost-basis-and-lots).

### FIFO — First In, First Out

The lot-selection method Wealthfolio uses: when you sell, the oldest lot is closed
first. The default in most jurisdictions; matches what your broker typically
reports for tax purposes.

### LIFO — Last In, First Out

An alternative cost-basis method (sell the newest lots first). Used in some US tax
strategies. Not yet supported in Wealthfolio; planned for a future version.

### ACB — Adjusted Cost Base

Canadian tax accounting's term for the weighted-average cost per share. Not natively
computed today (FIFO is used); planned for a future version.

### Weighted-Average Cost (WAC)

The cost basis method where every share carries the same per-unit cost, recomputed
as a running total cost ÷ total quantity after each buy — also called moving-average
cost (_gleitender Durchschnittspreis_ in Austria/Germany). Common in mutual fund and
Canadian tax accounting, and mandatory in some jurisdictions. Not yet computed in
Wealthfolio, which uses FIFO (planned for a future version); the "average cost" shown on
a holding is a display figure over your open FIFO lots, not a moving average.

### Specific identification

A cost-basis method where you pick which lots to close on each sale (typically
for tax-loss harvesting). Not yet supported.

### Fractional share

A position quantity that isn't a whole number. Wealthfolio tracks lots to eight
decimal places, so DRIP fractions, crypto satoshis, and broker fractional-share
programs all work.

---

## Activities & subtypes

### Activity

Wealthfolio's atomic event: every BUY, SELL, dividend, transfer, fee, etc.
Activities are the source of truth — all portfolio state is derived from them.
See [Activity Types](/docs/concepts/activity-types).

### Subtype

A semantic variation on an activity type (e.g. DRIP on DIVIDEND, Staking Reward
on INTEREST, Option Expiry on ADJUSTMENT). Wealthfolio expands subtypes into
canonical postings under the hood.

### DRIP — Dividend Reinvestment Plan

A dividend automatically reinvested into more shares of the same security. In
Wealthfolio: DIVIDEND activity with the DRIP subtype.

### Dividend in Kind

A dividend paid as additional shares (often from a spin-off). DIVIDEND activity
with the Dividend in Kind subtype.

### Staking reward

Crypto income received as additional tokens for staking. INTEREST activity with
the Staking Reward subtype.

### External flow

A `TRANSFER_IN` or `TRANSFER_OUT` with the External flag checked — represents an
asset or cash moving in from / out to a world Wealthfolio doesn't track (opening
balances, gifts, write-offs, crypto sent to a wallet).

### Internal flow

A `TRANSFER_IN` or `TRANSFER_OUT` paired with a matching activity on another
Wealthfolio account. Cost basis travels between accounts; no new capital enters
your portfolio.

### Net contribution

The sum of capital actually deposited into your portfolio (deposits + external
transfers in − withdrawals − external transfers out). Used to distinguish "did
you make money?" from "did you put money in?"

---

## Symbols & market data

### Ticker

A short identifier for a security (e.g. `AAPL`, `RY`, `BTC`). Wealthfolio stores
a canonical ticker per asset.

### MIC — Market Identifier Code

An ISO 10383 four-letter exchange code (e.g. `XNAS` for NASDAQ, `XTSE` for
Toronto, `XLON` for London). Wealthfolio uses MIC + ticker as the
provider-agnostic identifier for an asset.

### ISIN — International Securities Identification Number

A 12-character globally-unique identifier (e.g. `US0378331005` for Apple).
Required by some providers (OpenFIGI) and a fallback when ticker disambiguation
is hard.

### CUSIP

A 9-character US/Canada securities identifier, often used for bonds.

### FIGI — Financial Instrument Global Identifier

A 12-character Bloomberg-standard global identifier. Used by the OpenFIGI
provider for bond and identifier lookup.

### Provider

A source of market data — Yahoo Finance, Alpha Vantage, Finnhub, OpenFIGI, Börse
Frankfurt, Metal Price API, US Treasury Calc, and user-defined custom providers.
See [Market Data & FX](/docs/concepts/market-data-and-fx).

### Preferred provider

The provider Wealthfolio prefers when fetching quotes for a given asset. Set per
asset under the Market Data tab.

### Per-provider override

A symbol override stored on an asset for a specific provider — used when a
provider expects a different symbol format than the canonical one (e.g. `SHOP-CA`
instead of `SHOP`).

### Circuit breaker

A reliability pattern in the market-data layer: after a provider fails N times in
a row, it's marked unhealthy and skipped until a backoff period expires. Stops
runaway retries when an external API is down.

---

## Currency & FX

### Base currency

The currency every aggregated total in Wealthfolio is reported in. Set in
Settings → Preferences.

### Account currency

The currency a specific account is denominated in (e.g. a USD brokerage, a EUR
bank account). Set at account creation and cannot be changed.

### Asset / holding currency

The currency a specific security trades in (e.g. a Tokyo-listed stock has JPY
asset currency).

### Activity currency

The currency a specific transaction was settled in (e.g. you may buy a USD stock
through your CAD account; the activity currency is USD).

### FX rate

The exchange rate between two currencies on a given date. Wealthfolio uses the
trade-date rate to convert each activity into base currency, then today's rate
for live displays.

### Minor currency unit

A sub-unit of a major currency (GBp / GBX = British pence; ZAc = South African
cents; ILA = Israeli agorot). Wealthfolio normalises these to the major currency
automatically at the appropriate factor.

---

## Dividends & income

### Dividend yield

A security's annual dividend per share divided by its current price, expressed as
a percentage. Quick proxy for income return.

### Yield on cost

The annual dividend per share divided by your *cost basis* per share, not the
current price. A long-time holder of a growing company will see yield on cost
climb even if the market yield stays flat.

### Withholding tax

Tax deducted at source on dividends or interest, typically by the broker for the
issuing jurisdiction. Recorded in Wealthfolio as a TAX activity.

### Ex-dividend date

The cutoff date for owning a security to receive an upcoming dividend. Buy on or
after the ex-date and you miss the next payment.

---

## Account types & contribution limits

### TFSA — Tax-Free Savings Account

A Canadian registered account where contributions are after-tax but growth and
withdrawals are tax-free. Has an annual contribution limit.

### RRSP — Registered Retirement Savings Plan

A Canadian registered account where contributions are tax-deductible and growth
is tax-deferred until withdrawal. Annual contribution limit based on earned
income.

### FHSA — First Home Savings Account

A Canadian registered account combining TFSA-like growth with RRSP-like
deductibility, earmarked for a first home purchase.

### 401(k) / Roth 401(k)

US employer-sponsored retirement accounts. Traditional 401(k) is pre-tax; Roth is
after-tax with tax-free withdrawals.

### IRA / Roth IRA

US individual retirement accounts. Traditional IRA is pre-tax; Roth is after-tax.

### Contribution limit

The annual maximum you can deposit into a registered/retirement account. See
[Contribution Limits](/docs/guide/contribution-limits).

### Carry-forward room

Unused contribution room from prior years that you can use in the current year
(e.g. TFSA, RRSP).

---

## Portfolio planning

### FIRE — Financial Independence, Retire Early

A movement / planning style focused on saving aggressively to reach financial
independence well before traditional retirement age.

### Safe withdrawal rate

The percentage of your portfolio you can withdraw annually with high confidence
of not running out of money. The classic figure is 4% but Wealthfolio's retirement
simulator lets you stress-test your own number.

### Glide path

How your asset allocation shifts as you age — typically more equity early, more
bonds later.

### Monte Carlo simulation

A planning technique that runs your portfolio through thousands of randomised
return sequences to estimate the *probability* of meeting a goal, not just a
single point estimate.

---

## App concepts

### Account group

A logical grouping of multiple accounts (e.g. "Joint", "Spouse RRSP") used to
roll up performance and net worth on the dashboard.

### Holdings mode

An account tracking style where positions are seeded with External `TRANSFER_IN`
activities rather than recorded BUY-by-BUY. Faster to set up, less precise
performance math. See [Tracking Modes](/docs/concepts/tracking-modes).

### Transactions mode

The full account tracking style — every BUY, SELL, DIVIDEND, INTEREST recorded.
Precise performance math.

### Snapshot

A pre-computed portfolio state at a specific date. Wealthfolio caches snapshots
at strategic dates so the dashboard doesn't replay the whole activity history on
every load. Snapshots after a backdated edit are invalidated and rebuilt
incrementally.

### Custom provider

A user-defined market-data provider that fetches prices from any JSON API, HTML
page, table, or CSV source. No coding required. See
[Custom Providers](/docs/guide/custom-providers).

### Connect

Wealthfolio's optional paid service. Adds automatic broker sync (via SnapTrade)
and end-to-end encrypted multi-device sync. See [Connect](/connect).

---

**Need a term that isn't here?** Open an issue on
[GitHub](https://github.com/wealthfolio/wealthfolio/issues) — the glossary grows
from real questions.

<script type="application/ld+json" is:inline set:html={JSON.stringify({
  '@context': 'https://schema.org',
  '@type': 'DefinedTermSet',
  name: 'Wealthfolio Glossary',
  description: 'Plain-English definitions of investment-tracking terms used in the Wealthfolio app and docs.',
  inDefinedTermSet: 'https://wealthfolio.app/docs/glossary',
})} />
