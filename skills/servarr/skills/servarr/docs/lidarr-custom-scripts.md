> Source: https://wiki.servarr.com/lidarr/custom-scripts



# <a href="#lidarr-custom-scripts" class="toc-anchor">¶</a> Lidarr Custom Scripts

Lidarr can execute a custom script when it imports, renames, or retags an album, or when other events occur. Add scripts via **Settings → Connect → Custom Script**.

A custom script can be any executable accessible by the user Lidarr is running as: a shell script, PowerShell script, Python script, or compiled binary.

## <a href="#lidarr-logs" class="toc-anchor">¶</a> Lidarr logs

Lidarr writes script output to the log files:

| Output         | Log level | Log file                       |
|----------------|-----------|--------------------------------|
| `stdout`       | `Debug`   | `config/logs/Lidarr.debug.txt` |
| `stderr`       | `Error`   | `config/logs/Lidarr.txt`       |
| Script trigger | `Trace`   | `config/logs/Lidarr.trace.txt` |

Enable **Debug** or **Trace** logging in **Settings → General → Logging** to see script output in the log files.

## <a href="#script-requirements" class="toc-anchor">¶</a> Script requirements

- The script file must be executable by the user Lidarr runs as.
- On Linux/macOS: `chmod +x /path/to/your-script.sh`
- On Windows: `.ps1` files must be accessible; you must enable PowerShell script execution (`Set-ExecutionPolicy RemoteSigned`).
- The script must exit cleanly (exit code `0`) on the `Test` event, which Lidarr sends when you click **Test** in the connection settings. A non-zero exit code on Test will show an error, even though no real event fired.

## <a href="#environment-variables" class="toc-anchor">¶</a> Environment variables

Lidarr passes data to your script through environment variables. The variables available depend on the event type, indicated by `lidarr_eventtype`.

> **Variable names are lowercase.** The Lidarr source code defines these variables in Title_Case (for example, `Lidarr_EventType`), but Lidarr builds the environment variable list with .NET's `StringDictionary`, which lowercases every key before passing it to your script. The actual names your script receives are all lowercase, as shown in the tables below. Environment variable names are case-sensitive on Linux and macOS, so scripts on those platforms must use the lowercase form. Windows treats environment variable names as case-insensitive, but using the lowercase form keeps scripts portable across platforms.

### <a href="#common-variables-all-events" class="toc-anchor">¶</a> Common variables (all events)

These three variables are present in every event.

| Environment Variable    | Details                                                                                                                                                                     |
|-------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `lidarr_eventtype`      | The event name: `Grab`, `AlbumDownload`, `Rename`, `TrackRetag`, `ArtistAdd`, `ArtistDeleted`, `AlbumDeleted`, `HealthIssue`, `HealthRestored`, `ApplicationUpdate`, `Test` |
| `lidarr_instancename`   | The Lidarr instance name (set in Settings → General)                                                                                                                        |
| `lidarr_applicationurl` | The configured application URL (set in Settings → General)                                                                                                                  |

### <a href="#grab" class="toc-anchor">¶</a> Grab

Fired when Lidarr sends a release to a download client.

| Environment Variable               | Details                                                      |
|------------------------------------|--------------------------------------------------------------|
| `lidarr_eventtype`                 | `Grab`                                                       |
| `lidarr_artist_id`                 | Internal Lidarr ID for the artist                            |
| `lidarr_artist_name`               | Artist name                                                  |
| `lidarr_artist_mbid`               | MusicBrainz artist ID                                        |
| `lidarr_artist_type`               | Artist type (for example, `Person`, `Group`)                 |
| `lidarr_artist_genres`             | Pipe-separated list of genres                                |
| `lidarr_artist_tags`               | Pipe-separated list of tag labels                            |
| `lidarr_release_albumcount`        | Number of albums in this release                             |
| `lidarr_release_albumreleasedates` | Comma-separated list of album release dates                  |
| `lidarr_release_albumtitles`       | Pipe-separated list of album titles                          |
| `lidarr_release_albumoverviews`    | Pipe-separated list of album overviews                       |
| `lidarr_release_albummbids`        | Pipe-separated list of album MusicBrainz IDs                 |
| `lidarr_release_title`             | Release title as returned by the indexer                     |
| `lidarr_release_indexer`           | Indexer that found the release                               |
| `lidarr_release_size`              | Release size in bytes                                        |
| `lidarr_release_quality`           | Quality name (for example, `FLAC`, `MP3-320`)                |
| `lidarr_release_qualityversion`    | Quality revision version                                     |
| `lidarr_release_releasegroup`      | Release group tag from the release title                     |
| `lidarr_release_indexerflags`      | Indexer flags on the release                                 |
| `lidarr_release_customformat`      | Pipe-separated list of matched custom format names           |
| `lidarr_release_customformatscore` | Total custom format score for this release                   |
| `lidarr_download_client`           | Name of the download client used                             |
| `lidarr_download_client_type`      | Download client name (for example, `qBittorrent`, `SABnzbd`) |
| `lidarr_download_id`               | Download ID in the download client                           |

