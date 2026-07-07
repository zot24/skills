> Source: https://wiki.servarr.com/lidarr/quick-start-guide



# <a href="#lidarr-quick-start" class="toc-anchor">¶</a> Lidarr Quick Start

This guide walks you from a fresh Lidarr install to your first successful download in about fifteen minutes, using default settings everywhere. It assumes Lidarr is already installed — if it isn't, start with the <a href="/lidarr/installation" class="is-internal-link is-valid-page">Installation</a> page.

> The Lidarr UI shows advanced options in `orange`. Click **Show Advanced** at the top of the relevant page to reveal them.

## <a href="#who-this-is-for" class="toc-anchor">¶</a> Who this is for

This page is for users starting with an empty library who want to get to a first download quickly. The defaults used below are deliberately minimal and are safe to refine later.

If any of the following describes you, read the linked page instead — the quick path here won't work for your setup:

- You already have music files on disk and want Lidarr to manage them → <a href="/lidarr/importing-existing-library" class="is-internal-link is-valid-page">Importing an Existing Library</a>.
- You want to understand *why* Lidarr behaves the way it does, or whether it fits your library at all → <a href="/lidarr/concepts" class="is-internal-link is-valid-page">Concepts</a>.
- You need field-by-field detail on a setting → <a href="/lidarr/settings" class="is-internal-link is-valid-page">Settings</a>.

## <a href="#first-start" class="toc-anchor">¶</a> First start

After installation, open Lidarr in a browser at `http://<your-ip>:8686`.

![lidarr_qs_startup.png](/assets/lidarr/quick-start-guide/lidarr_qs_startup.png)

Ignore the two options on the startup screen for now; you'll configure everything manually through Settings.

## <a href="#configure-the-essentials" class="toc-anchor">¶</a> Configure the essentials

Four settings areas need input before Lidarr can find and import music: Media Management, Profiles & Quality, Indexers, and Download Clients. Defaults are fine for everything except the items called out below.

### <a href="#media-management" class="toc-anchor">¶</a> Media Management

Set a `Root Folder` — this is where imported music will live.

Click **Settings → Media Management**, then under **Root Folders** click **Add (+)**.

![lidarr_qs_mediamanagement.png](/assets/lidarr/quick-start-guide/lidarr_qs_mediamanagement.png)

![lidarr_qs_rootfolder.png](/assets/lidarr/quick-start-guide/lidarr_qs_rootfolder.png)

Fill in:

- **Name** — a friendly label.
- **Path** — the directory on disk where Lidarr stores music files. The Lidarr user must have read and write access. **This must not be the same folder your download client writes to.**

Leave everything else at defaults.

> Don't put Lidarr's root folder on a cloud storage provider. Lidarr writes tags frequently, which will exhaust cloud-service API quotas and cause failures. Keep the library on local or network-attached storage.

> NFS mounts need `nolock`; SMB mounts need `nobrl`. Non-Windows only.

> The root folder must not overlap with your download client's output folder. Lidarr imports *from* downloads *to* the root folder — they need to be distinct locations on the same filesystem (for fast moves and hardlinks).

If you already have music files here, stop — see <a href="/lidarr/importing-existing-library" class="is-internal-link is-valid-page">Importing an Existing Library</a> before saving this root folder.

### <a href="#profiles-quality" class="toc-anchor">¶</a> Profiles & Quality

`Settings → Profiles` and `Settings → Quality` — leave both at defaults. They're good enough to get to a first download. You can refine them later; see <a href="/lidarr/settings#profiles" class="is-internal-link is-valid-page">Settings → Profiles</a> and <a href="/lidarr/settings#quality" class="is-internal-link is-valid-page">Settings → Quality</a>.

### <a href="#indexers" class="toc-anchor">¶</a> Indexers

`Settings → Indexers` — add at least one. Lidarr treats Usenet indexers and BitTorrent trackers both as `Indexers`.

Click **Add (+)** and pick one you have access to. Choosing and configuring an indexer is outside the scope of this page — see the <a href="/lidarr/supported#indexers" class="is-internal-link is-valid-page">Supported Indexers</a> list and <a href="https://trash-guides.info/" class="is-external-link">TRaSH's indexer guides</a> for options and setup details.

