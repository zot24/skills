<!-- Source: https://wiki.servarr.com/prowlarr/faq -->

* * *

Prowlarr FAQ

Prowlarr FAQ

* * *

Page Contents

Table of Contents

Forced Authentication

How do I reset Stats

Category Not Available or Missing

Can I add any (generic) Torrent RSS Feed

Can I add any (generic) Torznab or Newznab indexer

Can I use flaresolverr indexers

How can I add an indexer that is down or not functional

Prowlarr will not sync to Sonarr

Prowlarr will not sync X Indexer to App

What \*Arr Indexer Settings are Compared for App Full Sync

How do I update Prowlarr

Can I switch from nightly back to develop

Can I switch between branches

Help, my Mac says Prowlarr cannot be opened because the developer cannot be verified

Help, my Mac says Prowlarr.app is damaged and can’t be opened

How do I request a feature for Prowlarr

I am getting an error: Database disk image is malformed

I use Prowlarr on a Mac and it suddenly stopped working. What happened

Prowlarr won't start on Debian 11 or older systems due to SQLite version

How do I change from the Windows Service to a Tray App

How do I Backup/Restore Prowlarr

WebUI only Loads at localhost on Windows

Finding Cookies

I got a pop-up that said config.xml was corrupt, what now

Invalid Certificate and other HTTPS or SSL issues

Help I have locked myself out

Weird UI Issues

VPNs, Jackett, and the \*ARRs

How do I stop the browser from launching on startup

Can I easily add all indexers at once

Tags

