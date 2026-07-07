> Source: https://wiki.servarr.com/sonarr/faq



> For Sonarr v4 specific FAQ entries - Please see the <a href="/sonarr/faq-v4" class="is-internal-link is-valid-page">Sonarr v4 FAQ</a>

# <a href="#sonarr-basics" class="toc-anchor">¶</a> Sonarr Basics

## <a href="#how-does-sonarr-find-episodes" class="toc-anchor">¶</a> How does Sonarr find episodes

- Sonarr does *not* regularly search for episode files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for *all* the newly posted episodes/newly uploaded releases, then compares that with its list of episodes that are missing or need to be upgraded. Any matches are downloaded. This lets Sonarr cover a library of *any size* with just 10-144 queries per day (RSS interval of 10-120 minutes). If you understand this, you will realize that it only covers the *future* though.
- So how do you deal with the present and past? When you're adding a show, you will need to set the correct path, profile and monitoring status then use the Start search for missing checkbox. If the show has had no episodes and hasn't been released yet, you do not need to initiate a search.
- Put another way, Sonarr will only find releases that are newly uploaded to your indexers. It will not actively try to find releases uploaded in the past.
- If you've already added the show, but now you want to search for it, you have a few choices. You can go to the show's page and use the search button, which will do a search and then automatically pick episode(s). You can search individual episodes or seasons automatically or manually. Or you can go to the <a href="/sonarr/wanted" class="is-internal-link is-valid-page">Wanted</a> tab and search from there.
- If Sonarr has been offline for an extended period of time, Sonarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Sonarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed episodes.

### <a href="#instances-when-auto-searching-does-occur" class="toc-anchor">¶</a> Instances When Auto Searching Does Occur

