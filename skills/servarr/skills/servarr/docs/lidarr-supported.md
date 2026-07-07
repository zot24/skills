> Source: https://wiki.servarr.com/lidarr/supported



This page is the disambiguation target for all **More Info** links in the Lidarr UI. Each entry corresponds to a specific integration type.

> Lidarr includes these integrations natively. Add more download clients and indexers (including slskd, Deezer, Tidal, and others) via <a href="/lidarr/plugins" class="is-internal-link is-valid-page">plugins</a>.

## <a href="#download-clients" class="toc-anchor">¶</a> Download Clients

- <span id="aria2">Aria2</span>
  - Open-source, multi-protocol download utility supporting HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="deluge">Deluge</span>
  - Open-source, cross-platform BitTorrent client with a web UI and remote daemon.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="torrentdownloadstation">Download Station</span>
  - Synology NAS built-in download manager. Handles torrent downloads natively without a separate client.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="usenetdownloadstation">Download Station</span>
  - Synology NAS built-in download manager. Handles Usenet downloads natively without a separate client.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="flood">Flood</span>
  - Modern web UI for rTorrent (and other torrent backends) with a clean interface and real-time updates.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="torrentfreeboxdownload">Freebox Download</span>
  - Download client built into Free's Freebox home router/gateway.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="hadouken">Hadouken</span>
  - Open-source BitTorrent client with a web UI.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="nzbget">NZBGet</span>
  - Efficient, low-resource Usenet downloader. A common alternative to SABnzbd.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="nzbvortex">NZBVortex</span>
  - Mac-native Usenet client.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="pneumatic">Pneumatic</span>
  - NZB client that drops files into a watch folder. Primarily used with Kodi.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="qbittorrent">qBittorrent</span>
  - Popular open-source BitTorrent client with a web UI. Widely recommended as the default choice.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="rtorrent">rTorrent</span>
  - Terminal-based BitTorrent client, often paired with the ruTorrent web UI.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="sabnzbd">SABnzbd</span>
  - Open-source Usenet client. One of the most widely used Usenet downloaders.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="torrentblackhole">Torrent Blackhole</span>
  - Watches a folder for `.torrent` files. Use this if your torrent client doesn't have a direct API integration.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="transmission">Transmission</span>
  - Lightweight, cross-platform BitTorrent client with a web UI. Popular on Linux and NAS devices.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="usenetblackhole">Usenet Blackhole</span>
  - Watches a folder for `.nzb` files. Use this if your Usenet client doesn't have a direct API integration.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="utorrent">uTorrent</span>
  - Avoid uTorrent. It's adware and has a history of including spyware. Most users choose qBittorrent.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="vuze">Vuze</span>
  - Java-based BitTorrent client with an advanced feature set including swarm merging and built-in search.
  - <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

## <a href="#indexers" class="toc-anchor">¶</a> Indexers

### <a href="#usenet" class="toc-anchor">¶</a> Usenet

- <span id="newznab">Newznab</span>
  - Standardised API used by most Usenet indexing sites. Many presets are available, but all require an API key. Indexer aggregators like <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a> and <a href="https://github.com/theotherp/nzbhydra2" class="is-external-link">NZBHydra2</a> can manage more than one Newznab indexer from a single interface.
  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

### <a href="#torrents" class="toc-anchor">¶</a> Torrents

- <span id="filelist">FileList</span>
  - Private torrent tracker with a broad content library.
  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="gazelle">Gazelle API</span>
  - Used by Gazelle-based private trackers such as Redacted (formerly <a href="http://What.CD" class="is-external-link">What.CD</a>).
  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="headphones">Headphones VIP</span>
  - Legacy music indexer aggregator from the Headphones era.
  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="iptorrents">IP Torrents</span>

  - Private tracker.

  > IP Torrents' native implementation doesn't support Search.

  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="nyaa">Nyaa</span>
  - Public Japanese torrent indexer. Covers anime, manga, and music.
  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="redacted">Redacted</span>
  - Premier private music tracker. Requires an account with the Redacted community.
  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="torrentrssindexer">Torrent RSS Feed</span>

  - Generic torrent RSS feed parser.

  > The RSS feed must contain a `pubdate`. The release size is recommended as well.

  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="torrentleech">TorrentLeech</span>
  - Private tracker.
  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="torznab">Torznab</span>
  - Standardised API for torrent indexers, based on the Newznab specification with torrent-specific extensions. Supports RSS feeds and backlog searching. Primarily provided by <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a> and <a href="https://github.com/Jackett/Jackett" class="is-external-link">Jackett</a>.
  - <a href="/lidarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

## <a href="#notifications" class="toc-anchor">¶</a> Notifications

- <span id="apprise">Apprise</span>
  - Allows notifications to be sent to many popular notification services via a single interface.

- <span id="customscript">Custom Script</span>
  - Runs a user-supplied script when a specified event occurs. See <a href="/lidarr/custom-scripts" class="is-internal-link is-valid-page">Custom Scripts</a> for the full list of available environment variables and example scripts.

