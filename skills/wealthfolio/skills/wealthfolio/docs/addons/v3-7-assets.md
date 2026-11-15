> Source: https://wealthfolio.app/docs/addons/v3-7-assets



Docs


v3.7 Compatibility and Packaged Assets


# v3.7 Compatibility and Packaged Assets

Migrate Wealthfolio 3.6 addons to the 3.7 development protocol and private packaged-asset API.


Last updated August 19, 2026


# Wealthfolio 3.7 addon compatibility

Wealthfolio 3.7 keeps the documented 3.6 sandbox API compatible and adds private packaged assets. Existing 3.6 addons that contain only their JavaScript and CSS bundle continue to install, load, disable, and uninstall.


| Addon or tool | Wealthfolio 3.7 | Earlier Wealthfolio versions |
|----|----|----|
| Existing 3.6 addon | Supported | Supported according to its existing minimum version |
| 3.7 addon using `ctx.assets` | Supported | Not supported; require Wealthfolio 3.7 |
| `@wealthfolio/addon-dev-tools` 3.6 | Not supported for 3.7 live loading | Supported by matching 3.6 hosts |
| `@wealthfolio/addon-dev-tools` 3.7 | Supported | Do not assume compatibility with older hosts |


`sdkVersion` records the SDK used to build the addon. Runtime compatibility is enforced by `minWealthfolioVersion`. Existing 3.6 releases do not need a version bump merely to run on Wealthfolio 3.7, but an addon that adopts `ctx.assets` must set both fields to `3.7.0` or newer.

## Runtime compatibility

Wealthfolio 3.7 pins the host, sandbox, and addon template to the same browser floor:


| Runtime                                 | Minimum supported version |
|-----------------------------------------|---------------------------|
| Chrome, Edge, WebView2, Android WebView | 107                       |
| Firefox                                 | 104                       |
| Safari and WKWebView                    | 16                        |
| Wealthfolio for macOS                   | macOS 12                  |
| Wealthfolio for iPhone and iPad         | iOS/iPadOS 16             |


Linux and Android use the WebKitGTK and Android System WebView installed on the device, so keep those components updated. Pin the same target in addon projects instead of inheriting Vite’s changing default:

``` mb-4
build: {
  target: ['chrome107', 'edge107', 'firefox104', 'safari16'],
}
```

## Upgrade a development project

``` mb-4
{
  "dependencies": {
    "@wealthfolio/addon-sdk": "^3.7.0",
    "@wealthfolio/ui": "^3.7.0"
  },
  "devDependencies": {
    "@wealthfolio/addon-dev-tools": "^3.7.0"
  }
}
```

``` mb-4
{
  "sdkVersion": "3.7.0",
  "minWealthfolioVersion": "3.7.0"
}
```

Wealthfolio 3.7 loads development addons from `/runtime-package`. The response identifies one immutable generation containing the manifest, runtime files, and asset metadata. Asset bytes are requested later from the same generation. A 404 or 405 for `/runtime-package` means the development server is too old; upgrade the dev tools and restart it.

## Package private assets

There is no `assets` manifest field and no new permission. Wealthfolio indexes these roots automatically:

- `assets/**`
- `dist/assets/**`

JavaScript and CSS in either root remain executable runtime files. Source maps, `.gitkeep`, and `.DS_Store` are not exposed as assets. Asset roots must be directories, and symlinks are rejected.

``` mb-4
export default async function enable(ctx: AddonContext) {
  const [logoUrl, configBlob, wasmBlob] = await Promise.all([
    ctx.assets.getUrl('assets/logo.png'),
    ctx.assets.getBlob('assets/config.json'),
    ctx.assets.getBlob('dist/assets/module.wasm'),
  ]);

  const config = JSON.parse(await configBlob.text());
  await WebAssembly.instantiate(await wasmBlob.arrayBuffer());

  ctx.api.logger.debug(`Loaded ${config.name} from ${logoUrl}`);
}
```

`ctx.assets` is the addon’s private package registry. `ctx.api.assets` is a different API for Wealthfolio financial instruments. The private registry never exposes host filesystem paths or opaque internal identifiers.

## CSS and JavaScript behavior

Local CSS `url(...)` references are rewritten to sandbox-local Blob URLs relative to the stylesheet. For example, `dist/addon.css` can use `url('./assets/background.png')` for `dist/assets/background.png`. Root-relative paths resolve from the package root. `data:` and `blob:` URLs are preserved.

Remote CSS URLs and `@import` are rejected when the addon loads. Bundle imported CSS and package remote images, fonts, media, or Wasm instead. JavaScript and JSX strings such as `<img src="assets/logo.png">` are not rewritten; call `await ctx.assets.getUrl(...)`.

## Limits and lifecycle

- Maximum 256 entries across runtime files and assets.
- Maximum 5 MiB per file and 25 MiB for the package.
- Asset bytes load lazily and are verified against their indexed generation.
- Concurrent requests for the same asset share one load; failed loads can be retried.
- `getUrl()` values are cached for the sandbox lifetime and automatically revoked on reload or disable. Do not persist them.
- Missing, invalid, or changed assets reject their promise. Provide a fallback for optional assets.

## Sandbox and network boundaries

The addon iframe has an opaque origin. Direct browser storage, filesystem paths, top-level navigation, and direct network access are not addon APIs. Use `ctx.api.storage` for durable state and `ctx.api.network.request()` for manifest-approved HTTPS hosts.

Brokered network responses are text. Binary resources should be packaged as private assets rather than downloaded at runtime.

Web Workers and service workers, popups/new windows, and remote CSS imports are also blocked. A packaged JavaScript asset cannot be used as a Worker entry point. These restrictions are intentional and consistent across supported browser engines.

## Release checklist

1.  Inspect the ZIP and verify each asset is under `assets/` or `dist/assets/`.
2.  Set `minWealthfolioVersion` to `3.7.0` when using `ctx.assets`.
3.  Develop with `@wealthfolio/addon-dev-tools` 3.7 or newer.
4.  Test CSS backgrounds, images, fonts, media, and Wasm in the Wealthfolio sandbox.
5.  Confirm disable/reload releases listeners, UI references, and Blob URLs.
6.  For a Wealthfolio release, smoke-test one addon on Windows WebView2, macOS WKWebView, iOS WKWebView with the keyboard open, Linux WebKitGTK, and Android WebView when addons are available there.


<a href="/docs/addons/getting-started/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Getting Started</a> <a href="/docs/addons/localization/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Localization</a>


On this page

- <a href="#wealthfolio-37-addon-compatibility" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Wealthfolio 3.7 addon compatibility</a>
  - <a href="#runtime-compatibility" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Runtime compatibility</a>
  - <a href="#upgrade-a-development-project" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Upgrade a development project</a>
  - <a href="#package-private-assets" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Package private assets</a>
  - <a href="#css-and-javascript-behavior" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">CSS and JavaScript behavior</a>
  - <a href="#limits-and-lifecycle" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Limits and lifecycle</a>
  - <a href="#sandbox-and-network-boundaries" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Sandbox and network boundaries</a>
  - <a href="#release-checklist" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Release checklist</a>


