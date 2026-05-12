<!-- Source: https://wiki.servarr.com/radarr/supported -->

* * *

Radarr Supported

Comprehensive list of supported indexers, download clients, and services for Radarr

* * *

Page Contents

Table of Contents

Download Clients

Indexers

Usenet

Torrents

Notifications

Lists

Metadata

Tags

[radarr](https://wiki.servarr.com/t/radarr) [indexers](https://wiki.servarr.com/t/indexers) [supported](https://wiki.servarr.com/t/supported) [download-clients](https://wiki.servarr.com/t/download-clients) [services](https://wiki.servarr.com/t/services) [compatibility](https://wiki.servarr.com/t/compatibility) [Pages matching tags](https://wiki.servarr.com/t/radarr/indexers/supported/download-clients/services/compatibility)

Last edited by

Administrator

09/06/2025

# [¶](https://wiki.servarr.com/radarr/supported\#table-of-contents) Table of Contents

> This page is a work in progress and requires additional effort.

This page is the disambiguation page for all `supported` wiki links (i.e. typically "more info" in the UI).

# [¶](https://wiki.servarr.com/radarr/supported\#download-clients) Download Clients

- Aria2
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- Deluge
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- Download Station
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- Download Station
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- Flood
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- Hadouken
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- NZBGet
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- NZBVortex
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- Pneumatic
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- qBittorrent
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- rTorrent
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- SABnzbd
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- Torrent Blackhole
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- Transmission
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- Usenet Blackhole
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
- uTorrent
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)
  - Due to utorrent being adware and formerly spyware, it is not recommended. Most users use Qbittorrent.
- Vuze
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#download-clients)

# [¶](https://wiki.servarr.com/radarr/supported\#indexers) Indexers

## [¶](https://wiki.servarr.com/radarr/supported\#usenet) Usenet

- Newznab
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)
  - Newznab is a standardized API used by many usenet indexing sites. Many presets are available, but all require an API key to be accessible.
  - Indexer Applications like [Prowlarr](https://wiki.servarr.com/prowlarr) and [NZBHydra2](https://github.com/theotherp/nzbhydra2) can provide advanced capabilities such as stat tracking.
- omgwtfnzbs
  - A defunct legacy implementation of a private usenet indexer. Use Newznab instead.
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)

## [¶](https://wiki.servarr.com/radarr/supported\#torrents) Torrents

- FileList
  - Private Tracker
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)
- HDBits
  - Private Tracker
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)
- IP Torrents


  - Private Tracker

> IP Torrents' native implementation does not support Search. Use it via Prowlarr or Jackett as torznab instead

  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)
- Nyaa


  - Torrent Tracker for Japanese Media (Anime) exclusively.

> Nyaa frowns upon automation and frequently will ban your IP.

  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)
- Pass The Popcorn (PTP)
  - Private Tracker
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)
- Torrent RSS Feed


  - Generic torrent RSS feed parser.

> The RSS feed must contain a `pubdate`. The release size is recommended as well.

  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)