### <a href="#on-import-on-upgrade" class="toc-anchor">¶</a> On Import / On Upgrade

Fired after Lidarr has successfully imported a downloaded album into the library. `lidarr_eventtype` is `AlbumDownload` for both initial imports and upgrades.

| Environment Variable          | Details                                                           |
|-------------------------------|-------------------------------------------------------------------|
| `lidarr_eventtype`            | `AlbumDownload`                                                   |
| `lidarr_artist_id`            | Internal Lidarr ID for the artist                                 |
| `lidarr_artist_name`          | Artist name                                                       |
| `lidarr_artist_path`          | Root path for this artist                                         |
| `lidarr_artist_mbid`          | MusicBrainz artist ID                                             |
| `lidarr_artist_type`          | Artist type                                                       |
| `lidarr_artist_genres`        | Pipe-separated list of genres                                     |
| `lidarr_artist_tags`          | Pipe-separated list of tag labels                                 |
| `lidarr_album_id`             | Internal Lidarr ID for the album                                  |
| `lidarr_album_title`          | Album title                                                       |
| `lidarr_album_overview`       | Album overview/description                                        |
| `lidarr_album_mbid`           | MusicBrainz release group ID                                      |
| `lidarr_albumrelease_mbid`    | MusicBrainz release ID (specific pressing)                        |
| `lidarr_album_releasedate`    | Album release date                                                |
| `lidarr_download_client`      | Name of the download client                                       |
| `lidarr_download_client_type` | Download client name                                              |
| `lidarr_download_id`          | Download ID in the download client                                |
| `lidarr_addedtrackpaths`      | Pipe-separated list of imported track file paths                  |
| `lidarr_deletedpaths`         | Pipe-separated list of file paths deleted/replaced during upgrade |
| `lidarr_deleteddateadded`     | Pipe-separated list of date-added values for deleted files        |

### <a href="#rename" class="toc-anchor">¶</a> Rename

Fired after Lidarr renames one or more track files for an artist.

| Environment Variable             | Details                                                        |
|----------------------------------|----------------------------------------------------------------|
| `lidarr_eventtype`               | `Rename`                                                       |
| `lidarr_artist_id`               | Internal Lidarr ID for the artist                              |
| `lidarr_artist_name`             | Artist name                                                    |
| `lidarr_artist_path`             | Root path for this artist                                      |
| `lidarr_artist_mbid`             | MusicBrainz artist ID                                          |
| `lidarr_artist_type`             | Artist type                                                    |
| `lidarr_artist_genres`           | Pipe-separated list of genres                                  |
| `lidarr_artist_tags`             | Pipe-separated list of tag labels                              |
| `lidarr_trackfile_ids`           | Comma-separated list of internal track file IDs Lidarr renamed |
| `lidarr_trackfile_paths`         | Pipe-separated list of new (current) paths after rename        |
| `lidarr_trackfile_previouspaths` | Pipe-separated list of old paths before rename                 |

### <a href="#track-retag" class="toc-anchor">¶</a> Track Retag

Fired after Lidarr rewrites tags on one or more track files.

