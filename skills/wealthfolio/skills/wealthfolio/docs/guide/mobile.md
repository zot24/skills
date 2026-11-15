> Source: https://wealthfolio.app/docs/guide/mobile



Docs


Mobile App (iOS & Android)


# Mobile App (iOS & Android)

Install Wealthfolio on iOS and Android, or use a self-hosted instance as a Progressive Web App on your phone.


Last updated November 12, 2026

Wealthfolio is available as a native app for iOS and Android. Self-hosted users can also access their instance as a Progressive Web App (PWA) on either platform. This guide covers installation, getting around on a phone, local data storage, and optional device sync.

<figure class="my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/app/mobile-store.png" class="block w-full rounded-lg" alt="Wealthfolio on iOS – dashboard, net worth, AI assistant, holdings, and allocation" />
<figcaption>Wealthfolio for iOS</figcaption>
</figure>

------------------------------------------------------------------------

## 1 · iOS app

Wealthfolio for iOS is a full native build of the same engine that powers the desktop app, packaged for iPhone and iPad. It does everything the desktop does, with a layout tuned for touch. Wealthfolio 3.7 requires iOS or iPadOS 16 or newer.

- Portfolio dashboard, holdings, activities, performance, goals.
- Manual entry and CSV import (use a cloud share like iCloud Drive or Dropbox to get the file onto the device).
- Custom market data providers.
- AI Assistant (Ollama is desktop-only; OpenAI / Anthropic work fine on iOS).
- <a href="/connect/" class="font-medium underline underline-offset-4">Connect</a> for broker sync and end-to-end encrypted device sync.

Install from the App Store: <a href="https://apps.apple.com/ca/app/wealthfolioapp/id6732888445" class="font-medium underline underline-offset-4">apps.apple.com/app/wealthfolioapp</a>.

### Where your iOS data lives

Each iOS device runs its own SQLite database in the app’s sandbox storage. If iCloud Backup is enabled on your phone, the database is backed up to iCloud along with the rest of your app data, but it isn’t synced to other devices unless you subscribe to Connect.

### Multi-device with Connect

Sign into Connect on the iOS app under **Settings → Wealthfolio Connect**. Changes flow to your other devices via E2E-encrypted blobs. See the <a href="/docs/guide/connect-broker-sync/" class="font-medium underline underline-offset-4">Connect &amp; Broker Sync guide</a> for the full setup.

------------------------------------------------------------------------

## 2 · Android app

Wealthfolio for Android is available on Google Play. Install the native app to track investments, net worth, and spending on your Android device.

Install from Google Play: <a href="https://play.google.com/store/apps/details?id=com.teymz.wealthfolio" class="font-medium underline underline-offset-4">Get Wealthfolio for Android</a>.

### Where your Android data lives

Each Android device keeps its own SQLite database in the app’s private storage. No Wealthfolio account is required, and your data stays on your device. It isn’t synced to other devices unless you use Connect.

### Multi-device with Connect

Sign into Connect in the Android app under **Settings → Wealthfolio Connect** to sync with your other devices using end-to-end encryption. See the <a href="/docs/guide/connect-broker-sync/" class="font-medium underline underline-offset-4">Connect &amp; Broker Sync guide</a> for the full setup.

------------------------------------------------------------------------

## 3 · Getting around on a phone

The bottom bar shows Dashboard, Insights, and Holdings, then Search and More. Activities is first in More. A pinned add-on takes Holdings’ place. On Android, the bar is a Material navigation bar: full width along the bottom, with a label under each icon, in the theme’s colours.

Each tab of the bar keeps its own stack of screens:

- Going back returns to the screen as you left it, with its scroll position, filters, and unsaved drafts.
- Switching tabs returns to where each tab was left.
- Tapping the tab you’re on scrolls it to the top, or returns it to its first screen.
- Screens slide in and out. In the iOS app, swipe from the left edge to go back.
- On Android, Back steps back through the tab, then goes to the Dashboard, then leaves the app.
- Leaving a CSV import part-way asks before discarding it.

Text size follows your phone’s system setting until you pick one in <a href="/docs/guide/settings/#appearance" class="font-medium underline underline-offset-4">Settings → Appearance</a>.

