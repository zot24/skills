<!-- Source: Scraped from trash-guides.info via Firecrawl -->

# TRaSH Guides — Quality Profiles

## Sonarr Quality Settings (File Size)

[Skip to content](https://trash-guides.info/Sonarr/Sonarr-Quality-Settings-File-Size/#quality-settings-file-size)

[Edit this page](https://github.com/TRaSH-Guides/Guides/edit/master/docs/Sonarr/Sonarr-Quality-Settings-File-Size.md "Edit this page") [View source of this page](https://github.com/TRaSH-Guides/Guides/raw/master/docs/Sonarr/Sonarr-Quality-Settings-File-Size.md "View source of this page")

# Quality Settings (File Size) [Permanent link](https://trash-guides.info/Sonarr/Sonarr-Quality-Settings-File-Size/\#quality-settings-file-size "Permanent link")

On the Radarr/Sonarr Discord people often ask,

- “What's the best quality size settings to use?”
- “Why are the ones from the TRaSH Guides so different from the default settings?”

Even though it is a personal preference, we will show you some recommendations to prevent low-quality or fake releases.

## FAQ [Permanent link](https://trash-guides.info/Sonarr/Sonarr-Quality-Settings-File-Size/\#faq "Permanent link")

Why do i only see sizes starting from HDTV720p and up?

- Watching content below 720p on a big screen can result in a blurry and pixelated image, making it difficult to see details and enjoy the true quality of the content. Additionally, lower-resolution videos may not fill the entire screen, leading to a less immersive viewing experience. Investing in higher-quality content ensures that you are getting the best possible picture and sound quality for your viewing pleasure.

Why are some sizes set to max?

- These guides are created to achieve the highest possible quality based on the quality profiles provided.

Why is there a difference between regular movies/tv shows and anime/animated/cartoons ?

- Regular movies and TV shows are set up more strictly to prevent low-quality and fake releases, whereas anime, animated series, and cartoons are set up wide open.

When I set Bluray to MAX size I often get ISO's/ Bluray folder structure.

- You have probably configured your Quality Profiles incorrectly by enabling BR-DISK without adding the recommended Custom Format for Radarr to block/ignore [BR-DISK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#br-disk). For Sonarr, you can use the following to block/ignore [BR-DISK](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#br-disk).

Some movies or episodes may not be grabbed due to these settings.

If you notice that some movies or episodes are not being grabbed due to size settings, you can provide proof with a screenshot showing the error that appears during an interactive search (excluding the indexer or tracker if you prefer).

- We will only consider changes for international releases; no multi-language or dubbed releases will be accepted.
- We will not accept incorrectly labeled source releases such as those from MeGusta, they need to properly name their content first.
- Changes for micro-sized releases will not be accepted.
- Documentaries and cartoons are typically much smaller, so we may not make edits to those either.

These quality file size settings have been created and tested with information gathered from release comparisons from various sources and information provided by the community.

* * *

## Sonarr Quality Definitions [Permanent link](https://trash-guides.info/Sonarr/Sonarr-Quality-Settings-File-Size/\#sonarr-quality-definitions "Permanent link")

Ensure that 'Show Advanced' is enabled if you don't see the option to enter scores under the Quality settings.

After setting the Max Size, set the 'Preferred' score as high as possible. You can accomplish this in one of two ways.

\- 1\. Move the slider to the farthest right.

\- 2\. Enter the maximum score.

In both cases, it will automatically adjust to the highest possible score, which will be slightly below the Max Size setting.

1000 is the displayed value for Unlimited

[Standard](https://trash-guides.info/Sonarr/Sonarr-Quality-Settings-File-Size/#standard)[Anime/Animated/Cartoons](https://trash-guides.info/Sonarr/Sonarr-Quality-Settings-File-Size/#animeanimatedcartoons)

| Quality | Minimum (MB/min) | Preferred (MB/min) | Maximum (MB/min) |
| --- | --- | --- | --- |
| HDTV-720p | 10 | 995 | 1000 |
| HDTV-1080p | 15 | 995 | 1000 |
| WEBRip-720p | 10 | 995 | 1000 |
| WEBDL-720p | 10 | 995 | 1000 |
| Bluray-720p | 17.1 | 995 | 1000 |
| WEBRip-1080p | 15 | 995 | 1000 |
| WEBDL-1080p | 15 | 995 | 1000 |
| Bluray-1080p | 50.4 | 995 | 1000 |
| Bluray-1080p Remux | 69.1 | 995 | 1000 |
| HDTV-2160p | 25 | 995 | 1000 |
| WEBRip-2160p | 25 | 995 | 1000 |
| WEBDL-2160p | 25 | 995 | 1000 |
| Bluray-2160p | 94.6 | 995 | 1000 |
| Bluray-2160p Remux | 187.4 | 995 | 1000 |

| Quality | Minimum (MB/min) | Preferred (MB/min) | Maximum (MB/min) |
| --- | --- | --- | --- |
| SDTV | 5 | 995 | 1000 |
| WEBRip-480p | 5 | 995 | 1000 |
| WEBDL-480p | 5 | 995 | 1000 |
| DVD | 5 | 995 | 1000 |
| Bluray-480p | 5 | 995 | 1000 |
| Bluray-576p | 5 | 995 | 1000 |
| HDTV-720p | 5 | 995 | 1000 |
| HDTV-1080p | 5 | 995 | 1000 |
| WEBRip-720p | 5 | 995 | 1000 |
| WEBDL-720p | 5 | 995 | 1000 |
| Bluray-720p | 5 | 995 | 1000 |
| WEBRip-1080p | 5 | 995 | 1000 |
| WEBDL-1080p | 5 | 995 | 1000 |
| Bluray-1080p | 5 | 995 | 1000 |
| Bluray-1080p Remux | 5 | 995 | 1000 |
| HDTV-2160p | 5 | 995 | 1000 |
| WEBRip-2160p | 5 | 995 | 1000 |
| WEBDL-2160p | 5 | 995 | 1000 |
| Bluray-2160p | 5 | 995 | 1000 |
| Bluray-2160p Remux | 5 | 995 | 1000 |

* * *

Questions or Suggestions?

If you have questions or suggestions, click the button below to join our Discord server.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

Back to top
---

## Sonarr Quality Profiles Setup

[Skip to content](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/#how-to-set-up-quality-profiles)

[Edit this page](https://github.com/TRaSH-Guides/Guides/edit/master/docs/Sonarr/sonarr-setup-quality-profiles.md "Edit this page") [View source of this page](https://github.com/TRaSH-Guides/Guides/raw/master/docs/Sonarr/sonarr-setup-quality-profiles.md "View source of this page")

# How to set up Quality Profiles [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#how-to-set-up-quality-profiles "Permanent link")

_aka How to set up Custom Formats_

So what's the best way to set up the Custom Formats and which ones to use with which scores to set up your quality profiles?

There isn't a "best" setup, it depends on your media setup (hardware devices) and your personal preferences.

Some prefer high-quality audio (HD Audio), others high-quality video. Many prefer both.

Here we will try to explain how to make the most of Custom Formats to help you set up your quality profiles for your personal preferences.

- We've also created an Excel sheet with several tested [media player devices](https://trash-guides.info/Plex/what-does-my-media-player-support) to display what formats and capabilities they support, sourced from information provided by our community. We hope this Excel sheet will be a helpful resource for those looking for a reliable media player device and will help you choose the appropriate quality profile.

* * *

## Basics [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#basics "Permanent link")

After you've added the Custom Formats, as explained in [How to import Custom Formats](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/).
You will need to set it up in the quality Profile you want to use/prefer to make use of the Custom Formats.

You can also use a [Guide sync tool](https://trash-guides.info/Guide-Sync/) to sync the Custom Formats or even the complete quality profile(s).

`Settings` =\> `Profiles`

![!cf-settings-profiles](https://trash-guides.info/Sonarr/images/cf-settings-profiles.png)

Sonarr Custom Formats can be set per profile and isn't global

Select the profile that you want to use/prefer.

![!cf-quality-profiles](https://trash-guides.info/Sonarr/images/cf-quality-profiles.png)

![!cf-profile-selected](https://trash-guides.info/Sonarr/images/cf-profile-selected.png)

1. Profile name.
2. Allow upgrades. Sonarr will stop upgrading quality once (3) is met.
3. Upgrade until the selected quality.
4. The `Minimum Custom Format Score` that is allowed to download. [More Info](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/#minimum-custom-format-score)
5. Keep upgrading Custom Format until this score is reached. (setting this to `0` means no upgrades will happen based on Custom Formats)

At the bottom, in your chosen profile, you will see the added Custom Formats where you can start setting up the scores.

Screenshot example - \[Click to show/hide\]

![!cf-quality-profile-cf](https://trash-guides.info/Sonarr/images/cf-quality-profile-cf.png)

Warning

These screenshots are just examples to show you how it should look and where you need to place the data that you need to add, they aren't always a 100% reflection of the actual data and are not 100% up to date with the actual data you need to add.

- Always follow the data described in the guide.
- If you have any questions or aren't sure just click the chat badge to join the Discord Channel where you can ask your questions directly.

Keep in mind Custom Formats are made to fine-tune your Quality Profile.

Generally, quality trumps all

Custom formats are controlled by Quality Profiles.

- The Upgrade Until score prevents upgrading once a release with this desired score has been downloaded.
- A score of 0 results in the custom format being informational only.
- The Minimum score requires releases to reach this threshold otherwise they will be rejected.
- Custom formats that match with undesirable attributes should be given a negative score to lower their appeal.
- Outright rejections should be given a negative score low enough that even if all of the other formats with positive scores were added, the score would still fall below the minimum.

* * *

### Sonarr current logic [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#sonarr-current-logic "Permanent link")

Sonarr current logic - \[Click to show/hide\]

As of 2024-01-16 the logic is as follows:

The Current logic on how downloads are compared is **Quality Trumps All**![‼](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/203c.svg)

1. Quality
2. Custom Format Score
3. Protocol
4. Episode Count
5. Episode Number
6. Indexer Priority
7. Seeds/Peers (If Torrent)
8. Age (If Usenet)
9. Size

[Source: Wiki Servarr](https://wiki.servarr.com/sonarr/faq#how-are-possible-downloads-compared)

\\* Use the [Season Pack Custom Format](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#season-pack) with a score greater than zero to prefer season packs.

REPACKS and PROPERs are v2 of Qualities and thus rank above a non-repack of the same quality.

`Settings` =\> `Media Management` =\> `File Management` =\> `Proper & Repacks` Change to `Do Not Prefer` and use the [Repack/Proper Custom Format](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repackproper)

* * *

## Which Quality Profile should you choose [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#which-quality-profile-should-you-choose "Permanent link")

Which Quality Profile should you choose - \[Click to show/hide\]

The guides and profiles are built for high-quality sources, specifically those based on formats like WEB-DL, Blu-ray, or Remuxes. These sources prioritize excellent video and audio quality, not small file sizes.

For example, a high-quality, extended version of _The Lord of the Rings_ cannot be compressed to a small size, such as 2-4 GB, without significant quality loss.

The size of a media file is directly related to the quality of the source (WEB-DL, Blu-ray, or Remuxes) and the running time. If you want the highest quality, you shouldn't worry about file size.

Many people think that TRaSH Guides dislikes x265 releases. **We DO NOT.** We simply dislike the reasoning behind why most x265 groups and users use them. More info [HERE](https://trash-guides.info/Misc/x265-4k/).

## Choose a profile based on:

**Hardware compatibility**

- Ensure BOTH your TV and media player support the formats you select. For example, if you want to play media in Dolby Vision (DV) but have a Samsung TV, it will ONLY play HDR10 (this is a Samsung TV limitation).

**Device capabilities**

- Avoid playing high bitrate media on underpowered devices (like smart TV apps).

**Network limitations**

- Consider bandwidth constraints, such as WiFi connections that may be unreliable or cause buffering issues due to inconsistent speeds
- Account for built-in network ports on TVs that are often limited to 100 Mbps

**Transcoding requirements**

- If you continually need to transcode video content, you've probably chosen the wrong profile. Consider selecting a different profile that allows direct playback without video transcoding.
- Audio transcoding has minimal resource impact, so it shouldn't be a major concern unless you're running your media server on a low-powered device.

These are all factors to consider when choosing your profile.

* * *

If you're unsure or have questions, don't hesitate to ask for help on Discord.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

* * *

## TRaSH Quality Profiles [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#trash-quality-profiles "Permanent link")

The following Quality Profiles can be combined into a single Quality Profile if you, for example, want to be able to upgrade from 1080p to 4K/2160p when and if it becomes available _AFTER_ the 1080p release is made.

### WEB-1080p [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#web-1080p "Permanent link")

If you prefer 720p/1080p WEBDL (WEB-1080p)

I suggest to follow the following Guides first.

- [Quality Settings (File Size)](https://trash-guides.info/Sonarr/Sonarr-Quality-Settings-File-Size/).
- [Recommended naming scheme](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/).

For this Quality Profile we're going to make use of the following Custom Formats with the scores given in the table.

Attention

All the used scores and combinations of Custom Formats in this Guide are tested to get the desired results while preventing download loops as much as possible.

From experience, most of the time when people change scores or leave out certain CFs that work together - they end up with undesired results.

If you're unsure or have questions, do not hesitate to ask for help on Discord

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

**The following Custom Formats are required:**

Unwanted - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [BR-DISK](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#br-disk) | -10000 | 85c61753df5da1fb2aab6f2a47426b09 |
| [LQ](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#lq) | -10000 | 9c11cd3f07101cdba90a2d81cf0e56b4 |
| [LQ (Release Title)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#lq-release-title) | -10000 | e2315f990da2e2cbfc9fa5b7a6fcfe48 |
| [x265 (HD)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-hd)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | 47435ece6b99a0b477caf360e79ba0bb |
| [Extras](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#extras) | -10000 | fbcb31d8dabd2a319072b84fc0b7249c |
| [AV1](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#av1) | -10000 | 15a05bc7c1a36e2b57fd628f8977e2fc |

* * *

Breakdown and Why

- **BR-DISK :** This is a custom format to help Sonarr recognize & ignore BR-DISK (ISO's and Blu-ray folder structure) in addition to the standard BR-DISK quality.
- **LQ:** A collection of known low-quality groups that are often banned from the top trackers due to their releases' lack of quality or other reasons.
- **LQ (Release Title):** A collection of terms seen in the titles of low-quality releases that are not captured by using a release group name.
- **x265 (HD):** This blocks 720/1080p (HD) releases that are encoded in x265.



If you have also added [x265 (no HDR/DV)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-no-hdrdv) to your Sonarr,

then one of them should be scored as `0` in your quality profile.

- **Extras:** This blocks/ignores extras

- **AV1:** This blocks all releases encoded in AV1.

**AV1**



AV1 encodes are currently targeting small file sizes, rather than good visual quality.
  - This is a new codec and you need modern devices that support it.
  - We also had reports of playback/transcoding issues.
  - No main group is actually using it (yet).
  - It's better to ignore this new codec to prevent compatibility issues

Miscellaneous (Required) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Repack/Proper](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repackproper) | 5 | ec8fa7296b64e8cd390a1600981f3923 |
| [Repack2](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repack2) | 6 | eb3d5cc0a2be0db205fb823640db6a3c |
| [Repack3](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repack3) | 7 | 44e7c4de10ae50265753082e5dc76047 |

Proper and Repacks - \[Click to show/hide\]

We also suggest changing the Propers and Repacks settings in Sonarr.

`Media Management` =\> `File Management` to `Do Not Prefer` and use the [Repack/Proper](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repackproper) Custom Format.

![!cf-mm-propers-repacks-disable](https://trash-guides.info/Sonarr/images/cf-mm-propers-repacks-disable.png)

This way you make sure the Custom Formats preferences will be used and not ignored.

General Streaming Services - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [AMZN](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#amzn) | 75 | d660701077794679fd59e8bdf4ce3a29 |
| [ATVP](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#atvp) | 75 | f67c9ca88f463a48346062e8ad07713f |
| [CC](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#cc) | 75 | 77a7b25585c18af08f60b1547bb9b4fb |
| [DCU](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#dcu) | 75 | 36b72f59f4ea20aad9316f475f2d9fbb |
| [DSNP](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#dsnp) | 75 | 89358767a60cc28783cdc3d0be9388a4 |
| [HMAX](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hmax) | 75 | a880d6abc21e7c16884f3ae393f84179 |
| [HBO](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hbo) | 75 | 7a235133c87f7da4c8cccceca7e3c7a6 |
| [HULU](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hulu) | 75 | f6cce30f1733d5c8194222a7507909bb |
| [iT](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#it) | 75 | 0ac24a2a68a9700bcb7eeca8e5cd644c |
| [MAX](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#max) | 75 | 81d1fbf600e2540cee87f3a23f9d3c1c |
| [NF](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#nf) | 75 | d34870697c9db575f17700212167be23 |
| [PMTP](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#pmtp) | 75 | c67a75ae4a1715f2bb4d492755ba4195 |
| [PCOK](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#pcok) | 75 | 1656adc6d7bb2c8cca6acfb6592db421 |
| [PLAY](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#play) | 75 | 6eb71887a8db6e783dd398446eb0e65d |
| [SHO](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#sho) | 75 | ae58039e1319178e6be73caab5c42166 |
| [STAN](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#stan) | 75 | 1efe8da11bfd74fbbcd4d8117ddb9213 |
| [SYFY](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#syfy) | 75 | 9623c5c9cac8e939c1b9aedd32f640bf |
| ![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg)[HD Streaming Boost](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hd-streaming-boost) | 75 | 218e93e5702f44a68ad9e3c6ba87d2f0 |

HD Streaming Boost Custom Format

The HD Streaming Boost custom format increases the score of some streaming services' HD releases when those are known to have better quality compared to other streaming services.

This custom format must be included in your profile for streaming service releases to be scored correctly.

HQ Source Groups - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [WEB Tier 01](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#web-tier-01) | 1700 | e6258996055b9fbab7e9cb2f75819294 |
| [WEB Tier 02](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#web-tier-02) | 1650 | 58790d4e2fdcd9733aa7ae68ba2bb503 |
| [WEB Tier 03](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#web-tier-03) | 1600 | d84935abd3f8556dcd51d4f27e22d0a6 |
| [WEB Scene](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#web-scene)![❗](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/2757.svg) | 1600 | d0c516558625b04b363fa6c5c2c7cfd4 |

Info

![❗](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/2757.svg) = The reason why this Custom Format gets positively scored is because it's the only quality scene group that exists (up until now). Scene groups don't add a streaming service to their release names, so the score is adjusted to take this into account.

**The following Custom Formats are optional:**

Miscellaneous (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Bad Dual Groups](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#bad-dual-groups) | -10000 | 32b367365729d530ca1c124a0b180c64 |
| [No-RlsGroup](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#no-rlsgroup) | -10000 | 82d40da2bc6923f41e14394075dd4b03 |
| [Obfuscated](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#obfuscated) | -10000 | e1a997ddb54e3ecbfe06341ad323c458 |
| [Retags](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#retags) | -10000 | 06d66ab109d4d2eddb2794d21526d140 |
| [Scene](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#scene) | -10000 | 1b3994c551cbb92a2c781af061f4ab44 |

* * *

Breakdown and Why

- **Bad Dual Groups:** \[ _Optional_\] These groups take the original release and add their own language track (e.g. AAC 2.0 Portuguese) as the first track. Afterward, FFprobe would determine that the media file is Portuguese. It's a common rule that you only add the best audio as the main track.
Also they often even rename the release name into Portuguese.
- **No-RlsGroup:** \[ _Optional_\] Some indexers strip out the release group which could result in LQ groups being scored incorrectly. For example, a lot of EVO releases end up with a stripped group name. These releases would appear as "upgrades" and could end up getting a decent score after other CFs are scored.
- **Obfuscated:** \[ _Optional_\] Use these only if you wish to avoid renamed releases.
- **Retags:** \[ _Optional_\] Use this if you wish to avoid retagged releases. Retagged releases often are not consistent with the quality of the original group's release (e.g. TGx downsampling an NTb release from 5.1 audio to 2.0 audio, yet maintaining the NTb naming).
- **Scene:** \[ _Optional_\] Use this only if you want to avoid SCENE releases.

Note: The `Audio Formats` Custom Formats aren't used in the WEB profile, as WEB-DL do not often come with HD audio (most newer WEB-DL will have lossy Atmos, though). If you want HD audio, we would suggest going with Remuxes.

Use the following main settings in your profile.

![!cf-profile-web1080](https://trash-guides.info/Sonarr/images/cf-profile-web1080.png)

#### WEB-1080p alternative Quality Profile [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#web-1080p-alternative-quality-profile "Permanent link")

Tip

For some older shows, you might want to enable the `WEB-720p`, `HDTV-720p/1080p`, or even `Bluray-720p/1080p` quality source. Depending on your preferences, you can put them above or below the `WEB-1080p`.

![Alternative Option](https://trash-guides.info/Sonarr/images/cf-profile-alternative-web1080.png)

* * *

Info

The order listed in the profile matters even if a quality is not checked, for example if you have a 1080p version but wanted the SD version, Radarr will reject all SD results because 1080p is listed higher than SD even though 1080p was not checked.

Qualities at the top of the list will appear first in manual searches.

- Qualities higher in the list are more preferred even if not checked.
- Qualities within the same group are equal.
- Only checked qualities are wanted.

This is why it's recommended to move the selected quality to the top of the list.

[Source: Wiki Servarr](https://wiki.servarr.com/en/radarr/settings#quality-profiles)

Workflow Logic - \[Click to show/hide\]

- It will download WEB-DL 1080p. (If you also enabled `WEB 720p` and/or `HDTV 1080p` it will upgrade until `Upgrade Until`)
- The downloaded media will be upgraded to any of the added Custom Formats until a score of 10000.

So why such a ridiculously high `Upgrade Until Custom` and not a score of `100`?

We're too lazy to calculate the maximum for every Quality Profile we provide, and we want it to upgrade to the highest possible score anyway to result in the highest possible quality release.

* * *

### WEB-2160p [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#web-2160p "Permanent link")

If you prefer 2160p WEBDL (WEB-2160p)

I suggest to follow the following Guides first.

- [Quality Settings (File Size)](https://trash-guides.info/Sonarr/Sonarr-Quality-Settings-File-Size/).
- [Recommended naming scheme](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/).

For this Quality Profile we're going to make use of the following Custom Formats with the scores given in the table.

Attention

All the used scores and combinations of Custom Formats in this Guide are tested to get the desired results while preventing download loops as much as possible.

From experience, most of the time when people change scores or leave out certain CFs that work together - they end up with undesired results.

If you're unsure or have questions, do not hesitate to ask for help on Discord

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

**The following Custom Formats are required:**

HDR Formats - \[Click to show/hide\]

**HDR**

All users with HDR-capable equipment should add the HDR custom format.

_This is a catch-all custom format for all HDR-related formats, including those with HDR10 or HDR10+ fallback capabilities, such as DV HDR10 or DV HDR10+._

* * *

**DV Boost**

If you prefer Dolby Vision and have compatible equipment, add the DV Boost custom format. This custom format prioritizes releases containing Dolby Vision over standard HDR releases.

_This custom format accepts DV Profile 5 and also upgrades from DV/HDR10/HDR10+ to DV HDR10 or DV HDR10+._

**HDR10+ Boost**

If you prefer HDR10+ releases and have compatible equipment, add the HDR10+ Boost custom format. This custom format prioritizes releases containing HDR10+ over standard HDR releases.

_This custom format also boosts DV HDR10+ releases if you prefer them over DV HDR10._

If you prefer both Dolby Vision and HDR10+, add both boost custom formats!

* * *

**DV (w/o HDR fallback)**

If **NOT** every device accessing your media server supports Dolby Vision, add the DV (w/o HDR fallback) custom format to ensure maximum compatibility with your setup. This prevents playback issues on devices that don't fully support Dolby Vision.

_This also applies to Dolby Vision releases without HDR10 fallback (Profile 5)._

* * *

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [HDR](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hdr) | 500 | 505d871304820ba7106b693be6fe4a9e |
| [DV Boost](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#dv-boost) | 1000 | 7c3a61a9c6cb04f52f1544be6d44a026 |
| [HDR10+ Boost](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hdr10plus-boost) | 100 | 0c4b99df9206d2cfac3c05ab897dd62a |
| [DV (w/o HDR fallback)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#dv-wo-hdr-fallback) | -10000 | 9b27ab6498ec0f31a3353992e19434ca |

* * *

Why am I getting purple or green colors? - \[Click to show/hide\]

Why am I getting purple or green colors?

There are several possible reasons why your TV would show purple or green colors when playing Dolby Vision content.

1. **Unsupported Hardware**: Your TV or hardware media player device (Roku, Apple TV, etc) doesn't support Dolby Vision or your hardware media player device doesn't support all the Dolby Vision Profiles. As a result, the device might struggle to produce accurate colors, leading to a purple or green tint.

2. **Incorrect Display Settings**: Dolby Vision content often requires specific settings to be enabled on your TV or display device in order to deliver the intended visual experience. If these settings are not configured properly, it can result in the device showing distorted colors (including purple or green hues).

3. **HDMI Compatibility Issues**: Sometimes, HDMI cables or ports may not be fully compatible with Dolby Vision. If the media player device is not recognizing the Dolby Vision signal properly, it may fail to process the content correctly, resulting in abnormal color rendering.


To resolve the purple or green color issues when playing Dolby Vision content, you can try the following troubleshooting steps:

1. Ensure your TV or hardware media player device is Dolby Vision compatible and up-to-date with the latest firmware.
2. Verify that your TV or display device is set up correctly and has the necessary Dolby Vision settings enabled.
3. Check the HDMI cables and ensure they can transmit Dolby Vision signals.

Dolby Vision Profiles - \[Click to show/hide\]

Dolby Vision Profiles

- **Profile 5**( _1_) \- This is what comes with WEB-DL Dolby Vision releases without HDR10 fallback.

( _Incompatible devices will playback with blown out pinks and greens_)
- **Profile 7**( _2_) \- This is what comes with UHD Bluray Remuxes and UHD BluRay releases.

_These files will play on an Nvidia Shield Pro (2019), but on most other players will revert to the HDR10 fallback._
- **Profile 8**( _3_) \- This is what comes with (Hybrid) WEB-DL (HULU), Hybrid UHD Remux, and UHD BluRay releases (all of which have HDR10 fallback).

_This works with several mainstream media players._


* * *

Apple TV Dolby Vision Limitations - \[Click to show/hide\]

Plex for Apple TV is only capable of playing Dolby Vision Profiles 5 and 8 correctly if CMv2.9 is being used.

Infuse 7.7.2+ offers expanded support for Dolby Vision Profile 8, including files containing CMv4.0 metadata, samples that were previously playing with a black screen, falling back to HDR10, or various other playback issues. [SOURCE](https://community.firecore.com/t/infuse-7-7-2-now-available/48208)

The Dolby Vision Profile and Version of a media file cannot be determined by automation software before downloading it, so when you are using an Apple TV, with or without Infuse, it will always be hit or miss whether the content is compatible or not.

Additionally, it is uncertain whether the Dolby Vision layer will play, fall back to HDR10, or result in a black screen.

- ( _1_) _PLEX for Apple TV and Plex with Infuse will only play profile 5 correctly if CMv2.9 is used._
- ( _2_) _Neither Infuse nor PLEX for Apple TV will deliver real Dolby Vision with Profile 7._
- ( _3_) _PLEX for Apple TV will only play profile 8 correctly if CMv2.9 is used. However, we have also received reports that in some cases, it will fall back to HDR10, or you may encounter a black screen._



To prevent your TV from incorrectly indicating that it is playing DV follow the steps provided by an Infuse user: **“With Infuse ensure you set the Extended Dolby Vision settings to Limited (prefer accuracy), convert P8 to P5 (when possible), and play other P8 as HDR (output will switch to either DoVi or HDR depending on the video)”**

Dolby Vision Versions - CMv2.9 and CMv4.0 - \[Click to show/hide\]

There are two versions of Dolby Vision, namely CMv2.9 and CMv4.0. CMv4.0 uses an improved algorithm and a superior tone curve, allowing for better mapping and more controls during the Dolby Vision trim pass process.

More info about the different Dolby Vision Versions: [Dolby Vision Versions - CMv2.9 vs. CMv4.0](https://professionalsupport.dolby.com/s/article/When-should-I-use-CM-v2-9-or-CM-v4-0-and-can-I-convert-between-them?language=en_US)

Unwanted - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [BR-DISK](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#br-disk) | -10000 | 85c61753df5da1fb2aab6f2a47426b09 |
| [LQ](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#lq) | -10000 | 9c11cd3f07101cdba90a2d81cf0e56b4 |
| [LQ (Release Title)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#lq-release-title) | -10000 | e2315f990da2e2cbfc9fa5b7a6fcfe48 |
| [x265 (HD)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-hd)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | 47435ece6b99a0b477caf360e79ba0bb |
| [Extras](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#extras) | -10000 | fbcb31d8dabd2a319072b84fc0b7249c |
| [AV1](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#av1) | -10000 | 15a05bc7c1a36e2b57fd628f8977e2fc |

* * *

Breakdown and Why

- **BR-DISK :** This is a custom format to help Sonarr recognize & ignore BR-DISK (ISO's and Blu-ray folder structure) in addition to the standard BR-DISK quality.
- **LQ:** A collection of known low-quality groups that are often banned from the top trackers due to their releases' lack of quality or other reasons.
- **LQ (Release Title):** A collection of terms seen in the titles of low-quality releases that are not captured by using a release group name.
- **x265 (HD):** This blocks 720/1080p (HD) releases that are encoded in x265.



If you have also added [x265 (no HDR/DV)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-no-hdrdv) to your Sonarr,

then one of them should be scored as `0` in your quality profile.

- **Extras:** This blocks/ignores extras

- **AV1:** This blocks all releases encoded in AV1.

**AV1**



AV1 encodes are currently targeting small file sizes, rather than good visual quality.
  - This is a new codec and you need modern devices that support it.
  - We also had reports of playback/transcoding issues.
  - No main group is actually using it (yet).
  - It's better to ignore this new codec to prevent compatibility issues

Miscellaneous (Required) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Repack/Proper](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repackproper) | 5 | ec8fa7296b64e8cd390a1600981f3923 |
| [Repack2](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repack2) | 6 | eb3d5cc0a2be0db205fb823640db6a3c |
| [Repack3](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repack3) | 7 | 44e7c4de10ae50265753082e5dc76047 |

Proper and Repacks - \[Click to show/hide\]

We also suggest changing the Propers and Repacks settings in Sonarr.

`Media Management` =\> `File Management` to `Do Not Prefer` and use the [Repack/Proper](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repackproper) Custom Format.

![!cf-mm-propers-repacks-disable](https://trash-guides.info/Sonarr/images/cf-mm-propers-repacks-disable.png)

This way you make sure the Custom Formats preferences will be used and not ignored.

General Streaming Services (UHD) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [AMZN](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#amzn) | 75 | d660701077794679fd59e8bdf4ce3a29 |
| [ATVP](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#atvp) | 75 | f67c9ca88f463a48346062e8ad07713f |
| [CC](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#cc) | 75 | 77a7b25585c18af08f60b1547bb9b4fb |
| [DCU](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#dcu) | 75 | 36b72f59f4ea20aad9316f475f2d9fbb |
| [DSNP](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#dsnp) | 75 | 89358767a60cc28783cdc3d0be9388a4 |
| [HMAX](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hmax) | 75 | a880d6abc21e7c16884f3ae393f84179 |
| [HBO](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hbo) | 75 | 7a235133c87f7da4c8cccceca7e3c7a6 |
| [HULU](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hulu) | 75 | f6cce30f1733d5c8194222a7507909bb |
| [iT](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#it) | 75 | 0ac24a2a68a9700bcb7eeca8e5cd644c |
| [MAX](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#max) | 75 | 81d1fbf600e2540cee87f3a23f9d3c1c |
| [NF](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#nf) | 75 | d34870697c9db575f17700212167be23 |
| [PMTP](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#pmtp) | 75 | c67a75ae4a1715f2bb4d492755ba4195 |
| [PCOK](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#pcok) | 75 | 1656adc6d7bb2c8cca6acfb6592db421 |
| [PLAY](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#play) | 75 | 6eb71887a8db6e783dd398446eb0e65d |
| [SHO](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#sho) | 75 | ae58039e1319178e6be73caab5c42166 |
| [STAN](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#stan) | 75 | 1efe8da11bfd74fbbcd4d8117ddb9213 |
| [SYFY](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#syfy) | 75 | 9623c5c9cac8e939c1b9aedd32f640bf |
| ![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg)[UHD Streaming Boost](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#uhd-streaming-boost) | 75 | 43b3cf48cb385cd3eac608ee6bca7f09 |
| ![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg)[HD Streaming Boost](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hd-streaming-boost) | 75 | 218e93e5702f44a68ad9e3c6ba87d2f0 |

UHD Streaming Boost and HD Streaming Boost Custom Formats

The UHD Streaming Boost and HD Streaming Boost custom formats increase the scores of streaming services' UHD or HD releases (or both), when those services are known to have better quality compared to other streaming services.

These two custom formats must be included in your profile for streaming service releases to be scored correctly.

HQ Source Groups - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [WEB Tier 01](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#web-tier-01) | 1700 | e6258996055b9fbab7e9cb2f75819294 |
| [WEB Tier 02](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#web-tier-02) | 1650 | 58790d4e2fdcd9733aa7ae68ba2bb503 |
| [WEB Tier 03](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#web-tier-03) | 1600 | d84935abd3f8556dcd51d4f27e22d0a6 |
| [WEB Scene](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#web-scene)![❗](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/2757.svg) | 1600 | d0c516558625b04b363fa6c5c2c7cfd4 |

Info

![❗](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/2757.svg) = The reason why this Custom Format gets positively scored is because it's the only quality scene group that exists (up until now). Scene groups don't add a streaming service to their release names, so the score is adjusted to take this into account.

**The following Custom Formats are optional:**

Miscellaneous (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Bad Dual Groups](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#bad-dual-groups) | -10000 | 32b367365729d530ca1c124a0b180c64 |
| [No-RlsGroup](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#no-rlsgroup) | -10000 | 82d40da2bc6923f41e14394075dd4b03 |
| [Obfuscated](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#obfuscated) | -10000 | e1a997ddb54e3ecbfe06341ad323c458 |
| [Retags](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#retags) | -10000 | 06d66ab109d4d2eddb2794d21526d140 |
| [Scene](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#scene) | -10000 | 1b3994c551cbb92a2c781af061f4ab44 |

* * *

Breakdown and Why

- **Bad Dual Groups:** \[ _Optional_\] These groups take the original release and add their own language track (e.g. AAC 2.0 Portuguese) as the first track. Afterward, FFprobe would determine that the media file is Portuguese. It's a common rule that you only add the best audio as the main track.
Also they often even rename the release name into Portuguese.
- **No-RlsGroup:** \[ _Optional_\] Some indexers strip out the release group which could result in LQ groups being scored incorrectly. For example, a lot of EVO releases end up with a stripped group name. These releases would appear as "upgrades" and could end up getting a decent score after other CFs are scored.
- **Obfuscated:** \[ _Optional_\] Use these only if you wish to avoid renamed releases.
- **Retags:** \[ _Optional_\] Use this if you wish to avoid retagged releases. Retagged releases often are not consistent with the quality of the original group's release (e.g. TGx downsampling an NTb release from 5.1 audio to 2.0 audio, yet maintaining the NTb naming).
- **Scene:** \[ _Optional_\] Use this only if you want to avoid SCENE releases.

Miscellaneous UHD (Optional) - \[Click to show/hide\]

I recommend using the following Custom Formats

- **For details on "Why" and a potential warning ![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) please see the notes below.**
- `x265 (no HDR/DV)` over the `x265 (HD)`
- `SDR (no WEBDL)` over the `SDR`

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [SDR](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#sdr) | -10000 | 2016d1676f5ee13a5b7257ff86ac9a93 |
| [SDR (no WEBDL)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#sdr-no-webdl)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | 83304f261cf516bb208c18c54c0adf97 |
| [x265 (no HDR/DV)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-no-hdrdv)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | 9b64dff695c2115facf1b6ea59c9bd07 |

* * *

Breakdown and Why

- **SDR:** This will prevent grabbing UHD/4k releases without HDR Formats.
- **SDR (no WEBDL):** This will prevent grabbing UHD/4k Remux and Bluray encode releases without HDR Formats. - i.e., SDR WEB releases will still be allowed since 4K SDR WEB releases can often look better than the 1080p version due to the improved bitrate.



If you have also added [SDR](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#sdr) to your Sonarr,

then one of them should be scored as `0` in your quality profile.

- **x265 (no HDR/DV):** This blocks 720/1080p (HD) releases that are encoded in x265, **But it will allow x265 releases if they have HDR and/or DV**



If you have also added [x265 (HD)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-hd) to your Sonarr,

then one of them should be scored as `0` in your quality profile.


Note: The `Audio Formats` Custom Formats aren't used in the WEB profile, as WEB-DL do not often come with HD audio (most newer WEB-DL will have lossy Atmos, though). If you want HD audio, we would suggest going with Remuxes.

Use the following main settings in your profile.

![!cf-profile-web2160](https://trash-guides.info/Sonarr/images/cf-profile-web2160.png)

#### WEB-2160p alternative Quality Profile [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#web-2160p-alternative-quality-profile "Permanent link")

Tip

You might want to combine the `WEB-720p/1080p` into a single Quality Profile if you, for example, want to be able to upgrade from 1080p to 4K/2160p when and if it becomes available after the 1080p release is made, and perhaps enable the `HDTV-720p/1080p` and/or `Bluray-720p/1080p` for some older shows, or even the `Bluray-2160p` quality source because you prefer HD audio. Depending on your preferences, you can put them above or below the `WEB-2160p`.

![Alternative Option](https://trash-guides.info/Sonarr/images/cf-profile-alternative-web2160.png)

* * *

Info

The order listed in the profile matters even if a quality is not checked, for example if you have a 1080p version but wanted the SD version, Radarr will reject all SD results because 1080p is listed higher than SD even though 1080p was not checked.

Qualities at the top of the list will appear first in manual searches.

- Qualities higher in the list are more preferred even if not checked.
- Qualities within the same group are equal.
- Only checked qualities are wanted.

This is why it's recommended to move the selected quality to the top of the list.

[Source: Wiki Servarr](https://wiki.servarr.com/en/radarr/settings#quality-profiles)

Workflow Logic - \[Click to show/hide\]

- This will download WEB-2160p with HDR/DV.
- The downloaded media will be upgraded to any of the added Custom Formats until a score of 10000.

So why such a ridiculously high `Upgrade Until Custom` and not a score of `100`?

We're too lazy to calculate the maximum for every Quality Profile we provide, and we want it to upgrade to the highest possible score anyway to result in the highest possible quality release.

* * *

## Custom Format Groups [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#custom-format-groups "Permanent link")

The following custom format groups should be combined with the Quality Profiles above. Users will need to choose which options and custom formats they prefer.

### HDR Formats [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#hdr-formats "Permanent link")

- You have a 4K TV and a hardware media player device (such as Roku, Apple TV, Shield, SmartTV App, etc.) that supports several HDR formats (such as Dolby Vision, HDR10, HDR10+, etc.).

HDR Formats - \[Click to show/hide\]

**HDR**

All users with HDR-capable equipment should add the HDR custom format.

_This is a catch-all custom format for all HDR-related formats, including those with HDR10 or HDR10+ fallback capabilities, such as DV HDR10 or DV HDR10+._

* * *

**DV Boost**

If you prefer Dolby Vision and have compatible equipment, add the DV Boost custom format. This custom format prioritizes releases containing Dolby Vision over standard HDR releases.

_This custom format accepts DV Profile 5 and also upgrades from DV/HDR10/HDR10+ to DV HDR10 or DV HDR10+._

**HDR10+ Boost**

If you prefer HDR10+ releases and have compatible equipment, add the HDR10+ Boost custom format. This custom format prioritizes releases containing HDR10+ over standard HDR releases.

_This custom format also boosts DV HDR10+ releases if you prefer them over DV HDR10._

If you prefer both Dolby Vision and HDR10+, add both boost custom formats!

* * *

**DV (w/o HDR fallback)**

If **NOT** every device accessing your media server supports Dolby Vision, add the DV (w/o HDR fallback) custom format to ensure maximum compatibility with your setup. This prevents playback issues on devices that don't fully support Dolby Vision.

_This also applies to Dolby Vision releases without HDR10 fallback (Profile 5)._

* * *

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [HDR](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hdr) | 500 | 505d871304820ba7106b693be6fe4a9e |
| [DV Boost](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#dv-boost) | 1000 | 7c3a61a9c6cb04f52f1544be6d44a026 |
| [HDR10+ Boost](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#hdr10plus-boost) | 100 | 0c4b99df9206d2cfac3c05ab897dd62a |
| [DV (w/o HDR fallback)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#dv-wo-hdr-fallback) | -10000 | 9b27ab6498ec0f31a3353992e19434ca |

* * *

Why am I getting purple or green colors? - \[Click to show/hide\]

Why am I getting purple or green colors?

There are several possible reasons why your TV would show purple or green colors when playing Dolby Vision content.

1. **Unsupported Hardware**: Your TV or hardware media player device (Roku, Apple TV, etc) doesn't support Dolby Vision or your hardware media player device doesn't support all the Dolby Vision Profiles. As a result, the device might struggle to produce accurate colors, leading to a purple or green tint.

2. **Incorrect Display Settings**: Dolby Vision content often requires specific settings to be enabled on your TV or display device in order to deliver the intended visual experience. If these settings are not configured properly, it can result in the device showing distorted colors (including purple or green hues).

3. **HDMI Compatibility Issues**: Sometimes, HDMI cables or ports may not be fully compatible with Dolby Vision. If the media player device is not recognizing the Dolby Vision signal properly, it may fail to process the content correctly, resulting in abnormal color rendering.


To resolve the purple or green color issues when playing Dolby Vision content, you can try the following troubleshooting steps:

1. Ensure your TV or hardware media player device is Dolby Vision compatible and up-to-date with the latest firmware.
2. Verify that your TV or display device is set up correctly and has the necessary Dolby Vision settings enabled.
3. Check the HDMI cables and ensure they can transmit Dolby Vision signals.

Dolby Vision Profiles - \[Click to show/hide\]

Dolby Vision Profiles

- **Profile 5**( _1_) \- This is what comes with WEB-DL Dolby Vision releases without HDR10 fallback.

( _Incompatible devices will playback with blown out pinks and greens_)
- **Profile 7**( _2_) \- This is what comes with UHD Bluray Remuxes and UHD BluRay releases.

_These files will play on an Nvidia Shield Pro (2019), but on most other players will revert to the HDR10 fallback._
- **Profile 8**( _3_) \- This is what comes with (Hybrid) WEB-DL (HULU), Hybrid UHD Remux, and UHD BluRay releases (all of which have HDR10 fallback).

_This works with several mainstream media players._


* * *

Apple TV Dolby Vision Limitations - \[Click to show/hide\]

Plex for Apple TV is only capable of playing Dolby Vision Profiles 5 and 8 correctly if CMv2.9 is being used.

Infuse 7.7.2+ offers expanded support for Dolby Vision Profile 8, including files containing CMv4.0 metadata, samples that were previously playing with a black screen, falling back to HDR10, or various other playback issues. [SOURCE](https://community.firecore.com/t/infuse-7-7-2-now-available/48208)

The Dolby Vision Profile and Version of a media file cannot be determined by automation software before downloading it, so when you are using an Apple TV, with or without Infuse, it will always be hit or miss whether the content is compatible or not.

Additionally, it is uncertain whether the Dolby Vision layer will play, fall back to HDR10, or result in a black screen.

- ( _1_) _PLEX for Apple TV and Plex with Infuse will only play profile 5 correctly if CMv2.9 is used._
- ( _2_) _Neither Infuse nor PLEX for Apple TV will deliver real Dolby Vision with Profile 7._
- ( _3_) _PLEX for Apple TV will only play profile 8 correctly if CMv2.9 is used. However, we have also received reports that in some cases, it will fall back to HDR10, or you may encounter a black screen._



To prevent your TV from incorrectly indicating that it is playing DV follow the steps provided by an Infuse user: **“With Infuse ensure you set the Extended Dolby Vision settings to Limited (prefer accuracy), convert P8 to P5 (when possible), and play other P8 as HDR (output will switch to either DoVi or HDR depending on the video)”**

Dolby Vision Versions - CMv2.9 and CMv4.0 - \[Click to show/hide\]

There are two versions of Dolby Vision, namely CMv2.9 and CMv4.0. CMv4.0 uses an improved algorithm and a superior tone curve, allowing for better mapping and more controls during the Dolby Vision trim pass process.

More info about the different Dolby Vision Versions: [Dolby Vision Versions - CMv2.9 vs. CMv4.0](https://professionalsupport.dolby.com/s/article/When-should-I-use-CM-v2-9-or-CM-v4-0-and-can-I-convert-between-them?language=en_US)

* * *

## FAQ & INFO [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#faq-info "Permanent link")

### Why only WEB-DL [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#why-only-web-dl "Permanent link")

Why do you only have Profiles for WEB-DL - \[Click to show/hide\]

We only do WEB-DL, myself, for TV shows. In our opinion, WEB-DL is the sweet spot between quality and size (you often don't see big differences anyway for TV shows) except for shows like GOT, Vikings, etc.

### Why prefer P2P groups [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#why-prefer-p2p-groups "Permanent link")

Why do you prefer P2P groups over scene groups - \[Click to show/hide\]

Scene groups are always in a rush to bring releases out as fast as possible.

We noticed, often, that we got Repacks/Propers from them, or of different groups and quality. P2P release groups are a bit smarter, and sort of work together, by not doing the same releases. Also, we noticed that with some scene releases the 5.1 audio was stripped out or converted to AAC audio.

In our opinion, the P2P releases are better quality. However, there is one scene group that does bring out quality releases `-deflate`/`-inflate`.

### Why so many repacks/propers [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#why-so-many-repackspropers "Permanent link")

Why do we see so many repacks/propers of Amazon WEB-DLs lately - \[Click to show/hide\]

A large portion of Amazon WEB-DLs in the last weeks have only had 192Kbps DD+5.1 (because that's all Amazon made available initially). The proper 640Kbps DD+5.1 audio might appear a few hours, or a few months, later. The lower quality release will be REPACKED when the higher quality audio is available.

### Proper and Repacks [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#proper-and-repacks "Permanent link")

Proper and Repacks - \[Click to show/hide\]

We also suggest that you change the Propers and Repacks settings in Radarr.

`Media Management` =\> `File Management` to `Do Not Prefer` and use the [Repack/Proper](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#repackproper) Custom Format.

![!cf-mm-propers-repacks-disable](https://trash-guides.info/Sonarr/images/cf-mm-propers-repacks-disable.png)

This way you make sure the Custom Format preferences will be used instead.

### How Does Custom Format Scoring Work? [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#how-does-custom-format-scoring-work "Permanent link")

How Does Custom Format Scoring Work? - \[Click to show/hide\]

Let’s say you have three custom formats, A, B and C. Scored as:

```
A: 10
B: 20
C: 30
```

Then, let’s say you have three releases, X, Y and Z. They happen to match your custom formats as follows:

```
X matches A
Y matches B and C
Z matches A and C
```

Total custom format scores would therefore be:

```
X: 10 (matches A)
Y: 50 (matches B and C)
Z: 40 (matches A and C)
```

Quality is the first check. If all three of our example releases here are the same quality - eg, WEBDL-1080p, then we move on to the next check which is custom format score. In the example above, Y would be chosen as it has the highest cumulative custom format score.

### Custom Formats to avoid certain releases [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#custom-formats-to-avoid-certain-releases "Permanent link")

How to use a Custom Format to avoid certain releases? - \[Click to show/hide\]

For Custom Formats matching what you want to avoid, set it to something really low like `-10000` and not something like `-10`.
When you add your preferred Custom Format and set it to something like `+10`, it's possible that, for example, the `BR-DISK` will be downloaded - (-10)+(+10)=0 - if your `Minimum Custom Format Score` is set at `0`.

### Releases you should avoid [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#releases-you-should-avoid "Permanent link")

This is a must-have for every Quality Profile you use in our opinion. All these Custom Formats make sure you don't get low-quality releases.

Unwanted - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [BR-DISK](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#br-disk) | -10000 | 85c61753df5da1fb2aab6f2a47426b09 |
| [LQ](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#lq) | -10000 | 9c11cd3f07101cdba90a2d81cf0e56b4 |
| [LQ (Release Title)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#lq-release-title) | -10000 | e2315f990da2e2cbfc9fa5b7a6fcfe48 |
| [x265 (HD)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-hd)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | 47435ece6b99a0b477caf360e79ba0bb |
| [Extras](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#extras) | -10000 | fbcb31d8dabd2a319072b84fc0b7249c |
| [AV1](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#av1) | -10000 | 15a05bc7c1a36e2b57fd628f8977e2fc |

* * *

Breakdown and Why

- **BR-DISK :** This is a custom format to help Sonarr recognize & ignore BR-DISK (ISO's and Blu-ray folder structure) in addition to the standard BR-DISK quality.
- **LQ:** A collection of known low-quality groups that are often banned from the top trackers due to their releases' lack of quality or other reasons.
- **LQ (Release Title):** A collection of terms seen in the titles of low-quality releases that are not captured by using a release group name.
- **x265 (HD):** This blocks 720/1080p (HD) releases that are encoded in x265.



If you have also added [x265 (no HDR/DV)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-no-hdrdv) to your Sonarr,

then one of them should be scored as `0` in your quality profile.

- **Extras:** This blocks/ignores extras

- **AV1:** This blocks all releases encoded in AV1.

**AV1**



AV1 encodes are currently targeting small file sizes, rather than good visual quality.
  - This is a new codec and you need modern devices that support it.
  - We also had reports of playback/transcoding issues.
  - No main group is actually using it (yet).
  - It's better to ignore this new codec to prevent compatibility issues

### Custom Formats with a score of 0 [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#custom-formats-with-a-score-of-0 "Permanent link")

What do Custom Formats with a score of 0 do? - \[Click to show/hide\]

All Custom Formats with a score of 0 are purely informational and don't do anything.

### Minimum Custom Format Score [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#minimum-custom-format-score "Permanent link")

Minimum Custom Format Score - \[Click to show/hide\]

Some people suggest not to use negative scores for your Custom Formats and set this option to a higher score than 0.

The reason why we don't prefer/use this is because you could limit yourself when some new groups or whatever will be released.

Also, it makes it much more clear what you prefer and what you want to avoid.

### Audio Channels [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#audio-channels "Permanent link")

Audio Channels - \[Click to show/hide\]

Elsewhere in the guide, you will find a separate group of custom formats called `Audio Channels`. These will match the number of audio channels in a release, for example, 2.0 (stereo) or 5.1/7.1 (surround sound). We wouldn't add the audio channels Custom Formats as you could limit yourself in the amount of releases you're able to get. Only use them if you have a specific need for them.

Using this with any kind of Remux Quality Profile is useless, in our opinion, being that 99% of all Remuxes are multi-audio anyway. You can get better scores just by using the `Audio Formats` Custom Formats.

### Avoid using the x264/x265 Custom Format [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#avoid-using-the-x264x265-custom-format "Permanent link")

Avoid using the x264/x265 Custom Format - \[Click to show/hide\]

Avoid using the x264/x265 Custom Format with a score if possible, it's smarter to use the [x265 (HD)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-hd) Custom Format.

Something like 95% of video files are x264 and have much better direct play support. If you have more than a of couple users, you will notice much more transcoding.

Use x265 only for 4k releases and the [x265 (HD)](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#x265-hd) makes sure you still get the x265 releases.

### Why am I getting purple or green colors [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#why-am-i-getting-purple-or-green-colors "Permanent link")

Why am I getting purple or green colors? - \[Click to show/hide\]

Why am I getting purple or green colors?

There are several possible reasons why your TV would show purple or green colors when playing Dolby Vision content.

1. **Unsupported Hardware**: Your TV or hardware media player device (Roku, Apple TV, etc) doesn't support Dolby Vision or your hardware media player device doesn't support all the Dolby Vision Profiles. As a result, the device might struggle to produce accurate colors, leading to a purple or green tint.

2. **Incorrect Display Settings**: Dolby Vision content often requires specific settings to be enabled on your TV or display device in order to deliver the intended visual experience. If these settings are not configured properly, it can result in the device showing distorted colors (including purple or green hues).

3. **HDMI Compatibility Issues**: Sometimes, HDMI cables or ports may not be fully compatible with Dolby Vision. If the media player device is not recognizing the Dolby Vision signal properly, it may fail to process the content correctly, resulting in abnormal color rendering.


To resolve the purple or green color issues when playing Dolby Vision content, you can try the following troubleshooting steps:

1. Ensure your TV or hardware media player device is Dolby Vision compatible and up-to-date with the latest firmware.
2. Verify that your TV or display device is set up correctly and has the necessary Dolby Vision settings enabled.
3. Check the HDMI cables and ensure they can transmit Dolby Vision signals.

### Dolby Vision Profiles [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#dolby-vision-profiles "Permanent link")

Dolby Vision Profiles - \[Click to show/hide\]

Dolby Vision Profiles

- **Profile 5**( _1_) \- This is what comes with WEB-DL Dolby Vision releases without HDR10 fallback.

( _Incompatible devices will playback with blown out pinks and greens_)
- **Profile 7**( _2_) \- This is what comes with UHD Bluray Remuxes and UHD BluRay releases.

_These files will play on an Nvidia Shield Pro (2019), but on most other players will revert to the HDR10 fallback._
- **Profile 8**( _3_) \- This is what comes with (Hybrid) WEB-DL (HULU), Hybrid UHD Remux, and UHD BluRay releases (all of which have HDR10 fallback).

_This works with several mainstream media players._


* * *

Apple TV Dolby Vision Limitations - \[Click to show/hide\]

Plex for Apple TV is only capable of playing Dolby Vision Profiles 5 and 8 correctly if CMv2.9 is being used.

Infuse 7.7.2+ offers expanded support for Dolby Vision Profile 8, including files containing CMv4.0 metadata, samples that were previously playing with a black screen, falling back to HDR10, or various other playback issues. [SOURCE](https://community.firecore.com/t/infuse-7-7-2-now-available/48208)

The Dolby Vision Profile and Version of a media file cannot be determined by automation software before downloading it, so when you are using an Apple TV, with or without Infuse, it will always be hit or miss whether the content is compatible or not.

Additionally, it is uncertain whether the Dolby Vision layer will play, fall back to HDR10, or result in a black screen.

- ( _1_) _PLEX for Apple TV and Plex with Infuse will only play profile 5 correctly if CMv2.9 is used._
- ( _2_) _Neither Infuse nor PLEX for Apple TV will deliver real Dolby Vision with Profile 7._
- ( _3_) _PLEX for Apple TV will only play profile 8 correctly if CMv2.9 is used. However, we have also received reports that in some cases, it will fall back to HDR10, or you may encounter a black screen._



To prevent your TV from incorrectly indicating that it is playing DV follow the steps provided by an Infuse user: **“With Infuse ensure you set the Extended Dolby Vision settings to Limited (prefer accuracy), convert P8 to P5 (when possible), and play other P8 as HDR (output will switch to either DoVi or HDR depending on the video)”**

Dolby Vision Versions - CMv2.9 and CMv4.0 - \[Click to show/hide\]

There are two versions of Dolby Vision, namely CMv2.9 and CMv4.0. CMv4.0 uses an improved algorithm and a superior tone curve, allowing for better mapping and more controls during the Dolby Vision trim pass process.

More info about the different Dolby Vision Versions: [Dolby Vision Versions - CMv2.9 vs. CMv4.0](https://professionalsupport.dolby.com/s/article/When-should-I-use-CM-v2-9-or-CM-v4-0-and-can-I-convert-between-them?language=en_US)

## Thanks [Permanent link](https://trash-guides.info/Sonarr/sonarr-setup-quality-profiles/\#thanks "Permanent link")

Special thanks to everyone who helped with the testing and creation of these Custom Formats.

* * *

Questions or Suggestions?

If you have questions or suggestions, click the button below to join our Discord server.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)
---

## Sonarr Naming Scheme

[Skip to content](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#recommended-naming-scheme)

[Edit this page](https://github.com/TRaSH-Guides/Guides/edit/master/docs/Sonarr/Sonarr-recommended-naming-scheme.md "Edit this page") [View source of this page](https://github.com/TRaSH-Guides/Guides/raw/master/docs/Sonarr/Sonarr-recommended-naming-scheme.md "View source of this page")

# Recommended naming scheme [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#recommended-naming-scheme "Permanent link")

On the Radarr/Sonarr Discord, people often ask:

- "What's the best way to name my files and folders?"
- "Why doesn't my naming scheme work well?"

While naming is a personal choice, adding non-recoverable information to your filenames is strongly recommended for several good reasons.

## FAQ [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#faq "Permanent link")

Why should I include extra information in filenames?

- **Easy re-imports**: If you ever need to reinstall or re-import your media in Radarr/Sonarr or media servers like Plex/Emby/Jellyfin, having all the details in the filename helps everything get imported correctly. Without this info, files might get wrongly identified as HDTV or WEB-DL quality.
- **Prevents duplicate downloads**: Radarr/Sonarr won't accidentally download the same file again.

What's non-recoverable information and can't be recovered later?

- **Quality source** (HDTV, WEB-DL, Blu-ray, Remux, etc.)
- **Release group** (the team that created the release)
- **Edition type** (Director's Cut, Theatrical, Unrated, etc.)
- **Repack/Proper status** (whether it's a fixed version)

Why is the non-recoverable information important/needed?

- **Stops download loops**: With a proper naming Radarr/Sonarr knows what you already have.
- **Quality source**: Can you tell what quality `Movie (2023).mkv` is just by looking at it? Probably not. Without this info, you can't easily upgrade or downgrade your files, and you might download the same movie or TV show again.
- **Release group**: Knowing the release group helps you identify if there are known issues with that specific release. It also helps you find extra information about hybrid releases or source materials.
- **Edition type**: Tells you if you have the Director's Cut, Theatrical version, Unrated version, etc.
- **Repack/Proper**: Shows whether you have the fixed version or the original (possibly broken) release.

Don't Plex, Emby, and Jellyfin work fine with simple names like `movie (year).ext`/`tv showname SxxExx.ext`?

- Yes, they do work with simple names. However, these media servers only care about organizing and playing your files—they don't track quality or help prevent duplicate downloads. That's what Radarr/Sonarr handles.

Why are the recommended filenames so long?

- **Complete information**: To ensure your files have all the details needed to prevent download loops after import.
- **Only used parts show up**: If your file doesn't have certain attributes (like being a repack), those parts won't appear in the filename.
- **Media servers hide filenames anyway**: Plex, Emby, and Jellyfin display movie titles and show information, not the actual filename, so the length doesn't matter for viewing.

* * *

_This naming guide was created with help from the Sonarr/Radarr support team and community feedback._

* * *

## Getting Started [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#getting-started "Permanent link")

First, you need to set up Sonarr to show all the naming options:

1. Go to **Settings** → **Media Management**
2. Enable **Show Advanced** at the top of the page

![Enable Advanced](https://trash-guides.info/Sonarr/images/sonarr-show-advanced.png)

After you click this button, you'll see all the advanced options like this:

![Unhide Advanced](https://trash-guides.info/Sonarr/images/unhide-advanced.png)

3. Enable **Rename Episodes** to see the episode naming options

![Enable Rename Episodes](https://trash-guides.info/Sonarr/images/sonarr-enable-rename.png)

4. Also make sure **Analyze video files** is enabled under **File Management**

![Enable Analyze video files](https://trash-guides.info/Sonarr/images/sonarr-enable-analyze-video-files.png)


* * *

## Episode Format [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#episode-format "Permanent link")

[Standard](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#standard)[Daily](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#daily)[Anime](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#anime)

```
{Series TitleYear} - S{season:00}E{episode:00} - {Episode CleanTitle:90} {[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Single Episode**: `The Series Title! (2010) - S01E01 - Episode Title 1 [AMZN WEBDL-1080p Proper][DV HDR10][DTS 5.1][x264]-RlsGrp`

**Multi Episode**: `The Series Title! (2010) - S01E01-E03 - Episode Title [AMZN WEBDL-1080p Proper][DV HDR10][DTS 5.1][x264]-RlsGrp`

```
{Series TitleYear} - {Air-Date} - {Episode CleanTitle:90} {[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Example**: `The Series Title! (2010) - 2013-10-30 - Episode Title 1 [AMZN WEBDL-1080p Proper][DV HDR10][DTS 5.1][x264]-RlsGrp`

```
{Series TitleYear} - S{season:00}E{episode:00} - {absolute:000} - {Episode CleanTitle:90} {[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{MediaInfo AudioLanguages}{[MediaInfo VideoDynamicRangeType]}[{Mediainfo VideoCodec }{MediaInfo VideoBitDepth}bit]{-Release Group}
```

**Single Episode**: `The Series Title! (2010) - S01E01 - 001 - Episode Title 1 [iNTERNAL HDTV-720p v2][HDR10][10bit][x264][DTS 5.1][JA]-RlsGrp`

**Multi Episode**: `The Series Title! (2010) - S01E01-E03 - 001-003 - Episode Title [iNTERNAL HDTV-720p v2][HDR10][10bit][x264][DTS 5.1][JA]-RlsGrp`

* * *

## Series Folder Format [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#series-folder-format "Permanent link")

While both IMDb and TVDb IDs are unique, TVDb can occasionally remove IDs entirely, sometimes only to be re-added with a new ID later. However, due to using TVDb as its metadata source, they can be seen as "more aligned" with Sonarr. IMDb IDs on the other hand, once present, are very accurate and rarely ever change.

[Standard Folder](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#standard-folder)[Optional Plex](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#optional-plex)[Optional Emby](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#optional-emby)[Optional Jellyfin](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#optional-jellyfin)

```
{Series TitleYear}
```

**Example**: `The Series Title! (2010)`

This naming scheme is made to be used with the [New Plex TV Series Scanner](https://forums.plex.tv/t/beta-new-plex-tv-series-scanner/696242)

[Plex Folder IMDb](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#plex-folder-imdb)[Plex Folder TVDb](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#plex-folder-tvdb)

TVDb is usually better as it guarantees a match, IMDb only gets matched if the TVDb entry has the correct IMDb ID association.

```
{Series TitleYear} {imdb-{ImdbId}}
```

**Example**: `The Series Title! (2010) {imdb-tt1520211}`

```
{Series TitleYear} {tvdb-{TvdbId}}
```

**Example**: `The Series Title! (2010) {tvdb-1520211}`

Source: [Emby Wiki/Docs](https://emby.media/support/articles/TV-Naming.html#id-tags-in-folder--file-names)

[Emby Folder IMDb](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#emby-folder-imdb)[Emby Folder TVDb](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#emby-folder-tvdb)

TVDb is usually better as it guarantees a match, IMDb only gets matched if the TVDb entry has the correct IMDb ID association.

```
{Series TitleYear} [imdb-{ImdbId}]
```

**Example**: `The Series Title! (2010) [imdb-tt1520211]`

```
{Series TitleYear} [tvdb-{TvdbId}]
```

**Example**: `The Series Title! (2010) [tvdb-1520211]`

Source: [Jellyfin Wiki/Docs](https://jellyfin.org/docs/general/server/media/shows/)

Jellyfin doesn't support IMDb IDs for shows

[Jellyfin Folder TVDb](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/#jellyfin-folder-tvdb)

```
{Series TitleYear} [tvdbid-{TvdbId}]
```

**Example**: `The Series Title! (2010) [tvdbid-1520211]`

* * *

## Season Folder Format [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#season-folder-format "Permanent link")

For this, there's only one real option to use in our opinion.

```
Season {season:00}
```

**Example**: `Season 01`

* * *

## Multi-Episode Style [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#multi-episode-style "Permanent link")

```
Prefixed Range
```

**Example**:

![results](https://trash-guides.info/Sonarr/images/results.png)

* * *

## Alternative Episode Naming Options [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#alternative-episode-naming-options "Permanent link")

These are other standard episode format naming schemes that work well. Use these if you don't like the brackets used in the main recommendations.

### Original Title [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#original-title "Permanent link")

Another option is to use `{Original Title}` instead of the recommended naming scheme above. `{Original Title}` uses the title of the release, which includes all the information from the release itself. The benefit of this naming scheme is that it prevents download loops that can happen during import when there's a mismatch between the release title and the file contents (for example, if the release title says DTS-ES but the contents are actually DTS). The downside is that you have less control over how the files are named.

If you use this alternate naming scheme, we suggest using `{Original Title}` instead of `{Original Filename}`.

Why?

The filename can be obscured or unclear, whereas the release naming is clear, especially when you use Usenet.

`{Original Title}` =\> `The.Series.Title.S01E01.Episode.Title.1080p.AMZN.WEB-DL.DDP5.1.H.264-RlsGrp`

`{Original Filename}` =\> `show episode 1-1080p` or `lchd-tkk1080p` or `t1i0p3s7i8yuti`

* * *

### P2P/Scene Naming [Permanent link](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/\#p2pscene-naming "Permanent link")

Use P2P/Scene naming if you don't like spaces and brackets in the filename. It's the closest to the P2P/scene naming scheme, except it uses the exact audio and HDR formats from the media file, where the original release or filename might be unclear.

```
{Series.CleanTitleYear}.S{season:00}E{episode:00}{.Episode.CleanTitle}{.Custom.Formats}{.Quality.Full}{.Mediainfo.AudioCodec}{.Mediainfo.AudioChannels}{.MediaInfo.VideoDynamicRangeType}{.Mediainfo.VideoCodec}{-Release Group}
```

**Single Episode**: `The.Series.Title's!.2010.S01E01.Episode.Title.1.ATVP.WEBDL-2160p.EAC3.Atmos.5.1.DV.HDR10Plus.h265-RlsGrp`

**Multi Episode**: `The.Series.Title's!.2010.S01E01-E03.Episode.ATVP.WEBDL-2160p.EAC3.Atmos.5.1.DV.HDR10Plus.h265-RlsGrp`

* * *

Questions or Suggestions?

If you have questions or suggestions, click the button below to join our Discord server.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

Back to top
---

## Sonarr Import Custom Formats

[Skip to content](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/#how-to-import-custom-formats)

[Edit this page](https://github.com/TRaSH-Guides/Guides/edit/master/docs/Sonarr/sonarr-import-custom-formats.md "Edit this page") [View source of this page](https://github.com/TRaSH-Guides/Guides/raw/master/docs/Sonarr/sonarr-import-custom-formats.md "View source of this page")

# How to import Custom Formats [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#how-to-import-custom-formats "Permanent link")

Here we will try to explain how you can manually import Custom Formats for Sonarr v4+.

Keep in mind Custom Formats are made to fine-tune your Quality Profile.

Generally, quality trumps all

## How to Copy/Paste the JSON from the site [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#how-to-copypaste-the-json-from-the-site "Permanent link")

In this example, we will use the [BR-DISK](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#br-disk) Custom Format, the one most people don't want to download anyway. And if you do, then you probably don't use any of the Starr apps or Plex, being both don't support it.

Visit the [Collection of Custom Formats](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/) and select [BR-DISK](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#br-disk) from the table.

![cf-table-select-brdisk](https://trash-guides.info/Sonarr/images/cf-table-select-brdisk.png)

### Expand the JSON for BR-DISK [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#expand-the-json-for-br-disk "Permanent link")

![cf-json-expand](https://trash-guides.info/Sonarr/images/cf-json-expand.png)

Then click the copy icon in the top right corner

![cf-json-copy-paste](https://trash-guides.info/Sonarr/images/cf-json-copy-paste.png)

## How to import a JSON Custom Format [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#how-to-import-a-json-custom-format "Permanent link")

### In Sonarr [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#in-sonarr "Permanent link")

`Settings` =\> `Custom Formats`

![cf-settings-cf](https://trash-guides.info/Sonarr/images/cf-settings-cf.png)

### Add a new Custom Format [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#add-a-new-custom-format "Permanent link")

Then click on the ![cf-plus-add-small](https://trash-guides.info/Sonarr/images/cf-plus-add-small.png) to add a new Custom Format.

### Import the Custom Format [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#import-the-custom-format "Permanent link")

Followed by the `Import` in the lower left.

![cf-import](https://trash-guides.info/Sonarr/images/cf-import.png)

### Paste the Custom Format [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#paste-the-custom-format "Permanent link")

Paste the `JSON` in the empty `Custom Format JSON` box (1) that you got from the [Custom Format Collection](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/) followed by the `Import` button (2).

![cf-import-cf](https://trash-guides.info/Sonarr/images/cf-import-cf.png)

### Save the Custom Format [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#save-the-custom-format "Permanent link")

After selecting the `Import` button you will get a screen that has all the Custom Formats variables filled in correctly,
all you need to do now is click on the `Save` button and you're done.

![cf-import-done](https://trash-guides.info/Sonarr/images/cf-import-done.png)

### Setup the scores in your Quality Profile [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#setup-the-scores-in-your-quality-profile "Permanent link")

After you've added the Custom Formats, You will need to set it up in the Quality Profile you want to use/prefer to make use of the Custom Formats.
How this is done is explained [HERE](https://trash-guides.info/Sonarr/sonarr-setup-custom-formats/#basics)

* * *

## Start adding other Custom Formats wisely [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#start-adding-other-custom-formats-wisely "Permanent link")

Start adding more Custom Formats wisely, **Don't add all the available Custom Formats!!!**

Check out the [How to set up Custom Formats](https://trash-guides.info/Sonarr/sonarr-setup-custom-formats/) where we will explain how to make the most use of custom formats and show some personal examples that I'm using. You can use these examples to get an idea of how to set up yours.

### Guide sync tool [Permanent link](https://trash-guides.info/Sonarr/sonarr-import-custom-formats/\#guide-sync-tool "Permanent link")

You can also use a [Guide sync tool](https://trash-guides.info/Guide-Sync/) to sync the Custom Formats or even the complete quality profile(s).

* * *

Questions or Suggestions?

If you have questions or suggestions, click the button below to join our Discord server.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

Back to top
---

## Radarr Quality Settings (File Size)

[Skip to content](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/#quality-settings-file-size)

[Edit this page](https://github.com/TRaSH-Guides/Guides/edit/master/docs/Radarr/Radarr-Quality-Settings-File-Size.md "Edit this page") [View source of this page](https://github.com/TRaSH-Guides/Guides/raw/master/docs/Radarr/Radarr-Quality-Settings-File-Size.md "View source of this page")

# Quality Settings (File Size) [Permanent link](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/\#quality-settings-file-size "Permanent link")

On the Radarr/Sonarr Discord people often ask,

- “What's the best quality size settings to use?”
- “Why are the ones from the TRaSH Guides so different from the default settings?”

Even though it is a personal preference, we will show you some recommendations to prevent low-quality or fake releases.

## FAQ [Permanent link](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/\#faq "Permanent link")

Why do i only see sizes starting from HDTV720p and up?

- Watching content below 720p on a big screen can result in a blurry and pixelated image, making it difficult to see details and enjoy the true quality of the content. Additionally, lower-resolution videos may not fill the entire screen, leading to a less immersive viewing experience. Investing in higher-quality content ensures that you are getting the best possible picture and sound quality for your viewing pleasure.

Why are some sizes set to max?

- These guides are created to achieve the highest possible quality based on the quality profiles provided.

Why is there a difference between regular movies/tv shows and anime/animated/cartoons ?

- Regular movies and TV shows are set up more strictly to prevent low-quality and fake releases, whereas anime, animated series, and cartoons are set up wide open.

When I set Bluray to MAX size I often get ISO's/ Bluray folder structure.

- You have probably configured your Quality Profiles incorrectly by enabling BR-DISK without adding the recommended Custom Format for Radarr to block/ignore [BR-DISK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#br-disk). For Sonarr, you can use the following to block/ignore [BR-DISK](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/#br-disk).

Some movies or episodes may not be grabbed due to these settings.

If you notice that some movies or episodes are not being grabbed due to size settings, you can provide proof with a screenshot showing the error that appears during an interactive search (excluding the indexer or tracker if you prefer).

- We will only consider changes for international releases; no multi-language or dubbed releases will be accepted.
- We will not accept incorrectly labeled source releases such as those from MeGusta, they need to properly name their content first.
- Changes for micro-sized releases will not be accepted.
- Documentaries and cartoons are typically much smaller, so we may not make edits to those either.

These quality file size settings have been created and tested with information gathered from release comparisons from various sources and information provided by the community.

* * *

## Radarr Quality Definitions [Permanent link](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/\#radarr-quality-definitions "Permanent link")

Ensure that 'Show Advanced' is enabled if you don't see the option to enter scores under the Quality settings.

After setting the Max Size, set the 'Preferred' score as high as possible. You can accomplish this in one of two ways.

\- 1\. Move the slider to the farthest right.

\- 2\. Enter the maximum score.

In both cases, it will automatically adjust to the highest possible score, which will be slightly below the Max Size setting.

2000 is the displayed value for Unlimited

[Standard](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/#standard)[Anime/Animated/Cartoons](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/#animeanimatedcartoons)

| Quality | Minimum (MB/min) | Preferred (MB/min) | Maximum (MB/min) |
| --- | --- | --- | --- |
| HDTV-720p | 17.1 | 1999 | 2000 |
| WEBDL-720p | 12.5 | 1999 | 2000 |
| WEBRip-720p | 12.5 | 1999 | 2000 |
| Bluray-720p | 25.7 | 1999 | 2000 |
| HDTV-1080p | 33.8 | 1999 | 2000 |
| WEBDL-1080p | 12.5 | 1999 | 2000 |
| WEBRip-1080p | 12.5 | 1999 | 2000 |
| Bluray-1080p | 50.8 | 1999 | 2000 |
| Remux-1080p | 102 | 1999 | 2000 |
| HDTV-2160p | 85 | 1999 | 2000 |
| WEBDL-2160p | 34.5 | 1999 | 2000 |
| WEBRip-2160p | 34.5 | 1999 | 2000 |
| Bluray-2160p | 102 | 1999 | 2000 |
| Remux-2160p | 187.4 | 1999 | 2000 |

| Quality | Minimum (MB/min) | Preferred (MB/min) | Maximum (MB/min) |
| --- | --- | --- | --- |
| SDTV | 5 | 1999 | 2000 |
| DVD | 5 | 1999 | 2000 |
| DVD-R | 5 | 1999 | 2000 |
| WEBDL-480p | 5 | 1999 | 2000 |
| WEBRip-480p | 5 | 1999 | 2000 |
| Bluray-480p | 5 | 1999 | 2000 |
| Bluray-576p | 5 | 1999 | 2000 |
| HDTV-720p | 5 | 1999 | 2000 |
| WEBDL-720p | 5 | 1999 | 2000 |
| WEBRip-720p | 5 | 1999 | 2000 |
| Bluray-720p | 5 | 1999 | 2000 |
| HDTV-1080p | 5 | 1999 | 2000 |
| WEBDL-1080p | 5 | 1999 | 2000 |
| WEBRip-1080p | 5 | 1999 | 2000 |
| Bluray-1080p | 5 | 1999 | 2000 |
| Remux-1080p | 5 | 1999 | 2000 |
| HDTV-2160p | 5 | 1999 | 2000 |
| WEBDL-2160p | 5 | 1999 | 2000 |
| WEBRip-2160p | 5 | 1999 | 2000 |
| Bluray-2160p | 5 | 1999 | 2000 |
| Remux-2160p | 5 | 1999 | 2000 |

* * *

Questions or Suggestions?

If you have questions or suggestions, click the button below to join our Discord server.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

Back to top
---

## Radarr Quality Profiles Setup

[Skip to content](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/#how-to-set-up-quality-profiles)

[Edit this page](https://github.com/TRaSH-Guides/Guides/edit/master/docs/Radarr/radarr-setup-quality-profiles.md "Edit this page") [View source of this page](https://github.com/TRaSH-Guides/Guides/raw/master/docs/Radarr/radarr-setup-quality-profiles.md "View source of this page")

# How to set up Quality Profiles [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#how-to-set-up-quality-profiles "Permanent link")

_aka How to set up Custom Formats_

So what's the best way to set up the Custom Formats and which ones to use with which scores to set up your quality profiles?

There isn't a "best" setup, it depends on your media setup (hardware devices) and your personal preferences.

Some prefer high-quality audio (HD Audio), others high-quality video. Many prefer both.

Here we will try to explain how to make the most of Custom Formats to help you set up your quality profiles for your personal preferences.

- We've also created an Excel sheet with several tested [media player devices](https://trash-guides.info/Plex/what-does-my-media-player-support) to display what formats and capabilities they support, sourced from information provided by our community. We hope this Excel sheet will be a helpful resource for those looking for a reliable media player device and will help you choose the appropriate quality profile.

* * *

## Basics [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#basics "Permanent link")

After you've added the Custom Formats, as explained in [How to import Custom Formats](https://trash-guides.info/Radarr/Radarr-import-custom-formats/).
You will need to set it up in the quality Profile you want to use/prefer to make use of the Custom Formats.

You can also use a [Guide sync tool](https://trash-guides.info/Guide-Sync/) to sync the Custom Formats or even the complete quality profile(s).

`Settings` =\> `Profiles`

![!cf-settings-profiles](https://trash-guides.info/Radarr/images/cf-settings-profiles.png)

Radarr Custom Formats can be set per profile and isn't global

Select the profile that you want to use/prefer.

![!cf-quality-profiles](https://trash-guides.info/Radarr/images/cf-quality-profiles.png)

![!cf-profile-selected](https://trash-guides.info/Radarr/images/cf-profile-selected.png)

1. Profile name.
2. Allow upgrades. Radarr will stop upgrading quality once (3) is met.
3. Upgrade until the selected quality.
4. The `Minimum Custom Format Score` that is allowed to download. [More Info](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/#minimum-custom-format-score)
5. Keep upgrading Custom Format until this score is reached. (setting this to `0` means no upgrades will happen based on Custom Formats)
6. Your preferred language profile for your releases. (Original is recommended)

At the bottom, in your chosen profile, you will see the added Custom Formats where you can start setting up the scores.

Screenshot example - \[Click to show/hide\]

![!cf-quality-profile-cf](https://trash-guides.info/Radarr/images/cf-quality-profile-cf.png)

Warning

These screenshots are just examples to show you how it should look and where you need to place the data that you need to add, they aren't always a 100% reflection of the actual data and are not 100% up to date with the actual data you need to add.

- Always follow the data described in the guide.
- If you have any questions or aren't sure just click the chat badge to join the Discord Channel where you can ask your questions directly.

Keep in mind Custom Formats are made to fine-tune your Quality Profile.

Generally, quality trumps all

Custom formats are controlled by Quality Profiles.

- The Upgrade Until score prevents upgrading once a release with this desired score has been downloaded.
- A score of 0 results in the custom format being informational only.
- The Minimum score requires releases to reach this threshold otherwise they will be rejected.
- Custom formats that match with undesirable attributes should be given a negative score to lower their appeal.
- Outright rejections should be given a negative score low enough that even if all of the other formats with positive scores were added, the score would still fall below the minimum.

* * *

### Radarr current logic [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#radarr-current-logic "Permanent link")

Radarr current logic - \[Click to show/hide\]

As of 2021-11-06 the logic is as follows:

The Current logic on how downloads are compared is **Quality Trumps All**![‼](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/203c.svg)

1. Quality
2. Custom Format Score
3. Protocol
4. Indexer Priority
5. Indexer Flags
6. Seeds/Peers (If Torrent)
7. Age (If Usenet)
8. Size

[Source: Wiki Servarr](https://wiki.servarr.com/radarr/faq#how-are-possible-downloads-compared)

REPACKS and PROPERs are v2 of Qualities and thus rank above a non-repack of the same quality.

`Settings` =\> `Media Management` =\> `File Management` =\> `Proper & Repacks` Change to `Do Not Prefer` and use the [Repack/Proper Custom Format](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper)

* * *

## Which Quality Profile should you choose [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#which-quality-profile-should-you-choose "Permanent link")

Which Quality Profile should you choose - \[Click to show/hide\]

The guides and profiles are built for high-quality sources, specifically those based on formats like WEB-DL, Blu-ray, or Remuxes. These sources prioritize excellent video and audio quality, not small file sizes.

For example, a high-quality, extended version of _The Lord of the Rings_ cannot be compressed to a small size, such as 2-4 GB, without significant quality loss.

The size of a media file is directly related to the quality of the source (WEB-DL, Blu-ray, or Remuxes) and the running time. If you want the highest quality, you shouldn't worry about file size.

Many people think that TRaSH Guides dislikes x265 releases. **We DO NOT.** We simply dislike the reasoning behind why most x265 groups and users use them. More info [HERE](https://trash-guides.info/Misc/x265-4k/).

## Choose a profile based on:

**Hardware compatibility**

- Ensure BOTH your TV and media player support the formats you select. For example, if you want to play media in Dolby Vision (DV) but have a Samsung TV, it will ONLY play HDR10 (this is a Samsung TV limitation).

**Device capabilities**

- Avoid playing high bitrate media on underpowered devices (like smart TV apps).

**Network limitations**

- Consider bandwidth constraints, such as WiFi connections that may be unreliable or cause buffering issues due to inconsistent speeds
- Account for built-in network ports on TVs that are often limited to 100 Mbps

**Transcoding requirements**

- If you continually need to transcode video content, you've probably chosen the wrong profile. Consider selecting a different profile that allows direct playback without video transcoding.
- Audio transcoding has minimal resource impact, so it shouldn't be a major concern unless you're running your media server on a low-powered device.

These are all factors to consider when choosing your profile.

* * *

If you're unsure or have questions, don't hesitate to ask for help on Discord.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

* * *

## TRaSH Quality Profiles [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#trash-quality-profiles "Permanent link")

The following Quality Profiles can be combined into a single Quality Profile if you, for example, want to be able to upgrade from 1080p to 4K/2160p when and if it becomes available _AFTER_ the 1080p release is made.

### HD Bluray + WEB [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#hd-bluray-web "Permanent link")

If you prefer High-Quality HD Encodes (Bluray-720p/1080p)

- _Size: 6-15 GB for a Bluray-1080p depending on the running time._

I suggest to follow the following Guides first.

- [Quality Settings (File Size)](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/).
- [Recommended naming scheme](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/).

For this Quality Profile we're going to make use of the following Custom Formats with the scores given in the table.

Attention

All the used scores and combinations of Custom Formats in this Guide are tested to get the desired results while preventing download loops as much as possible.

From experience, most of the time when people change scores or leave out certain CFs that work together - they end up with undesired results.

If you're unsure or have questions, do not hesitate to ask for help on Discord

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

**The following Custom Formats are required:**

HQ Release Groups - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [HD Bluray Tier 01](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hd-bluray-tier-01) | 1800 | ed27ebfef2f323e964fb1f61391bcb35 |
| [HD Bluray Tier 02](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hd-bluray-tier-02) | 1750 | c20c8647f2746a1f4c4262b0fbbeeeae |
| [HD Bluray Tier 03](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hd-bluray-tier-03) | 1700 | 5608c71bcebba0a5e666223bae8c9227 |
| [WEB Tier 01](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-01) | 1700 | c20f169ef63c5f40c2def54abaf4438e |
| [WEB Tier 02](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-02) | 1650 | 403816d65392c79236dcb6dd591aeda4 |
| [WEB Tier 03](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-03) | 1600 | af94e0fe497124d1f9ce732069ec8c3b |

Miscellaneous (Required) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Repack/Proper](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper) | 5 | e7718d7a3ce595f289bfee26adc178f5 |
| [Repack2](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repack2) | 6 | ae43b294509409a6a13919dedd4764c4 |
| [Repack3](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repack3) | 7 | 5caaaa1c08c1742aa4342d8c4cc463f2 |

Proper and Repacks - \[Click to show/hide\]

We also suggest changing the Propers and Repacks settings in Radarr.

`Media Management` =\> `File Management` to `Do Not Prefer` and use the [Repack/Proper](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper) Custom Format.

![!cf-mm-propers-repacks-disable](https://trash-guides.info/Radarr/images/cf-mm-propers-repacks-disable.png)

This way you make sure the Custom Formats preferences will be used and not ignored.

Unwanted - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [BR-DISK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#br-disk) | -10000 | ed38b889b31be83fda192888e2286d83 |
| [Generated Dynamic HDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#generated-dynamic-hdr) | -10000 | e6886871085226c3da1830830146846c |
| [LQ](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq) | -10000 | 90a6f9a284dff5103f6346090e6280c8 |
| [LQ (Release Title)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq-release-title) | -10000 | e204b80c87be9497a8a6eaff48f72905 |
| [x265 (HD)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-hd)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | dc98083864ea246d05a42df0d05f81cc |
| [3D](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#3d) | -10000 | b8cd450cbfa689c0259a01d9e29ba3d6 |
| [Extras](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#extras) | -10000 | 0a3f082873eb454bde444150b70253cc |
| [Sing-Along Versions](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sing-along-versions) | -10000 | 712d74cd88bceb883ee32f773656b1f5 |
| [AV1](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#av1) | -10000 | cae4ca30163749b891686f95532519bd |

* * *

Breakdown and Why

- **BR-DISK :** This is a custom format to help Radarr recognize & ignore BR-DISK (ISO's and Blu-ray folder structure) in addition to the standard BR-DISK quality.
- **Generated Dynamic HDR :** A collection of groups who are known to generate their own dynamic HDR metadata - Dolby Vision and/or HDR10+.
- **LQ:** A collection of known low-quality groups that are often banned from the top trackers due to their releases' lack of quality or other reasons.
- **LQ (Release Title):** A collection of terms seen in the titles of low-quality releases that are not captured by using a release group name.
- **x265 (HD):** This blocks 720/1080p (HD) releases that are encoded in x265.



If you have also added [x265 (no HDR/DV)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-no-hdrdv) to your Radarr,

then one of them should be scored as `0` in your quality profile.

- **3D:** Is 3D still a thing for home use ?

- **Extras:** Blocks releases that only contain extras
- **Sing-Along Versions:** Blocks releases that contain hardcoded sing-along lyrics for musical sections
- **AV1:** This blocks all releases encoded in AV1.

**AV1**



AV1 encodes are currently targeting small file sizes, rather than good visual quality.
  - This is a new codec and you need modern devices that support it.
  - We also had reports of playback/transcoding issues.
  - No main group is actually using it (yet).
  - It's better to ignore this new codec to prevent compatibility issues

General Streaming Services - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [AMZN](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#amzn) | 0 | b3b3a6ac74ecbd56bcdbefa4799fb9df |
| [ATV](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atv) | 0 | df13ed57843877b21ad969184ab6888f |
| [ATVP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atvp) | 0 | 40e9380490e748672c2522eaaeb692f7 |
| [BCORE](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#bcore) | 15 | cc5e51a9e85a6296ceefe097a77f12f4 |
| [CRiT](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#crit) | 20 | 16622a6911d1ab5d5b8b713d5b0036d4 |
| [DSNP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dsnp) | 0 | 84272245b2988854bfb76a16e60baea5 |
| [HBO](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hbo) | 0 | 509e5f41146e278f9eab1ddaceb34515 |
| [HMAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hmax) | 0 | 5763d1b0ce84aff3b21038eea8e9b8ad |
| [Hulu](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hulu) | 0 | 526d445d4c16214309f0fd2b3be18a89 |
| [iT](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#it) | 0 | e0ec9672be6cac914ffad34a6b077209 |
| [MAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#max) | 0 | 6a061313d22e51e0f25b7cd4dc065233 |
| [MA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ma) | 20 | 2a6039655313bf5dab1e43523b62c374 |
| [NF](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#nf) | 0 | 170b1d363bd8516fbf3a3eb05d4faff6 |
| [PMTP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pmtp) | 0 | e36a0ba1bc902b26ee40818a1d59b8bd |
| [PCOK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pcok) | 0 | c9fd353f8f5f1baf56dc601c4cb29920 |
| [PLAY](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#play) | 0 | 350e9170619683a55cb9191d0b1ababa |
| [ROKU](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#roku) | 0 | 44c2b54d7c81c1a442a8b2cabeaef54f |
| [STAN](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#stan) | 0 | c2863d2a50c9acad1fb50e53ece60817 |

* * *

Breakdown and Why

- The reason why these Custom Formats have a score of `0` is because they are mainly used for the naming scheme and other variables should decide for movies if a certain release if preferred.
- `BCore`, `CRiT` and `MA` are the only ones with a score because of their better source material, or higher bitrate and quality compared to other streaming services.

**The following Custom Formats are optional:**

Miscellaneous (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Bad Dual Groups](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#bad-dual-groups) | -10000 | b6832f586342ef70d9c128d40c07b872 |
| [Black and White Editions](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#black-and-white-editions) | -10000 | cc444569854e9de0b084ab2b8b1532b2 |
| [No-RlsGroup](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#no-rlsgroup) | -10000 | ae9b7c9ebde1f3bd336a8cbd1ec4c5e5 |
| [Obfuscated](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#obfuscated) | -10000 | 7357cf5161efbf8c4d5d0c30b4815ee2 |
| [Retags](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#retags) | -10000 | 5c44f52a8714fdd79bb4d98e2673be1f |
| [Scene](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#scene) | -10000 | f537cf427b64c38c8e36298f657e4828 |

* * *

Breakdown and Why

- **Bad Dual Groups:** \[ _Optional_\] These groups take the original release and add their own language track (e.g. AAC 2.0 Portuguese) as the first track. Afterward, FFprobe would determine that the media file is Portuguese. It's a common rule that you only add the best audio as the main track.
Also they often even rename the release name into Portuguese.
- **Black and White Editions:** \[ _Optional_\] Some movies get an additional release version in monochrome/black and white. This custom format matches some of the more common occurrences of these.
- **No-RlsGroup:** \[ _Optional_\] Some indexers strip out the release group which could result in LQ groups being scored incorrectly. For example, a lot of EVO releases end up with a stripped group name. These releases would appear as "upgrades" and could end up getting a decent score after other CFs are scored.
- **Obfuscated:** \[ _Optional_\] Use these only if you wish to avoid renamed releases.
- **Retags:** \[ _Optional_\] Use this if you want to avoid retagged releases. Retagged releases often are not consistent with the quality of the original group's release.
- **Scene:** \[ _Optional_\] Use this only if you want to avoid SCENE releases.

Movie Versions (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Remaster](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remaster) | 25 | 570bc9ebecd92723d2d21500f4be314c |
| [4K Remaster](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#4k-remaster) | 25 | eca37840c13c6ef2dd0262b141a5482f |
| [Criterion Collection](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#criterion-collection) | 25 | e0c07d59beb37348e975a930d5e50319 |
| [Masters of Cinema](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#masters-of-cinema) | 25 | 9d27d9d2181838f76dee150882bdc58c |
| [Vinegar Syndrome](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#vinegar-syndrome) | 25 | db9b4c4b53d312a3ca5f1378f6440fc9 |
| [Special Edition](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#special-edition) | 125 | 957d0f44b592285f26449575e8b1167e |
| [IMAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#imax) | 800 | eecf3a857724171f968a66cb5719e152 |
| [IMAX Enhanced](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#imax-enhanced) | 800 | 9f6cbff8cfe4ebbc1bde14c7b7bec0de |

IMAX Enhanced

IMAX Enhanced: Get More Picture Instead of Black Bars.

IMAX Enhanced exclusive expanded aspect ratio is 1:90:1, which offers up to 26% more picture for select sequences, meaning more of the action is visible on screen.

If you don't prefer `IMAX Enhanced` then don't add it or use a score of `0`

Note: The `Audio Formats` Custom Formats aren't used in the HD Bluray + WEB profile, as HD Bluray Encodes do not often come with HD audio. If you want HD audio, we would suggest going with a Remux or UHD Encode.

Use the following main settings in your profile.

![HD Bluray + WEB](https://trash-guides.info/Radarr/images/qp-bluray-webdl.png)

Make sure you don't check the BR-DISK.

The reason why we didn't select the WEB-DL 720p is that you will hardly find any releases that aren't done as 1080p WEB-DL.

Info

The order listed in the profile matters even if a quality is not checked, for example if you have a 1080p version but wanted the SD version, Radarr will reject all SD results because 1080p is listed higher than SD even though 1080p was not checked.

Qualities at the top of the list will appear first in manual searches.

- Qualities higher in the list are more preferred even if not checked.
- Qualities within the same group are equal.
- Only checked qualities are wanted.

This is why it's recommended to move the selected quality to the top of the list.

[Source: Wiki Servarr](https://wiki.servarr.com/en/radarr/settings#quality-profiles)

Workflow Logic - \[Click to show/hide\]

- When the WEB-1080p is released it will download the WEB-1080p. (streaming services)
- When the Bluray-1080p is released it will upgrade to the Bluray-1080p.
- The downloaded media will be upgraded to any of the added Custom Formats until a score of `10000`.

So why such a ridiculously high `Upgrade Until Custom` and not a score of `100`?

We're too lazy to calculate the maximum for every Quality Profile we provide, and we want it to upgrade to the highest possible score anyway to result in the highest possible quality release.

* * *

### UHD Bluray + WEB [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#uhd-bluray-web "Permanent link")

If you prefer High-Quality UHD Encodes (Bluray-2160p)

- _Size: 20-60 GB for a Bluray-2160p depending on the running time._

I suggest to follow the following Guides first.

- [Quality Settings (File Size)](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/).
- [Recommended naming scheme](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/).

For this Quality Profile we're going to make use of the following Custom Formats with the scores given in the table.

Attention

All the used scores and combinations of Custom Formats in this Guide are tested to get the desired results while preventing download loops as much as possible.

From experience, most of the time when people change scores or leave out certain CFs that work together - they end up with undesired results.

If you're unsure or have questions, do not hesitate to ask for help on Discord

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

**The following Custom Formats are required:**

HDR Formats - \[Click to show/hide\]

**HDR**

All users with HDR-capable equipment should add the HDR custom format.

_This is a catch-all custom format for all HDR-related formats, including those with HDR10 or HDR10+ fallback capabilities, such as DV HDR10 or DV HDR10+._

* * *

**DV Boost**

If you prefer Dolby Vision and have compatible equipment, add the DV Boost custom format. This custom format prioritizes releases containing Dolby Vision over standard HDR releases.

_This custom format accepts DV Profile 5 and also upgrades from DV/HDR10/HDR10+ to DV HDR10 or DV HDR10+._

**HDR10+ Boost**

If you prefer HDR10+ releases and have compatible equipment, add the HDR10+ Boost custom format. This custom format prioritizes releases containing HDR10+ over standard HDR releases.

_This custom format also boosts DV HDR10+ releases if you prefer them over DV HDR10._

If you prefer both Dolby Vision and HDR10+, add both boost custom formats!

* * *

**DV (w/o HDR fallback)**

If **NOT** every device accessing your media server supports Dolby Vision, add the DV (w/o HDR fallback) custom format to ensure maximum compatibility with your setup. This prevents playback issues on devices that don't fully support Dolby Vision.

_This also applies to Dolby Vision releases without HDR10 fallback (Profile 5)._

* * *

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [HDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hdr) | 500 | 493b6d1dbec3c3364c59d7607f7e3405 |
| [DV Boost](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dv-boost) | 1000 | b337d6812e06c200ec9a2d3cfa9d20a7 |
| [HDR10+ Boost](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hdr10plus-boost) | 100 | caa37d0df9c348912df1fb1d88f9273a |
| [DV (w/o HDR fallback)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dv-wo-hdr-fallback) | -10000 | 923b6abef9b17f937fab56cfcf89e1f1 |

* * *

Why am I getting purple or green colors? - \[Click to show/hide\]

Why am I getting purple or green colors?

There are several possible reasons why your TV would show purple or green colors when playing Dolby Vision content.

1. **Unsupported Hardware**: Your TV or hardware media player device (Roku, Apple TV, etc) doesn't support Dolby Vision or your hardware media player device doesn't support all the Dolby Vision Profiles. As a result, the device might struggle to produce accurate colors, leading to a purple or green tint.

2. **Incorrect Display Settings**: Dolby Vision content often requires specific settings to be enabled on your TV or display device in order to deliver the intended visual experience. If these settings are not configured properly, it can result in the device showing distorted colors (including purple or green hues).

3. **HDMI Compatibility Issues**: Sometimes, HDMI cables or ports may not be fully compatible with Dolby Vision. If the media player device is not recognizing the Dolby Vision signal properly, it may fail to process the content correctly, resulting in abnormal color rendering.


To resolve the purple or green color issues when playing Dolby Vision content, you can try the following troubleshooting steps:

1. Ensure your TV or hardware media player device is Dolby Vision compatible and up-to-date with the latest firmware.
2. Verify that your TV or display device is set up correctly and has the necessary Dolby Vision settings enabled.
3. Check the HDMI cables and ensure they can transmit Dolby Vision signals.

Dolby Vision Profiles - \[Click to show/hide\]

Dolby Vision Profiles

- **Profile 5**( _1_) \- This is what comes with WEB-DL Dolby Vision releases without HDR10 fallback.

( _Incompatible devices will playback with blown out pinks and greens_)
- **Profile 7**( _2_) \- This is what comes with UHD Bluray Remuxes and UHD BluRay releases.

_These files will play on an Nvidia Shield Pro (2019), but on most other players will revert to the HDR10 fallback._
- **Profile 8**( _3_) \- This is what comes with (Hybrid) WEB-DL (HULU), Hybrid UHD Remux, and UHD BluRay releases (all of which have HDR10 fallback).

_This works with several mainstream media players._


* * *

Apple TV Dolby Vision Limitations - \[Click to show/hide\]

Plex for Apple TV is only capable of playing Dolby Vision Profiles 5 and 8 correctly if CMv2.9 is being used.

Infuse 7.7.2+ offers expanded support for Dolby Vision Profile 8, including files containing CMv4.0 metadata, samples that were previously playing with a black screen, falling back to HDR10, or various other playback issues. [SOURCE](https://community.firecore.com/t/infuse-7-7-2-now-available/48208)

The Dolby Vision Profile and Version of a media file cannot be determined by automation software before downloading it, so when you are using an Apple TV, with or without Infuse, it will always be hit or miss whether the content is compatible or not.

Additionally, it is uncertain whether the Dolby Vision layer will play, fall back to HDR10, or result in a black screen.

- ( _1_) _PLEX for Apple TV and Plex with Infuse will only play profile 5 correctly if CMv2.9 is used._
- ( _2_) _Neither Infuse nor PLEX for Apple TV will deliver real Dolby Vision with Profile 7._
- ( _3_) _PLEX for Apple TV will only play profile 8 correctly if CMv2.9 is used. However, we have also received reports that in some cases, it will fall back to HDR10, or you may encounter a black screen._



To prevent your TV from incorrectly indicating that it is playing DV follow the steps provided by an Infuse user: **“With Infuse ensure you set the Extended Dolby Vision settings to Limited (prefer accuracy), convert P8 to P5 (when possible), and play other P8 as HDR (output will switch to either DoVi or HDR depending on the video)”**

Dolby Vision Versions - CMv2.9 and CMv4.0 - \[Click to show/hide\]

There are two versions of Dolby Vision, namely CMv2.9 and CMv4.0. CMv4.0 uses an improved algorithm and a superior tone curve, allowing for better mapping and more controls during the Dolby Vision trim pass process.

More info about the different Dolby Vision Versions: [Dolby Vision Versions - CMv2.9 vs. CMv4.0](https://professionalsupport.dolby.com/s/article/When-should-I-use-CM-v2-9-or-CM-v4-0-and-can-I-convert-between-them?language=en_US)

HQ Release Groups - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [UHD Bluray Tier 01](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#uhd-bluray-tier-01) | 1800 | 4d74ac4c4db0b64bff6ce0cffef99bf0 |
| [UHD Bluray Tier 02](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#uhd-bluray-tier-02) | 1750 | a58f517a70193f8e578056642178419d |
| [UHD Bluray Tier 03](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#uhd-bluray-tier-03) | 1700 | e71939fae578037e7aed3ee219bbe7c1 |
| [WEB Tier 01](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-01) | 1700 | c20f169ef63c5f40c2def54abaf4438e |
| [WEB Tier 02](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-02) | 1650 | 403816d65392c79236dcb6dd591aeda4 |
| [WEB Tier 03](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-03) | 1600 | af94e0fe497124d1f9ce732069ec8c3b |

Miscellaneous (Required) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Repack/Proper](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper) | 5 | e7718d7a3ce595f289bfee26adc178f5 |
| [Repack2](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repack2) | 6 | ae43b294509409a6a13919dedd4764c4 |
| [Repack3](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repack3) | 7 | 5caaaa1c08c1742aa4342d8c4cc463f2 |

Proper and Repacks - \[Click to show/hide\]

We also suggest changing the Propers and Repacks settings in Radarr.

`Media Management` =\> `File Management` to `Do Not Prefer` and use the [Repack/Proper](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper) Custom Format.

![!cf-mm-propers-repacks-disable](https://trash-guides.info/Radarr/images/cf-mm-propers-repacks-disable.png)

This way you make sure the Custom Formats preferences will be used and not ignored.

Unwanted - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [BR-DISK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#br-disk) | -10000 | ed38b889b31be83fda192888e2286d83 |
| [Generated Dynamic HDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#generated-dynamic-hdr) | -10000 | e6886871085226c3da1830830146846c |
| [LQ](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq) | -10000 | 90a6f9a284dff5103f6346090e6280c8 |
| [LQ (Release Title)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq-release-title) | -10000 | e204b80c87be9497a8a6eaff48f72905 |
| [x265 (HD)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-hd)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | dc98083864ea246d05a42df0d05f81cc |
| [3D](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#3d) | -10000 | b8cd450cbfa689c0259a01d9e29ba3d6 |
| [Upscaled](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#upscaled) | -10000 | bfd8eb01832d646a0a89c4deb46f8564 |
| [Extras](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#extras) | -10000 | 0a3f082873eb454bde444150b70253cc |
| [Sing-Along Versions](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sing-along-versions) | -10000 | 712d74cd88bceb883ee32f773656b1f5 |
| [AV1](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#av1) | -10000 | cae4ca30163749b891686f95532519bd |

* * *

Breakdown and Why

- **BR-DISK :** This is a custom format to help Radarr recognize & ignore BR-DISK (ISO's and Blu-ray folder structure) in addition to the standard BR-DISK quality.
- **Generated Dynamic HDR :** A collection of groups who are known to generate their own dynamic HDR metadata - Dolby Vision and/or HDR10+.
- **LQ:** A collection of known low-quality groups that are often banned from the top trackers due to their releases' lack of quality or other reasons.
- **LQ (Release Title):** A collection of terms seen in the titles of low-quality releases that are not captured by using a release group name.
- **x265 (HD):** This blocks 720/1080p (HD) releases that are encoded in x265.



If you have also added [x265 (no HDR/DV)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-no-hdrdv) to your Radarr,

then one of them should be scored as `0` in your quality profile.

- **3D:** Is 3D still a thing for home use ?

- **Upscaled:** A custom format to prevent Radarr from grabbing upscaled releases.
- **Extras:** Blocks releases that only contain extras
- **Sing-Along Versions:** Blocks releases that contain hardcoded sing-along lyrics for musical sections
- **AV1:** This blocks all releases encoded in AV1.

**AV1**



AV1 encodes are currently targeting small file sizes, rather than good visual quality.
  - This is a new codec and you need modern devices that support it.
  - We also had reports of playback/transcoding issues.
  - No main group is actually using it (yet).
  - It's better to ignore this new codec to prevent compatibility issues

General Streaming Services - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [AMZN](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#amzn) | 0 | b3b3a6ac74ecbd56bcdbefa4799fb9df |
| [ATV](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atv) | 0 | df13ed57843877b21ad969184ab6888f |
| [ATVP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atvp) | 0 | 40e9380490e748672c2522eaaeb692f7 |
| [BCORE](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#bcore) | 15 | cc5e51a9e85a6296ceefe097a77f12f4 |
| [CRiT](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#crit) | 20 | 16622a6911d1ab5d5b8b713d5b0036d4 |
| [DSNP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dsnp) | 0 | 84272245b2988854bfb76a16e60baea5 |
| [HBO](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hbo) | 0 | 509e5f41146e278f9eab1ddaceb34515 |
| [HMAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hmax) | 0 | 5763d1b0ce84aff3b21038eea8e9b8ad |
| [Hulu](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hulu) | 0 | 526d445d4c16214309f0fd2b3be18a89 |
| [iT](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#it) | 0 | e0ec9672be6cac914ffad34a6b077209 |
| [MAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#max) | 0 | 6a061313d22e51e0f25b7cd4dc065233 |
| [MA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ma) | 20 | 2a6039655313bf5dab1e43523b62c374 |
| [NF](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#nf) | 0 | 170b1d363bd8516fbf3a3eb05d4faff6 |
| [PMTP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pmtp) | 0 | e36a0ba1bc902b26ee40818a1d59b8bd |
| [PCOK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pcok) | 0 | c9fd353f8f5f1baf56dc601c4cb29920 |
| [PLAY](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#play) | 0 | 350e9170619683a55cb9191d0b1ababa |
| [ROKU](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#roku) | 0 | 44c2b54d7c81c1a442a8b2cabeaef54f |
| [STAN](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#stan) | 0 | c2863d2a50c9acad1fb50e53ece60817 |

* * *

Breakdown and Why

- The reason why these Custom Formats have a score of `0` is because they are mainly used for the naming scheme and other variables should decide for movies if a certain release if preferred.
- `BCore`, `CRiT` and `MA` are the only ones with a score because of their better source material, or higher bitrate and quality compared to other streaming services.

**The following Custom Formats are optional:**

Audio (Optional) - \[Click to show/hide\]

**Why should I choose All Audio formats?**

- You have a hardware media player device and an audio setup that supports **ALL** HD Audio (TrueHD, DTS-X, DTS-HD, etc).



Apple TV doesn't passthrough HD-audio, If you use infuse, it's still limited!

Please check `I have an Apple TV`

- You've chosen a profile that includes Audio Formats. You should use all the Audio formats with Remuxes/UHD Encodes.

- You should add **ALL** the Audio formats - don't leave any of them out!
- Audio transcoding has a low impact on your server. If your server can't handle audio transcoding, consider choosing another quality profile.

I have an Apple TV - \[Click to show/hide\]

![!Audio Formats Flowchart](https://trash-guides.info/Radarr/images/plex-audio-atv.png)

- Passthrough: The preferred method if you have an audio setup (AVR/Soundbar). This mode sends the audio signals without any alteration or processing.
- Direct Play: The client natively supports the container, video, and audio streams. The Plex server sends the media file as-is to the client, using very little CPU power.
- Transcode: The client does not support the video and/or audio streams. The Plex server re-encodes the video, audio, or both into a compatible format. Transcoding video uses much CPU power, but transcoding audio uses little to moderate CPU power.
- Decodes: Decompresses the audio before sending it to your AVR/Soundbar.

_partial used source: [Infuse FAQ](https://support.firecore.com/hc/en-us/articles/217735707-Audio-Options-tvOS#h_01HE1Z5XNJZK5YTF1SVTPS0MTR)_

Am I losing any quality by using LPCM? - \[Click to show/hide\]

- No. Since LPCM is a lossless format, using it will result in no loss of quality. What your ears hear will be exactly the same. The only difference is your receiver will recognize the audio stream as PCM instead of Dolby/DTS.
- LPCM will discard object and spatial metadata. (TrueHD Atmos, DTS-X)

_source: [Infuse FAQ](https://support.firecore.com/hc/en-us/articles/217735707-Audio-Options-tvOS#h_01HE1Z5XNJZK5YTF1SVTPS0MTR)_

Should I block certain audio formats because something in my setup doesn't support it? - \[Click to show/hide\]

Suppose you have chosen a profile that includes Audio Formats. In that case, lowering the scores or blocking certain audio formats is somewhat pointless since 95% of the Remuxes and UHD Encodes provide HD audio formats such as TrueHD Atmos, TrueHD, and DTS-X.

So you have two options.

1. Choose another quality profile that doesn't include audio formats, such as `HD Bluray + WEB` or `2160p WEB-DL`.
2. Accept the limitations of your audio setup (AVR/Soundbar) and/or your hardware media player device.

Which Audio Format should I choose? - \[Click to show/hide\]

![!Audio Formats Flowchart](https://trash-guides.info/Radarr/images/flowchart-audio.png)

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [TrueHD ATMOS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#truehd-atmos) | 5000 | 496f355514737f7d83bf7aa4d24f8169 |
| [DTS X](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-x) | 4500 | 2f22d89048b01681dde8afe203bf2e95 |
| [ATMOS (undefined)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atmos-undefined) | 3000 | 417804f7f2c4308c1f4c5d380d4c4475 |
| [DD+ ATMOS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ddplus-atmos) | 3000 | 1af239278386be2919e1bcee0bde047e |
| [TrueHD](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#truehd) | 2750 | 3cafb66171b47f226146a0770576870f |
| [DTS-HD MA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-hd-ma) | 2500 | dcf3ec6938fa32445f590a4da84256cd |
| [FLAC](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#flac) | 2250 | a570d4a0e56a2874b64e5bfa55202a1b |
| [PCM](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pcm) | 2250 | e7c2fcae07cbada050a0af3357491d7b |
| [DTS-HD HRA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-hd-hra) | 2000 | 8e109e50e0a0b83a5098b056e13bf6db |
| [DD+](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ddplus) | 1750 | 185f1dd7264c4562b9022d963ac37424 |
| [DTS-ES](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-es) | 1500 | f9f847ac70a0af62ea4a08280b859636 |
| [DTS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts) | 1250 | 1c1a4c5e823891c75bc50380a6866f73 |
| [AAC](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#aac) | 1000 | 240770601cc226190c367ef59aba7463 |
| [DD](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dd) | 750 | c2998bd0d90ed5621d8df281e839436e |

Miscellaneous (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Bad Dual Groups](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#bad-dual-groups) | -10000 | b6832f586342ef70d9c128d40c07b872 |
| [Black and White Editions](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#black-and-white-editions) | -10000 | cc444569854e9de0b084ab2b8b1532b2 |
| [No-RlsGroup](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#no-rlsgroup) | -10000 | ae9b7c9ebde1f3bd336a8cbd1ec4c5e5 |
| [Obfuscated](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#obfuscated) | -10000 | 7357cf5161efbf8c4d5d0c30b4815ee2 |
| [Retags](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#retags) | -10000 | 5c44f52a8714fdd79bb4d98e2673be1f |
| [Scene](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#scene) | -10000 | f537cf427b64c38c8e36298f657e4828 |

* * *

Breakdown and Why

- **Bad Dual Groups:** \[ _Optional_\] These groups take the original release and add their own language track (e.g. AAC 2.0 Portuguese) as the first track. Afterward, FFprobe would determine that the media file is Portuguese. It's a common rule that you only add the best audio as the main track.
Also they often even rename the release name into Portuguese.
- **Black and White Editions:** \[ _Optional_\] Some movies get an additional release version in monochrome/black and white. This custom format matches some of the more common occurrences of these.
- **No-RlsGroup:** \[ _Optional_\] Some indexers strip out the release group which could result in LQ groups being scored incorrectly. For example, a lot of EVO releases end up with a stripped group name. These releases would appear as "upgrades" and could end up getting a decent score after other CFs are scored.
- **Obfuscated:** \[ _Optional_\] Use these only if you wish to avoid renamed releases.
- **Retags:** \[ _Optional_\] Use this if you want to avoid retagged releases. Retagged releases often are not consistent with the quality of the original group's release.
- **Scene:** \[ _Optional_\] Use this only if you want to avoid SCENE releases.

Miscellaneous UHD (Optional) - \[Click to show/hide\]

I recommend using the following Custom Formats

- **For details on "Why" and a potential warning ![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) please see the notes below.**
- `x265 (no HDR/DV)` over the `x265 (HD)`
- `SDR (no WEBDL)` over the `SDR`

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [SDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sdr) | -10000 | 9c38ebb7384dada637be8899efa68e6f |
| [SDR (no WEBDL)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sdr-no-webdl)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | 25c12f78430a3a23413652cbd1d48d77 |
| [x265 (no HDR/DV)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-no-hdrdv)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | 839bea857ed2c0a8e084f3cbdbd65ecb |

* * *

Breakdown and Why

- **SDR:** This will prevent grabbing UHD/4k releases without HDR Formats.
- **SDR (no WEBDL):** This will prevent grabbing UHD/4k Remux and Bluray encode releases without HDR Formats. - i.e., SDR WEB releases will still be allowed since 4K SDR WEB releases can often look better than the 1080p version due to the improved bitrate.



If you have also added [SDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sdr) to your Radarr,

then one of them should be scored as `0` in your quality profile.

- **x265 (no HDR/DV):** This blocks 720/1080p (HD) releases that are encoded in x265, **But it will allow x265 releases if they have HDR and/or DV**



If you have also added [x265 (HD)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-hd) to your Radarr,

then one of them should be scored as `0` in your quality profile.


Movie Versions (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Remaster](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remaster) | 25 | 570bc9ebecd92723d2d21500f4be314c |
| [4K Remaster](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#4k-remaster) | 25 | eca37840c13c6ef2dd0262b141a5482f |
| [Criterion Collection](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#criterion-collection) | 25 | e0c07d59beb37348e975a930d5e50319 |
| [Masters of Cinema](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#masters-of-cinema) | 25 | 9d27d9d2181838f76dee150882bdc58c |
| [Vinegar Syndrome](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#vinegar-syndrome) | 25 | db9b4c4b53d312a3ca5f1378f6440fc9 |
| [Special Edition](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#special-edition) | 125 | 957d0f44b592285f26449575e8b1167e |
| [IMAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#imax) | 800 | eecf3a857724171f968a66cb5719e152 |
| [IMAX Enhanced](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#imax-enhanced) | 800 | 9f6cbff8cfe4ebbc1bde14c7b7bec0de |

IMAX Enhanced

IMAX Enhanced: Get More Picture Instead of Black Bars.

IMAX Enhanced exclusive expanded aspect ratio is 1:90:1, which offers up to 26% more picture for select sequences, meaning more of the action is visible on screen.

If you don't prefer `IMAX Enhanced` then don't add it or use a score of `0`

Use the following main settings in your profile.

![UHD Bluray + WEB](https://trash-guides.info/Radarr/images/qp-uhd-bluray-webdl.png)

Make sure you don't check the BR-DISK.

Info

The order listed in the profile matters even if a quality is not checked, for example if you have a 1080p version but wanted the SD version, Radarr will reject all SD results because 1080p is listed higher than SD even though 1080p was not checked.

Qualities at the top of the list will appear first in manual searches.

- Qualities higher in the list are more preferred even if not checked.
- Qualities within the same group are equal.
- Only checked qualities are wanted.

This is why it's recommended to move the selected quality to the top of the list.

[Source: Wiki Servarr](https://wiki.servarr.com/en/radarr/settings#quality-profiles)

Workflow Logic - \[Click to show/hide\]

**Depending on what's released first and available the following Workflow Logic will be used:**

- When the WEB-2160p is released it will download the WEB-2160p. (streaming services)
- When the Bluray-2160p is released it will upgrade to the Bluray-2160p.
- The downloaded media will be upgraded to any of the added Custom Formats until a score of `10000`.

So why such a ridiculously high `Upgrade Until Custom` and not a score of `100`?

We're too lazy to calculate the maximum for every Quality Profile we provide, and we want it to upgrade to the highest possible score anyway to result in the highest possible quality release.

* * *

### Remux + WEB 1080p [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#remux-web-1080p "Permanent link")

If you prefer 1080p Remuxes (Remux-1080p)

- _Size: 20-40 GB for a Remux-1080p depending on the running time._

I suggest to follow the following Guides first.

- [Quality Settings (File Size)](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/).
- [Recommended naming scheme](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/).

For this Quality Profile we're going to make use of the following Custom Formats with the scores given in the table.

Attention

All the used scores and combinations of Custom Formats in this Guide are tested to get the desired results while preventing download loops as much as possible.

From experience, most of the time when people change scores or leave out certain CFs that work together - they end up with undesired results.

If you're unsure or have questions, do not hesitate to ask for help on Discord

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

**The following Custom Formats are required:**

HQ Release Groups - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Remux Tier 01](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remux-tier-01) | 1950 | 3a3ff47579026e76d6504ebea39390de |
| [Remux Tier 02](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remux-tier-02) | 1900 | 9f98181fe5a3fbeb0cc29340da2a468a |
| [Remux Tier 03](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remux-tier-03) | 1850 | 8baaf0b3142bf4d94c42a724f034e27a |
| [WEB Tier 01](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-01) | 1700 | c20f169ef63c5f40c2def54abaf4438e |
| [WEB Tier 02](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-02) | 1650 | 403816d65392c79236dcb6dd591aeda4 |
| [WEB Tier 03](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-03) | 1600 | af94e0fe497124d1f9ce732069ec8c3b |

Miscellaneous (Required) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Repack/Proper](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper) | 5 | e7718d7a3ce595f289bfee26adc178f5 |
| [Repack2](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repack2) | 6 | ae43b294509409a6a13919dedd4764c4 |
| [Repack3](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repack3) | 7 | 5caaaa1c08c1742aa4342d8c4cc463f2 |

Proper and Repacks - \[Click to show/hide\]

We also suggest changing the Propers and Repacks settings in Radarr.

`Media Management` =\> `File Management` to `Do Not Prefer` and use the [Repack/Proper](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper) Custom Format.

![!cf-mm-propers-repacks-disable](https://trash-guides.info/Radarr/images/cf-mm-propers-repacks-disable.png)

This way you make sure the Custom Formats preferences will be used and not ignored.

Unwanted - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [BR-DISK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#br-disk) | -10000 | ed38b889b31be83fda192888e2286d83 |
| [Generated Dynamic HDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#generated-dynamic-hdr) | -10000 | e6886871085226c3da1830830146846c |
| [LQ](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq) | -10000 | 90a6f9a284dff5103f6346090e6280c8 |
| [LQ (Release Title)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq-release-title) | -10000 | e204b80c87be9497a8a6eaff48f72905 |
| [x265 (HD)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-hd)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | dc98083864ea246d05a42df0d05f81cc |
| [3D](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#3d) | -10000 | b8cd450cbfa689c0259a01d9e29ba3d6 |
| [Extras](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#extras) | -10000 | 0a3f082873eb454bde444150b70253cc |
| [Sing-Along Versions](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sing-along-versions) | -10000 | 712d74cd88bceb883ee32f773656b1f5 |
| [AV1](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#av1) | -10000 | cae4ca30163749b891686f95532519bd |

* * *

Breakdown and Why

- **BR-DISK :** This is a custom format to help Radarr recognize & ignore BR-DISK (ISO's and Blu-ray folder structure) in addition to the standard BR-DISK quality.
- **Generated Dynamic HDR :** A collection of groups who are known to generate their own dynamic HDR metadata - Dolby Vision and/or HDR10+.
- **LQ:** A collection of known low-quality groups that are often banned from the top trackers due to their releases' lack of quality or other reasons.
- **LQ (Release Title):** A collection of terms seen in the titles of low-quality releases that are not captured by using a release group name.
- **x265 (HD):** This blocks 720/1080p (HD) releases that are encoded in x265.



If you have also added [x265 (no HDR/DV)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-no-hdrdv) to your Radarr,

then one of them should be scored as `0` in your quality profile.

- **3D:** Is 3D still a thing for home use ?

- **Extras:** Blocks releases that only contain extras
- **Sing-Along Versions:** Blocks releases that contain hardcoded sing-along lyrics for musical sections
- **AV1:** This blocks all releases encoded in AV1.

**AV1**



AV1 encodes are currently targeting small file sizes, rather than good visual quality.
  - This is a new codec and you need modern devices that support it.
  - We also had reports of playback/transcoding issues.
  - No main group is actually using it (yet).
  - It's better to ignore this new codec to prevent compatibility issues

General Streaming Services - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [AMZN](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#amzn) | 0 | b3b3a6ac74ecbd56bcdbefa4799fb9df |
| [ATV](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atv) | 0 | df13ed57843877b21ad969184ab6888f |
| [ATVP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atvp) | 0 | 40e9380490e748672c2522eaaeb692f7 |
| [BCORE](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#bcore) | 15 | cc5e51a9e85a6296ceefe097a77f12f4 |
| [CRiT](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#crit) | 20 | 16622a6911d1ab5d5b8b713d5b0036d4 |
| [DSNP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dsnp) | 0 | 84272245b2988854bfb76a16e60baea5 |
| [HBO](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hbo) | 0 | 509e5f41146e278f9eab1ddaceb34515 |
| [HMAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hmax) | 0 | 5763d1b0ce84aff3b21038eea8e9b8ad |
| [Hulu](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hulu) | 0 | 526d445d4c16214309f0fd2b3be18a89 |
| [iT](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#it) | 0 | e0ec9672be6cac914ffad34a6b077209 |
| [MAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#max) | 0 | 6a061313d22e51e0f25b7cd4dc065233 |
| [MA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ma) | 20 | 2a6039655313bf5dab1e43523b62c374 |
| [NF](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#nf) | 0 | 170b1d363bd8516fbf3a3eb05d4faff6 |
| [PMTP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pmtp) | 0 | e36a0ba1bc902b26ee40818a1d59b8bd |
| [PCOK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pcok) | 0 | c9fd353f8f5f1baf56dc601c4cb29920 |
| [PLAY](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#play) | 0 | 350e9170619683a55cb9191d0b1ababa |
| [ROKU](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#roku) | 0 | 44c2b54d7c81c1a442a8b2cabeaef54f |
| [STAN](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#stan) | 0 | c2863d2a50c9acad1fb50e53ece60817 |

* * *

Breakdown and Why

- The reason why these Custom Formats have a score of `0` is because they are mainly used for the naming scheme and other variables should decide for movies if a certain release if preferred.
- `BCore`, `CRiT` and `MA` are the only ones with a score because of their better source material, or higher bitrate and quality compared to other streaming services.

**The following Custom Formats are optional:**

Audio (Optional) - \[Click to show/hide\]

**Why should I choose All Audio formats?**

- You have a hardware media player device and an audio setup that supports **ALL** HD Audio (TrueHD, DTS-X, DTS-HD, etc).



Apple TV doesn't passthrough HD-audio, If you use infuse, it's still limited!

Please check `I have an Apple TV`

- You've chosen a profile that includes Audio Formats. You should use all the Audio formats with Remuxes/UHD Encodes.

- You should add **ALL** the Audio formats - don't leave any of them out!
- Audio transcoding has a low impact on your server. If your server can't handle audio transcoding, consider choosing another quality profile.

I have an Apple TV - \[Click to show/hide\]

![!Audio Formats Flowchart](https://trash-guides.info/Radarr/images/plex-audio-atv.png)

- Passthrough: The preferred method if you have an audio setup (AVR/Soundbar). This mode sends the audio signals without any alteration or processing.
- Direct Play: The client natively supports the container, video, and audio streams. The Plex server sends the media file as-is to the client, using very little CPU power.
- Transcode: The client does not support the video and/or audio streams. The Plex server re-encodes the video, audio, or both into a compatible format. Transcoding video uses much CPU power, but transcoding audio uses little to moderate CPU power.
- Decodes: Decompresses the audio before sending it to your AVR/Soundbar.

_partial used source: [Infuse FAQ](https://support.firecore.com/hc/en-us/articles/217735707-Audio-Options-tvOS#h_01HE1Z5XNJZK5YTF1SVTPS0MTR)_

Am I losing any quality by using LPCM? - \[Click to show/hide\]

- No. Since LPCM is a lossless format, using it will result in no loss of quality. What your ears hear will be exactly the same. The only difference is your receiver will recognize the audio stream as PCM instead of Dolby/DTS.
- LPCM will discard object and spatial metadata. (TrueHD Atmos, DTS-X)

_source: [Infuse FAQ](https://support.firecore.com/hc/en-us/articles/217735707-Audio-Options-tvOS#h_01HE1Z5XNJZK5YTF1SVTPS0MTR)_

Should I block certain audio formats because something in my setup doesn't support it? - \[Click to show/hide\]

Suppose you have chosen a profile that includes Audio Formats. In that case, lowering the scores or blocking certain audio formats is somewhat pointless since 95% of the Remuxes and UHD Encodes provide HD audio formats such as TrueHD Atmos, TrueHD, and DTS-X.

So you have two options.

1. Choose another quality profile that doesn't include audio formats, such as `HD Bluray + WEB` or `2160p WEB-DL`.
2. Accept the limitations of your audio setup (AVR/Soundbar) and/or your hardware media player device.

Which Audio Format should I choose? - \[Click to show/hide\]

![!Audio Formats Flowchart](https://trash-guides.info/Radarr/images/flowchart-audio.png)

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [TrueHD ATMOS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#truehd-atmos) | 5000 | 496f355514737f7d83bf7aa4d24f8169 |
| [DTS X](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-x) | 4500 | 2f22d89048b01681dde8afe203bf2e95 |
| [ATMOS (undefined)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atmos-undefined) | 3000 | 417804f7f2c4308c1f4c5d380d4c4475 |
| [DD+ ATMOS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ddplus-atmos) | 3000 | 1af239278386be2919e1bcee0bde047e |
| [TrueHD](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#truehd) | 2750 | 3cafb66171b47f226146a0770576870f |
| [DTS-HD MA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-hd-ma) | 2500 | dcf3ec6938fa32445f590a4da84256cd |
| [FLAC](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#flac) | 2250 | a570d4a0e56a2874b64e5bfa55202a1b |
| [PCM](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pcm) | 2250 | e7c2fcae07cbada050a0af3357491d7b |
| [DTS-HD HRA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-hd-hra) | 2000 | 8e109e50e0a0b83a5098b056e13bf6db |
| [DD+](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ddplus) | 1750 | 185f1dd7264c4562b9022d963ac37424 |
| [DTS-ES](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-es) | 1500 | f9f847ac70a0af62ea4a08280b859636 |
| [DTS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts) | 1250 | 1c1a4c5e823891c75bc50380a6866f73 |
| [AAC](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#aac) | 1000 | 240770601cc226190c367ef59aba7463 |
| [DD](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dd) | 750 | c2998bd0d90ed5621d8df281e839436e |

Miscellaneous (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Bad Dual Groups](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#bad-dual-groups) | -10000 | b6832f586342ef70d9c128d40c07b872 |
| [Black and White Editions](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#black-and-white-editions) | -10000 | cc444569854e9de0b084ab2b8b1532b2 |
| [No-RlsGroup](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#no-rlsgroup) | -10000 | ae9b7c9ebde1f3bd336a8cbd1ec4c5e5 |
| [Obfuscated](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#obfuscated) | -10000 | 7357cf5161efbf8c4d5d0c30b4815ee2 |
| [Retags](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#retags) | -10000 | 5c44f52a8714fdd79bb4d98e2673be1f |
| [Scene](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#scene) | -10000 | f537cf427b64c38c8e36298f657e4828 |

* * *

Breakdown and Why

- **Bad Dual Groups:** \[ _Optional_\] These groups take the original release and add their own language track (e.g. AAC 2.0 Portuguese) as the first track. Afterward, FFprobe would determine that the media file is Portuguese. It's a common rule that you only add the best audio as the main track.
Also they often even rename the release name into Portuguese.
- **Black and White Editions:** \[ _Optional_\] Some movies get an additional release version in monochrome/black and white. This custom format matches some of the more common occurrences of these.
- **No-RlsGroup:** \[ _Optional_\] Some indexers strip out the release group which could result in LQ groups being scored incorrectly. For example, a lot of EVO releases end up with a stripped group name. These releases would appear as "upgrades" and could end up getting a decent score after other CFs are scored.
- **Obfuscated:** \[ _Optional_\] Use these only if you wish to avoid renamed releases.
- **Retags:** \[ _Optional_\] Use this if you want to avoid retagged releases. Retagged releases often are not consistent with the quality of the original group's release.
- **Scene:** \[ _Optional_\] Use this only if you want to avoid SCENE releases.

Movie Versions (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Hybrid](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hybrid) | 100 | 0f12c086e289cf966fa5948eac571f44 |
| [Remaster](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remaster) | 25 | 570bc9ebecd92723d2d21500f4be314c |
| [4K Remaster](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#4k-remaster) | 25 | eca37840c13c6ef2dd0262b141a5482f |
| [Criterion Collection](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#criterion-collection) | 25 | e0c07d59beb37348e975a930d5e50319 |
| [Masters of Cinema](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#masters-of-cinema) | 25 | 9d27d9d2181838f76dee150882bdc58c |
| [Vinegar Syndrome](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#vinegar-syndrome) | 25 | db9b4c4b53d312a3ca5f1378f6440fc9 |
| [Special Edition](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#special-edition) | 125 | 957d0f44b592285f26449575e8b1167e |
| [IMAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#imax) | 800 | eecf3a857724171f968a66cb5719e152 |
| [IMAX Enhanced](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#imax-enhanced) | 800 | 9f6cbff8cfe4ebbc1bde14c7b7bec0de |

IMAX Enhanced

IMAX Enhanced: Get More Picture Instead of Black Bars.

IMAX Enhanced exclusive expanded aspect ratio is 1:90:1, which offers up to 26% more picture for select sequences, meaning more of the action is visible on screen.

If you don't prefer `IMAX Enhanced` then don't add it or use a score of `0`

Use the following main settings in your profile.

![Remux + WEB 1080p](https://trash-guides.info/Radarr/images/qp-remux-webdl-1080p.png)

Make sure you don't check the BR-DISK.

The reason why we didn't select the WEB-DL 720p is that you will hardly find any releases that aren't done as 1080p WEB-DL.

Info

The order listed in the profile matters even if a quality is not checked, for example if you have a 1080p version but wanted the SD version, Radarr will reject all SD results because 1080p is listed higher than SD even though 1080p was not checked.

Qualities at the top of the list will appear first in manual searches.

- Qualities higher in the list are more preferred even if not checked.
- Qualities within the same group are equal.
- Only checked qualities are wanted.

This is why it's recommended to move the selected quality to the top of the list.

[Source: Wiki Servarr](https://wiki.servarr.com/en/radarr/settings#quality-profiles)

Workflow Logic - \[Click to show/hide\]

- When the WEB-1080p is released it will download the WEB-1080p. (streaming services)
- When the REMUX-1080p is released it will upgrade to the REMUX-1080p.
- The downloaded media will be upgraded to any of the added Custom Formats until a score of `10000`.

So why such a ridiculously high `Upgrade Until Custom` and not a score of `500`?

We're too lazy to calculate the maximum for every Quality Profile we provide, and we want it to upgrade to the highest possible score anyway to result in the highest possible quality release.

* * *

### Remux + WEB 2160p [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#remux-web-2160p "Permanent link")

If you prefer 2160p Remuxes (Remux-2160p)

- _Size: 40-100 GB for a Remux-2160p depending on the running time._

I suggest to follow the following Guides first.

- [Quality Settings (File Size)](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/).
- [Recommended naming scheme](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/).

For this Quality Profile we're going to make use of the following Custom Formats with the scores given in the table.

Attention

All the used scores and combinations of Custom Formats in this Guide are tested to get the desired results while preventing download loops as much as possible.

From experience, most of the time when people change scores or leave out certain CFs that work together - they end up with undesired results.

If you're unsure or have questions, do not hesitate to ask for help on Discord

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

**The following Custom Formats are required:**

HDR Formats - \[Click to show/hide\]

**HDR**

All users with HDR-capable equipment should add the HDR custom format.

_This is a catch-all custom format for all HDR-related formats, including those with HDR10 or HDR10+ fallback capabilities, such as DV HDR10 or DV HDR10+._

* * *

**DV Boost**

If you prefer Dolby Vision and have compatible equipment, add the DV Boost custom format. This custom format prioritizes releases containing Dolby Vision over standard HDR releases.

_This custom format accepts DV Profile 5 and also upgrades from DV/HDR10/HDR10+ to DV HDR10 or DV HDR10+._

**HDR10+ Boost**

If you prefer HDR10+ releases and have compatible equipment, add the HDR10+ Boost custom format. This custom format prioritizes releases containing HDR10+ over standard HDR releases.

_This custom format also boosts DV HDR10+ releases if you prefer them over DV HDR10._

If you prefer both Dolby Vision and HDR10+, add both boost custom formats!

* * *

**DV (w/o HDR fallback)**

If **NOT** every device accessing your media server supports Dolby Vision, add the DV (w/o HDR fallback) custom format to ensure maximum compatibility with your setup. This prevents playback issues on devices that don't fully support Dolby Vision.

_This also applies to Dolby Vision releases without HDR10 fallback (Profile 5)._

* * *

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [HDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hdr) | 500 | 493b6d1dbec3c3364c59d7607f7e3405 |
| [DV Boost](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dv-boost) | 1000 | b337d6812e06c200ec9a2d3cfa9d20a7 |
| [HDR10+ Boost](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hdr10plus-boost) | 100 | caa37d0df9c348912df1fb1d88f9273a |
| [DV (w/o HDR fallback)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dv-wo-hdr-fallback) | -10000 | 923b6abef9b17f937fab56cfcf89e1f1 |

* * *

Why am I getting purple or green colors? - \[Click to show/hide\]

Why am I getting purple or green colors?

There are several possible reasons why your TV would show purple or green colors when playing Dolby Vision content.

1. **Unsupported Hardware**: Your TV or hardware media player device (Roku, Apple TV, etc) doesn't support Dolby Vision or your hardware media player device doesn't support all the Dolby Vision Profiles. As a result, the device might struggle to produce accurate colors, leading to a purple or green tint.

2. **Incorrect Display Settings**: Dolby Vision content often requires specific settings to be enabled on your TV or display device in order to deliver the intended visual experience. If these settings are not configured properly, it can result in the device showing distorted colors (including purple or green hues).

3. **HDMI Compatibility Issues**: Sometimes, HDMI cables or ports may not be fully compatible with Dolby Vision. If the media player device is not recognizing the Dolby Vision signal properly, it may fail to process the content correctly, resulting in abnormal color rendering.


To resolve the purple or green color issues when playing Dolby Vision content, you can try the following troubleshooting steps:

1. Ensure your TV or hardware media player device is Dolby Vision compatible and up-to-date with the latest firmware.
2. Verify that your TV or display device is set up correctly and has the necessary Dolby Vision settings enabled.
3. Check the HDMI cables and ensure they can transmit Dolby Vision signals.

Dolby Vision Profiles - \[Click to show/hide\]

Dolby Vision Profiles

- **Profile 5**( _1_) \- This is what comes with WEB-DL Dolby Vision releases without HDR10 fallback.

( _Incompatible devices will playback with blown out pinks and greens_)
- **Profile 7**( _2_) \- This is what comes with UHD Bluray Remuxes and UHD BluRay releases.

_These files will play on an Nvidia Shield Pro (2019), but on most other players will revert to the HDR10 fallback._
- **Profile 8**( _3_) \- This is what comes with (Hybrid) WEB-DL (HULU), Hybrid UHD Remux, and UHD BluRay releases (all of which have HDR10 fallback).

_This works with several mainstream media players._


* * *

Apple TV Dolby Vision Limitations - \[Click to show/hide\]

Plex for Apple TV is only capable of playing Dolby Vision Profiles 5 and 8 correctly if CMv2.9 is being used.

Infuse 7.7.2+ offers expanded support for Dolby Vision Profile 8, including files containing CMv4.0 metadata, samples that were previously playing with a black screen, falling back to HDR10, or various other playback issues. [SOURCE](https://community.firecore.com/t/infuse-7-7-2-now-available/48208)

The Dolby Vision Profile and Version of a media file cannot be determined by automation software before downloading it, so when you are using an Apple TV, with or without Infuse, it will always be hit or miss whether the content is compatible or not.

Additionally, it is uncertain whether the Dolby Vision layer will play, fall back to HDR10, or result in a black screen.

- ( _1_) _PLEX for Apple TV and Plex with Infuse will only play profile 5 correctly if CMv2.9 is used._
- ( _2_) _Neither Infuse nor PLEX for Apple TV will deliver real Dolby Vision with Profile 7._
- ( _3_) _PLEX for Apple TV will only play profile 8 correctly if CMv2.9 is used. However, we have also received reports that in some cases, it will fall back to HDR10, or you may encounter a black screen._



To prevent your TV from incorrectly indicating that it is playing DV follow the steps provided by an Infuse user: **“With Infuse ensure you set the Extended Dolby Vision settings to Limited (prefer accuracy), convert P8 to P5 (when possible), and play other P8 as HDR (output will switch to either DoVi or HDR depending on the video)”**

Dolby Vision Versions - CMv2.9 and CMv4.0 - \[Click to show/hide\]

There are two versions of Dolby Vision, namely CMv2.9 and CMv4.0. CMv4.0 uses an improved algorithm and a superior tone curve, allowing for better mapping and more controls during the Dolby Vision trim pass process.

More info about the different Dolby Vision Versions: [Dolby Vision Versions - CMv2.9 vs. CMv4.0](https://professionalsupport.dolby.com/s/article/When-should-I-use-CM-v2-9-or-CM-v4-0-and-can-I-convert-between-them?language=en_US)

HQ Release Groups - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Remux Tier 01](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remux-tier-01) | 1950 | 3a3ff47579026e76d6504ebea39390de |
| [Remux Tier 02](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remux-tier-02) | 1900 | 9f98181fe5a3fbeb0cc29340da2a468a |
| [Remux Tier 03](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remux-tier-03) | 1850 | 8baaf0b3142bf4d94c42a724f034e27a |
| [WEB Tier 01](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-01) | 1700 | c20f169ef63c5f40c2def54abaf4438e |
| [WEB Tier 02](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-02) | 1650 | 403816d65392c79236dcb6dd591aeda4 |
| [WEB Tier 03](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#web-tier-03) | 1600 | af94e0fe497124d1f9ce732069ec8c3b |

Miscellaneous (Required) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Repack/Proper](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper) | 5 | e7718d7a3ce595f289bfee26adc178f5 |
| [Repack2](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repack2) | 6 | ae43b294509409a6a13919dedd4764c4 |
| [Repack3](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repack3) | 7 | 5caaaa1c08c1742aa4342d8c4cc463f2 |

Proper and Repacks - \[Click to show/hide\]

We also suggest changing the Propers and Repacks settings in Radarr.

`Media Management` =\> `File Management` to `Do Not Prefer` and use the [Repack/Proper](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper) Custom Format.

![!cf-mm-propers-repacks-disable](https://trash-guides.info/Radarr/images/cf-mm-propers-repacks-disable.png)

This way you make sure the Custom Formats preferences will be used and not ignored.

Unwanted - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [BR-DISK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#br-disk) | -10000 | ed38b889b31be83fda192888e2286d83 |
| [Generated Dynamic HDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#generated-dynamic-hdr) | -10000 | e6886871085226c3da1830830146846c |
| [LQ](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq) | -10000 | 90a6f9a284dff5103f6346090e6280c8 |
| [LQ (Release Title)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq-release-title) | -10000 | e204b80c87be9497a8a6eaff48f72905 |
| [x265 (HD)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-hd)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | dc98083864ea246d05a42df0d05f81cc |
| [3D](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#3d) | -10000 | b8cd450cbfa689c0259a01d9e29ba3d6 |
| [Upscaled](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#upscaled) | -10000 | bfd8eb01832d646a0a89c4deb46f8564 |
| [Extras](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#extras) | -10000 | 0a3f082873eb454bde444150b70253cc |
| [Sing-Along Versions](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sing-along-versions) | -10000 | 712d74cd88bceb883ee32f773656b1f5 |
| [AV1](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#av1) | -10000 | cae4ca30163749b891686f95532519bd |

* * *

Breakdown and Why

- **BR-DISK :** This is a custom format to help Radarr recognize & ignore BR-DISK (ISO's and Blu-ray folder structure) in addition to the standard BR-DISK quality.
- **Generated Dynamic HDR :** A collection of groups who are known to generate their own dynamic HDR metadata - Dolby Vision and/or HDR10+.
- **LQ:** A collection of known low-quality groups that are often banned from the top trackers due to their releases' lack of quality or other reasons.
- **LQ (Release Title):** A collection of terms seen in the titles of low-quality releases that are not captured by using a release group name.
- **x265 (HD):** This blocks 720/1080p (HD) releases that are encoded in x265.



If you have also added [x265 (no HDR/DV)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-no-hdrdv) to your Radarr,

then one of them should be scored as `0` in your quality profile.

- **3D:** Is 3D still a thing for home use ?

- **Upscaled:** A custom format to prevent Radarr from grabbing upscaled releases.
- **Extras:** Blocks releases that only contain extras
- **Sing-Along Versions:** Blocks releases that contain hardcoded sing-along lyrics for musical sections
- **AV1:** This blocks all releases encoded in AV1.

**AV1**



AV1 encodes are currently targeting small file sizes, rather than good visual quality.
  - This is a new codec and you need modern devices that support it.
  - We also had reports of playback/transcoding issues.
  - No main group is actually using it (yet).
  - It's better to ignore this new codec to prevent compatibility issues

General Streaming Services - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [AMZN](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#amzn) | 0 | b3b3a6ac74ecbd56bcdbefa4799fb9df |
| [ATV](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atv) | 0 | df13ed57843877b21ad969184ab6888f |
| [ATVP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atvp) | 0 | 40e9380490e748672c2522eaaeb692f7 |
| [BCORE](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#bcore) | 15 | cc5e51a9e85a6296ceefe097a77f12f4 |
| [CRiT](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#crit) | 20 | 16622a6911d1ab5d5b8b713d5b0036d4 |
| [DSNP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dsnp) | 0 | 84272245b2988854bfb76a16e60baea5 |
| [HBO](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hbo) | 0 | 509e5f41146e278f9eab1ddaceb34515 |
| [HMAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hmax) | 0 | 5763d1b0ce84aff3b21038eea8e9b8ad |
| [Hulu](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hulu) | 0 | 526d445d4c16214309f0fd2b3be18a89 |
| [iT](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#it) | 0 | e0ec9672be6cac914ffad34a6b077209 |
| [MAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#max) | 0 | 6a061313d22e51e0f25b7cd4dc065233 |
| [MA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ma) | 20 | 2a6039655313bf5dab1e43523b62c374 |
| [NF](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#nf) | 0 | 170b1d363bd8516fbf3a3eb05d4faff6 |
| [PMTP](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pmtp) | 0 | e36a0ba1bc902b26ee40818a1d59b8bd |
| [PCOK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pcok) | 0 | c9fd353f8f5f1baf56dc601c4cb29920 |
| [PLAY](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#play) | 0 | 350e9170619683a55cb9191d0b1ababa |
| [ROKU](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#roku) | 0 | 44c2b54d7c81c1a442a8b2cabeaef54f |
| [STAN](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#stan) | 0 | c2863d2a50c9acad1fb50e53ece60817 |

* * *

Breakdown and Why

- The reason why these Custom Formats have a score of `0` is because they are mainly used for the naming scheme and other variables should decide for movies if a certain release if preferred.
- `BCore`, `CRiT` and `MA` are the only ones with a score because of their better source material, or higher bitrate and quality compared to other streaming services.

**The following Custom Formats are optional:**

Audio (Optional) - \[Click to show/hide\]

**Why should I choose All Audio formats?**

- You have a hardware media player device and an audio setup that supports **ALL** HD Audio (TrueHD, DTS-X, DTS-HD, etc).



Apple TV doesn't passthrough HD-audio, If you use infuse, it's still limited!

Please check `I have an Apple TV`

- You've chosen a profile that includes Audio Formats. You should use all the Audio formats with Remuxes/UHD Encodes.

- You should add **ALL** the Audio formats - don't leave any of them out!
- Audio transcoding has a low impact on your server. If your server can't handle audio transcoding, consider choosing another quality profile.

I have an Apple TV - \[Click to show/hide\]

![!Audio Formats Flowchart](https://trash-guides.info/Radarr/images/plex-audio-atv.png)

- Passthrough: The preferred method if you have an audio setup (AVR/Soundbar). This mode sends the audio signals without any alteration or processing.
- Direct Play: The client natively supports the container, video, and audio streams. The Plex server sends the media file as-is to the client, using very little CPU power.
- Transcode: The client does not support the video and/or audio streams. The Plex server re-encodes the video, audio, or both into a compatible format. Transcoding video uses much CPU power, but transcoding audio uses little to moderate CPU power.
- Decodes: Decompresses the audio before sending it to your AVR/Soundbar.

_partial used source: [Infuse FAQ](https://support.firecore.com/hc/en-us/articles/217735707-Audio-Options-tvOS#h_01HE1Z5XNJZK5YTF1SVTPS0MTR)_

Am I losing any quality by using LPCM? - \[Click to show/hide\]

- No. Since LPCM is a lossless format, using it will result in no loss of quality. What your ears hear will be exactly the same. The only difference is your receiver will recognize the audio stream as PCM instead of Dolby/DTS.
- LPCM will discard object and spatial metadata. (TrueHD Atmos, DTS-X)

_source: [Infuse FAQ](https://support.firecore.com/hc/en-us/articles/217735707-Audio-Options-tvOS#h_01HE1Z5XNJZK5YTF1SVTPS0MTR)_

Should I block certain audio formats because something in my setup doesn't support it? - \[Click to show/hide\]

Suppose you have chosen a profile that includes Audio Formats. In that case, lowering the scores or blocking certain audio formats is somewhat pointless since 95% of the Remuxes and UHD Encodes provide HD audio formats such as TrueHD Atmos, TrueHD, and DTS-X.

So you have two options.

1. Choose another quality profile that doesn't include audio formats, such as `HD Bluray + WEB` or `2160p WEB-DL`.
2. Accept the limitations of your audio setup (AVR/Soundbar) and/or your hardware media player device.

Which Audio Format should I choose? - \[Click to show/hide\]

![!Audio Formats Flowchart](https://trash-guides.info/Radarr/images/flowchart-audio.png)

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [TrueHD ATMOS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#truehd-atmos) | 5000 | 496f355514737f7d83bf7aa4d24f8169 |
| [DTS X](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-x) | 4500 | 2f22d89048b01681dde8afe203bf2e95 |
| [ATMOS (undefined)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atmos-undefined) | 3000 | 417804f7f2c4308c1f4c5d380d4c4475 |
| [DD+ ATMOS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ddplus-atmos) | 3000 | 1af239278386be2919e1bcee0bde047e |
| [TrueHD](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#truehd) | 2750 | 3cafb66171b47f226146a0770576870f |
| [DTS-HD MA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-hd-ma) | 2500 | dcf3ec6938fa32445f590a4da84256cd |
| [FLAC](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#flac) | 2250 | a570d4a0e56a2874b64e5bfa55202a1b |
| [PCM](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pcm) | 2250 | e7c2fcae07cbada050a0af3357491d7b |
| [DTS-HD HRA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-hd-hra) | 2000 | 8e109e50e0a0b83a5098b056e13bf6db |
| [DD+](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ddplus) | 1750 | 185f1dd7264c4562b9022d963ac37424 |
| [DTS-ES](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-es) | 1500 | f9f847ac70a0af62ea4a08280b859636 |
| [DTS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts) | 1250 | 1c1a4c5e823891c75bc50380a6866f73 |
| [AAC](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#aac) | 1000 | 240770601cc226190c367ef59aba7463 |
| [DD](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dd) | 750 | c2998bd0d90ed5621d8df281e839436e |

Miscellaneous (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Bad Dual Groups](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#bad-dual-groups) | -10000 | b6832f586342ef70d9c128d40c07b872 |
| [Black and White Editions](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#black-and-white-editions) | -10000 | cc444569854e9de0b084ab2b8b1532b2 |
| [No-RlsGroup](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#no-rlsgroup) | -10000 | ae9b7c9ebde1f3bd336a8cbd1ec4c5e5 |
| [Obfuscated](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#obfuscated) | -10000 | 7357cf5161efbf8c4d5d0c30b4815ee2 |
| [Retags](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#retags) | -10000 | 5c44f52a8714fdd79bb4d98e2673be1f |
| [Scene](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#scene) | -10000 | f537cf427b64c38c8e36298f657e4828 |

* * *

Breakdown and Why

- **Bad Dual Groups:** \[ _Optional_\] These groups take the original release and add their own language track (e.g. AAC 2.0 Portuguese) as the first track. Afterward, FFprobe would determine that the media file is Portuguese. It's a common rule that you only add the best audio as the main track.
Also they often even rename the release name into Portuguese.
- **Black and White Editions:** \[ _Optional_\] Some movies get an additional release version in monochrome/black and white. This custom format matches some of the more common occurrences of these.
- **No-RlsGroup:** \[ _Optional_\] Some indexers strip out the release group which could result in LQ groups being scored incorrectly. For example, a lot of EVO releases end up with a stripped group name. These releases would appear as "upgrades" and could end up getting a decent score after other CFs are scored.
- **Obfuscated:** \[ _Optional_\] Use these only if you wish to avoid renamed releases.
- **Retags:** \[ _Optional_\] Use this if you want to avoid retagged releases. Retagged releases often are not consistent with the quality of the original group's release.
- **Scene:** \[ _Optional_\] Use this only if you want to avoid SCENE releases.

Miscellaneous UHD (Optional) - \[Click to show/hide\]

I recommend using the following Custom Formats

- **For details on "Why" and a potential warning ![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) please see the notes below.**
- `x265 (no HDR/DV)` over the `x265 (HD)`
- `SDR (no WEBDL)` over the `SDR`

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [SDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sdr) | -10000 | 9c38ebb7384dada637be8899efa68e6f |
| [SDR (no WEBDL)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sdr-no-webdl)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | 25c12f78430a3a23413652cbd1d48d77 |
| [x265 (no HDR/DV)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-no-hdrdv)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | 839bea857ed2c0a8e084f3cbdbd65ecb |

* * *

Breakdown and Why

- **SDR:** This will prevent grabbing UHD/4k releases without HDR Formats.
- **SDR (no WEBDL):** This will prevent grabbing UHD/4k Remux and Bluray encode releases without HDR Formats. - i.e., SDR WEB releases will still be allowed since 4K SDR WEB releases can often look better than the 1080p version due to the improved bitrate.



If you have also added [SDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sdr) to your Radarr,

then one of them should be scored as `0` in your quality profile.

- **x265 (no HDR/DV):** This blocks 720/1080p (HD) releases that are encoded in x265, **But it will allow x265 releases if they have HDR and/or DV**



If you have also added [x265 (HD)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-hd) to your Radarr,

then one of them should be scored as `0` in your quality profile.


Movie Versions (Optional) - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [Hybrid](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hybrid) | 100 | 0f12c086e289cf966fa5948eac571f44 |
| [Remaster](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#remaster) | 25 | 570bc9ebecd92723d2d21500f4be314c |
| [4K Remaster](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#4k-remaster) | 25 | eca37840c13c6ef2dd0262b141a5482f |
| [Criterion Collection](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#criterion-collection) | 25 | e0c07d59beb37348e975a930d5e50319 |
| [Masters of Cinema](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#masters-of-cinema) | 25 | 9d27d9d2181838f76dee150882bdc58c |
| [Vinegar Syndrome](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#vinegar-syndrome) | 25 | db9b4c4b53d312a3ca5f1378f6440fc9 |
| [Special Edition](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#special-edition) | 125 | 957d0f44b592285f26449575e8b1167e |
| [IMAX](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#imax) | 800 | eecf3a857724171f968a66cb5719e152 |
| [IMAX Enhanced](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#imax-enhanced) | 800 | 9f6cbff8cfe4ebbc1bde14c7b7bec0de |

IMAX Enhanced

IMAX Enhanced: Get More Picture Instead of Black Bars.

IMAX Enhanced exclusive expanded aspect ratio is 1:90:1, which offers up to 26% more picture for select sequences, meaning more of the action is visible on screen.

If you don't prefer `IMAX Enhanced` then don't add it or use a score of `0`

Use the following main settings in your profile.

![Remux + WEB 2160p](https://trash-guides.info/Radarr/images/qp-remux-webdl-2160p.png)

Make sure you don't check the BR-DISK.

Info

The order listed in the profile matters even if a quality is not checked, for example if you have a 1080p version but wanted the SD version, Radarr will reject all SD results because 1080p is listed higher than SD even though 1080p was not checked.

Qualities at the top of the list will appear first in manual searches.

- Qualities higher in the list are more preferred even if not checked.
- Qualities within the same group are equal.
- Only checked qualities are wanted.

This is why it's recommended to move the selected quality to the top of the list.

[Source: Wiki Servarr](https://wiki.servarr.com/en/radarr/settings#quality-profiles)

Workflow Logic - \[Click to show/hide\]

- When the WEB-2160p is released it will download the WEB-2160p. (streaming services)
- When the REMUX-2160p is released it will upgrade to the REMUX-2160p.
- The downloaded media will be upgraded to any of the added Custom Formats until a score of `10000`.

So why such a ridiculously high `Upgrade Until Custom` and not a score of `500`?

We're too lazy to calculate the maximum for every Quality Profile we provide, and we want it to upgrade to the highest possible score anyway to result in the highest possible quality release.

* * *

## Custom Format Groups [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#custom-format-groups "Permanent link")

The following custom format groups should be combined with the Quality Profiles above. Users will need to choose which options and custom formats they prefer.

### Audio Formats [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#audio-formats "Permanent link")

- You have a hardware media player device and an audio setup that supports **ALL** HD Audio (TrueHD, DTS-X, DTS-HD, etc).



Apple TV doesn't passthrough HD-audio, If you use infuse, it's still limited!

Please check `I have an Apple TV`

- You've chosen a profile that includes Audio Formats. You should use all the Audio formats with Remuxes/UHD Encodes.

- You should add **ALL** the Audio formats - don't leave any of them out!
- Audio transcoding has a low impact on your server. If your server can't handle audio transcoding, consider choosing another quality profile.

_The reason that we score lossy Atmos higher than lossless DTS-HD MA is that we prefer having the object metadata (Atmos) over lossless audio._

Audio (Optional) - \[Click to show/hide\]

**Why should I choose All Audio formats?**

- You have a hardware media player device and an audio setup that supports **ALL** HD Audio (TrueHD, DTS-X, DTS-HD, etc).



Apple TV doesn't passthrough HD-audio, If you use infuse, it's still limited!

Please check `I have an Apple TV`

- You've chosen a profile that includes Audio Formats. You should use all the Audio formats with Remuxes/UHD Encodes.

- You should add **ALL** the Audio formats - don't leave any of them out!
- Audio transcoding has a low impact on your server. If your server can't handle audio transcoding, consider choosing another quality profile.

I have an Apple TV - \[Click to show/hide\]

![!Audio Formats Flowchart](https://trash-guides.info/Radarr/images/plex-audio-atv.png)

- Passthrough: The preferred method if you have an audio setup (AVR/Soundbar). This mode sends the audio signals without any alteration or processing.
- Direct Play: The client natively supports the container, video, and audio streams. The Plex server sends the media file as-is to the client, using very little CPU power.
- Transcode: The client does not support the video and/or audio streams. The Plex server re-encodes the video, audio, or both into a compatible format. Transcoding video uses much CPU power, but transcoding audio uses little to moderate CPU power.
- Decodes: Decompresses the audio before sending it to your AVR/Soundbar.

_partial used source: [Infuse FAQ](https://support.firecore.com/hc/en-us/articles/217735707-Audio-Options-tvOS#h_01HE1Z5XNJZK5YTF1SVTPS0MTR)_

Am I losing any quality by using LPCM? - \[Click to show/hide\]

- No. Since LPCM is a lossless format, using it will result in no loss of quality. What your ears hear will be exactly the same. The only difference is your receiver will recognize the audio stream as PCM instead of Dolby/DTS.
- LPCM will discard object and spatial metadata. (TrueHD Atmos, DTS-X)

_source: [Infuse FAQ](https://support.firecore.com/hc/en-us/articles/217735707-Audio-Options-tvOS#h_01HE1Z5XNJZK5YTF1SVTPS0MTR)_

Should I block certain audio formats because something in my setup doesn't support it? - \[Click to show/hide\]

Suppose you have chosen a profile that includes Audio Formats. In that case, lowering the scores or blocking certain audio formats is somewhat pointless since 95% of the Remuxes and UHD Encodes provide HD audio formats such as TrueHD Atmos, TrueHD, and DTS-X.

So you have two options.

1. Choose another quality profile that doesn't include audio formats, such as `HD Bluray + WEB` or `2160p WEB-DL`.
2. Accept the limitations of your audio setup (AVR/Soundbar) and/or your hardware media player device.

Which Audio Format should I choose? - \[Click to show/hide\]

![!Audio Formats Flowchart](https://trash-guides.info/Radarr/images/flowchart-audio.png)

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [TrueHD ATMOS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#truehd-atmos) | 5000 | 496f355514737f7d83bf7aa4d24f8169 |
| [DTS X](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-x) | 4500 | 2f22d89048b01681dde8afe203bf2e95 |
| [ATMOS (undefined)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#atmos-undefined) | 3000 | 417804f7f2c4308c1f4c5d380d4c4475 |
| [DD+ ATMOS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ddplus-atmos) | 3000 | 1af239278386be2919e1bcee0bde047e |
| [TrueHD](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#truehd) | 2750 | 3cafb66171b47f226146a0770576870f |
| [DTS-HD MA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-hd-ma) | 2500 | dcf3ec6938fa32445f590a4da84256cd |
| [FLAC](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#flac) | 2250 | a570d4a0e56a2874b64e5bfa55202a1b |
| [PCM](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#pcm) | 2250 | e7c2fcae07cbada050a0af3357491d7b |
| [DTS-HD HRA](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-hd-hra) | 2000 | 8e109e50e0a0b83a5098b056e13bf6db |
| [DD+](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#ddplus) | 1750 | 185f1dd7264c4562b9022d963ac37424 |
| [DTS-ES](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts-es) | 1500 | f9f847ac70a0af62ea4a08280b859636 |
| [DTS](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dts) | 1250 | 1c1a4c5e823891c75bc50380a6866f73 |
| [AAC](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#aac) | 1000 | 240770601cc226190c367ef59aba7463 |
| [DD](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dd) | 750 | c2998bd0d90ed5621d8df281e839436e |

* * *

### HDR Formats [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#hdr-formats "Permanent link")

- You have a 4K TV and a hardware media player device (such as Roku, Apple TV, Shield, SmartTV App, etc.) that supports several HDR formats (such as Dolby Vision, HDR10, HDR10+, etc.).

HDR Formats - \[Click to show/hide\]

**HDR**

All users with HDR-capable equipment should add the HDR custom format.

_This is a catch-all custom format for all HDR-related formats, including those with HDR10 or HDR10+ fallback capabilities, such as DV HDR10 or DV HDR10+._

* * *

**DV Boost**

If you prefer Dolby Vision and have compatible equipment, add the DV Boost custom format. This custom format prioritizes releases containing Dolby Vision over standard HDR releases.

_This custom format accepts DV Profile 5 and also upgrades from DV/HDR10/HDR10+ to DV HDR10 or DV HDR10+._

**HDR10+ Boost**

If you prefer HDR10+ releases and have compatible equipment, add the HDR10+ Boost custom format. This custom format prioritizes releases containing HDR10+ over standard HDR releases.

_This custom format also boosts DV HDR10+ releases if you prefer them over DV HDR10._

If you prefer both Dolby Vision and HDR10+, add both boost custom formats!

* * *

**DV (w/o HDR fallback)**

If **NOT** every device accessing your media server supports Dolby Vision, add the DV (w/o HDR fallback) custom format to ensure maximum compatibility with your setup. This prevents playback issues on devices that don't fully support Dolby Vision.

_This also applies to Dolby Vision releases without HDR10 fallback (Profile 5)._

* * *

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [HDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hdr) | 500 | 493b6d1dbec3c3364c59d7607f7e3405 |
| [DV Boost](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dv-boost) | 1000 | b337d6812e06c200ec9a2d3cfa9d20a7 |
| [HDR10+ Boost](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#hdr10plus-boost) | 100 | caa37d0df9c348912df1fb1d88f9273a |
| [DV (w/o HDR fallback)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dv-wo-hdr-fallback) | -10000 | 923b6abef9b17f937fab56cfcf89e1f1 |

* * *

Why am I getting purple or green colors? - \[Click to show/hide\]

Why am I getting purple or green colors?

There are several possible reasons why your TV would show purple or green colors when playing Dolby Vision content.

1. **Unsupported Hardware**: Your TV or hardware media player device (Roku, Apple TV, etc) doesn't support Dolby Vision or your hardware media player device doesn't support all the Dolby Vision Profiles. As a result, the device might struggle to produce accurate colors, leading to a purple or green tint.

2. **Incorrect Display Settings**: Dolby Vision content often requires specific settings to be enabled on your TV or display device in order to deliver the intended visual experience. If these settings are not configured properly, it can result in the device showing distorted colors (including purple or green hues).

3. **HDMI Compatibility Issues**: Sometimes, HDMI cables or ports may not be fully compatible with Dolby Vision. If the media player device is not recognizing the Dolby Vision signal properly, it may fail to process the content correctly, resulting in abnormal color rendering.


To resolve the purple or green color issues when playing Dolby Vision content, you can try the following troubleshooting steps:

1. Ensure your TV or hardware media player device is Dolby Vision compatible and up-to-date with the latest firmware.
2. Verify that your TV or display device is set up correctly and has the necessary Dolby Vision settings enabled.
3. Check the HDMI cables and ensure they can transmit Dolby Vision signals.

Dolby Vision Profiles - \[Click to show/hide\]

Dolby Vision Profiles

- **Profile 5**( _1_) \- This is what comes with WEB-DL Dolby Vision releases without HDR10 fallback.

( _Incompatible devices will playback with blown out pinks and greens_)
- **Profile 7**( _2_) \- This is what comes with UHD Bluray Remuxes and UHD BluRay releases.

_These files will play on an Nvidia Shield Pro (2019), but on most other players will revert to the HDR10 fallback._
- **Profile 8**( _3_) \- This is what comes with (Hybrid) WEB-DL (HULU), Hybrid UHD Remux, and UHD BluRay releases (all of which have HDR10 fallback).

_This works with several mainstream media players._


* * *

Apple TV Dolby Vision Limitations - \[Click to show/hide\]

Plex for Apple TV is only capable of playing Dolby Vision Profiles 5 and 8 correctly if CMv2.9 is being used.

Infuse 7.7.2+ offers expanded support for Dolby Vision Profile 8, including files containing CMv4.0 metadata, samples that were previously playing with a black screen, falling back to HDR10, or various other playback issues. [SOURCE](https://community.firecore.com/t/infuse-7-7-2-now-available/48208)

The Dolby Vision Profile and Version of a media file cannot be determined by automation software before downloading it, so when you are using an Apple TV, with or without Infuse, it will always be hit or miss whether the content is compatible or not.

Additionally, it is uncertain whether the Dolby Vision layer will play, fall back to HDR10, or result in a black screen.

- ( _1_) _PLEX for Apple TV and Plex with Infuse will only play profile 5 correctly if CMv2.9 is used._
- ( _2_) _Neither Infuse nor PLEX for Apple TV will deliver real Dolby Vision with Profile 7._
- ( _3_) _PLEX for Apple TV will only play profile 8 correctly if CMv2.9 is used. However, we have also received reports that in some cases, it will fall back to HDR10, or you may encounter a black screen._



To prevent your TV from incorrectly indicating that it is playing DV follow the steps provided by an Infuse user: **“With Infuse ensure you set the Extended Dolby Vision settings to Limited (prefer accuracy), convert P8 to P5 (when possible), and play other P8 as HDR (output will switch to either DoVi or HDR depending on the video)”**

Dolby Vision Versions - CMv2.9 and CMv4.0 - \[Click to show/hide\]

There are two versions of Dolby Vision, namely CMv2.9 and CMv4.0. CMv4.0 uses an improved algorithm and a superior tone curve, allowing for better mapping and more controls during the Dolby Vision trim pass process.

More info about the different Dolby Vision Versions: [Dolby Vision Versions - CMv2.9 vs. CMv4.0](https://professionalsupport.dolby.com/s/article/When-should-I-use-CM-v2-9-or-CM-v4-0-and-can-I-convert-between-them?language=en_US)

* * *

## FAQ & INFO [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#faq-info "Permanent link")

### Proper and Repacks [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#proper-and-repacks "Permanent link")

Proper and Repacks - \[Click to show/hide\]

We also suggest that you change the Propers and Repacks settings in Radarr

`Media Management` =\> `File Management` to `Do Not Prefer` and use the [Repack/Proper](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#repackproper) Custom Format.

![!cf-mm-propers-repacks-disable](https://trash-guides.info/Radarr/images/cf-mm-propers-repacks-disable.png)

This way you make sure the Custom Format preferences will be used instead.

### How Does Custom Format Scoring Work? [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#how-does-custom-format-scoring-work "Permanent link")

How Does Custom Format Scoring Work? - \[Click to show/hide\]

Let’s say you have three custom formats, A, B and C. Scored as:

```
A: 10
B: 20
C: 30
```

Then, let’s say you have three releases, X, Y and Z. They happen to match your custom formats as follows:

```
X matches A
Y matches B and C
Z matches A and C
```

Total custom format scores would therefore be:

```
X: 10 (matches A)
Y: 50 (matches B and C)
Z: 40 (matches A and C)
```

Quality is the first check. If all three of our example releases here are the same quality - eg, WEBDL-1080p, then we move on to the next check which is custom format score. In the example above, Y would be chosen as it has the highest cumulative custom format score.

### Custom Formats to avoid certain releases [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#custom-formats-to-avoid-certain-releases "Permanent link")

How to use a Custom Format to avoid certain releases? - \[Click to show/hide\]

For Custom Formats you want to avoid, set it to something really low like `-10000` and not something like `-10`.
When you add your preferred Custom Format and set it to something like `+10`, it's possible that, for example, the `BR-DISK` will be downloaded - (-10)+(+10)=0 - if your `Minimum Custom Format Score` is set at `0`.

### Releases you should avoid [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#releases-you-should-avoid "Permanent link")

This is a must-have for every Quality Profile you use in our opinion. All these Custom Formats make sure you don't get low-quality releases.

Unwanted - \[Click to show/hide\]

| Custom Format | Score | Trash ID |
| --- | --- | --- |
| [BR-DISK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#br-disk) | -10000 | ed38b889b31be83fda192888e2286d83 |
| [Generated Dynamic HDR](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#generated-dynamic-hdr) | -10000 | e6886871085226c3da1830830146846c |
| [LQ](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq) | -10000 | 90a6f9a284dff5103f6346090e6280c8 |
| [LQ (Release Title)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#lq-release-title) | -10000 | e204b80c87be9497a8a6eaff48f72905 |
| [x265 (HD)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-hd)![⚠](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/26a0.svg) | -10000 | dc98083864ea246d05a42df0d05f81cc |
| [3D](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#3d) | -10000 | b8cd450cbfa689c0259a01d9e29ba3d6 |
| [Extras](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#extras) | -10000 | 0a3f082873eb454bde444150b70253cc |
| [Sing-Along Versions](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#sing-along-versions) | -10000 | 712d74cd88bceb883ee32f773656b1f5 |
| [AV1](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#av1) | -10000 | cae4ca30163749b891686f95532519bd |

* * *

Breakdown and Why

- **BR-DISK :** This is a custom format to help Radarr recognize & ignore BR-DISK (ISO's and Blu-ray folder structure) in addition to the standard BR-DISK quality.
- **Generated Dynamic HDR :** A collection of groups who are known to generate their own dynamic HDR metadata - Dolby Vision and/or HDR10+.
- **LQ:** A collection of known low-quality groups that are often banned from the top trackers due to their releases' lack of quality or other reasons.
- **LQ (Release Title):** A collection of terms seen in the titles of low-quality releases that are not captured by using a release group name.
- **x265 (HD):** This blocks 720/1080p (HD) releases that are encoded in x265.



If you have also added [x265 (no HDR/DV)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-no-hdrdv) to your Radarr,

then one of them should be scored as `0` in your quality profile.

- **3D:** Is 3D still a thing for home use ?

- **Extras:** Blocks releases that only contain extras
- **Sing-Along Versions:** Blocks releases that contain hardcoded sing-along lyrics for musical sections
- **AV1:** This blocks all releases encoded in AV1.

**AV1**



AV1 encodes are currently targeting small file sizes, rather than good visual quality.
  - This is a new codec and you need modern devices that support it.
  - We also had reports of playback/transcoding issues.
  - No main group is actually using it (yet).
  - It's better to ignore this new codec to prevent compatibility issues

### Custom Formats with a score of 0 [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#custom-formats-with-a-score-of-0 "Permanent link")

What do Custom Formats with a score of 0 do? - \[Click to show/hide\]

All Custom Formats with a score of 0 are purely informational and don't do anything.

### Minimum Custom Format Score [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#minimum-custom-format-score "Permanent link")

Minimum Custom Format Score - \[Click to show/hide\]

Some people suggest not to use negative scores for your Custom Formats and set this option to a higher score than 0.

The reason why we don't prefer/use this is because you could limit yourself when some new groups or whatever will be released.

Also, it makes it much more clear what you prefer and what you want to avoid.

### Audio Channels [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#audio-channels "Permanent link")

Audio Channels - \[Click to show/hide\]

Elsewhere in the guide, you will find a separate group of custom formats called `Audio Channels`. These will match the number of audio channels in a release, for example, 2.0 (stereo) or 5.1/7.1 (surround sound). We wouldn't add the audio channels Custom Formats as you could limit yourself in the amount of releases you're able to get. Only use them if you have a specific need for them.

Using this with any kind of Remux Quality Profile is useless, in our opinion, being that 99% of all Remuxes are multi-audio anyway. You can get better scores just by using the `Audio Formats` Custom Formats.

### Avoid using the x264/x265 Custom Format [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#avoid-using-the-x264x265-custom-format "Permanent link")

Avoid using the x264/x265 Custom Format - \[Click to show/hide\]

Avoid using the x264/x265 Custom Format with a score if possible, it's smarter to use the [x265 (HD)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-hd) Custom Format.

Something like 95% of video files are x264 and have much better direct play support. If you have more than a of couple users, you will notice much more transcoding.

Use x265 only for 4k releases and the [x265 (HD)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#x265-hd) makes sure you still get the x265 releases.

### Why am I getting purple or green colors [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#why-am-i-getting-purple-or-green-colors "Permanent link")

Why am I getting purple or green colors? - \[Click to show/hide\]

Why am I getting purple or green colors?

There are several possible reasons why your TV would show purple or green colors when playing Dolby Vision content.

1. **Unsupported Hardware**: Your TV or hardware media player device (Roku, Apple TV, etc) doesn't support Dolby Vision or your hardware media player device doesn't support all the Dolby Vision Profiles. As a result, the device might struggle to produce accurate colors, leading to a purple or green tint.

2. **Incorrect Display Settings**: Dolby Vision content often requires specific settings to be enabled on your TV or display device in order to deliver the intended visual experience. If these settings are not configured properly, it can result in the device showing distorted colors (including purple or green hues).

3. **HDMI Compatibility Issues**: Sometimes, HDMI cables or ports may not be fully compatible with Dolby Vision. If the media player device is not recognizing the Dolby Vision signal properly, it may fail to process the content correctly, resulting in abnormal color rendering.


To resolve the purple or green color issues when playing Dolby Vision content, you can try the following troubleshooting steps:

1. Ensure your TV or hardware media player device is Dolby Vision compatible and up-to-date with the latest firmware.
2. Verify that your TV or display device is set up correctly and has the necessary Dolby Vision settings enabled.
3. Check the HDMI cables and ensure they can transmit Dolby Vision signals.

### Dolby Vision Profiles [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#dolby-vision-profiles "Permanent link")

Dolby Vision Profiles - \[Click to show/hide\]

Dolby Vision Profiles

- **Profile 5**( _1_) \- This is what comes with WEB-DL Dolby Vision releases without HDR10 fallback.

( _Incompatible devices will playback with blown out pinks and greens_)
- **Profile 7**( _2_) \- This is what comes with UHD Bluray Remuxes and UHD BluRay releases.

_These files will play on an Nvidia Shield Pro (2019), but on most other players will revert to the HDR10 fallback._
- **Profile 8**( _3_) \- This is what comes with (Hybrid) WEB-DL (HULU), Hybrid UHD Remux, and UHD BluRay releases (all of which have HDR10 fallback).

_This works with several mainstream media players._


* * *

Apple TV Dolby Vision Limitations - \[Click to show/hide\]

Plex for Apple TV is only capable of playing Dolby Vision Profiles 5 and 8 correctly if CMv2.9 is being used.

Infuse 7.7.2+ offers expanded support for Dolby Vision Profile 8, including files containing CMv4.0 metadata, samples that were previously playing with a black screen, falling back to HDR10, or various other playback issues. [SOURCE](https://community.firecore.com/t/infuse-7-7-2-now-available/48208)

The Dolby Vision Profile and Version of a media file cannot be determined by automation software before downloading it, so when you are using an Apple TV, with or without Infuse, it will always be hit or miss whether the content is compatible or not.

Additionally, it is uncertain whether the Dolby Vision layer will play, fall back to HDR10, or result in a black screen.

- ( _1_) _PLEX for Apple TV and Plex with Infuse will only play profile 5 correctly if CMv2.9 is used._
- ( _2_) _Neither Infuse nor PLEX for Apple TV will deliver real Dolby Vision with Profile 7._
- ( _3_) _PLEX for Apple TV will only play profile 8 correctly if CMv2.9 is used. However, we have also received reports that in some cases, it will fall back to HDR10, or you may encounter a black screen._



To prevent your TV from incorrectly indicating that it is playing DV follow the steps provided by an Infuse user: **“With Infuse ensure you set the Extended Dolby Vision settings to Limited (prefer accuracy), convert P8 to P5 (when possible), and play other P8 as HDR (output will switch to either DoVi or HDR depending on the video)”**

Dolby Vision Versions - CMv2.9 and CMv4.0 - \[Click to show/hide\]

There are two versions of Dolby Vision, namely CMv2.9 and CMv4.0. CMv4.0 uses an improved algorithm and a superior tone curve, allowing for better mapping and more controls during the Dolby Vision trim pass process.

More info about the different Dolby Vision Versions: [Dolby Vision Versions - CMv2.9 vs. CMv4.0](https://professionalsupport.dolby.com/s/article/When-should-I-use-CM-v2-9-or-CM-v4-0-and-can-I-convert-between-them?language=en_US)

## Thanks [Permanent link](https://trash-guides.info/Radarr/radarr-setup-quality-profiles/\#thanks "Permanent link")

Special thanks to everyone who helped with the testing and creation of these Custom Formats.

* * *

Questions or Suggestions?

If you have questions or suggestions, click the button below to join our Discord server.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

Back to top
---

## Radarr Naming Scheme

[Skip to content](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#recommended-naming-scheme)

[Edit this page](https://github.com/TRaSH-Guides/Guides/edit/master/docs/Radarr/Radarr-recommended-naming-scheme.md "Edit this page") [View source of this page](https://github.com/TRaSH-Guides/Guides/raw/master/docs/Radarr/Radarr-recommended-naming-scheme.md "View source of this page")

# Recommended Naming Scheme [Permanent link](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/\#recommended-naming-scheme "Permanent link")

On the Radarr/Sonarr Discord, people often ask:

- "What's the best way to name my files and folders?"
- "Why doesn't my naming scheme work well?"

While naming is a personal choice, adding non-recoverable information to your filenames is strongly recommended for several good reasons.

## FAQ [Permanent link](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/\#faq "Permanent link")

Why should I include extra information in filenames?

- **Easy re-imports**: If you ever need to reinstall or re-import your media in Radarr/Sonarr or media servers like Plex/Emby/Jellyfin, having all the details in the filename helps everything get imported correctly. Without this info, files might get wrongly identified as HDTV or WEB-DL quality.
- **Prevents duplicate downloads**: Radarr/Sonarr won't accidentally download the same file again.

What's non-recoverable information and can't be recovered later?

- **Quality source** (HDTV, WEB-DL, Blu-ray, Remux, etc.)
- **Release group** (the team that created the release)
- **Edition type** (Director's Cut, Theatrical, Unrated, etc.)
- **Repack/Proper status** (whether it's a fixed version)

Why is the non-recoverable information important/needed?

- **Stops download loops**: With a proper naming Radarr/Sonarr knows what you already have.
- **Quality source**: Can you tell what quality `Movie (2023).mkv` is just by looking at it? Probably not. Without this info, you can't easily upgrade or downgrade your files, and you might download the same movie or TV show again.
- **Release group**: Knowing the release group helps you identify if there are known issues with that specific release. It also helps you find extra information about hybrid releases or source materials.
- **Edition type**: Tells you if you have the Director's Cut, Theatrical version, Unrated version, etc.
- **Repack/Proper**: Shows whether you have the fixed version or the original (possibly broken) release.

Don't Plex, Emby, and Jellyfin work fine with simple names like `movie (year).ext`/`tv showname SxxExx.ext`?

- Yes, they do work with simple names. However, these media servers only care about organizing and playing your files—they don't track quality or help prevent duplicate downloads. That's what Radarr/Sonarr handles.

Why are the recommended filenames so long?

- **Complete information**: To ensure your files have all the details needed to prevent download loops after import.
- **Only used parts show up**: If your file doesn't have certain attributes (like being a repack), those parts won't appear in the filename.
- **Media servers hide filenames anyway**: Plex, Emby, and Jellyfin display movie titles and show information, not the actual filename, so the length doesn't matter for viewing.

* * *

_This naming guide was created with help from the Sonarr/Radarr support team and community feedback._

* * *

## Getting Started [Permanent link](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/\#getting-started "Permanent link")

First, you need to set up Radarr to show all the naming options:

1. Go to **Settings** → **Media Management**
2. Enable **Show Advanced** at the top of the page

![Enable Advanced](https://trash-guides.info/Radarr/images/radarr-show-adavanced.png)

After you click this button, you'll see all the advanced options like this:

![Unhide Advanced](https://trash-guides.info/Radarr/images/unhide-advanced.png)

3. Enable **Rename Movies** to see the movie renaming options.

![Enable Rename Movies](https://trash-guides.info/Radarr/images/radarr-enable-rename.png)

4. Also make sure **Analyze video files** is enabled under **File Management**

![Enable Analyze video files](https://trash-guides.info/Radarr/images/radarr-enable-analyze-video-files.png)


## Standard Movie Format [Permanent link](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/\#standard-movie-format "Permanent link")

While both IMDb and TMDb IDs are unique, TMDb can occasionally remove IDs entirely, sometimes only to be re-added with a new ID later. However, due to using TMDb as its metadata source, they can be seen as "more aligned" with Radarr. IMDb IDs on the other hand, once present, are very accurate and rarely ever change.

[Standard](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#standard)[Plex](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#plex)[Emby](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#emby)[Jellyfin](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#jellyfin)

```
{Movie CleanTitle} {(Release Year)} - {{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Movie**: `The Movie Title (2010) {edition-Ultimate Extended Edition} [IMAX HYBRID][Bluray-1080p Proper][3D][DV HDR10][DTS 5.1][x264]-RlsGrp`

This naming scheme is designed to work with the [New Plex Agent](https://forums.plex.tv/t/new-plex-media-server-movie-scanner-and-agent-preview/593269/517).

[Plex (IMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#plex-imdb)[Plex (TMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#plex-tmdb)[Plex Anime (IMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#plex-anime-imdb)[Plex Anime (TMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#plex-anime-tmdb)

TMDb is usually better as it guarantees a match, IMDb only gets matched if the TMDb entry has the correct IMDb ID association.

```
{Movie CleanTitle} {(Release Year)} {imdb-{ImdbId}} - {edition-{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Movie**: `The Movie Title (2010) {imdb-tt0066921} {edition-Ultimate Extended Edition} [IMAX HYBRID][Bluray-1080p Proper][3D][DV HDR10][DTS 5.1][x264]-RlsGrp`

```
{Movie CleanTitle} {(Release Year)} {tmdb-{TmdbId}} - {edition-{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Movie**: `The Movie Title (2010) {tmdb-345691} {edition-Ultimate Extended Edition} [IMAX HYBRID][Bluray-1080p Proper][3D][DV HDR10][DTS 5.1][x264]-RlsGrp`

TMDb is usually better as it guarantees a match, IMDb only gets matched if the TMDb entry has the correct IMDb ID association.

```
{Movie CleanTitle} {(Release Year)} {imdb-{ImdbId}} - {edition-{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{MediaInfo AudioLanguages}{[MediaInfo VideoDynamicRangeType]}[{Mediainfo VideoCodec }{MediaInfo VideoBitDepth}bit]{-Release Group}
```

**Movie**: `The Movie Title (2010) {imdb-tt0066921} {edition-Ultimate Extended Edition} [Surround Sound x264][Bluray-1080p Proper][3D][DTS 5.1][DE][10bit][AVC]-RlsGrp`

```
{Movie CleanTitle} {(Release Year)} {tmdb-{TmdbId}} - {edition-{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{MediaInfo AudioLanguages}{[MediaInfo VideoDynamicRangeType]}[{Mediainfo VideoCodec }{MediaInfo VideoBitDepth}bit]{-Release Group}
```

**Movie**: `The Movie Title (2010) {tmdb-345691} {edition-Ultimate Extended Edition} [Surround Sound x264][Bluray-1080p Proper][3D][DTS 5.1][DE][10bit][AVC]-RlsGrp`

If you use the `{edition-{Edition Tags}}` part of the recommended file name, Plex will recognize the movie edition and add it to the Plex interface - for example, Director's Cut.

However, this means that if you have two copies of a movie with different editions in a single merged library - for example, a 1080p Director's Cut and a 2160p Theatrical Edition - these will appear as two separate items in Plex.

If you want a movie to appear only once per library when you keep more than one copy of a movie, replace: `{edition-{Edition Tags}}` with `{Edition Tags}`.

[Plex Edition Alternative (IMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#plex-edition-alternative-imdb)[Plex Edition Alternative (TMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#plex-edition-alternative-tmdb)

TMDb is usually better as it guarantees a match, IMDb only gets matched if the TMDb entry has the correct IMDb ID association.

```
{Movie CleanTitle} {(Release Year)} {imdb-{ImdbId}} - {{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Movie**: `The Movie Title (2010) {imdb-tt0066921} {Ultimate Extended Edition} [IMAX HYBRID][Bluray-1080p Proper][3D][DV HDR10][DTS 5.1][x264]-RlsGrp`

```
{Movie CleanTitle} {(Release Year)} {tmdb-{TmdbId}} - {{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Movie**: `The Movie Title (2010) {tmdb-345691} {Ultimate Extended Edition} [IMAX HYBRID][Bluray-1080p Proper][3D][DV HDR10][DTS 5.1][x264]-RlsGrp`

Source: [Emby Wiki/Docs](https://emby.media/support/articles/Movie-Naming.html#id-tags-in-folder--file-names)

[Emby (IMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#emby-imdb)[Emby (TMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#emby-tmdb)[Emby Anime (IMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#emby-anime-imdb)[Emby Anime (TMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#emby-anime-tmdb)

TMDb is usually better as it guarantees a match, IMDb only gets matched if the TMDb entry has the correct IMDb ID association.

```
{Movie CleanTitle} {(Release Year)} [imdb-{ImdbId}] - {edition-{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Movie**: `The Movie Title (2010) [imdbid-tt0066921] - {edition-Ultimate Extended Edition} [IMAX HYBRID][Bluray-1080p Proper][3D][DV HDR10][DTS 5.1][x264]-RlsGrp`

```
{Movie CleanTitle} {(Release Year)} [tmdb-{TmdbId}] - {edition-{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Movie**: `The Movie Title (2010) [tmdbid-tt0066921] - {edition-Ultimate Extended Edition} [IMAX HYBRID][Bluray-1080p Proper][3D][DV HDR10][DTS 5.1][x264]-RlsGrp`

TMDb is usually better as it guarantees a match, IMDb only gets matched if the TMDb entry has the correct IMDb ID association.

```
{Movie CleanTitle} {(Release Year)} [imdb-{ImdbId}] - {edition-{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{MediaInfo AudioLanguages}{[MediaInfo VideoDynamicRangeType]}[{Mediainfo VideoCodec }{MediaInfo VideoBitDepth}bit]{-Release Group}
```

**Movie**: `The Movie Title (2010) [imdbid-tt0066921] - {edition-Ultimate Extended Edition} [Surround Sound x264][Bluray-1080p Proper][3D][DTS 5.1][DE][10bit][AVC]-RlsGrp`

```
{Movie CleanTitle} {(Release Year)} [tmdb-{TmdbId}] - {edition-{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{MediaInfo AudioLanguages}{[MediaInfo VideoDynamicRangeType]}[{Mediainfo VideoCodec }{MediaInfo VideoBitDepth}bit]{-Release Group}
```

**Movie**: `The Movie Title (2010) [tmdbid-tt0066921] - {edition-Ultimate Extended Edition} [Surround Sound x264][Bluray-1080p Proper][3D][DTS 5.1][DE][10bit][AVC]-RlsGrp`

Source: [Jellyfin Wiki/Docs](https://jellyfin.org/docs/general/server/media/movies)

[Jellyfin (IMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#jellyfin-imdb)[Jellyfin (TMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#jellyfin-tmdb)[Jellyfin Anime (IMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#jellyfin-anime-imdb)[Jellyfin Anime (TMDb)](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#jellyfin-anime-tmdb)

```
{Movie CleanTitle} {(Release Year)} [imdbid-{ImdbId}] - {{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Movie**: `The Movie Title (2010) [imdbid-tt0106145] - {edition-Ultimate Extended Edition} [IMAX HYBRID][Bluray-1080p Proper][3D][DV HDR10][DTS 5.1][x264]-RlsGrp`

```
{Movie CleanTitle} {(Release Year)} [tmdbid-{TmdbId}] - {{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{-Release Group}
```

**Movie**: `The Movie Title (2010) [tmdbid-65567] - {edition-Ultimate Extended Edition} [IMAX HYBRID][Bluray-1080p Proper][3D][DV HDR10][DTS 5.1][x264]-RlsGrp`

```
{Movie CleanTitle} {(Release Year)} [imdbid-{ImdbId}] - {{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{MediaInfo AudioLanguages}{[MediaInfo VideoDynamicRangeType]}[{Mediainfo VideoCodec }{MediaInfo VideoBitDepth}bit]{-Release Group}
```

**Movie**: `The Movie Title (2010) [imdbid-tt0106145] - {edition-Ultimate Extended Edition} [Surround Sound x264][Bluray-1080p Proper][3D][DTS 5.1][DE][10bit][AVC]-RlsGrp`

```
{Movie CleanTitle} {(Release Year)} [tmdbid-{TmdbId}] - {{Edition Tags}} {[MediaInfo 3D]}{[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{MediaInfo AudioLanguages}{[MediaInfo VideoDynamicRangeType]}[{Mediainfo VideoCodec }{MediaInfo VideoBitDepth}bit]{-Release Group}
```

**Movie**: `The Movie Title (2010) [tmdbid-65567] - {edition-Ultimate Extended Edition} [Surround Sound x264][Bluray-1080p Proper][3D][DTS 5.1][DE][10bit][AVC]-RlsGrp`

* * *

## Alternative Movie Naming Options [Permanent link](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/\#alternative-movie-naming-options "Permanent link")

These are other standard movie format naming schemes that work well. Use these if you don't like the brackets used in the main recommendations.

### Original Title [Permanent link](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/\#original-title "Permanent link")

Another option is to use `{Original Title}` instead of the recommended naming scheme above. `{Original Title}` uses the title of the release, which includes all the information from the release itself. The benefit of this naming scheme is that it prevents download loops that can happen during import when there's a mismatch between the release title and the file contents (for example, if the release title says DTS-ES but the contents are actually DTS). The downside is that you have less control over how the files are named.

If you use this alternate naming scheme, we suggest using `{Original Title}` instead of `{Original Filename}`.

Why?

The filename can be obscured or unclear, whereas the release naming is clear, especially when you use Usenet.

`{Original Title}` =\> `The.Movie.Title.2010.REMASTERED.1080p.BluRay.x264-RlsGrp`

`{Original Filename}` =\> `rlsgrp-karatekid-1080p` or `lchd-tkk1080p` or `t1i0p3s7i8yuti`

* * *

### P2P/Scene Naming [Permanent link](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/\#p2pscene-naming "Permanent link")

Use P2P/Scene naming if you don't like spaces and brackets in the filename. It's the closest to the P2P/scene naming scheme, except it uses the exact audio and HDR formats from the media file, where the original release or filename might be unclear.

```
{Movie.CleanTitle}{.Release.Year}{.Edition.Tags}{.MediaInfo.3D}{.Custom.Formats}{.Quality.Full}{.Mediainfo.AudioCodec}{.Mediainfo.AudioChannels}{.MediaInfo.VideoDynamicRangeType}{.Mediainfo.VideoCodec}{-Release Group}
```

**Movie**: `The.Movie.Title.2010.Ultimate.Extended.Edition.3D.Hybrid.Remux-2160p.TrueHD.Atmos.7.1.DV.HDR10Plus.HEVC-RlsGrp`

**Movie**: `The.Movie.Title.2010.MA.WEBDL-2160p.TrueHD.Atmos.7.1.DV.HDR10Plus.h265-RlsGrp`

* * *

## Movie Folder Format [Permanent link](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/\#movie-folder-format "Permanent link")

While both IMDb and TMDb IDs are unique, TMDb can occasionally remove IDs entirely, sometimes only to be re-added with a new ID later. However, due to using TMDb as its metadata source, they can be seen as "more aligned" with Radarr. IMDb IDs on the other hand, once present, are very accurate and rarely ever change.

Please note that folder names are created in the database when the movie is added to Radarr, and the ID may be missing or wrong at that time. This could result in your folder having a blank ID. ![‼](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/203c.svg)

If you add the ID to the filename instead, the IMDb/TMDb ID will be pulled fresh for any download or upgrade.

[Standard Folder](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#standard-folder)[Optional Plex](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#optional-plex)[Optional Emby](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#optional-emby)[Optional Jellyfin](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#optional-jellyfin)

The minimum needed and recommended format

```
{Movie CleanTitle} ({Release Year})
```

**Example**: `The Movie Title (2010)`

Keep in mind adding anything additional after the release year could give issues during a fresh import into Radarr, but it can help for movies that have the same release name and year

[Plex Folder IMDb](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#plex-folder-imdb)[Plex Folder TMDb](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#plex-folder-tmdb)

TMDb is usually better as it guarantees a match, IMDb only gets matched if the TMDb entry has the correct IMDb ID association.

```
{Movie CleanTitle} ({Release Year}) {imdb-{ImdbId}}
```

**Example**: `The Movie Title (2010) {imdb-tt1520211}`

```
{Movie CleanTitle} ({Release Year}) {tmdb-{TmdbId}}
```

**Example**: `The Movie Title (2010) {tmdb-1520211}`

Keep in mind adding anything additional after the release year could give issues during a fresh import into Radarr, but it can help for movies that have the same release name and year

[Emby Folder IMDb](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#emby-folder-imdb)[Emby Folder TMDb](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#emby-folder-tmdb)

TMDb is usually better as it guarantees a match, IMDb only gets matched if the TMDb entry has the correct IMDb ID association.

```
{Movie CleanTitle} ({Release Year}) [imdb-{ImdbId}]
```

**Example**: `The Movie Title (2010) [imdb-tt1520211]`

```
{Movie CleanTitle} ({Release Year}) [tmdb-{TmdbId}]
```

**Example**: `The Movie Title (2010) [tmdb-1520211]`

Keep in mind adding anything additional after the release year could give issues during a fresh import into Radarr, but it can help for movies that have the same release name and year

[Jellyfin Folder IMDb](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#jellyfin-folder-imdb)[Jellyfin Folder TMDb](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/#jellyfin-folder-tmdb)

TMDb is usually better as it guarantees a match, IMDb only gets matched if the TMDb entry has the correct IMDb ID association.

```
{Movie CleanTitle} ({Release Year}) [imdbid-{ImdbId}]
```

**Example**: `The Movie Title (2010) [imdbid-tt1520211]`

```
{Movie CleanTitle} ({Release Year}) [tmdbid-{TmdbId}]
```

**Example**: `The Movie Title (2010) [tmdbid-1520211]`

* * *

Questions or Suggestions?

If you have questions or suggestions, click the button below to join our Discord server.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

Back to top