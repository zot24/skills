<!-- Source: Scraped from trash-guides.info via Firecrawl -->

[Skip to content](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/#hardlinks-and-instant-moves-atomic-moves)

[Edit this page](https://github.com/TRaSH-Guides/Guides/edit/master/docs/File-and-Folder-Structure/Hardlinks-and-Instant-Moves.md "Edit this page") [View source of this page](https://github.com/TRaSH-Guides/Guides/raw/master/docs/File-and-Folder-Structure/Hardlinks-and-Instant-Moves.md "View source of this page")

# Hardlinks and Instant Moves (Atomic-Moves) [Permanent link](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/\#hardlinks-and-instant-moves-atomic-moves "Permanent link")

## Description [Permanent link](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/\#description "Permanent link")

Info

If you’re wondering why hardlinks aren’t working or why a simple move is taking far longer than it should.

Here we will try to explain it.

This guide consists of 4 sections.

1. This page with a short description.
2. [How to set up](https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/) for your installation method.
3. [Examples](https://trash-guides.info/File-and-Folder-Structure/Examples/) What you should use for your path settings in your used applications.
4. [Check if hardlinks are working](https://trash-guides.info/File-and-Folder-Structure/Check-if-hardlinks-are-working/)

So you want one of the following?

- Instant moves (Atomic-Moves) during import of the Starr Apps (useful when using Usenet)?
- You don't want to use twice the storage when using torrents. (hardlinks)?
- You want to perma-seed?

Then Continue to [How to set up](https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/) for your installation method.

## FAQ [Permanent link](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/\#faq "Permanent link")

### Hardlinks Limitations [Permanent link](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/\#hardlinks-limitations "Permanent link")

\- You CAN'T create hardlinks for directories ![‼](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/203c.svg)

\- You CAN'T hardlink across separate file systems, partitions, volumes or mounts ![‼](https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/svg/203c.svg)

\- Some file systems, such as exFAT, are known not to support hardlinks and should be avoided (double-check if you are unsure!).

### What are Hardlinks [Permanent link](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/\#what-are-hardlinks "Permanent link")

**What are hardlinks?** \- \[Click to show/hide\]

- \[ **Short answer**\] Having a file in multiple locations without using double your storage space.
- \[ **Long answer**\] Hardlinks allow a copy operation to be instant and not consume space for those additional copies.

Every file is a hardlink: some metadata that points at blocks on the file system, **which is why they're restricted to the same file system**. There can be as many metadata files pointing at those blocks as needed, and the blocks know how many links point to them. Once the blocks have 0 links, they're considered deleted.

This means:


  - You can delete any "copy" without impacting other instances (hardlinks).

    Your download client can remove its "copy" without impacting the library "copy". The library "copy" can also be removed by Plex, Sonarr/Radarr, or manually without impacting your download client's "copy".

  - Space is only reclaimed once all "copies" of hardlinked data are deleted.

  - Modifying any copy of a hardlinked file will impact all "copies".

    For example, modifying the id3 tags of a .mp3 download after import would change the download client "copy", breaking the torrent.


[More info from Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Hard_link)

Don't forget to read the [Hardlinks limitations](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/#hardlinks-limitations)

### What are Instant Moves (Atomic Moves) [Permanent link](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/\#what-are-instant-moves-atomic-moves "Permanent link")

**What are Instant Moves (Atomic Moves)?** \- \[Click to show/hide\]

This is a real move, not a copying of a file from the download folder to the media folder and then deleting the file from the download folder.

### What are the Starr Apps [Permanent link](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/\#what-are-the-starr-apps "Permanent link")

**What are the `Starr Apps`?** \- \[Click to show/hide\]

Sonarr, Radarr, Lidarr, etc.

* * *

Questions or Suggestions?

If you have questions or suggestions, click the button below to join our Discord server.

[Click For Support](https://trash-guides.info/discord)[![Discord chat](https://img.shields.io/discord/492590071455940612?style=for-the-badge&color=4051B5&logo=discord)](https://trash-guides.info/discord)

Back to top