> Source: https://wiki.servarr.com/sonarr/tips-and-tricks



# <a href="#trashs-custom-formats" class="toc-anchor">¶</a> TRaSH's Custom Formats

- <a href="https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/" class="is-external-link">TRaSH has a guide</a> on how to use <a href="/sonarr/settings#custom-formats-2" class="is-internal-link is-valid-page">Sonarr =&gt; Settings =&gt; Custom Formats</a> as well as a shared repository of Custom Formats.

# <a href="#syncing-two-sonarr-instances" class="toc-anchor">¶</a> Syncing Two Sonarr Instances

- TRaSH has <a href="https://trash-guides.info/Radarr/Tips/Sync-2-radarr-sonarr/" class="is-external-link">a guide</a> on how to sync two (or more) instances

# <a href="#renaming-series-folders" class="toc-anchor">¶</a> Renaming Series Folders

- If you change your Series Folder Format after Sonarr has already created folders, Sonarr does not rename the existing folders automatically. See <a href="/sonarr/faq#rename-folders" class="is-internal-link is-valid-page">this FAQ entry</a> for the steps to trigger a rename.

# <a href="#creating-a-folder-for-each-series" class="toc-anchor">¶</a> Creating a Folder for Each Series

- This is only needed to clean up / organize an existing library to facilitate importing into Sonarr. Below are a few different methods.

## <a href="#filebot" class="toc-anchor">¶</a> Filebot

> Filebot is supported on Windows, Linux, and MacOS

- <a href="https://www.filebot.net/" class="is-external-link">Filebot</a> is a fantastic utility for getting your episodes organized in a way that Sonarr can successfully parse. Version 4.7.9 can still be downloaded for free from a SourceForge mirror, but there are also paid versions in the Windows and Apple stores. On Linux, your distribution of choice may have a package for it, like in Arch's AUR package or `.deb` files for Debian/Ubuntu from their download page. It has both a GUI and a CLI, so it should satisfy almost everyone.

- There is great help available, including their format expressions page. Filebot's TV format expressions can produce a `Series Name (Year)/Season XX/` layout that Sonarr parses cleanly.

- To keep this pattern for future imports, you should set:

- <a href="/sonarr/settings#media-management" class="is-internal-link is-valid-page">Settings =&gt; Media Management (Advanced Settings Shown) =&gt; Series Folder Format</a>

  - Series Folder: `{Series TitleYear}`
  - Season Folder: `Season {season:00}`

- Note: You can adjust the tokens above using any of the <a href="/sonarr/settings#series-folder-format" class="is-internal-link is-valid-page">series naming tokens</a> that Sonarr supports.

## <a href="#linux-bash-script" class="toc-anchor">¶</a> Linux Bash Script

The following script will take all video files within your selected folder and move each into a folder based on the series portion of its name. Note that this does not go into subfolders within the starting/selected folder. Sort the resulting folders before importing — this is a starting point, not a parser.

``` prismjs
cd /path/to/your/episode/files/
find . -maxdepth 1 -type f \( -iname "*.mkv" -o -iname "*.mp4" \) -exec sh -c 'mkdir "${1%.*}" ; mv "${1%}" "${1%.*}" ' _ {} \;
```

## <a href="#windows-powershell" class="toc-anchor">¶</a> Windows Powershell

Alternatively in Windows you can run the following script in Powershell to iterate over each file in a directory, and move it to a folder with the same name.

``` prismjs
Get-ChildItem -File |
  ForEach-Object {
    $dir = New-Item -ItemType Directory -Name $_.BaseName -Force
    $_ | Move-Item -Destination $dir
  }
```


