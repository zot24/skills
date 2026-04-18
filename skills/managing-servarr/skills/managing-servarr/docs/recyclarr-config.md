<!-- Source: Scraped from recyclarr.dev via Firecrawl -->

[Skip to main content](https://recyclarr.dev/guide/getting-started/#__docusaurus_skipToContent_fallback)

On this page

This guide walks you through setting up Recyclarr to sync [TRaSH Guide](https://trash-guides.info/Radarr/) quality
profiles to Radarr. By the end, you'll have a working quality profile with custom formats and proper
media naming. No YAML expertise required.

## Prerequisites [​](https://recyclarr.dev/guide/getting-started/\#prerequisites "Direct link to Prerequisites")

- Radarr is running and accessible (Sonarr setup is similar — just use `sonarr` templates)
- You know where to find your API key (Settings → General → Security)

## Step 1: Install Recyclarr [​](https://recyclarr.dev/guide/getting-started/\#install "Direct link to Step 1: Install Recyclarr")

Add the Recyclarr service to your existing `docker-compose.yml` file, or create a new one:

```yml
services:

  recyclarr:

    image: ghcr.io/recyclarr/recyclarr:8

    container_name: recyclarr

    user: 1000:1000

    restart: unless-stopped

    environment:

      - TZ=America/New_York

    volumes:

      - ./config:/config
```

For detailed installation options (networking, tags, native install), see the [Installation\\
Guide](https://recyclarr.dev/guide/installation/).

## Step 2: Choose a Quality Profile [​](https://recyclarr.dev/guide/getting-started/\#choose-profile "Direct link to Step 2: Choose a Quality Profile")

Recyclarr provides ready-to-use templates that match TRaSH Guide quality profiles. List them with:

```bash
docker compose run --rm recyclarr config list templates
```

You'll see available templates:

```txt
┌───────────────────┬───────────────────┐

│ Sonarr            │ Radarr            │

├───────────────────┼───────────────────┤

│ web-1080p         │ hd-bluray-web     │

│ web-2160p         │ uhd-bluray-web    │

│ anime-remux-1080p │ remux-web-1080p   │

│ ...               │ remux-web-2160p   │

│                   │ anime-remux-1080p │

│                   │ ...               │

└───────────────────┴───────────────────┘
```

These correspond to profiles on the [TRaSH Guides Radarr Quality Profiles](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/) page.

## Step 3: Create Your Configuration [​](https://recyclarr.dev/guide/getting-started/\#create-config "Direct link to Step 3: Create Your Configuration")

Generate a config file from your chosen template. For example, to use the [`HD Bluray + WEB`](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/#hd-bluray-web) profile:

```bash
docker compose run --rm recyclarr config create --template hd-bluray-web
```

This creates `config/configs/hd-bluray-web.yml` with everything pre-configured. Open it and update
`base_url` and `api_key`:

```yml
radarr:

  hd-bluray-web:

    base_url: http://radarr:7878  # Your Radarr URL

    api_key: your_api_key_here    # Radarr → Settings → General → API Key
```

Optionally, add this line if you want Recyclarr to delete custom formats it previously synced but
are no longer in your configuration:

```yml
    delete_old_custom_formats: true
```

That's it. The template already includes the quality definition, quality profile, and custom formats
from the TRaSH Guide.

## Step 4: Run Your First Sync [​](https://recyclarr.dev/guide/getting-started/\#first-sync "Direct link to Step 4: Run Your First Sync")

```bash
docker compose run --rm recyclarr sync
```

You should see output like:

```txt
===========================================

Processing Radarr Server: [hd-bluray-web]

===========================================

[INF] Created 34 New Custom Formats

[INF] Total of 34 custom formats were synced

[INF] Created 1 Profiles: ["HD Bluray + WEB"]

[INF] A total of 1 profiles were synced. 1 contain quality changes and 1 contain updated scores

[INF] Total of 14 sizes were synced for quality definition movie

[INF] Completed at 12/16/2025 10:55:42
```

## Step 5: Verify the Sync [​](https://recyclarr.dev/guide/getting-started/\#verify "Direct link to Step 5: Verify the Sync")

Check these locations in the service to confirm the sync worked:

- **Settings → Profiles** — Your new quality profile appears ("HD Bluray + WEB")
- **Settings → Custom Formats** — New custom formats with scores assigned
- **Settings → Quality** — Size ranges updated for each quality level

## Adding More Profiles [​](https://recyclarr.dev/guide/getting-started/\#more-profiles "Direct link to Adding More Profiles")

Want multiple quality profiles (e.g., both 1080p and 4K)? Add more guide-backed profiles to your
existing config file.

Edit your `hd-bluray-web.yml` (or create a new config file) and add additional `trash_id` entries
under `quality_profiles`. Here's an example with four profiles:

```yml
radarr:

  main:

    base_url: http://radarr:7878

    api_key: your_api_key_here

    delete_old_custom_formats: true

    quality_definition:

      type: movie

    quality_profiles:

      # HD Bluray + WEB (1080p)

      - trash_id: d1d67249d3890e49bc12e275d989a7e9  # HD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

      # UHD Bluray + WEB (4K)

      - trash_id: 64fb5f9858489bdac2af690e27c8f42f  # UHD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

      # Remux + WEB 1080p

      - trash_id: 9ca12ea80aa55ef916e3751f4b874151  # Remux + WEB 1080p

        reset_unmatched_scores:

          enabled: true

      # Remux + WEB 2160p

      - trash_id: fd161a61e3ab826d3a22d53f935696dd  # Remux + WEB 2160p

        reset_unmatched_scores:

          enabled: true
```

Each guide-backed profile pulls its quality profile settings and custom format scores directly from
the TRaSH Guides, so a single `trash_id` is all you need per profile.

tip

Each template also includes commented-out `custom_format_groups` for optional CF groups like
streaming services and movie versions. See the [Quick Setup Templates](https://recyclarr.dev/guide/guide-configs/) page for the full
template contents, or run `recyclarr config create --template` to generate a file with all available
groups.

Run `docker compose run --rm recyclarr sync` again, and all profiles will be created.

## Adding Media Naming [​](https://recyclarr.dev/guide/getting-started/\#media-naming "Direct link to Adding Media Naming")

To sync TRaSH Guide naming formats, first see what's available:

```bash
docker compose run --rm recyclarr list naming radarr
```

Then add a `media_naming` section to your config:

```yml
radarr:

  main:

    base_url: http://radarr:7878

    api_key: your_api_key_here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: d1d67249d3890e49bc12e275d989a7e9  # HD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

    # Results visible in: Radarr → Settings → Media Management

    media_naming:

      folder: plex-tmdb

      movie:

        rename: true

        standard: plex-tmdb
```

## When to Customize [​](https://recyclarr.dev/guide/getting-started/\#customize "Direct link to When to Customize")

The templates provide the full TRaSH Guide recommendation. For most users, that's everything you
need.

You only need a `custom_formats:` section if you want to:

- **Override a score** — Change the default score for a specific custom format
- **Add optional custom formats** — Include CFs marked as "optional" in the TRaSH Guides

For customization examples, see the [Configuration Examples](https://recyclarr.dev/reference/config-examples/) page.

## Next Steps [​](https://recyclarr.dev/guide/getting-started/\#next-steps "Direct link to Next Steps")

- [Configuration Reference](https://recyclarr.dev/reference/configuration/) — All available settings
- [Configuration Examples](https://recyclarr.dev/reference/config-examples/) — Real-world configuration patterns
- [Quick Setup Templates](https://recyclarr.dev/guide/guide-configs/) — Browse all available templates
- [Secrets](https://recyclarr.dev/reference/configuration/value-substitution/#secrets) — Store API keys securely
- [Docker Guide](https://recyclarr.dev/guide/installation/docker/) — Cron mode for automatic daily syncs
- [CLI Reference](https://recyclarr.dev/cli/) — All commands and options
- [File Structure](https://recyclarr.dev/guide/file-structure/#config-directory) — Where Recyclarr stores data

- [Prerequisites](https://recyclarr.dev/guide/getting-started/#prerequisites)
- [Step 1: Install Recyclarr](https://recyclarr.dev/guide/getting-started/#install)
- [Step 2: Choose a Quality Profile](https://recyclarr.dev/guide/getting-started/#choose-profile)
- [Step 3: Create Your Configuration](https://recyclarr.dev/guide/getting-started/#create-config)
- [Step 4: Run Your First Sync](https://recyclarr.dev/guide/getting-started/#first-sync)
- [Step 5: Verify the Sync](https://recyclarr.dev/guide/getting-started/#verify)
- [Adding More Profiles](https://recyclarr.dev/guide/getting-started/#more-profiles)
- [Adding Media Naming](https://recyclarr.dev/guide/getting-started/#media-naming)
- [When to Customize](https://recyclarr.dev/guide/getting-started/#customize)
- [Next Steps](https://recyclarr.dev/guide/getting-started/#next-steps)
---

# Guide Configs

[Skip to main content](https://recyclarr.dev/guide/guide-configs/#__docusaurus_skipToContent_fallback)

New to Recyclarr?

See the [Getting Started](https://recyclarr.dev/guide/getting-started/) guide for a walkthrough of using these templates.

Recyclarr offers pre-built configuration files that can be used as a straightforward method of
deploying one or more of the TRaSH Guides profiles:

- [Radarr](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/)
- [Radarr (Anime)](https://trash-guides.info/Radarr/radarr-setup-quality-profiles-anime/)
- [Radarr (French)](https://trash-guides.info/Radarr/radarr-setup-quality-profiles-french-en/)
- [Radarr (German)](https://trash-guides.info/Radarr/radarr-setup-quality-profiles-german-en/)
- [Sonarr](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/)
- [Sonarr (Anime)](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-anime/)
- [Sonarr (French)](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-french-en/)
- [Sonarr (German)](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-german-en/)

These pre-built configuration files use [guide-backed quality profiles](https://recyclarr.dev/reference/configuration/quality-profiles/) and [custom format\\
groups](https://recyclarr.dev/guide/cf-groups/) to synchronize all mandatory elements of any given guide profile. A single `trash_id`
reference per quality profile replaces what previously required multiple include templates. The
content of these templates can be found in the [Recyclarr config-templates GitHub\\
repository](https://github.com/recyclarr/config-templates/tree/v8).

## Deployment [​](https://recyclarr.dev/guide/guide-configs/\#deployment "Direct link to Deployment")

The pre-built configuration files can be deployed in two ways:

- Via the CLI using [`recyclarr config create -t`](https://recyclarr.dev/cli/config/create/#template).
- Manually, by copying the contents of the relevant pre-built configuration file into a [supported\\
file location](https://recyclarr.dev/guide/file-structure/#default-yaml). The files can be found in the index below.

## Customization [​](https://recyclarr.dev/guide/guide-configs/\#customization "Direct link to Customization")

warning

The pre-built configuration files are designed as a simple mechanism to deploy one or more of the
TRaSH Guides profiles, in exactly the same configuration as they appear on the guides pages. Minimal
customization is possible, however more extensive customization usually necessitates building your
own custom configuration file.

Guide-backed quality profiles pull their settings directly from the TRaSH Guides. To customize a
profile, add overrides in your configuration file. [Guidance is available on this\\
behavior](https://recyclarr.dev/reference/configuration/include/).

A common request is to add additional qualities to a [quality profile](https://recyclarr.dev/reference/configuration/quality-profiles/). This is as simple
as writing your own complete quality profile configuration and adding it to your configuration file.
The guide-backed profile's qualities will be replaced by your custom list as described in the
[include behavior section](https://recyclarr.dev/reference/configuration/include/#merge-quality-profiles).

Additional custom formats can be added to the configuration file in the same way as normal.

## Index [​](https://recyclarr.dev/guide/guide-configs/\#index "Direct link to Index")

| Radarr | Sonarr |
| --- | --- |
| [HD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#hd-bluray-web) | [WEB-1080p](https://recyclarr.dev/guide/guide-configs/#web-1080p) |
| [UHD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#uhd-bluray-web) | [WEB-1080p (Alternative)](https://recyclarr.dev/guide/guide-configs/#web-1080p-alternative) |
| [Remux + WEB 1080p](https://recyclarr.dev/guide/guide-configs/#remux-web-1080p) | [WEB-2160p](https://recyclarr.dev/guide/guide-configs/#web-2160p) |
| [Remux + WEB 2160p](https://recyclarr.dev/guide/guide-configs/#remux-web-2160p) | [WEB-2160p (Alternative)](https://recyclarr.dev/guide/guide-configs/#web-2160p-alternative) |
| [Remux 2160p (Alternative)](https://recyclarr.dev/guide/guide-configs/#remux-2160p-alternative) | [WEB-2160p (Combined)](https://recyclarr.dev/guide/guide-configs/#web-2160p-combined) |
| [Remux 2160p (Combined)](https://recyclarr.dev/guide/guide-configs/#remux-2160p-combined) | [Anime Remux 1080p](https://recyclarr.dev/guide/guide-configs/#anime-remux-1080p-sonarr) |
| [Anime Remux 1080p](https://recyclarr.dev/guide/guide-configs/#anime-remux-1080p-radarr) | [French HD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#french-hd-bluray-web-1080p) |
| [French HD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#french-hd-bluray-web) | [French UHD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#french-uhd-bluray-web-2160p) |
| [French HD Remux 1080p](https://recyclarr.dev/guide/guide-configs/#french-hd-remux-1080p) | [German HD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#german-hd-bluray-web-sonarr) |
| [French UHD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#french-uhd-bluray-web) | [German HD Remux + WEB](https://recyclarr.dev/guide/guide-configs/#german-hd-remux-web-sonarr) |
| [French UHD Remux 2160p](https://recyclarr.dev/guide/guide-configs/#french-uhd-remux-2160p) | [German UHD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#german-uhd-bluray-web-sonarr) |
| [German HD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#german-hd-bluray-web) | [German UHD Bluray + WEB (Alt.)](https://recyclarr.dev/guide/guide-configs/#german-uhd-bluray-web-alt-s) |
| [German HD Remux + WEB](https://recyclarr.dev/guide/guide-configs/#german-hd-remux-web) | [German UHD Remux + WEB](https://recyclarr.dev/guide/guide-configs/#german-uhd-remux-web-sonarr) |
| [German UHD Bluray + WEB](https://recyclarr.dev/guide/guide-configs/#german-uhd-bluray-web) |  |
| [German UHD Bluray + WEB (Alt.)](https://recyclarr.dev/guide/guide-configs/#german-uhd-bluray-alt) |  |
| [German Remux + WEB 2160p](https://recyclarr.dev/guide/guide-configs/#german-remux-web-2160p) |  |

* * *

## Radarr [​](https://recyclarr.dev/guide/guide-configs/\#radarr "Direct link to Radarr")

### HD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#hd-bluray-web "Direct link to HD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: HD Bluray + WEB

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles/#hd-bluray-web

################################################################################

radarr:

  hd-bluray-web:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: d1d67249d3890e49bc12e275d989a7e9  # HD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: f8bf8eab4617f12dfdbd16303d8da245  # [Required] Golden Rule HD

          select:

            - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            # - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/hd-bluray-web.yml)

### UHD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#uhd-bluray-web "Direct link to UHD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: UHD Bluray + WEB

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles/#uhd-bluray-

## web

################################################################################

radarr:

  uhd-bluray-web:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: 64fb5f9858489bdac2af690e27c8f42f  # UHD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: ff204bbcecdd487d1cefcefdbf0c278d  # [Required] Golden Rule UHD

          select:

            # - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 7fc2751eef7e6bdc70b74136e5e35c76  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: 1616617ab3a14397a2b2321bcbda44d1  # [HDR Formats] DV Boost

        # - trash_id: b29413a7487478fe98228ce79e5689e4  # [HDR Formats] HDR10+ Boost

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - ef20e67b95a381fb3bc6d1f06ea24f46  # [HDR Formats] HDR

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/uhd-bluray-web.yml)

### Remux + WEB 1080p [​](https://recyclarr.dev/guide/guide-configs/\#remux-web-1080p "Direct link to Remux + WEB 1080p")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: Remux + WEB 1080p

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles/#remux-

## web-1080p

################################################################################

radarr:

  remux-web-1080p:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: 9ca12ea80aa55ef916e3751f4b874151  # Remux + WEB 1080p

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: f8bf8eab4617f12dfdbd16303d8da245  # [Required] Golden Rule HD

          select:

            - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            # - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/remux-web-1080p.yml)

### Remux + WEB 2160p [​](https://recyclarr.dev/guide/guide-configs/\#remux-web-2160p "Direct link to Remux + WEB 2160p")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: Remux + WEB 2160p

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles/#remux-

## web-2160p

################################################################################

radarr:

  remux-web-2160p:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: fd161a61e3ab826d3a22d53f935696dd  # Remux + WEB 2160p

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: ff204bbcecdd487d1cefcefdbf0c278d  # [Required] Golden Rule UHD

          select:

            # - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 7fc2751eef7e6bdc70b74136e5e35c76  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: 1616617ab3a14397a2b2321bcbda44d1  # [HDR Formats] DV Boost

        # - trash_id: b29413a7487478fe98228ce79e5689e4  # [HDR Formats] HDR10+ Boost

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - ef20e67b95a381fb3bc6d1f06ea24f46  # [HDR Formats] HDR

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/remux-web-2160p.yml)

### Remux 2160p (Alternative) [​](https://recyclarr.dev/guide/guide-configs/\#remux-2160p-alternative "Direct link to Remux 2160p (Alternative)")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: Remux 2160p (Alternative)

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles/#remux-

## web-2160p

################################################################################

radarr:

  remux-2160p-alternative:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: dd3cd75deb9645bae838d1c5da6388d5  # Remux 2160p (Alternative)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: ff204bbcecdd487d1cefcefdbf0c278d  # [Required] Golden Rule UHD

          select:

            # - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 7fc2751eef7e6bdc70b74136e5e35c76  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: 1616617ab3a14397a2b2321bcbda44d1  # [HDR Formats] DV Boost

        # - trash_id: b29413a7487478fe98228ce79e5689e4  # [HDR Formats] HDR10+ Boost

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - ef20e67b95a381fb3bc6d1f06ea24f46  # [HDR Formats] HDR

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/remux-2160p-alternative.yml)

### Remux 2160p (Combined) [​](https://recyclarr.dev/guide/guide-configs/\#remux-2160p-combined "Direct link to Remux 2160p (Combined)")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: Remux 2160p (Combined)

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles/#remux-

## web-2160p

################################################################################

radarr:

  remux-2160p-combined:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: d1d310673359205736b4b84acd5ea8c8  # Remux 2160p (Combined)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: ff204bbcecdd487d1cefcefdbf0c278d  # [Required] Golden Rule UHD

          select:

            # - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 7fc2751eef7e6bdc70b74136e5e35c76  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: 1616617ab3a14397a2b2321bcbda44d1  # [HDR Formats] DV Boost

        # - trash_id: b29413a7487478fe98228ce79e5689e4  # [HDR Formats] HDR10+ Boost

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - ef20e67b95a381fb3bc6d1f06ea24f46  # [HDR Formats] HDR

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/remux-2160p-combined.yml)

### Anime Remux 1080p (Radarr) [​](https://recyclarr.dev/guide/guide-configs/\#anime-remux-1080p-radarr "Direct link to Anime Remux 1080p (Radarr)")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [Anime] Remux-1080p

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-

## anime/#quality-profile

################################################################################

radarr:

  radarr-anime-remux-1080p:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: anime

    quality_profiles:

      - trash_id: 722b624f9af1e492284c4bc842153a38  # [Anime] Remux-1080p

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/anime-remux-1080p.yml)

### French HD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#french-hd-bluray-web "Direct link to French HD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [French MULTi.VO] HD Bluray + WEB

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-french-en/#hd-

## bluray-web-1080p

################################################################################

radarr:

  french-hd-bluray-web:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: 2572ce3ea4eef1c19d59e0e20ed1cea7  # [French MULTi.VO] HD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: f8bf8eab4617f12dfdbd16303d8da245  # [Required] Golden Rule HD

          select:

            - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            # - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 12a919c8a5e2342db6e9c0b4e3c0756e  # [Release Groups] French

        #   select:

        #     - 5583260016e0b9f683f53af41fb42e4a  # FR Remux Tier 01

        #     - 9019d81307e68cd4a7eb06a567e833b8  # FR Remux Tier 02

        #     - 64f8f12bbf7472a6ccf838bfd6b5e3e8  # FR UHD Bluray Tier 01

        #     - 0dcf0c8a386d82e3f2d424189af14065  # FR UHD Bluray Tier 02

        #     - 5322da05b19d857acc1e75be3edf47b3  # FR HD Bluray Tier 01

        #     - 57f34251344be2e283fc30e00e458be6  # FR HD Bluray Tier 02

        #     - 9790a618cec1aeac8ce75601a17ea40d  # FR WEB Tier 01

        #     - 3c83a765f84239716bd5fd2d7af188f9  # FR WEB Tier 02

        #     - 0d94489c0d5828cd3bf9409d309fb32b  # FR Scene Groups

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/french-hd-bluray-web.yml)

### French HD Remux 1080p [​](https://recyclarr.dev/guide/guide-configs/\#french-hd-remux-1080p "Direct link to French HD Remux 1080p")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [French MULTi.VO] HD Remux (1080p)

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-french-en/#hd-

## remux-1080p

################################################################################

radarr:

  french-hd-remux-1080p:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: c6460a102b312200c095a2d0982e0461  # [French MULTi.VO] HD Remux (1080p)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: f8bf8eab4617f12dfdbd16303d8da245  # [Required] Golden Rule HD

          select:

            - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            # - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: 12a919c8a5e2342db6e9c0b4e3c0756e  # [Release Groups] French

        #   select:

        #     - 5583260016e0b9f683f53af41fb42e4a  # FR Remux Tier 01

        #     - 9019d81307e68cd4a7eb06a567e833b8  # FR Remux Tier 02

        #     - 64f8f12bbf7472a6ccf838bfd6b5e3e8  # FR UHD Bluray Tier 01

        #     - 0dcf0c8a386d82e3f2d424189af14065  # FR UHD Bluray Tier 02

        #     - 5322da05b19d857acc1e75be3edf47b3  # FR HD Bluray Tier 01

        #     - 57f34251344be2e283fc30e00e458be6  # FR HD Bluray Tier 02

        #     - 9790a618cec1aeac8ce75601a17ea40d  # FR WEB Tier 01

        #     - 3c83a765f84239716bd5fd2d7af188f9  # FR WEB Tier 02

        #     - 0d94489c0d5828cd3bf9409d309fb32b  # FR Scene Groups

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/french-hd-remux-1080p.yml)

### French UHD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#french-uhd-bluray-web "Direct link to French UHD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [French MULTi.VO] UHD Bluray + WEB

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-french-

## en/#uhd-bluray-web-2160p

################################################################################

radarr:

  french-uhd-bluray-web:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: 92ead7022d13a7858d54e328e6a2f8f9  # [French MULTi.VO] UHD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: ff204bbcecdd487d1cefcefdbf0c278d  # [Required] Golden Rule UHD

          select:

            # - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 7fc2751eef7e6bdc70b74136e5e35c76  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: 1616617ab3a14397a2b2321bcbda44d1  # [HDR Formats] DV Boost

        # - trash_id: b29413a7487478fe98228ce79e5689e4  # [HDR Formats] HDR10+ Boost

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: 12a919c8a5e2342db6e9c0b4e3c0756e  # [Release Groups] French

        #   select:

        #     - 5583260016e0b9f683f53af41fb42e4a  # FR Remux Tier 01

        #     - 9019d81307e68cd4a7eb06a567e833b8  # FR Remux Tier 02

        #     - 64f8f12bbf7472a6ccf838bfd6b5e3e8  # FR UHD Bluray Tier 01

        #     - 0dcf0c8a386d82e3f2d424189af14065  # FR UHD Bluray Tier 02

        #     - 5322da05b19d857acc1e75be3edf47b3  # FR HD Bluray Tier 01

        #     - 57f34251344be2e283fc30e00e458be6  # FR HD Bluray Tier 02

        #     - 9790a618cec1aeac8ce75601a17ea40d  # FR WEB Tier 01

        #     - 3c83a765f84239716bd5fd2d7af188f9  # FR WEB Tier 02

        #     - 0d94489c0d5828cd3bf9409d309fb32b  # FR Scene Groups

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - ef20e67b95a381fb3bc6d1f06ea24f46  # [HDR Formats] HDR

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/french-uhd-bluray-web.yml)

### French UHD Remux 2160p [​](https://recyclarr.dev/guide/guide-configs/\#french-uhd-remux-2160p "Direct link to French UHD Remux 2160p")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [French MULTi.VO] UHD Remux (2160p)

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-french-

## en/#uhd-remux-2160p

################################################################################

radarr:

  french-uhd-remux-2160p:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: 1fef28c8c919f31cd86283b1baf527d4  # [French MULTi.VO] UHD Remux (2160p)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: ff204bbcecdd487d1cefcefdbf0c278d  # [Required] Golden Rule UHD

          select:

            # - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 7fc2751eef7e6bdc70b74136e5e35c76  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: 1616617ab3a14397a2b2321bcbda44d1  # [HDR Formats] DV Boost

        # - trash_id: b29413a7487478fe98228ce79e5689e4  # [HDR Formats] HDR10+ Boost

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: 12a919c8a5e2342db6e9c0b4e3c0756e  # [Release Groups] French

        #   select:

        #     - 5583260016e0b9f683f53af41fb42e4a  # FR Remux Tier 01

        #     - 9019d81307e68cd4a7eb06a567e833b8  # FR Remux Tier 02

        #     - 64f8f12bbf7472a6ccf838bfd6b5e3e8  # FR UHD Bluray Tier 01

        #     - 0dcf0c8a386d82e3f2d424189af14065  # FR UHD Bluray Tier 02

        #     - 5322da05b19d857acc1e75be3edf47b3  # FR HD Bluray Tier 01

        #     - 57f34251344be2e283fc30e00e458be6  # FR HD Bluray Tier 02

        #     - 9790a618cec1aeac8ce75601a17ea40d  # FR WEB Tier 01

        #     - 3c83a765f84239716bd5fd2d7af188f9  # FR WEB Tier 02

        #     - 0d94489c0d5828cd3bf9409d309fb32b  # FR Scene Groups

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - ef20e67b95a381fb3bc6d1f06ea24f46  # [HDR Formats] HDR

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/french-uhd-remux-2160p.yml)

### German HD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#german-hd-bluray-web "Direct link to German HD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] HD Bluray + WEB

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-german-en/#hd-

## bluray-web

################################################################################

radarr:

  radarr-german-hd-bluray-web:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: 2b90e905c99490edc7c7a5787443748b  # [German] HD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: f8bf8eab4617f12dfdbd16303d8da245  # [Required] Golden Rule HD

          select:

            - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            # - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: bc85e56ee3bd0f01467866d5f1261543  # [Release Groups] German

        #   select:

        #     - 8608a2ed20c636b8a62de108e9147713  # German Remux Tier 01

        #     - f9cf598d55ce532d63596b060a6db9ee  # German Remux Tier 02

        #     - 54795711b78ea87e56127928c423689b  # German Bluray Tier 01

        #     - 1bfc773c53283d47c68e535811da30b7  # German Bluray Tier 02

        #     - aee01d40cd1bf4bcded81ee62f0f3659  # German Bluray Tier 03

        #     - a2ab25194f463f057a5559c03c84a3df  # German Web Tier 01

        #     - 08d120d5a003ec4954b5b255c0691d79  # German Web Tier 02

        #     - 439f9d71becaed589058ec949e037ff3  # German Web Tier 03

        #     - 2d136d4e33082fe573d06b1f237c40dd  # German Scene

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/german-hd-bluray-web.yml)

### German HD Remux + WEB [​](https://recyclarr.dev/guide/guide-configs/\#german-hd-remux-web "Direct link to German HD Remux + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] HD Remux + WEB

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-german-en/#hd-

## remux-web

################################################################################

radarr:

  radarr-german-hd-remux-web:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: c13c33fdd2c306266b34cb9946de5919  # [German] HD Remux + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: f8bf8eab4617f12dfdbd16303d8da245  # [Required] Golden Rule HD

          select:

            - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            # - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: bc85e56ee3bd0f01467866d5f1261543  # [Release Groups] German

        #   select:

        #     - 8608a2ed20c636b8a62de108e9147713  # German Remux Tier 01

        #     - f9cf598d55ce532d63596b060a6db9ee  # German Remux Tier 02

        #     - 54795711b78ea87e56127928c423689b  # German Bluray Tier 01

        #     - 1bfc773c53283d47c68e535811da30b7  # German Bluray Tier 02

        #     - aee01d40cd1bf4bcded81ee62f0f3659  # German Bluray Tier 03

        #     - a2ab25194f463f057a5559c03c84a3df  # German Web Tier 01

        #     - 08d120d5a003ec4954b5b255c0691d79  # German Web Tier 02

        #     - 439f9d71becaed589058ec949e037ff3  # German Web Tier 03

        #     - 2d136d4e33082fe573d06b1f237c40dd  # German Scene

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/german-hd-remux-web.yml)

### German UHD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#german-uhd-bluray-web "Direct link to German UHD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] UHD Bluray + WEB

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-german-

## en/#uhd-bluray-web

################################################################################

radarr:

  radarr-german-uhd-bluray-web:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: 27cc3d153c0a799fd139ef1ff4c4cc42  # [German] UHD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: ff204bbcecdd487d1cefcefdbf0c278d  # [Required] Golden Rule UHD

          select:

            # - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 7fc2751eef7e6bdc70b74136e5e35c76  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: 1616617ab3a14397a2b2321bcbda44d1  # [HDR Formats] DV Boost

        # - trash_id: b29413a7487478fe98228ce79e5689e4  # [HDR Formats] HDR10+ Boost

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: bc85e56ee3bd0f01467866d5f1261543  # [Release Groups] German

        #   select:

        #     - 8608a2ed20c636b8a62de108e9147713  # German Remux Tier 01

        #     - f9cf598d55ce532d63596b060a6db9ee  # German Remux Tier 02

        #     - 54795711b78ea87e56127928c423689b  # German Bluray Tier 01

        #     - 1bfc773c53283d47c68e535811da30b7  # German Bluray Tier 02

        #     - aee01d40cd1bf4bcded81ee62f0f3659  # German Bluray Tier 03

        #     - a2ab25194f463f057a5559c03c84a3df  # German Web Tier 01

        #     - 08d120d5a003ec4954b5b255c0691d79  # German Web Tier 02

        #     - 439f9d71becaed589058ec949e037ff3  # German Web Tier 03

        #     - 2d136d4e33082fe573d06b1f237c40dd  # German Scene

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - ef20e67b95a381fb3bc6d1f06ea24f46  # [HDR Formats] HDR

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/german-uhd-bluray-web.yml)

### German UHD Bluray + WEB (Alternative) [​](https://recyclarr.dev/guide/guide-configs/\#german-uhd-bluray-alt "Direct link to German UHD Bluray + WEB (Alternative)")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] UHD Bluray + WEB (Alternative)

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-german-

## en/#uhd-bluray-web

################################################################################

radarr:

  radarr-german-uhd-bluray-web-alternative:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: 425da1ba30711b55d2eb371437ec98d7  # [German] UHD Bluray + WEB (Alternative)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: ff204bbcecdd487d1cefcefdbf0c278d  # [Required] Golden Rule UHD

          select:

            # - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 7fc2751eef7e6bdc70b74136e5e35c76  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: 1616617ab3a14397a2b2321bcbda44d1  # [HDR Formats] DV Boost

        # - trash_id: b29413a7487478fe98228ce79e5689e4  # [HDR Formats] HDR10+ Boost

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: bc85e56ee3bd0f01467866d5f1261543  # [Release Groups] German

        #   select:

        #     - 8608a2ed20c636b8a62de108e9147713  # German Remux Tier 01

        #     - f9cf598d55ce532d63596b060a6db9ee  # German Remux Tier 02

        #     - 54795711b78ea87e56127928c423689b  # German Bluray Tier 01

        #     - 1bfc773c53283d47c68e535811da30b7  # German Bluray Tier 02

        #     - aee01d40cd1bf4bcded81ee62f0f3659  # German Bluray Tier 03

        #     - a2ab25194f463f057a5559c03c84a3df  # German Web Tier 01

        #     - 08d120d5a003ec4954b5b255c0691d79  # German Web Tier 02

        #     - 439f9d71becaed589058ec949e037ff3  # German Web Tier 03

        #     - 2d136d4e33082fe573d06b1f237c40dd  # German Scene

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - ef20e67b95a381fb3bc6d1f06ea24f46  # [HDR Formats] HDR

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/german-uhd-bluray-web-alternative.yml)

### German Remux + WEB 2160p [​](https://recyclarr.dev/guide/guide-configs/\#german-remux-web-2160p "Direct link to German Remux + WEB 2160p")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] Remux + WEB 2160p

##

## https://trash-guides.info/Radarr/radarr-setup-quality-profiles-german-

## en/#uhd-remux-web

################################################################################

radarr:

  german-remux-web-2160p:

    base_url: Put your Radarr URL here

    api_key: Put your API key here

    quality_definition:

      type: movie

    quality_profiles:

      - trash_id: 79faa9943cef2f510b997b1f2a9f3ea6  # [German] Remux + WEB 2160p

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: ff204bbcecdd487d1cefcefdbf0c278d  # [Required] Golden Rule UHD

          select:

            # - dc98083864ea246d05a42df0d05f81cc  # x265 (HD)

            - 839bea857ed2c0a8e084f3cbdbd65ecb  # x265 (no HDR/DV)

        # - trash_id: 7fc2751eef7e6bdc70b74136e5e35c76  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: 1616617ab3a14397a2b2321bcbda44d1  # [HDR Formats] DV Boost

        # - trash_id: b29413a7487478fe98228ce79e5689e4  # [HDR Formats] HDR10+ Boost

        # - trash_id: 60f6d50cbd3cfc3e9a8c00e3a30c3114  # [Streaming Services] Anime

        # - trash_id: b22449f789b16a4163b59f1b70cbc580  # [Streaming Services] Asian

        # - trash_id: 088a792e0561c927fb396664b0db5c8f  # [Streaming Services] Dutch

        # - trash_id: f737e18b5824d6ebb2d57b957ae2fd6c  # [Streaming Services] UK

        # - trash_id: 9337080378236ce4c0b183e35790d2a7  # [Optional] Miscellaneous

        #   select:

        #     - b6832f586342ef70d9c128d40c07b872  # Bad Dual Groups

        #     - cc444569854e9de0b084ab2b8b1532b2  # Black and White Editions

        #     - f700d29429c023a5734505e77daeaea7  # DV (Disk)

        #     - 73613461ac2cea99d52c4cd6e177ab82  # HFR

        #     - 4b900e171accbfb172729b63323ea8ca  # Multi

        #     - ae9b7c9ebde1f3bd336a8cbd1ec4c5e5  # No-RlsGroup

        #     - 7357cf5161efbf8c4d5d0c30b4815ee2  # Obfuscated

        #     - 5c44f52a8714fdd79bb4d98e2673be1f  # Retags

        #     - f537cf427b64c38c8e36298f657e4828  # Scene

        #     - 11cd1db7165d6a7ad9a83bc97b8b1060  # VC-1

        #     - ae4cfaa9283a4f2150ac3da08e388723  # VP9

        #     - 2899d84dc9372de3408e6d8cc18e9666  # x264

        #     - 9170d55c319f4fe40da8711ba9d8050d  # x265

        #     - 390455c22a9cac81a738f6cbad705c3c  # x266

        # - trash_id: f4f1474b963b24cf983455743aa9906c  # [Optional] Movie Versions

        #   select:

        #     - 570bc9ebecd92723d2d21500f4be314c  # Remaster

        #     - eca37840c13c6ef2dd0262b141a5482f  # 4K Remaster

        #     - e0c07d59beb37348e975a930d5e50319  # Criterion Collection

        #     - 9d27d9d2181838f76dee150882bdc58c  # Masters of Cinema

        #     - 09d9dd29a0fc958f9796e65c2a8864b4  # Open Matte

        #     - db9b4c4b53d312a3ca5f1378f6440fc9  # Vinegar Syndrome

        #     - 957d0f44b592285f26449575e8b1167e  # Special Edition

        #     - e9001909a4c88013a359d0b9920d7bea  # Theatrical Cut

        #     - 0f12c086e289cf966fa5948eac571f44  # Hybrid

        #     - eecf3a857724171f968a66cb5719e152  # IMAX

        #     - 9f6cbff8cfe4ebbc1bde14c7b7bec0de  # IMAX Enhanced

        # - trash_id: 47f0d69750de9e16855915fa73bb7b08  # [Optional] SDR

        #   select:

        #     - 9c38ebb7384dada637be8899efa68e6f  # SDR

        #     - 25c12f78430a3a23413652cbd1d48d77  # SDR (no WEBDL)

        # - trash_id: bc85e56ee3bd0f01467866d5f1261543  # [Release Groups] German

        #   select:

        #     - 8608a2ed20c636b8a62de108e9147713  # German Remux Tier 01

        #     - f9cf598d55ce532d63596b060a6db9ee  # German Remux Tier 02

        #     - 54795711b78ea87e56127928c423689b  # German Bluray Tier 01

        #     - 1bfc773c53283d47c68e535811da30b7  # German Bluray Tier 02

        #     - aee01d40cd1bf4bcded81ee62f0f3659  # German Bluray Tier 03

        #     - a2ab25194f463f057a5559c03c84a3df  # German Web Tier 01

        #     - 08d120d5a003ec4954b5b255c0691d79  # German Web Tier 02

        #     - 439f9d71becaed589058ec949e037ff3  # German Web Tier 03

        #     - 2d136d4e33082fe573d06b1f237c40dd  # German Scene

        # - trash_id: 9fc645b3cef52b149ec13ba3972245d1  # [Streaming Services] Miscellaneous

        #   select:

        #     - 3bf143ecd06f66ed88da4c704350af1d  # AUBC

        #     - d9058beaae2e147183870304dd526761  # CBC

        #     - f6ff65b3f4b464a79dcc75950fe20382  # CRAV

        #     - fbca986396c5e695ef7b2def3c755d01  # OViD

        #     - ab56ccdc473a1f2897c76187ea365be2  # STRP

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 9d5acd8f1da78dfbae788182f7605200  # [Audio] Audio Formats

        # - ef20e67b95a381fb3bc6d1f06ea24f46  # [HDR Formats] HDR

        # - d9cc9a504e5ede6294c8b973aad4f028  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/radarr/templates/german-remux-web-2160p.yml)

* * *

## Sonarr [​](https://recyclarr.dev/guide/guide-configs/\#sonarr "Direct link to Sonarr")

### WEB-1080p [​](https://recyclarr.dev/guide/guide-configs/\#web-1080p "Direct link to WEB-1080p")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: WEB-1080p

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/#web-1080p

################################################################################

sonarr:

  web-1080p:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: 72dae194fc92bf828f32cde7744e51a1  # WEB-1080p

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: 158188097a58d7687dee647e04af0da3  # [Required] Golden Rule HD

          select:

            - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            # - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/web-1080p.yml)

### WEB-1080p (Alternative) [​](https://recyclarr.dev/guide/guide-configs/\#web-1080p-alternative "Direct link to WEB-1080p (Alternative)")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: WEB-1080p (Alternative)

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/#web-1080p

################################################################################

sonarr:

  web-1080p-alternative:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: 9d142234e45d6143785ac55f5a9e8dc9  # WEB-1080p (Alternative)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: 158188097a58d7687dee647e04af0da3  # [Required] Golden Rule HD

          select:

            - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            # - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: e9a1944a254e6f8a9da63083f7ae15cb  # [Audio] Audio Formats

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/web-1080p-alternative.yml)

### WEB-2160p [​](https://recyclarr.dev/guide/guide-configs/\#web-2160p "Direct link to WEB-2160p")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: WEB-2160p

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/#web-2160p

################################################################################

sonarr:

  web-2160p:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: d1498e7d189fbe6c7110ceaabb7473e6  # WEB-2160p

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: e3f37512790f00d0e89e54fe5e790d1c  # [Required] Golden Rule UHD

          select:

            # - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d776a1ea912a117d66d83b880ff2055d  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: e0b2774083df4265f25c9e5bc6c80940  # [HDR Formats] DV Boost

        # - trash_id: 7d366c213e5c23a052b157356fac1921  # [HDR Formats] HDR10+ Boost

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: e1053c0ef622df3749fa43c22865663a  # [Optional] SDR

        #   select:

        #     - 2016d1676f5ee13a5b7257ff86ac9a93  # SDR

        #     - 83304f261cf516bb208c18c54c0adf97  # SDR (no WEBDL)

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 7e1724c5da59e7474803ad25be98f6a3  # [HDR Formats] HDR

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/web-2160p.yml)

### WEB-2160p (Alternative) [​](https://recyclarr.dev/guide/guide-configs/\#web-2160p-alternative "Direct link to WEB-2160p (Alternative)")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: WEB-2160p (Alternative)

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/#web-2160p

################################################################################

sonarr:

  web-2160p-alternative:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: dfa5eaae7894077ad6449169b6eb03e0  # WEB-2160p (Alternative)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: e3f37512790f00d0e89e54fe5e790d1c  # [Required] Golden Rule UHD

          select:

            # - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: e9a1944a254e6f8a9da63083f7ae15cb  # [Audio] Audio Formats

        # - trash_id: d776a1ea912a117d66d83b880ff2055d  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: e0b2774083df4265f25c9e5bc6c80940  # [HDR Formats] DV Boost

        # - trash_id: 7d366c213e5c23a052b157356fac1921  # [HDR Formats] HDR10+ Boost

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: e1053c0ef622df3749fa43c22865663a  # [Optional] SDR

        #   select:

        #     - 2016d1676f5ee13a5b7257ff86ac9a93  # SDR

        #     - 83304f261cf516bb208c18c54c0adf97  # SDR (no WEBDL)

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 7e1724c5da59e7474803ad25be98f6a3  # [HDR Formats] HDR

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/web-2160p-alternative.yml)

### WEB-2160p (Combined) [​](https://recyclarr.dev/guide/guide-configs/\#web-2160p-combined "Direct link to WEB-2160p (Combined)")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: WEB-2160p (Combined)

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/#web-2160p

################################################################################

sonarr:

  web-2160p-combined:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: c4cadd6b35b95f62c3d47a408e53e2f7  # WEB-2160p (Combined)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: e3f37512790f00d0e89e54fe5e790d1c  # [Required] Golden Rule UHD

          select:

            # - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d776a1ea912a117d66d83b880ff2055d  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: e0b2774083df4265f25c9e5bc6c80940  # [HDR Formats] DV Boost

        # - trash_id: 7d366c213e5c23a052b157356fac1921  # [HDR Formats] HDR10+ Boost

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: e1053c0ef622df3749fa43c22865663a  # [Optional] SDR

        #   select:

        #     - 2016d1676f5ee13a5b7257ff86ac9a93  # SDR

        #     - 83304f261cf516bb208c18c54c0adf97  # SDR (no WEBDL)

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 7e1724c5da59e7474803ad25be98f6a3  # [HDR Formats] HDR

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/web-2160p-combined.yml)

### Anime Remux 1080p (Sonarr) [​](https://recyclarr.dev/guide/guide-configs/\#anime-remux-1080p-sonarr "Direct link to Anime Remux 1080p (Sonarr)")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [Anime] Remux-1080p

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-

## anime/#quality-profile

################################################################################

sonarr:

  sonarr-anime-remux-1080p:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: anime

    quality_profiles:

      - trash_id: 20e0fc959f1f1704bed501f23bdae76f  # [Anime] Remux-1080p

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/anime-remux-1080p.yml)

### French HD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#french-hd-bluray-web-1080p "Direct link to French HD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [French MULTi.VO] HD Bluray + WEB (1080p)

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-french-en/#hd-

## bluray-web-1080p

################################################################################

sonarr:

  french-hd-bluray-web-1080p:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: 4c48f506c1116a3a57ae33f12346bd15  # [French MULTi.VO] HD Bluray + WEB (1080p)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: 158188097a58d7687dee647e04af0da3  # [Required] Golden Rule HD

          select:

            - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            # - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/french-hd-bluray-web-1080p.yml)

### French UHD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#french-uhd-bluray-web-2160p "Direct link to French UHD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [French MULTi.VO] UHD Bluray + WEB (2160p)

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-french-

## en/#uhd-bluray-web-2160p

################################################################################

sonarr:

  french-uhd-bluray-web-2160p:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: 6fa7364373e8f06206871d9c20a4fb3e  # [French MULTi.VO] UHD Bluray + WEB (2160p)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: e3f37512790f00d0e89e54fe5e790d1c  # [Required] Golden Rule UHD

          select:

            # - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d776a1ea912a117d66d83b880ff2055d  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: e0b2774083df4265f25c9e5bc6c80940  # [HDR Formats] DV Boost

        # - trash_id: 7d366c213e5c23a052b157356fac1921  # [HDR Formats] HDR10+ Boost

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: e1053c0ef622df3749fa43c22865663a  # [Optional] SDR

        #   select:

        #     - 2016d1676f5ee13a5b7257ff86ac9a93  # SDR

        #     - 83304f261cf516bb208c18c54c0adf97  # SDR (no WEBDL)

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 7e1724c5da59e7474803ad25be98f6a3  # [HDR Formats] HDR

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/french-uhd-bluray-web-2160p.yml)

### German HD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#german-hd-bluray-web-sonarr "Direct link to German HD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] HD Bluray + WEB

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-german-en/#hd-

## bluray-web

################################################################################

sonarr:

  sonarr-german-hd-bluray-web:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: dca7e5e9e99c703bcbdaaa471dd40e98  # [German] HD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: 158188097a58d7687dee647e04af0da3  # [Required] Golden Rule HD

          select:

            - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            # - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/german-hd-bluray-web.yml)

### German HD Remux + WEB [​](https://recyclarr.dev/guide/guide-configs/\#german-hd-remux-web-sonarr "Direct link to German HD Remux + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] HD Remux + WEB

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-german-en/#hd-

## remux-web

################################################################################

sonarr:

  sonarr-german-hd-remux-web:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: 0dd5f085ed61a1e01f6d347779dfa1bc  # [German] HD Remux + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: 158188097a58d7687dee647e04af0da3  # [Required] Golden Rule HD

          select:

            - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            # - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/german-hd-remux-web.yml)

### German UHD Bluray + WEB [​](https://recyclarr.dev/guide/guide-configs/\#german-uhd-bluray-web-sonarr "Direct link to German UHD Bluray + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] UHD Bluray + WEB

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-german-

## en/#uhd-bluray-web-2160p

################################################################################

sonarr:

  sonarr-german-uhd-bluray-web:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: 3b0fa37fddaaefc931b75f2889d4b4f5  # [German] UHD Bluray + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: 158188097a58d7687dee647e04af0da3  # [Required] Golden Rule HD

          select:

            - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            # - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        - trash_id: e3f37512790f00d0e89e54fe5e790d1c  # [Required] Golden Rule UHD

          select:

            # - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d776a1ea912a117d66d83b880ff2055d  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: e0b2774083df4265f25c9e5bc6c80940  # [HDR Formats] DV Boost

        # - trash_id: 7d366c213e5c23a052b157356fac1921  # [HDR Formats] HDR10+ Boost

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: e1053c0ef622df3749fa43c22865663a  # [Optional] SDR

        #   select:

        #     - 2016d1676f5ee13a5b7257ff86ac9a93  # SDR

        #     - 83304f261cf516bb208c18c54c0adf97  # SDR (no WEBDL)

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 7e1724c5da59e7474803ad25be98f6a3  # [HDR Formats] HDR

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/german-uhd-bluray-web.yml)

### German UHD Bluray + WEB (Alternative) [​](https://recyclarr.dev/guide/guide-configs/\#german-uhd-bluray-web-alt-s "Direct link to German UHD Bluray + WEB (Alternative)")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] UHD Bluray + WEB (Alternative)

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-german-

## en/#uhd-bluray-web-2160p

################################################################################

sonarr:

  sonarr-german-uhd-bluray-web-alternative:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: 7324309a7d1e10dc0dc2cea6c70ed852  # [German] UHD Bluray + WEB (Alternative)

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: 158188097a58d7687dee647e04af0da3  # [Required] Golden Rule HD

          select:

            - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            # - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        - trash_id: e3f37512790f00d0e89e54fe5e790d1c  # [Required] Golden Rule UHD

          select:

            # - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d776a1ea912a117d66d83b880ff2055d  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: e0b2774083df4265f25c9e5bc6c80940  # [HDR Formats] DV Boost

        # - trash_id: 7d366c213e5c23a052b157356fac1921  # [HDR Formats] HDR10+ Boost

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: e1053c0ef622df3749fa43c22865663a  # [Optional] SDR

        #   select:

        #     - 2016d1676f5ee13a5b7257ff86ac9a93  # SDR

        #     - 83304f261cf516bb208c18c54c0adf97  # SDR (no WEBDL)

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 7e1724c5da59e7474803ad25be98f6a3  # [HDR Formats] HDR

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/german-uhd-bluray-web-alternative.yml)

### German UHD Remux + WEB [​](https://recyclarr.dev/guide/guide-configs/\#german-uhd-remux-web-sonarr "Direct link to German UHD Remux + WEB")

Click to show/hide

Copy this configuration into your own configuration file:

```yml
# yaml-language-server: $schema=https://schemas.recyclarr.dev/v8/config-schema.json

################################################################################

## TRaSH Guides: [German] UHD Remux + WEB

##

## https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles-german-

## en/#uhd-remux-web-2160p

################################################################################

sonarr:

  german-uhd-remux-web:

    base_url: Put your Sonarr URL here

    api_key: Put your API key here

    quality_definition:

      type: series

    quality_profiles:

      - trash_id: 08cececf1840290f6fd490b7d79e8642  # [German] UHD Remux + WEB

        reset_unmatched_scores:

          enabled: true

    custom_format_groups:

      ################################################################################

      ## These groups are NOT synced by default. Uncomment to enable. Use `select:` to

      ## choose specific CFs within a group.

      ##

      ## To uncomment, remove `# ` (hash + space) so that indentation stays aligned.

      ## Most editors do this automatically with toggle-comment (Ctrl+/).

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      add:

        - trash_id: 158188097a58d7687dee647e04af0da3  # [Required] Golden Rule HD

          select:

            - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            # - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        - trash_id: e3f37512790f00d0e89e54fe5e790d1c  # [Required] Golden Rule UHD

          select:

            # - 47435ece6b99a0b477caf360e79ba0bb  # x265 (HD)

            - 9b64dff695c2115facf1b6ea59c9bd07  # x265 (no HDR/DV)

        # - trash_id: d776a1ea912a117d66d83b880ff2055d  # [HDR Formats] DV (w/o HDR fallback)

        # - trash_id: e0b2774083df4265f25c9e5bc6c80940  # [HDR Formats] DV Boost

        # - trash_id: 7d366c213e5c23a052b157356fac1921  # [HDR Formats] HDR10+ Boost

        # - trash_id: d920fd959d220306888f40b6f38e1578  # [Optional] Season Packs

        # - trash_id: 35fb4585dcd9e2a5ac732e4309f5a45a  # [Streaming Services] Asian

        # - trash_id: f60f4401ce880aad62e9d21c8bb6b91a  # [Streaming Services] Dutch

        # - trash_id: 848fd356c200568fc5a6248150e7e7ea  # [Streaming Services] French

        # - trash_id: ddab3095a5d2f436f369263840af34f9  # [Streaming Services] UK

        # - trash_id: f4a0410a1df109a66d6e47dcadcce014  # [Optional] Miscellaneous

        #   select:

        #     - 32b367365729d530ca1c124a0b180c64  # Bad Dual Groups

        #     - ef4963043b0987f8485bc9106f16db38  # DV (Disk)

        #     - 1bd69272e23c5e6c5b1d6c8a36fce95e  # HFR

        #     - 7ba05c6e0e14e793538174c679126996  # MULTi

        #     - 82d40da2bc6923f41e14394075dd4b03  # No-RlsGroup

        #     - e1a997ddb54e3ecbfe06341ad323c458  # Obfuscated

        #     - 06d66ab109d4d2eddb2794d21526d140  # Retags

        #     - 1b3994c551cbb92a2c781af061f4ab44  # Scene

        #     - 7470a681e6205243983c4410ee4c920f  # VC-1

        #     - 90501962793d580d011511155c97e4e5  # VP9

        #     - cddfb4e32db826151d97352b8e37c648  # x264

        #     - c9eafd50846d299b862ca9bb6ea91950  # x265

        #     - 041d90b435ebd773271cea047a457a6a  # x266

        # - trash_id: e1053c0ef622df3749fa43c22865663a  # [Optional] SDR

        #   select:

        #     - 2016d1676f5ee13a5b7257ff86ac9a93  # SDR

        #     - 83304f261cf516bb208c18c54c0adf97  # SDR (no WEBDL)

        # - trash_id: 7832db22b71ab669458c17a2850d6913  # [Streaming Services] Miscellaneous

        #   select:

        #     - e6e299075e22ac8f541f722254c8350a  # AUBC

        #     - defb0b4c8b3f6a15927c0f14c6e69c94  # CBC

        #     - 4e9a630db98d5391aec1368a0256e2fe  # CRAV

        #     - dc5f2bb0e0262155b5fedd0f6c5d2b55  # DSCP

        #     - fb1a91cdc0f26f7ca0696e0e95274645  # OViD

        #     - fe4062eac43d4ea75955f8ae48adcf1e  # STRP

        #     - c30d2958827d1867c73318a5a2957eb1  # RED

        #     - 3ac5d84fce98bab1b531393e9c82f467  # QIBI

      ################################################################################

      ## These groups ARE synced by default. Uncomment to disable.

      ##

      ## https://recyclarr.dev/guide/cf-groups/

      ################################################################################

      skip:

        # - 7e1724c5da59e7474803ad25be98f6a3  # [HDR Formats] HDR

        # - abe720fab2d27682adc2a735136cec02  # [Streaming Services] General
```

[View on GitHub](https://github.com/recyclarr/config-templates/blob/v8/sonarr/templates/german-uhd-remux-web.yml)