Active searching (via the indexer's API) is only done in the below situations. Note that the same rules as normal apply: series + episode must be monitored and episodes without an airdate are skipped

- Triggered Automatic or Manual Search
  - User or API triggered search. Typically executed by clicking the Automatic or Manual Search buttons on a specific episode, season, or series.
- Adding a show using the Add and Search button
- Using Wanted =\> Missing or Wanted =\> Cutoff Unmet to do one or more searches
- Recent Episodes
  - **New episodes** from TVDb in Skyhook that aired in the last 14 days or within 1 day into the future (to cover those episodes that may release a bit early) will be automatically searched for those episodes after the series folder is rescanned (to catch things imported outside of Sonarr)
  - **Absolute Numbering** Episodes with absolute numbers added to TVDb in Skyhook that aired in the last 14 days or within 1 day into the future

## <a href="#how-are-possible-downloads-compared" class="toc-anchor">¶</a> How are possible downloads compared

> Generally Quality Trumps All. If you wish to have Quality not be the main priority - you can merge your qualities together. <a href="https://trash-guides.info/merge-quality" class="is-external-link">See TRaSH's Guide</a>

- The current logic <a href="https://github.com/Sonarr/Sonarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs#L31-L41s" class="is-external-link">can always be found here</a>.

- As of 2024-01-16 the logic is as follows:

1.  Quality
2.  Custom Format Score
3.  Protocol (as configured in the relevant Delay Profile)
4.  Episode Count\*
5.  Episode Number
6.  Indexer Priority
7.  Seeds/Peers (If Torrent)
8.  Age (If Usenet)
9.  Size

> REPACKS and PROPERs are v2 of Qualities and thus rank above a non-repack of the same quality. <a href="/sonarr/settings#file-management" class="is-internal-link is-valid-page">Set Media Management =&gt; File Management <code>Download Proper &amp; Repacks</code> to "Do Not Prefer"</a> and use <a href="https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repackproper" class="is-external-link">TRaSH's Repack/Proper Custom Format</a> with a positive score as suggested by <a href="https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/" class="is-external-link">TRaSH's Guides</a>

> \* Use Custom Formats and TRaSH Guide's <a href="https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#season-pack" class="is-external-link">season pack custom format</a> with a score greater than zero to prefer season packs.

## <a href="#how-do-i-change-from-the-windows-service-to-a-tray-app" class="toc-anchor">¶</a> How do I change from the Windows Service to a Tray App

1.  Shut Sonarr down
2.  Run serviceuninstall.exe that's in the Sonarr directory
3.  Run Sonarr.exe as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
4.  (Optional) Drop a shortcut to Sonarr.exe in the startup folder to auto-start on boot.

## <a href="#how-do-i-backuprestore-my-sonarr" class="toc-anchor">¶</a> How do I Backup/Restore my Sonarr

### <a href="#backing-up-sonarr" class="toc-anchor">¶</a> Backing up Sonarr

#### <a href="#using-built-in-backup" class="toc-anchor">¶</a> Using built-in backup

- Go to System =\> Backup in the Sonarr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

#### <a href="#using-file-system-directly" class="toc-anchor">¶</a> Using file system directly

- Find the location of the AppData directory for Sonarr
  - Via the Sonarr UI go to System =\> About
  - <a href="/sonarr/appdata-directory" class="is-internal-link is-valid-page">Sonarr Appdata Directory</a>
- Stop Sonarr - This will prevent the database from being corrupted
- Copy the contents to a safe location

### <a href="#restoring-from-backup" class="toc-anchor">¶</a> Restoring from Backup

> Restoring to an OS that uses different paths will not work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database or use <a href="https://github.com/Notifiarr/toolbarr" class="is-external-link">Toolbarr</a>.

#### <a href="#using-zip-backup" class="toc-anchor">¶</a> Using zip backup

- Re-install Sonarr (if applicable / not already installed)
- Run Sonarr
- Navigate to System =\> Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

#### <a href="#using-file-system-backup" class="toc-anchor">¶</a> Using file system backup

- Re-install Sonarr (if applicable / not already installed)
- Find the location of the AppData directory for Sonarr
  - Running Sonarr once and via the UI go to System =\> About
  - <a href="/sonarr/appdata-directory" class="is-internal-link is-valid-page">Sonarr Appdata Directory</a>
- Stop Sonarr
- Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
- Restore from your backup
- Start Sonarr
- As long as the paths are the same, everything will pick up where it left off

#### <a href="#file-system-restore-on-synology-nas" class="toc-anchor">¶</a> File System Restore on Synology NAS

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.

- Re-install Sonarr (if applicable / not already installed)
- Find the location of the AppData directory for Sonarr
  - Running Sonarr once and via the UI go to System =\> About
  - <a href="/sonarr/appdata-directory" class="is-internal-link is-valid-page">Sonarr Appdata Directory</a>
- Stop Sonarr
- Connect to the Synology NAS through SSH and log in as root

> On some installations, the user is different than the below commands: `chown -R sc-Sonarr:Sonarr *`

- Execute the following commands:

``` prismjs
rm -r /usr/local/Sonarr/var/.config/Sonarr/Sonarr.db
cp -f /tmp/Sonarr_backup/* /usr/local/Sonarr/var/.config/Sonarr/
```

- Update permissions on the files:

``` prismjs
cd /usr/local/Sonarr/var/.config/Sonarr/
chown -R Sonarr:users *
chmod -R 0644 *
```

- Start Sonarr

## <a href="#help-i-have-locked-myself-out" class="toc-anchor">¶</a> Help I have locked myself out

> Authentication is now mandatory in v4 of Sonarr and the `AuthenticationMethod` type `None` is no longer valid - please see this <a href="/sonarr/faq-v4#forced-authentication" class="is-internal-link is-valid-page">v4 FAQ - Forced Authentication</a>

To disable authentication (to reset your forgotten username or password) you will need need to edit `config.xml` which will be inside the <a href="/sonarr/appdata-directory" class="is-internal-link is-valid-page">Sonarr Appdata Directory</a>

1.  Stop Sonarr
2.  Open config.xml in a text editor
3.  Find the authentication method line - will be  
    `<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`  
    ***(Be sure that you do not have two AuthenticationMethod entries in your file)***
4.  Remove the entire `AuthenticationMethod` line
5.  Restart Sonarr
6.  Sonarr will now be accessible without a password. When you open the Web UI, you should be prompted to set a new password and authentication method

## <a href="#why-are-there-two-files-why-is-there-a-file-left-in-downloads" class="toc-anchor">¶</a> Why are there two files? \| Why is there a file left in downloads

This is expected. With a setup that supports <a href="https://trash-guides.info/hardlinks" class="is-external-link">hardlinks</a>, double space will not be used. Below is how the Torrent Process works.

1.  Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
2.  Sonarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
3.  Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlinkthe file if supported by your setup or copy if not hard links are not supported.
4.  If the "Completed Download Handling - Remove Completed" option is enabled in Sonarr's settings, Sonarr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped (i.e. paused). See <a href="https://trash-guides.info/Downloaders/" class="is-external-link">TRaSH's Download Client Guides</a> for how to configure your download client optimally.

> Hard links are enabled by default. <a href="https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/" class="is-external-link">A hard link will not use any additional disk space</a>. The file system and mounts must be the same for your completed download directory and your media library. If the hard link creation fails or your setup does not support hard links then it will fall back and copy the file.

## <a href="#i-see-that-featurebug-x-was-fixed-why-can-i-not-see-it" class="toc-anchor">¶</a> I see that feature/bug X was fixed, Why can I not see it

Sonarr consists of two main branches of code, `main` and `develop`.

- `main`is released periodically, when the `develop` branch is stable
- `develop` is for pre-release testing and people willing to live on the edge. When a feature is marked as in `develop` it will only be available to users running the `develop` branch, once it has been move to live (in `main`) it is officially released.

## <a href="#episode-progress-how-is-it-calculated" class="toc-anchor">¶</a> Episode Progress - How is it calculated

- There are two parts to the episode count, one being the number of episodes (Episode Count) and the other being the number of episodes with files (Episode File Count), each one uses slightly different logic to give you the overall progress for a series or season.

  - Episode Count =\> Episode has already aired AND is monitored OR - Episode has a file
  - Episode File Count =\> Episode has a file

- If a series has 10 episodes that have all aired and you do not have any files for them you would have 0/10 episodes, if you unmonitored all the episodes in that series you would have 0/0 and if you got all the episodes for that series, regardless of if the episodes are monitored or not, you would have 10/10 episodes.

## <a href="#how-do-i-access-sonarr-from-another-computer" class="toc-anchor">¶</a> How do I access Sonarr from another computer

- By default Sonarr doesn't listen to requests from all systems (when not run as administrator), it will only listen on localhost, this is due to how the Web Server Sonarr uses integrates with Windows (this also applies for current alternatives). If Sonarr is run as an administrator it will correctly register itself with Windows as well as open the Firewall port so it can be accessed from other systems on your network. Running as admin only needs to happen once (if you change the port it will need to be re-run).

## <a href="#why-does-sonarr-refresh-series-information-so-frequently" class="toc-anchor">¶</a> Why does Sonarr refresh series information so frequently

- Sonarr refreshes series and episode information in addition to rescanning the disk for files every 12 hours. This might seem aggressive, but is a very important process. The data refresh from our TVDb proxy is important, because new episode information is synced down, air dates, number of episodes, status (continuing/ended). Even shows that aren't airing are being updated with new information.
- The disk scan is less important, but is used to check for new files that weren't sorted by Sonarr and detect deleted files.
- The most time consuming portion is the information refresh (assuming reasonable disk access speed), larger shows take longer due to the number of episodes to process.
- No you cannot disable the task nor should you through any SQL hackery. The refresh series task queries the upstream Skyhook proxy and checks to see if the metadata for each series (ids, episodes, summaries, etc.) has updated compared to what is currently in Sonarr. If necessary, it will then update the applicable movies.
- A common complaint is the Refresh task causes heavy I/O usage.
- The main setting is "Rescan Series Folder after Refresh". If your disk I/O usage spikes during a Refresh then you may want to change the Rescan setting to `Manual`.
  - Do not change this to `Never` unless all changes to your library (new movies, upgrades, deletions etc) are done through Sonarr.
  - If you delete movie files manually or via Plex or another third party program, do not set this to `Never`.
- The other setting that can be changed is "Analyze video files" which is advised to be enabled if you use tdarr or otherwise externally modify your files. If you do not you can safely disable "Analyze video files" to reduce some I/O.

> It is not possible to disable this task. If this task is running for long enough that you feel it's the problem, something else is going on that needs to be solved instead of stopping this task.

## <a href="#why-is-there-a-number-next-to-activity" class="toc-anchor">¶</a> Why is there a number next to Activity

- This number shows the count of episodes in your download client's queue and the last 60 items in its history that have not yet been imported. If the number is blue it is operating normally and should import episodes when they complete. Yellow means there is a warning on one of the episodes. Red means there has been an error. In the case of yellow (warning) and red (error), you will need to look at the queue under Activity to see what the issue is (hover over the icon to get more details).
- You need to remove the item from your download client's queue or history to remove them from Sonarr's queue.

## <a href="#whats-the-different-series-types" class="toc-anchor">¶</a> What's the different Series Types

- Series Type impacts how Sonarr searches for series. A series type is based on how the series is released on one's indexers and is not necessarily the true 'type' of the series.

- Most shows should be `Standard`. For daily shows which are typically released with a date, `Daily` should be used. Finally, there is anime where using `Anime` is *usually* right, but sometimes `Standard` can work better, so try the *other* one if you're having issues.

- Please note that if the series type is set to anime and if none of your enabled indexers have any anime categories configured then it effectively skips the indexer and may appear that it is not searching.

- Please note that the Anime type does not have any concept of Season Packs or Seasons and will cause each episode individually to be searched.

- Please note that not all indexers support season/episode (standard) searches.

- Series types can be modified from Mass Editor or from `Edit` when viewing a series. Note that the series type is selectable at import.

- If **Anime** Series Type is used - it is <a href="/sonarr/settings#indexers" class="is-internal-link is-valid-page">possible to also have your indexer searched with the standard type as well.</a>

### <a href="#series-types" class="toc-anchor">¶</a> Series Types

- **Anime** - Episodes released using an absolute episode number
- **Daily** - Episodes released daily or less frequently that use year-month-day (2017-05-25)
- **Standard** - Episodes released with SxxEyy pattern

### <a href="#series-type-examples" class="toc-anchor">¶</a> Series Type Examples

Below are some example release names for each show type. The specific differentiating piece is noted in bold.

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

## <a href="#how-can-i-rename-my-series-folders" class="toc-anchor">¶</a> How can I rename my series folders

> The same process applies for moving/changing Series paths as well

If you have adjusted your Series Name format after Sonarr has already created some Series folders, Sonarr will not automatically rename existing folders. In order to trigger a rename of these folders the following steps should be taken:

1.  Series
2.  Click on "Select Series"
3.  Select what series need their folder renamed
4.  Click on "Edit"
5.  Change Root Folder to the same Root Folder that the series currently exist in
6.  Select "Yes, move the files"

> If you are using Plex or Emby, this will trigger re-detection of intros, thumbnails, chapters, and preview metadata.

## <a href="#how-do-i-update-sonarr" class="toc-anchor">¶</a> How do I update Sonarr

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1.  Under the Updates section change the branch name to `main` or `develop`
2.  Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- main - ![Current v4 Main/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=Main&query=%24%5B%27v4-stable%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) - (Default/Stable): This has been tested by users on nightly (`develop`) branch and it's not known to have any major issues. This branch should be used by the majority of users. On GitHub, this is the `main` branch.
- develop - ![Current v4 Develop/Nightly](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=Develop&query=%24%5B%27v4-nightly%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) - (Beta/Unstable) : This is the bleeding edge. It is released as soon as code is committed and passes all automated tests. This build may have not been used by us or other users yet. There is no guarantee that it will even run in some cases. This branch is only recommended for advanced users. Issues and self investigation are expected in this branch. **Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.** This version is updated immediately.

> **Warning: You may not be able to go back to `main` after switching to this branch.** On GitHub, this is the `develop` branch.

> v3 **non-docker** installs **cannot** be upgraded directly to v4 and require installing Sonarr v4

- Note: If your install is through Docker append `:release`, `:latest`, `:nightly`, or `:develop` to the end of your container tag depending on who makes your builds.

|                                                                                                        | `main` (v4 stable) ![Current v4 Main/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=Main&query=%24%5B%27v4-stable%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) | `develop` (v4 beta) ![Current v4 Develop/Nightly](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=Develop&query=%24%5B%27v4-nightly%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) |
|--------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://hotio.dev/containers/sonarr" class="is-external-link">hotio</a>                       | `release`                                                                                                                                                                                                   | `nightly`                                                                                                                                                                                                            |
| <a href="https://docs.linuxserver.io/images/docker-sonarr" class="is-external-link">LinuxServer.io</a> | `latest`                                                                                                                                                                                                    | `develop`                                                                                                                                                                                                            |

### <a href="#installing-a-newer-version" class="toc-anchor">¶</a> Installing a newer version

#### <a href="#native" class="toc-anchor">¶</a> Native

1.  Go to System and then the Updates tab
2.  Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

> v3 cannot be updated to beta v4 and requires manually installing. Refer to the <a href="https://www.reddit.com/r/sonarr/comments/z3nb82/sonarr_v4_beta/" class="is-external-link">v4 Beta Announcement</a>

#### <a href="#docker" class="toc-anchor">¶</a> Docker

1.  Repull your tag and update your container

## <a href="#can-i-switch-from-develop-back-to-main" class="toc-anchor">¶</a> Can I switch from `develop` back to `main`

- See the entry below

## <a href="#can-i-switch-between-branches" class="toc-anchor">¶</a> Can I switch between branches

> You can (almost) always increase your risk.

- `main` can go to `develop`
- See below or otherwise check with the development team to see if you can switch from `develop` to `main` for your given build.
- Failure to follow these instructions may result in your Sonarr becoming unusable or throwing errors. You have been warned. If the below errors are encountered then you are using a newer database with an older \*Arr version which is not supported. Upgrade \*Arr to the version you were previously on or newer.
  - Example Error Messages:
    - `Error parsing column 45 (Language=31 - Int64)`
    - `The DataMapper was unable to load the following field: 'Languages' value`
    - `ID does not match a known language Parameter name: id`
    - Other similar database errors around missing columns or tables.

# <a href="#sonarr-and-series-issues-metadata" class="toc-anchor">¶</a> Sonarr and Series Issues + Metadata

## <a href="#how-does-sonarr-handle-scene-numbering-issues-american-dad-etc" class="toc-anchor">¶</a> How does Sonarr handle scene numbering issues (American Dad!, etc)

### <a href="#how-sonarr-handles-scene-numbering-issues" class="toc-anchor">¶</a> How Sonarr handles scene numbering issues

- Sonarr relies on <a href="http://thexem.info/" class="is-external-link">TheXEM</a>, a community driven site that lets users create mappings of shows that the scene (the people that post the files) and TheTVDb (which typically follows the network's numbering). There are a number of shows on there already, but it is easy to add another and typically the changes are accepted within a couple days (if they're correct). TheXEM is used to correct differences in episode numbering (disagreement whether an episode is a special or not) as well as season number differences, such as episodes being released as S10E01, but TheTVDb listing that same episode as S2017E01.
- XEM typically fixes the issues when release groups' (colloquially known as 'the scene') numbering does not match TVDb numbering so Sonarr doesn't work. Well enter <a href="http://thexem.info" class="is-external-link">XEM</a> which creates a map for Sonarr to look at.
- Releases double episodes in a single file since that is how they air but TVDb marks each episode individually.
- Release groups use a year for the season S2010 and TVDb uses S01.
- <a href="http://thexem.info" class="is-external-link">XEM</a> works in most cases and keeps it running smooth without you ever knowing. However as with most things, there will always be a *problematic exceptions* and in this case there is a list of them.

> Certain indexers or release groups may follow TVDb rather than `Scene` (i.e. XEM).  
> If this is observed, please submit them via the scene mapping form.

- <a href="https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0" class="is-external-link">Services Requested Mappings <em>Review and ensure the alias and release have not already been requested or added</em></a>
- <a href="https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform" class="is-external-link">Services Scene Mapping Request Form <em>Make a new request for an alias. Ensure the form is filled out in full</em></a>

### <a href="#problematic-shows" class="toc-anchor">¶</a> Problematic Shows

> This by no means is an all inclusive list of shows that have known issues with scene mapping; however, these are some common ones.

- This is an incomplete list of the known shows and how/why they're problematic:
- <span id="problemshow-americandad">American Dad</span>
  - Due to network season changes, American Dad is typically off by 1 season between releases and TVDb. Refer to the XEM map for details
  - <a href="https://thexem.info/xem/show/4948" class="is-external-link">American Dad</a> is currently on S19 based on TVDb or S18 based on Scene at the time of this writing. So searching in Sonarr for Season 19 will **only** return Season 18 results because of the XEM map.
  - If you have an indexer / release groups with Season 19 episodes, please submit them via the scene mapping form and ensure they are not already requested
    - <a href="https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0" class="is-external-link">Services Requested Mappings <em>Review and ensure the alias and release have not already been requested or added</em></a>
    - <a href="https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform" class="is-external-link">Services Scene Mapping Request Form <em>Make a new request for an alias. Ensure the form is filled out in full</em></a>
- <span id="problemshow-pawpatrol">Paw Patrol</span>
  - Double episode files vs single episode TVDb but also not all episodes are doubles so the map can get added wrong pointing to which ones are singles vs doubles
- <span id="problemshow-pokemon">Pokémon</span>
  - On TheXem, <a href="http://thexem.info/xem/show/4638" class="is-external-link">Pokemon</a> is tracking *dubbed* episodes. So if you want subbed episodes, you may be out of luck. If certain release groups are following TVDb and not XEM mapping, please submit them via the scene mapping form and ensure they are not already requested
    - <a href="https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0" class="is-external-link">Services Requested Mappings <em>Review and ensure the alias and release have not already been requested or added</em></a>
    - <a href="https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform" class="is-external-link">Services Scene Mapping Request Form <em>Make a new request for an alias. Ensure the form is filled out in full</em></a>
- <span id="problemshow-moneyheist">La Casa de Papel / Money Heist</span>
  - TVDb has the original airing order from the Spanish network, but Netflix bought the rights and re-cut the series into a different episode count. This is causing "season 5" to be imported over existing "season 3" episodes. <a href="https://old.reddit.com/r/sonarr/comments/pdrr6l/money_heist_mess/" class="is-external-link">Additional information can be found on this reddit thread</a>
- <span id="problemshow-kamenrider">Kamen Rider</span>
  - The anthology entry (<a href="https://thetvdb.com/series/kamen-rider" class="is-external-link">TVDb ID 74096</a>) should be used in Sonarr for automation  
    as this show has both an anthology entry (collecting all seasons) and the individual seasons listed as separate entries on TVDb. Due to the anthology entry having individual season name mappings on <a href="https://thexem.info/xem/show/5376" class="is-external-link">TheXEM</a> it is not possible to add the individual season entries to Sonarr without manually downloading and importing releases.
- <span id="problemshow-bleach">Bleach: Thousand-Year Blood War</span>
  - The newest season of Bleach: Thousand-Year Blood War is being released with a variety of different naming schemes making it difficult to automate and potentially overwriting some of your existing episodes. It can only be automated if your release group is either:
    - Releasing the episodes as S17Exx numbering, or
    - Releasing them with the correct Season 2 series title (found here <a href="https://thexem.info/xem/show/5476" class="is-external-link">https://thexem.info/xem/show/5476</a>) and have began this new arc at absolute episode number 1.
- <span id="problemshow-greatasianrail">Great Asian Railway Journeys</span>
  - Great Asian Railway Journeys was first aired as 20 smaller episodes, but was later re-aired as 10 long episodes. These longer combined episodes were added as Specials, and should be named accordingly. (S00E01, etc, ...)
- <span id="problemshow-horizon">Horizon</span>
  - A show that sporadically airs episodes since 1964. This makes mapping particularly difficult, as you can see on <a href="https://thexem.info/xem/show/5495" class="is-external-link">TheXEM</a>. Those interested can find the original discussion <a href="https://discord.com/channels/383686866005917708/649018968559845376/1046898050909622312" class="is-external-link">on the Sonarr discord server</a>.
- <span id="problemshow-kaleidoscope">Kaleidoscope (2023)</span>
  - Kaleidoscope (2023) was released on Netflix as a non-linear show meaning that every user got a different order when watching the series. This causes an issue for Sonarr as release groups have different episode orders for the show. In order to prevent incorrect mapping of episodes Sonarr will not automatically grab episodes and you will need to grab and import the episodes manually. You can match them based on episode title, or by previewing the first few seconds and seeing the episode 'color' matching the title.

Some examples of other shows that commonly have issues, most of which may be resolved by TheXEM mappings are: Arrested Development, Kitchen Nightmares (US), Mythbusters, Pawn Stars.

## <a href="#why-cant-sonarr-import-episode-files-for-series-x-why-cant-sonarr-find-releases-for-series-x" class="toc-anchor">¶</a> Why can't Sonarr import episode files for series X? / Why can't Sonarr find releases for series X

There can be multiple reasons why Sonarr is not able to find or import episodes for a particular series, and there are two methods for "correcting" these failures.

- Sonarr tries to search first using TVDBid or IMDBid, if your indexer supports those kinds of searches. If there are no results, or you have no indexers which support ID-based searches, Sonarr falls back to searching text-based titles.
- Sonarr does not use aliases nor translations (i.e. any foreign language titles) from TVDb.
- The text-based search must match exactly. This includes the year, if a year is required (listed on TVDB with a year after the series title).
- The text-based search is *only* for the English translation of the series title from TVDB. Other languages are not searched.
- The site <a href="https://thexem.info" class="is-external-link">https://thexem.info</a> is used to correct scene/episode mappings, and also to add aliases to be searched for series or season names. Note that this is primarily for Anime only. Please check this site for corrections if you have a mismatch between season/episode results and the ones you expect. There is a \#xem channel on Discord to talk about changes to the site. Xem is the *only* way to fix Japanese Anime aliases. Additional information on XEM's usage can be found in the faq entry [How Sonarr Handles scenen numbering issues](#how-sonarr-handles-scene-numbering-issues)
- The Scene Mapping Table is what is primarily to be used for series aliases for non-Anime series only. This table is manual. Please search first to be sure your request has not been made, and provide a release name example with your request. <a href="https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0" class="is-external-link">This</a> is the current list of previous requests for your review. <a href="https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform" class="is-external-link">This</a> is the form for requesting new mappings. Requests to this table are added manually by devs, and can take up to 2 weeks to take effect. *Please remember that all aliases must be searched by all Sonarr users for every episode/season search, which can dramatically increase search times and API hits.*
- We are aware that some series are just plain difficult. You may also wish to review the [FAQ Entry for Problematic Shows and Release Group vs. TVDb numbering issues](#how-does-sonarr-handle-scene-numbering-issues-american-dad-etc).

## <a href="#tvdb-is-updated-why-isnt-sonarr" class="toc-anchor">¶</a> TVDb is updated why isn't Sonarr

- TVDb has a 1-3 hour cache on their API.
- TVDb's API then needs to populate through their CDN cache which takes up to an hour.
- Sonarr's Skyhook has a much smaller few hour cache on top of that.
- Additionally, Sonarr only runs the Refresh Series task every 12 hours. This task can be manually ran from System =\> Tasks; "Update All" from the Series Index, or manually ran for a specific series on that series's page.
- Therefore for a change on TVDb to get into Sonarr automatically it will typically take between 3 and 19 hours (3 + 1 + 3 + 12)
- Episode titles in English are the only titles synced. If there is no English translation, then the episode title will be TBA.

<!-- -->

- If you know a TVDb update was made more than 24 hours ago, and you have refreshed the series in Sonarr, then please come discuss on our <a href="https://discord.sonarr.tv/" class="is-external-link">Discord</a>.

## <a href="#why-can-i-not-add-a-series" class="toc-anchor">¶</a> Why can I not add a series

- In the event that TheTVDb is unavailable Sonarr is unable to get search results and you will be unable to add any new series by searching. You may be able to add a new series by the TVDbID if you know what it is, the UI explains how to add it by an ID.
- Sonarr cannot add any series that does not have an English language title. If you try to add a series via TVDb ID that does not have an English title. If no English title exists for that series on TheTVDb it will need to be added and then [one will need to wait for TVDb's cache to clear](#tvdb).
- The show must be a TV Series, and not a movie. It must also exist on TVDb. If it is on IMDB, TMDB, or anywhere else, but not on TVDb you cannot add the show.
- The series must exist on TVDb
- Certain series may actually be considered continuations are and seasons in their primary series.
  - Some series/seasons known are:
  - <a href="https://thetvdb.com/series/dexter/seasons/official/9" class="is-external-link">Dexter New Blood was Season 9</a> but it is now <a href="https://thetvdb.com/series/dexter-new-blood" class="is-external-link">it's own series</a>

## <a href="#why-can-i-not-add-a-series-when-i-know-the-tvdb-id" class="toc-anchor">¶</a> Why can I not add a series when I know the TVDb ID

- Sonarr cannot add any series that does not have an English language title. If you try to add a series via TVDb ID that does not have an English title then the series will not be found. If no English title exists for that series on TheTVDb it will need to be added (if available).
- Check the URL / series - Sonarr does not support movies; use <a href="/radarr" class="is-internal-link is-valid-page">Radarr</a> for movies

## <a href="#title-slug-in-use" class="toc-anchor">¶</a> Title Slug in Use

- There are two primary causes of this error that are listed below.

## <a href="#duplicate-names-no-year" class="toc-anchor">¶</a> Duplicate Names No Year

- This error often occurs when two series are named with the same title on TheTVDB, if this is the case the second series should have the year appended to the series title.
  - Series A
  - Series A (2021)
- To rectify this, wait for someone to eventually (maybe) update TVDb or update TVDb yourself. Once corrected **and once approved by TVDb's moderators**, due to [TVDb's API issues](#tvdb-is-updated-why-isnt-sonarr), once updated you'll need to wait 30+ hours before the corrected title can be used in Sonarr.

## <a href="#duplicate-names-punctuation" class="toc-anchor">¶</a> Duplicate Names Punctuation

- It will also happen with two similarly named series that may only differ by punctuation, if this is the case please report this on the <a href="https://discord.sonarr.tv/" class="is-external-link">Sonarr Discord</a>.
  - Joe's Show (2022)
  - Joes Show (2022)

## <a href="#episode-does-not-have-an-absolute-number" class="toc-anchor">¶</a> Episode does not have an absolute number

- The episode(s) on TVDb do not have an absolute number assigned. Update the series on TVDb if required and then wait the 36-48 hours for the update to clear TVDb's internal cache and load into Sonarr

## <a href="#episode-air-times" class="toc-anchor">¶</a> Episode Air Times

- Within Sonarr, Episode Air Date and Times shown in the browser are based of the client's time/timezone, all times are sent from Sonarr to the browser as UTC times (ISO-8601 formatted to be exact)
- TVDb dictates - with exceptions for streaming services - that the airtime and date is based on the Primary Airing Network's local time in the country's most popular city. <a href="https://support.thetvdb.com/kb/faq.php?id=29" class="is-external-link">See TVDb's FAQ entry for details</a>
- Episode Air Dates and Air Time on TVDb is converted to UTC and uses Sonarr's Timezone that is mapped in Skyhook by the Sonarr team for the Network TVDb has for the series.
  - In the rare case a network is not mapped then the time in TVDb will be assumed to be US EST (UTC-5).
  - If the airtime does not seem to align when converting from the airtime Network's local timezone to your browser's timezone then it is likely the network needs to be mapped in Skyhook. <a href="https://discord.sonarr.tv/" class="is-external-link">Contact the development team on Discord</a> for support with updating the Network's timezone.

# <a href="#sonarr-common-problems" class="toc-anchor">¶</a> Sonarr Common Problems

## <a href="#path-is-already-configured-for-an-existing-series" class="toc-anchor">¶</a> Path is Already Configured for an Existing Series

- Library Import shows "Existing" or you get an error of "Path is configured for an existing series"
- This occurs when trying to add a series or edit an existing series's path that already is assigned to a different series.
- Likely this was caused by not correcting a mismatched series when the user imported their library.
- Locate and correct the movie that is already assigned to that series's path.
  - Series Index
  - Table View
  - Options =\> Add path as a column
  - Sort and find the movie at the noted problematic path.
- Alternatively, delete the series using the existing path from Sonarr

## <a href="#system-logs-loads-forever" class="toc-anchor">¶</a> System & Logs loads forever

- It's the easy-privacy blocklist. They basically block any url with /api/log? in it. Look over the list and tell me if you think that blocking all the urls in that list is a sensible idea, there are dozens of urls in there that potentially break sites. You selected that in your adblocker. Easy solution is to whitelist the domain Sonarr is running on. But I still recommend checking the list.

## <a href="#weird-ui-issues" class="toc-anchor">¶</a> Weird UI Issues

- If you experience any weird UI issues like the Library page not listing anything or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the <a href="/useful-tools#clearing-cookies-and-local-storage" class="is-internal-link is-valid-page">Clear Cache Cookies and Local Storage</a> wiki article.

## <a href="#web-interface-only-loads-at-localhost-on-windows" class="toc-anchor">¶</a> Web Interface Only Loads at localhost on Windows

- If you can only reach your web interface at <a href="http://localhost:8989/" class="is-external-link">http://localhost:8989/</a> or <a href="http://127.0.0.1:8989" class="is-external-link">http://127.0.0.1:8989</a>, you need to run Sonarr as administrator at least once.

## <a href="#i-got-a-pop-up-that-said-configxml-was-corrupt-what-now" class="toc-anchor">¶</a> I got a pop-up that said config.xml was corrupt, what now

- Sonarr was unable to read your config file on start-up as it became corrupted somehow. In order to get Sonarr back online, you will need to delete `.xml` in your <a href="/sonarr/appdata-directory" class="is-internal-link is-valid-page">AppData Folder</a> once deleted start Sonarr and it will start on the default port (8989), you should now re-configure any settings you configured on the General Settings page.

## <a href="#invalid-certificate-and-other-https-or-ssl-issues" class="toc-anchor">¶</a> Invalid Certificate and other HTTPS or SSL issues

- If you're on non-Windows, most likely your mono's certificates are out of date and need to be synced. <a href="/sonarr/installation#mono-ssl-issues" class="is-internal-link is-valid-page">See the section about mono ssl in the installation article for details</a>
- Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?
  - Sonarr now validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then Sonarr will refuse to connect. Free properly signed certificates are available from <a href="https://letsencrypt.org/" class="is-external-link">let's encrypt</a>.
  - If your download client and Sonarr are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## <a href="#how-do-i-stop-the-browser-from-launching-on-startup" class="toc-anchor">¶</a> How do I stop the browser from launching on startup

Depending on your OS, there are multiple possible ways.

- In `Settings` =\> `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Sonarr, you can add `-nobrowser` (\*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Sonarr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.

## <a href="#vpns-jackett-and-the-arrs" class="toc-anchor">¶</a> VPNs, Jackett, and the \*ARRs

> For comprehensive VPN guidance, see the dedicated <a href="/vpn" class="is-internal-link is-valid-page">VPN Guide</a> page.

- Unless you're in a repressive country like China, Australia or the UK, your torrent client is typically the only thing that needs to be behind a VPN. If you're in a repressive country noted above it is likely your connection to your trackers needs to be VPN'd as well - in other words Jackett behind a VPN or Prowlarr using an Indexer Proxy. Other \*Arr apps not connecting to trackers should not be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.
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

## <a href="#i-see-log-messages-for-shows-i-do-not-havedo-not-want" class="toc-anchor">¶</a> I see log messages for shows I do not have/do not want

- These messages are completely normal and come from the RSS feeds that Sonarr checks to see if there are episodes you do want, usually these only appear in debug/trace logging, but in the event of an problem processing an item you may see a warning or error. It is safe to ignore the warnings/errors as well since they are for shows you do not want, in the event it is for a show you want, open up a support thread on the forums.

## <a href="#seeding-torrents-arent-deleted-automatically" class="toc-anchor">¶</a> Seeding torrents aren't deleted automatically

- When a torrent that is still seeding is imported, it is copied or hard linked (if enabled and *possible*) so that the torrent client can continue seeding. In an ideal setup, the torrent download folder and the library folder will be on the same file system and *look like it* (Docker and network shares make this easy to get wrong), which makes hard links possible and minimizes wasted space.
- In addition, you can configure your seed time/ratio goals in Sonarr or your download client, setup your download client to *pause* or *stop* when they're met and enable Remove under Completed and Failed Download Handler. That way, torrents that finish seeding will be removed from the download client by Sonarr.

## <a href="#help-my-mac-says-sonarr-cannot-be-opened-because-the-developer-cannot-be-verified" class="toc-anchor">¶</a> Help, my Mac says Sonarr cannot be opened because the developer cannot be verified

- This is simple, please see this link for more information <a href="https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac" class="is-external-link">in the Mac help documentation</a>  
  \[![Developer Cannot be verified](/assets/general/faq_1_mac.png)\]

## <a href="#help-my-mac-says-sonarrapp-is-damaged-and-cannot-be-opened" class="toc-anchor">¶</a> Help, my Mac says Sonarr.app is damaged and cannot be opened

- That is either due to a corrupt download so try again or [security issues, please see this related FAQ entry.](#help-my-mac-says-sonarr-cannot-be-opened-because-the-developer-cannot-be-verified)

## <a href="#i-am-getting-an-error-database-disk-image-is-malformed" class="toc-anchor">¶</a> I am getting an error: Database disk image is malformed

> Database corruption occurring when upgrading to v4 means your existing v3 database is corrupt. v4 does not create database corruption. Downgrading to v3 or staying on v3 does not and will never fix the underlying corruption. **Sonarr v3 is end of life and unsupported**

- **Errors of `Error creating log database` indicate issues with logs.db**
  - This can quickly be resolved by renaming or removing the database. The logs database contains unimportant information regarding commands history and update install history, and Info, Warn, and Error entries
- **Errors of `Error creating main database` or generic `database disk image is malformed` with no specified database indicate issues with sonarr.db**
  - Continue with the steps noted below
- This means your SQLite database that stores most of the information for Sonarr is corrupt. Your options are to try (a) backup(s), try recovering the existing database, try recovering the backup(s), or if all else fails starting over with a fresh new database.
- This error may show if the database file is not writable by the user/group \*Arr is running as. Permissions being the cause will likely only be an issue for new installs, migrated installs to a new server, if you recently modified your appdata directory permissions, or if you changed the user and group \*Arr run as.
- Your best and first option is to [try restoring from a backup](#how-do-i-backuprestore-my-sonarr)
- You can also try recovering your database. This is typically the only option for when this issue occurs after an update. Try the <a href="/useful-tools#recovering-a-corrupt-db" class="is-internal-link is-valid-page">sqlite3 <code>.recover</code> command</a>
  - If your sqlite does not have `.recover` or you wish a more GUI (i.e. Windows) friendly way then follow <a href="/useful-tools#recovering-a-corrupt-db-ui" class="is-internal-link is-valid-page">our instructions on this wiki.</a>
- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). **SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. <a href="https://www.sqlite.org/draft/useovernet.html" class="is-external-link">SQLite and network drives not play nice together and will cause a malformed database eventually</a>.
- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS <a href="https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs" class="is-external-link">docs here</a>

## <a href="#i-use-sonarr-on-a-mac-and-it-suddenly-stopped-working-what-happened" class="toc-anchor">¶</a> I use Sonarr on a Mac and it suddenly stopped working. What happened

- Most likely this is due to a MacOS bug which caused one of the Sonarr databases to be corrupted.
- [Follow these steps to resolve](#i-am-getting-an-error-database-disk-image-is-malformed)
- Then attempt to launch Sonarr and see if it works. If it does not work, you will need further support. Post in our <a href="http://reddit.com/r/Sonarr" class="is-external-link">reddit</a> or hop on <a href="https://discord.sonarr.tv/" class="is-external-link">discord</a> for help.

## <a href="#why-can-sonarr-not-see-my-files-on-a-remote-server" class="toc-anchor">¶</a> Why can Sonarr not see my files on a remote server

- For all OSes ensure the user/group you're running \*Arr as has read and write access to the mounted drive.
- For Linux ensure:
  - If you're using an NFS mount ensure `nolock` is enabled for your mount.
  - If you're using an SMB mount ensure `nobrl` is enabled for your mount.
- For Windows: In short: the user \*Arr is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is \*Arr is running as a service, which causes the issues described below.

### <a href="#sonarr-runs-under-the-localservice-account-by-default-which-doesnt-have-access-to-protected-remote-file-shares" class="toc-anchor">¶</a> Sonarr runs under the LocalService account by default which doesn't have access to protected remote file shares

- Run Sonarr's service as another user that has access to that share
- Open the Administrative Tools \> Services window on your Windows server.
- Stop the Sonarr service.
- Open the Properties \> Log On dialog.
- Change the service user account to the target user account.

### <a href="#youre-using-a-mapped-network-drive-not-a-unc-path" class="toc-anchor">¶</a> You're using a mapped network drive (not a UNC path)

- Change your paths to UNC paths (`\\server\share`)
- Run Sonarr.exe via the Startup Folder

## <a href="#mapped-network-drives-vs-unc-paths" class="toc-anchor">¶</a> Mapped Network Drives vs UNC Paths

- Using mapped network drives generally doesn't work very well, especially when Sonarr is configured to run as a service. The better way to set shares up is using UNC paths. So instead of `X:\TV` use `\\Server\TV`.

- A key point to remember is that Sonarr gets path information from the downloader, so you will *also* need to setup NZBGet, SABNzbd or any other downloader to use UNC paths too.

## <a href="#sonarr-will-not-work-on-big-sure" class="toc-anchor">¶</a> Sonarr will not work on Big Sure

Run

``` prismjs
chmod +x /Applications/Sonarr.app/Contents/MacOS/Sonarr
```

## <a href="#my-custom-script-stopped-working-after-upgrading-from-v2" class="toc-anchor">¶</a> My Custom Script stopped working after upgrading from v2

- You were likely passing arguments in your connection...that is not supported.
- To correct this:
  1.  Change your argument to be your path
  2.  Make sure the shebang in your script maps to your pwsh path (if you do not have a shebang definition in there, add it)
  3.  Make sure the pwsh script is executable

# <a href="#sonarr-searching-downloading-common-problems" class="toc-anchor">¶</a> Sonarr Searching & Downloading Common Problems

## <a href="#query-successful-no-results-returned" class="toc-anchor">¶</a> Query Successful - No Results Returned

- <a href="/sonarr/troubleshooting#query-successful-no-results-returned" class="is-internal-link is-valid-page">See this troubleshooting entry</a>

## <a href="#why-didnt-sonarr-grab-an-episode-i-was-expecting" class="toc-anchor">¶</a> Why didn't Sonarr grab an episode I was expecting

First, make sure you read and understand the section above called ["How does Sonarr find episodes?](#how-does-sonarr-find-episodes) Second, make sure at least one of your indexers has the episode you were expecting to be grabbed.

1.  Click the 'Manual Search' icon next to the episode listing in Sonarr. Are there any results? If no, then either Sonarr is having trouble communicating with your indexers, or your indexers do not have the episode, or the episode is improperly named/categorized on the indexer.
2.  **If there are results from step 1**, check next to them for red exclamation point icon. Hover over the icon to see why that release is not a candidate for automatic downloads. If every result has the icon, then no automatic download will occur.
3.  **If there is at least one valid manual search result from step 2**, then an automatic download should have happened. If it didn't, the most likely reason is a temporary communication problem preventing an RSS Sync from your indexer. It is recommended to have several indexers set up for best results.
4.  **If there is no manual result from a show, but you can find it when you browse your indexer's website** - This can be caused by a number of reasons, for example the release is not properly tagged on your indexer causing it to not be returned to sonarr in an automatic search. This <a href="/sonarr/troubleshooting#searches-indexers-and-trackers" class="is-internal-link is-valid-page">troubleshooting entry</a> provides some tips on how to determine the cause. Having several indexers active can help solve this by providing more sources to the same content.

## <a href="#found-matching-series-via-grab-history-but-release-was-matched-to-series-by-id-automatic-import-is-not-possible" class="toc-anchor">¶</a> Found matching series via grab history, but release was matched to series by ID. Automatic import is not possible

- See <a href="/sonarr/troubleshooting#found-matching-series-via-grab-history-but-series-was-matched-by-series-id-automatic-import-is-not-possible" class="is-internal-link is-valid-page">this troubleshooting entry</a>

## <a href="#tba-episode-naming" class="toc-anchor">¶</a> TBA Episode Naming

- On TVDb, when episode names are unknown they'll be titled TBA and there is a cache on the TVDb API. The <a href="/sonarr/settings#importing" class="is-internal-link is-valid-page">Episode Title Required setting</a> in Sonarr controls import behavior when the title is TBA, but after 48 hours from series airing the release will be imported even if the title is still TBA. There is also no automatic follow up renaming of TBA titled files. Note that the TBA timer is calculated from the episode airdate and time, not from when you've grabbed it or the upload time.
- Details on TVDb and Skyhook's cache can be found in the FAQ [TVDb is updated why isn't Sonarr?](#tvdb-is-updated-why-isnt-sonarr)

## <a href="#sonarr-says-unknown-series-on-searches-or-imports" class="toc-anchor">¶</a> Sonarr says Unknown Series on Searches or Imports

- See the <a href="/sonarr/faq#why-cant-sonarr-import-episode-files-for-series-x-why-cant-sonarr-find-releases-for-series-x" class="is-internal-link is-valid-page">Why can't Sonarr import episode files for series X? / Why can't Sonarr find releases for series X?</a> entry

## <a href="#jacketts-all-endpoint" class="toc-anchor">¶</a> Jackett's /all Endpoint

- The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is required. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative <a href="/prowlarr" class="is-internal-link is-valid-page">Prowlarr</a>

- **February 5 2022 Update: \*Arr Support has been discontinued for the jackett `\all` endpoint. Jackett /all endpoint is no longer supported (e.g. warnings will occur) as of v3.0.6.1457 due to the fact it only causes issues.**

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

## <a href="#jackett-shows-more-results-than-sonarr-when-manually-searching" class="toc-anchor">¶</a> Jackett shows more results than Sonarr when manually searching

- Check your configured categories for your tracker in Sonarr
- This is usually due to Sonarr searching Jackett differently than you do. <a href="/sonarr/troubleshooting#searches-indexers-and-trackers" class="is-internal-link is-valid-page">See this troubleshooting article for further information</a>.

## <a href="#finding-cookies" class="toc-anchor">¶</a> Finding Cookies

- Some sites cannot be logged into automatically and require you to login manually then give the cookies to Sonarr to work. <a href="/useful-tools#finding-cookies" class="is-internal-link is-valid-page">Please see this article for details.</a>

## <a href="#unpack-torrents" class="toc-anchor">¶</a> Unpack Torrents

- Most torrent clients doesn't come with the automatic handling of compressed archives like their usenet counterparts. We recommend <a href="https://github.com/unpackerr/unpackerr" class="is-external-link">unpackerr</a>.

## <a href="#permissions" class="toc-anchor">¶</a> Permissions

- Sonarr will need to move files away from where the downloader puts them into the final location, so this means that Sonarr will need to read/write to both the source and the destination directory and files.
- On Linux, where best practices have services running as their own user, this will probably mean using a shared group and setting folder permissions to `775` and files to `664` both in your downloader and Sonarr. In umask notation, that would be `002`.

## <a href="#forced-authentication" class="toc-anchor">¶</a> Forced Authentication

- In Sonarr v4 authentication is mandatory. Please see the <a href="/sonarr/faq-v4#forced-authentication" class="is-internal-link is-valid-page">Sonarr v4 FAQ - Forced Authentication</a> for details

## <a href="#removing-completed-torrents" class="toc-anchor">¶</a> Removing Completed Torrents

- In Sonarr in Settings -\> Download Clients, in each download client, check the box to Remove Completed.

- In your download client, set it to Pause or Stop on completion of meeting goals. You should not set goals in your download client, just the option to Pause or Stop (in qbit, you have to check a box for ratio or time, change the setting, and then uncheck the box again).

- In each indexer in Settings -\> Indexers, set a Seed Ratio and/or Seed Time (this is an advanced option). The settings you choose here are "first to meet one of the goals". Note that if you use Prowlarr on Full Sync, you want to set those goals there instead, or they will be overwritten on the next sync.

- Note that time or ratio settings here are set On Grab. They do not impact torrents you already have in your download client. They also do not work with a post-import category setting.

- Some torrent clients do not have this ability. See <a href="/sonarr/settings#torrent-client-remove-download-compatibility" class="is-internal-link is-valid-page">this page</a> for details for your client.

- Setting extremely low seed times or ratios will not work, and is also poor torrent etiquette. You should **always** seed to at least a 1.0x ratio, or a couple of hours, for public trackers and whatever the requirements are for private trackers (plus a little buffer, because the way your download client calculates time and ratio is slightly different than your private tracker, and you don't want a hit and run for being a few minutes short of your requirement). Seeding for less than 1.0x ratio will mean that we will not provide you support in discord.


