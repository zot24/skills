> Source: https://wiki.servarr.com/radarr/supported



# <a href="#table-of-contents" class="toc-anchor">¶</a> Table of Contents

> This page is a work in progress and requires additional effort.

This page is the disambiguation page for all `supported` wiki links (i.e. typically "more info" in the UI).

# <a href="#download-clients" class="toc-anchor">¶</a> Download Clients

- <span id="aria2">Aria2</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="deluge">Deluge</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="torrentdownloadstation">Download Station</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="usenetdownloadstation">Download Station</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="flood">Flood</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="torrentfreeboxdownload">Freebox Download</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="hadouken">Hadouken</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="nzbget">NZBGet</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="nzbvortex">NZBVortex</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="pneumatic">Pneumatic</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="qbittorrent">qBittorrent</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="rtorrent">rTorrent</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="sabnzbd">SABnzbd</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="torrentblackhole">Torrent Blackhole</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="transmission">Transmission</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="usenetblackhole">Usenet Blackhole</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
- <span id="utorrent">uTorrent</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
  - Due to utorrent being adware and formerly spyware, it is not recommended. Most users use Qbittorrent.
- <span id="vuze">Vuze</span>
  - <a href="/radarr/settings#download-clients" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

# <a href="#indexers" class="toc-anchor">¶</a> Indexers

## <a href="#usenet" class="toc-anchor">¶</a> Usenet

- <span id="newznab">Newznab</span>
  - <a href="/radarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>
  - Newznab is a standardized API used by many usenet indexing sites. Many presets are available, but all require an API key to be accessible.
  - Indexer Applications like <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a> and <a href="https://github.com/theotherp/nzbhydra2" class="is-external-link">NZBHydra2</a> can provide advanced capabilities such as stat tracking.

## <a href="#torrents" class="toc-anchor">¶</a> Torrents

- <span id="filelist">FileList</span>
  - Private Tracker
  - <a href="/radarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="hdbits">HDBits</span>
  - Private Tracker
  - <a href="/radarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="iptorrents">IP Torrents</span>

  - Private Tracker

  > IP Torrents' native implementation does not support Search. Use it via Prowlarr or Jackett as torznab instead

  - <a href="/radarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="nyaa">Nyaa</span>

  - Torrent Tracker for Japanese Media (Anime) exclusively.

  > Nyaa frowns upon automation and frequently will ban your IP.

  - <a href="/radarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="passthepopcorn">Pass The Popcorn (PTP)</span>
  - Private Tracker
  - <a href="/radarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="torrentrssindexer">Torrent RSS Feed</span>

  - Generic torrent RSS feed parser.

  > The RSS feed must contain a `pubdate`. The release size is recommended as well.

  - <a href="/radarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="torrentpotato">TorrentPotato</span>
  - A legacy Couchpotato pre-Torznab format.
  - <a href="/radarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

- <span id="torznab">Torznab</span>
  - Torznab is a wordplay on Torrent and Newznab. It uses the same structure and syntax as the Newznab API specification, but exposing torrent-specific attributes and .torrent files. Thus supports a recent RSS feed AND backlog searching capabilities. The specification is not maintained nor supported by the Newznab organization. (The same API specification is shared with nZEDb)
  - This is primarily only supported by <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a> and <a href="https://github.com/Jackett/Jackett" class="is-external-link">Jackett</a>
  - <a href="/radarr/settings#indexer-settings" class="is-internal-link is-valid-page">Refer to the Settings Page</a>

> Many torrent trackers thrive on the community and may have rules in place that mandate site visits, karma, votes, comments, etc.  
> Please review your tracker rules and etiquette, keep your community alive.  
> We're not responsible if your account is banned for disobeying rules or accruing Hit and Runs (HnRs)/low-ratio.

# <a href="#notifications" class="toc-anchor">¶</a> Notifications

- <span id="apprise">Apprise</span>
- <span id="customscript">Custom Script</span>
  - This allows you to make a custom script for when a particular action happens this script will run. See <a href="/radarr/custom-scripts" class="is-internal-link is-valid-page">Custom Scripts</a> for more details.
