> Source: https://wiki.servarr.com/lidarr/library



# <a href="#artists" class="toc-anchor">¶</a> Artists

The Artists index is the main view of your library. Each row represents an artist Lidarr is tracking, with columns showing monitoring status, quality and metadata profiles, album count, track availability, path, tags, and disk size.

## <a href="#views" class="toc-anchor">¶</a> Views

The toolbar's **View** toggle switches between four display modes:

- **Table**: a sortable list with configurable columns. Use **Options** to show or hide individual columns.
- **Posters**: artist artwork in a grid, good for browsing a large library visually.
- **Banners**: wide banner art, one artist per row.
- **Overview**: artist art alongside a short biography and key stats.

## <a href="#actions" class="toc-anchor">¶</a> Actions

The toolbar above the artist list contains the following actions:

- **Update All** / **Update Filtered** / **Update Selected**: refreshes metadata for all artists, the current filtered view, or only the selected artists from the Servarr metadata server and rescans their folders.
- **RSS Sync**: polls your configured indexers' RSS feeds immediately, rather than waiting for the next scheduled sync.
- **Select Artists**: enters select mode, showing a footer with bulk-action buttons (Edit, Rename Files, Write Metadata Tags, Set App Tags, Update Monitoring, Delete) that apply to the artists you select.
- **Options**: shows or hides columns in Table view and adjusts poster/banner/overview size in the grid views.

## <a href="#filters" class="toc-anchor">¶</a> Filters

The **Filter** button narrows the artist list. Built-in filters:

- **All**: every artist in the library, monitored or not.
- **Monitored**: artists with monitoring enabled.
- **Unmonitored**: artists with monitoring disabled. Lidarr won't search for new releases from these artists.
- **Continuing**: artists whose career status is active/continuing.
- **Ended**: artists who are no longer releasing new music.
- **Missing**: artists that have at least one track with no file on disk.
- **Custom Filters**: you can build and save your own filters against any combination of artist fields (monitored status, quality profile, metadata profile, path, tags, added date, and more).

## <a href="#artist-detail" class="toc-anchor">¶</a> Artist detail

Clicking an artist's name opens their detail page, which shows the artist biography, a full list of release groups, and the per-album track breakdown. From here you can:

- Toggle monitoring on individual albums or the artist as a whole.
- Trigger a refresh and rescan for just that artist.
- Edit the artist's quality profile, metadata profile, root folder, tags, and monitoring status.
- Trigger an automatic search for a specific album.

# <a href="#add-new" class="toc-anchor">¶</a> Add New

The Add New tab is where you search for and add artists to Lidarr. Search by name or paste a MusicBrainz artist ID directly (prefixed with `lidarr:`, for example, `lidarr:9255f594-b912-4bdf-87a2-ada04502a459`). See <a href="/lidarr/faq#finding-music-and-musicbrainz" class="is-internal-link is-valid-page">Finding music and MusicBrainz</a> in the FAQ if an artist is hard to find.

When adding an artist you will set:

- **Root Folder**: the parent directory under which Lidarr will create the artist's folder.
- **Monitor**: which albums to monitor initially (All Albums, Future Albums, Missing Albums, Existing Albums, First Album, Latest Album, or None).
- **Monitor New Items**: how to handle new releases added to the artist's discography after the artist is added (All Albums, New Albums, or None).
- **Quality Profile**: the target quality and upgrade rules for this artist's files.
- **Metadata Profile**: which release group types (Album, Single, EP, etc.) and statuses to include in the artist's library.
- **Tags**: optional tags to assign to the artist for use in custom filters and profiles.
- **Start Search for Missing Albums**: triggers an immediate search after adding, rather than waiting for the next scheduled search.

# <a href="#library-import" class="toc-anchor">¶</a> Library Import

Library Import is for bringing an existing organised music collection into Lidarr. It scans a root folder, matches what it finds to MusicBrainz release groups, and imports matched files into Lidarr's library without moving or copying them.

See <a href="/lidarr/importing-existing-library" class="is-internal-link is-valid-page">Importing an Existing Library</a> for the full walkthrough, including how to prepare your files, what the matching thresholds are, and what to do when files don't match automatically.

> Library Import is for an already-organised library. To import files from a download folder, use **Manual Import** from the toolbar instead.