[prowlarr](https://wiki.servarr.com/t/prowlarr) [troubleshooting](https://wiki.servarr.com/t/troubleshooting) [faq](https://wiki.servarr.com/t/faq) [Pages matching tags](https://wiki.servarr.com/t/prowlarr/troubleshooting/faq)

Last edited by

Administrator

12/16/2025

# [¶](https://wiki.servarr.com/prowlarr/faq\#table-of-contents) Table of Contents

- [Table of Contents](https://wiki.servarr.com/prowlarr/faq#table-of-contents)
  - [Forced Authentication](https://wiki.servarr.com/prowlarr/faq#forced-authentication)
    - [Authentication Method](https://wiki.servarr.com/prowlarr/faq#authentication-method)
    - [Authentication Required](https://wiki.servarr.com/prowlarr/faq#authentication-required)
  - [How do I reset Stats?](https://wiki.servarr.com/prowlarr/faq#how-do-i-reset-stats)
  - [Category Not Available or Missing](https://wiki.servarr.com/prowlarr/faq#category-not-available-or-missing)
  - [Can I add any (generic) Torrent RSS Feed?](https://wiki.servarr.com/prowlarr/faq#can-i-add-any-generic-torrent-rss-feed)
  - [Can I add any (generic) Torznab or Newznab indexer?](https://wiki.servarr.com/prowlarr/faq#can-i-add-any-generic-torznab-or-newznab-indexer)
  - [Can I use flaresolverr indexers?](https://wiki.servarr.com/prowlarr/faq#can-i-use-flaresolverr-indexers)
  - [How can I add an indexer that is down or not functional?](https://wiki.servarr.com/prowlarr/faq#how-can-i-add-an-indexer-that-is-down-or-not-functional)
  - [Prowlarr will not sync to Sonarr](https://wiki.servarr.com/prowlarr/faq#prowlarr-will-not-sync-to-sonarr)
  - [Prowlarr will not sync X Indexer to App](https://wiki.servarr.com/prowlarr/faq#prowlarr-will-not-sync-x-indexer-to-app)
  - [What \*Arr Indexer Settings are Compared for App Full Sync](https://wiki.servarr.com/prowlarr/faq#what-arr-indexer-settings-are-compared-for-app-full-sync)
  - [How do I update Prowlarr?](https://wiki.servarr.com/prowlarr/faq#how-do-i-update-prowlarr)
    - [Can I update Prowlarr inside my Docker container?](https://wiki.servarr.com/prowlarr/faq#can-i-update-prowlarr-inside-my-docker-container)
    - [Installing a newer version](https://wiki.servarr.com/prowlarr/faq#installing-a-newer-version)
      - [Native](https://wiki.servarr.com/prowlarr/faq#native)
      - [Docker](https://wiki.servarr.com/prowlarr/faq#docker)
  - [Can I switch from `nightly` back to `develop`?](https://wiki.servarr.com/prowlarr/faq#can-i-switch-from-nightly-back-to-develop)
  - [Can I switch between branches?](https://wiki.servarr.com/prowlarr/faq#can-i-switch-between-branches)
  - [Help, my Mac says Prowlarr cannot be opened because the developer cannot be verified](https://wiki.servarr.com/prowlarr/faq#help-my-mac-says-prowlarr-cannot-be-opened-because-the-developer-cannot-be-verified)
  - [Help, my Mac says Prowlarr.app is damaged and can’t be opened](https://wiki.servarr.com/prowlarr/faq#help-my-mac-says-prowlarrapp-is-damaged-and-cant-be-opened)
  - [How do I request a feature for Prowlarr?](https://wiki.servarr.com/prowlarr/faq#how-do-i-request-a-feature-for-prowlarr)
  - [I am getting an error: Database disk image is malformed](https://wiki.servarr.com/prowlarr/faq#i-am-getting-an-error-database-disk-image-is-malformed)
  - [I use Prowlarr on a Mac and it suddenly stopped working. What happened?](https://wiki.servarr.com/prowlarr/faq#i-use-prowlarr-on-a-mac-and-it-suddenly-stopped-working-what-happened)
  - [How do I change from the Windows Service to a Tray App?](https://wiki.servarr.com/prowlarr/faq#how-do-i-change-from-the-windows-service-to-a-tray-app)
  - [How do I Backup/Restore Prowlarr?](https://wiki.servarr.com/prowlarr/faq#how-do-i-backuprestore-prowlarr)
    - [Backing up Prowlarr](https://wiki.servarr.com/prowlarr/faq#backing-up-prowlarr)
      - [Using built-in backup](https://wiki.servarr.com/prowlarr/faq#using-built-in-backup)
      - [Using file system directly](https://wiki.servarr.com/prowlarr/faq#using-file-system-directly)
    - [Restoring from Backup](https://wiki.servarr.com/prowlarr/faq#restoring-from-backup)
      - [Using zip backup](https://wiki.servarr.com/prowlarr/faq#using-zip-backup)
      - [Using file system backup](https://wiki.servarr.com/prowlarr/faq#using-file-system-backup)
      - [File System Restore on Synology NAS](https://wiki.servarr.com/prowlarr/faq#file-system-restore-on-synology-nas)
  - [WebUI only Loads at localhost on Windows](https://wiki.servarr.com/prowlarr/faq#webui-only-loads-at-localhost-on-windows)
  - [Finding Cookies](https://wiki.servarr.com/prowlarr/faq#finding-cookies)
  - [I got a pop-up that said config.xml was corrupt, what now?](https://wiki.servarr.com/prowlarr/faq#i-got-a-pop-up-that-said-configxml-was-corrupt-what-now)
  - [Invalid Certificate and other HTTPS or SSL issues](https://wiki.servarr.com/prowlarr/faq#invalid-certificate-and-other-https-or-ssl-issues)
  - [Help I have locked myself out](https://wiki.servarr.com/prowlarr/faq#help-i-have-locked-myself-out)
  - [Weird UI Issues](https://wiki.servarr.com/prowlarr/faq#weird-ui-issues)
  - [VPNs, Jackett, and the \*ARRs](https://wiki.servarr.com/prowlarr/faq#vpns-jackett-and-the-arrs)
    - [Use of a VPN](https://wiki.servarr.com/prowlarr/faq#use-of-a-vpn)
  - [How do I stop the browser from launching on startup?](https://wiki.servarr.com/prowlarr/faq#how-do-i-stop-the-browser-from-launching-on-startup)
  - [Can I easily add all indexers at once?](https://wiki.servarr.com/prowlarr/faq#can-i-easily-add-all-indexers-at-once)

## [¶](https://wiki.servarr.com/prowlarr/faq\#forced-authentication) Forced Authentication

If Prowlarr is exposed so that the UI can be accessed from outside your local network then you should have some form of authentication method enabled in order to access the UI. This is also increasingly required by Trackers and Indexers.

As of Prowlarr v1, Authentication is Mandatory.

- `AuthenticationType` and `AuthenticationMethod` are mandatory required attributes in the configuration file.

### [¶](https://wiki.servarr.com/prowlarr/faq\#authentication-method) Authentication Method

- `Basic` (Browser pop-up) - Basic Auth is not supported as of Prowlarr v1
- `Forms` (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Prowlarr. This is recommended.
- `External`\- Configurable via Config File Only

  - Disables app authentication completely. _Use at your own risk especially if exposed to the internet_ Suggested only if you use an **external authentication** such as Authelia, Authetik, NGINX Basic auth, etc. you can prevent needing to double authenticate by shutting down the app, setting `<AuthenticationMethod>External</AuthenticationMethod>` in the [config file](https://wiki.servarr.com/prowlarr/appdata-directory), and restarting the app. **Note that multiple `AuthenticationMethod` entries in the file are not supported and only the topmost value will be used**

### [¶](https://wiki.servarr.com/prowlarr/faq\#authentication-required) Authentication Required

- If you do not expose the app externally and/or do not wish to have auth required for local (e.g. LAN) access then change in Settings => General Security => Authentication Required to `Disabled For Local Addresses`
  - The config file equivalent of this is `<AuthenticationType>DisabledForLocalAddresses</AuthenticationType>`
- `<AuthenticationType>Enabled</AuthenticationType>` is also a valid value

## [¶](https://wiki.servarr.com/prowlarr/faq\#how-do-i-reset-stats) How do I reset Stats

- To reset your stats and clear history do the following:

1. History => Options
2. Set History Cleanup to `1`. This will keep only through yesterday's History and Stats
3. Navigate to System => Tasks
4. Run the `Clean Up History` Task
5. Run the `Housekeeping` Task
6. Return to History => Options
7. Set History Cleanup to your desired retention period for History and Stats

## [¶](https://wiki.servarr.com/prowlarr/faq\#category-not-available-or-missing) Category Not Available or Missing

- Please note that custom/non-standard indexer specific categories are mapped to standard ones, so searching will standard ones will incorporate all custom ones. Review your specific Indexer's category mapping definition for details.

## [¶](https://wiki.servarr.com/prowlarr/faq\#can-i-add-any-generic-torrent-rss-feed) Can I add any (generic) Torrent RSS Feed

Yes. Use "TorrentRSS".

The following attributes are mandatory:

- guid
- title
- infohash
- enclosure or link

The following attributes are optional, but recommended:

- size
- pubDate

## [¶](https://wiki.servarr.com/prowlarr/faq\#can-i-add-any-generic-torznab-or-newznab-indexer) Can I add any (generic) Torznab or Newznab indexer

- Yes.
- Go to `Indexers` =\> `Add Indexer` (+) =\> `Generic Torznab` or `Generic Newznab`

## [¶](https://wiki.servarr.com/prowlarr/faq\#can-i-use-flaresolverr-indexers) Can I use flaresolverr indexers

- Yes.

1. Configure your flaresolverr instance by adding it as a proxy in [Settings => Indexers](https://wiki.servarr.com/prowlarr/settings#indexer-proxies)
2. Add a tag to the created flaresolverr proxy
3. Add the same tag to your [Indexer](https://wiki.servarr.com/prowlarr/indexers)

> The tags must match & Cloudflare must be detected for Flaresolverr to be used. A Flaresolverr proxy is disabled if no tags are used.

> [See TRaSH's Guides on "How to setup Flaresolverr"](https://trash-guides.info/Prowlarr/prowlarr-setup-flaresolverr/) for more details

## [¶](https://wiki.servarr.com/prowlarr/faq\#how-can-i-add-an-indexer-that-is-down-or-not-functional) How can I add an indexer that is down or not functional

- Follow the standard steps to add the indexer noting the following changes.
- Uncheck (Disable) the `Enabled` box
- Press `Save`
- Press `Save` again to trigger a force save
- Edit the Indexer (Wrench Icon)
- Check (Enable) the `Enabled` box
- Press `Save`
- Press `Save` again to trigger a force save

## [¶](https://wiki.servarr.com/prowlarr/faq\#prowlarr-will-not-sync-to-sonarr) Prowlarr will not sync to Sonarr

- Prowlarr only supports Sonarr v3+
- Sonarr v2 (fka nzbdrone) is not supported by Prowlarr nor supported in general and has been end-of-life since March 2021

## [¶](https://wiki.servarr.com/prowlarr/faq\#prowlarr-will-not-sync-x-indexer-to-app) Prowlarr will not sync X Indexer to App

- Prowlarr only syncs if Add and Remove or Full Sync is enabled for the app.
- Only in instances where an App and Indexer have matching tags or no tags at all will an indexer be synced to an app
- Indexers are synced based on the capabilities/categories they claim to support.
  - If an indexer supports only TV categories it will not be synced to Lidarr, Radarr, and Readarr.
- A given indexer will only be synced to Sonarr if "Supported" Categories can be selected as an advanced setting on a per app basis.
- Indexers will not be attempted to be synced if the specific Categories supported by the Indexer are not selected in Settings => Application => {App} => Sync Categories (Advanced Settings) and logs will not show any indication of a sync attempt.
- The most common cause for this is that the \*Arrs only accept indexers whose test queries return results containing at least one of the configured categories. In other words, if you're syncing to an App and your indexer's empty query does not return results with any release within the categories configured for the App then it will be unable to add the indexer to \*Arr.
- The specific error will be an HTTP 400 from \*Arr stating `Query successful, but no results in the configured categories were returned from your indexer. This may be an issue with the indexer or your indexer category settings.`
  - Possibly that indexer simply cannot be used with that \*Arr. This is common for attempting to use public trackers or usenet indexers with Readarr and Lidarr.
  - Adjust the categories synced in the advanced settings for the \*Arr application within Prowlarr
    - Note that certain Trackers - primarily "crappy" public trackers - require one to select and sync the `8000 - Other` category. This is often - but not always - noted within the Tracker's details within Prowlarr.
  - Try again later
  - If the issue persist you may have a corrupted database. Check your logs for instances of `Database disk image is malformed` or `Error creating main database`. See [this heading](https://wiki.servarr.com/prowlarr/faq#i-am-getting-an-error-database-disk-image-is-malformed) for possible solutions.

## [¶](https://wiki.servarr.com/prowlarr/faq\#what-arr-indexer-settings-are-compared-for-app-full-sync) What \*Arr Indexer Settings are Compared for App Full Sync

When Full Sync is enabled, Prowlarr compares the following settings between the \*Arr app and Prowlarr to determine if an indexer needs to be updated:

### [¶](https://wiki.servarr.com/prowlarr/faq\#sonarr) Sonarr

| Setting | Description | Code Reference |
| --- | --- | --- |
| **Indexer Name** | The name of the indexer (with "(Prowlarr)" suffix) | `SonarrIndexer.cs:71` |
| **Enable RSS** | Whether RSS feeds are enabled for the indexer | `SonarrIndexer.cs:68` |
| **Enable Automatic Search** | Whether automatic searches are enabled | `SonarrIndexer.cs:69` |
| **Enable Interactive Search** | Whether interactive (manual) searches are enabled | `SonarrIndexer.cs:70` |
| **Priority** | Indexer priority for search order | `SonarrIndexer.cs:73` |
| **Implementation** | Indexer protocol type (Newznab/Torznab) | `SonarrIndexer.cs:72` |
| **Base URL** | The base URL for the indexer API endpoint | `SonarrIndexer.cs:32` |
| **API Path** | The API path (typically "/api") | `SonarrIndexer.cs:40-42` |
| **API Key** | Prowlarr's API key for authentication | `SonarrIndexer.cs:36-38` |
| **Categories** | Supported categories mapped between Prowlarr and Sonarr | `SonarrIndexer.cs:33` |
| **Anime Categories** | Anime-specific category mappings | `SonarrIndexer.cs:34` |
| **Anime Standard Format Search** | Whether to use standard format for anime searches | `SonarrIndexer.cs:44-46` |
| **Minimum Seeders** | Minimum number of seeders required (torrent indexers only) | `SonarrIndexer.cs:48-50` |
| **Seed Ratio** | Seed ratio for torrent downloads | `SonarrIndexer.cs:60-62` |
| **Seed Time** | Minimum seed time for torrents | `SonarrIndexer.cs:52-54` |
| **Season Pack Seed Time** | Seed time for season packs | `SonarrIndexer.cs:56-58` |
| **Reject Blocklisted Torrent Hashes** | Whether to reject blocklisted torrent hashes while grabbing | `SonarrIndexer.cs:64-66` |

### [¶](https://wiki.servarr.com/prowlarr/faq\#radarr) Radarr

| Setting | Description | Code Reference |
| --- | --- | --- |
| **Indexer Name** | The name of the indexer (with "(Prowlarr)" suffix) | `RadarrIndexer.cs:61` |
| **Enable RSS** | Whether RSS feeds are enabled for the indexer | `RadarrIndexer.cs:58` |
| **Enable Automatic Search** | Whether automatic searches are enabled | `RadarrIndexer.cs:59` |
| **Enable Interactive Search** | Whether interactive (manual) searches are enabled | `RadarrIndexer.cs:60` |
| **Priority** | Indexer priority for search order | `RadarrIndexer.cs:63` |
| **Implementation** | Indexer protocol type (Newznab/Torznab) | `RadarrIndexer.cs:62` |
| **Base URL** | The base URL for the indexer API endpoint | `RadarrIndexer.cs:31` |
| **API Path** | The API path (typically "/api") | `RadarrIndexer.cs:38-40` |
| **API Key** | Prowlarr's API key for authentication | `RadarrIndexer.cs:34-36` |
| **Categories** | Supported categories mapped between Prowlarr and Radarr | `RadarrIndexer.cs:32` |
| **Minimum Seeders** | Minimum number of seeders required (torrent indexers only) | `RadarrIndexer.cs:42-44` |
| **Seed Ratio** | Seed ratio for torrent downloads | `RadarrIndexer.cs:50-52` |
| **Seed Time** | Minimum seed time for torrents | `RadarrIndexer.cs:46-48` |
| **Reject Blocklisted Torrent Hashes** | Whether to reject blocklisted torrent hashes while grabbing | `RadarrIndexer.cs:54-56` |

### [¶](https://wiki.servarr.com/prowlarr/faq\#lidarr) Lidarr

| Setting | Description | Code Reference |
| --- | --- | --- |
| **Indexer Name** | The name of the indexer (with "(Prowlarr)" suffix) | `LidarrIndexer.cs:65` |
| **Enable RSS** | Whether RSS feeds are enabled for the indexer | `LidarrIndexer.cs:62` |
| **Enable Automatic Search** | Whether automatic searches are enabled | `LidarrIndexer.cs:63` |
| **Enable Interactive Search** | Whether interactive (manual) searches are enabled | `LidarrIndexer.cs:64` |
| **Priority** | Indexer priority for search order | `LidarrIndexer.cs:67` |
| **Implementation** | Indexer protocol type (Newznab/Torznab) | `LidarrIndexer.cs:66` |
| **Base URL** | The base URL for the indexer API endpoint | `LidarrIndexer.cs:31` |
| **API Path** | The API path (typically "/api") | `LidarrIndexer.cs:38-40` |
| **API Key** | Prowlarr's API key for authentication | `LidarrIndexer.cs:34-36` |
| **Categories** | Supported categories mapped between Prowlarr and Lidarr | `LidarrIndexer.cs:32` |
| **Minimum Seeders** | Minimum number of seeders required (torrent indexers only) | `LidarrIndexer.cs:42-44` |
| **Seed Ratio** | Seed ratio for torrent downloads | `LidarrIndexer.cs:54-56` |
| **Seed Time** | Minimum seed time for torrents | `LidarrIndexer.cs:46-48` |
| **Discography Seed Time** | Seed time for discography downloads | `LidarrIndexer.cs:50-52` |
| **Reject Blocklisted Torrent Hashes** | Whether to reject blocklisted torrent hashes while grabbing | `LidarrIndexer.cs:58-60` |

With Full Sync enabled, if any of the above settings differ between the \*Arr app and Prowlarr, the indexer will be synced and updated in the \*Arr app.

## [¶](https://wiki.servarr.com/prowlarr/faq\#how-do-i-update-prowlarr) How do I update Prowlarr

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `master`, `develop`, or `nightly`
2. Save

_This will not install the bits from that branch immediately, it will happen during the next update._

- `master` \- ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/master/changes) \- (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. On GitHub, this is the `master` branch.

- `develop` \- ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/develop/changes) \- (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first after nightly. It can be considered semi-stable, but is still `beta`.


> On GitHub, this is a snapshot of the `develop` branch at a specific point in time and is tagged as pre-release.

- `nightly` \- ![Current Nightly/Unstable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/nightly/changes) \- (Alpha/Unstable): This is the bleeding edge. It is released as soon as code is committed and passes all automated tests. This build may have not been used by us or other users yet. There is no guarantee that it will even run in some cases. This branch is only recommended for advanced users. Issues and self investigation are expected in this branch. _**Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.**_ This version is updated immediately.

> **Warning: You may not be able to go back to `develop` after switching to this branch.** On GitHub, this is the `develop` branch.

- Note: If your install is through Docker append `:latest`, `:testing`, `:develop`, or `:nightly` to the end of your container tag depending on who makes your builds.

|  | `master` (stable) ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/master/changes) | `develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/develop/changes) | `nightly` (unstable) ![Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/nightly/changes) |
| --- | --- | --- | --- |
| [hotio](https://hotio.dev/containers/prowlarr) | `latest` | `testing` | `nightly` |
| [LinuxServer.io](https://docs.linuxserver.io/images/docker-prowlarr) | `latest` | `develop` | `nightly` |

### [¶](https://wiki.servarr.com/prowlarr/faq\#can-i-update-prowlarr-inside-my-docker-container) Can I update Prowlarr inside my Docker container

- _Technically, yes._ **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

### [¶](https://wiki.servarr.com/prowlarr/faq\#installing-a-newer-version) Installing a newer version

#### [¶](https://wiki.servarr.com/prowlarr/faq\#native) Native

1. Go to System and then the Updates tab
2. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

#### [¶](https://wiki.servarr.com/prowlarr/faq\#docker) Docker

1. Repull your tag and update your container

## [¶](https://wiki.servarr.com/prowlarr/faq\#can-i-switch-from-nightly-back-to-develop) Can I switch from `nightly` back to `develop`

- See [Can I switch between branches?](https://wiki.servarr.com/prowlarr/faq#can-i-switch-between-branches) below.

## [¶](https://wiki.servarr.com/prowlarr/faq\#can-i-switch-between-branches) Can I switch between branches

- If version is identical you can switch, otherwise check with the development team to see if you can switch from `nightly` to `develop`; or `develop` to `nightly` for your given build.
- Failure to follow these instructions may result in your Prowlarr becoming unusable or throwing errors. You have been warned
  - The most common errors are database errors around missing columns or tables.

## [¶](https://wiki.servarr.com/prowlarr/faq\#help-my-mac-says-prowlarr-cannot-be-opened-because-the-developer-cannot-be-verified) Help, my Mac says Prowlarr cannot be opened because the developer cannot be verified

- This is simple, please see the [Mac help documentation](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac) for more information
- Alternatively, you may need to self-sign Prowlarr `codesign --force --deep -s - /Applications/Prowlarr.app && xattr -rd com.apple.quarantine`

![faq_1_mac.png](https://wiki.servarr.com/assets/general/faq_1_mac.png)

## [¶](https://wiki.servarr.com/prowlarr/faq\#help-my-mac-says-prowlarrapp-is-damaged-and-cant-be-opened) Help, my Mac says Prowlarr.app is damaged and can’t be opened

That is either due to a corrupt download (so try again), or security issues answered just above this.

## [¶](https://wiki.servarr.com/prowlarr/faq\#how-do-i-request-a-feature-for-prowlarr) How do I request a feature for Prowlarr

To request a feature for Prowlarr, first search on GitHub to ensure no similar request exists, then [submit a feature request on GitHub](https://github.com/Prowlarr/Prowlarr/issues/new?assignees=&labels=feature+request&template=feature_request.md&title=) to add your request.

## [¶](https://wiki.servarr.com/prowlarr/faq\#i-am-getting-an-error-database-disk-image-is-malformed) I am getting an error: Database disk image is malformed

- **Errors of `Error creating log database` indicate issues with logs.db**
  - This can quickly be resolved by renaming or removing the database. The logs database contains unimportant information regarding commands history and update install history, and Info, Warn, and Error entries
- **Errors of `Error creating main database` or generic `database disk image is malformed` with no specified database indicate issues with prowlarr.db**
  - Continue with the steps noted below
- This means your SQLite database that stores most of the information for Prowlarr is corrupt. Your options are to try (a) backup(s), try recovering the existing database, try recovering the backup(s), or if all else fails starting over with a fresh new database.
- This error may show if the database file is not writable by the user/group \*Arr is running as. Permissions being the cause will likely only be an issue for new installs, migrated installs to a new server, if you recently modified your appdata directory permissions, or if you changed the user and group \*Arr run as.
- Your best and first option is to [try restoring from a backup](https://wiki.servarr.com/prowlarr/faq#how-do-i-backuprestore-my-prowlarr)
- You can also try recovering your database. This is typically the only option for when this issue occurs after an update. Try the [sqlite3 `.recover` command](https://wiki.servarr.com/useful-tools#recovering-a-corrupt-db)
  - If your sqlite does not have `.recover` or you wish a more GUI (i.e. Windows) friendly way then follow [our instructions on this wiki.](https://wiki.servarr.com/useful-tools#recovering-a-corrupt-db-ui)
- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). **SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. [SQLite and network drives not play nice together and will cause a malformed database eventually](https://www.sqlite.org/draft/useovernet.html).
- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## [¶](https://wiki.servarr.com/prowlarr/faq\#i-use-prowlarr-on-a-mac-and-it-suddenly-stopped-working-what-happened) I use Prowlarr on a Mac and it suddenly stopped working. What happened

- Most likely this is due to a MacOS bug which caused the Prowlarr database to be corrupted. Please check the FAQ entry for restoring a corrupt database.

## [¶](https://wiki.servarr.com/prowlarr/faq\#prowlarr-wont-start-on-debian-11-or-older-systems-due-to-sqlite-version) Prowlarr won't start on Debian 11 or older systems due to SQLite version

> This workaround is only for older end-of-standard-support systems with outdated GLIBC/SQLite versions. This is not applicable to systems with SQLite corruption issues.

Prowlarr v2.1.5.5216+ uses SQLite from SourceGear.sqlite3, which requires newer GLIBC versions and may cause compatibility issues on older end-of-standard-support systems including Debian 10, Debian 11, Synology DSM, Ubuntu 18, and Ubuntu 20. If you encounter SQLite-related errors (not corruption) on these platforms, you can force Prowlarr to use your system's native SQLite library instead, which is compatible with your GLIBC version.

### [¶](https://wiki.servarr.com/prowlarr/faq\#solution) Solution

Create a symlink from your system's SQLite library to the expected library name in Prowlarr's directory:

```bash

```

Copy

After creating the symlink, restart Prowlarr. It will now use the system's SQLite library which is compatible with your GLIBC version.

> **Note:** You will need to recreate this symlink after each Prowlarr update, as updates replace the application directory contents.

### [¶](https://wiki.servarr.com/prowlarr/faq\#when-to-use-this-workaround) When to use this workaround

- You're running an older end-of-life system (Debian 10, Debian 11, Synology DSM, Ubuntu 18, or Ubuntu 20)
- Prowlarr fails to start with SQLite initialization errors
- The error is **not** related to database corruption
- Your system's SQLite version is at least 3.9.0

### [¶](https://wiki.servarr.com/prowlarr/faq\#when-not-to-use-this-workaround) When NOT to use this workaround

- You have a database corruption issue (see the section above instead)
- You're on a modern, supported Linux distribution
- Prowlarr starts normally

## [¶](https://wiki.servarr.com/prowlarr/faq\#how-do-i-change-from-the-windows-service-to-a-tray-app) How do I change from the Windows Service to a Tray App

- Shut Prowlarr down
- Run serviceuninstall.exe that's in the Prowlarr directory
- Run Prowlarr.exe as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
- (Optional) Drop a shortcut to Prowlarr.exe in the startup folder to auto-start on boot.

## [¶](https://wiki.servarr.com/prowlarr/faq\#how-do-i-backuprestore-prowlarr) How do I Backup/Restore Prowlarr

### [¶](https://wiki.servarr.com/prowlarr/faq\#backing-up-prowlarr) Backing up Prowlarr

#### [¶](https://wiki.servarr.com/prowlarr/faq\#using-built-in-backup) Using built-in backup

- Go to System => Backup in the Prowlarr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

#### [¶](https://wiki.servarr.com/prowlarr/faq\#using-file-system-directly) Using file system directly

- Find the location of the AppData directory for Prowlarr
  - Via the Prowlarr UI go to System => About
  - [Prowlarr Appdata Directory](https://wiki.servarr.com/prowlarr/appdata-directory)
- Stop Prowlarr - This will prevent the database from being corrupted
- Copy the contents to a safe location

### [¶](https://wiki.servarr.com/prowlarr/faq\#restoring-from-backup) Restoring from Backup

> Restoring to an OS that uses different paths will not work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database.

#### [¶](https://wiki.servarr.com/prowlarr/faq\#using-zip-backup) Using zip backup

- Re-install Prowlarr (if applicable / not already installed)
- Run Prowlarr
- Navigate to System => Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

#### [¶](https://wiki.servarr.com/prowlarr/faq\#using-file-system-backup) Using file system backup

- Re-install Prowlarr (if applicable / not already installed)
- Find the location of the AppData directory for Prowlarr
  - Running Prowlarr once and via the UI go to System => About
  - [Prowlarr Appdata Directory](https://wiki.servarr.com/prowlarr/appdata-directory)
- Stop Prowlarr
- Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
- Restore from your backup
- Start Prowlarr
- As long as the paths are the same, everything will pick up where it left off

#### [¶](https://wiki.servarr.com/prowlarr/faq\#file-system-restore-on-synology-nas) File System Restore on Synology NAS

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.

- Re-install Prowlarr (if applicable / not already installed)
- Find the location of the AppData directory for Prowlarr
  - Running Prowlarr once and via the UI go to System => About
  - [Prowlarr Appdata Directory](https://wiki.servarr.com/prowlarr/appdata-directory)
- Stop Prowlarr
- Connect to the Synology NAS through SSH and log in as root

> On some installations, the user is different than the below commands: `chown -R sc-Prowlarr:Prowlarr *`

- Execute the following commands:



```shell

```





Copy

- Update permissions on the files:



```shell

```





Copy

- Start Prowlarr


## [¶](https://wiki.servarr.com/prowlarr/faq\#webui-only-loads-at-localhost-on-windows) WebUI only Loads at localhost on Windows

If you can only reach your web interface at `http://localhost:9696/` or `http://127.0.0.1:9696`, you need to run Prowlarr as Administrator at least once, maybe even always.

## [¶](https://wiki.servarr.com/prowlarr/faq\#finding-cookies) Finding Cookies

Some sites cannot be logged into automatically and require you to login manually then give the cookies to Prowlarr to work. [Please see this article for details.](https://wiki.servarr.com/useful-tools#finding-cookies)

## [¶](https://wiki.servarr.com/prowlarr/faq\#i-got-a-pop-up-that-said-configxml-was-corrupt-what-now) I got a pop-up that said config.xml was corrupt, what now

Prowlarr was unable to read your config file on start-up as it became corrupted somehow. In order to get Prowlarr back online, you will need to delete `.xml` in your AppData Folder, once deleted start Prowlarr and it will start on the default port (9696), you should now re-configure any settings you configured on the General Settings page.

## [¶](https://wiki.servarr.com/prowlarr/faq\#invalid-certificate-and-other-https-or-ssl-issues) Invalid Certificate and other HTTPS or SSL issues

Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?

Prowlarr validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then Prowlarr will refuse to connect. Free properly signed certificates are available from let's encrypt.

If your download client and Prowlarr are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## [¶](https://wiki.servarr.com/prowlarr/faq\#help-i-have-locked-myself-out) Help I have locked myself out

1. Stop Prowlarr
2. Open config.xml in a text editor
3. Find the authentication method line - will be

`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`

_**(Be sure you do not have two AuthenticationMethod entries in your file!)**_
4. Remove the entire `AuthenticationMethod` line
5. Start Prowlarr
6. Prowlarr will now be accessible without a password. When you open the Web UI, you should be prompted to set a new password and authentication method

## [¶](https://wiki.servarr.com/prowlarr/faq\#weird-ui-issues) Weird UI Issues

- If you experience any weird UI issues or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the [Clear Cache Cookies and Local Storage](https://wiki.servarr.com/useful-tools#clearing-cookies-and-local-storage) wiki article.

## [¶](https://wiki.servarr.com/prowlarr/faq\#vpns-jackett-and-the-arrs) VPNs, Jackett, and the \*ARRs

> For comprehensive VPN guidance, see the dedicated [VPN Guide](https://wiki.servarr.com/vpn) page.

- Unless you're in a repressive country like China or Australia, your BitTorrent client is typically the only thing that needs to be behind a VPN. Usenet does not require VPN protection as it uses encrypted SSL connections. For most countries including the UK, using secure DNS (like Cloudflare's 1.1.1.1 or Google's 8.8.8.8) is sufficient to resolve access issues without requiring a VPN. Other \*Arr apps not connecting to trackers should not be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.

> **To be clear it is not a matter if VPNs will cause issues with the \*Arrs, but when: image providers will block you and cloudflare is in front of most of \*Arr servers (updates, metadata, etc.) and liable to block you too**

- **Many private trackers will ban you for using or accessing them (i.e. using Jackett or Prowlarr) via a VPN.**

## [¶](https://wiki.servarr.com/prowlarr/faq\#how-do-i-stop-the-browser-from-launching-on-startup) How do I stop the browser from launching on startup

Depending on your OS, there are multiple possible ways.

- In `Settings` =\> `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Prowlarr, you can add `-nobrowser` (\*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Prowlarr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.

## [¶](https://wiki.servarr.com/prowlarr/faq\#can-i-easily-add-all-indexers-at-once) Can I easily add all indexers at once

No. This would not be a good thing to do, and this functionality will not be added. It is much better to choose your indexers wisely, pay attention to the stats to remove indexers that are too slow or not producing grabs. Proper pruning and maintenance of your indexers will result in much better results overall, and quicker results on searches from your apps.