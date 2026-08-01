> Source: https://wiki.servarr.com/lidarr/concepts



# <a href="#lidarr-concepts" class="toc-anchor">¶</a> Lidarr Concepts

This page explains the model Lidarr uses to manage music, why that model depends on MusicBrainz, and when Lidarr is (and isn't) the right tool for your library. If you just want to install and start using Lidarr, read the <a href="/lidarr/quick-start-guide" class="is-internal-link is-valid-page">Quick Start</a> first. Come back here when you want to understand *why* something behaves the way it does.

## <a href="#how-lidarr-manages-music" class="toc-anchor">¶</a> How Lidarr manages music

Lidarr is a music library management system, data aggregator, and automation platform for finding and downloading media. At a high level it follows the same principles as the other Arr applications (Sonarr, Radarr, etc.), but music introduces complications that film and TV don't.

Unlike movies and TV shows, music has no consistent set of standards for tagging, naming, or storage. Distribution has shifted from physical media to electronic over decades, which has widened the variation rather than narrowed it. Opinions on how to handle music-library management are wide and varied, and Lidarr has to pick one.

The choice Lidarr makes is to lean on third-party metadata to impose order. Every album and artist in Lidarr corresponds to a record in an external data source, and Lidarr uses that record to categorize, tag, and manage files. Everything else in this page follows from that decision.

> If the data doesn't exist in third-party services, Lidarr can't manage it.

## <a href="#the-release-model" class="toc-anchor">¶</a> The Release model

Lidarr organizes music around the `Release` standard from MusicBrainz. Every item Lidarr manages must correspond to a `Release` in its metadata source.

Examples of `Releases`:

- Album
- EP
- Single
- Broadcast

If something you want to manage doesn't exist as a `Release` in the metadata source, Lidarr can't handle it. Lidarr has no "add it locally only" escape hatch.

Lidarr is audio-only. MusicBrainz marks some recordings as video (music videos, live video streams, etc.). Lidarr skips those entirely and won't search for, grab, or import a release where all tracks carry the video flag.

> You can only manage `Releases` in Lidarr if they exist in third-party services.

## <a href="#release-groups-and-releases" class="toc-anchor">¶</a> Release groups and releases

MusicBrainz distinguishes two levels: the **release group** ("the album") and the **release** ("a specific edition of the album"). The 2005 studio album is a release group. The 2005 CD edition, the 2005 vinyl pressing, and the 2015 remastered reissue are all releases within that release group.

Lidarr's `Album` corresponds to **MusicBrainz's release group**, not its release. When Lidarr adds an album, it's adding the release group and tracking one of its releases as the "active" release for your library.

Two consequences follow:

- **You can't add a single release without its release group.** There's no "only this pressing" model in Lidarr; the release group is always added, and Lidarr designates one of its releases as active. You can switch which release is active from the album's Edit dialog. This is how you tell Lidarr to match the 2015 remaster instead of the 2005 original.
- **Adding "just an album" still involves the artist.** When you add an album, Lidarr also needs the artist record in its database. You can add the album without monitoring the rest of the artist's catalogue by setting monitoring to *None* at add-time; the artist row exists in Lidarr's database but Lidarr only monitors the target album.

Individual tracks aren't addable in isolation. A recording released as part of an album lives inside that release group. To fetch it, add the release group and let Lidarr fetch the whole thing. Where MusicBrainz classifies a track as a single (its own release group of type `Single`), Lidarr can handle it. That's one of the reasons Metadata Profiles expose `Single` as a release-group-type toggle separate from `Album`.

The <a href="/lidarr/metadata-troubleshooting" class="is-internal-link is-valid-page">Metadata Troubleshooting</a> page covers the related failure modes. For example, it describes what happens when a release group has `Type: Unknown` and your Metadata Profile filters it out.

## <a href="#the-artist-model" class="toc-anchor">¶</a> The Artist model

An `Artist` in Lidarr is the `Release Artist`: the artist the metadata source attributes a `Release` to. This is a slippery thing to pin down: naming, stylization, collaborations, and user preferences all contribute to ambiguity about what counts as "the" artist.

Consider how many ways the same person can appear:

- Bob Dylan
- BOB DYLAN
- The Bob Dylan
- Bob Dylan, The
- Bob Dylan & the Band
- Bob Dylan feat. The Band
- The Band featuring Bob Dylan

Each `Release` belongs to exactly one `Artist`. To add a `Release` in Lidarr, find the canonical `Artist` as the metadata source defines it. This isn't necessarily the name on the album cover. It's the name in MusicBrainz. This is the source of most "why can't I add this artist?" problems. See the <a href="/lidarr/faq" class="is-internal-link is-valid-page">FAQ</a> for specific cases.

> You can only manage `Release Artists` in Lidarr if they exist in third-party services.

## <a href="#dependence-on-musicbrainz" class="toc-anchor">¶</a> Dependence on MusicBrainz

The metadata source Lidarr relies on is <a href="https://musicbrainz.org/" class="is-external-link">MusicBrainz</a>, a free, community-driven service that exists and survives on user contributions. Lidarr doesn't have its own metadata. It reads MusicBrainz's.

Two practical consequences follow.

**Missing or incorrect data is a MusicBrainz problem, not a Lidarr problem.** If an album isn't showing up in Lidarr, the first question to ask is whether it exists on MusicBrainz and whether the data there's correct. Lidarr doesn't offer a way to edit metadata locally. It reads MusicBrainz and doesn't override it. Fixes have to happen upstream at MusicBrainz, and Lidarr picks them up on the next refresh after propagation.

**Propagation takes time.** When someone adds or corrects a record on MusicBrainz, Lidarr doesn't see it immediately. Updates flow from MusicBrainz through a periodic sync into a metadata service that Lidarr queries, and from there into your instance on refresh. You can refresh individual artists and albums inside Lidarr once the upstream propagation has happened, but you can't speed up the propagation itself. Expect a delay measured in hours to days, not minutes.

If you find that a `Release` or `Release Artist` is missing from MusicBrainz, you can help fix it: see <a href="https://musicbrainz.org/doc/How_to_Contribute" class="is-external-link">How To Contribute</a>. Creating and editing MusicBrainz records is beyond the scope of this wiki.

## <a href="#hardlinks-and-completed-downloads" class="toc-anchor">¶</a> Hardlinks and completed downloads

Two questions that come up often enough to answer here:

- *Why do I have the same file in my download folder and my library folder?*
- *Why do files stay in the download folder after Lidarr imported them?*

Both are expected with the default Lidarr workflow, and both are answered by understanding how the post-import handoff works.

### <a href="#the-torrent-download-flow" class="toc-anchor">¶</a> The torrent download flow

1.  Lidarr sends a download request to the torrent client, tagged with a category (default: `lidarr-music` or similar, configurable per download client).
2.  Lidarr watches the download client's queue via its API for items in that category.
3.  When a download finishes, Lidarr imports the files into the library folder. Whether that import copies or hardlinks is determined by filesystem support. See below.
4.  The torrent client keeps the files in the download folder so it can seed. That's why the file "is left in downloads" after import.
5.  Optionally, if **Completed Download Handling → Remove Completed** is enabled, Lidarr tells the torrent client to remove the torrent and its files *after* seeding is complete. If you don't want the file to persist in the download folder at all, this is the setting to turn on.

### <a href="#hardlinks" class="toc-anchor">¶</a> Hardlinks

If the download folder and the library folder are on the **same filesystem** (same mount, same partition), Lidarr uses a **hardlink** instead of a copy. A hardlink is a second directory entry pointing at the same underlying file. The file appears in both folders but only occupies disk space once. Lidarr can import by hardlink before the torrent finishes seeding, and seeding continues to work on the original file because they are literally the same bytes on disk.

If the download folder and the library folder are on **different filesystems**, Lidarr can't hardlink across them and falls back to a copy. The copy doubles the disk space until the download client cleans up its side.

**The requirement for hardlinks to work:**

- Both folders must be on the same filesystem (same mount point, same volume).
- In Docker, both folders must be mounted through the same volume or bind mount. Two separate volumes, even pointing at the same host filesystem, won't hardlink.
- The TRaSH Guides <a href="https://trash-guides.info/hardlinks" class="is-external-link">Hardlinks and Instant Moves</a> page has a detailed walkthrough of the common misconfigurations.

> Hardlinks are enabled by default. If you are seeing double disk usage, the usual culprits are mismatched mounts (Docker), a download client writing to a different filesystem than the library, or a filesystem that doesn't support hardlinks (some network filesystems, FAT32).

## <a href="#is-lidarr-right-for-your-library" class="toc-anchor">¶</a> Is Lidarr right for your library?

Lidarr is built around the `Release` model. If your library doesn't fit that model, Lidarr will be a frustrating tool no matter how much you tune it. Lidarr **isn't** a good fit for the following situations.

- **A loose collection of files.** Files from multiple artists (not compilations) or multiple `Releases` sharing a single folder. Low-to-no-curation libraries won't work with Lidarr. Don't try.
- **Classical music libraries.** Classical releases typically have extensive tagging requirements, and `Release` metadata on MusicBrainz is often missing or incorrect. You can use Lidarr, but expect substantial manual work.
- **Singles-heavy libraries.** Many singles aren't actual `Releases` in MusicBrainz. Third-party data sources return no metadata for them, so they can't be automated.
- **Mixes, beats, and samples.** Libraries made of DJ mixes, beat packs, or producer samples (Beatport-style content). These aren't `Releases` in the metadata sources and Lidarr can't manage them. This does *not* apply to albums in the Electronic genre, which are fine.

If most of your library falls into one of the above categories, Lidarr may not be the right tool. If only part of your library does, you can still use Lidarr for the rest. Just expect to manage the problematic portion by hand.

## <a href="#alternatives-and-companion-tools" class="toc-anchor">¶</a> Alternatives and companion tools

The tools below can be used instead of, or alongside, Lidarr.

- <a href="https://beets.io/" class="is-external-link">Beets</a>: music library organizer and tagger, strong at bulk cleanup.
- <a href="https://picard.musicbrainz.org/" class="is-external-link">MusicBrainz Picard</a>: the canonical MusicBrainz tagger.
- <a href="https://getmusicbee.com/" class="is-external-link">MusicBee</a>: music player with strong library-management features.

Using these in tandem with Lidarr is beyond the scope of this page, but they're common companions for preparing a library before import, or for managing the parts of a collection Lidarr can't.

## <a href="#see-also" class="toc-anchor">¶</a> See also

- <a href="/lidarr/quick-start-guide" class="is-internal-link is-valid-page">Quick Start</a>: install and reach your first download.
- <a href="/lidarr/importing-existing-library" class="is-internal-link is-valid-page">Importing an Existing Library</a>: migrating files you already have.
- <a href="/lidarr/metadata-troubleshooting" class="is-internal-link is-valid-page">Metadata Troubleshooting</a>: fixing missing or incorrect MusicBrainz data.
- <a href="/lidarr/faq" class="is-internal-link is-valid-page">FAQ</a>: common questions and troubleshooting.
- <a href="/lidarr/settings" class="is-internal-link is-valid-page">Settings</a>: detailed reference for every configuration option.


