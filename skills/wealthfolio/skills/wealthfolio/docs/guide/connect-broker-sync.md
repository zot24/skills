> Source: https://wealthfolio.app/docs/guide/connect-broker-sync



Docs


Connect & Broker Sync


# Connect & Broker Sync

Automatically pull activities from your brokerage and sync your data across devices, privately and end-to-end encrypted.


Last updated November 12, 2026

<a href="/connect/" class="font-medium underline underline-offset-4">Wealthfolio Connect</a> is an optional paid service that adds two things on top of the free local-first app:

1.  **Automatic broker sync.** Activities pulled directly from your brokerage, no CSV exports required.
2.  **End-to-end encrypted device sync.** Keep desktop, iOS, Android, and self-hosted instances in step without anyone (us included) being able to read your portfolio.

The core app stays exactly the same with or without Connect. This guide covers what Connect does, what it doesn’t, and how to set it up.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/app/connect.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Wealthfolio Connect – sync brokers and devices while your data stays on your device" /> <img src="https://assets.wealthfolio.app/images/screenshots/app/connect-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Wealthfolio Connect – sync brokers and devices while your data stays on your device" />
<figcaption>Wealthfolio Connect – sync brokers and devices while your data stays on your device</figcaption>
</figure>

------------------------------------------------------------------------

## Checking imported amounts

The saved amount is the cash actually paid or received, with fees and taxes already applied. If an imported total conflicts with the trade details, Wealthfolio keeps it and marks it **Needs review**. Incomplete final amounts can leave an imported row as Draft. Check the row against your broker statement. The review flag is separate from the activity status: a flagged Posted row still affects balances. See <a href="/docs/concepts/activity-fields/" class="font-medium underline underline-offset-4">Activity Fields</a> for the rules.

When upgrading to 3.8, update all devices using device sync before adding or editing activities, so they use the same amount rules.

## 1 · What Connect does (and doesn’t)


| Feature                                                  | Free core | Connect |
|----------------------------------------------------------|-----------|---------|
| Local SQLite database, full data ownership               | ✅        | ✅      |
| Manual entry + CSV import                                | ✅        | ✅      |
| Market data (Yahoo + custom providers)                   | ✅        | ✅      |
| Performance metrics, goals, FIRE, contribution limits    | ✅        | ✅      |
| Self-hosting                                             | ✅        | ✅      |
| AI assistant (BYO API key)                               | ✅        | ✅      |
| **Automatic broker sync** (SnapTrade integration)        | –         | ✅      |
| **Multi-device sync** (E2E encrypted)                    | –         | ✅      |
| **Household / family sharing** (share selected accounts) | –         | ✅      |


Connect is opt-in. If you only want manual + CSV imports, you never need it.

------------------------------------------------------------------------

## 2 · Supported brokerages

Connect uses <a href="https://snaptrade.com" class="font-medium underline underline-offset-4">SnapTrade</a> to talk to your broker. SnapTrade supports the major US, Canadian, and select international brokers. Full list at <a href="/connect/brokerages/" class="font-medium underline underline-offset-4">/connect/brokerages</a>.

Highlights:

- **US:** Fidelity, Schwab, Robinhood, E\*Trade, Webull, Public, TradeStation, tastytrade
- **Canada:** Questrade, Interactive Brokers
- **International:** Interactive Brokers (global), Trading 212, Kraken (crypto), Coinbase (crypto), Binance (crypto)

If your broker isn’t listed, request it via <a href="https://snaptrade.com/brokerage-integrations" class="font-medium underline underline-offset-4">SnapTrade’s coverage form</a>. Support tends to expand quickly.

------------------------------------------------------------------------

## 3 · Set up broker sync

1.  **Subscribe** to Connect at <a href="/connect/" class="font-medium underline underline-offset-4">wealthfolio.app/connect</a>.
2.  **Sign in** to Connect from the desktop, iOS, or Android app via Settings → **Connect**.
3.  **Link a brokerage**: Settings → **Connected Accounts** → **Add brokerage**. You’ll be redirected to SnapTrade’s hosted connection portal. Depending on the institution, you may authorize OAuth on the brokerage website, provide broker-issued API credentials or a reporting token, or authenticate inside the hosted portal. Wealthfolio requests a read-only connection in every case.
4.  **First sync** runs immediately and pulls the history the connection makes available. The range varies by brokerage and account. Subsequent syncs run automatically once per day, or on demand via **Sync now**.

Wealthfolio never receives your broker password. When OAuth is available, you sign in on the brokerage website. For a non-OAuth connection, credentials or API tokens are entered directly into SnapTrade’s hosted portal and stored there encrypted so SnapTrade can maintain the connection. SnapTrade returns the authorized account data through Wealthfolio Connect to your device over encrypted channels.

------------------------------------------------------------------------

## 4 · How synced data lands in Wealthfolio

Each linked brokerage creates one or more **Connect accounts** in Wealthfolio. They look like manual accounts, except:

- Activities flow in automatically. You can correct imported activities; user edits are tracked and protected during broker sync. Check flagged rows against your statement rather than adding another activity for the same event.
- Each Connect account shows its **last sync time** and a **status badge** (synced, syncing, error).
- You can mix synced and manual activities in adjacent accounts; performance metrics combine them seamlessly.

