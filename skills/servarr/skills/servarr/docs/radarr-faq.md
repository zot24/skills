> Source: https://wiki.servarr.com/radarr/faq



# <a href="#table-of-contents" class="toc-anchor">¶</a> Table of Contents

- [Table of Contents](#table-of-contents)
- [Radarr Basics](#radarr-basics)
  - [How does Radarr work?](#how-does-radarr-work)
  - [How does Radarr find movies?](#how-does-radarr-find-movies)
  - [How do I access Radarr from another computer?](#how-do-i-access-radarr-from-another-computer)
  - [Forced Authentication](#forced-authentication)
    - [Authentication Method](#authentication-method)
    - [Authentication Required](#authentication-required)
  - [What is Minimum Availability?](#what-is-minimum-availability)
  - [How are possible downloads compared?](#how-are-possible-downloads-compared)
  - [What are Lists and what can they do for me?](#what-are-lists-and-what-can-they-do-for-me)
    - [Why are lists sync times so long and can I change it?](#why-are-lists-sync-times-so-long-and-can-i-change-it)
  - [Can all my movie files be stored in one folder?](#can-all-my-movie-files-be-stored-in-one-folder)
  - [Can I put all my movies in my library into one folder?](#can-i-put-all-my-movies-in-my-library-into-one-folder)
  - [How do I update Radarr?](#how-do-i-update-radarr)
    - [Can I update Radarr inside my Docker container?](#can-i-update-radarr-inside-my-docker-container)
    - [Installing a newer version](#installing-a-newer-version)
      - [Native](#native)
      - [Docker](#docker)
  - [Can I switch from `nightly` back to `develop`?](#can-i-switch-from-nightly-back-to-develop)
  - [Can I switch between branches?](#can-i-switch-between-branches)
  - [How do I Backup/Restore Radarr?](#how-do-i-backuprestore-radarr)
    - [Backing up Radarr](#backing-up-radarr)
      - [Using built-in backup](#using-built-in-backup)
      - [Using file system directly](#using-file-system-directly)
    - [Restoring from Backup](#restoring-from-backup)
      - [Using zip backup](#using-zip-backup)
      - [Using file system backup](#using-file-system-backup)
      - [File System Restore on Synology NAS](#file-system-restore-on-synology-nas)
- [Radarr Common Problems](#radarr-common-problems)
  - [A Task was Canceled](#a-task-was-canceled)
  - [Path is Already Configured for an Existing Movie](#path-is-already-configured-for-an-existing-movie)
  - [How can I rename my movie folders?](#how-can-i-rename-my-movie-folders)
  - [Movie File and Folder Naming](#movie-file-and-folder-naming)
  - [Movie Folders Named Incorrectly](#movie-folders-named-incorrectly)
  - [Can I disable the refresh movies task](#can-i-disable-the-refresh-movies-task)
  - [How do I request a feature for Radarr?](#how-do-i-request-a-feature-for-radarr)
  - [Help, My Mac says Radarr cannot be opened because the developer cannot be verified](#help-my-mac-says-radarr-cannot-be-opened-because-the-developer-cannot-be-verified)
  - [Help, My Mac says Radarr.app is damaged and can’t be opened](#help-my-mac-says-radarrapp-is-damaged-and-cant-be-opened)
  - [I am getting an error: Database disk image is malformed](#i-am-getting-an-error-database-disk-image-is-malformed)
  - [I use Radarr on a Mac and it suddenly stopped working. What happened?](#i-use-radarr-on-a-mac-and-it-suddenly-stopped-working-what-happened)
  - [Why can Radarr not see my files on a remote server?](#why-can-radarr-not-see-my-files-on-a-remote-server)
    - [Radarr runs under the LocalService account by default which doesn't have access to protected remote file shares](#radarr-runs-under-the-localservice-account-by-default-which-doesnt-have-access-to-protected-remote-file-shares)
    - [You're using a mapped network drive (not a UNC path)](#youre-using-a-mapped-network-drive-not-a-unc-path)
  - [How do I change from the Windows Service to a Tray App?](#how-do-i-change-from-the-windows-service-to-a-tray-app)
  - [Help I have locked myself out](#help-i-have-locked-myself-out)
  - [How do I stop the browser from launching on startup?](#how-do-i-stop-the-browser-from-launching-on-startup)
  - [Weird UI Issues](#weird-ui-issues)
  - [Web Interface Only Loads at localhost on Windows](#web-interface-only-loads-at-localhost-on-windows)
  - [Permissions](#permissions)
  - [System & Logs loads forever](#system-logs-loads-forever)
  - [Unpack Torrents](#unpack-torrents)
  - [I got a pop-up that said config.xml was corrupt, what now?](#i-got-a-pop-up-that-said-configxml-was-corrupt-what-now)
  - [Invalid Certificate and other HTTPS or SSL issues](#invalid-certificate-and-other-https-or-ssl-issues)
  - [VPNs, Jackett, and the \*ARRs](#vpns-jackett-and-the-arrs)
    - [Use of a VPN](#use-of-a-vpn)
- [Radarr Searching & Downloading Common Problems](#radarr-searching--downloading-common-problems)
  - [Why can I not add a new movie to Radarr?](#why-can-i-not-add-a-new-movie-to-radarr)
  - [What is this new "*Override and add to download queue*" button?](#what-is-this-new-override-and-add-to-download-queue-button)
  - [Jackett shows more results than when manually searching](#jackett-shows-more-results-than-when-manually-searching)
  - [How does Radarr determine the year of a movie?](#how-does-radarr-determine-the-year-of-a-movie)
  - [How does Radarr handle foreign movies or foreign titles?](#how-does-radarr-handle-foreign-movies-or-foreign-titles)
  - [ID Searches](#id-searches)
  - [Text Searches](#text-searches)
  - [Getting Foreign Movies](#getting-foreign-movies)
  - [How does Radarr handle "multi" in names?](#how-does-radarr-handle-multi-in-names)
  - [Help, Movie Added, But Not Searched](#help-movie-added-but-not-searched)
  - [Jackett's /all Endpoint](#jacketts-all-endpoint)
    - [Jackett /All Solutions](#jackett-all-solutions)
  - [Why are there two files? \| Why is there a file left in downloads?](#why-are-there-two-files--why-is-there-a-file-left-in-downloads)
  - [Why doesn't Radarr work behind a reverse proxy](#why-doesnt-radarr-work-behind-a-reverse-proxy)

# <a href="#radarr-basics" class="toc-anchor">¶</a> Radarr Basics

## <a href="#how-does-radarr-work" class="toc-anchor">¶</a> How does Radarr work

- Radarr does *not* regularly search for movie files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for *all* the newly posted movies, then compares that with its list of movies that are missing or need to be upgraded. Any matches are downloaded. This lets Radarr cover a library of *any size* with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you will realize that it only covers the *future* though.
- So how do you deal with the present and past? When you're adding a movie, you will need to set the correct path, profile and monitoring status then use the Start search for missing movie checkbox. If the movie hasn't been released yet, you do not need to initiate a search.
- Put another way, Radarr will only find movies that are newly uploaded to your indexers. It will not actively try to find movies you want that were uploaded in the past.
- If you've already added the movie, but now you want to search for it, you have a few choices. You can go to the movie's page and use the search button, which will do a search and then automatically pick one. You can use the Search tab and see *all* the results, hand picking the one you want. Or you can use the filters of `Missing`, `Wanted`, or `Cut-off Unmet`.
- If Radarr has been offline for an extended period of time, Radarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Radarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed movies.

> Upgradinatorr can do periodic bulk searches which is useful to safely and sanely look for upgrades after major changes to one's quality profile. Use <a href="/useful-tools#drazzilbs-userscripts" class="is-internal-link is-valid-page">Drazzlib's Python Script</a> or <a href="/useful-tools#just-a-bunch-of-starr-scripts" class="is-internal-link is-valid-page">Cuban's Powershell Script</a>

## <a href="#how-does-radarr-find-movies" class="toc-anchor">¶</a> How does Radarr find movies

> This FAQ item is a legacy FAQ Entry. Refer to [How does Radarr work?](#how-does-radarr-work)

## <a href="#how-do-i-access-radarr-from-another-computer" class="toc-anchor">¶</a> How do I access Radarr from another computer

- By default Radarr doesn't listen to requests from all systems (when not run as administrator), it will only listen on localhost, this is due to how the Web Server Radarr uses integrates with Windows (this also applies for current alternatives). If Radarr is run as an administrator it will correctly register itself with Windows as well as open the Firewall port so it can be accessed from other systems on your network. Running as admin only needs to happen once (if you change the port it will need to be re-run).

## <a href="#forced-authentication" class="toc-anchor">¶</a> Forced Authentication

If Radarr is exposed so that the UI can be accessed from outside your local network then you should have some form of authentication method enabled in order to access the UI. This is also increasingly required by Trackers and Indexers.

**As of Radarr v5, Authentication is Mandatory.**

- `AuthenticationRequired` and `AuthenticationMethod` are mandatory required attributes in the configuration file.

### <a href="#authentication-method" class="toc-anchor">¶</a> Authentication Method

- `Basic` (Browser pop-up) - This option when accessing your Radarr will show a small pop-up allowing you to input a Username and Password. Note this is not recommended and removed in Radarr v6.
- `Forms` (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Radarr. This is recommended.
- `External` - Configurable via Config File Only
  - Disables app authentication completely. *Use at your own risk especially if exposed to the internet* Suggested if you use an **external authentication** such as Authelia, Authetik, NGINX Basic auth, etc. you can prevent needing to double authenticate by shutting down the app, setting `<AuthenticationMethod>External</AuthenticationMethod>` in the <a href="/radarr/appdata-directory" class="is-internal-link is-valid-page">config file</a>, and restarting the app. **Note that multiple `AuthenticationMethod` entries in the file are not supported and only the topmost value will be used**
  - <a href="https://github.com/Radarr/Radarr/issues/7047#issuecomment-1696156068" class="is-external-link">OIDC Support</a> is being explored for future versions (Ref <a href="https://github.com/Radarr/Radarr/issues/7047" class="is-external-link">GHI #7047</a>) and is NOT currently supported.

### <a href="#authentication-required" class="toc-anchor">¶</a> Authentication Required

- If you do not expose the app externally and/or do not wish to have auth required for local (e.g. LAN (i.e. Link Local, <a href="https://en.wikipedia.org/wiki/Classful_network#Classful_addressing_definition" class="is-external-link">Class A, Class C, or Class B</a> addresses)) access then change in Settings =\> General Security =\> Authentication Required to `Disabled For Local Addresses`
  - The config file equivalent of this is `<AuthenticationRequired>DisabledForLocalAddresses</AuthenticationRequired>`
- `<AuthenticationRequired>Enabled</AuthenticationRequired>` is also a valid value

## <a href="#what-is-minimum-availability" class="toc-anchor">¶</a> What is Minimum Availability

> For More Information on TMDB's Dates that impact the below Availabilities See [How Does Radarr Determine the Year of the Movie](#how-does-radarr-determine-the-year-of-a-movie)

- **Announced**: Radarr shall consider movies available as soon as they are added to Radarr. This option is not recommended.
- **In Cinemas**: Radarr shall consider movies available as soon as movies hit cinemas (Theatrical Date on TMDb) This option is not recommended.
- **Released**: Radarr shall consider movies available as soon as the Blu-Ray or streaming version is released (Digital and Physical dates on TMDb) This option is recommended and should be combined with an `Availability Delay` (Settings =\> Indexers) of `-14` or `-21` days.
  - If TMDb is not populated with a date, it is assumed 90 days after `Theatrical Date` (Oldest in theater's date) the movie is available in web or physical services.

## <a href="#how-are-possible-downloads-compared" class="toc-anchor">¶</a> How are possible downloads compared

> Generally Quality Trumps All. If you wish to have Quality not be the main priority - you can merge your qualities together. <a href="https://trash-guides.info/merge-quality" class="is-external-link">See TRaSH's Guide</a>

- The current logic <a href="https://github.com/Radarr/Radarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs" class="is-external-link">can always be found here</a>.

- As of 2022-01-23 the logic is as follows:

1.  Quality\*
2.  Custom Format Score
3.  Protocol (as configured in the relevant Delay Profile)
4.  Indexer Priority
5.  Indexer Flags
6.  Seeds/Peers (If Torrent)
7.  Age (If Usenet)
8.  Size

> This ranking applies to both releases that would be Quality and/or Custom Format upgrades.

> \*REPACKS and PROPERs are v2 of Qualities and thus rank above a non-repack of the same quality. <a href="/radarr/settings#file-management" class="is-internal-link is-valid-page">Set Media Management =&gt; File Management <code>Download Proper &amp; Repacks</code> "Do Not Prefer"</a> and use the <a href="https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repack-proper" class="is-external-link">Repack/Proper Custom Format</a>.

## <a href="#what-are-lists-and-what-can-they-do-for-me" class="toc-anchor">¶</a> What are Lists and what can they do for me

- Lists are a part of Radarr that allow you to follow a given list from various sources including Plex
- Lists are not intended to be an "add it now" functionality, but rather are an add movies in this list eventually functionality.
- Let's say that you follow a given list creator on Trakt/TMDb and really like their Marvel Cinematic Universe film section and want to watch every movie on their list. You look in your Radarr and realize that you do not have those movies. Well instead of searching one by one and adding those lists and then searching your indexers for those movies. You can do this all at once with a List. The Lists can be set to import all the movies on that curators list as well as be set to automatically assign a quality profile, automatically add, and automatically monitor that movie.
- Lists can also be used to sync Radarr to another Radarr instance or to import your users' Plex watchlist(s)

> **CAUTION:** If done improperly lists can wreak havoc on your library by adding many movies you have no intention of watching. Make certain you are familiar with the list before you click save.

- It's suggested that you physically look at the list before you even go to Radarr.

### <a href="#why-are-lists-sync-times-so-long-and-can-i-change-it" class="toc-anchor">¶</a> Why are lists sync times so long and can I change it

- Lists never were nor are intended to be `add it now` they are `hey i want this, add it eventually` tools
- You can trigger a list refresh manually by testing it, add the movies to Radarr, use Ombi, Petio, Overseer, or any similar app that adds them right away
- This restriction is to not have our server and list providers get killed by people updating lists every 10 minutes.
- In Radarr pre-v4.7 interval can be configured in <a href="/radarr/settings#lists" class="is-internal-link is-valid-page">Settings =&gt; Lists</a> for between 6-24 hours. The default is 24 hours.
- In Radarr v4.7 these values are now hardcoded and not configurable. Times are based on the list type to minimize impact to third party services and allow Radarr's functionality with them to continue.

## <a href="#can-all-my-movie-files-be-stored-in-one-folder" class="toc-anchor">¶</a> Can all my movie files be stored in one folder

- No. Radarr is a fork of <a href="/sonarr" class="is-internal-link is-valid-page">Sonarr</a> and thus requires that each movie be stored in individual folders. It is **highly unlikely** a flat file structure would ever be supported due to substantial backend modifications required.
- The <a href="https://github.com/Radarr/Radarr/issues/153" class="is-external-link">Custom Folder GitHub Issue</a> addresses this request, but it is **unlikely** that it would allow all movie files to be housed in a single folder.
- For information on how to move your movies from a single folder to separate folders, refer to the <a href="/radarr/tips-and-tricks#creating-a-folder-for-each-movie" class="is-internal-link is-valid-page">Tips and Tricks Section =&gt; Create a Folder for Each Movie</a>.

## <a href="#can-i-put-all-my-movies-in-my-library-into-one-folder" class="toc-anchor">¶</a> Can I put all my movies in my library into one folder

- No, see above.

## <a href="#how-do-i-update-radarr" class="toc-anchor">¶</a> How do I update Radarr

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1.  Under the Updates section change the branch name to `master` or `develop`
2.  Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://radarr.servarr.com/v1/update/master/changes) - (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. This version will receive updates approximately monthly. On GitHub, this is the `master` branch.

- ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://radarr.servarr.com/v1/update/develop/changes) - (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first after nightly. It can be considered semi-stable, but is still `beta`. This version will receive updates either weekly or biweekly depending on development and will be tagged as `pre-release`.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is a snapshot of the `develop` branch at a specific point in time and is tagged as pre-release.

- ![Current Nightly/Unstable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://radarr.servarr.com/v1/update/nightly/changes) - (Alpha/Unstable) : This is the bleeding edge. It is released as soon as code is committed and passes all automated tests. This build may have not been used by us or other users yet. There is no guarantee that it will even run in some cases. This branch is only recommended for advanced users. Issues and self investigation are expected in this branch. ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is the `develop` branch.

- Note: If your install is through Docker append `:release`, `:latest`, `:testing`, or `:develop` to the end of your container tag depending on who makes your builds.

|                                                                                                        | ![Current Master/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://radarr.servarr.com/v1/update/master/changes) | ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://radarr.servarr.com/v1/update/develop/changes) | ![Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://radarr.servarr.com/v1/update/nightly/changes) |
|--------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://hotio.dev/containers/radarr" class="is-external-link">hotio</a>                       | `release`                                                                                                                                                                                        | `testing`                                                                                                                                                                                         | `nightly`                                                                                                                                                                                          |
| <a href="https://docs.linuxserver.io/images/docker-radarr" class="is-external-link">LinuxServer.io</a> | `latest`                                                                                                                                                                                         | `develop`                                                                                                                                                                                         | `nightly`                                                                                                                                                                                          |

### <a href="#can-i-update-radarr-inside-my-docker-container" class="toc-anchor">¶</a> Can I update Radarr inside my Docker container

- *Technically, yes.* **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

### <a href="#installing-a-newer-version" class="toc-anchor">¶</a> Installing a newer version

#### <a href="#native" class="toc-anchor">¶</a> Native

1.  Go to System and then the Updates tab
2.  Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

#### <a href="#docker" class="toc-anchor">¶</a> Docker

1.  Repull your tag and update your container

## <a href="#can-i-switch-from-nightly-back-to-develop" class="toc-anchor">¶</a> Can I switch from `nightly` back to `develop`

## <a href="#can-i-switch-between-branches" class="toc-anchor">¶</a> Can I switch between branches

- If version is identical you are able to switch, otherwise check with the development team to see if you can switch from `nightly` to `master`; `nightly` to `develop`; or `develop` to `master` for your given build.
- Failure to follow these instructions may result in your Radarr becoming unusable or throwing errors. You have been warned. If the below errors are encountered then you are using a newer database with an older \*Arr version which is not supported. Upgrade \*Arr to the version you were previously on or newer.
  - Example Error Messages:
    - `Error parsing column 45 (Language=31 - Int64)`
    - `The DataMapper was unable to load the following field: 'Languages' value`
    - `ID does not match a known language Parameter name: id`
    - Other similar database errors around missing columns or tables.

## <a href="#how-do-i-backuprestore-radarr" class="toc-anchor">¶</a> How do I Backup/Restore Radarr

### <a href="#backing-up-radarr" class="toc-anchor">¶</a> Backing up Radarr

#### <a href="#using-built-in-backup" class="toc-anchor">¶</a> Using built-in backup

- Go to System =\> Backup in the Radarr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

#### <a href="#using-file-system-directly" class="toc-anchor">¶</a> Using file system directly

- Find the location of the AppData directory for Radarr
  - Via the Radarr UI go to System =\> About
  - <a href="/radarr/appdata-directory" class="is-internal-link is-valid-page">Radarr Appdata Directory</a>
- Stop Radarr - This will prevent the database from being corrupted
- Copy the contents to a safe location

### <a href="#restoring-from-backup" class="toc-anchor">¶</a> Restoring from Backup

> Restoring to an OS that uses different paths will not work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database or use <a href="https://github.com/Notifiarr/toolbarr" class="is-external-link">Toolbarr</a>.

#### <a href="#using-zip-backup" class="toc-anchor">¶</a> Using zip backup

- Re-install Radarr (if applicable / not already installed)
- Run Radarr
- Navigate to System =\> Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

#### <a href="#using-file-system-backup" class="toc-anchor">¶</a> Using file system backup

- Re-install Radarr (if applicable / not already installed)
- Find the location of the AppData directory for Radarr
  - Running Radarr once and via the UI go to System =\> About
  - <a href="/radarr/appdata-directory" class="is-internal-link is-valid-page">Radarr Appdata Directory</a>
- Stop Radarr
- Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
- Restore from your backup
- Start Radarr
- As long as the paths are the same, everything will pick up where it left off

#### <a href="#file-system-restore-on-synology-nas" class="toc-anchor">¶</a> File System Restore on Synology NAS

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.

- Re-install Radarr (if applicable / not already installed)
- Find the location of the AppData directory for Radarr
  - Running Radarr once and via the UI go to System =\> About
  - <a href="/radarr/appdata-directory" class="is-internal-link is-valid-page">Radarr Appdata Directory</a>
- Stop Radarr
- Connect to the Synology NAS through SSH and log in as root

> On some installations, the user is different than the below commands: `chown -R sc-Radarr:Radarr *`

- Execute the following commands:

  ``` prismjs
      rm -r /usr/local/Radarr/var/.config/Radarr/Radarr.db
      cp -f /tmp/Radarr_backup/* /usr/local/Radarr/var/.config/Radarr/
  ```

- Update permissions on the files:

  ``` prismjs
      cd /usr/local/Radarr/var/.config/Radarr/
      chown -R Radarr:users *
      chmod -R 0644 *
  ```

- Start Radarr

# <a href="#radarr-common-problems" class="toc-anchor">¶</a> Radarr Common Problems

## <a href="#a-task-was-canceled" class="toc-anchor">¶</a> A Task was Canceled

- Radarr received no response from the server the request was made to after 100 seconds.
- Logs will contain `System.Threading.Tasks.TaskCanceledException: A task was canceled.`
- This is often caused by:
  - improperly configured or use of a VPN
  - improperly configured or use of a proxy
  - local DNS issues - Try changing to a different DNS provider
  - local IPv6 issues - *most common* - typically IPv6 is enabled on the host system, but non-functional
  - the use of Privoxy and it being improperly configured
  - PiHole <a href="https://docs.pi-hole.net/ftldns/configfile/#rate_limit" class="is-external-link">Rate Limiting</a> requests
- You can troubleshoot with DNS `nslookup <domain.tld from trace logs>` and ipv6 with `curl -sv -6 "<url from trace logs>"` / all other connectivity with `curl -sv -4 "<url from trace logs>"`

## <a href="#path-is-already-configured-for-an-existing-movie" class="toc-anchor">¶</a> Path is Already Configured for an Existing Movie

![existing-movie.png](/assets/radarr/existing-movie.png)

- Library Import shows "Existing" or you get an error of "Path is configured for an existing movie"
- This occurs when trying to add a movie or edit an existing movie's path that already is assigned to a different movie.
- Likely this was caused by not correcting a mismatched movie when the user imported their library.
- Locate and correct the movie that is already assigned to that movie's path.
  - Movie Index
  - Table View
  - Options =\> Add path as a column
  - Sort and find the movie at the noted problematic path.
- Alternatively, delete the movie using the existing path from Radarr

## <a href="#how-can-i-rename-my-movie-folders" class="toc-anchor">¶</a> How can I rename my movie folders

> The same process applies for moving/changing Movie paths as well. If you're just updating paths in Radarr and do not need to move the files, then do not select "Yes Move files" in Step 5.

1.  Movies
2.  Click on "Edit Movies"
3.  Select what movies need their folder renamed
4.  Click on "Edit"
5.  Change Root Folder to the same Root Folder that the movies currently exist in
6.  Select "Yes, move the files"

> If you are using Plex, this will trigger re-detection of intros, thumbnails, chapters, and preview metadata.

## <a href="#movie-file-and-folder-naming" class="toc-anchor">¶</a> Movie File and Folder Naming

- Currently, Radarr requires that each movie be in a folder with the format containing at minimum `Movie Title (Year)/`, optionally `_` or `.` are valid separators. To facilitate correct quality and resolution identification during import, a file name like `Movie Title (Year) [Quality-Resolution].ext` is best, again `_` or `.` are valid separators too.

  - A useful tool for making these changes to your collection is <a href="http://www.filebot.net/#download" class="is-external-link">filebot</a> which has paid version in both the Apple and Windows stores, but can be found for free on their legacy <a href="https://sourceforge.net/projects/filebot/files/latest/download" class="is-external-link">SourceForge</a> site. It has both a GUI and CLI, so you can use whatever you’re comfortable with. For the above example, `{ny}` expands to `Name (Year)` and `{vf}` gives the resolution like `1080p`. There is nothing to infer quality, so you can fake it using `{ny}/{ny} [{dim[0] >= 1280 ? 'Bluray' : 'DVD'}-{vf}]` which will name anything lower than 720p to `[DVD-572p]` and greater or equal to 720p like `[Bluray-1080p]`.

- See <a href="/radarr/faq" class="is-internal-link is-valid-page">Tips and Tricks Section =&gt; Create a Folder for Each Movie</a>radarr/tips-and-tricks#creating-a-folder-for-each-movie) for more details.

## <a href="#movie-folders-named-incorrectly" class="toc-anchor">¶</a> Movie Folders Named Incorrectly

- Movie Folder naming is based on the metadata (name/year) at the time the movie was added. If you added a movie before it was released, you may need to use the rename folder trick noted above to update the movie folded naming to reflect the new current data.

- Even if your movies are in folders already, the folders may not be named correctly. The folder name should be `Movie Title (Year)`, having the title and year in the folder’s name is critical right now.

  - Examples that will work well:
    - `/mnt/Movies/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - `/mnt/Kid Movies/Frozen (2013)/Frozen (2013) [Bluray-1080p].mkv`
  - Examples that will work, but will require manual management:
    - By letters: `/mnt/Movies/A-D/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - By rating: `/mnt/Movies/R/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - By genre: `/mnt/Movies/Crime, Drama, Sci-Fi/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - These examples will require manual management when the movie is added. Each of the examples will have many root directories, like `A-D` and `E-G` in the first letter example, `R` and `PG-13` in the rating example and you can guess at the variety of genre folders. When adding a new movie, the correct base folder will need to be selected for this format to work.
  - Examples that won’t work:
    - Single folder: `/mnt/Kid Movies/Frozen (2013) [Bluray-1080p].mkv`
      - At this time, movies simply have to be in a folder named after the movie. There is no way around this until development work is done to add this feature.
    - **Movie** Folder Naming Formats from v0.2 that include **File** properties in the **movie folder** name such as `` {Movie.Title}.{Release Year}.{Quality.Full}-{MediaInfo.Simple}{`Release.Group} `` will not work in v3.
      - Folders are related to the movie and independent of the file. Additionally, this will break with the planned multiple files per movie support.
      - The other reason it was removed was it caused frequent confusion, database corruption, and generally was only half baked.
  - The <a href="/radarr/tips-and-tricks#creating-a-folder-for-each-movie" class="is-internal-link is-valid-page">Tips and Tricks Section =&gt; Create a Folder for Each Movie</a> is a great source for making sure your file and folder structure will work great.

## <a href="#can-i-disable-the-refresh-movies-task" class="toc-anchor">¶</a> Can I disable the refresh movies task

- No, nor should you through any SQL hackery. The refresh movies task queries the upstream Servarr proxy and checks to see if the metadata for each movie (ids, cast, summary, rating, translations, alt titles, etc.) has updated compared to what is currently in Radarr. If necessary, it will then update the applicable movies.
- A common complaint is the Refresh task causes heavy I/O usage.
- The main setting is "Rescan Movie Folder after Refresh". If your disk I/O usage spikes during a Refresh then you may want to change the Rescan setting to `Manual`.
  - Do not change this to `Never` unless all changes to your library (new movies, upgrades, deletions etc) are done through Radarr.
  - If you delete movie files manually or via Plex or another third party program, do not set this to `Never`.
- The other setting that can be changed is "Analyze video files" which is advised to be enabled if you use tdarr or otherwise externally modify your files. If you do not you can safely disable "Analyze video files" to reduce some I/O.

## <a href="#found-matching-movie-via-grab-history-but-release-was-matched-to-movie-by-id-manual-import-required" class="toc-anchor">¶</a> Found matching movie via grab history, but release was matched to movie by ID. Manual Import required

When you this error, it is because Radarr asked your indexer for a tmdbid or imdbid, and your indexer returned this movie. However, the movie name is not an exact match for the movie in Radarr, so it will require you to validate that it's actually the thing you want and manually import it.

This could be because your indexer poorly matched it, or the uploader didn't name it quite right. If it's the wrong movie, you should report this bad match to the indexer the release was grabbed from.

## <a href="#how-do-i-request-a-feature-for-radarr" class="toc-anchor">¶</a> How do I request a feature for Radarr

- This is an easy one <a href="https://github.com/Radarr/Radarr/issues" class="is-external-link">visit the Radarr GitHub issues page</a>

## <a href="#help-my-mac-says-radarr-cannot-be-opened-because-the-developer-cannot-be-verified" class="toc-anchor">¶</a> Help, My Mac says Radarr cannot be opened because the developer cannot be verified

- This is simple, please see this link for more information <a href="https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac" class="is-external-link">in the Mac help documentation</a> ![Developer Cannot be verified](developer-cannot-be-verified.png "Developer Cannot be verified")
- Alternatively, you may need to self-sign Radarr `codesign --force --deep -s - /Applications/Radarr.app && xattr -rd com.apple.quarantine`

## <a href="#help-my-mac-says-radarrapp-is-damaged-and-cant-be-opened" class="toc-anchor">¶</a> Help, My Mac says Radarr.app is damaged and can’t be opened

- That is either due to a corrupt download so try again or [security issues, please see this related FAQ entry.](#help-my-mac-says-radarr-cannot-be-opened-because-the-developer-cannot-be-verified)

## <a href="#i-am-getting-an-error-database-disk-image-is-malformed" class="toc-anchor">¶</a> I am getting an error: Database disk image is malformed

- **Errors of `Error creating log database` indicate issues with logs.db**
  - This can quickly be resolved by renaming or removing the database. The logs database contains unimportant information regarding commands history and update install history, and Info, Warn, and Error entries
- **Errors of `Error creating main database` or generic `database disk image is malformed` with no specified database indicate issues with radarr.db**
  - Continue with the steps noted below
- This means your SQLite database that stores most of the information for Radarr is corrupt. Your options are to try (a) backup(s), try recovering the existing database, try recovering the backup(s), or if all else fails starting over with a fresh new database.
- This error may show if the database file is not writable by the user/group \*Arr is running as. Permissions being the cause will likely only be an issue for new installs, migrated installs to a new server, if you recently modified your appdata directory permissions, or if you changed the user and group \*Arr run as.
- Your best and first option is to [try restoring from a backup](#how-do-i-backuprestore-my-radarr). However, for users receiving this after upgrading to v4 it is highly unlikely the backup itself will work and you'll need to try the other recovery methods mentioned.
- You can also try recovering your database. This is typically the only option for when this issue occurs after an update. Try the <a href="/useful-tools#recovering-a-corrupt-db" class="is-internal-link is-valid-page">sqlite3 <code>.recover</code> command</a>
  - If your sqlite does not have `.recover` or you wish a more GUI (i.e. Windows) friendly way then follow <a href="/useful-tools#recovering-a-corrupt-db-ui" class="is-internal-link is-valid-page">our instructions on this wiki.</a>
- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). **SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. <a href="https://www.sqlite.org/draft/useovernet.html" class="is-external-link">SQLite and network drives not play nice together and will cause a malformed database eventually</a>.
- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS <a href="https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs" class="is-external-link">docs here</a>

## <a href="#i-use-radarr-on-a-mac-and-it-suddenly-stopped-working-what-happened" class="toc-anchor">¶</a> I use Radarr on a Mac and it suddenly stopped working. What happened

- Most likely this is due to a MacOS bug which caused one of the databases to be corrupted.
- See the above database is malformed entry.
- Then attempt to launch and see if it works. If it does not work, you will need further support. Post in our <a href="http://reddit.com/r/radarr" class="is-external-link">subreddit /r/radarr</a> or hop on <a href="https://radarr.video/discord" class="is-external-link">our discord</a> for help.

## <a href="#radarr-wont-start-on-debian-11-or-older-systems-due-to-sqlite-version" class="toc-anchor">¶</a> Radarr won't start on Debian 11 or older systems due to SQLite version

> This workaround is only for older end-of-standard-support systems with outdated GLIBC/SQLite versions. This is not applicable to systems with SQLite corruption issues.

Radarr v6+ uses SQLite from SourceGear.sqlite3, which requires newer GLIBC versions and may cause compatibility issues on older end-of-standard-support systems including Debian 10, Debian 11, Synology DSM, Ubuntu 18, and Ubuntu 20. If you encounter SQLite-related errors (not corruption) on these platforms, you can force Radarr to use your system's native SQLite library instead, which is compatible with your GLIBC version.

### <a href="#solution" class="toc-anchor">¶</a> Solution

Create a symlink from your system's SQLite library to the expected library name in Radarr's directory:

``` prismjs
# First, ensure libsqlite3-0 is installed (not just sqlite3)
sudo apt update
sudo apt install libsqlite3-0

# Navigate to Radarr installation directory
cd /opt/Radarr/

# Backup the original bundled library
mv libe_sqlite3.so libe_sqlite3.so.backup 2>/dev/null || true

# Create symlink to system SQLite library
# The path varies by architecture:
# - amd64/x64: /usr/lib/x86_64-linux-gnu/libsqlite3.so.0
# - arm64: /usr/lib/aarch64-linux-gnu/libsqlite3.so.0
# - armhf: /usr/lib/arm-linux-gnueabihf/libsqlite3.so.0

# For amd64 systems (most common):
ln -s /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 libe_sqlite3.so

# For arm64 systems:
# ln -s /usr/lib/aarch64-linux-gnu/libsqlite3.so.0 libe_sqlite3.so

# For armhf systems:
# ln -s /usr/lib/arm-linux-gnueabihf/libsqlite3.so.0 libe_sqlite3.so

# Verify the symlink was created
ls -la libe_sqlite3.so
```

After creating the symlink, restart Radarr. It will now use the system's SQLite library which is compatible with your GLIBC version.

> **Note:** You will need to recreate this symlink after each Radarr update, as updates replace the application directory contents.

### <a href="#when-to-use-this-workaround" class="toc-anchor">¶</a> When to use this workaround

- You're running an older end-of-life system (Debian 10, Debian 11, Synology DSM, Ubuntu 18, or Ubuntu 20)
- Radarr fails to start with SQLite initialization errors
- The error is **not** related to database corruption
- Your system's SQLite version is at least 3.9.0

### <a href="#when-not-to-use-this-workaround" class="toc-anchor">¶</a> When NOT to use this workaround

- You have a database corruption issue (see the section above instead)
- You're on a modern, supported Linux distribution
- Radarr starts normally

## <a href="#why-can-radarr-not-see-my-files-on-a-remote-server" class="toc-anchor">¶</a> Why can Radarr not see my files on a remote server

- For all OSes ensure the user/group you're running \*Arr as has read and write access to the mounted drive.
- For Linux ensure:
  - If you're using an NFS mount ensure `nolock` is enabled for your mount.
  - If you're using an SMB mount ensure `nobrl` is enabled for your mount.
- For Windows: In short: the user \*Arr is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is \*Arr is running as a service, which causes the issues described below.

### <a href="#radarr-runs-under-the-localservice-account-by-default-which-doesnt-have-access-to-protected-remote-file-shares" class="toc-anchor">¶</a> Radarr runs under the LocalService account by default which doesn't have access to protected remote file shares

- Run Radarr's service as another user that has access to that share
- Open the Administrative Tools \> Services window on your Windows server.
- Stop the Radarr service.
- Open the Properties \> Log On dialog.
- Change the service user account to the target user account.
- Run Radarr.exe using the Startup Folder

### <a href="#youre-using-a-mapped-network-drive-not-a-unc-path" class="toc-anchor">¶</a> You're using a mapped network drive (not a UNC path)

- Change your paths to UNC paths (`\\server\share`)
- Run Radarr.exe via the Startup Folder

## <a href="#how-do-i-change-from-the-windows-service-to-a-tray-app" class="toc-anchor">¶</a> How do I change from the Windows Service to a Tray App

1.  Shut down Radarr
2.  Run serviceuninstall.exe that's in the Radarr directory
3.  Run `Radarr.exe` as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
4.  (Optional) Drop a shortcut to .exe in the startup folder to auto-start on boot.

## <a href="#help-i-have-locked-myself-out" class="toc-anchor">¶</a> Help I have locked myself out

To disable authentication (to reset your forgotten username or password) you will need need to edit `config.xml` which will be inside the <a href="/radarr/appdata-directory" class="is-internal-link is-valid-page">Radarr Appdata Directory</a>

1.  Stop Radarr
2.  Open config.xml in a text editor
3.  Find the authentication method line - will be  
    `<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`  
    ***(Be sure you do not have two AuthenticationMethod entries in your file!)***
4.  Remove the entire `AuthenticationMethod` line
5.  Start Radarr
6.  Radarr will now be accessible without a password. When you open the Web UI, you should be prompted to set a new password and authentication method

## <a href="#how-do-i-stop-the-browser-from-launching-on-startup" class="toc-anchor">¶</a> How do I stop the browser from launching on startup

Depending on your OS, there are multiple possible ways.

- In `Settings` =\> `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Radarr, you can add `-nobrowser` (\*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Radarr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.

## <a href="#weird-ui-issues" class="toc-anchor">¶</a> Weird UI Issues

- If you experience any weird UI issues like the Library page not listing anything or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the <a href="/useful-tools#clearing-cookies-and-local-storage" class="is-internal-link is-valid-page">Clear Cache Cookies and Local Storage</a> wiki article.

## <a href="#web-interface-only-loads-at-localhost-on-windows" class="toc-anchor">¶</a> Web Interface Only Loads at localhost on Windows

- If you can only reach your web interface at <a href="http://localhost:7878/" class="is-external-link">http://localhost:7878/</a> or <a href="http://127.0.0.1:7878/" class="is-external-link">http://127.0.0.1:7878/</a>, you need to run as administrator at least once.

## <a href="#permissions" class="toc-anchor">¶</a> Permissions

- Radarr will need to move files away from where the downloader puts them into the final location, so this means that will need to read/write to both the source and the destination directory and files.
- On Linux, where best practices have services running as their own user, this will probably mean using a shared group and setting folder permissions to `775` and files to `664` both in your downloader and . In umask notation, that would be `002`.

## <a href="#system-logs-loads-forever" class="toc-anchor">¶</a> System & Logs loads forever

- It's the easy-privacy blocklist. They basically block any url with /api/log? in it. Look over the list and tell me if you think that blocking all the urls in that list is a sensible idea, there are dozens of urls in there that potentially break sites. You selected that in your adblocker. Easy solution is to whitelist the domain Radarr is running on. But I still recommend checking the list.

## <a href="#unpack-torrents" class="toc-anchor">¶</a> Unpack Torrents

- Most torrent clients doesn’t come with the automatic handling of compressed archives like their usenet counterparts. We recommend <a href="https://github.com/unpackerr/unpackerr" class="is-external-link">unpackerr</a>.

## <a href="#i-got-a-pop-up-that-said-configxml-was-corrupt-what-now" class="toc-anchor">¶</a> I got a pop-up that said config.xml was corrupt, what now

- Radarr was unable to read your config file on start-up as it became corrupted somehow. In order to get back online, you will need to delete `.xml` in your <a href="/radarr/appdata-directory" class="is-internal-link is-valid-page">appdata-directory</a>, once deleted start and it will start on the default port (7878), you should now re-configure any settings you configured on the General Settings page.

## <a href="#invalid-certificate-and-other-https-or-ssl-issues" class="toc-anchor">¶</a> Invalid Certificate and other HTTPS or SSL issues

- Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?
  - Radarr validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then will refuse to connect. Free properly signed certificates are available from <a href="https://letsencrypt.org/" class="is-external-link">let's encrypt</a>.
  - If your download client and are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## <a href="#vpns-jackett-and-the-arrs" class="toc-anchor">¶</a> VPNs, Jackett, and the \*ARRs

> For comprehensive VPN guidance, see the dedicated <a href="/vpn" class="is-internal-link is-valid-page">VPN Guide</a> page.

- Unless you're in a repressive country like China, Australia or the UK, your BitTorrent client is typically the only thing that needs to be behind a VPN. Usenet does not require VPN protection as it uses encrypted SSL connections. If you're in a repressive country noted above it is likely your connection to your trackers needs to be VPN'd as well - in other words Jackett behind a VPN or Prowlarr using an Indexer Proxy. Other \*Arr apps not connecting to trackers should not be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.
- In other words, putting the \*Arrs (Lidarr, Prowlarr, Radarr, Readarr, and Sonarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible.

> **To be clear it is not a matter if VPNs will cause issues with the \*Arrs, but when: image providers will block you and cloudflare is in front of most of \*Arr servers (updates, metadata, etc.) and liable to block you too**

- **Many private trackers will ban you for using or accessing them (i.e. using Jackett or Prowlarr) via a VPN.**

### <a href="#use-of-a-vpn" class="toc-anchor">¶</a> Use of a VPN

- If a VPN is required and Docker is used it is recommended to use Hotio or Binhex's Download Client + VPN Containers.
- If a VPN is required and Docker is not used your VPN client ***must*** support split tunneling so only the required (Download Client) apps are behind the VPN.
- Many issues with accessing trackers can be resolved by using Google or Cloudflare's DNS servers in lieu of your ISP's DNS servers.
- In some cases (i.e. UK ISPs) you may need to put your torrent download client behind a VPN and Jackett/Prowlarr as follows:
  - put Jackett behind the VPN and ensure split tunneling allows local access
  - for Prowlarr configure your vpn client to provide a proxy and add the proxy in Settings =\> Indexers. Give the proxy a tag and any indexers that need to use it the same tag.
    - If absolutely required and if your vpn does not provide a way to create a proxy you may put Prowlarr behind the VPN and ensure split tunneling allows local access.

# <a href="#radarr-searching-downloading-common-problems" class="toc-anchor">¶</a> Radarr Searching & Downloading Common Problems

## <a href="#why-can-i-not-add-a-new-movie-to-radarr" class="toc-anchor">¶</a> Why can I not add a new movie to Radarr

- Radarr uses <a href="http://themoviedb.org" class="is-external-link">The Movie Database (TMDb)</a> for movie information and images like fanart, banners and backgrounds. Generally, there are a few reasons why you may not be able to add a movie:
  - TMDb doesn't like special characters to be used when searching for movies through the API (which Radarr uses), so try searching a translated name, and/or without special characters.
  - You can also add by TMDb ID or, if TMDb has it, the IMDb ID
  - The movie hasn't been added to TMDb yet, follow their <a href="https://www.themoviedb.org/bible/new_content#59f7933c9251413e93000006" class="is-external-link">guide</a> to get it added.

## <a href="#what-is-this-new-override-and-add-to-download-queue-button" class="toc-anchor">¶</a> What is this new "*Override and add to download queue*" button

When doing an interactive search a second download button has been added titled "Override and add to download queue". This button enables you to do two things:

- Choose which download client the download is sent to. This is useful in the case that you have multiple download clients for the same protocol (e.g. multiple instances of a torrent client) instead of letting Radarr decide which client to use.
- Override Radarr's parsing of the release title in case Radarr has parsed it incorrectly or Radarr was unable to parse it, but you still want to grab the release. The following parsed fields can be overruled:
  - Movie
  - Quality
  - Language
- *Note that this overruled information is not carried over to the import logic and manual imports may be required*

## <a href="#jackett-shows-more-results-than-when-manually-searching" class="toc-anchor">¶</a> Jackett shows more results than when manually searching

- This is usually due to searching Jackett differently than you do. See our <a href="/radarr/troubleshooting" class="is-internal-link is-valid-page">troubleshooting article</a> for more information.

## <a href="#how-does-radarr-determine-the-year-of-a-movie" class="toc-anchor">¶</a> How does Radarr determine the year of a movie

- Radarr gets metadata from <a href="https://www.themoviedb.org/" class="is-external-link">TMDb</a>
- Radarr uses the year of the oldest **Theatrical Release** date for primary purposes and the oldest **Premier** date as secondary only for matching.
  - Note that if a Theatrical Release does not exist then the logic will fall back to the oldest physical or digital release date.
- If a movie is missing a digital, physical, theatrical, or premier release date then TMDb should be updated.
- <a href="https://www.themoviedb.org/bible/movie/59f3b16d9251414f20000009#59f73d3c9251416e71000013" class="is-external-link">TMDb's Contribution Bible</a> notes the following about their release types.
  - **Premiere** - A premiere screening can take the form of a festival screening (e.g. TIFF) or a premiere event filled with the cast and crew in a big city (e.g. LA, London, Toronto).
  - **Theatrical** - Can be used for the original release and any subsequent official releases. Used for wide or saturation releases. In the United States, 600-1,999 screens is considered a wide release and 2000+ is considered a saturation release.
  - **Theatrical (limited)** - Limited theatrical release is a film distribution strategy of releasing a new film in a few theaters across a country, typically in major metropolitan markets. In the United States, the number of theaters is fewer than 600.
  - **Physical** - Includes all VHS, DVD and Blu-ray releases.
  - **Digital** - All and any relevant releases can be added including streaming platforms, VOD rental or purchase. Digital screenings including online film festivals and virtual cinema releases also count as digital releases.

## <a href="#how-does-radarr-handle-foreign-movies-or-foreign-titles" class="toc-anchor">¶</a> How does Radarr handle foreign movies or foreign titles

> <a href="https://trash-guides.info/Radarr/Tips/How-to-setup-language-custom-formats/#how-to-setup-language-custom-formats" class="is-external-link">TRaSH's Custom Format Language Guide</a> may be useful for helping get movies in the language(s) you want.

> Radarr's metadata cache considers a Movie's Original Language to be the TMDb Spoken Language if and only if only one (1) spoken language exists for the movie on TMDb; otherwise the movie's original TMDb language will be used.\*

- *\*the <a href="https://www.themoviedb.org/talk/646c7179a5046e00e5b7cd4c#647239a9dd731b00ddf07fd1" class="is-external-link">original language field should contain the main language spoken by the production companies.</a>*

## <a href="#id-searches" class="toc-anchor">¶</a> ID Searches

- **Indexers supporting ID based Searches** - Searches on indexers and trackers that support ID (TMDbId, IMDbId, etc.) based searches - such as many Usenet indexers and many private Torrent trackers - text queries are not used if results are returned for an ID based search. If results are returned will not fallback to a name/text search. If you're missing results from your indexer then this is due to them having the release(s) associated with the incorrect movie id.
  - Language of the release may also be derived from the indexer or trackers release's language in the result if provided rather than parsed from the name

## <a href="#text-searches" class="toc-anchor">¶</a> Text Searches

- **Indexers not supporting id based searches or id based searches with no results** - Search on will use the Movie's Original Title, English Title, and Translated Title from whatever languages you have preferred in the movie's quality profile and <a href="https://trash-guides.info/Radarr/Tips/How-to-setup-language-custom-formats/" class="is-external-link">any custom formats with scores in the quality profile greater than zero</a>.
- Parsing (i.e. importing) looks for a match in all Translations and Alternative Titles.
  - Language of the release may also be derived from the indexer or trackers release's language in the result if provided rather than parsed from the name

## <a href="#getting-foreign-movies" class="toc-anchor">¶</a> Getting Foreign Movies

- To get a movie in a foreign language set your movie's Quality Profile Language to Original (Movie's Original Language\*), a specific language for that profile, or `Any`, then to determine which language to grab, create Custom Formats with Language Conditions and give them a score greater than 0. - <a href="https://trash-guides.info/Radarr/Tips/How-to-setup-language-custom-formats/" class="is-external-link">see the linked TRaSH's Guide for details</a>.
- Note that this does not include any indexer languages configured in the indexer's settings as `multi`.
  - Note that starting with <a href="https://github.com/Radarr/Radarr/commit/ad8629fac981217f5a4a5068da968c29d9ee634c" class="is-external-link">Radarr v4.1</a> of Radarr `multi` is no longer assumed to include English
  - Users can adjust their Settings per Indexer to define what language(s) `multi` indicates

## <a href="#how-does-radarr-handle-multi-in-names" class="toc-anchor">¶</a> How does Radarr handle "multi" in names

- With Radarr v4.1+, Radarr assumes  
  `multi` is only the movie's language and **NOT** English as in previous versions.
  - Users can adjust their Settings per Indexer to define what language(s) `multi` indicates
- Note that `multi` definitions only help for release parsing and not for foreign titles or movies searches.

## <a href="#help-movie-added-but-not-searched" class="toc-anchor">¶</a> Help, Movie Added, But Not Searched

- Radarr does not *actively* search for missing movies automatically. Instead, a periodic query of new posts is made to all indexers configured for RSS. When a wanted or cutoff unmet movie shows up in that list, it gets downloaded. This means that until a movie is posted (or reposted), it won’t get downloaded.

- If you’re adding a movie that you want now, the best option is to check the “Start search for missing movie” box, to the left of the *Add Movie* (**1**) button. You can also go to the page for a movie you’ve added and click the magnifying glass “Search” (**2**) button or use the Wanted view to search for Missing or Cutoff Unmet movies.

  - Add and Search for Movie when adding a movie  
    ![addmovie-add-and-search.png](/assets/radarr/addmovie-add-and-search.png)
  - Search an existing Movie  
    ![searchmovie-movie-page.png](/assets/radarr/searchmovie-movie-page.png)

## <a href="#jacketts-all-endpoint" class="toc-anchor">¶</a> Jackett's /all Endpoint

- The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is required. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a>

- **January 1 2022 Update: Jackett `/all` endpoint is no longer supported (e.g. warnings will occur) as of 4.0.0.5730 due to the fact it only causes issues.**

- The Jackett /all endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is now required.

- <a href="https://github.com/Jackett/Jackett#aggregate-indexers" class="is-external-link">Even Jackett's Devs says it should be avoided and should not be used.</a>

- Using the /all endpoint has no advantages, only disadvantages:

  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - indexer specific categories (\>= 100000) cannot be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000
  - if one of the trackers in /all returns an error, \*Arr will disable it and now you do not get any results.

### <a href="#jackett-all-solutions" class="toc-anchor">¶</a> Jackett /All Solutions

- Add each tracker in Jackett manually as an indexer in \*Arr
- Check out <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a> which can sync indexers to \*Arr and from the Lidarr/Radarr/Readarr development team.
- Check out <a href="https://github.com/theotherp/nzbhydra2" class="is-external-link">NZBHydra2</a> which can sync indexers to \*Arr. But do not use their single aggregate endpoint and use `multi` if sync will be used.

## <a href="#why-are-there-two-files-why-is-there-a-file-left-in-downloads" class="toc-anchor">¶</a> Why are there two files? \| Why is there a file left in downloads

This is expected. With a setup that supports <a href="https://trash-guides.info/hardlinks" class="is-external-link">hardlinks</a>, double space will not be used. Below is how the Torrent Process works.

1.  Radarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
2.  Radarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
3.  Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlinkthe file if supported by your setup or copy if not hard links are not supported.
4.  If the "Completed Download Handling - Remove Completed" option is enabled in Radarr's settings, Radarr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped (i.e. paused). See <a href="https://trash-guides.info/Downloaders/" class="is-external-link">TRaSH's Download Client Guides</a> for how to configure your download client optimally.

> Hard links are enabled by default. <a href="https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/" class="is-external-link">A hard link will allow not use any additional disk space.</a> The file system and mounts must be the same for your completed download directory and your media library. If the hard link creation fails or your setup does not support hard links then will fall back and copy the file.

## <a href="#why-doesnt-radarr-work-behind-a-reverse-proxy" class="toc-anchor">¶</a> Why doesn't Radarr work behind a reverse proxy

- Starting with v3 Radarr has switched to .NET and a new webserver. In order for SignalR to work, the UI buttons to work, database changes to take, and other items. It requires the following addition to the location block for Radarr:

``` prismjs
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection $http_connection;
```

- Make sure you **do not** include `proxy_set_header Connection "Upgrade";` as suggested by the nginx documentation. **THIS WILL NOT WORK**
- <a href="https://github.com/aspnet/AspNetCore/issues/17081" class="is-external-link">See this ASP.NET Core issue</a>
- If you are using a CDN like Cloudflare ensure websockets are enabled to allow websocket connections.
- If you have unexpected redirects, ensure your host header is being forwarded.


