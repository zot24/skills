> Source: https://wiki.servarr.com/lidarr/metadata-troubleshooting



# <a href="#metadata-troubleshooting" class="toc-anchor">¶</a> Metadata Troubleshooting

> Why can't I add or update this album? This page walks through the most common MusicBrainz-related problems in Lidarr — propagation lag, unknown release statuses, bad matches, and the cache-bust process — and helps decide whether to retry, wait, or fix data upstream.

If you're new to how Lidarr depends on MusicBrainz, read <a href="/lidarr/concepts#dependence-on-musicbrainz" class="is-internal-link is-valid-page">Concepts</a> first. This page assumes you already know that MusicBrainz is the source of truth and Lidarr reads from it through a cache.

## <a href="#how-musicbrainz-data-reaches-lidarr" class="toc-anchor">¶</a> How MusicBrainz data reaches Lidarr

Three caches sit between MusicBrainz and what you see in the UI:

1.  **MusicBrainz itself.** Community-maintained. Every edit goes through a review window before it's visible on `musicbrainz.org`.
2.  **The Servarr metadata server.** An intermediate proxy that mirrors MusicBrainz and serves Lidarr. It pulls from MusicBrainz on a schedule and holds a cache so every Lidarr install doesn't hammer MusicBrainz directly.
3.  **Lidarr's local database.** Lidarr refreshes artists on its own schedule and stores the result locally.

A change made at MusicBrainz is only visible in Lidarr once it has propagated through all three. Expect hours, sometimes longer. This is normal — most "it's on MusicBrainz but not in Lidarr" reports are propagation, not breakage.

## <a href="#its-on-musicbrainz-but-lidarr-doesnt-see-it" class="toc-anchor">¶</a> It's on MusicBrainz but Lidarr doesn't see it

Three likely causes, in order of how often they come up:

### <a href="#h-1-propagation-lag" class="toc-anchor">¶</a> 1. Propagation lag

The edit hasn't reached the Servarr metadata server yet, or it has, but Lidarr hasn't refreshed the artist since.

