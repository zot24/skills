> Source: https://wiki.servarr.com/lidarr/plugins



## <a href="#what-are-plugins" class="toc-anchor">¶</a> What are plugins

Lidarr plugins allow users to extend the capability of Lidarr to include new indexers and download clients, including peer-to-peer networks and common streaming services.

Lidarr 3.1.2.4938 and later include plugin support on the `develop` and `nightly` branches. The `master` branch doesn't support plugins yet.

> You can't go back to the `master` branch without restoring a database backup from before you switched to the `plugins`, `nightly`, or `develop` branch. Errors will be relating to the protocol such as `Error parsing column 10 (Protocol=TorrentDownloadProtocol - String)` or being unable to enable torrent/usenet in a Delay Profile

### <a href="#how-to-install-plugins" class="toc-anchor">¶</a> How To Install Plugins

To use plugins, switch Lidarr to the `develop` or `nightly` branch and update to 3.1.2.4938 or later. `develop` gets new builds less often than `nightly` and is the more stable of the two.

### <a href="#native-installs-windows-mac-and-linux" class="toc-anchor">¶</a> Native Installs - Windows, Mac, and Linux

- Navigate to `/settings/general`
- Show Advanced if not already enabled
- Scroll down to Updates. Type in `develop` or `nightly`
- Save changes.
- Update Lidarr

### <a href="#docker" class="toc-anchor">¶</a> Docker

Update your Docker Compose file to use one of the following images, pull, and recreate your Lidarr container.

#### <a href="#hotio" class="toc-anchor">¶</a> Hotio

``` prismjs
image: ghcr.io/hotio/lidarr:testing # develop branch
image: ghcr.io/hotio/lidarr:nightly # nightly branch
```

#### <a href="#linuxserverio" class="toc-anchor">¶</a> <a href="http://LinuxServer.io" class="is-external-link">LinuxServer.io</a>

``` prismjs
image: lscr.io/linuxserver/lidarr:develop # develop branch
image: lscr.io/linuxserver/lidarr:nightly # nightly branch
```

### <a href="#manually-installing" class="toc-anchor">¶</a> Manually Installing

- See the <a href="/lidarr/installation/" class="is-internal-link is-valid-page">Installation Docs</a> and change the branch in the URL from `master` to `develop` or `nightly`. Otherwise, follow the docs as written.

### <a href="#post-install" class="toc-anchor">¶</a> Post Install

- Navigate to `/system/plugins`. Enter the URL of the GitHub repository that contains the plugin and select Install. You can watch the progress in the lower left corner. Installation takes a few seconds depending on your setup.
- Restart Lidarr to load the plugin.
- If `/system/plugins` doesn't appear in the menu, check `/system/status` and make sure you're running Lidarr 3.1.2.4938 or later on the `develop` or `nightly` branch.

### <a href="#updating-plugins" class="toc-anchor">¶</a> Updating Plugins

Lidarr doesn't update plugins automatically or check for updates on a schedule. It checks each plugin's GitHub releases only when you open `/system/plugins`.

1.  Navigate to `/system/plugins`. The Available Version column shows the newest release for each plugin.
2.  If a newer version exists, an update button appears next to the plugin. Select it to install the update.
3.  Restart Lidarr to load the new version.

# <a href="#plugins" class="toc-anchor">¶</a> Plugins

> Both plugins and this documentation are community-driven. No official recommendations exist. Each developer supports their own plugin.

## <a href="#jtstotharduniquesingles" class="toc-anchor">¶</a> jtstothard/UniqueSingles

<a href="https://github.com/jtstothard/lidarr-plugin-uniquesingles" class="is-external-link">UniqueSingles by jtstothard</a>

Removes duplicate singles when the same track already exists on a monitored album or EP. Matches by MusicBrainz recording ID, title + duration, or title alone.

### <a href="#prerequisites" class="toc-anchor">¶</a> Prerequisites

- Lidarr 3.1.2.4938 or later on the `develop` or `nightly` branch

### <a href="#post-install-configuration" class="toc-anchor">¶</a> Post-Install Configuration

1.  Go to **Settings → Connect** and select the **+** button
2.  Choose **Unique Singles** from the list
3.  Configure settings and select **Save**

#### <a href="#settings" class="toc-anchor">¶</a> Settings

- **Duration tolerance (ms):** how close track lengths need to be for a match (default 3000ms)
- **Release types to compare:** which release types to check against singles (default: Album, EP)
- **Title-only match action:** what happens when titles match but durations don't. Options: flag for review (default), skip, or autoclean
- **Scan interval (minutes):** how often to sweep the full library (default 1440 = 24 hours)