| Environment Variable              | Details                                                |
|-----------------------------------|--------------------------------------------------------|
| `lidarr_eventtype`                | `TrackRetag`                                           |
| `lidarr_artist_id`                | Internal Lidarr ID for the artist                      |
| `lidarr_artist_name`              | Artist name                                            |
| `lidarr_artist_path`              | Root path for this artist                              |
| `lidarr_artist_mbid`              | MusicBrainz artist ID                                  |
| `lidarr_artist_type`              | Artist type                                            |
| `lidarr_artist_genres`            | Pipe-separated list of genres                          |
| `lidarr_artist_tags`              | Pipe-separated list of tag labels                      |
| `lidarr_album_id`                 | Internal Lidarr ID for the album                       |
| `lidarr_album_title`              | Album title                                            |
| `lidarr_album_overview`           | Album overview/description                             |
| `lidarr_album_mbid`               | MusicBrainz release group ID                           |
| `lidarr_albumrelease_mbid`        | MusicBrainz release ID                                 |
| `lidarr_album_releasedate`        | Album release date                                     |
| `lidarr_trackfile_id`             | Internal track file ID                                 |
| `lidarr_trackfile_trackcount`     | Number of tracks in this file                          |
| `lidarr_trackfile_path`           | Path to the track file                                 |
| `lidarr_trackfile_trackids`       | Comma-separated list of internal track IDs             |
| `lidarr_trackfile_tracknumbers`   | Comma-separated list of track numbers                  |
| `lidarr_trackfile_tracktitles`    | Pipe-separated list of track titles                    |
| `lidarr_trackfile_quality`        | Quality name                                           |
| `lidarr_trackfile_qualityversion` | Quality revision version                               |
| `lidarr_trackfile_releasegroup`   | Release group tag                                      |
| `lidarr_trackfile_scenename`      | Scene name of the source release                       |
| `lidarr_tags_diff`                | JSON diff of tag changes                               |
| `lidarr_tags_scrubbed`            | Whether Lidarr scrubbed existing tags (`True`/`False`) |

### <a href="#artist-added" class="toc-anchor">¶</a> Artist Added

Fired when you add an artist to Lidarr.

| Environment Variable   | Details                           |
|------------------------|-----------------------------------|
| `lidarr_eventtype`     | `ArtistAdd`                       |
| `lidarr_artist_id`     | Internal Lidarr ID for the artist |
| `lidarr_artist_title`  | Artist name                       |
| `lidarr_artist_path`   | Root path for this artist         |
| `lidarr_artist_mbid`   | MusicBrainz artist ID             |
| `lidarr_artist_type`   | Artist type                       |
| `lidarr_artist_genres` | Pipe-separated list of genres     |
| `lidarr_artist_tags`   | Pipe-separated list of tag labels |

### <a href="#artist-deleted" class="toc-anchor">¶</a> Artist Deleted

Fired when you remove an artist from Lidarr.

| Environment Variable         | Details                                                  |
|------------------------------|----------------------------------------------------------|
| `lidarr_eventtype`           | `ArtistDeleted`                                          |
| `lidarr_artist_id`           | Internal Lidarr ID for the artist                        |
| `lidarr_artist_title`        | Artist name                                              |
| `lidarr_artist_path`         | Path Lidarr used for this artist                         |
| `lidarr_artist_mbid`         | MusicBrainz artist ID                                    |
| `lidarr_artist_type`         | Artist type                                              |
| `lidarr_artist_genres`       | Pipe-separated list of genres                            |
| `lidarr_artist_tags`         | Pipe-separated list of tag labels                        |
| `lidarr_artist_deletedfiles` | Whether files on disk were also deleted (`True`/`False`) |

### <a href="#album-deleted" class="toc-anchor">¶</a> Album Deleted

Fired when you remove an album from Lidarr.

| Environment Variable         | Details                                                  |
|------------------------------|----------------------------------------------------------|
| `lidarr_eventtype`           | `AlbumDeleted`                                           |
| `lidarr_artist_id`           | Internal Lidarr ID for the artist                        |
| `lidarr_artist_name`         | Artist name                                              |
| `lidarr_artist_path`         | Root path for this artist                                |
| `lidarr_artist_mbid`         | MusicBrainz artist ID                                    |
| `lidarr_artist_type`         | Artist type                                              |
| `lidarr_artist_genres`       | Pipe-separated list of genres                            |
| `lidarr_artist_tags`         | Pipe-separated list of tag labels                        |
| `lidarr_album_id`            | Internal Lidarr ID for the album                         |
| `lidarr_album_title`         | Album title                                              |
| `lidarr_album_overview`      | Album overview/description                               |
| `lidarr_album_mbid`          | MusicBrainz release group ID                             |
| `lidarr_album_releasedate`   | Album release date                                       |
| `lidarr_artist_deletedfiles` | Whether files on disk were also deleted (`True`/`False`) |