- <span id="discord">Discord</span>
  - By far one of the most common ways to push notifications of actions happening on your Radarr
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

  - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customizable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community. By adding Kodi as a connection you can update Kodi's library when a new movie has been added to Radarr.

  </div>

- <div id="mailgun">

  Mailgun

  </div>

- <div id="notifiarr">

  Notifiarr

  - See the entry on <a href="/useful-tools#notifiarr-fka-discord-notifier" class="is-internal-link is-valid-page">Useful Tools - Notifiarr</a>

  </div>

- <div id="ntfy">

  <a href="http://ntfy.sh" class="is-external-link">ntfy.sh</a>

  </div>

- <div id="plexserver">

  Plex Media Server

  - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded movie is available.
  - This is rarely needed and is only required if Plex is unable to watch the file system for changes.
  - In the handful of situations where Plex is unable to watch the file system using ionotify - such as certain types of remote mounts and a handful of older network mounts - it is suggested to use the app plexautoscan rather than the Plex connection

  </div>

- A use a tool like <a href="https://github.com/l3uddz/plex_autoscan" class="is-external-link">plexautoscan</a> is another option.

- <div id="prowl">

  Prowl

  </div>

- <div id="pushbullet">

  Pushbullet

  </div>

- <div id="pushcut">

  Pushcut

  </div>

- <div id="pushover">

  Pushover

  </div>

- <div id="pushsafer">

  Pushsafer

  </div>

- <div id="sendgrid">

  SendGrid

  </div>

- <div id="signal">

  Signal

  </div>

- <div id="simplepush">

  Simplepush

  </div>

- <div id="slack">

  Slack

  </div>

- <div id="synologyindexer">

  Synology Indexer

  </div>

- <div id="telegram">

  Telegram

  </div>

- <div id="trakt">

  Trakt

  </div>

- <div id="twitter">

  Twitter

  - See this <a href="/useful-tools#twitter" class="is-internal-link is-valid-page">Tips and Tricks entry</a>

  </div>

- <div id="webhook">

  Webhook

  </div>

# <a href="#lists" class="toc-anchor">¶</a> Lists

- <div id="couchpotatoimport">

  CouchPotato

  </div>

- <div id="radarrlistimport">

  Custom Lists

  </div>