- TorrentPotato
  - A legacy Couchpotato pre-Torznab format.
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)
- Torznab
  - Torznab is a wordplay on Torrent and Newznab. It uses the same structure and syntax as the Newznab API specification, but exposing torrent-specific attributes and .torrent files. Thus supports a recent RSS feed AND backlog searching capabilities. The specification is not maintained nor supported by the Newznab organization. (The same API specification is shared with nZEDb)
  - This is primarily only supported by [Prowlarr](https://wiki.servarr.com/prowlarr) and [Jackett](https://github.com/Jackett/Jackett)
  - [Refer to the Settings Page](https://wiki.servarr.com/radarr/settings#indexer-settings)

> Many torrent trackers thrive on the community and may have rules in place that mandate site visits, karma, votes, comments, etc.
>
> Please review your tracker rules and etiquette, keep your community alive.
>
> We're not responsible if your account is banned for disobeying rules or accruing Hit and Runs (HnRs)/low-ratio.

# [¶](https://wiki.servarr.com/radarr/supported\#notifications) Notifications

- Boxcar
- Custom Script
  - This allows you to make a custom script for when a particular action happens this script will run. See [Custom Scripts](https://wiki.servarr.com/radarr/custom-scripts) for more details.
- Discord
  - By far one of the most common ways to push notifications of actions happening on your Radarr
- Email
  - Simply send yourself or somebody you want to annoy with email. If you're using Gmail, you need to enable less secure apps. If you're using Gmail and have 2-factor authentication enabled you need to use an App Specific password.

> You can use a "pretty address" like `SomePrettyName <email@example.org>`

- Emby

- Gotify

- Join

- Kodi

  - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customizable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community. By adding Kodi as a connection you can update Kodi's library when a new movie has been added to Radarr.
- Mailgun

- Notifiarr

  - See the entry on [Useful Tools - Notifiarr](https://wiki.servarr.com/useful-tools#notifiarr-fka-discord-notifier)
- Plex Media Server

  - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded movie is available.
  - This is rarely needed and is only required if Plex is unable to watch the file system for changes.
  - In the handful of situations where Plex is unable to watch the file system using ionotify - such as certain types of remote mounts and a handful of older network mounts - it is suggested to use the app plexautoscan rather than the Plex connection
- A use a tool like [plexautoscan](https://github.com/l3uddz/plex_autoscan) is another option.

- Prowl

- Pushbullet

- Pushcut

- Pushover

- SendGrid

- Slack

- Synology Indexer

- Telegram

- Trakt

- Twitter

  - See this [Tips and Tricks entry](https://wiki.servarr.com/useful-tools#twitter)
- Webhook


# [¶](https://wiki.servarr.com/radarr/supported\#lists) Lists

- CouchPotato

- Custom Lists

- IMDb Lists


  - To add your IMDb Watchlist, go to your list and click edit. Make sure privacy setting is set to public. In the address bar you will find the `lsxxxxxx` number that you will need to enter into Radarr

    1. Go to your IMDB List Settings
    2. Ensure Privacy is set to `Public` (i.e. `Disabled)`
    3. Use the `ls` number within the URL

![imdb-list-ls.png](https://wiki.servarr.com/assets/radarr/imdb-list-ls.png)

- Plex Watchlist

  - Requires: v4.1.0.6176+
  - Simply add a Plex watchlist for the authenticated Plex user to Radarr. Note that it's required that your list contain movies on it.
  - To have multiple user's watchlists you'll need to add each user's lists and authenticate with their Plex user.
- Radarr

  - TRaSH has [a guide](https://trash-guides.info/Radarr/Tips/Sync-2-radarr-sonarr/) for syncing two instances
- RSS List

  - This list format inherit from old IMDB RSS feeds. It only needs a title and a year which can be useful for non-enriched data.


    > Year is directly parsed from the title tag value


    Here is a sample data :



    ```xml

    ```





    Copy
- StevenLu Custom

  - Allows you to create custom movies lists in json format.


    Your feed requires for each movie either a `title` or an `imdb_id`, both can be provided.


    > Note that `imdb_id` is safer than `title` as it does not require a broad search
    >
    > Here is a sample valid json :




    ```json

    ```





    Copy

  - Additional keys can be added in items (will be ignored)

  - For an empty list just return an empty json array `[]`
- StevenLu List

- TMDb Collection

  - Collection Lists are no longer supported in Radarr v4.2 and have been migrated to collections within Radarr. See the [Collections](https://wiki.servarr.com/radarr/library#collections) section for more details.
- TMDb Company

- TMDb Keyword

- TMDb List

- TMDb Person

  - If the TMDb Person url is `https://www.themoviedb.org/person/500-tom-cruise` then the Person ID is `500`
- TMDb Popular

  - Top uses [https://developers.themoviedb.org/3/movies/get-top-rated-movies](https://developers.themoviedb.org/3/movies/get-top-rated-movies)
  - Popular uses [https://developers.themoviedb.org/3/movies/get-popular-movies](https://developers.themoviedb.org/3/movies/get-popular-movies)
  - Theaters uses [https://developers.themoviedb.org/3/movies/get-now-playing](https://developers.themoviedb.org/3/movies/get-now-playing)
  - Upcoming uses [https://developers.themoviedb.org/3/movies/get-upcoming](https://developers.themoviedb.org/3/movies/get-upcoming)
- TMDb User

- Trakt List

  - Username - Ensure you enter the actual username of the user and not the user's name
  - List - Ensure you use the list name as presented in the list URL
  - Example: `https://trakt.tv/users/some-user-name/lists/trakt-list-name?sort=rank,asc`
    - Username: `some-user-name`
    - List: `trakt-list-name`
- Trakt Popular List

- Trakt User

  - This type should be used when using your own watchlist

# [¶](https://wiki.servarr.com/radarr/supported\#metadata) Metadata

- Emby (Legacy)
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Enable metadata file creation for this metadata type
- Kodi (XBMC) / Emby
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Create a `<filename>.nfo` with the movie metadata
  - (Advanced Option) Movie Metadata URL - Create `movie.nfo` with TMDb and IMDb movie URLs
  - Metadata Language - Select the language Radarr should use to write the metadata if available in that language
  - Movie Images - Create various Season images including posters and banners
  - Use Movie.nfo - Write the nfo file as `movie.nfo` rather than the default
  - Collection Name - Radarr will write the collection name to the .nfo file
- Roksbox
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Create xml file for each movie
  - Movie Images - Create `Movie.jpg`
- WDTV
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Create `<filename>.xml` for each episode
  - Movie Images - Create `folder.jpg`