### <a href="#health-issue" class="toc-anchor">¶</a> Health Issue

Fired when Lidarr detects a health check failure.

| Environment Variable          | Details                                               |
|-------------------------------|-------------------------------------------------------|
| `lidarr_eventtype`            | `HealthIssue`                                         |
| `lidarr_health_issue_level`   | Severity level: `Ok`, `Notice`, `Warning`, or `Error` |
| `lidarr_health_issue_message` | Human-readable description of the issue               |
| `lidarr_health_issue_type`    | Name of the health check that fired                   |
| `lidarr_health_issue_wiki`    | Wiki URL of this health issue, if one exists          |

### <a href="#health-restored" class="toc-anchor">¶</a> Health Restored

Fired when a failing health check returns to a healthy state.

| Environment Variable             | Details                                 |
|----------------------------------|-----------------------------------------|
| `lidarr_eventtype`               | `HealthRestored`                        |
| `lidarr_health_restored_level`   | Previous severity level                 |
| `lidarr_health_restored_message` | Description of the check that recovered |
| `lidarr_health_restored_type`    | Name of the health check                |
| `lidarr_health_restored_wiki`    | Wiki URL of this health check           |

### <a href="#application-update" class="toc-anchor">¶</a> Application Update

Fired after Lidarr updates itself to a new version.

| Environment Variable            | Details                         |
|---------------------------------|---------------------------------|
| `lidarr_eventtype`              | `ApplicationUpdate`             |
| `lidarr_update_message`         | Update changelog message        |
| `lidarr_update_newversion`      | Version that was just installed |
| `lidarr_update_previousversion` | Version Lidarr replaced         |

### <a href="#on-test" class="toc-anchor">¶</a> On Test

When you click **Test** in Settings → Connect, Lidarr calls the script with only the common variables set. Your script must exit cleanly (`0`) on this event.

| Environment Variable | Details |
|----------------------|---------|
| `lidarr_eventtype`   | `Test`  |

## <a href="#example-scripts" class="toc-anchor">¶</a> Example scripts

The examples below cover the most common starting points. All shell examples check `lidarr_eventtype` and exit early on the `Test` event. This is the recommended pattern for any script that does real work.

### <a href="#log-all-variables-to-a-file-shell" class="toc-anchor">¶</a> Log all variables to a file (shell)

The simplest useful script: dumps every `lidarr_*` variable to a log file. Run this when you're building a new script and want to see exactly what data is available for a given event.

Save as an executable `.sh` file:

``` prismjs
#!/bin/sh
# Dump all Lidarr environment variables to a log file.
# Useful for inspecting what's available before writing a real script.

LOG="/tmp/lidarr-events.log"

echo "---" >> "$LOG"
echo "$(date -Iseconds)  event=$lidarr_eventtype" >> "$LOG"
env | grep '^lidarr_' | sort >> "$LOG"
```

Make it executable: `chmod +x /path/to/log-events.sh`

### <a href="#log-all-variables-to-a-file-powershell" class="toc-anchor">¶</a> Log all variables to a file (PowerShell)

``` prismjs
$logFile = "C:\Temp\lidarr-events.log"
$timestamp = Get-Date -Format "o"

Add-Content -Path $logFile -Value "---"
Add-Content -Path $logFile -Value "$timestamp  event=$env:lidarr_eventtype"

Get-ChildItem env: |
    Where-Object { $_.Name -like 'lidarr_*' } |
    Sort-Object Name |
    ForEach-Object { Add-Content -Path $logFile -Value "$($_.Name)=$($_.Value)" }
```

### <a href="#discord-webhook-on-import-shell" class="toc-anchor">¶</a> Discord webhook on import (shell)

Sends a message to a Discord channel when an album finishes importing.