- <div id="imdblistimport">

  IMDb Lists

  - To add your IMDb Watchlist, go to your list and click edit. Make sure privacy setting is set to public. In the address bar you will find the `lsxxxxxx` number that you will need to enter into Radarr

    1.  Go to your IMDB List Settings
    2.  Ensure Privacy is set to `Public` (i.e. `Disabled)`
    3.  Use the `ls` number within the URL

  ![imdb-list-ls.png](/assets/radarr/imdb-list-ls.png)

  </div>

- <div id="plex">

  Plex Watchlist

  - Requires: v4.1.0.6176+
  - Simply add a Plex watchlist for the authenticated Plex user to Radarr. Note that it's required that your list contain movies on it.
  - To have multiple user's watchlists you'll need to add each user's lists and authenticate with their Plex user.

  </div>

- <div id="plexrss">

  Plex Watchlist RSS

  - Add a Plex watchlist via an RSS feed URL.

  </div>

- <div id="radarrimport">

  Radarr

  - TRaSH has <a href="https://trash-guides.info/Radarr/Tips/Sync-2-radarr-sonarr/" class="is-external-link">a guide</a> for syncing two instances

  </div>

- <div id="rssimport">

  RSS List

  - This list format inherit from old IMDB RSS feeds. It only needs a title and a year which can be useful for non-enriched data.

    > Year is directly parsed from the title tag value

    Here is a sample data :

    ``` prismjs
    <rss>
      <channel>
          <title>My custom RSS list</title>
          <description></description>
          <link>http://example.com/rss</link>
          <lastBuildDate>Sun, 16 Jun 2024 13:54:33 GMT</lastBuildDate>
          <item>
              <title><![CDATA[ Tehachapi (2023) ]]></title>
              <guid isPermaLink="false">Tehachapi (2023)</guid>
          </item>
          <item>
              <title><![CDATA[ Dissidente (2023) ]]></title>
              <guid isPermaLink="false">Dissidente (2023)</guid>
          </item>
      </channel>
    </rss>
    ```

  </div>

- <div id="simkl">

  Simkl User Watchlist

  - Add movies from your Simkl watchlist.

  </div>

- <div id="stevenluimport">

  StevenLu Custom

  - Allows you to create custom movies lists in json format.  
    Your feed requires for each movie either a `title` or an `imdb_id`, both can be provided.

    > Note that `imdb_id` is safer than `title` as it does not require a broad search  
    > Here is a sample valid json :

    ``` prismjs
    [
        {
          "title": "The Wastetown",
          "poster_url": "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/6J32RMp8uko8CUEM3rYP962hQun.jpg",
          "imdb_id": "tt22889064"
        },
        {
          "title": "Wild Sunflowers",
          "poster_url": "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/tHK4c0UZKrqkmXZ2HJeGNhNetRz.jpg",
          "imdb_id": "tt13774830"
        }
    ]
    ```

  - Additional keys can be added in items (will be ignored)

  - For an empty list just return an empty json array `[]`

  </div>

- <div id="stevenlu2import">

  StevenLu List

  </div>

- <div id="tmdbcollectionimport">

  TMDb Collection

  - Collection Lists are no longer supported in Radarr v4.2 and have been migrated to collections within Radarr. See the <a href="/radarr/library#collections" class="is-internal-link is-valid-page">Collections</a> section for more details.

  </div>

- <div id="tmdbcompanyimport">

  TMDb Company

  </div>

- <div id="tmdbkeywordimport">

  TMDb Keyword

  </div>

- <div id="tmdblistimport">

  TMDb List

  </div>

- <div id="tmdbpersonimport">

  TMDb Person

  - If the TMDb Person url is `https://www.themoviedb.org/person/500-tom-cruise` then the Person ID is `500`

  </div>

- <div id="tmdbpopularimport">

  TMDb Popular

  - Top uses <a href="https://developers.themoviedb.org/3/movies/get-top-rated-movies" class="is-external-link">https://developers.themoviedb.org/3/movies/get-top-rated-movies</a>
  - Popular uses <a href="https://developers.themoviedb.org/3/movies/get-popular-movies" class="is-external-link">https://developers.themoviedb.org/3/movies/get-popular-movies</a>
  - Theaters uses <a href="https://developers.themoviedb.org/3/movies/get-now-playing" class="is-external-link">https://developers.themoviedb.org/3/movies/get-now-playing</a>
  - Upcoming uses <a href="https://developers.themoviedb.org/3/movies/get-upcoming" class="is-external-link">https://developers.themoviedb.org/3/movies/get-upcoming</a>

  </div>

- <div id="tmdbuserimport">

  TMDb User

  </div>

- <div id="traktlistimport">

  Trakt List

  - Username - Ensure you enter the actual username of the user and not the user's name
  - List - Ensure you use the list name as presented in the list URL
  - Example: `https://trakt.tv/users/some-user-name/lists/trakt-list-name?sort=rank,asc`
    - Username: `some-user-name`
    - List: `trakt-list-name`

  </div>

- <div id="traktpopularimport">

  Trakt Popular List

  </div>

- <div id="traktuserimport">

  Trakt User

  - This type should be used when using your own watchlist

  </div>

# <a href="#metadata" class="toc-anchor">¶</a> Metadata

- <span id="mediabrowsermetadata">Emby (Legacy)</span>
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Enable metadata file creation for this metadata type
- <span id="kometametadata">Kometa</span>
  - Deprecated - This metadata consumer has been deprecated
- <span id="xbmcmetadata">Kodi (XBMC) / Emby</span>
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Create a `<filename>.nfo` with the movie metadata
  - (Advanced Option) Movie Metadata URL - Create `movie.nfo` with TMDb and IMDb movie URLs
  - Metadata Language - Select the language Radarr should use to write the metadata if available in that language
  - Movie Images - Create various Season images including posters and banners
  - Use Movie.nfo - Write the nfo file as `movie.nfo` rather than the default
  - Collection Name - Radarr will write the collection name to the .nfo file
- <span id="roksboxmetadata">Roksbox</span>
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Create xml file for each movie
  - Movie Images - Create `Movie.jpg`
- <span id="wdtvmetadata">WDTV</span>
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Create `<filename>.xml` for each episode
  - Movie Images - Create `folder.jpg`


