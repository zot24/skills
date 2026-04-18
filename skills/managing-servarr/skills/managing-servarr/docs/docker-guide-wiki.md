* * *

Docker Guide

Servarr Docker Guide - Overview of Docker Concepts, Hardlink Concepts, and Linux Ownership and Permissions

* * *

Page Contents

Table of Contents

The Best Docker Setup

Portainer

Introduction

Multiple users and a shared group

Permissions

UMASK

PUID and PGID

Example

Single user and optional shared group

Ownership and permissions of /config

Consistent and well planned paths

Examples

Issues

Running containers using

Docker Compose

docker run

Systemd

Helpful commands

List running containers

Shell inside a container

Prune Docker

Get docker run command

Get docker-compose

Troubleshoot networking

Recursively chown user and group

Recursively chmod to 775/664

Find UID/GID for user

Examine files for hard links

Interesting Docker Images

All-in-One Solutions

Custom Docker Network and DNS

Using .internal Domain for Container Communication

Common Problems

Correct outside paths, incorrect inside paths

Running Docker containers as root or changing users around

Running Docker containers with umask 000

Getting Help

Chat Support (Discord)

Forum Support (Reddit)

Tags

[radarr](https://wiki.servarr.com/t/radarr) [sonarr](https://wiki.servarr.com/t/sonarr) [lidarr](https://wiki.servarr.com/t/lidarr) [readarr](https://wiki.servarr.com/t/readarr) [prowlarr](https://wiki.servarr.com/t/prowlarr) [troubleshooting](https://wiki.servarr.com/t/troubleshooting) [docker](https://wiki.servarr.com/t/docker) [synology](https://wiki.servarr.com/t/synology) [installation](https://wiki.servarr.com/t/installation) [whisparr](https://wiki.servarr.com/t/whisparr) [scripts](https://wiki.servarr.com/t/scripts) [Pages matching tags](https://wiki.servarr.com/t/radarr/sonarr/lidarr/readarr/prowlarr/troubleshooting/docker/synology/installation/whisparr/scripts)

Last edited by

Administrator

10/05/2025

# [¶](https://wiki.servarr.com/en/docker-guide\#table-of-contents) Table of Contents

- [Table of Contents](https://wiki.servarr.com/en/docker-guide#table-of-contents)
- [The Best Docker Setup](https://wiki.servarr.com/en/docker-guide#the-best-docker-setup)
- [Portainer](https://wiki.servarr.com/en/docker-guide#portainer)
- [Introduction](https://wiki.servarr.com/en/docker-guide#introduction)
- [Multiple users and a shared group](https://wiki.servarr.com/en/docker-guide#multiple-users-and-a-shared-group)
  - [Permissions](https://wiki.servarr.com/en/docker-guide#permissions)
  - [UMASK](https://wiki.servarr.com/en/docker-guide#umask)
  - [PUID and PGID](https://wiki.servarr.com/en/docker-guide#puid-and-pgid)
  - [Example](https://wiki.servarr.com/en/docker-guide#example)
- [Single user and optional shared group](https://wiki.servarr.com/en/docker-guide#single-user-and-optional-shared-group)
- [Ownership and permissions of /config](https://wiki.servarr.com/en/docker-guide#ownership-and-permissions-of-config)
- [Consistent and well planned paths](https://wiki.servarr.com/en/docker-guide#consistent-and-well-planned-paths)
  - [Examples](https://wiki.servarr.com/en/docker-guide#examples)
    - [Torrents](https://wiki.servarr.com/en/docker-guide#torrents)
    - [Usenet](https://wiki.servarr.com/en/docker-guide#usenet)
    - [Media Server](https://wiki.servarr.com/en/docker-guide#media-server)
    - [Sonarr, Radarr and Lidarr](https://wiki.servarr.com/en/docker-guide#sonarr-radarr-and-lidarr)
  - [Issues](https://wiki.servarr.com/en/docker-guide#issues)
- [Running containers using](https://wiki.servarr.com/en/docker-guide#running-containers-using)
  - [Docker Compose](https://wiki.servarr.com/en/docker-guide#docker-compose)
    - [Update all images and containers](https://wiki.servarr.com/en/docker-guide#update-all-images-and-containers)
    - [Update individual image and container](https://wiki.servarr.com/en/docker-guide#update-individual-image-and-container)
  - [docker run](https://wiki.servarr.com/en/docker-guide#docker-run)
  - [Systemd](https://wiki.servarr.com/en/docker-guide#systemd)
- [Helpful commands](https://wiki.servarr.com/en/docker-guide#helpful-commands)
  - [List running containers](https://wiki.servarr.com/en/docker-guide#list-running-containers)
  - [Shell _inside_ a container](https://wiki.servarr.com/en/docker-guide#shell-inside-a-container)
    - [Examples as Specific Users](https://wiki.servarr.com/en/docker-guide#examples-as-specific-users)
      - [LSIO Radarr](https://wiki.servarr.com/en/docker-guide#lsio-radarr)
      - [Hotio Sonarr](https://wiki.servarr.com/en/docker-guide#hotio-sonarr)
  - [Prune Docker](https://wiki.servarr.com/en/docker-guide#prune-docker)
  - [Get docker run command](https://wiki.servarr.com/en/docker-guide#get-docker-run-command)
  - [Get docker-compose](https://wiki.servarr.com/en/docker-guide#get-docker-compose)
  - [Troubleshoot networking](https://wiki.servarr.com/en/docker-guide#troubleshoot-networking)
  - [Recursively chown user and group](https://wiki.servarr.com/en/docker-guide#recursively-chown-user-and-group)
  - [Recursively chmod to 775/664](https://wiki.servarr.com/en/docker-guide#recursively-chmod-to-775664)
  - [Find UID/GID for user](https://wiki.servarr.com/en/docker-guide#find-uidgid-for-user)
  - [Examine files for hard links](https://wiki.servarr.com/en/docker-guide#examine-files-for-hard-links)
- [Interesting Docker Images](https://wiki.servarr.com/en/docker-guide#interesting-docker-images)
  - [All-in-One Solutions](https://wiki.servarr.com/en/docker-guide#all-in-one-solutions)
- [Custom Docker Network and DNS](https://wiki.servarr.com/en/docker-guide#custom-docker-network-and-dns)
- [Common Problems](https://wiki.servarr.com/en/docker-guide#common-problems)
  - [Correct _outside_ paths, incorrect _inside_ paths](https://wiki.servarr.com/en/docker-guide#correct-outside-paths-incorrect-inside-paths)
  - [Running Docker containers as root or changing users around](https://wiki.servarr.com/en/docker-guide#running-docker-containers-as-root-or-changing-users-around)
  - [Running Docker containers with umask 000](https://wiki.servarr.com/en/docker-guide#running-docker-containers-with-umask-000)
- [Getting Help](https://wiki.servarr.com/en/docker-guide#getting-help)
  - [Chat Support (Discord)](https://wiki.servarr.com/en/docker-guide#chat-support-discord)

# [¶](https://wiki.servarr.com/en/docker-guide\#the-best-docker-setup) The Best Docker Setup

> `Multiple users and a shared group` does not apply to Unraid which does things a little differently and runs all containers as `nobody:users`. See TRaSH's Hardlink's Unraid Guide for details and the `Consistent and well planned paths` section that does apply.

**TL;DR**: An [eponymous](https://www.dictionary.com/browse/eponymous) user per daemon and a shared group with a umask of `002`. Consistent path definitions between _all_ containers that maintains the folder structure. Using one volume (so the download folder and library folder are on the same file system) makes [hardlinks](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/#what-are-hardlinks) and [instant moves (atomic moves)](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/#what-are-instant-moves-atomic-moves) possible for Sonarr, Radarr, Lidarr and Readarr. And most of all, ignore _most_ of the Docker image’s path documentation!

> Note: Many folks find [TRaSH's Hardlink Tutorial](https://trash-guides.info/hardlinks/) helpful and easier to understand than this guide. This guide is more conceptual in nature while TRaSH's tutorial walks you through the process.

# [¶](https://wiki.servarr.com/en/docker-guide\#portainer) Portainer

> **Portainer should be avoided for setting up docker containers**

- Portainer gives a pretty GUI for managing containers, but that is all it is useful for.
- Portainer should only for viewing docker container logs / container status.
- It's strongly suggested to use Docker compose and to not use Portainer.
- Portainer has many issues, such as:
  - Incorrect order of source and target of mounts
  - Inconsistent case-sensitivity
  - No automatically created custom networks for inter-container communication
  - Inconsistent compose implementations on different architectures
  - Pulls every tag on update when you don't set a specific tag
  - Capabilities are hidden and some don't work at all on ARM platforms

See this [Docker Guide](https://wiki.servarr.com/docker-guide) and [TRaSH's Docker Tutorial](https://trash-guides.info/hardlinks/) instead for how to setup Docker Compose.

# [¶](https://wiki.servarr.com/en/docker-guide\#introduction) Introduction

This article will not show you specifics about the best Docker setup, but it describes an overview that you can use to make your own setup the best that it can be. The idea is that you run each Docker container as its own user, with a shared group and consistent volumes so every container sees the same path layout. This is easy to say, but not so easy to understand and explain.

> Reminder that many folks find [TRaSH's Hardlink Tutorial](https://trash-guides.info/hardlinks/) helpful and easier to understand than this guide. This guide is more conceptual in nature while TRaSH's tutorial walks you through the process.

# [¶](https://wiki.servarr.com/en/docker-guide\#multiple-users-and-a-shared-group) Multiple users and a shared group

> This does not apply to Unraid which does things a little differently and runs all containers as `nobody:users` and should generally be the same single user and single group.

## [¶](https://wiki.servarr.com/en/docker-guide\#permissions) Permissions

Ideally, each software runs as its own user and they are all part of a shared group with folder permissions set to `775` (`drwxrwxr-x`) and files set to `664` (`-rw-rw-r--`), which is a umask of `002`. A sane alternative to this is a single shared user, which would use `755` and `644` which is a umask of `022`. You can restrict permissions even more by denying read from “other”, which would be a umask of `007` for a user per daemon or `077` for a single shared user. For a deeper explanation, try the Arch Linux wiki articles about [file permissions and attributes](https://wiki.archlinux.org/index.php/File_permissions_and_attributes) and [UMASK](https://wiki.archlinux.org/index.php/Umask).

## [¶](https://wiki.servarr.com/en/docker-guide\#umask) UMASK

Many Docker images accept `-e UMASK=002` as an environment variable and some software can be configured with a user, group and umask (NZBGet) or folder/file permission (Sonarr/Radarr), inside the container. This will ensure that files and folders created by _one_ can be read and written by the others. If you are using existing folders and files, you will need to fix their current ownership and permissions too, but going forward they will be correct because you set each software up right.

## [¶](https://wiki.servarr.com/en/docker-guide\#puid-and-pgid) PUID and PGID

Many Docker images also take a `-e PUID=123` and `-e PGID=321` that lets you change the UID/GID used inside to that of an account on the outside. If you ever peek in, you’ll find that username is something like `abc`, `nobody` or `hotio`, but because it uses the UID/GID you pass in, on the outside it looks like the expected user. If you’re using storage from another system via NFS or CIFS, it will make your life easier if _that_ system also has matching users and group. Perhaps let one system pick the UID/GIDs, then re-use those on the other system, assuming they don’t conflict.

## [¶](https://wiki.servarr.com/en/docker-guide\#example) Example

You run [Sonarr](https://github.com/Sonarr/Sonarr/releases) using [hotio/sonarr](https://github.com/hotio/docker-sonarr), you’ve created a `sonarr` user with uid `123` and a shared group `media` with gid `321` which the `sonarr` user is a member of. You configure the Docker image to run with `-e PUID=123 -e PGID=321 -e UMASK=002`. Sonarr also lets you configure the user, group as well as folder and file permissions. The previous settings should negate these, but you could configure them if you wanted. An UMASK of `002` results in `775` (`drwxrwxr-x`) for folders and `664` (`-rw-rw-r--`) for files. and the user/group are a little tricky because _inside_ the container, they have a different name. Typically they are `abc` or `nobody`.

# [¶](https://wiki.servarr.com/en/docker-guide\#single-user-and-optional-shared-group) Single user and optional shared group

Another popular and arguably easier option is a single, shared user. Perhaps even _your_ user. It isn’t as secure and doesn’t follow best practices, but in the end it is easier to understand and implement. The UMASK for this is `022` which results in `755` (`drwxr-xr-x`) for folders and `644` (`-rw-r--r--`) for files. The group no longer really matters, so you’ll probably just use the group named after the user. This does make it harder to share with _other_ users, so you may still end up wanting a UMASK of `002` even with this setup.

# [¶](https://wiki.servarr.com/en/docker-guide\#ownership-and-permissions-of-config) Ownership and permissions of /config

Don’t forget that your `/config` volume will _also_ need to have correct ownership and permissions, usually the daemon’s user and that user’s group like `sonarr:sonarr` and a umask of `022` or `077` so _only_ that user has access. In a single user setup, this would of course be the one user you’ve chosen.

# [¶](https://wiki.servarr.com/en/docker-guide\#consistent-and-well-planned-paths) Consistent and well planned paths

> Many folks find [TRaSH's Hardlink Tutorial](https://trash-guides.info/hardlinks) helpful and easier to understand than this guide. This guide is more conceptual in nature while TRaSH's tutorial walks you through the process.

The easiest and most important detail is to create unified path definitions across all the containers.

If you’re wondering why hard links aren’t working or why a simple move is taking far longer than it should, this section explains it. The paths you use on the _inside_ matter. Because of how Docker’s volumes work, passing in two volumes such as the commonly suggested `/tv`, `/movies`, and `/downloads` makes them look like two different file systems, even if they are a single file system outside the container. This means hard links won’t work _and_ instead of an instant/atomic move, a slower and more IO intensive copy+delete is used. If you have multiple download clients because you’re using torrents and usenet, having a single `/downloads` path means they’ll be mixed up. Because the Radarr in one container will ask the NZBGet in its own container where files are, using the same path in both means it will all just work. If you don’t, you’d need to fix it with a remote path map.

So pick _one_ path layout and use it for all of them. It's suggested to use `/data`, but there are other common names like `/shared`, `/media` or `/dvr`. Keeping this the same on the outside _and_ inside will make your setup simpler: one path to remember or if integrating Docker and native software. For example, Synology might use `/Volume1/data` and unRAID might use `/mnt/user/data` on the outside, but `/data` on the inside is fine.

It is also important to remember that you’ll need to setup or re-configure paths in the software running _inside_ these Docker containers. If you change the paths for your download client, you’ll need to edit its settings to match and likely update existing torrents. If you change your library path, you’ll need to change those settings in Sonarr, Radarr, Lidarr, Plex, etc.

## [¶](https://wiki.servarr.com/en/docker-guide\#examples) Examples

What matters here is the general structure, not the names. You are free to pick folder names that make sense to you. And there are other ways of arranging things too. For example, you’re not likely to download and run into conflicts of identical releases between usenet and torrents, so you _could_ put both in `/data/downloads/{movies|books|music|tv}` folders. Downloads don’t even have to be sorted into subfolders either, since movies, music and tv will rarely conflict.

This example `data` folder has subfolders for torrents and usenet and each of these have subfolders for tv, movie and music downloads to keep things neat. The `media` folder has nicely named `tv`, `movies`, `books`, and `music` subfolders. This `media` folder is your library and what you’d pass to Plex, Kodi, Emby, Jellyfin, etc.

For the below example `data` is equivalent to the host path `/host/data` and the docker path `/data`

```none

```

Copy

The path for each Docker container can be as specific as needed while still maintaining the correct structure:

### [¶](https://wiki.servarr.com/en/docker-guide\#torrents) Torrents

```none

```

Copy

Torrents only needs access to torrent files, so pass it `-v /host/data/torrents:/data/torrents`. In the torrent software settings, you’ll need to reconfigure paths and you can sort into subfolders like`/data/torrents/{tv|books|movies|music}`.

### [¶](https://wiki.servarr.com/en/docker-guide\#usenet) Usenet

```none

```

Copy

Usenet only needs access to usenet files, so pass it `-v /host/data/usenet:/data/usenet`. In the usenet software settings, you’ll need to reconfigure paths and you can sort into subfolders like`/data/usenet/{tv|movies|music}`.

### [¶](https://wiki.servarr.com/en/docker-guide\#media-server) Media Server

```none

```

Copy

Plex/Emby only needs access to your media library, so pass `-v /host/data/media:/data/media`, which can have any number of subfolders like `movies`, `kids movies`, `tv`, `documentary tv` and/or `music` as sub folders.

### [¶](https://wiki.servarr.com/en/docker-guide\#sonarr-radarr-and-lidarr) Sonarr, Radarr and Lidarr

```none

```

Copy

Sonarr, Radarr and Lidarr get everything using `-v /host/data:/data` because the _download_ folder(s) and _media_ folder will look like and _be_ one file system. Hard links will work and moves will be atomic, instead of copy + delete.

## [¶](https://wiki.servarr.com/en/docker-guide\#issues) Issues

There are a couple minor issues with not following the Docker image’s suggested paths.

The biggest is that volumes defined in the `dockerfile` will get created if they’re not specified, this means they’ll pile up as you delete and re-create the containers. If they end up with data in them, they can consume space unexpectedly and likely in an unsuitable place. You can find a [cleanup command](https://wiki.servarr.com/en/docker-guide#prune-docker) in the helpful commands section below. This could also be mitigated by passing in an empty folder for all the volumes you don’t want to use, like `/data/empty:/movies` and `/data/empty:/downloads`. Maybe even put a file named `DO NOT USE THIS FOLDER` inside, to remind yourself.

Another problem is that some images are pre-configured to use the documented volumes, so you’ll need to change settings in the software inside the Docker container. Thankfully, since configuration persists outside the container this is a one time issue. You might also pick a path like `/data` or `/media` which some images already define for a specific use. It shouldn’t be a problem, but will be a little more confusing when combined with the previous issues. In the end, it is worth it for working hard links and fast moves. The consistency and simplicity are welcome side effects as well.

If you use the latest version of the abandoned [RadarrSync](https://github.com/Sperryfreak01/RadarrSync) to synchronize two Radarr instances, it _depends_ on mapping the _same_ path inside to a different path on the outside, for example `/movies` for one instance would point at `/data/media/movies` and the other at `/data/media/movies4k`. This breaks _everything_ you’ve read above. There is no good solution, you either use the old version which isn’t as good, do your mapping in a way that is ugly and breaks hard links or just don’t use it at all.

# [¶](https://wiki.servarr.com/en/docker-guide\#running-containers-using) Running containers using

## [¶](https://wiki.servarr.com/en/docker-guide\#docker-compose) Docker Compose

This is the best option for most users, it lets you control and configure many containers and their interdependence in one file. A good starting place is Docker’s own [Get started with Docker Compose](https://docs.docker.com/compose/gettingstarted/). You can use [composerize](https://composerize.com/) or [ghcr.io/red5d/docker-autocompose](https://wiki.servarr.com/en/docker-guide#get-docker-compose) to convert `docker run` commands into a single `docker-compose.yml` file.

> The below is _not_ a complete working example! The containers only have PID, UID, UMASK and example paths defined to keep it simple.

```yml

```

Copy

### [¶](https://wiki.servarr.com/en/docker-guide\#update-all-images-and-containers) Update all images and containers

```shell

```

Copy

### [¶](https://wiki.servarr.com/en/docker-guide\#update-individual-image-and-container) Update individual image and container

```shell

```

Copy

## [¶](https://wiki.servarr.com/en/docker-guide\#docker-run) docker run

> Like the Docker Compose example above, the following `docker run` commands are stripped down to _only_ the PUID, PGID, UMASK and volumes in order to act as an obvious example.

```shell

```

Copy

## [¶](https://wiki.servarr.com/en/docker-guide\#systemd) Systemd

For maintaining a few Docker containers just using systemd is an option. It standardizes control and makes dependencies simpler for both native and Docker services. The generic example below can be adapted to any container by adjusting or adding the various values and options.

```shell

```

Copy

# [¶](https://wiki.servarr.com/en/docker-guide\#helpful-commands) Helpful commands

## [¶](https://wiki.servarr.com/en/docker-guide\#list-running-containers) List running containers

```shell

```

Copy

## [¶](https://wiki.servarr.com/en/docker-guide\#shell-inside-a-container) Shell _inside_ a container

Exec into a container will typically log you in as root

```shell

```

Copy

Once inside, you can switch users with

```shell

```

Copy

To exec in as a specific user, add `-u` as an argument and pass the username or id

```shell

```

Copy

### [¶](https://wiki.servarr.com/en/docker-guide\#examples-as-specific-users) Examples as Specific Users

#### [¶](https://wiki.servarr.com/en/docker-guide\#lsio-radarr) LSIO Radarr

```shell

```

Copy

#### [¶](https://wiki.servarr.com/en/docker-guide\#hotio-sonarr) Hotio Sonarr

```shell

```

Copy

For more information, see the [docker exec](https://docs.docker.com/engine/reference/commandline/exec/) documentation.

## [¶](https://wiki.servarr.com/en/docker-guide\#prune-docker) Prune Docker

```shell

```

Copy

> Remove unused containers, networks, volumes, images and build cache. As the WARNING this command gives says, this will remove all of the previously mentioned items for anything not in use by a running container. In a correctly configured environment, this is fine. But be aware and proceed cautiously the first time. See the [Docker system prune](https://docs.docker.com/engine/reference/commandline/system_prune/) documentation for more details.

## [¶](https://wiki.servarr.com/en/docker-guide\#get-docker-run-command) Get docker run command

Getting the `docker run` command from GUI managers can be hard, this Docker image makes it easy for a running container ( [source](https://stackoverflow.com/questions/32758793/how-to-show-the-run-command-of-a-docker-container)).

```shell

```

Copy

## [¶](https://wiki.servarr.com/en/docker-guide\#get-docker-compose) Get docker-compose

> Additionally, you may check out [TRaSH's Guide for docker-compose](https://trash-guides.info/compose/)

Getting a `docker-compose.yml` from running instances is possible with [docker-autocompose](https://github.com/Red5d/docker-autocompose), in case you’ve already started your containers with `docker run` or `docker create` and want to change to `docker-compose` style. It is also great for sharing your settings with others, since it doesn’t matter what management software you’re using. The last argument(s) are your container names and you can pass in as many as needed at the same time. The first container name is required, more are optional. You can see container names in the **NAMES** column of `docker ps`, they're usually set by you or might be generated based on the image like `binhex-qbittorrent`. It is _not_ the image name, like `binhex/arch-qbittorrentvpn`.

```shell

```

Copy

For some users this could be:

```shell

```

Copy

## [¶](https://wiki.servarr.com/en/docker-guide\#troubleshoot-networking) Troubleshoot networking

Most Docker images don’t have many useful tools in them for troubleshooting, but you can [attach a network troubleshooting type image](https://hub.docker.com/r/nicolaka/netshoot) to an existing container to help with that.

```shell

```

Copy

## [¶](https://wiki.servarr.com/en/docker-guide\#recursively-chown-user-and-group) Recursively chown user and group

```shell

```

Copy

## [¶](https://wiki.servarr.com/en/docker-guide\#recursively-chmod-to-775664) Recursively chmod to 775/664

```shell

```

Copy

## [¶](https://wiki.servarr.com/en/docker-guide\#find-uidgid-for-user) Find UID/GID for user

```shell

```

Copy

## [¶](https://wiki.servarr.com/en/docker-guide\#examine-files-for-hard-links) Examine files for hard links

```shell

```

Copy

# [¶](https://wiki.servarr.com/en/docker-guide\#interesting-docker-images) Interesting Docker Images

- [rasmunk/sshfs](https://github.com/rasmunk/docker-volume-sshfs)
- [hotio’s](https://hotio.dev/)The documentation and Dockerfile don’t make any poor path suggestions. Images are automatically updated 2x in 1 hour if upstream changes are found. Hotio also builds our Pull Requests (except Sonarr) which may be useful for testing.

  - [sonarr](https://hotio.dev/containers/sonarr)
  - [radarr](https://hotio.dev/containers/radarr)
  - [lidarr](https://hotio.dev/containers/lidarr)
  - [readarr](https://hotio.dev/containers/readarr)
  - [prowlarr](https://hotio.dev/containers/prowlarr) for usenet and torrent tracker searching
  - [qbittorrent](https://hotio.dev/containers/qbittorrent/)
  - [NZBGet](https://hotio.dev/containers/nzbget/)
  - [SABnzbd](https://hotio.dev/containers/sabnzbd/)
  - [qflood](https://hotio.dev/containers/qflood/)
  - [overseerr](https://hotio.dev/containers/overseerr/) for requesting media
  - [jackett](https://hotio.dev/containers/jackett) for torrent tracker searching
  - [nzbhydra2](https://hotio.dev/containers/nzbhydra2) for usenet indexer searching
  - [bazarr](https://hotio.dev/containers/bazarr) for subtitles
  - [pullio](https://hotio.dev/pullio/) for auto updating containers
  - [unpackerr](https://hotio.dev/containers/unpackerr) is useful for packed torrent extraction across a variety of torrent clients where unpacking is lacking or missing entirely.
- [linuxserver.io](https://hub.docker.com/u/linuxserver) images have images for a _lot_ of software and they’re well maintained. However, avoid their 'suggested (optional)' paths.

  - [SWAG Proxy](https://hub.docker.com/r/linuxserver/swag)
  - [qbittorrent](https://hub.docker.com/r/linuxserver/qbittorrent/)
  - [deluge](https://hub.docker.com/r/linuxserver/deluge/)
  - [rtorrent](https://hub.docker.com/r/linuxserver/rutorrent/)
  - [SABnzbd](https://hub.docker.com/r/linuxserver/sabnzbd/)
  - [NZBGet](https://hub.docker.com/r/linuxserver/nzbget/)
  - [sonarr](https://hub.docker.com/r/linuxserver/sonarr/)
  - [radarr](https://hub.docker.com/r/linuxserver/radarr/)
  - [lidarr](https://hub.docker.com/r/linuxserver/lidarr/)
- [binhex](https://hub.docker.com/u/binhex)another popular maintainer

  - [qbittorrent](https://hub.docker.com/r/binhex/arch-qbittorrentvpn/)
  - [deluge](https://hub.docker.com/r/binhex/arch-delugevpn/)
  - [rtorrent](https://hub.docker.com/r/binhex/arch-rtorrentvpn/)
  - [SABnzbd](https://hub.docker.com/r/binhex/arch-sabnzbd/)
  - [NZBGet](https://hub.docker.com/r/binhex/arch-nzbget/)
  - [sonarr](https://hub.docker.com/r/binhex/arch-sonarr/)
  - [radarr](https://hub.docker.com/r/binhex/arch-radarr/)
  - [lidarr](https://hub.docker.com/r/binhex/arch-lidarr/)

## [¶](https://wiki.servarr.com/en/docker-guide\#all-in-one-solutions) All-in-One Solutions

- [This is a GitHub repository](https://github.com/Luctia/ezarr) aimed at beginners who want to use Docker for their Servarr stack. It is basically a ready-to-go collection of files and only requires you to run two things to get the entire thing online. It removes the hassle around user management and permissions on the host device and features some other applications like PleX.

# [¶](https://wiki.servarr.com/en/docker-guide\#custom-docker-network-and-dns) Custom Docker Network and DNS

One interesting feature of a [custom Docker network](https://docs.docker.com/network/network-tutorial-standalone/#use-user-defined-bridge-networks) is that it gets its own DNS server. If you create a bridge network for your containers, you can use their hostnames in your configuration. For example, if you `docker run --network=isolated --hostname=deluge binhex/arch-deluge` and `docker run --network=isolated --hostname=radarr binhex/arch-radarr`, you can then configure the Download Client in Radarr to point at just `deluge` and it'll work _and_ communicate on its own private network. Which means if you wanted to be even more secure, you could _stop_ forwarding that port too. If you put your reverse proxy container on the same network, you can even stop forwarding the web interface ports and make them even more secure.

## [¶](https://wiki.servarr.com/en/docker-guide\#using-internal-domain-for-container-communication) Using .internal Domain for Container Communication

**For more reliable container-to-container communication, especially when using VPN containers, it's recommended to use the `.internal` domain suffix.**

Docker's built-in DNS automatically resolves container names with the `.internal` suffix to their internal IP addresses. This is particularly useful when:

- Using VPN containers (like Hotio's VPN feature) where network routing can be complex
- Containers need to communicate across different network configurations
- You want to ensure DNS resolution works reliably regardless of network setup

**Example:**

Instead of using just the container name:

```yaml

```

Copy

Use the `.internal` suffix:

```yaml

```

Copy

This works with any container name in your Docker setup. If your qBittorrent container is named `qbittorrent`, other containers can reach it at `qbittorrent.internal` without any additional configuration.

> **Note**: This is especially important when using [Hotio's VPN feature](https://hotio.dev/containers/qbittorrent/) or any VPN container setup, as it ensures reliable DNS resolution even when routing traffic through VPN tunnels.

# [¶](https://wiki.servarr.com/en/docker-guide\#common-problems) Common Problems

## [¶](https://wiki.servarr.com/en/docker-guide\#correct-outside-paths-incorrect-inside-paths) Correct _outside_ paths, incorrect _inside_ paths

Many people read this and think they understand, but they end up seeing the outside path correctly to something like `/data/usenet`, but then they miss the point and set the _inside_ path to `/downloads` still.

- Good:
  - `/host/data/usenet:/data/usenet`
  - `/data/media:/data/media`
- Bad:
  - `/host/data:/downloads`
  - `/host/data:/media`
  - `/data/downloads:/data`

## [¶](https://wiki.servarr.com/en/docker-guide\#running-docker-containers-as-root-or-changing-users-around) Running Docker containers as root or changing users around

If you find yourself running your containers as `root:root`, you’re doing something wrong. If you’re not passing in a UID and GID, you’ll be using whatever the default is for the image and _that_ will be unlikely to line up with a reasonable user on your system. And if you’re changing the user and group your Docker containers are running as, you’ll probably end up with permissions issues on folders like the `/config` folder which will likely have files and folders in them that got created the first time with the UID/GID you used the first time.

## [¶](https://wiki.servarr.com/en/docker-guide\#running-docker-containers-with-umask-000) Running Docker containers with umask 000

If you find yourself setting a UMASK of `000` (which is 777 for folders and 666 for files), you’re _also_ doing something wrong. It leaves your files and folders read/write to _everyone_, which is poor Linux hygiene.

# [¶](https://wiki.servarr.com/en/docker-guide\#getting-help) Getting Help

## [¶](https://wiki.servarr.com/en/docker-guide\#chat-support-discord) Chat Support (Discord)

- [Sonarr Discord](https://discord.sonarr.tv/)
- [Radarr Discord](https://radarr.video/discord)

## [¶](https://wiki.servarr.com/en/docker-guide\#forum-support-reddit) Forum Support (Reddit)

- [/r/sonarr](http://reddit.com/r/sonarr)
- [/r/radarr](http://reddit.com/r/radarr)