> The scheduled scan appears under **Settings → Metadata** rather than Tasks. It's cosmetic and works fine.

## <a href="#jtstothardlidarr-plugin-bandcamp" class="toc-anchor">¶</a> jtstothard/lidarr-plugin-bandcamp

<a href="https://github.com/jtstothard/lidarr-plugin-bandcamp" class="is-external-link">Bandcamp by jtstothard</a>

Bandcamp indexer and download client for Lidarr. Searches your Bandcamp collection for albums you have bought and downloads them. Only works with music you own. Lidarr has no public catalog search.

Requires cookie-based auth using the `identity` cookie from your browser.

### <a href="#prerequisites-1" class="toc-anchor">¶</a> Prerequisites

- Lidarr 3.1.2.4938 or later on the `develop` or `nightly` branch
- A Bandcamp account with purchased music
- The `identity` cookie exported from your browser

### <a href="#post-install-configuration-1" class="toc-anchor">¶</a> Post-Install Configuration

#### <a href="#indexer" class="toc-anchor">¶</a> Indexer

- Navigate to `/settings/indexers` and select the **+** button under Indexers. Bandcamp appears at the bottom under the Other section.
- Paste your `identity` cookie value into **Session Cookies**.
- Select **Test**, then **Save**.

#### <a href="#download-client" class="toc-anchor">¶</a> Download Client

- Navigate to `/settings/downloadclients` and select the **+** button under Download Clients. Bandcamp appears at the bottom under the Other section.
- Paste your `identity` cookie value into **Session Cookies**.
- Set **Download Path** to somewhere Lidarr can write (for example, `/downloads/bandcamp`).
- Select **Test**, then **Save**.

#### <a href="#delay-profile" class="toc-anchor">¶</a> Delay Profile

- Navigate to `settings/profiles` and scroll down to Delay Profiles.
- Select the wrench icon on the profile you want to use Bandcamp with.
- Select the Bandcamp protocol, then **Save**.

### <a href="#exporting-the-cookie" class="toc-anchor">¶</a> Exporting the Cookie

**Chrome:** Open DevTools (`F12`) → Application tab → Cookies → `https://bandcamp.com` → copy the `identity` value.

**Firefox:** Open Developer Tools (`F12`) → Storage tab → Cookies → `https://bandcamp.com` → copy the `identity` value.

The cookie expires over time. When downloads fail with auth errors, export a fresh one from your browser.

### <a href="#troubleshooting" class="toc-anchor">¶</a> Troubleshooting

- **Auth errors:** Cookie expired. Re-export it from your browser.
- **No search results:** Check that you bought the album on Bandcamp and that the Bandcamp protocol is enabled in your Delay Profile.
- **Plugin missing:** Make sure Lidarr is 3.1.2.4938 or later on the `develop` or `nightly` branch, then restart.

## <a href="#allquiet-hublidarrpluginslskd" class="toc-anchor">¶</a> allquiet-hub/Lidarr.Plugin.Slskd

<a href="https://github.com/allquiet-hub/Lidarr.Plugin.Slskd" class="is-external-link">Slskd (Soulseek) by Allquiet</a>

### <a href="#prerequisites-2" class="toc-anchor">¶</a> Prerequisites

This plugin enables Lidarr to search Soulseek using Slskd. You must have Lidarr 3.1.2.4938 or later on the `develop` or `nightly` branch and a working Slskd installation to use this plugin.

To generate the Api Key necessary for the communication to the Slskd app follow the steps <a href="https://github.com/slskd/slskd/blob/master/docs/config.md#authentication" class="is-external-link">here on the developer's repository</a>

### <a href="#post-install-configuration-2" class="toc-anchor">¶</a> Post-Install Configuration

#### <a href="#download-client-1" class="toc-anchor">¶</a> Download Client

Once you install the plugin, you can add Slskd as a download client.

- Navigate to `/settings/downloadclients`, and select the + button under Download clients. Slskd will appear at the bottom under the Other section.
- Enter the correct hostname.
- Enter the API key
- Select the Test button.
- If the Test returns a green checkmark, select Save.

### <a href="#indexer-1" class="toc-anchor">¶</a> Indexer

To search, you must also add Slskd as an Indexer.

- Navigate to `/settings/indexers`, and select the + button under Indexers. Slskd will appear at the bottom under the Other section.
- Enter the correct URL.
- Enter the API key.
- Enter a '0' (Key) and your Soulseek username (Value) for 'Ignored Users'.
- Select the Test button.
  - The Indexer test will send a test search to slskd for "Silent Partner Chances."