### Forms and sheets

- Sheets and dialogs stay above the keyboard and inside the screen’s safe areas. The field you tapped scrolls back into view.
- Pickers for accounts, lists, dates, and symbols open as a screen inside the sheet. Tap **Back** to return to the form.
- **Add expense** and **Add income** start with a large amount, then rows for the account, date, category, and event.
- **Add existing holdings** gives each holding its own card.
- Closing a form with something typed asks **Discard changes?** first.
- Health issues, activity details, and asset details open as bottom sheets.

### Dashboard

Actions that add things, such as **Add Asset** or **Add expense**, are in the dashboard’s ⋮ menu. Health issues show as one badge beside the total. Tap it to open the Health Center.

------------------------------------------------------------------------

## 4 · Self-hosted on mobile (PWA)

A self-hosted Wealthfolio instance works as a Progressive Web App. On iOS Safari or Android Chrome:

1.  Navigate to your self-hosted URL (e.g. `https://wealthfolio.mydomain.com`).
2.  Sign in.
3.  **iOS Safari:** tap the Share button → **Add to Home Screen**. **Android Chrome:** tap the menu → **Add to Home screen** or **Install app**.

The icon on your home screen launches the app full-screen with no browser chrome. It behaves like a native app for the things that matter: bookmarks, sessions, offline chrome (the data itself still needs your server reachable).

### What you give up vs. the native mobile apps

- **No iCloud backup** of an embedded database as on iOS. The data lives on your self-hosted server, so back it up there.
- **No Face ID lock** (PWAs don’t get biometric auth APIs the same way native apps do).
- **No background sync.** Pull-to-refresh works while the app is open; nothing happens while it’s backgrounded.

For most self-hosters this is a perfectly fine setup.

------------------------------------------------------------------------

## 5 · Tips & limitations

- **Imports on iOS:** to import a CSV, share it from Files / iCloud Drive / Dropbox into the Wealthfolio app. The mapping flow is identical to desktop.
- **Custom providers on iOS:** custom JSON / HTML providers work the same; bear in mind that scraping endpoints that block mobile user-agents may need an HTTP-level `User-Agent` override (configurable in the provider settings).
- **Connect-required brokers on iOS:** broker sync requires Connect. The link flow opens SnapTrade’s hosted connection portal in an in-app browser window. Authentication depends on the brokerage and may use OAuth, API credentials, a reporting token, or a broker login handled by SnapTrade.
- **The app and the desktop don’t sync by default.** Without Connect, each device runs its own local database.

------------------------------------------------------------------------

**Next step:** if you’re using self-hosting + PWA, the <a href="/docs/guide/self-hosting/#troubleshooting" class="font-medium underline underline-offset-4">Self-Hosting troubleshooting section</a> covers the most-common server-side hiccups. If you’re using the native iOS or Android app + Connect, the <a href="/docs/guide/connect-broker-sync/" class="font-medium underline underline-offset-4">Connect &amp; Broker Sync guide</a> is where to go next.


<a href="/docs/guide/mcp-server/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">MCP Server (Agent Access)</a> <a href="/docs/guide/self-hosting/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Overview</a>


On this page

- <a href="#1--ios-app" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1 · iOS app</a>
  - <a href="#where-your-ios-data-lives" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Where your iOS data lives</a>
  - <a href="#multi-device-with-connect" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Multi-device with Connect</a>
- <a href="#2--android-app" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2 · Android app</a>
  - <a href="#where-your-android-data-lives" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Where your Android data lives</a>
  - <a href="#multi-device-with-connect-1" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Multi-device with Connect</a>
- <a href="#3--getting-around-on-a-phone" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3 · Getting around on a phone</a>
  - <a href="#forms-and-sheets" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Forms and sheets</a>
  - <a href="#dashboard" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Dashboard</a>
- <a href="#4--self-hosted-on-mobile-pwa" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">4 · Self-hosted on mobile (PWA)</a>
  - <a href="#what-you-give-up-vs-the-native-mobile-apps" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">What you give up vs. the native mobile apps</a>
- <a href="#5--tips--limitations" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">5 · Tips &amp; limitations</a>