``` prismjs
#!/bin/sh
set -euo pipefail

# Exit cleanly on Test events
if [ "$lidarr_eventtype" = "Test" ]; then
    echo "Test event received. Exiting."
    exit 0
fi

# Only act on import events
if [ "$lidarr_eventtype" != "AlbumDownload" ]; then
    exit 0
fi

WEBHOOK_URL="https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"

MESSAGE="**$lidarr_artist_name** - $lidarr_album_title imported ($lidarr_release_quality)"

curl -s -X POST "$WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"$MESSAGE\"}"
```

Replace `YOUR_WEBHOOK_URL` with your Discord webhook URL. In Discord, open channel settings → Integrations → Webhooks to create one.

> The message string above doesn't escape special characters. If your artist or album names can contain double-quotes or backslashes, use `jq` to build the JSON payload instead of constructing it manually.

### <a href="#discord-webhook-on-import-powershell" class="toc-anchor">¶</a> Discord webhook on import (PowerShell)

``` prismjs
if ($env:lidarr_eventtype -eq "Test") { exit 0 }
if ($env:lidarr_eventtype -ne "AlbumDownload") { exit 0 }

$webhookUrl = "https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"
$message    = "**$env:lidarr_artist_name** - $env:lidarr_album_title imported ($env:lidarr_release_quality)"

$body = @{ content = $message } | ConvertTo-Json
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "application/json" -Body $body
```

### <a href="#trigger-a-plex-library-scan-on-import-shell" class="toc-anchor">¶</a> Trigger a Plex library scan on import (shell)

Tells Plex to scan the imported artist's folder after Lidarr finishes importing. Replace the placeholders with your Plex server URL and token.

``` prismjs
#!/bin/sh
set -euo pipefail

if [ "$lidarr_eventtype" = "Test" ]; then exit 0; fi
if [ "$lidarr_eventtype" != "AlbumDownload" ]; then exit 0; fi

PLEX_URL="http://localhost:32400"
PLEX_TOKEN="YOUR_PLEX_TOKEN"
PLEX_SECTION_ID="YOUR_MUSIC_SECTION_ID"

# URL-encode the artist path for the Plex API
ENCODED_PATH=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$lidarr_artist_path")

curl -s -X GET \
    "$PLEX_URL/library/sections/$PLEX_SECTION_ID/refresh?path=$ENCODED_PATH&X-Plex-Token=$PLEX_TOKEN"
```

To find your section ID, open `http://your-plex-server:32400/library/sections?X-Plex-Token=YOUR_TOKEN` in a browser and look for the music library. Find your Plex token in Plex Web → Settings → Troubleshooting → Get an Online Media Token.

> If Plex and Lidarr run in separate Docker containers, `localhost` won't reach the Plex container. Use the Plex container's name or IP on the shared Docker network instead.

### <a href="#notify-on-health-issues-shell" class="toc-anchor">¶</a> Notify on health issues (shell)

Sends an alert when Lidarr raises a health warning or error. Useful for monitoring an unattended server.

``` prismjs
#!/bin/sh
set -euo pipefail

if [ "$lidarr_eventtype" = "Test" ]; then exit 0; fi
if [ "$lidarr_eventtype" != "HealthIssue" ]; then exit 0; fi

# Only alert on Warning or Error, not Notice
if [ "$lidarr_health_issue_level" = "Ok" ] || [ "$lidarr_health_issue_level" = "Notice" ]; then
    exit 0
fi

WEBHOOK_URL="https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"
MESSAGE=":warning: Lidarr health issue [$lidarr_health_issue_level]: $lidarr_health_issue_message"

curl -s -X POST "$WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"$MESSAGE\"}"
```

## <a href="#external-resources" class="toc-anchor">¶</a> External resources

- <a href="https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/Notifications/CustomScript/CustomScript.cs" class="is-external-link">Lidarr/Lidarr: CustomScript.cs</a>: the authoritative source for all environment variables, event types, and their values

## <a href="#see-also" class="toc-anchor">¶</a> See also

- <a href="/lidarr/settings#connections" class="is-internal-link is-valid-page">Settings: Connect</a>: where you register scripts in the Lidarr UI
- <a href="/lidarr/beets-integration" class="is-internal-link is-valid-page">Beets Integration</a>: using a custom script to invoke beets for tag enrichment after import


