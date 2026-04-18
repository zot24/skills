<!-- Source: https://wiki.servarr.com/radarr/troubleshooting -->

* * *

Radarr Troubleshooting

Troubleshooting for Radarr including getting log files, search troubleshooting and common problems, and downloading / importing troubleshooting and common problems

* * *

Page Contents

Asking for Help

Logging and Log Files

Standard Logs Location

Update Logs Location

Sharing Logs

Trace/Debug Logs

Clearing Logs

Multiple Log Files

Recovering from a Failed Update

Determine the issue

Resolving the issue

Downloads and Importing

Testing the Download Client

Testing a Download

Testing an Import

Common Problems

Problem Not Listed

Searches Indexers and Trackers

Turn logging up to trace

Testing an Indexer or Tracker

Testing a Search

Common Problems

Errors

Tags

[radarr](https://wiki.servarr.com/t/radarr) [troubleshooting](https://wiki.servarr.com/t/troubleshooting) [Pages matching tags](https://wiki.servarr.com/t/radarr/troubleshooting)

Last edited by

thezak48

02/01/2026

# [¶](https://wiki.servarr.com/radarr/troubleshooting\#asking-for-help) Asking for Help

Do you need help? That's okay, everyone needs help sometimes. You can get real time help via chat on

- [Discord _Official Radarr Discord_](https://radarr.video/discord)

But before you go there and post, be sure your request for help is the best it can be. Clearly describe the problem and briefly describe your setup, including things like your OS/distribution, version of .NET, version of Radarr, download client and its version. **If you are using [Docker](https://www.docker.com/) please run through [Docker Guide](https://wiki.servarr.com/docker-guide) first as that will solve common and frequent path/permissions issues. Otherwise please have a [docker compose](https://wiki.servarr.com/docker-guide#docker-compose) handy. [How to Generate a Docker Compose](https://trash-guides.info/compose)** Tell us about what you've tried already, what you've looked at. Use the [Logging and Log Files section](https://wiki.servarr.com/radarr/troubleshooting#logging-and-log-files) to turn your logging up to trace, recreate the issue, pastebin the relevant context and include a link to it in your post. Maybe even include some screen shots to highlight the issue.

The more we know, the easier it is to help you.

> Please note we only support builds created by the Servarr build platform

# [¶](https://wiki.servarr.com/radarr/troubleshooting\#logging-and-log-files) Logging and Log Files

It is likely beneficial to also review the Common Troubleshooting problems:

- [Downloads and Importing Common Problems](https://wiki.servarr.com/radarr/troubleshooting#common-problems)
- [Searching Indexers and Trackers Common Problems](https://wiki.servarr.com/radarr/troubleshooting#common-problems-1)

If you're asked for debug logs your logs will contain `debug` and if you're asked for trace logs your logs will contain `trace`. If the logs you are providing do not contain either then they are not the logs requested.

- Avoid sharing the entire log file unless asked.
- Don't upload logs directly to Discord or paste them as walls of text, unless requested.
- Don't share the logs as an attachment, a zip archive, or anything other than text shared via the services noted below

To provide good and useful logs for sharing:

> Ensure a spammy task is NOT running such as an RSS refresh

1. [Turn Logging up to Trace (Settings => General => Log Level or Edit The Config File)](https://wiki.servarr.com/radarr/troubleshooting#tracedebug-logs)
2. [Clear Logs (System => Logs => Clear Logs or Delete all the Logs in the Log Folder)](https://wiki.servarr.com/radarr/troubleshooting#clearing-logs)
3. Reproduce the Issue (Redo what is breaking things)
4. [Open the trace log file (radarr.trace.txt) via the UI or the log file](https://wiki.servarr.com/radarr/troubleshooting#standard-logs-location) on the filesystem and find the relevant context
5. Copy a big chunk before the issue, the issue itself, and a big chunk after the issue.
6. Use [Gist](https://gist.github.com/), [0bin ( **Be sure to disable colorization**)](https://0bin.net/), [PrivateBin](https://privatebin.net/), [Notifiarr PrivateBin](http://logs.notifiarr.com/), [Hastebin](https://hastebin.com/), [Ubuntu's Pastebin](https://pastebin.ubuntu.com/), or similar sites - excluding those noted to avoid below - to share the copied logs from above

**Warnings:**

- \*\*Do not use [pastebin.com](https://pastebin.com/) as their filters have a tendency to block the logs.
- Do not use [pastebin.pl](https://pastebin.pl/) as their site is frequently not accessible.
- Do not use [JustPasteIt](https://justpaste.it/) as their site does not facilitate reviewing logs.
- Do not upload your log as a file
- Do not upload and share your logs via Google Drive, Dropbox, or any other site not noted above.
- Do not archive (zip, tar (tarball), 7zip, etc.) your logs.
- Do not share console output, docker container output, or anything other than the application logs specified

**Important Note:**

- When using [0bin](https://0bin.net/), be sure to disable colorization and do not burn after reading.

- Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use N++. You can use the Notepad++ "Find in Files" function to search old log files as needed.

- **Unix Only:** Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use grep. For example if you want to find information about the movie/show/book/song/indexer "Shooter" you can run the following command `grep -inr -C 100 -e 'Shooter' /path/to/logs/*.trace*.txt` If your [Appdata Directory](https://wiki.servarr.com/radarr/appdata-directory) is in your home folder then you'd run: `grep -inr -C 100 -e 'Shooter' /home/$User/.config/logs/*.trace*.txt`


```none

```

Copy

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#standard-logs-location) Standard Logs Location

The log files are located in Radarr's [Appdata Directory](https://wiki.servarr.com/radarr/appdata-directory), inside the logs/ folder. You can also access the log files from the UI at System => Logs => Files.

> Note: The Logs ("Events") Table in the UI is not the same as the log files and isn't as useful. If you're asked for logs, please copy/paste from the log files and not the table.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#update-logs-location) Update Logs Location

The update log files are located in Radarr's [Appdata Directory](https://wiki.servarr.com/radarr/appdata-directory), inside the UpdateLogs/ folder.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#sharing-logs) Sharing Logs

The logs can be long and hard to read as part of a forum or Reddit post and they're spammy in Discord, so please use [Pastebin](https://pastebin.ubuntu.com/), [Hastebin](https://hastebin.com/), [Gist](https://gist.github.com/), [0bin](https://0bin.net/), or any other similar pastebin site. The whole file typically isn't needed, just a good amount of context from before and after the issue/error. Do not forget to wait for spammy tasks like an RSS sync or library refresh to finish.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#tracedebug-logs) Trace/Debug Logs

You can change the log level at Settings => General => Logging. Radarr does not need to restarted for the change to take effect. This change only affects the log files, not the logging database. The latest debug/trace log files are named `radarr.debug.txt` and `radarr.trace.txt` respectively.

If you're unable to access the UI to set the logging level you can do so by editing config.xml in the AppData directory by setting the LogLevel value to Debug or Trace instead of Info.

```xml

```

Copy

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#clearing-logs) Clearing Logs

You can clear log files and the logs database directly from the UI, under System => Logs => Files and System => Logs => Delete (Trash Can Icon)

# [¶](https://wiki.servarr.com/radarr/troubleshooting\#multiple-log-files) Multiple Log Files

Radarr uses rolling log files limited to 1MB each. The current log file is always ,`radarr.txt`, for the the other files `radarr.0.txt` is the next newest (the higher the number the older it is). This log file contains `fatal`, `error`, `warn`, and `info` entries.

When Debug log level is enabled, additional `radarr.debug.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It usually covers a 40h period.

When Trace log level is enabled, additional `radarr.trace.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most.

# [¶](https://wiki.servarr.com/radarr/troubleshooting\#recovering-from-a-failed-update) Recovering from a Failed Update

- We do everything we can to prevent issues when upgrading, but if they do occur this will walk you through the steps to take to recover your installation.
- This section also covers common post-update issues.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#determine-the-issue) Determine the issue

- The best place to look when the application will not start after an update is to review the [update logs](https://wiki.servarr.com/radarr/troubleshooting#update-logs-location) and see if the update completed successfully. If those do not have an issue then the next step is to look at your regular application log files, before trying to start again, use [Logging](https://wiki.servarr.com/radarr/settings#logging) and [Log Files](https://wiki.servarr.com/radarr/system#log-files) to find them and increase the log level.
- The most frequently seen issue is that the system the app is installed on messed with the `/tmp` directory and deleted critical \*Arr files during the upgrade thus causing both the upgrade and rollback to fail. In this case, simply reinstall in-place over the existing borked installation.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#database-disk-image-is-malformed) Database disk image is malformed

- See our [FAQ Entry](https://wiki.servarr.com/radarr/faq#i-am-getting-an-error-database-disk-image-is-malformed)

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#migration-issue) Migration Issue

- Migration errors will not be identical, but here is an example:

```none

```

Copy

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#ui-migration-issues) UI Migration Issues

- If you switch between [unsupported versions/branches](https://wiki.servarr.com/radarr/faq#can-i-switch-between-branches) then you may experience a migration issue that looks like the below. The solution is to [go back to the branch or higher version you were on previously](https://wiki.servarr.com/radarr/faq#how-do-i-update-radarr), or [restore a back-up](https://wiki.servarr.com/radarr/faq#how-do-i-backuprestore-radarr) for your current version.

![radarr-migration-error-ui.png](https://wiki.servarr.com/assets/radarr/radarr-migration-error-ui.png)

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#permission-issue) Permission Issue

- Permissions issues are due to the application being unable to access the the relevant temporary folders and/or the app binary folder. Fix the permissions so the user/group the application runs as has the appropriate access.

- Synology users may encounter this Synology bug `Access to the path '/proc/{some number}/maps is denied`

- Synology users may also encounter being out of space in `/tmp` on certain NASes. You'll need to specify a different `/tmp` path for the app. See the SynoCommunity or other Synology support channels for help with this.


## [¶](https://wiki.servarr.com/radarr/troubleshooting\#resolving-the-issue) Resolving the issue

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#migration-issues) Migration Issues

In the event of a migration issue there is not much you can do immediately, if the issue is specific to you (or there are not yet any posts), please swing by our [discord](https://radarr.video/discord), if there are others with the same issue, then rest assured we are working on it.

> Please ensure you did not try to use a database from `nightly` on the stable version. Branch hopping is ill-advised.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#permissions-issues) Permissions Issues

- Fix the permissions to ensure the user/group the application is running as can access (read and write) to both `/tmp` and the installation directory of the application.

- For Synology users experiencing issues with `/proc/###/maps` stopping Sonarr or the other \*Arr applications and updating should resolve this. This is an issue with the SynoCommunity package.


### [¶](https://wiki.servarr.com/radarr/troubleshooting\#manually-upgrading) Manually upgrading

Grab the latest release from our website.

Install the update (.exe) or extract (.zip) the contents over your existing installation and re-run Radarr as you normally would.

# [¶](https://wiki.servarr.com/radarr/troubleshooting\#downloads-and-importing) Downloads and Importing

Downloading and importing is where _most_ people experience issues. From a high level perspective, Radarr needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even _bigger_ variety of setups. This means that while there are some _common_ setups, there isn’t one _right_ setup and everyone’s setup can be a little different.

> **The first step is to turn logging up to Trace, see [Logging and Log Files](https://wiki.servarr.com/radarr/troubleshooting#logging-and-log-files) for details on adjusting logging and searching logs. You’ll then reproduce the issue and use the trace level logs from that time frame to examine the issue.** If someone is helping you, put context from before/after in a [pastebin](https://0bin.net/), [Gist](https://gist.com/), or similar site to show them. It doesn’t need to be the whole file and it shouldn’t _just_ be the error. You should also reproduce the issue while tasks that spam the log file aren’t running.

When you reach out for help, be sure to read [asking for help](https://wiki.servarr.com/radarr/troubleshooting#asking-for-help) so that you can provide us with the details we’ll need.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#testing-the-download-client) Testing the Download Client

Ensure your download client(s) are running. Start by testing the download client, if it doesn’t work you’ll be able to see details in the trace level logs. You should find a URL you can put into your browser and see if it works. It could be a connection problem, which could indicate a wrong ip, hostname, port or even a firewall blocking access. It might be obvious, like an authentication problem where you’ve gotten the username, password or apikey wrong. Note that some seedboxes require the use of https, port 443, and a URL Base (advanced options), instead of your download client's real port.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#testing-a-download) Testing a Download

Now we’ll try a download, pick a movie and do a manual search. Pick one of those files and attempt to download it. Does it get sent to the download client? Does it end up with the correct category? Does it show up in Activity? Does it end up in the trace level logs during the **Check For Finished Download** tasks (Refresh Monitored Downloads and Process Monitored Downloads tasks) which runs roughly every minute? Does it get correctly parsed during that task? Does the queued up download have a reasonable name? Since searches by are by id on some indexers/trackers, it can queue one up with a name that it can’t recognize.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#testing-an-import) Testing an Import

Import issues should almost always manifest as an item in Activity with an orange icon you can hover to see the error. If they’re not showing up in Activity, this is the issue you need to focus on first so go back and figure that out. Most import errors are _permissions_ issues, remember that needs to be able to read and write in the download folder. Sometimes, permissions in the library folder can be at fault too, so be sure to check both.

Incorrect path issues are possible too, though less common in normal setups. The key to understanding path issues is knowing that gets the path to the download _from_ the download client, via its API. This becomes a problem in more unique use cases, like the download client running on a different system (maybe even OS!). It can also occur in a Docker setup, when volumes are not done well. A remote path map is a good solution where you don’t have control, like a seedbox setup. On a Docker setup, fixing the paths is a better option.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#common-problems) Common Problems

Below are some common problems.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#download-clients-webui-is-not-enabled) Download Client's WebUI is not enabled

Radarr talks to you download client via it's API and accesses it via the client's webui. You must ensure the client's webui is enabled and the port it is using does not conflict with any other client ports in use or ports in use on your system.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#ssl-in-use-and-incorrectly-configured) SSL in use and incorrectly configured

Ensure SSL encryption is not turned on if you're using both your instance and your download client on a local network. See [the SSL FAQ entry](https://wiki.servarr.com/radarr/faq#invalid-certificate-and-other-HTTPS-or-SSL-issues) for more information.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#cant-see-share-on-windows) Can’t see share on Windows

The default user for a Windows service is `LocalService` which typically doesn’t have access to your shares. Edit the service and set it up to run as your own user, see the FAQ entry [why can’t see my files on a remote server](https://wiki.servarr.com/radarr/faq#why-cant-i-see-my-files-on-a-remote-server) for details.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#mapped-network-drives-are-not-reliable) Mapped network drives are not reliable

While mapped network drives like `X:\` are convenient, they aren’t as reliable as UNC paths like `\\server\share` and they’re also not available before login. Setup and your download client(s) so that they use UNC paths as needed. If your library is on a share, you’d make sure your root folders are using UNC paths. If your download client sends to a share, that is where you’ll need to configure UNC paths since gets the download path from the download client. It is fine to keep your mapped network drives to use yourself, just don’t use them for automation.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#docker-and-user-group-ownership-permissions-and-paths) Docker and user, group, ownership, permissions and paths

Docker adds another layer of complexity that is easy to get wrong, but still end up with a setup that functions, but has various problems. Instead of going over them here, read this wiki article [for these automation software and Docker](https://wiki.servarr.com/docker-guide) which is all about user, group, ownership, permissions and paths. It isn’t specific to any Docker system, instead it goes over things at a high level so that you can implement them in your own environment.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#remote-path-mapping) Remote Path Mapping

If you have Radarr in Docker and the Download Client in non-Docker (or vice versa) or have the programs on different servers then you may need a remote path map.

Logs will indicate something similar to.

```none

```

Copy

Thus `/volume3/data` does not exist within Radarr's container or is not accessible.

- [Settings => Download Clients => Remote Path Mappings](https://wiki.servarr.com/radarr/settings#remote-path-mappings)
- A remote path mapping is used when your download client is reporting a path for completed data either on another server or in a way that \*Arr doesn't address that folder.
- Generally, a remote path map is only required if your download client is on Linux when \*Arr is on Windows or vice versa. A remote path map is also possibly needed if mixing Docker and Native clients or if using a remote server.
- A remote path map is a DUMB search/replace (where it finds the REMOTE value, replace it with LOCAL value for the specified Host).
- If the error message about a bad path does not contain the REPLACED value, then the path mapping is not working as you expect. The typical solution is to add and remove the mapping.
- [See TRaSH's Tutorial for additional information regarding remote path mapping](https://trash-guides.info/Radarr/Radarr-remote-path-mapping/)

> If both \*Arr and your Download Client are Docker Containers it is rare a remote path map is needed. It is suggested you [review the Docker Guide](https://wiki.servarr.com/docker-guide) and/or [follow TRaSH's Tutorial](https://trash-guides.info/hardlinks)

#### [¶](https://wiki.servarr.com/radarr/troubleshooting\#remote-mount-or-remote-sync-syncthing) Remote Mount or Remote Sync (Syncthing)

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

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#permissions-on-the-library-folder) Permissions on the Library Folder

Logs will look like

```none

```

Copy

Don’t forget to check permissions and ownership of the _destination_. It is easy to get fixated on the download’s ownership and permissions and that is _usually_ the cause of permissions related issues, but it _could_ be the destination as well. Check that the destination folder(s) exist. Check that a destination _file_ doesn’t already exist or can’t be deleted or moved to recycle bin. Check that ownership and permissions allow the downloaded file to be copied, hard linked or moved. The user or group that runs as needs to be able to read and write the root folder.

- For Windows Users this may be due to running as a service:

  - the Windows Service runs under the 'Local Service' account, by default this account does not have permissions to access your user's home directory unless permissions have been assigned manually. This is particularly relevant when using download clients that are configured to download to your home directory.
  - 'Local Service' also generally has very limited permissions. It's therefore advisable to install the app as a system tray application if the user can remain logged in. The option to do so is provided during the installer. See the FAQ for how to convert from a service to tray app.
- For Synology Users refer to [SynoCommunity's Permissions Article for their Packages](https://github.com/SynoCommunity/spksrc/wiki/Permission-Management)

- Non-Windows: If you're using an NFS mount ensure `nolock` is enabled.

- If you're using an SMB mount ensure `nobrl` is enabled.


### [¶](https://wiki.servarr.com/radarr/troubleshooting\#permissions-on-the-downloads-folder) Permissions on the Downloads Folder

Logs will look like

```none

```

Copy

Don’t forget to check permissions and ownership of the _source_. It is easy to get fixated on the destination's ownership and permissions and that is a _possible_ cause of permissions related issues, but it _typically_ is the source. Check that the source folder(s) exist - and if docker that the mounts are aligned and consistent. Check that ownership and permissions allow the downloaded file to be copied/hardlinked or copy+delete/moved. The user or group that runs as needs to be able to read and write the downloads folder.

- For Windows Users this may be due to running as a service:

  - the Windows Service runs under the 'Local Service' account, by default this account does not have permissions to access your user's home directory unless permissions have been assigned manually. This is particularly relevant when using download clients that are configured to download to your home directory.
  - 'Local Service' also generally has very limited permissions. It's therefore advisable to install the app as a system tray application if the user can remain logged in. The option to do so is provided during the installer. See the FAQ for how to convert from a service to tray app.
- For Synology Users refer to [SynoCommunity's Permissions Article for their Packages](https://github.com/SynoCommunity/spksrc/wiki/Permission-Management)

- Non-Windows: If you're using an NFS mount ensure `nolock` is enabled.

- If you're using an SMB mount ensure `nobrl` is enabled.


### [¶](https://wiki.servarr.com/radarr/troubleshooting\#download-folder-and-library-folder-not-different-folders) Download folder and library folder not different folders

- The download client should download into a folder accessible by \*Arr and that is not your root/library folder; should import from that separate download folder into your Library folder.
- You should never download directly into your root folder. You also should not use your root folder as the download client's completed folder or incomplete folder.
- [**This will also cause a healthcheck in System as well**](https://wiki.servarr.com/radarr/system#downloading-into-root-folder)
- Within the application, a root folder is defined as the configured media library folder. This is not the root folder of a mount. Your download client has an incomplete or complete (or is moving completed downloads) into your root (library) folder. This frequently causes issues and is not advised. To fix this change your download client so it is not placing downloads within your root folder. Note that 'placing' also includes if your download client category is set to your root folder or if NZBGet/SABnzbd have sort enabled and are sorting to your root folder. Please note that this check looks at all defined/configured root folders added not only root folders currently in use. In other words, the folder your download client downloads into or moves completed downloads to, should not be the same folder you have configured as your root/library/final media destination folder in the \*Arr application.
- Configured Root Folders (aka Library folders) can be found in [Settings => Media Management => Root Folders](https://wiki.servarr.com/radarr/settings/#root-folders)
- One example is if your downloads are going into `\data\downloads` then you have a root folder set as `\data\downloads`.
- It is suggested to use paths like `\data\media\` for your root folder/library and `\data\downloads\` for your downloads.

> Your download folder and your root/library folder MUST be separate

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#incorrect-category) Incorrect category

Radarr should be setup to use a category so that it only tries to process its own downloads. It is rare that a torrent submitted by gets added without the correct category, but it can happen. If you’re adding torrents manually and want to process them, they’ll need to have the correct category. It can be set at any time, since tries to process downloads every minute.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#packed-torrents) Packed torrents

Logs will indicate errors like

```none

```

Copy

If your torrent is packed in `.rar` files, you’ll need to setup extraction. We recommend [Unpackerr](https://github.com/unpackerr/unpackerr) as it does unpacking right: preventing corrupt partial imports and cleans up the unpacked files after import.

The error by also be seen if there is no valid media file in the folder.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#repeated-downloads) Repeated downloads

There are a few causes of repeated downloads, but one is related to Custom Formats. It's possible the release name matches a custom format, but the download files do not. This gets you into a loop where you download the items again and again because it looks like an upgrade, then isn’t, then shows up again and looks like an upgrade, then isn’t. Depending on your custom format you may be able to work around this by including the custom format in your renaming schema. (Enable the Custom Format to be included in renaming & then add Custom Format to you renaming schema)

This may also be due to the fact that the download never actually imports and then is missing from the queue, so a new download is perpetually grabbed and never imported. Please see the various other common problems and troubleshooting steps for this.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#usenet-download-misses-import) Usenet download misses import

Radarr only looks at the 60 most recent downloads in SABnzbd and NZBGet, so if you _keep_ your history this means that during large queues with import issues, downloads can be silently missed and not imported. The best way to avoid that is to keep your history clear, so that any items that still appear need investigating. You can achieve this by enabling Remove under Completed and Failed Download Handler. In NZBGet, this will move items to the _hidden_ history which is great. Unfortunately, SABnzbd does not have a similar feature. The best you can achieve there is to use the nzb backup folder.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#download-client-clearing-items) Download client clearing items

The download client should _not_ be responsible for removing downloads. Usenet clients should be configured so they _don’t_ remove downloads from history. Torrent clients should be setup so they _don’t_ remove torrents when they’re finished seeding (pause or stop instead). This is because communicates with the download client to know what to import, so if they’re _removed_ there is nothing to be imported… even if there is a folder full of files.

For SABnzbd, this is handled with the History Retention setting.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#download-cannot-be-matched-to-a-library-item) Download cannot be matched to a library item

For various reasons, releases cannot be parsed once grabbed and sent to the download client. Activity => Options => Show Unknown (this is now enabled by default in recent builds) will display all items not otherwise ignored / already imported within \*Arr's download client category. These will typically need to be manually mapped and imported.

Reasons Include:

- Movie Name has a `:` on TMDb and TMDb has no alt title with a `-` or with a \`\` replacing the `:`
- File Name is missing the year which is required
- AKA or weird multiple names; Radarr has limited support for these
- File Name matches to multiple movies
- Release Name or Release ID from the indexer does not match the file name

This can also occur if you have a release in your download client but that media item (movie/episode/book/song) does not exist in the application.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#the-underlying-connection-was-closed-an-unexpected-error-occurred-on-a-send) The underlying connection was closed: An unexpected error occurred on a send

This is caused by the indexer using a SSL protocol not supported by the current .NET Version found in [Radarr => System => Status](https://wiki.servarr.com/radarr/system#status).

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#the-request-timed-out) The request timed out

Radarr is getting no response from the client.

```none

```

Copy

```none

```

Copy

This can also be caused by:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues - Try changing to a different DNS provider
- local IPv6 issues - typically IPv6 is enabled, but non-functional
- the use of Privoxy and it being improperly configured

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#download-doesnt-contain-intermediate-path) Download doesn't contain intermediate path

There was no output path reported from your download client for this item.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#problem-not-listed) Problem Not Listed

You can also review some common permissions and networking troubleshooting commands [in our guide](https://wiki.servarr.com/permissions-and-networking). Otherwise please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.

# [¶](https://wiki.servarr.com/radarr/troubleshooting\#searches-indexers-and-trackers) Searches Indexers and Trackers

- If you use [Prowlarr](https://wiki.servarr.com/prowlarr), then you can view the [History](https://wiki.servarr.com/prowlarr/history) of all queries Prowlarr received and how they were sent to the sites. Ensure that `Parameters` is enabled in Prowlarr History => Options. The (i) icon provides additional details.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#turn-logging-up-to-trace) Turn logging up to trace

> **The first step is to turn logging up to Trace, see [Logging and Log Files](https://wiki.servarr.com/radarr/troubleshooting#logging-and-log-files) for details on adjusting logging and searching logs. You’ll then reproduce the issue and use the trace level logs from that time frame to examine the issue.** If someone is helping you, put context from before/after in a [pastebin](https://0bin.net/), [Gist](https://gist.com/), or similar site to show them. It doesn’t need to be the whole file and it shouldn’t _just_ be the error. You should also reproduce the issue while tasks that spam the log file aren’t running.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#testing-an-indexer-or-tracker) Testing an Indexer or Tracker

When you test an indexer or tracker, in debug or trace logs you can find the URL used. An example of a successful test is below, you can see it query the indexer via a specific URL with specific parameters and then the response. You test this url in your browser like replacing the `apikey=(removed)` with the correct apikey like `apikey=123`. You can experiment with the parameters if you’re getting an error from the indexer or see if you have connectivity issues if it doesn’t even work. After you’ve tested in your own browser, you should test from the system is running on _if_ you haven’t already.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#testing-a-search) Testing a Search

Just like the indexer/tracker test above, when you trigger a search while at Debug or Trace level logging, you can get the URL used from the log files. While testing, it is best to use as narrow a search as possible. A manual search is good because it is specific and you can see the results in the UI while examining the logs.

In this test, you’ll be looking for obvious errors and running some simple tests. You can see the search used the url `https://api.nzbgeek.info/api?t=movie&cat=2000&apikey=(removed)&q=O+Brother+Where+Art+Thou`, which you can try yourself in a browser after replacing `(removed)` with your apikey for that indexer. Does it work? Do you see the expected results? In that URL, you can see that it set the specific category of 2000, so if you’re not seeing expected results, this is one likely reason. If the movie isn’t properly categorized on the indexer, it will need to be fixed. Look at Manual Search XML Output below to see an example of a working query’s output.

- Manual Search XML Output

```xml

```

Copy

_**Images needed**_

![searches-indexers-and-trackers1.png](https://wiki.servarr.com/assets/radarr/searches-indexers-and-trackers1.png)

![searches-indexers-and-trackers2.png](https://wiki.servarr.com/assets/radarr/searches-indexers-and-trackers2.png)

- Trace Log Snippet

```none

```

Copy

- Full Trace Log of a Search

```none

```

Copy

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#common-problems-1) Common Problems

Below are some common problems.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#unable-to-load-search-results) Unable to Load Search Results

Most likely you're using a reverse proxy and you reverse proxy timeout is set too short before \*Arr has completed the search query. Increase the timeout and try again.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#tracker-needs-rawsearch-caps) Tracker needs RawSearch Caps

- Radarr is searching for `Kikis Delivery Service` but your tracker only has results for `Kiki's Delivery Service`
- This is due to your tracker not supporting normal standardized searches.
- The solution is that your tracker's definition's search capabilities need to be updates to indicate it [requires and supports `RawSearch`](https://github.com/Radarr/Radarr/issues/4502#issuecomment-981143905)
- Jackett supports the flag, but the capabilities need to be updated on a per-indexer basis. Open a feature request for Jackett to add this functionality for your indexer.
- Prowlarr supports the flag, but the capabilities need to be updated on a per-indexer basis. Open a feature request for Prowlarr to add this functionality for your indexer.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#media-is-unmonitored) Media is Unmonitored

The movie(s) is(are) not monitored.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#wrong-categories) Wrong categories

Incorrect categories is probably the most common cause of results showing in manual searches of an indexer/tracker, but _not_ in . The indexer/tracker _should_ show the category in the search results, which should help you figure out what is missing. If you’re using Jackett or Prowlarr, each tracker has a list of specifically supported categories. Make sure you’re using the correct ones for Categories. Many find it helpful to have the list visible in one browser window while they edit the entry in.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#indexer-needs-year-removed-in-search) Indexer needs year removed in search

Some indexers don't return results with the year for the search. There is an Indexer Advanced option to remove the year from the search string. Note that year in the release name is still required for Radarr to parse the title.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#query-successful-no-results-returned) Query Successful - No Results returned

You receive a message similar to `Query successful, but no results were returned from your indexer. This may be an issue with the indexer or your indexer category settings.`

This is caused by your Indexer failing to return any results that are within the categories you configured for the Indexer.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#wrong-results) Wrong results

Sometimes indexers will return completely unrelated results, Radarr will feed in parameters to limit the search, but the results returned are completely unrelated. Or sometimes, mostly related with a few incorrect results. The first is usually an indexer problem and you’ll be able to tell from the trace logs which is causing it. You can disable that indexer and report the problem. The other is usually categorized releases which should be reportable on the indexer/tracker.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#missing-results) Missing Results

If you have results on the site you can find that are not showing in Radarr then your issue is likely one of several possibilities:

- [Categories are incorrect - See Above](https://wiki.servarr.com/radarr/troubleshooting#wrong-categories)
- An ID (IMDbId, TMDbId, etc.) based searched is being done and the Indexer does not have the releases correctly mapped to that ID. This is something only your indexer can solve. They need to ensure the release is mapped to the correct applicable ids.
- Not searching how Radarr is searching; It's highly likely the terms you are searching on the indexer is not how Radarr is querying it. You can see how Radarr is querying from the Trace Logs. Text based queries will generally be in the format of `q=words%20and%20things%20here` this string is HTTP encoded and can be easily decoded using any HTML decoding/encoding tool online.
- [See the FAQ for how Foreign and Alternative Movie Titles are handled & when Radarr would search them](https://wiki.servarr.com/radarr/faq#how-does-radarr-handle-foreign-movies-or-foreign-titles)

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#certificate-validation) Certificate validation

You’ll be connecting to most indexers/trackers via https, so you’ll need that to work properly on your system. That means your time zone and time both need to be set _correctly_. It also means your system certificates need to be up to date.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#hitting-rate-limits) Hitting rate limits

If you run your through a VPN or proxy, you may be competing with 10s or 100s or 1000s of other people all trying to use services like , theXEM ,and/or your indexers and trackers. Rate limiting and DDOS protection are often done by IP address and your VPN/proxy exit point is _one_ IP address. Unless you’re in a repressive country like China, Australia or South Africa you don’t need to VPN/proxy .

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#ip-ban) IP Ban

Similarly to rate limits, certain indexers - such as Nyaa - may outright ban an IP address. This is typically semi-permanent and the solution is to to get a new IP from your ISP or VPN provider.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#year-doesnt-match) Year doesn't match

- [See this FAQ Entry](https://wiki.servarr.com/radarr/faq#how-does-radarr-determine-the-year-of-a-movie)
  - Radarr gets metadata from TMDb
  - Radarr uses the year of the oldest **Theatrical Release** date and the oldest **Premier** date for matching
- In some cases, the movie was pushed or shifted around and the year being used by the release groups do not match neither the oldest Premier date year nor the oldest Theatrical date year. In these situations, you must grab and import manually.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#missing-year) Missing year

Radarr will not grab a release if the release name doesn't contain a year. This is a bad release, and can only be manually grabbed. This is a common thing to overlook when trying to figure out why a movie was not grabbed as expected.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#using-the-jackett-all-endpoint) Using the Jackett /all endpoint

The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is required. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative [Prowlarr](https://wiki.servarr.com/prowlarr)

[Even Jackett says /all should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)

Using the all endpoint has no advantages (besides reduced management overhead), only disadvantages:

- you lose control over indexer specific settings (categories, search modes, etc.)
- mixing search modes (IMDB, query, etc.) might cause low-quality results
- indexer specific categories (>= 100000) cannot be used.
- slow indexers will slow down the overall result
- total results are limited to 1000

Adding each indexer separately It allows for fine tuning of categories on a per indexer basis, which can be a problem with the `/all` end point if using the wrong category causes errors on some trackers. In , each indexer is limited to 1000 results if pagination is supported or 100 if not, which means as you add more and more trackers to Jackett, you’re more and more likely to clip results. Finally, if _one_ of the trackers in `/all` returns an error, will disable it and now you don’t get any results.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#using-nzbhydra2-as-a-single-entry) Using NZBHydra2 as a single entry

Using NZBHydra2 as a single indexer entry (i.e. 1 NZBHydra2 Entry in Radarr for many indexers in NZBHydra2) rather than multiple (i.e. many NZBHydra2 entries in Radarr for many indexers in NZBHydra2) has the same problems as noted above with Jackett's `/all` endpoint.

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#invalid-response-received-from-tmdb) Invalid response received from TMDB

If you are performing a search, and get this error message, please check your log. If the error code is "503.ServiceUnavailable", then you have one of these issues going on:

1. You are using a Unifi router, and have ad blocking turned on. Unifi has decided that all .video sites should be blocked, which includes Radarr's metadata server. To solve this, either turn off ad blocking entirely on Unifi, or add a whitelist for the radarr.video domain.

2. You are in Russia or Belarus, or are using a VPN whose IP address is associated with Russia or Belarus. You may use [this Cloudflare Page to Geolocate your IP](https://radar.cloudflare.com/ip). Radarr via Cloudflare's blocking uses [MaxMind](https://www.maxmind.com/en/locate-my-ip-address) to determine geolocation, and sometimes they get it wrong and cause false positives. You can report false positives to MaxMind, or if you're on a VPN, get a different IP. If you truly are in Russia or Belarus, you are blocked from using Radarr.

3. The Radarr metadata server is temporarily down. It'll be back up shortly.


### [¶](https://wiki.servarr.com/radarr/troubleshooting\#problem-not-listed-1) Problem Not Listed

You can also review some common permissions and networking troubleshooting commands [in our guide](https://wiki.servarr.com/permissions-and-networking). Otherwise please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.

## [¶](https://wiki.servarr.com/radarr/troubleshooting\#errors) Errors

These are some of the common errors you may see when adding an indexer

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#the-underlying-connection-was-closed-an-unexpected-error-occurred-on-a-send-1) The underlying connection was closed: An unexpected error occurred on a send

This is caused by the indexer using a SSL protocol not supported by the current .NET Version found in [Radarr => System => Status](https://wiki.servarr.com/radarr/system#status).

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#the-request-timed-out-1) The request timed out

Radarr is getting no response from the indexer.

```none

```

Copy

```none

```

Copy

This can also be caused by:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues - Try changing to a different DNS provider
- local IPv6 issues - typically IPv6 is enabled, but non-functional
- the use of Privoxy and it being improperly configured

### [¶](https://wiki.servarr.com/radarr/troubleshooting\#problem-not-listed-2) Problem Not Listed

You can also review some common permissions and networking troubleshooting commands [in our guide](https://wiki.servarr.com/permissions-and-networking). Otherwise please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.