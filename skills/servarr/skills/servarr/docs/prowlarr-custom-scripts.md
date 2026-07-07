> Source: https://wiki.servarr.com/prowlarr/custom-scripts



If you're looking to trigger a custom script, you can find more details here. Scripts are added to Prowlarr via the <a href="/prowlarr/settings#connections" class="is-internal-link is-valid-page">Connect Settings</a>.

# <a href="#overview" class="toc-anchor">¶</a> Overview

Prowlarr can execute a custom script when a grab occurs or a health/application event fires. Depending on the action, different parameters are supplied. Parameters are passed to the script through environment variables.

## <a href="#prowlarr-logs" class="toc-anchor">¶</a> Prowlarr Logs

Note that the following will only be logged for custom scripts:

- Script `stdout` output will be logged as `Debug`
- Script `stderr` output will be logged as `Info`
- The trigger of the script will be logged in `Trace`

# <a href="#environment-variables" class="toc-anchor">¶</a> Environment Variables

## <a href="#on-grab" class="toc-anchor">¶</a> On Grab

| Environment Variable            | Details                                             |
|---------------------------------|-----------------------------------------------------|
| `prowlarr_eventtype`            | `Grab`                                              |
| `prowlarr_instancename`         | Name of the Prowlarr instance                       |
| `prowlarr_applicationurl`       | Application URL of Prowlarr                         |
| `prowlarr_release_title`        | Title of the release                                |
| `prowlarr_release_indexer`      | Indexer the release was grabbed from                |
| `prowlarr_release_size`         | Size of the release in bytes                        |
| `prowlarr_release_genres`       | Genres for the release (pipe `\|` separated)        |
| `prowlarr_release_categories`   | Categories for the release (pipe `\|` separated)    |
| `prowlarr_release_indexerflags` | Indexer flags for the release (pipe `\|` separated) |
| `prowlarr_release_publishdate`  | Publish date of the release (ISO 8601 UTC)          |
| `prowlarr_download_client`      | Download client used for the grab                   |
| `prowlarr_download_client_type` | Type of download client used                        |
| `prowlarr_download_id`          | Download ID from the download client                |
| `prowlarr_source`               | Source application that triggered the grab          |
| `prowlarr_host`                 | Host of the source application                      |
| `prowlarr_redirect`             | Whether the grab was a redirect (`True` or `False`) |

## <a href="#on-health-issue" class="toc-anchor">¶</a> On Health Issue

| Environment Variable            | Details                                                      |
|---------------------------------|--------------------------------------------------------------|
| `prowlarr_eventtype`            | `HealthIssue`                                                |
| `prowlarr_instancename`         | Name of the Prowlarr instance                                |
| `prowlarr_applicationurl`       | Application URL of Prowlarr                                  |
| `prowlarr_health_issue_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `prowlarr_health_issue_message` | Message from the health issue                                |
| `prowlarr_health_issue_type`    | Source of the health issue                                   |
| `prowlarr_health_issue_wiki`    | Wiki URL for the health issue (Empty if it does not exist)   |

## <a href="#on-health-restored" class="toc-anchor">¶</a> On Health Restored

| Environment Variable               | Details                                                      |
|------------------------------------|--------------------------------------------------------------|
| `prowlarr_eventtype`               | `HealthRestored`                                             |
| `prowlarr_instancename`            | Name of the Prowlarr instance                                |
| `prowlarr_applicationurl`          | Application URL of Prowlarr                                  |
| `prowlarr_health_restored_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `prowlarr_health_restored_message` | Message from the health issue                                |
| `prowlarr_health_restored_type`    | Source of the health issue                                   |
| `prowlarr_health_restored_wiki`    | Wiki URL for the health issue (Empty if it does not exist)   |

## <a href="#on-application-update" class="toc-anchor">¶</a> On Application Update

| Environment Variable              | Details                                |
|-----------------------------------|----------------------------------------|
| `prowlarr_eventtype`              | `ApplicationUpdate`                    |
| `prowlarr_instancename`           | Name of the Prowlarr instance          |
| `prowlarr_applicationurl`         | Application URL of Prowlarr            |
| `prowlarr_update_message`         | Message from the update                |
| `prowlarr_update_newversion`      | Version Prowlarr updated to (string)   |
| `prowlarr_update_previousversion` | Version Prowlarr updated from (string) |

## <a href="#on-test" class="toc-anchor">¶</a> On Test

When adding the script to Prowlarr and clicking 'Test,' the script will be invoked with the following parameters. The script should be able to gracefully ignore any unsupported event type.

| Environment Variable      | Details                       |
|---------------------------|-------------------------------|
| `prowlarr_eventtype`      | `Test`                        |
| `prowlarr_instancename`   | Name of the Prowlarr instance |
| `prowlarr_applicationurl` | Application URL of Prowlarr   |


