<!-- Source: https://wiki.servarr.com/radarr/tips-and-tricks -->

* * *

Radarr Tips and Tricks

Advanced tips and tricks for optimizing Radarr configuration and workflow

* * *

Page Contents

TRaSH's Custom Formats

Syncing Two Radarr Instances

Renaming Movie Folders

Creating a Folder for Each Movie

Filebot

Files 2 Folder

Linux Bash Script

Windows Command Line

Windows Powershell

Configuring Radarr to Auto-Remove Completed Torrents

Tags

[radarr](https://wiki.servarr.com/t/radarr) [configuration](https://wiki.servarr.com/t/configuration) [tips](https://wiki.servarr.com/t/tips) [tricks](https://wiki.servarr.com/t/tricks) [optimization](https://wiki.servarr.com/t/optimization) [workflow](https://wiki.servarr.com/t/workflow) [Pages matching tags](https://wiki.servarr.com/t/radarr/configuration/tips/tricks/optimization/workflow)

Last edited by

Administrator

09/06/2025

# [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#trashs-custom-formats) TRaSH's Custom Formats

- [TRasH has a guide](https://trash-guides.info/Radarr/) on how to use [Radarr => Settings => Custom Formats](https://wiki.servarr.com/radarr/settings#custom-formats) as well as a shared repository of Custom Formats.

# [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#syncing-two-radarr-instances) Syncing Two Radarr Instances

- TRaSH has [a guide](https://trash-guides.info/Radarr/Tips/Sync-2-radarr-sonarr/) for syncing two instances

# [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#renaming-movie-folders) Renaming Movie Folders

- [See this FAQ Entry](https://wiki.servarr.com/radarr/faq#how-can-i-rename-my-movie-folders)

# [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#creating-a-folder-for-each-movie) Creating a Folder for Each Movie

- This is only needed to cleanup / organize and existing library to facilitate importing into Radarr. Below are a few different methods.

## [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#filebot) Filebot

> Filebot is supported on Windows, Linux, and MacOS

- [Filebot](https://www.filebot.net/) is a fantastic utility for getting your movies organized in a way that Radarr can successfully parse. Version 4.7.9 can still be downloaded for free from a SourceForge mirror, but there are also paid versions in the Windows and Apple stores. On Linux, your distribution of choice may have a package for it, like in Arch’s AUR package or `.deb` files for Debian/Ubuntu from their download page. It has both a GUI and a CLI, so it should satisfy almost everyone.

- There is great help available, including their format expressions page. My personal suggestion is to use something like `{ny}\{fn}` if your files include useful details like quality, edition and/or group or `{ny}/{ny} [{dim[0] >= 1280 ? 'Bluray' : 'DVD'}-{vf}]` if they don’t, which would yield `Movie (Year)/Movie (Year) [Bluray-1080p]` or `Movie (Year)/Movie (Year) [DVD-480p]` for example. Instead of Bluray, you could also use WEBDL if you’d rather your collection be considered that.

- To keep this pattern for future movies, you should set:

- [Settings => Media Management (Advanced Settings Shown) => Movie Naming](https://wiki.servarr.com/radarr/settings#media-management)

  - File: `{Movie CleanTitle} {(Release Year)} {Edition Tags} {[Quality Title]}`
  - Folder: `{Movie CleanTitle} {(Release Year)}`
- Note: You can replace the spaces above with `.` or `_` if you prefer that naming format.


## [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#files-2-folder) Files 2 Folder

> Files 2 Folder is a Windows Application

[Files 2 Folder](http://www.dcmembers.com/skwire/download/files-2-folder/) can movie library orgainzed for import into Radarr. Simply extract the zip to your computer and run the .exe as administrator, then click yes to add it to your right click menu.

Once installed it is only a few clicks to organize all your files into their own folders.

1. Browse to your movie folder
2. Select all files and right click to bring up the menu
3. Select the `files 2 folder` option in the menu
4. In the Files 2 Folder window select `Move each file to individual subfolders based on their names`
5. Click OK
6. Wait a moment and all your files will be in their own folder.

## [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#linux-bash-script) Linux Bash Script

The following script will take all `*.mkv` files within your selected folder and move them into a folder based on their name. Note that this does not go into subfolders within the starting/selected folder.

```shell

```

Copy

## [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#windows-command-line) Windows Command Line

Drop to a command line in Windows (cmd.exe) `As Administrator`. Navigate to your movie folder. Run these two commands (copy/paste is fine, there is nothing to change):

`for %i in (*) do md "%~ni"`

This will create a folder for every file in the directory.

`for %i in (*) do move "%i" "%~ni"`

This will move all of your files into the new directories.

If you need to clean up empty directories, this command will do that:

`for /f "usebackq delims=" %d in ("dir /ad/b/s | sort /R") do rd "%d"`

## [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#windows-powershell) Windows Powershell

Alternatively in Windows you can run the following script in Powershell to iterate over each file in a directory, and move it to a folder with the same name.

```powershell

```

Copy

# [¶](https://wiki.servarr.com/radarr/tips-and-tricks\#configuring-radarr-to-auto-remove-completed-torrents) Configuring Radarr to Auto-Remove Completed Torrents

Radarr can be configured to auto-remove torrents (and their files) upon meeting seed goals. This guide will use Qbittorrent as an example, but most download clients will work.

Caveats:

```text

```

Copy

If you use Prowlarr on full sync, then you should be setting these values in Prowlarr!

1. In Radarr, go to Settings -> Indexers. Click on each indexer. In that indexer, click Show Advanced. Set the Seed Ratio value to at least "1", and the Seed Time value to at least 300. You may leave one of those values blank, if you only want either time or ratio. If you set both, the first value that is met triggers the removal (i.e. if it hits 1.0 ratio in 120 minutes, it would be removed even though it hasn't met the time value).

![radarr-seed-time.png](https://wiki.servarr.com/images/radarr-seed-time.png)

2. Repeat this for all of your torrent indexers. You can set different goals for each indexer. Note that you should add 10-20% over what your private indexers require, because the way that your download client calculates time/ratio is slightly different than what your indexers do, and setting it too close to requirements can result in hit & runs.

3. In Qbittorrent, go to Tools / Options / BitTorrent. You will have to check one of the seed goal items in order to be able to select from the drop-down. Change the drop-down to "Stop Torrent" (on older versions of Qbittorrent, this is Pause Torrent). Then you can un-check the box again, if you don't want Qbittorrent to have any default values set.

![qbit-remove-settings.png](https://wiki.servarr.com/images/qbit-remove-settings.png)


Now you're done. New grabs should have the values you've set, and when they're done they should Stop in Qbittorrent, and be removed shortly thereafter by Radarr.