------------------------------------------------------------------------

## 5 · Multi-device sync

Once Connect is active, devices linked to the same Connect account stay in sync:

1.  Sign into Connect on each device (desktop, iOS, Android, self-hosted).
2.  Wealthfolio generates a device-specific keypair on first sign-in.
3.  Changes are encrypted on-device with your account key and pushed to Connect’s storage tier.
4.  Other devices pull the encrypted blobs and decrypt locally.

We can’t read the encrypted blobs. If you lose every device, you can recover by linking a new device with your account credentials. But if you also lose your account credentials, the data is unrecoverable. (That’s the deal with E2E encryption.)


**Back up your data.** E2E means we cannot recover your portfolio for you. Periodically export a full database SQL (<a href="/docs/guide/data-export/" class="font-medium underline underline-offset-4">Export &amp; Backup</a>) and store it somewhere you trust.


------------------------------------------------------------------------

## 6 · Renaming and grouping Connect accounts

By default, Connect accounts inherit names from your broker (“Joint Brokerage 1234…” gets ugly fast). To clean up:

- **Rename:** Settings → **Accounts** → click the synced account → **Edit** → set a display name. The display name is local; the underlying SnapTrade link is unchanged.
- **Group:** Use **Account Groups** to roll up multiple Connect accounts (e.g. “Joint”, “Solo IRA”, “Spouse RRSP”) into one logical bucket for dashboard rollups.

------------------------------------------------------------------------

## 7 · Known limitations

- **Joint accounts:** SnapTrade returns the same joint account once per linked login. If both spouses link the same brokerage, the joint account appears twice. Disable one of the duplicates from Settings → Accounts (toggle Active off) rather than deleting it. Deletion breaks the Connect link.
- **Single-active connection brokers:** E\*Trade and a few others only allow one active SnapTrade session per user. Re-authenticating on a second device disconnects the first.
- **Incomplete activities:** brokers occasionally publish reinvestments with no share count or trades with no price. Rows that cannot be completed can be imported as **Draft** with **Needs review**. Check their status and complete the missing details before confirming them as Posted.
- **Transfers between your own accounts:** the two sides of a transfer can sync separately, as unlinked activities. Link them on <a href="/docs/guide/activities/#match-transfers" class="font-medium underline underline-offset-4">Match transfers</a>.

------------------------------------------------------------------------

## 8 · Disconnecting

To remove a brokerage link: Settings → **Connected Accounts** → select the brokerage → **Disconnect**. The Connect account stays in Wealthfolio (with all its synced history) but won’t sync again. To delete the account entirely, also remove it from Settings → **Accounts**.

------------------------------------------------------------------------

## 9 · Troubleshooting

### Sync failed with “authentication error”

Your broker’s OAuth token expired (most brokers expire after 90 days). Settings → **Connected Accounts** → click the failing brokerage → **Reauthorize**.

### A synced activity looks wrong

Open the activity and correct the relevant details, including its final amount and currency. User changes are tracked so broker sync can protect them. If a sync is consistently wrong, such as importing totals in the wrong currency, file a ticket via <a href="https://discord.gg/WDMCY6aPWK" class="font-medium underline underline-offset-4">Discord</a>. We forward to SnapTrade when needed.

### Sync is stuck on “syncing…” for hours

Cancel and retry: Settings → **Connected Accounts** → **Sync now**. If it fails again, disconnect and reconnect the brokerage.

------------------------------------------------------------------------

**Next step:** Once your brokers are syncing, the <a href="/docs/guide/health-center/" class="font-medium underline underline-offset-4">Health Center</a> will flag any inconsistencies between synced data and what Wealthfolio expects (negative cash, missing deposits, stale quotes).


<a href="/docs/guide/data-export/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Export &amp; Backup</a> <a href="/docs/guide/ai-assistant/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">AI Assistant</a>


On this page

- <a href="#checking-imported-amounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Checking imported amounts</a>
- <a href="#1--what-connect-does-and-doesnt" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1 · What Connect does (and doesn't)</a>
- <a href="#2--supported-brokerages" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2 · Supported brokerages</a>
- <a href="#3--set-up-broker-sync" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3 · Set up broker sync</a>
- <a href="#4--how-synced-data-lands-in-wealthfolio" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">4 · How synced data lands in Wealthfolio</a>
- <a href="#5--multi-device-sync" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">5 · Multi-device sync</a>
- <a href="#6--renaming-and-grouping-connect-accounts" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">6 · Renaming and grouping Connect accounts</a>
- <a href="#7--known-limitations" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">7 · Known limitations</a>
- <a href="#8--disconnecting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">8 · Disconnecting</a>
- <a href="#9--troubleshooting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">9 · Troubleshooting</a>
  - <a href="#sync-failed-with-authentication-error" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Sync failed with "authentication error"</a>
  - <a href="#a-synced-activity-looks-wrong" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">A synced activity looks wrong</a>
  - <a href="#sync-is-stuck-on-syncing-for-hours" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Sync is stuck on "syncing…" for hours</a>