- <span id="discord">Discord</span>
  - Sends notifications to a Discord channel via webhook. One of the most commonly used notification integrations.

- <span id="email">Email</span>

  - Sends notification emails. If you use Gmail, enable App Passwords under your Google account security settings rather than using your main password.

  > You can use a display name with the address: `Your Name <email@example.com>`

- <span id="mediabrowser">Emby / Jellyfin</span>
  - Notifies an Emby or Jellyfin server to refresh its music library after a track is imported or upgraded.

- <span id="gotify">Gotify</span>
  - Self-hosted push notification server.

- <span id="join">Join</span>
  - Push notification service for Android devices.

- <span id="xbmc">Kodi</span>
  - Notifies a Kodi instance to refresh its music library after a track is imported or upgraded. Kodi is a free, open-source media centre application.

- <span id="mailgun">Mailgun</span>
  - Transactional email API service for sending notification emails.

- <span id="notifiarr">Notifiarr</span>
  - See <a href="/useful-tools#notifiarr-fka-discord-notifier" class="is-internal-link is-valid-page">Useful Tools — Notifiarr</a>

- <span id="ntfy"><a href="http://ntfy.sh" class="is-external-link">ntfy.sh</a></span>
  - Self-hostable push notification service with a simple HTTP API.

- <span id="plexserver">Plex Media Server</span>
  - Notifies a Plex Media Server to refresh its music library after a track is imported or upgraded.

- <span id="prowl">Prowl</span>
  - iOS push notification service.

- <span id="pushbullet">Pushbullet</span>
  - Cross-platform notification and file sharing service.

- <span id="pushcut">Pushcut</span>
  - iOS app for automation and notifications.

- <span id="pushover">Pushover</span>
  - Simple push notification service for mobile devices.

- <span id="sendgrid">SendGrid</span>
  - Transactional email API service for sending notification emails.

- <span id="signal">Signal</span>
  - Sends notifications via the Signal messaging app. Requires a running <a href="https://github.com/AsamK/signal-cli" class="is-external-link">Signal-CLI</a> instance.

- <span id="simplepush">Simplepush</span>
  - Simple push notification service requiring no account.

- <span id="slack">Slack</span>
  - Sends notifications to a Slack channel via webhook.

- <span id="subsonic">Subsonic</span>
  - Notifies a Subsonic-compatible server to update its music library.

- <span id="synologyindexer">Synology Indexer</span>
  - Triggers a Synology NAS media indexer scan after a track is imported or upgraded.

- <span id="telegram">Telegram</span>
  - Sends notifications to a Telegram chat or channel via a bot.

- <span id="twitter">Twitter</span>
  - Posts notifications to a Twitter account.

- <span id="webhook">Webhook</span>
  - Sends an HTTP POST request to a configured URL when events occur.

## <a href="#lists" class="toc-anchor">¶</a> Lists

- <span id="customlist">Custom List</span>
  - Import artists from a manually maintained list.
- <span id="headphonesimport">Headphones</span>
  - Import artists from a <a href="https://github.com/rembo10/headphones" class="is-external-link">Headphones</a> instance.
- <span id="lastfmtag"><a href="http://Last.fm" class="is-external-link">Last.fm</a> Tag</span>
  - Import artists via a <a href="http://Last.fm" class="is-external-link">Last.fm</a> genre or style tag.
- <span id="lastfmuser"><a href="http://Last.fm" class="is-external-link">Last.fm</a> User</span>
  - Import artists from a <a href="http://Last.fm" class="is-external-link">Last.fm</a> user's listening history or loved tracks.
- <span id="lidarrimport">Lidarr</span>
  - Sync monitored artists from another Lidarr instance.
- <span id="lidarrlists">Lidarr Lists</span>
  - Import artists from curated Lidarr community lists.
- <span id="musicbrainzseries">MusicBrainz Series</span>
  - Import artists belonging to a <a href="https://musicbrainz.org/doc/Series" class="is-external-link">MusicBrainz Series</a>.
- <span id="spotifyfollowedartists">Spotify Followed Artists</span>
  - Import artists you follow on Spotify.
- <span id="spotifyplaylist">Spotify Playlists</span>
  - Import artists from your Spotify playlists.
- <span id="spotifysavedalbums">Spotify Saved Albums</span>
  - Import artists from your Spotify saved albums.

## <a href="#metadata" class="toc-anchor">¶</a> Metadata

- <span id="xbmcmetadata">Kodi (XBMC) / Emby</span>
  - Generates `.nfo` sidecar files for artist and album folders, compatible with Kodi and Emby/Jellyfin.
- <span id="roksboxmetadata">Roksbox</span>
  - Generates metadata files compatible with Roksbox media players.
- <span id="wdtvmetadata">WDTV</span>
  - Generates metadata files compatible with WD TV media players.