### <a href="#download-clients" class="toc-anchor">¶</a> Download Clients

`Settings → Download Clients` — add at least one.

![lidarr-settings-download-clients.png](./images/lidarr-settings-download-clients.png)

Lidarr sends downloads to your client with a label/category (for example, `music`), watches the client's API for completion, then imports finished files into your root folder. The client and Lidarr must both be able to read the same filesystem path, and that path must be on the same mount as your root folder for hardlinks and atomic moves to work.

> Volume and path configuration is the single most common source of import failures, especially with Docker. If Lidarr and your download client run in separate containers, both must mount the same host path at the same container path. See <a href="/lidarr/installation/docker#volumes-and-paths" class="is-internal-link is-valid-page">Installation → Docker</a> and <a href="https://trash-guides.info/hardlinks/" class="is-external-link">TRaSH's hardlink guide</a> before configuring.

For field-level detail see <a href="/lidarr/settings#download-clients" class="is-internal-link is-valid-page">Settings → Download Clients</a> and the <a href="/lidarr/supported#download-clients" class="is-internal-link is-valid-page">Supported Download Clients</a> list.

## <a href="#add-your-first-artist" class="toc-anchor">¶</a> Add your first artist

With settings done, add an artist. `Library → Add New`.

![lidarr_qs_addnew.png](/assets/lidarr/quick-start-guide/lidarr_qs_addnew.png)

Search for the artist you want — Lidarr looks them up in MusicBrainz. Select the result and the **Add new Artist** dialog opens.

![lidarr_qs_addnewdylan.png](/assets/lidarr/quick-start-guide/lidarr_qs_addnewdylan.png)

Use these settings:

- **Root Folder** — the one you just created.
- **Monitor** — set to **None** (the UI default is "All Albums"; change it to None so Lidarr doesn't immediately queue everything).
- **Quality Profile** — Any.
- **Tags** — empty.
- **Start search for missing albums** — unchecked.

Save. Lidarr fetches the artist's metadata from MusicBrainz; this takes a few seconds to a few minutes depending on the artist's catalog size.

Click the new artist when it appears.

![lidarr_qs_dylan.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylan.png)

> With the default `Metadata Profile`, Lidarr shows only `Releases` of type **Studio Album**. See <a href="/lidarr/concepts" class="is-internal-link is-valid-page">Concepts</a> for why the metadata profile matters.

## <a href="#trigger-your-first-download" class="toc-anchor">¶</a> Trigger your first download

On the artist page, pick a `Release` to download and click the **Manual Search** (human) icon next to it.

![lidarr_qs_dylanrelease.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylanrelease.png)

Lidarr queries your indexers and shows available results.

![lidarr_qs_dylandownload.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylandownload.png)

Each row shows:

1.  **Title** — the release name as returned by the indexer.
2.  **Quality** — Lidarr's parse of the title into a quality level.
3.  **Warning indicators** — if a result fails a check (wrong album, wrong quality, etc.) Lidarr shows the reason here.
4.  **Download icon** — click to send the release to your download client.

Pick a clean result and click the download icon. Lidarr hands the download off to your client, watches the queue, and imports the finished files into your root folder when the client reports completion.

![lidarr_qs_dylansuccess.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylansuccess.png)

Your imported files will be in the root folder, organized as `<Root Folder>/<Artist>/<Release>/<Track>`.

![lidarr_qs_dylanfolder.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylanfolder.png)

That's the full loop — settings, artist, release, download, import.

## <a href="#what-to-read-next" class="toc-anchor">¶</a> What to read next

- <a href="/lidarr/concepts" class="is-internal-link is-valid-page">Concepts</a> — the `Release` and `Artist` model, and why Lidarr's behavior depends on MusicBrainz.
- <a href="/lidarr/importing-existing-library" class="is-internal-link is-valid-page">Importing an Existing Library</a> — migrating files you already have into Lidarr.
- <a href="/lidarr/settings" class="is-internal-link is-valid-page">Settings</a> — the detailed reference for every configuration option referenced on this page.
- <a href="/lidarr/faq" class="is-internal-link is-valid-page">FAQ</a> — common questions and troubleshooting.