- If the Test returns a green checkmark, select Save.

### <a href="#delay-profile-1" class="toc-anchor">¶</a> Delay Profile

- Navigate to `settings/profiles` and scroll down to Delay Profiles
- Select the wrench icon on the right side of the profile you wish to use slskd with. Most installations will only have a Default profile.
- Select the Slskd protocol, and select Save.

### <a href="#verification" class="toc-anchor">¶</a> Verification

Slskd is now available for both automatic and interactive searches. During Lidarr search operations you can view the slskd `/searches` as they occur and monitor `/downloads`.

## <a href="#typnulltubifarry" class="toc-anchor">¶</a> TypNull/Tubifarry

<a href="https://github.com/TypNull/Tubifarry" class="is-external-link">Tubifarry by TypNull</a> is a *multi-feature* plugin that extends Lidarr's capabilities with these key functions:

### <a href="#core-features" class="toc-anchor">¶</a> Core Features

- **YouTube Music Downloader**:
  - Downloads music from YouTube (requires cookies/trusted sessions for reliability)
  - Optional FFmpeg audio extraction (recommended for compatibility)
- **Soulseek Integration**:
  - Slskd support as both indexer and download client

### <a href="#toolbox-additions" class="toc-anchor">¶</a> Toolbox Additions

- **Soundtrack Importer**: Fetches soundtracks from Sonarr/Radarr via *Arr-Soundtracks* import list
- **Queue Cleaner**: Automatically manages failed imports (blocklist/rename/retry)
- **Codec Tinker**: Converts audio formats using FFmpeg rules (for example, `wav→flac`, `AAC→MP3`)
- **Lyrics Fetcher**: Adds time-synced lyrics (.lrc files or embedded metadata)
- **Search Sniper**: Automates batch searching of large wanted lists
- **MetaMix**: Aggregates metadata from different sources (experimental)

### <a href="#branches" class="toc-anchor">¶</a> Branches

- Certain features are only available on specific branches.
- To install these:
  1.  First ensure you have the stable version installed.
  2.  Then switch to your desired branch using its URL.
- *Example:* Find the development version at:  
  `https://github.com/TypNull/Tubifarry/tree/develop`

> See the <a href="https://github.com/TypNull/Tubifarry" class="is-external-link">Tubifarry README</a> for advanced configuration, troubleshooting, and feature deep-dives.

## <a href="#trevtv" class="toc-anchor">¶</a> TrevTV

TrevTV develops specialized Lidarr plugins for direct music platform integration.

### <a href="#deezer" class="toc-anchor">¶</a> Deezer

<a href="https://github.com/TrevTV/Lidarr.Plugin.Deezer" class="is-external-link">Deezer by TrevTV</a> is a Lidarr plugin that provides direct Deezer integration:

- **Indexer & Download Client**: Searches and downloads from Deezer without intermediaries like Deemix
- **Flexible Auth**: Automatic ARL selection or manual entry