- Give it at least one full refresh cycle (see [Refresh cadence](#refresh-cadence)).
- Trigger **Refresh Artist** in Lidarr manually once that window has passed.
- If it's a brand-new artist or release on MusicBrainz, allow longer — new entities take longer to propagate than edits to existing ones.

### <a href="#h-2-the-release-status-is-unknown" class="toc-anchor">¶</a> 2. The release status is `unknown`

Lidarr only imports releases with statuses it recognises. Lidarr skips anything with status `unknown` at MusicBrainz, even if the release is otherwise complete.

Statuses Lidarr can import, depending on the **Release Statuses** selected in your metadata profile:

- Official
- Promotion
- Bootleg
- Pseudo-Release

The fix is to update the status at MusicBrainz — typically to `Official`. See [Updating MusicBrainz](#updating-musicbrainz) below for the tools.

> The `unknown` status is the single most common reason a release visible on `musicbrainz.org` doesn't appear in Lidarr. Check the status on the MusicBrainz release page before concluding there is a bug on the Lidarr side.

### <a href="#h-3-wrong-release-matched" class="toc-anchor">¶</a> 3. Wrong release matched

Lidarr matched the release group to one specific release (one pressing, one format) that doesn't include the tracks you were expecting. The data is fine. The match is wrong. See [Picking the right release](#picking-the-right-release).

## <a href="#picking-the-right-release" class="toc-anchor">¶</a> Picking the right release

A release group on MusicBrainz can have many releases underneath it: one per pressing, per format (CD, vinyl, digital, cassette), per region, and sometimes per edition (standard, deluxe, remastered). Lidarr tracks *release groups* as albums and only holds **one** release per album at a time. If Lidarr picked a different release than the one you have, the track list won't match.

To switch releases:

1.  Open the album's detail page in Lidarr.
2.  Click the **Edit** icon in the top navigation.
3.  Use the release dropdown to pick a different release from the same release group.

If none of the releases match what you have, the release probably doesn't exist at MusicBrainz yet. [Add it upstream](#updating-musicbrainz) rather than trying to work around the gap in Lidarr.

## <a href="#meta-artists-like-various-artists" class="toc-anchor">¶</a> Meta-artists like Various Artists

"Various Artists," soundtracks, and similar meta-artists on MusicBrainz have thousands of releases attached because the entity acts as a catch-all. Lidarr doesn't add these by design. Pulling in every compilation ever credited to Various Artists would be a bulk metadata load that punishes both the user and the metadata server.

If you want a specific compilation album, add it under the artists who actually perform on it, or add the album directly and leave the artist unmonitored.

## <a href="#lidarr-keeps-trying-to-download-the-same-album" class="toc-anchor">¶</a> Lidarr keeps trying to download the same album

If an album is already imported and Lidarr starts searching for and grabbing it again, the cause is upstream at MusicBrainz, not in Lidarr. This can happen more than once, sometimes into the same folder on top of what's already there.

The common trigger: someone adds a new pressing, format, or remaster to MusicBrainz but creates a new release group instead of adding it to the existing one. Because Lidarr treats each release group as an album, the new release group appears as a distinct new album. Lidarr then monitors it and starts the grab-and-import cycle for something you already have.

Two fixes:

- **Local / immediate.** Unmonitor the new (duplicate) album in Lidarr so it stops trying to download. This stops the symptom but leaves the underlying MusicBrainz structure wrong; the same thing will happen the next time someone adds a release to the duplicate group.
- **Upstream / full fix.** Merge the release groups on MusicBrainz so there's only one album entity. The edit goes through the usual MusicBrainz review window — expect days. Once approved and propagated, Lidarr collapses the duplicate back into a single album on the next refresh.

If you notice this pattern for a specific artist, spot-check their MusicBrainz discography for other duplicated release groups while you're already there. Merging them in one pass is cheaper than catching each duplicate one at a time.

## <a href="#refresh-cadence" class="toc-anchor">¶</a> Refresh cadence

- **Lidarr ↔ metadata server:** every 24 hours.
- **Metadata server ↔ MusicBrainz:** faster but not instant; assume hours, not minutes.
- **Cover art updates:** slowest of the three — expect days. Covers aren't pulled directly by Lidarr — see [Cover art](#cover-art) below.

If an edit is more than 3 hours old, visible on MusicBrainz, and still absent from Lidarr after a manual **Refresh Artist**, use the cache-bust process.

### <a href="#metadata-server-cache-bust" class="toc-anchor">¶</a> Metadata server cache-bust

The Servarr metadata server occasionally holds onto stale data past the normal refresh window. When that happens, a **Servarr Team Member** or **Servarr Donatarr** can clear the cache for a specific artist or album. Any user who donates any amount to Servarr becomes a Donatarr and can run `!refresh` commands directly — no need to wait for a team member.

- This is less common now that the metadata server has been rebuilt. Try a manual Refresh Artist after 3 hours first.
- Run the refresh bot commands in the **`#bot-spam`** channel on the <a href="https://lidarr.audio/discord" class="is-external-link">Servarr Discord</a>. The format is:
  - **Album:** `!refresh album/<release-group-mbid>` — note this is the **release group** MBID (what Lidarr calls the album ID), not the release MBID. Mixing these two up is the most common reason a refresh request does nothing.
  - **Artist:** `!refresh artist/<artist-mbid>` — the artist MBID from MusicBrainz.
- Example: `!refresh album/96eacc6a-b618-490b-91f2-6e58b57b57aa` or `!refresh artist/9255f594-b912-4bdf-87a2-ada04502a459`.
- The cache-bust forces a pull from MusicBrainz on the next refresh — it doesn't skip Lidarr's own refresh schedule. After the bot confirms, still expect to wait one Lidarr refresh cycle before seeing the change locally.

> **Release ID vs. Release Group ID.** MusicBrainz has two IDs that look similar but point to different things. The *release group* is the album (for example, *Kid A*); the *release* is a specific pressing of it (for example, the 2000 UK CD vs. the 2017 remaster). Lidarr treats albums as release groups — so the ID you want for `!refresh album/…` is the one shown on the MusicBrainz **release group** page, not the individual release page.

## <a href="#about-the-refresh-releases-task" class="toc-anchor">¶</a> About the refresh releases task

Refresh Releases is the task that keeps Lidarr's local view of metadata in sync with the metadata server. You can't disable it, and you shouldn't try through database edits or other workarounds. Lidarr relies on it to catch upstream corrections (ID changes, alt titles, ratings, summaries, translations) that affect matching and organisation.

If the refresh is causing heavy disk I/O, the setting to look at is **Rescan Artist Folder after Refresh**:

- Default is `Always`, which re-reads every file after every refresh.
- Changing it to `After Manual Refresh` resolves the I/O problem — refreshes still update metadata, they just don't re-scan files on disk.
- **Don't** set it to `Never` unless every change to your library (additions, upgrades, deletions) goes through Lidarr. Lidarr won't pick up manual file changes or third-party tooling if rescans never run.

## <a href="#updating-musicbrainz" class="toc-anchor">¶</a> Updating MusicBrainz

Fixes to metadata happen at MusicBrainz, not in Lidarr. Lidarr reads MusicBrainz. It doesn't override it.

### <a href="#harmony-recommended" class="toc-anchor">¶</a> Harmony (recommended)

<a href="https://harmony.pulsewidth.org.uk/" class="is-external-link">Harmony</a> is a music-metadata aggregator and MusicBrainz importer. For most users it's the easiest and most accurate way to add a missing release. It pulls release data from upstream sources (streaming services, digital retailers, etc.) and cross-references them. The result is a MusicBrainz-ready import with the key fields (album type, release status, track list) already populated. Compared to hand-editing on MusicBrainz, Harmony avoids the common mistakes (missing album type, wrong status) that cause a newly imported release to land as `unknown` and stay invisible to Lidarr.

Use Harmony when:

- The release is missing from MusicBrainz entirely and exists on a streaming service Harmony supports.
- An existing MusicBrainz release has sparse data (missing tracks, missing status) that the upstream source has in full.

### <a href="#musicbrainz-userscripts" class="toc-anchor">¶</a> MusicBrainz userscripts

The MusicBrainz community maintains a set of browser userscripts that assist with editing and importing — see the <a href="https://musicbrainz.org/doc/Guides/Userscripts" class="is-external-link">MusicBrainz Userscripts guide</a>. These are useful for bulk imports from specific sources (Bandcamp, Discogs, streaming services, etc.).

> **Caveat for Lidarr users.** Some userscripts don't copy every field from the upstream source. The field that most often gets missed is the **album type** — if the imported release lands at MusicBrainz without a primary type, it shows up as `unknown` and Lidarr won't add it. After any scripted import, verify the release's type on MusicBrainz before submitting, and expect to fix it manually if the script left it blank.

### <a href="#musicbrainz-web-editor" class="toc-anchor">¶</a> MusicBrainz web editor

Direct edits on <a href="https://musicbrainz.org" class="is-external-link">musicbrainz.org</a> are the right path for:

- Changing a release status from `unknown` to `Official`
- Correcting track lists, durations, or titles on an existing release
- Fixing album type or secondary type on an existing release

All edits go through a review window: allow a few days for the change to become visible site-wide, then more propagation time through the metadata server and Lidarr. Start counting from when you submit the edit, not from when it appears on MusicBrainz.

### <a href="#musicbrainz-picard" class="toc-anchor">¶</a> MusicBrainz Picard

<a href="https://picard.musicbrainz.org/" class="is-external-link">Picard</a> is a tagging application that reads files, identifies releases, and tags against MusicBrainz IDs. For users already tagging a library, Picard is the right tool to keep files in sync with MusicBrainz once the data there is correct. Clean tags also improve matching on import (see <a href="/lidarr/importing-existing-library#tagging" class="is-internal-link is-valid-page">Importing an Existing Library</a>).

Picard is a *tagging* tool. For adding or editing releases at MusicBrainz, reach for Harmony or the web editor instead.

### <a href="#cover-art" class="toc-anchor">¶</a> Cover art

Cover art **isn't pulled directly by Lidarr** — the Servarr metadata server serves covers to Lidarr, aggregating from upstream sources. The canonical place to upload album art is the <a href="https://coverartarchive.org/" class="is-external-link">Cover Art Archive</a> (attached to the MusicBrainz release), but don't expect an instant appearance in Lidarr:

- The metadata server's refresh cadence for cover data is slower than for textual metadata.
- Lidarr displays whatever cover URL the metadata server hands it; if the server hasn't yet picked up the new upload, Lidarr won't either.
- Plan on days, not hours. If a cover still hasn't appeared after a full week, a cache-bust request is the right next step.

> This page doesn't cover MusicBrainz's style guidelines or the review process. If you have never edited MusicBrainz before, start with <a href="https://musicbrainz.org/doc/How_to_Contribute" class="is-external-link">How to Contribute</a> on the MusicBrainz wiki.

## <a href="#spotify-import-list-rate-limiting" class="toc-anchor">¶</a> Spotify import list rate limiting

When Lidarr processes a Spotify import list, it resolves each Spotify track or album ID to a MusicBrainz ID in two stages:

1.  **Cache lookup** — Lidarr sends all Spotify IDs to the Servarr metadata server at once. The server returns MusicBrainz IDs for any Spotify IDs it has already cached.
2.  **Individual lookups** — for any Spotify ID not in the cache, Lidarr falls back to querying the metadata server one ID at a time. A large playlist or many concurrent lists can generate enough individual lookups to trigger a 429 rate-limit response from the metadata server.

When you hit the rate limit, Lidarr won't add affected albums to its queue until the limit clears.

**Resolution:**

- **Wait** — the rate-limit window will expire and Lidarr will retry on the next list sync.
- **Add the missing Spotify link to MusicBrainz** — if the MusicBrainz release for an album doesn't have its Spotify album URL in the relationship links, the metadata server can't cache that mapping. Adding the Spotify relationship to the release on MusicBrainz allows the server to cache it, so future lookups for that album resolve from cache rather than triggering an individual API call.

To add a Spotify relationship on MusicBrainz, open the release and go to **Edit** → **Add Relationship**. Set the type to **stream for free** (Spotify) or the appropriate streaming relationship type, then paste the Spotify album URL. The cache will pick it up on the next metadata server refresh cycle.

> A 429 from Spotify doesn't mean anything is wrong with your Lidarr setup — it's a server-side rate limit on lookups. Checking Lidarr's logs at Debug level will show the 429 responses if you want to confirm that's the cause.

## <a href="#retry-or-wait" class="toc-anchor">¶</a> Retry or wait

| Situation                                                             | Action                                                                                                                                                       |
|-----------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| You just submitted an edit at MusicBrainz                             | Wait ~3 hours, then **Refresh Artist** in Lidarr                                                                                                             |
| You just uploaded cover art to the Cover Art Archive                  | Allow days, not hours — covers propagate slower than metadata                                                                                                |
| A release status was `unknown` and you changed it                     | Wait ~3 hours after the edit's visible on MusicBrainz, then **Refresh Artist**                                                                               |
| A scripted import left the album type blank                           | Fix the type on MusicBrainz first; the release is invisible to Lidarr until then                                                                             |
| Lidarr matched the wrong release                                      | Use the release dropdown on the album detail page — no waiting needed                                                                                        |
| You already waited 3+ hours and refreshed and the data is still wrong | Request a cache-bust on the Servarr Discord with `!refresh album/<release-group-mbid>` or `!refresh artist/<artist-mbid>`                                    |
| The release doesn't exist on MusicBrainz at all                       | Add it with <a href="https://harmony.pulsewidth.org.uk/" class="is-external-link">Harmony</a> or the MusicBrainz web editor, then follow the first row above |

## <a href="#see-also" class="toc-anchor">¶</a> See also

- <a href="/lidarr/concepts#dependence-on-musicbrainz" class="is-internal-link is-valid-page">Concepts</a> — why Lidarr depends on MusicBrainz and what the Release/Artist model looks like
- <a href="/lidarr/importing-existing-library" class="is-internal-link is-valid-page">Importing an Existing Library</a> — tagging and pre-import considerations that affect matching
- <a href="/lidarr/faq" class="is-internal-link is-valid-page">FAQ</a> — shorter answers and the operational questions that don't fit this page
- <a href="https://harmony.pulsewidth.org.uk/" class="is-external-link">Harmony</a> — recommended tool for importing releases into MusicBrainz
- <a href="https://musicbrainz.org/doc/Guides/Userscripts" class="is-external-link">MusicBrainz Userscripts</a> — browser userscripts for MusicBrainz editing (watch the album-type caveat above)
- <a href="https://lidarr.audio/discord" class="is-external-link">Servarr Discord</a> — where cache-bust reque


