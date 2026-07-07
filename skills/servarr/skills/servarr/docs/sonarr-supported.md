> Source: https://wiki.servarr.com/sonarr/supported



> This page is a work in progress and requires additional effort.

This page is the disambiguation page for all "supported" wiki links (i.e. typically `More Info` in the UI).

# <a href="#download-clients" class="toc-anchor">¶</a> Download Clients

- <span id="aria2">Aria2</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="deluge">Deluge</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="torrentdownloadstation">Download Station</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="usenetdownloadstation">Download Station</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="flood">Flood</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="hadouken">Hadouken</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="nzbget">NZBGet</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="nzbvortex">NZBVortex</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="pneumatic">Pneumatic</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="qbittorrent">qBittorrent</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="rtorrent">rTorrent</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="sabnzbd">SABnzbd</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="torrentfreeboxdownload">Freebox Download</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="torrentblackhole">Torrent Blackhole</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="transmission">Transmission</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="usenetblackhole">Usenet Blackhole</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="utorrent">uTorrent</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
  - Due to uTorrent being adware and formerly spyware, it is not recommended. Most users use Qbittorrent
- <span id="vuze">Vuze</span>
  - <a href="/sonarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

# <a href="#indexers" class="toc-anchor">¶</a> Indexers

## <a href="#usenet" class="toc-anchor">¶</a> Usenet

- <span id="fanzub">Fanzub</span>
  - Usenet Indexer for Japanese Media (Anime) exclusively.
  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="newznab">Newznab</span>
  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
  - Newznab is a standardized API used by many usenet indexing sites. Many presets are available, but all require an API key to be accessible.
  - Indexer Applications like <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a> and <a href="https://github.com/theotherp/nzbhydra2" class="is-external-link">NZBHydra2</a> can provide advanced capabilities such as stat tracking.
- <span id="omgwtfnzbs">omgwtfnzbs</span>
  - A defunct legacy implementation of a private usenet indexer. Use Newznab instead.
  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

## <a href="#torrents" class="toc-anchor">¶</a> Torrents

- <span id="broadcasthenet">BroadcasTheNet (BTN)</span>
  - Private Tracker
  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="filelist">FileList</span>
  - Private Tracker
  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="hdbits">HDBits</span>
  - Private Tracker
  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="iptorrents">IP Torrents</span>

  - Private Tracker

  > IP Torrents' native implementation does not support Search. Use it via Prowlarr or Jackett as torznab instead

  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="nyaa">Nyaa</span>
  - Torrent Tracker for Japanese Media (Anime) exclusively.

  - Nyaa only supports search for Anime Series Types

  - Known Issues exist with the native Sonarr version
    - <a href="https://github.com/Sonarr/Sonarr/issues/4614" class="is-external-link">Nyaa seeders/leechers not parsed properly anymore. #4614</a>
      - This can be fixed when / if <a href="https://github.com/Sonarr/Sonarr/pull/4637" class="is-external-link">Pull Request #4637</a> is merged

  - Nyaa frowns upon automation and frequently will ban your IP.

  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="torrentrssindexer">Torrent RSS Feed</span>

  - Generic torrent RSS feed parser.

  > The RSS feed must contain a `pubdate`. The release size is recommended as well.

  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="torrentleech">TorrentLeech</span>
  - Private Indexer
  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="torznab">Torznab</span>
  - Torznab is a wordplay on Torrent and Newznab. It uses the same structure and syntax as the Newznab API specification, but exposing torrent-specific attributes and .torrent files. Thus supports a recent RSS feed AND backlog searching capabilities. The specification is not maintained nor supported by the Newznab organization. (The same API specification is shared with nZEDb)
  - This is primarily only supported by <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a> and <a href="https://github.com/Jackett/Jackett" class="is-external-link">Jackett</a>
  - <a href="/sonarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

> Many torrent trackers thrive on the community and may have rules in place that mandate site visits, karma, votes, comments, etc.  
> Please review your tracker rules and etiquette, keep your community alive.  
> We’re not responsible if your account is banned for disobeying rules or accruing Hit and Runs (HnRs)/low-ratio.

# <a href="#notifications" class="toc-anchor">¶</a> Notifications

- <span id="apprise">Apprise</span>
- <span id="customscript">Custom Script</span>
  - This allows you to make a custom script for when a particular action happens this script will run. See <a href="/sonarr/custom-scripts" class="is-internal-link is-valid-page">Custom Scripts</a> for more details.
- <span id="discord">Discord</span>
  - By far one of the most common ways to push notifications of actions happening on your Sonarr
  - Supported field types:  
    `Overview, Rating, Genres, Quality, Group, Size, Links, Release, Poster, Fanart, CustomFormats, CustomFormatScore, Indexer`
- <span id="email">Email</span>
  - Simply send yourself or somebody you want to annoy with email. If you're using Gmail, you need to enable less secure apps. If you're using Gmail and have 2-factor authentication enabled you need to use an App Specific password.

> You can use a "pretty address" like `SomePrettyName <email@example.org>`

- <div id="mediabrowser">

  Emby / Jellyfin

  </div>

- <div id="gotify">

  Gotify

  </div>

- <div id="join">

  Join

  </div>

- <div id="xbmc">

  Kodi

  - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customizable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community. By adding Kodi as a connection you can update Kodi's library when a new episode has been added to Sonarr.

  </div>

- <div id="mailgun">

  Mailgun

  </div>