> TrevTV's Deezer plugin hasn't had a release since 10.1.0.18 in November 2025. For a maintained fork, see [jasonpatrickellykrause/Lidarr.Plugin.Deezer](#jasonpatrickellykrauselidarrplugindeezer).

### <a href="#tidal" class="toc-anchor">¶</a> Tidal

<a href="https://github.com/TrevTV/Lidarr.Plugin.Tidal" class="is-external-link">Tidal by TrevTV</a> is a Lidarr plugin for Tidal integration:

- **OAuth2 Authentication**: Secure token-based login flow
- **FFmpeg Conversion**: Optional audio processing
- *Note: Shows only estimated file sizes*

### <a href="#qobuz" class="toc-anchor">¶</a> Qobuz

<a href="https://github.com/TrevTV/Lidarr.Plugin.Qobuz" class="is-external-link">Qobuz by TrevTV</a> is a Lidarr plugin for Qobuz integration:

- **Dual Authentication**: Email/MD5 password or user token login
- **Hi-Res Handling**: Automatically falls back to 96kHz when needed

### <a href="#configuration-essentials" class="toc-anchor">¶</a> Configuration Essentials

1.  **Delay Profiles**: All plugins require Delay Profile activation
2.  **Lyrics Support**:
    - Enable `.lrc` file support in:
      - Each plugin's download client settings
      - Lidarr's Media Management → "Import Extra Files" (add `lrc`)
3.  **Docker Requirements**:
    - FFmpeg required for Tidal conversions
    - Qobuz authentication may require custom app IDs

## <a href="#jasonpatrickellykrauselidarrplugindeezer" class="toc-anchor">¶</a> jasonpatrickellykrause/Lidarr.Plugin.Deezer

<a href="https://github.com/jasonpatrickellykrause/Lidarr.Plugin.Deezer" class="is-external-link">Deezer by jasonpatrickellykrause</a> is a maintained fork of TrevTV's Deezer plugin. It adds a Deezer indexer and download client that talk to Deezer directly, without Deemix.

The fork focuses on protecting your Deezer account and reducing failed downloads:

- **ARL protection**: Lidarr masks the ARL in its interface and API. A **Saved ARL** field shows only the last four characters.
- **Request pacing**: The plugin paces track downloads and search lookups, stops an album as soon as Deezer rejects the ARL, and doesn't retry a dead session without limit.
- **Fewer failed grabs**: Search results offer FLAC or MP3 320 only when every track on the album is available at that quality.
- **MusicBrainz tagging**: Downloaded files carry the release, artist, and recording IDs that Lidarr matched, which helps imports.

> Deezer restricts download tools. Pacing lowers the risk, but Deezer can still limit or ban your account.

### <a href="#prerequisites-3" class="toc-anchor">¶</a> Prerequisites

- Lidarr 3.1.2.4938 or later on the `develop` or `nightly` branch
- A Deezer account and its ARL cookie. FLAC downloads require a paid Deezer plan that includes lossless audio.

### <a href="#switching-from-trevtvs-deezer-plugin" class="toc-anchor">¶</a> Switching from TrevTV's Deezer Plugin

Lidarr can only load one Deezer plugin. With two installed, Lidarr logs `Sequence contains more than one matching element`, and this plugin reports a health check error on **System** \> **Status**.

1.  Back up Lidarr from **System** \> **Backup** \> **Backup Now**.
2.  In **System** \> **Plugins**, uninstall TrevTV's Deezer plugin, then restart Lidarr.
3.  Install this plugin, then restart Lidarr again.

Lidarr keeps your Deezer indexer and download client settings in its database, so you don't need to add them again.

### <a href="#post-install-configuration-3" class="toc-anchor">¶</a> Post-Install Configuration

#### <a href="#indexer-2" class="toc-anchor">¶</a> Indexer

- Navigate to `/settings/indexers` and select the **+** button under Indexers. Deezer appears at the bottom under the Other section.
- Paste your ARL into **ARL** and select **Save**. Saving takes a moment while the plugin contacts Deezer.
- After saving, Lidarr masks the ARL. Compare the last four characters in **Saved ARL** when you replace it.

#### <a href="#download-client-2" class="toc-anchor">¶</a> Download Client

- Navigate to `/settings/downloadclients` and select the **+** button under Download Clients. Deezer appears at the bottom under the Other section.
- Set the download path to a folder Lidarr can write to, then select **Save**.
- To keep `.lrc` lyrics files, go to **Settings** \> **Media Management**, enable **Import Extra Files**, and add `lrc` to the list.

#### <a href="#delay-profile-2" class="toc-anchor">¶</a> Delay Profile

- Navigate to `settings/profiles` and scroll down to Delay Profiles.
- Select the wrench icon on each profile you want to use Deezer with.
- Enable the Deezer protocol, then select **Save**.

> Enable **Rename Tracks** in **Settings** \> **Media Management** so each album imports into its own folder instead of the artist folder.

See the <a href="https://github.com/jasonpatrickellykrause/Lidarr.Plugin.Deezer" class="is-external-link">plugin README</a> for the changelog and release notes.

## <a href="#ta264deemix" class="toc-anchor">¶</a> ta264/deemix

<a href="https://github.com/ta264/Lidarr.Plugin.Deemix" class="is-external-link">Deemix plugin by ta264</a>

This plugin enables Lidarr to search Deezer using Deemix. You must have Lidarr 3.1.2.4938 or later on the `develop` or `nightly` branch, a working Deemix container, and an ARL from Deezer to use this plugin. To get FLAC files, your ARL must be for a hi-fi account type on Deezer.

<a href="https://github.com/bambanah/deemix" class="is-external-link">Deemix</a>

## <a href="#lucapolesellidarrpluginslskd" class="toc-anchor">¶</a> lucapolesel/Lidarr.Plugin.Slskd

<a href="https://github.com/lucapolesel/Lidarr.Plugin.Slskd" class="is-external-link">Slskd (Soulseek) by lucapolesel</a>


