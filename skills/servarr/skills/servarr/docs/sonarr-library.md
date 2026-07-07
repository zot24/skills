> Source: https://wiki.servarr.com/sonarr/library



# <a href="#series" class="toc-anchor">¶</a> Series

The series page shows your entire library and allows you to select individual series (however, searching can be more efficient in large libraries) and make searches for specific series, as well as being able to edit them. It also allows you to filter your series.

# <a href="#filters" class="toc-anchor">¶</a> Filters

The filters options allows you to narrow your series down and is incredibly helpful. It can be used to see release dates, names, episode counts, disk size counts, and too much more to list, including custom filters, to fit your every need. These can also be used in the mass editor.

# <a href="#add-new" class="toc-anchor">¶</a> Add New

The add new feature allows you to add a new series for Sonarr to monitor and download.

- Root Folder - The selected <a href="/sonarr/settings#root-folders" class="is-internal-link is-valid-page">root/library folder</a> in Sonarr for this series to use
- Monitor - How do you want the series monitored initially?
  - All Episodes - Monitor all episodes except specials
  - Future Episodes - Monitor episodes that have not aired yet
  - Missing Episodes - Monitor episodes that do not have files or have not aired yet
  - Existing Episodes - Monitor episodes that have files or have not aired yet
  - Recent Episodes - Monitor episodes aired within the last 90 days and future episodes
  - Pilot Episode - Only monitor the first episode of the first season
  - First Season - Monitor all episodes of the first season; all other seasons will be ignored
  - Last Season - Monitor all episodes of the last season
  - Monitor Specials - Monitor all special episodes without changing the monitored status of other episodes
  - Unmonitor Specials - Unmonitor all special episodes without changing the monitored status of other episodes
  - None - No episodes will be monitored
- Quality Profile - The <a href="/sonarr/settings#quality-profiles" class="is-internal-link is-valid-page">quality profile</a> to use for this series
- Series Type - Which Series Type to use for this series; this changes how searches occur <a href="/sonarr/faq#whats-the-different-series-types" class="is-internal-link is-valid-page">See the FAQ entry for more info</a>
- Season Folder - Enable or disable creation and usage of Season folders for this series
- Tags - Used to assign series to release profiles, delay profiles, indexers, or just to organize your series
- Start search for missing episodes - based on your selected monitor settings, search for all missing and monitored episodes in this series
- Start search for cutoff unmet episodes - based on your selected monitor settings and only applicable if you have existing files for your episodes in the series folder, search for all existing and monitored episodes in this series that do not meet or exceed your quality profile's cutoff

# <a href="#library-import" class="toc-anchor">¶</a> Library Import

Library Import allows you to import existing, organized series and episode files into Sonarr via existing files in the path directory. This is especially useful when making a new Sonarr instance and wanting to keep your existing series.

- Library import is for adding and importing an existing organized library of series into Sonarr.

- Library Import cannot be used for:

  - Importing files from a download folder
  - Adding or Importing one or more files that are not properly named and organized in their own Series Folder within your root folder or a folder you wish to add as a root folder
  - Any other uses that are not adding a series or episode to Sonarr and importing the series and its file(s) from the root (library) folder that was input to Library Import

> \* Non-Windows: If you're using an NFS mount ensure `nolock` is enabled.  
> \* If you're using an SMB mount ensure `nobrl` is enabled.

> **The user and group you configured Sonarr to run as must have read & write access to this location.**

> Your download client downloads to a download folder and Sonarr imports it to your media folder (final destination) that your media server uses.

> **Your download folder and media folder can’t be the same location**

# <a href="#mass-editor" class="toc-anchor">¶</a> Mass Editor

The mass editor allows you to edit series en masse. You can change any of the previous settings made when you added the series.

# <a href="#season-pass" class="toc-anchor">¶</a> Season Pass

This shows information about how many seasons every series has and how many episodes in each season are missing.


