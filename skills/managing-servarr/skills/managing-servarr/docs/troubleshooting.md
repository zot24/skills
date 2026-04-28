> Source: https://wiki.servarr.com/en/sonarr/troubleshooting



# <a href="#asking-for-help" class="toc-anchor">¶</a> Asking for Help

Do you need help? That's okay, everyone needs help sometimes. You can get help on

- <a href="https://discord.sonarr.tv/" class="is-external-link"><em></em> Discord <em>Official Sonarr Discord</em></a>
- <a href="https://forums.sonarr.tv/" class="is-external-link"><em></em> Reddit <em>Official Sonarr Forums</em></a>

But before you go there and post, be sure your request for help is the best it can be. Clearly describe the problem and briefly describe your setup, including things like your OS/distribution, version of .NET, version of Sonarr, download client and its version. **If you are using <a href="https://www.docker.com/" class="is-external-link">Docker</a> please run through <a href="/docker-guide" class="is-internal-link is-valid-page">Docker Guide</a> first as that will solve common and frequent path/permissions issues. Otherwise please have a <a href="/docker-guide#docker-compose" class="is-internal-link is-valid-page">docker compose</a> handy. <a href="https://trash-guides.info/compose" class="is-external-link">How to Generate a Docker Compose</a>** Tell us about what you've tried already, what you've looked at. Use the [Logging and Log Files section](#logging-and-log-files) to turn your logging up to trace, recreate the issue, pastebin the relevant context and include a link to it in your post. Maybe even include some screen shots to highlight the issue.

The more we know, the easier it is to help you.

> Please note we only support builds created by the Sonarr build platform

# <a href="#logging-and-log-files" class="toc-anchor">¶</a> Logging and Log Files

It is likely beneficial to also review the Common Troubleshooting problems:

- [Downloads and Importing Common Problems](#common-problems)
- [Searching Indexers and Trackers Common Problems](#common-problems-1)

If you're asked for debug logs your logs will contain `debug` and if you're asked for trace logs your logs will contain `trace`. If the logs you are providing do not contain either then they are not the logs requested.

- Avoid sharing the entire log file unless asked.
- Don't upload logs directly to Discord or paste them as walls of text, unless requested.
- Don't share the logs as an attachment, a zip archive, or anything other than text shared via the services noted below

To provide good and useful logs for sharing:

> Ensure a spammy task is NOT running such as an RSS refresh

1.  [Turn Logging up to Trace (Settings =\> General =\> Log Level or Edit The Config File)](#tracedebug-logs)
2.  [Clear Logs (System =\> Logs =\> Clear Logs or Delete all the Logs in the Log Folder)](#clearing-logs)
3.  Reproduce the Issue (Redo what is breaking things)
4.  [Open the trace log file (sonarr.trace.txt) via the UI or the log file](#standard-logs-location) on the filesystem and find the relevant context
5.  Copy a big chunk before the issue, the issue itself, and a big chunk after the issue.
6.  Use <a href="https://gist.github.com/" class="is-external-link">Gist</a>, <a href="https://0bin.net/" class="is-external-link">0bin (<strong>Be sure to disable colorization</strong>)</a>, <a href="https://privatebin.net/" class="is-external-link">PrivateBin</a>, <a href="http://logs.notifiarr.com/" class="is-external-link">Notifiarr PrivateBin</a>, <a href="https://hastebin.com/" class="is-external-link">Hastebin</a>, <a href="https://pastebin.ubuntu.com/" class="is-external-link">Ubuntu's Pastebin</a>, or similar sites - excluding those noted to avoid below - to share the copied logs from above

**Warnings:**

- **Do not use <a href="https://pastebin.com" class="is-external-link">pastebin.com</a> as their filters have a tendency to block the logs.**
- Do not use <a href="https://pastebin.pl" class="is-external-link">pastebin.pl</a> as their site is frequently not accessible.
- Do not use <a href="https://justpaste.it/" class="is-external-link">JustPasteIt</a> as their site does not facilitate reviewing logs.
- Do not upload your log as a file
- Do not upload and share your logs via Google Drive, Dropbox, or any other site not noted above.
- Do not archive (zip, tar (tarball), 7zip, etc.) your logs.
- Do not share console output, docker container output, or anything other than the application logs specified

**Important Note:**

- When using <a href="https://0bin.net/" class="is-external-link">0bin</a>, be sure to disable colorization and do not burn after reading.

- Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use N++. You can use the Notepad++ "Find in Files" function to search old log files as needed.

- **Unix Only:** Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use grep. For example if you want to find information about the movie/show/book/song/indexer "Shooter" you can run the following command `grep -inr -C 100 -e 'Shooter' /path/to/logs/*.trace*.txt` If your <a href="/sonarr/appdata-directory" class="is-internal-link is-valid-page">Appdata Directory</a> is in your home folder then you'd run: `grep -inr -C 100 -e 'Shooter' /home/$User/.config/logs/*.trace*.txt`

``` prismjs
    * The flags have the following functions
    * -i: ignore case
    * -n: show line number
    *  -r: recursively check all files in the path
    * -C: provide # of lines before and after the line it is found on
    * -e: the pattern to search for
```

## <a href="#standard-logs-location" class="toc-anchor">¶</a> Standard Logs Location

The log files are located in Sonarr's <a href="/sonarr/appdata-directory" class="is-internal-link is-valid-page">Appdata Directory</a>, inside the logs/ folder. You can also access the log files from the UI at System =\> Logs =\> Files.

> Note: The Logs ("Events") Table in the UI is not the same as the log files and isn't as useful. If you're asked for logs, please copy/paste from the log files and not the table.

## <a href="#update-logs-location" class="toc-anchor">¶</a> Update Logs Location

The update log files are located in Sonarr's <a href="/sonarr/appdata-directory" class="is-internal-link is-valid-page">Appdata Directory</a>, inside the UpdateLogs/ folder.

## <a href="#sharing-logs" class="toc-anchor">¶</a> Sharing Logs

The logs can be long and hard to read as part of a forum or Reddit post and they're spammy in Discord, so please use <a href="https://pastebin.ubuntu.com/" class="is-external-link">Pastebin</a>, <a href="https://hastebin.com/" class="is-external-link">Hastebin</a>, <a href="https://gist.github.com" class="is-external-link">Gist</a>, <a href="https://0bin.net" class="is-external-link">0bin</a>, or any other similar pastebin site. The whole file typically isn't needed, just a good amount of context from before and after the issue/error. Do not forget to wait for spammy tasks like an RSS sync or library refresh to finish.

## <a href="#tracedebug-logs" class="toc-anchor">¶</a> Trace/Debug Logs

You can change the log level at Settings =\> General =\> Logging. Sonarr does not need to restarted for the change to take effect. This change only affects the log files, not the logging database. The latest debug/trace log files are named `sonarr.debug.txt` and `sonarr.trace.txt` respectively.

If you're unable to access the UI to set the logging level you can do so by editing config.xml in the AppData directory by setting the LogLevel value to Debug or Trace instead of Info.

``` prismjs
 <Config>
  [...]
  <LogLevel>debug</LogLevel>
  [...]
 </Config>
```

## <a href="#clearing-logs" class="toc-anchor">¶</a> Clearing Logs

You can clear log files and the logs database directly from the UI, under System =\> Logs =\> Files and System =\> Logs =\> Delete (Trash Can Icon)

# <a href="#multiple-log-files" class="toc-anchor">¶</a> Multiple Log Files

Sonarr uses rolling log files limited to 1MB each. The current log file is always ,`sonarr.txt`, for the the other files `sonarr.0.txt` is the next newest (the higher the number the older it is). This log file contains `fatal`, `error`, `warn`, and `info` entries.

When Debug log level is enabled, additional `sonarr.debug.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It usually covers a 40h period.

When Trace log level is enabled, additional `sonarr.trace.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most.

# <a href="#recovering-from-a-failed-update" class="toc-anchor">¶</a> Recovering from a Failed Update

We do everything we can to prevent issues when upgrading, but if they do occur this will walk you through the steps to take to recover your installation.

## <a href="#determine-the-issue" class="toc-anchor">¶</a> Determine the issue

The best place to look when the application will not start after an update is to review the [update logs](#update-logs-location) and see if the update completed successfully. If those do not have an issue then the next step is to look at your regular application log files, before trying to start again, use <a href="/sonarr/settings#logging" class="is-internal-link is-valid-page">Logging</a> and <a href="/sonarr/system#log-files" class="is-internal-link is-valid-page">Log Files</a> to find them and increase the log level.

### <a href="#migration-issue" class="toc-anchor">¶</a> Migration Issue

- Migration errors will not be identical, but here is an example:

``` prismjs
14-2-4 18:56:49.5|Info|MigrationLogger|\*\*\* 36: update\_with\_quality\_converters migrating \*\*\*

14-2-4 18:56:49.6|Error|MigrationLogger|SQL logic error or missing database duplicate column name: Items

While Processing: "ALTER TABLE "QualityProfiles" ADD COLUMN "Items" TEXT"
```

### <a href="#permission-issue" class="toc-anchor">¶</a> Permission Issue

- Permissions issues are due to the application being unable to access the the relevant temporary folders and/or the app binary folder. Fix the permissions so the user/group the application runs as has the appropriate access.

- Synology users may encounter this Synology bug `Access to the path '/proc/{some number}/maps is denied`

- Synology users may also encounter being out of space in `/tmp` on certain NASes. You'll need to specify a different `/tmp` path for the app. See the SynoCommunity or other Synology support channels for help with this.

## <a href="#resolving-the-issue" class="toc-anchor">¶</a> Resolving the issue

In the event of a migration issue there is not much you can do immediately, if the issue is specific to you (or there are not yet any posts), please create a post on <a href="https://reddit.com/r/sonarr" class="is-external-link">our subreddit</a> or swing by our <a href="https://discord.sonarr.tv/" class="is-external-link">discord</a>, if there are others with the same issue, then rest assured we are working on it.

> Please ensure you did not try to use a database from `develop` on the stable version. Branch hopping is ill-advised.

### <a href="#permissions-issues" class="toc-anchor">¶</a> Permissions Issues

- Fix the permissions to ensure the user/group the application is running as can access (read and write) to both `/tmp` and the installation directory of the application.

- For Synology users experiencing issues with `/proc/###/maps` stopping Sonarr or the other \*Arr applications and updating should resolve this. This is an issue with the SynoCommunity package.

### <a href="#manually-upgrading" class="toc-anchor">¶</a> Manually upgrading

Grab the latest release from our website.

Install the update (.exe) or extract (.zip) the contents over your existing installation and re-run Sonarr as you normally would.

# <a href="#downloads-and-importing" class="toc-anchor">¶</a> Downloads and Importing

Downloading and importing is where *most* people experience issues. From a high level perspective, Sonarr needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even *bigger* variety of setups. This means that while there are some *common* setups, there isn’t one *right* setup and everyone’s setup can be a little different.

> **The first step is to turn logging up to Trace, see [Logging and Log Files](#logging-and-log-files) for details on adjusting logging and searching logs. You’ll then reproduce the issue and use the trace level logs from that time frame to examine the issue.**  
> If someone is helping you, put context from before/after in a <a href="https://0bin.net" class="is-external-link">pastebin</a>, <a href="https://gist.com" class="is-external-link">Gist</a>, or similar site to show them.  
> It doesn’t need to be the whole file and it shouldn’t *just* be the error. You should also reproduce the issue while tasks that spam the log file aren’t running.

When you reach out for help, be sure to read [asking for help](#asking-for-help) so that you can provide us with the details we’ll need.

## <a href="#testing-the-download-client" class="toc-anchor">¶</a> Testing the Download Client

Ensure your download client(s) are running. Start by testing the download client, if it doesn’t work you’ll be able to see details in the trace level logs. You should find a URL you can put into your browser and see if it works. It could be a connection problem, which could indicate a wrong ip, hostname, port or even a firewall blocking access. It might be obvious, like an authentication problem where you’ve gotten the username, password or apikey wrong.

## <a href="#testing-a-download" class="toc-anchor">¶</a> Testing a Download

Now we’ll try a download, pick an episode for a series and do a manual search. Pick one of those files and attempt to download it. Does it get sent to the download client? Does it end up with the correct category? Does it show up in Activity? Does it end up in the trace level logs during the **Check For Finished Download** tasks (Refresh Monitored Downloads and Process Monitored Downloads tasks) which runs roughly every minute? Does it get correctly parsed during that task? Does the queued up download have a reasonable name? Since searches by are by id on some indexers/trackers, it can queue one up with a name that it can’t recognize.

## <a href="#testing-an-import" class="toc-anchor">¶</a> Testing an Import

Import issues should almost always manifest as an item in Activity with an orange icon you can hover to see the error. If they’re not showing up in Activity, this is the issue you need to focus on first so go back and figure that out. Most import errors are *permissions* issues, remember that needs to be able to read and write in the download folder. Sometimes, permissions in the library folder can be at fault too, so be sure to check both.

Incorrect path issues are possible too, though less common in normal setups. The key to understanding path issues is knowing that gets the path to the download *from* the download client, via its API. This becomes a problem in more unique use cases, like the download client running on a different system (maybe even OS!). It can also occur in a Docker setup, when volumes are not done well. A remote path map is a good solution where you don’t have control, like a seedbox setup. On a Docker setup, fixing the paths is a better option.

## <a href="#common-problems" class="toc-anchor">¶</a> Common Problems

Below are some common problems.

### <a href="#one-or-more-episodes-expected-in-the-release-were-not-imported-or-missing" class="toc-anchor">¶</a> One or More Episodes expected in the release were not imported or missing

- If all episodes were imported then the most common cause is a Season Pack was downloaded, but does not contain all episodes in the season. Click the `X` to remove and ignore the release.
- For all other issues, one or more episodes were not able to be imported. Review the information in the UI and other common problems.

### <a href="#using-sonarr-v2" class="toc-anchor">¶</a> Using Sonarr v2

Sonarr v2 has been end of life and not supported since 3/2021. It is not compatible with qBittorrent v4.3.0 or newer. Upgrade to Sonarr v4

### <a href="#using-sonarr-v3" class="toc-anchor">¶</a> Using Sonarr v3

Sonarr v3 has been end of life since 1/2024. Upgrade to Sonarr v4.

### <a href="#download-clients-webui-is-not-enabled" class="toc-anchor">¶</a> Download Client's WebUI is not enabled

Sonarr talks to you download client via it's API and accesses it via the client's webui. You must ensure the client's webui is enabled and the port it is using does not conflict with any other client ports in use or ports in use on your system.

### <a href="#ssl-in-use-and-incorrectly-configured" class="toc-anchor">¶</a> SSL in use and incorrectly configured

Ensure SSL encryption is not turned on if you're using both your instance and your download client on a local network. See <a href="/sonarr/faq#invalid-certificate-and-other-HTTPS-or-SSL-issues" class="is-internal-link is-valid-page">the SSL FAQ entry</a> for more information.

### <a href="#cant-see-share-on-windows" class="toc-anchor">¶</a> Can’t see share on Windows

The default user for a Windows service is `LocalService` which typically doesn’t have access to your shares. Edit the service and set it up to run as your own user, see the FAQ entry <a href="/sonarr/faq#why-can-sonarr-not-see-my-files-on-a-remote-server" class="is-internal-link is-valid-page">why can’t Sonarr see my files on a remote server</a> for details.

### <a href="#mapped-network-drives-are-not-reliable" class="toc-anchor">¶</a> Mapped network drives are not reliable

While mapped network drives like `X:\` are convenient, they aren’t as reliable as UNC paths like `\\server\share` and they’re also not available before login. Setup and your download client(s) so that they use UNC paths as needed. If your library is on a share, you’d make sure your root folders are using UNC paths. If your download client sends to a share, that is where you’ll need to configure UNC paths since gets the download path from the download client. It is fine to keep your mapped network drives to use yourself, just don’t use them for automation.

### <a href="#docker-and-user-group-ownership-permissions-and-paths" class="toc-anchor">¶</a> Docker and user, group, ownership, permissions and paths

Docker adds another layer of complexity that is easy to get wrong, but still end up with a setup that functions, but has various problems. Instead of going over them here, read this wiki article <a href="/docker-guide" class="is-internal-link is-valid-page">for these automation software and Docker</a> which is all about user, group, ownership, permissions and paths. It isn’t specific to any Docker system, instead it goes over things at a high level so that you can implement them in your own environment.

### <a href="#remote-path-mapping" class="toc-anchor">¶</a> Remote Path Mapping

If you have Sonarr in Docker and the Download Client in non-Docker (or vice versa) or have the programs on different servers then you may need a remote path map.

Logs will look like

``` prismjs
2022-02-03 14:03:54.3|Error|DownloadedEpisodesImportService|Import failed, path does not exist or is not accessible by Sonarr: /volume3/data/torrents/tv/The.Orville.S03E08.1080p.WEB.H264-GGEZ[eztv]. Ensure the path exists and the user running Sonarr has the correct permissions to access this file/folder
```

Thus `/volume3/data` does not exist within Sonarr's container or is not accessible.

- <a href="/sonarr/settings#remote-path-mappings" class="is-internal-link is-valid-page">Settings =&gt; Download Clients =&gt; Remote Path Mappings</a>
- A remote path mapping is used when your download client is reporting a path for completed data either on another server or in a way that \*Arr doesn't address that folder.
- Generally, a remote path map is only required if your download client is on Linux when \*Arr is on Windows or vice versa. A remote path map is also possibly needed if mixing Docker and Native clients or if using a remote server.
- A remote path map is a DUMB search/replace (where it finds the REMOTE value, replace it with LOCAL value for the specified Host).
- If the error message about a bad path does not contain the REPLACED value, then the path mapping is not working as you expect. The typical solution is to add and remove the mapping.
- <a href="https://trash-guides.info/Radarr/Radarr-remote-path-mapping/" class="is-external-link">See TRaSH's Tutorial for additional information regarding remote path mapping</a>

> If both \*Arr and your Download Client are Docker Containers it is rare a remote path map is needed. It is suggested you <a href="/docker-guide" class="is-internal-link is-valid-page">review the Docker Guide</a> and/or <a href="https://trash-guides.info/hardlinks" class="is-external-link">follow TRaSH's Tutorial</a>

#### <a href="#remote-mount-or-remote-sync-syncthing" class="toc-anchor">¶</a> Remote Mount or Remote Sync (Syncthing)

- You need it to be syncing the whole time it is downloading. And you need that local sync destination to be able to be hard links when \*Arr import, which means same file system and look like it.
  - Sync at a lower, common folder that contains both incomplete and complete.
  - Sync to a location that is on the same file system locally as your library and looks like it (docker and network shares make this easy to misconfigure)
  - You want to sync the incomplete and complete so that when the torrent client does the move, that is reflected locally and all the files are already "there" (even if they're still downloading). Then you want to use hard links because even if it imports before its done, they'll still finish.
  - This way the whole time it downloads, it is syncing, then torrent client moves to tv sub-folder and sync reflects that. That way downloads are mostly there when declared finished. And even if they're not totally done, having the hard link possible means that is still okay.
  - (Optional - if applicable and/or required (e.g. remote usenet client)) Configure a custom script to run on import/download/upgrade to remove the remote file
- Alternatively a remote mount rather than a remote sync setup is significantly less complicated to configure, but typically slowly.
  - Mount your remote storage with sshfs or another network file system protocol
  - Ensure the user and group \*Arr is configured to run as has read or write access.
  - Configure a remote path map to find the REMOTE path and replace it with the LOCAL equivalent

### <a href="#permissions-on-the-library-folder" class="toc-anchor">¶</a> Permissions on the Library Folder

Logs will look like

``` prismjs
2022-02-03 14:03:54.3|Error|DownloadedEpisodesImportService|Import failed, path does not exist or is not accessible by Sonarr: /volume3/data/tv/The Orville/Season 03/The.Orville.S03E08.1080p.WEB.H264-GGEZ[eztv]. Ensure the path exists and the user running Sonarr has the correct permissions to access this file/folder
```

Don’t forget to check permissions and ownership of the *destination*. It is easy to get fixated on the download’s ownership and permissions and that is *usually* the cause of permissions related issues, but it *could* be the destination as well. Check that the destination folder(s) exist. Check that a destination *file* doesn’t already exist or can’t be deleted or moved to recycle bin. Check that ownership and permissions allow the downloaded file to be copied, hard linked or moved. The user or group that runs as needs to be able to read and write the root folder.

- For Windows Users this may be due to running as a service:

  - the Windows Service runs under the 'Local Service' account, by default this account does not have permissions to access your user's home directory unless permissions have been assigned manually. This is particularly relevant when using download clients that are configured to download to your home directory.
  - 'Local Service' also generally has very limited permissions. It's therefore advisable to install the app as a system tray application if the user can remain logged in. The option to do so is provided during the installer. See the FAQ for how to convert from a service to tray app.

- For Synology Users refer to <a href="https://github.com/SynoCommunity/spksrc/wiki/Permission-Management" class="is-external-link">SynoCommunity's Permissions Article for their Packages</a>

- Non-Windows: If you're using an NFS mount ensure `nolock` is enabled.

- If you're using an SMB mount ensure `nobrl` is enabled.

### <a href="#permissions-on-the-downloads-folder" class="toc-anchor">¶</a> Permissions on the Downloads Folder

You'll see an error similar to the following

``` prismjs
2022-02-03 14:03:54.3|Error|DownloadedEpisodesImportService|Import failed, path does not exist or is not accessible by Sonarr: /volume1/THE VOID/Downloads/Usenet Downloads/complete/Resident.Alien.S02E02.720p.WEB.H264-CAKES.1/a4187f6c3c4445f98e85da52b83c84e8.mkv. Ensure the path exists and the user running Sonarr has the correct permissions to access this file/folder
```

or

``` prismjs
2022-02-03 10:40:41.8|Warn|Sabnzbd|[Resident.Alien.S02E02.720p.WEB.H264-CAKES] Error occurred while trying to delete data from '/volume1/THE VOID/Downloads/Usenet Downloads/complete/Resident.Alien.S02E02.720p.WEB.H264-CAKES/'.

[v3.0.6.1342] System.UnauthorizedAccessException: Access to the path '/volume1/THE VOID/Downloads/Usenet Downloads/complete/Resident.Alien.S02E02.720p.WEB.H264-CAKES' is denied.
```

Don’t forget to check permissions and ownership of the *source*. It is easy to get fixated on the destination's ownership and permissions and that is a *possible* cause of permissions related issues, but it *typically* is the source. Check that the source folder(s) exist - and if docker that the mounts are aligned and consistent. Check that ownership and permissions allow the downloaded file to be copied/hardlinked or copy+delete/moved. The user or group that Sonarr runs as needs to be able to read and write the downloads files.

- For Windows Users this may be due to running as a service:

  - the Windows Service runs under the 'Local Service' account, by default this account does not have permissions to access your user's home directory unless permissions have been assigned manually. This is particularly relevant when using download clients that are configured to download to your home directory.
  - 'Local Service' also generally has very limited permissions. It's therefore advisable to install the app as a system tray application if the user can remain logged in. The option to do so is provided during the installer. See the FAQ for how to convert from a service to tray app.

- For Synology Users refer to <a href="https://github.com/SynoCommunity/spksrc/wiki/Permission-Management" class="is-external-link">SynoCommunity's Permissions Article for their Packages</a>

- Non-Windows: If you're using an NFS mount ensure `nolock` is enabled.

- If you're using an SMB mount ensure `nobrl` is enabled.

### <a href="#download-folder-and-library-folder-not-different-folders" class="toc-anchor">¶</a> Download folder and library folder not different folders

- The download client should download into a folder accessible by \*Arr and that is not your root/library folder; should import from that separate download folder into your Library folder.
- You should never download directly into your root folder. You also should not use your root folder as the download client's completed folder or incomplete folder.
- <a href="/sonarr/system#downloading-into-root-folder" class="is-internal-link is-valid-page"><strong>This will also cause a healthcheck in System as well</strong></a>
- Within the application, a root folder is defined as the configured media library folder. This is not the root folder of a mount. Your download client has an incomplete or complete (or is moving completed downloads) into your root (library) folder. This frequently causes issues and is not advised. To fix this change your download client so it is not placing downloads within your root folder. Note that 'placing' also includes if your download client category is set to your root folder or if NZBGet/SABnzbd have sort enabled and are sorting to your root folder. Please note that this check looks at all defined/configured root folders added not only root folders currently in use. In other words, the folder your download client downloads into or moves completed downloads to, should not be the same folder you have configured as your root/library/final media destination folder in the \*Arr application.
- Configured Root Folders (aka Library folders) can be found in <a href="/sonarr/settings/#root-folders" class="is-internal-link is-valid-page">Settings =&gt; Media Management =&gt; Root Folders</a>
- One example is if your downloads are going into `\data\downloads` then you have a root folder set as `\data\downloads`.
- It is suggested to use paths like `\data\media\` for your root folder/library and `\data\downloads\` for your downloads.

> Your download folder and your root/library folder MUST be separate

### <a href="#incorrect-category" class="toc-anchor">¶</a> Incorrect category

Sonarr should be setup to use a category so that it only tries to process its own downloads. It is rare that a torrent submitted by gets added without the correct category, but it can happen. If you’re adding torrents manually and want to process them, they’ll need to have the correct category. It can be set at any time, since tries to process downloads every minute.

### <a href="#packed-torrents" class="toc-anchor">¶</a> Packed torrents

Logs will indicate errors like

``` prismjs
No files found are eligible for import
```

If your torrent is packed in `.rar` files, you’ll need to setup extraction. We recommend <a href="https://github.com/unpackerr/unpackerr" class="is-external-link">Unpackerr</a> as it does unpacking right: preventing corrupt partial imports and cleans up the unpacked files after import.

The error by also be seen if there is no valid media file in the folder.

### <a href="#repeated-downloads" class="toc-anchor">¶</a> Repeated downloads

There are a few causes of repeated downloads, but one is related to Custom Formats. It's possible the release name matches a custom format, but the download files do not. This gets you into a loop where you download the items again and again because it looks like an upgrade, then isn’t, then shows up again and looks like an upgrade, then isn’t. Depending on your custom format you may be able to work around this by including the custom format in your renaming schema. (Enable the Custom Format to be included in renaming & then add Custom Format to you renaming schema)

This may also be due to the fact that the download never actually imports and then is missing from the queue, so a new download is perpetually grabbed and never imported. Please see the various other common problems and troubleshooting steps for this.

### <a href="#usenet-download-misses-import" class="toc-anchor">¶</a> Usenet download misses import

Sonarr only looks at the 60 most recent downloads in SABnzbd and NZBGet, so if you *keep* your history this means that during large queues with import issues, downloads can be silently missed and not imported. The best way to avoid that is to keep your history clear, so that any items that still appear need investigating. You can achieve this by enabling Remove under Completed and Failed Download Handler. In NZBGet, this will move items to the *hidden* history which is great. Unfortunately, SABnzbd does not have a similar feature. The best you can achieve there is to use the nzb backup folder.

### <a href="#download-client-clearing-items" class="toc-anchor">¶</a> Download client clearing items

The download client should *not* be responsible for removing downloads. Usenet clients should be configured so they *don’t* remove downloads from history. Torrent clients should be setup so they *don’t* remove torrents when they’re finished seeding (pause or stop instead). This is because communicates with the download client to know what to import, so if they’re *removed* there is nothing to be imported. even if there is a folder full of files.

For SABnzbd, this is handled with the History Retention setting.

### <a href="#download-cannot-be-matched-to-a-library-item" class="toc-anchor">¶</a> Download cannot be matched to a library item

For various reasons, releases cannot be parsed once grabbed and sent to the download client. Activity =\> Options =\> Show Unknown (this is now enabled by default in recent builds) will display all items not otherwise ignored / already imported within \*Arr's download client category. These will typically need to be manually mapped and imported.

This can also occur if you have a release in your download client but that media item (movie/episode/book/song) does not exist in the application.

#### <a href="#found-matching-series-via-grab-history-but-series-was-matched-by-series-id-automatic-import-is-not-possible" class="toc-anchor">¶</a> Found matching series via grab history, but series was matched by series ID. Automatic import is not possible

- This import error is similar to the above can't be matched error.
- Sonarr grabbed the release due to your indexer or tracker reporting that the release had the TVDb Id (or IMDb Id) for a series you wanted.
- The series of the downloaded file does not match the id reported, so Sonarr will not import the file.
- Depending on the series title and release name - assuming the release is correct for the series id it is associated with - Sonarr will probably need an alias added, <a href="/sonarr/faq#why-cant-sonarr-import-episode-files-for-series-x-why-cant-sonarr-find-releases-for-series-x" class="is-internal-link is-valid-page">this FAQ entry has some more info</a> on requesting one to be added.
- Alternatively, the release is mislabeled and not for the series id that was reported. This should be reported to your indexer so they can take corrective action.
- To handle this error:
  1.  Verify the series of the file
  2.  Request an alias (if applicable)
  3.  Manual Import the file (Human Icon to the right) from the Activity =\> Queue OR click the `X` in queue to ignore the release in your client and optionally blocklist it / optionally remove it from the client

### <a href="#episode-name-is-tba" class="toc-anchor">¶</a> Episode Name is TBA

On TVDB, when episode names are unknown they'll be titled TBA and there is a 24 hour cache on the API. Typically, changes to the TVDB website take 24-48 hours to reach Sonarr due to TVDB cache, Skyhook cache and the series refresh interval.

The <a href="/sonarr/settings#importing" class="is-internal-link is-valid-page">Episode Title Required</a> setting in Sonarr controls import behavior when the title is TBA, but after 24 hours from the episode's air date the release will be imported even if the title is still TBA. There is also no automatic follow up renaming of TBA titled files.

### <a href="#the-underlying-connection-was-closed-an-unexpected-error-occurred-on-a-send" class="toc-anchor">¶</a> The underlying connection was closed: An unexpected error occurred on a send

This is caused by the indexer using a SSL protocol not supported by the current .NET Version found in <a href="/sonarr/system#status" class="is-internal-link is-valid-page">Sonarr =&gt; System =&gt; Status</a>.

### <a href="#the-request-timed-out" class="toc-anchor">¶</a> The request timed out

Sonarr is getting no response from the client.

``` prismjs
    System.NET.WebException: The request timed out: ’https://example.org/api?t=caps&apikey=(removed) —> System.NET.WebException: The request timed out
```

``` prismjs
2022-11-01 10:16:54.3|Warn|Newznab|Unable to connect to indexer

[v4.3.0.6671] System.Threading.Tasks.TaskCanceledException: A task was canceled.
```

This can also be caused by:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues - Try changing to a different DNS provider
- local IPv6 issues - typically IPv6 is enabled, but non-functional
- the use of Privoxy and it being improperly configured

### <a href="#download-doesnt-contain-intermediate-path" class="toc-anchor">¶</a> Download doesn't contain intermediate path

There was no output path reported from your download client for this item.

## <a href="#problem-not-listed" class="toc-anchor">¶</a> Problem Not Listed

You can also review some common permissions and networking troubleshooting commands <a href="/permissions-and-networking" class="is-internal-link is-valid-page">in our guide</a>. Otherwise please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.

# <a href="#searches-indexers-and-trackers" class="toc-anchor">¶</a> Searches Indexers and Trackers

- The <a href="/sonarr/faq#why-didnt-sonarr-grab-an-episode-i-was-expecting" class="is-internal-link is-valid-page">Why didn't Sonarr grab an episode I was expecting?</a> FAQ entry is likely helpful as well.
- If you use <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a>, then you can view the <a href="/prowlarr/history" class="is-internal-link is-valid-page">History</a> of all queries Prowlarr received and how they were sent to the sites. Ensure that `Parameters` is enabled in Prowlarr History =\> Options. The (i) icon provides additional details.
- The troubleshooting steps are otherwise below

## <a href="#turn-logging-up-to-trace" class="toc-anchor">¶</a> Turn logging up to trace

> **The first step is to turn logging up to Trace, see [Logging and Log Files](#logging-and-log-files) for details on adjusting logging and searching logs. You’ll then reproduce the issue and use the trace level logs from that time frame to examine the issue.** If someone is helping you, put context from before/after in a <a href="https://0bin.net" class="is-external-link">pastebin</a>, <a href="https://gist.com" class="is-external-link">Gist</a>, or similar site to show them. It doesn’t need to be the whole file and it shouldn’t *just* be the error. You should also reproduce the issue while tasks that spam the log file aren’t running.

## <a href="#testing-an-indexer-or-tracker" class="toc-anchor">¶</a> Testing an Indexer or Tracker

When you test an indexer or tracker, in debug or trace logs you can find the URL used. An example of a successful test is below, you can see it query the indexer via a specific URL with specific parameters and then the response. You test this url in your browser like replacing the `apikey=(removed)` with the correct apikey like `apikey=123`. You can experiment with the parameters if you’re getting an error from the indexer or see if you have connectivity issues if it doesn’t even work. After you’ve tested in your own browser, you should test from the system is running on *if* you haven’t already.

## <a href="#testing-a-search" class="toc-anchor">¶</a> Testing a Search

Just like the indexer/tracker test above, when you trigger a search while at Debug or Trace level logging, you can get the URL used from the log files. While testing, it is best to use as narrow a search as possible. A manual (interactive) search for a single episode or season is good because it is specific and you can see the results in the UI while examining the logs. Manual (Interactive) Searches are triggered by going to a Series and clicking the human icon for an episode or season.

In this test, you’ll be looking for obvious errors and running some simple tests. You can see the search used the url `https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1`, which you can try yourself in a browser after replacing (removed) with your apikey for that indexer. Does it work? Do you see the expected results? Does this FAQ entry apply? In that URL, you can see that it set specific categories with `cat=5030,5040,5045,5080`, so if you’re not seeing expected results, this is one likely reason. You can also see that it searched by tvdbid with `tvdbid=354629`, so if the episode isn’t properly categorized on the indexer, it will need to be fixed. You can also see that it searches by specific season and episode with season=1 and ep=1, so if that isn’t correct on the indexer, you won’t see those results. Look at Manual Search XML Output below to see an example of a working query’s output.

- Manual Search XML Output

``` prismjs
<rss xmlns:atom="http://www.w3.org/2005/Atom" xmlns:newznab="http://www.newznab.com/DTD/2010/feeds/attributes/" version="2.0">
<channel>
<atom:link href="https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1" rel="self" type="application/rss+xml"/>
<title>api.nzbgeek.info</title>
<description>NZBgeek API</description>
<link>http://api.nzbgeek.info/</link>
<language>en-gb</language>
<webMaster>info@nzbgeek.info (NZBgeek)</webMaster>
<category/>
<image>
<url>https://api.nzbgeek.info/covers/nzbgeek.png</url>
<title>api.nzbgeek.info</title>
<link>http://api.nzbgeek.info/</link>
<description>NZBgeek</description>
</image>
<newznab:response offset="0" total="2"/>
<item>
<title>The.Fix.S01E01.1080p.AMZN.WEB-DL</title>
<guid isPermaLink="true">
https://api.nzbgeek.info/details/358e0f946f953771c7688864b0334ba1
</guid>
<link>
https://api.nzbgeek.info/api?t=get&id=358e0f946f953771c7688864b0334ba1&apikey=(removed)
</link>
<comments>
https://nzbgeek.info/geekseek.php?guid=358e0f946f953771c7688864b0334ba1
</comments>
<pubDate>Wed, 20 Mar 2019 05:03:32 +0000</pubDate>
<category>TV > HD</category>
<description>The.Fix.S01E01.1080p.AMZN.WEB-DL</description>
<enclosure url="https://api.nzbgeek.info/api?t=get&id=358e0f946f953771c7688864b0334ba1&apikey=(removed)" length="3810861000" type="application/x-nzb"/>
<newznab:attr name="category" value="5000"/>
<newznab:attr name="category" value="5040"/>
<newznab:attr name="size" value="3810861000"/>
<newznab:attr name="guid" value="358e0f946f953771c7688864b0334ba1"/>
<newznab:attr name="tvdbid" value="354629"/>
<newznab:attr name="season" value="S01"/>
<newznab:attr name="episode" value="E01"/>
<newznab:attr name="tvairdate" value="2019-03-18T00:00:00Z"/>
<newznab:attr name="grabs" value="55"/>
<newznab:attr name="usenetdate" value="Wed, 20 Mar 2019 04:54:15 +0000"/>
</item>
<item>
<title>The.Fix.S01E01.720p.AMZN.WEB-DL</title>
<guid isPermaLink="true">
https://api.nzbgeek.info/details/f7e4ac2875b6a1ce45bae91ab19e9699
</guid>
<link>
https://api.nzbgeek.info/api?t=get&id=f7e4ac2875b6a1ce45bae91ab19e9699&apikey=(removed)
</link>
<comments>
https://nzbgeek.info/geekseek.php?guid=f7e4ac2875b6a1ce45bae91ab19e9699
</comments>
<pubDate>Wed, 20 Mar 2019 05:03:33 +0000</pubDate>
<category>TV > HD</category>
<description>The.Fix.S01E01.720p.AMZN.WEB-DL</description>
<enclosure url="https://api.nzbgeek.info/api?t=get&id=f7e4ac2875b6a1ce45bae91ab19e9699&apikey=(removed)" length="1195794000" type="application/x-nzb"/>
<newznab:attr name="category" value="5000"/>
<newznab:attr name="category" value="5040"/>
<newznab:attr name="size" value="1195794000"/>
<newznab:attr name="guid" value="f7e4ac2875b6a1ce45bae91ab19e9699"/>
<newznab:attr name="tvdbid" value="354629"/>
<newznab:attr name="season" value="S01"/>
<newznab:attr name="episode" value="E01"/>
<newznab:attr name="tvairdate" value="2019-03-18T00:00:00Z"/>
<newznab:attr name="grabs" value="14"/>
<newznab:attr name="usenetdate" value="Wed, 20 Mar 2019 04:51:45 +0000"/>
</item>
</channel>
</rss>
```

![searches-indexers-and-trackers1.png](/assets/sonarr/searches-indexers-and-trackers1.png)  
![searches-indexers-and-trackers2.png](/assets/sonarr/searches-indexers-and-trackers2.png)

- Trace Log Snippet

``` prismjs
2021-03-20 13:15:23.6|Info|NzbSearchService|Searching 1 indexers for [The Fix : S01E01]
2021-03-20 13:15:23.6|Debug|Newznab|Downloading Feed https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
2021-03-20 13:15:23.6|Trace|HttpClient|Req: [GET] https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
```

- Full Trace Log of a Search

``` prismjs
2021-03-20 13:15:23.6|Trace|Http|Req: 66 [GET] /api/v3/release?episodeId=1
2021-03-20 13:15:23.6|Info|NzbSearchService|Searching 1 indexers for [The Fix : S01E01]
2021-03-20 13:15:23.6|Debug|Newznab|Downloading Feed https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
2021-03-20 13:15:23.6|Trace|HttpClient|Req: [GET] https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
2021-03-20 13:15:23.6|Trace|ConfigService|Using default config value for 'proxyenabled' defaultValue:'False'
2021-03-20 13:15:24.3|Trace|HttpClient|Res: [GET] https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1: 200.OK (680 ms)
2021-03-20 13:15:24.3|Trace|NewznabRssParser|Parsed: The.Fix.S01E01.1080p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Trace|NewznabRssParser|Parsed: The.Fix.S01E01.720p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|NzbSearchService|Total of 2 reports were found for [The Fix : S01E01] from 1 indexers
2021-03-20 13:15:24.3|Debug|NzbSearchService|Setting last search time to: 11/20/2019 13:15:24
2021-03-20 13:15:24.3|Info|DownloadDecisionMaker|Processing 2 releases
2021-03-20 13:15:24.3|Trace|DownloadDecisionMaker|Processing release 1/2
2021-03-20 13:15:24.3|Debug|DownloadDecisionMaker|Processing release 'The.Fix.S01E01.1080p.AMZN.WEB-DL' from 'NZBgeek'
2021-03-20 13:15:24.3|Debug|Parser|Parsing string 'The.Fix.S01E01.1080p.AMZN.WEB-DL'
2021-03-20 13:15:24.3|Trace|Parser|^(?<title>.+?)(?:(?:[-_\W](?<![()\[!]))+S?(?<season>(?<!\d+)(?:\d{1,2})(?!\d+))(?:[ex]|\W[ex]){1,2}(?<episode>\d{2,3}(?!\d+))(?:(?:\-|[ex]|\W[ex]|_){1,2}(?<episode>\d{2,3}(?!\d+)))*)\W?(?!\\)
2021-03-20 13:15:24.3|Debug|Parser|Episode Parsed. The Fix - S01E01
2021-03-20 13:15:24.3|Debug|Parser|Language parsed: English
2021-03-20 13:15:24.3|Debug|QualityParser|Trying to parse quality for The.Fix.S01E01.1080p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|Parser|Quality parsed: WEBDL-1080p v1
2021-03-20 13:15:24.3|Debug|Parser|Release Group parsed:
2021-03-20 13:15:24.3|Trace|PreferredWordService|Calculating preferred word score for 'The.Fix.S01E01.1080p.AMZN.WEB-DL'
2021-03-20 13:15:24.3|Trace|PreferredWordService|Calculated preferred word score for 'The.Fix.S01E01.1080p.AMZN.WEB-DL': 0
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Beginning size check for: The.Fix.S01E01.1080p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Possible double episode, doubling allowed size.
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Item: The.Fix.S01E01.1080p.AMZN.WEB-DL, meets size constraints.
2021-03-20 13:15:24.3|Debug|AlreadyImportedSpecification|Performing already imported check on report
2021-03-20 13:15:24.3|Debug|AlreadyImportedSpecification|Skipping already imported check for episode without file
2021-03-20 13:15:24.3|Debug|LanguageSpecification|Checking if report meets language requirements. English
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'maximumsize' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|MaximumSizeSpecification|Maximum size is not set.
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'minimumage' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|MinimumAgeSpecification|Minimum age is not set.
2021-03-20 13:15:24.3|Debug|QualityAllowedByProfileSpecification|Checking if report meets quality requirements. WEBDL-1080p v1
2021-03-20 13:15:24.3|Debug|QualityAllowedByProfileSpecification|Quality WEBDL-1080p v1 rejected by Series' quality profile
2021-03-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|Checking if release meets restrictions: The.Fix.S01E01.1080p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|[The.Fix.S01E01.1080p.AMZN.WEB-DL] No restrictions apply, allowing
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'retention' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|RetentionSpecification|Checking if report meets retention requirements. 245
2021-03-20 13:15:24.3|Debug|SeriesSpecification|Checking if series matches searched series
2021-03-20 13:15:24.3|Debug|DelaySpecification|Ignoring delay for user invoked search
2021-03-20 13:15:24.3|Debug|HistorySpecification|Skipping history check during search
2021-03-20 13:15:24.3|Debug|MonitoredEpisodeSpecification|Skipping monitored check during search
2021-03-20 13:15:24.3|Debug|DownloadDecisionMaker|Release rejected for the following reasons: [Permanent] WEBDL-1080p is not wanted in profile
2021-03-20 13:15:24.3|Trace|DownloadDecisionMaker|Processing release 2/2
2021-03-20 13:15:24.3|Debug|DownloadDecisionMaker|Processing release 'The.Fix.S01E01.720p.AMZN.WEB-DL' from 'NZBgeek'
2021-03-20 13:15:24.3|Debug|Parser|Parsing string 'The.Fix.S01E01.720p.AMZN.WEB-DL'
2021-03-20 13:15:24.3|Trace|Parser|^(?<title>.+?)(?:(?:[-_\W](?<![()\[!]))+S?(?<season>(?<!\d+)(?:\d{1,2})(?!\d+))(?:[ex]|\W[ex]){1,2}(?<episode>\d{2,3}(?!\d+))(?:(?:\-|[ex]|\W[ex]|_){1,2}(?<episode>\d{2,3}(?!\d+)))*)\W?(?!\\)
2021-03-20 13:15:24.3|Debug|Parser|Episode Parsed. The Fix - S01E01
2021-03-20 13:15:24.3|Debug|Parser|Language parsed: English
2021-03-20 13:15:24.3|Debug|QualityParser|Trying to parse quality for The.Fix.S01E01.720p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|Parser|Quality parsed: WEBDL-720p v1
2021-03-20 13:15:24.3|Debug|Parser|Release Group parsed:
2021-03-20 13:15:24.3|Trace|PreferredWordService|Calculating preferred word score for 'The.Fix.S01E01.720p.AMZN.WEB-DL'
2021-03-20 13:15:24.3|Trace|PreferredWordService|Calculated preferred word score for 'The.Fix.S01E01.720p.AMZN.WEB-DL': 0
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Beginning size check for: The.Fix.S01E01.720p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Possible double episode, doubling allowed size.
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Item: The.Fix.S01E01.720p.AMZN.WEB-DL, meets size constraints.
2021-03-20 13:15:24.3|Debug|AlreadyImportedSpecification|Performing already imported check on report
2021-03-20 13:15:24.3|Debug|AlreadyImportedSpecification|Skipping already imported check for episode without file
2021-03-20 13:15:24.3|Debug|LanguageSpecification|Checking if report meets language requirements. English
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'maximumsize' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|MaximumSizeSpecification|Maximum size is not set.
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'minimumage' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|MinimumAgeSpecification|Minimum age is not set.
2021-03-20 13:15:24.3|Debug|QualityAllowedByProfileSpecification|Checking if report meets quality requirements. WEBDL-720p v1
2021-03-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|Checking if release meets restrictions: The.Fix.S01E01.720p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|[The.Fix.S01E01.720p.AMZN.WEB-DL] No restrictions apply, allowing
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'retention' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|RetentionSpecification|Checking if report meets retention requirements. 245
2021-03-20 13:15:24.3|Debug|SeriesSpecification|Checking if series matches searched series
2021-03-20 13:15:24.3|Debug|DelaySpecification|Ignoring delay for user invoked search
2021-03-20 13:15:24.3|Debug|HistorySpecification|Skipping history check during search
2021-03-20 13:15:24.3|Debug|MonitoredEpisodeSpecification|Skipping monitored check during search
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'autounmonitorpreviouslydownloadedepisodes' defaultValue:'False'
2021-03-20 13:15:24.3|Debug|DownloadDecisionMaker|Release accepted
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'downloadpropersandrepacks' defaultValue:'PreferAndUpgrade'
2021-03-20 13:15:24.3|Trace|Http|Res: 66 [GET] /api/v3/release?episodeId=1: 200.OK (775 ms)
2021-03-20 13:15:24.3|Debug|Api|[GET] /api/v3/release?episodeId=1: 200.OK (775 ms)
```

## <a href="#common-problems-1" class="toc-anchor">¶</a> Common Problems

Below are some common problems that are the solution for almost all issues experienced.

### <a href="#unable-to-load-search-results" class="toc-anchor">¶</a> Unable to Load Search Results

Most likely you're using a reverse proxy and you reverse proxy timeout is set too short before \*Arr has completed the search query. Increase the timeout and try again.

### <a href="#indexers-not-being-searched" class="toc-anchor">¶</a> Indexers not being Searched

- Logs will look like

``` prismjs
2022-04-24 20:14:26.7|Info|ReleaseSearchService|Searching indexers for [Fairy Tail : S02E91 (91)]. 0 active indexers
2022-04-24 20:14:26.7|Debug|ReleaseSearchService|Total of 0 reports were found for [Fairy Tail : S02E91 (91)] from 0 indexers
2022-04-24 20:14:26.7|Info|DownloadDecisionMaker|No results found
```

- Note that in the above case there are 0 indexers being searched. This number may very based on your specific setup. If the number is not the same as the number of indexers configured then the following are likely causes:
  - <a href="/sonarr/system#health" class="is-internal-link is-valid-page">Health Checks (System =&gt; Status)</a>
    - <a href="/sonarr/system#no-indexers-available-with-automatic-search-enabled-sonarr-will-not-provide-any-automatic-search-results" class="is-internal-link is-valid-page">No indexers available with automatic search enabled, Sonarr will not provide any automatic search results</a>
    - <a href="/sonarr/system#no-indexers-are-enabled" class="is-internal-link is-valid-page">No indexers are enabled</a>
    - <a href="/sonarr/system#enabled-indexers-do-not-support-searching" class="is-internal-link is-valid-page">Enabled indexers do not support searching</a>
    - <a href="/sonarr/system#no-indexers-available-with-interactive-search-enabled" class="is-internal-link is-valid-page">No indexers available with Interactive Search Enabled</a>
    - <a href="/sonarr/system#indexers-are-unavailable-due-to-failures" class="is-internal-link is-valid-page">Indexers are unavailable due to failures</a>
  - Searching a Series Type of Anime and no anime categories are configured for your tracker(s). Indexers have <a href="/sonarr/settings#indexers" class="is-internal-link is-valid-page">two different configurable category types</a>.
  - Searching a Series Type of Daily or Standard are no standard (non-anime) categories are configured for your tracker(s)
    - Categories - Default categories will be used unless edited. It is likely these default categories are suboptimal. Upon editing this setting, Sonarr queries the indexer for its available categories and displays them in a selectable a list. The stale defaults will clear as soon as a category is toggled.
  - Anime Categories - The categories that Sonarr will use for Anime searches No categories will be used unless edited. Upon editing this setting, Sonarr queries the indexer for its available categories and displays them in a selectable a list. The stale defaults will clear as soon as a category is toggled.
  - The Indexer's Capabilities do not support the query type (e.g. Season/Episode, etc.):
    - Within Prowlarr, an indexer's capabilities can be located in the (I) icon for the indexer
    - Jackett does not display a tracker's capabilities within its UI.
  - Trace logs will display information as to why indexers are being ignored if a search is conducted after ***restarting Sonarr***.

### <a href="#poorly-named-releases" class="toc-anchor">¶</a> Poorly Named Releases

- Series Packs are not supported
- Multiple Season Packs are not supported
- In many cases, Sonarr is simply unable to match the returned result to a known series. In these cases your logs will look similar to below. These would need to be grabbed and likely imported manually. The key phrase to see in the logs is `|Debug|DownloadDecisionMaker|Release rejected for the following reasons: [Permanent] Unable to identify correct episode(s) using release name and scene mappings`

``` prismjs
2022-02-23 14:11:09.7|Debug|Parser|Parsing string 'Johnny Bravo 1997 Season 1 4 S01 S04 Specials 576p Mixed x265 HEVC 10bit AAC 2 0 Ghost QxR'
2022-02-23 14:11:09.7|Trace|Parser|^(?<title>.+?)[-_. ]+?(?:S|Season|Saison|Series)[-_. ]?(?<season>\d{1,2}(?![-_. ]?\d+))(\W+|_|$)(?<extras>EXTRAS|SUBPACK)?(?!\\)
2022-02-23 14:11:09.7|Debug|Parser|Episode Parsed. Johnny Bravo 1997 Season 1 4 - Season 01
2022-02-23 14:11:09.7|Debug|Parser|Language parsed: English
2022-02-23 14:11:09.7|Debug|QualityParser|Trying to parse quality for Johnny Bravo 1997 Season 1 4 S01 S04 Specials 576p Mixed x265 HEVC 10bit AAC 2 0 Ghost QxR
2022-02-23 14:11:09.7|Debug|Parser|Quality parsed: SDTV v1
2022-02-23 14:11:09.7|Debug|Parser|Release Group parsed:
2022-02-23 14:11:09.8|Debug|DownloadDecisionMaker|Release rejected for the following reasons: [Permanent] Unable to identify correct episode(s) using release name and scene mappings
```

### <a href="#tracker-needs-rawsearch-caps" class="toc-anchor">¶</a> Tracker needs RawSearch Caps

- Sonarr is searching for `9 1 1` but your tracker only has results for `9-1-1` or `John s Show` and `John's Show`
- This is due to your tracker not supporting normal standardized searches.
- The solution is that your tracker's definition's search capabilities need to be updates to indicate it <a href="https://github.com/Sonarr/Sonarr/issues/1225#issuecomment-981153943" class="is-external-link">requires and supports <code>RawSearch</code></a>
- Jackett supports the flag, but the capabilities need to be updated on a per-indexer basis. Open a feature request for Jackett to add this functionality for your indexer.
- Prowlarr supports the flag, but the capabilities need to be updated on a per-indexer basis. Open a feature request for Prowlarr to add this functionality for your indexer.

### <a href="#series-needs-an-alias" class="toc-anchor">¶</a> Series needs an alias

Releases may be uploaded as `The Series Name`, but TVDB has the series as `Series Name` or similar naming differences. This also includes Foreign Titles. Please see <a href="/sonarr/faq#why-cant-sonarr-import-episode-files-for-series-x-why-cant-sonarr-find-releases-for-series-x" class="is-internal-link is-valid-page">this FAQ entry</a>

### <a href="#series-needs-an-xem-mapping" class="toc-anchor">¶</a> Series needs an XEM Mapping

Releases may be uploaded as `Series Title S02E45` or `Other Series Title S2022E42`, but TVDB has this episode as `Series Title S03E01` or `Other Series Title S03E42` Please see <a href="/sonarr/faq#how-does-sonarr-handle-scene-numbering-issues-american-dad-etc" class="is-internal-link is-valid-page">this FAQ entry</a>

### <a href="#wrong-series-type" class="toc-anchor">¶</a> Wrong Series Type

The series type affects how Sonarr searches. The series type should be selected based on how the series is being released on the indexers.  
<a href="/sonarr/faq#whats-the-different-series-types" class="is-internal-link is-valid-page">See this FAQ entry for more details</a>

> If **Anime** Series Type is used - it is <a href="/sonarr/settings#indexers" class="is-internal-link is-valid-page">possible to also have your indexer searched with the standard type as well.</a>

#### <a href="#daily" class="toc-anchor">¶</a> Daily

Logs will show `Searching indexers for [The Witcher : 2021-12-20]`

- Some.Daily.Show.**2021.03.04**.1080p.HDTV.x264-DARKSPORT
- A.Daily.Show.with.Some.Guy.**2021.03.03**.1080p.CC.WEB-DL.AAC2.0.x264-null
- DailyShow.**2021.03.08**.720p.HDTV.x264-NTb

#### <a href="#standard" class="toc-anchor">¶</a> Standard

Logs will show `Searching indexers for [The Witcher : S01E09]`

- The.Show.**S20E03**.Episode.Title.Part.3.1080p.HULU.WEB-DL.DDP5.1.H.264-NTb
- Another.Show.**S03E08**.1080p.WEB.H264-GGEZ
- GreatShow.**S17E02**.1080p.HDTV.x264-DARKFLiX

#### <a href="#anime" class="toc-anchor">¶</a> Anime

Logs will show `Searching indexers for [The Witcher : S01E09 (09)]`

- Anime.Origins.**E04**.File.4\_.Monkey.WEB-DL.H.264.1080p.AAC2.0.AC3.5.1.Srt.EngCC-Pikanet128.1272903A
- \[Coalgirls\] Human X Monkey **148** (1920x1080 Blu-ray FLAC) \[63B8AC67\]
- \[KaiDubs\] Series x Title (2011) - **142** \[1080p\] \[English Dub\] \[CC\] \[AS-DL\] \[A24AB2E5\]

### <a href="#media-is-unmonitored" class="toc-anchor">¶</a> Media is Unmonitored

Logs will show something similar to

``` prismjs
2022-03-30 13:46:03.0|Debug|MonitoredEpisodeSpecification|No episodes in the release are monitored. Rejecting
2022-03-30 13:46:03.0|Debug|DownloadDecisionMaker|Release rejected for the following reasons: [Permanent] One or more episodes is not monitored
```

The series/season/episode(s) is(are) not monitored. Check the monitoring status of the Series, Season, and Episode(s).

> Season Packs will only be grabbed if all episodes in the season are monitored and the season pack upgrades all existing episodes or all episodes are missing.

### <a href="#query-successful-no-results-returned" class="toc-anchor">¶</a> Query Successful - No Results Returned

You receive a message similar to `Query successful, but no results were returned from your indexer. This may be an issue with the indexer or your indexer category settings.`

This is caused by your Indexer failing to return any results that are within the categories you configured for the Indexer.

### <a href="#wrong-categories" class="toc-anchor">¶</a> Wrong Categories

Incorrect categories is probably the most common cause of results showing in manual searches of an indexer/tracker, but *not* in \*Arr. The indexer/tracker *should* show the category in the search results, which should help you figure out what is missing. If you’re using Jackett or Prowlarr, each tracker has a list of specifically supported categories. Make sure you’re using the correct ones for Categories. Many find it helpful to have the list visible in one browser window while they edit the entry in Sonarr.

> Note that if you have `Anime Categories` blank in your Indexer settings then the Indexer will not be used for Anime Series Type searches.  
> Similarly, if you have `Categories` blank in your Indexer settings then the Indexer will not be used for Standard nor Daily Series Type searches.

### <a href="#wrong-results" class="toc-anchor">¶</a> Wrong Results

Sometimes indexers will return completely unrelated results; Sonarr will feed in parameters to limit the search to an series. Sometimes the results returned are completely unrelated. Or sometimes, mostly related with a few incorrect results. The first is usually an indexer problem and you’ll be able to tell from the trace logs which is causing it. You can disable that indexer and report the problem. The other is usually categorized releases which should be reportable on the indexer/tracker.

Certain trackers - such as EZTV an other publics - return random results if they do not have an exact match for the series/season/episode being queried. There is no resolution for this.

### <a href="#missing-results" class="toc-anchor">¶</a> Missing Results

If you have results on the site you can find that are not showing in Sonarr then your issue is likely one of several possibilities:

- [Categories are incorrect - See Above](#wrong-categories)
- An ID (IMDbId, TVDBId, etc.) based searched is being done and the Indexer does not have the releases correctly mapped to that ID. This is something only your indexer can solve. They need to ensure the release is mapped to the correct applicable ids.
- Not searching how Sonarr is searching; It's highly likely the terms you are searching on the indexer is not how Sonarr is querying it. You can see how Sonarr is querying from the Trace Logs. Text based queries will generally be in the format of `q=words%20and%20things%20here` this string is HTTP encoded and can be easily decoded using any HTML decoding/encoding tool online.
- Missed chunks of RSS Feed of new uploads. Logs will appear as follows and an Event of Warning will be noted.

``` prismjs
2022-02-22 08:03:38.7|Debug|Torznab|Downloading Feed http://jackett:9117/api/v2.0/indexers/torrentdownloads/results/torznab?t=tvsearch&cat=5000,100008&extended=1&apikey=(removed)&offset=2900&limit=100
2022-02-22 08:03:40.7|Warn|Torznab|Indexer TorrentDownloads rss sync didn't cover the period between 2/21/2022 8:32:06 PM and 2/21/2022 9:02:42 PM UTC. Search may be required.
```

### <a href="#certificate-validation" class="toc-anchor">¶</a> Certificate validation

You’ll be connecting to most indexers/trackers via https, so you’ll need that to work properly on your system. That means your time zone and time both need to be set *correctly*. It also means your system certificates need to be up to date.

### <a href="#hitting-rate-limits" class="toc-anchor">¶</a> Hitting rate limits

If you run your through a VPN or proxy, you may be competing with 10s or 100s or 1000s of other people all trying to use services like , theXEM ,and/or your indexers and trackers. Rate limiting and DDOS protection are often done by IP address and your VPN/proxy exit point is *one* IP address. Unless you’re in a repressive country like China, Australia or South Africa you don’t need to VPN/proxy.

### <a href="#ip-ban" class="toc-anchor">¶</a> IP Ban

Similarly to rate limits, certain indexers - such as Nyaa - may outright ban an IP address. This is typically semi-permanent and the solution is to to get a new IP from your ISP or VPN provider.

### <a href="#using-the-jackett-all-endpoint" class="toc-anchor">¶</a> Using the Jackett /all endpoint

The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is required. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a>

<a href="https://github.com/Jackett/Jackett#aggregate-indexers" class="is-external-link">Even Jackett says /all should be avoided and should not be used.</a>

Using the all endpoint has no advantages (besides reduced management overhead), only disadvantages:

- you lose control over indexer specific settings (categories, search modes, etc.)
- mixing search modes (IMDB, query, etc.) might cause low-quality results
- indexer specific categories (\>= 100000) cannot be used.
- slow indexers will slow down the overall result
- total results are limited to 1000
- unrelated results
- missing results

Adding each indexer separately It allows for fine tuning of categories on a per indexer basis, which can be a problem with the `/all` end point if using the wrong category causes errors on some trackers. In Sonarr, each indexer is limited to 1000 results if pagination is supported or 100 if not, which means as you add more and more trackers to Jackett, you’re more and more likely to clip results. Finally, if *one* of the trackers in `/all` returns an error, will disable it and now you don’t get any results.

### <a href="#using-nzbhydra2-as-a-single-entry" class="toc-anchor">¶</a> Using NZBHydra2 as a single entry

Using NZBHydra2 as a single indexer entry (i.e. 1 NZBHydra2 Entry in Sonarr for many indexers in NZBHydra2) rather than multiple (i.e. many NZBHydra2 entries in Sonarr for many indexers in NZBHydra2) has the same problems as noted above with Jackett's `/all` endpoint.

### <a href="#indexer-not-being-searched" class="toc-anchor">¶</a> Indexer not being searched

- If an indexer does not appear to being searched, it is likely due to the indexer not supporting the query type. The most common instance is Nyaa only supports query searches and not Season/Episode searches. The Trace logs indicate after a reboot on the first search what capabilities an indexer has or does not have.

### <a href="#jackett-manual-search-finding-more-results" class="toc-anchor">¶</a> Jackett manual search finding more results

- <a href="/sonarr/faq#jackett-shows-more-results-than-sonarr-when-manually-searching" class="is-internal-link is-valid-page">See this FAQ entry</a>

### <a href="#problem-not-listed-1" class="toc-anchor">¶</a> Problem Not Listed

You can also review some common permissions and networking troubleshooting commands <a href="/permissions-and-networking" class="is-internal-link is-valid-page">in our guide</a>. Otherwise please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.

## <a href="#errors" class="toc-anchor">¶</a> Errors

These are some of the common errors you may see when adding an indexer

### <a href="#the-underlying-connection-was-closed-an-unexpected-error-occurred-on-a-send-1" class="toc-anchor">¶</a> The underlying connection was closed: An unexpected error occurred on a send

This is caused by the indexer using a SSL protocol not supported by the current .NET Version found in <a href="/sonarr/system#status" class="is-internal-link is-valid-page">Sonarr =&gt; System =&gt; Status</a>.

### <a href="#the-request-timed-out-1" class="toc-anchor">¶</a> The request timed out

Sonarr is getting no response from the indexer.

``` prismjs
    System.NET.WebException: The request timed out: ’https://example.org/api?t=caps&apikey=(removed) —> System.NET.WebException: The request timed out
```

``` prismjs
2022-11-01 10:16:54.3|Warn|Newznab|Unable to connect to indexer

[v4.3.0.6671] System.Threading.Tasks.TaskCanceledException: A task was canceled.
```

This can also be caused by:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues - Try changing to a different DNS provider
- local IPv6 issues - typically IPv6 is enabled, but non-functional
- the use of Privoxy and it being improperly configured

### <a href="#problem-not-listed-2" class="toc-anchor">¶</a> Problem Not Listed

You can also review some common permissions and networking troubleshooting commands <a href="/permissions-and-networking" class="is-internal-link is-valid-page">in our guide</a>. Otherwise please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.