- <div id="notifiarr">

  Notifiarr

  </div>

- <div id="ntfy">

  <a href="http://Ntfy.sh" class="is-external-link">Ntfy.sh</a>

  </div>

- <div id="plexserver">

  Plex Media Server

  - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded episode is available.
  - This is rarely needed and is only required if Plex is unable to watch the file system for changes.
  - In the handful of situations where Plex is unable to watch the file system using ionotify - such as certain types of remote mounts and a handful of older network mounts - it is suggested to use the app plexautoscan rather than the Plex connection

  </div>

> Note that this may trigger a full library scan for the library/root folder the series is in. It is strongly suggested to use the native Plex functionality that just watches the file system or to use a tool like <a href="https://github.com/l3uddz/plex_autoscan" class="is-external-link">plexautoscan</a>

- <span id="prowl">Prowl</span>
- <span id="pushbullet">Pushbullet</span>
- <span id="pushcut">Pushcut</span>
- <span id="pushover">Pushover</span>
- <span id="sendgrid">SendGrid</span>
- <span id="signal">Signal</span>
  - Requires <a href="https://github.com/AsamK/signal-cli" class="is-external-link">Signal-CLI</a>
- <span id="simplepush">Simplepush</span>
- <span id="slack">Slack</span>
- <span id="synologyindexer">Synology Indexer</span>
- <span id="telegram">Telegram</span>
- <span id="trakt">Trakt</span>
- <span id="twitter">Twitter</span>
  - See this <a href="/useful-tools#twitter" class="is-internal-link is-valid-page">Tips and Tricks entry</a>
- <span id="webhook">Webhook</span>

## <a href="#deprecated-notifications" class="toc-anchor">¶</a> Deprecated Notifications

- <span id="boxcar">Boxcar</span>
- <span id="plexhometheater">Plex Home Theater</span>
- <span id="plexclient">Plex Media Center</span>

# <a href="#lists" class="toc-anchor">¶</a> Lists

- <span id="anilistimport">AniList</span>
  - <a href="/sonarr/settings#import-lists" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="customimport">Custom Lists</span>
  - <a href="/sonarr/settings#import-lists" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="imdblistimport">IMDb Lists</span>
  - <a href="/sonarr/settings#import-lists" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="myanimelistimport">MyAnimeList</span>
  - <a href="/sonarr/settings#import-lists" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="pleximport">Plex Watchlist</span>
  - Simply add a Plex watchlist for the authenticated Plex user to Sonarr. Note that it's required that your list contain shows on it.
  - To have multiple user's watchlists you'll need to add each user's lists and authenticate with their Plex user.
- <span id="plexrssimport">Plex Watchlist RSS</span>
  - <a href="/sonarr/settings#import-lists" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="simkluserimport">Simkl</span>
  - <a href="/sonarr/settings#import-lists" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="sonarrimport">Sonarr</span>
  - TRaSH has <a href="https://trash-guides.info/Sonarr/Tips/Sync-2-radarr-sonarr/" class="is-external-link">a guide</a> for syncing two instances
- <span id="traktlistimport">Trakt List</span>
  - Username - Ensure you enter the actual username of the user and not the user's name
  - List - Ensure you use the list name as presented in the list URL
  - Example: `https://trakt.tv/users/some-user-name/lists/trakt-list-name?sort=rank,asc`
    - Username: `some-user-name`
    - List: `trakt-list-name`
- <span id="traktpopularimport">Trakt Popular List</span>
- <span id="traktuserimport">Trakt User</span>

> Trakt lists should contain shows, not individual episodes. Sonarr will only match and add shows.

# <a href="#metadata" class="toc-anchor">¶</a> Metadata

- <span id="kometametadata">Kometa</span>

  - Enable - Enable metadata file creation for this metadata type

  > Kometa metadata is deprecated.

- <span id="xbmcmetadata">Kodi (XBMC) / Emby</span>
  - Enable - Enable metadata file creation for this metadata type
  - Series Metadata - Create a `tvshow.nfo` with full series metadata
  - (Advanced Option) Series Metadata URL - Create tvshow.nfo with TheTVDb series URL
  - Episode Metadata - Create `<filename>.nfo` for each episode
  - Series Images - Create various Series images including posters and banners named as `poster.jpg` and `banner.jpg`
  - Season Images - Create various Season images including posters and banners named as `season##-poster.jpg` and `season##-banner.jpg`
  - Episode Images - Create various Episode images such as thumnbnails named as named as `<filename>-thumb.jpg`

- <span id="plexmetadata">Plex</span>
  - Enable - Enable metadata file creation for this metadata type
  - Series Metadata - Create a `.plexmatch` file in the series root folder

- <span id="roksboxmetadata">Roksbox</span>
  - Enable - Enable metadata file creation for this metadata type
  - Episode Metadata - Create `Season##\<filename>.xml` for each episode
  - Series Images - Create `Series Title.jpg`
  - Season Images - Create `Season ##.jpg`
  - Episode Images - Create `Season##\<filename>.jpg`

- <span id="wdtvmetadata">WDTV</span>
  - Enable - Enable metadata file creation for this metadata type
  - Episode Metadata - Create `Season##\<filename>.xml` for each episode
  - Series Images - Create `folder.jpg`
  - Season Images - Create `Season ##\folder.jpg`
  - Episode Images - Create `Season##\<filename>.metathumb`


