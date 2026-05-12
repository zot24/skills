> Source: https://wiki.servarr.com/en/docker-guide



# <a href="#table-of-contents" class="toc-anchor">¶</a> Table of Contents

- [Table of Contents](#table-of-contents)
- [The Best Docker Setup](#the-best-docker-setup)
- [Portainer](#portainer)
- [Introduction](#introduction)
- [Multiple users and a shared group](#multiple-users-and-a-shared-group)
  - [Permissions](#permissions)
  - [UMASK](#umask)
  - [PUID and PGID](#puid-and-pgid)
  - [Example](#example)
- [Single user and optional shared group](#single-user-and-optional-shared-group)
- [Ownership and permissions of /config](#ownership-and-permissions-of-config)
- [Consistent and well planned paths](#consistent-and-well-planned-paths)
  - [Examples](#examples)
    - [Torrents](#torrents)
    - [Usenet](#usenet)
    - [Media Server](#media-server)
    - [Sonarr, Radarr and Lidarr](#sonarr-radarr-and-lidarr)
  - [Issues](#issues)
- [Running containers using](#running-containers-using)
  - [Docker Compose](#docker-compose)
    - [Update all images and containers](#update-all-images-and-containers)
    - [Update individual image and container](#update-individual-image-and-container)
  - [docker run](#docker-run)
  - [Systemd](#systemd)
- [Helpful commands](#helpful-commands)
  - [List running containers](#list-running-containers)
  - [Shell *inside* a container](#shell-inside-a-container)
    - [Examples as Specific Users](#examples-as-specific-users)
      - [LSIO Radarr](#lsio-radarr)
      - [Hotio Sonarr](#hotio-sonarr)
  - [Prune Docker](#prune-docker)
  - [Get docker run command](#get-docker-run-command)
  - [Get docker-compose](#get-docker-compose)
  - [Troubleshoot networking](#troubleshoot-networking)
  - [Recursively chown user and group](#recursively-chown-user-and-group)
  - [Recursively chmod to 775/664](#recursively-chmod-to-775664)
  - [Find UID/GID for user](#find-uidgid-for-user)
  - [Examine files for hard links](#examine-files-for-hard-links)
- [Interesting Docker Images](#interesting-docker-images)
  - [All-in-One Solutions](#all-in-one-solutions)
- [Custom Docker Network and DNS](#custom-docker-network-and-dns)
- [Common Problems](#common-problems)
  - [Correct *outside* paths, incorrect *inside* paths](#correct-outside-paths-incorrect-inside-paths)
  - [Running Docker containers as root or changing users around](#running-docker-containers-as-root-or-changing-users-around)
  - [Running Docker containers with umask 000](#running-docker-containers-with-umask-000)
- [Getting Help](#getting-help)
  - [Chat Support (Discord)](#chat-support-discord)

# <a href="#the-best-docker-setup" class="toc-anchor">¶</a> The Best Docker Setup

> `Multiple users and a shared group` does not apply to Unraid which does things a little differently and runs all containers as `nobody:users`. See TRaSH's Hardlink's Unraid Guide for details and the `Consistent and well planned paths` section that does apply.

**TL;DR**: An <a href="https://www.dictionary.com/browse/eponymous" class="is-external-link">eponymous</a> user per daemon and a shared group with a umask of `002`. Consistent path definitions between *all* containers that maintains the folder structure. Using one volume (so the download folder and library folder are on the same file system) makes <a href="https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/#what-are-hardlinks" class="is-external-link">hardlinks</a> and <a href="https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/#what-are-instant-moves-atomic-moves" class="is-external-link">instant moves (atomic moves)</a> possible for Sonarr, Radarr, Lidarr and Readarr. And most of all, ignore *most* of the Docker image’s path documentation!

> Note: Many folks find <a href="https://trash-guides.info/hardlinks/" class="is-external-link">TRaSH's Hardlink Tutorial</a> helpful and easier to understand than this guide. This guide is more conceptual in nature while TRaSH's tutorial walks you through the process.

# <a href="#portainer" class="toc-anchor">¶</a> Portainer

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

See this <a href="/docker-guide" class="is-internal-link is-valid-page">Docker Guide</a> and <a href="https://trash-guides.info/hardlinks/" class="is-external-link">TRaSH's Docker Tutorial</a> instead for how to setup Docker Compose.

# <a href="#introduction" class="toc-anchor">¶</a> Introduction

This article will not show you specifics about the best Docker setup, but it describes an overview that you can use to make your own setup the best that it can be. The idea is that you run each Docker container as its own user, with a shared group and consistent volumes so every container sees the same path layout. This is easy to say, but not so easy to understand and explain.

> Reminder that many folks find <a href="https://trash-guides.info/hardlinks/" class="is-external-link">TRaSH's Hardlink Tutorial</a> helpful and easier to understand than this guide. This guide is more conceptual in nature while TRaSH's tutorial walks you through the process.

# <a href="#multiple-users-and-a-shared-group" class="toc-anchor">¶</a> Multiple users and a shared group

> This does not apply to Unraid which does things a little differently and runs all containers as `nobody:users` and should generally be the same single user and single group.

## <a href="#permissions" class="toc-anchor">¶</a> Permissions

Ideally, each software runs as its own user and they are all part of a shared group with folder permissions set to `775` (`drwxrwxr-x`) and files set to `664` (`-rw-rw-r--`), which is a umask of `002`. A sane alternative to this is a single shared user, which would use `755` and `644` which is a umask of `022`. You can restrict permissions even more by denying read from “other”, which would be a umask of `007` for a user per daemon or `077` for a single shared user. For a deeper explanation, try the Arch Linux wiki articles about <a href="https://wiki.archlinux.org/index.php/File_permissions_and_attributes" class="is-external-link">file permissions and attributes</a> and <a href="https://wiki.archlinux.org/index.php/Umask" class="is-external-link">UMASK</a>.

## <a href="#umask" class="toc-anchor">¶</a> UMASK

Many Docker images accept `-e UMASK=002` as an environment variable and some software can be configured with a user, group and umask (NZBGet) or folder/file permission (Sonarr/Radarr), inside the container. This will ensure that files and folders created by *one* can be read and written by the others. If you are using existing folders and files, you will need to fix their current ownership and permissions too, but going forward they will be correct because you set each software up right.

## <a href="#puid-and-pgid" class="toc-anchor">¶</a> PUID and PGID

Many Docker images also take a `-e PUID=123` and `-e PGID=321` that lets you change the UID/GID used inside to that of an account on the outside. If you ever peek in, you’ll find that username is something like `abc`, `nobody` or `hotio`, but because it uses the UID/GID you pass in, on the outside it looks like the expected user. If you’re using storage from another system via NFS or CIFS, it will make your life easier if *that* system also has matching users and group. Perhaps let one system pick the UID/GIDs, then re-use those on the other system, assuming they don’t conflict.

## <a href="#example" class="toc-anchor">¶</a> Example

You run <a href="https://github.com/Sonarr/Sonarr/releases" class="is-external-link">Sonarr</a> using <a href="https://github.com/hotio/docker-sonarr" class="is-external-link">hotio/sonarr</a>, you’ve created a `sonarr` user with uid `123` and a shared group `media` with gid `321` which the `sonarr` user is a member of. You configure the Docker image to run with `-e PUID=123 -e PGID=321 -e UMASK=002`. Sonarr also lets you configure the user, group as well as folder and file permissions. The previous settings should negate these, but you could configure them if you wanted. An UMASK of `002` results in `775` (`drwxrwxr-x`) for folders and `664` (`-rw-rw-r--`) for files. and the user/group are a little tricky because *inside* the container, they have a different name. Typically they are `abc` or `nobody`.

# <a href="#single-user-and-optional-shared-group" class="toc-anchor">¶</a> Single user and optional shared group

Another popular and arguably easier option is a single, shared user. Perhaps even *your* user. It isn’t as secure and doesn’t follow best practices, but in the end it is easier to understand and implement. The UMASK for this is `022` which results in `755` (`drwxr-xr-x`) for folders and `644` (`-rw-r--r--`) for files. The group no longer really matters, so you’ll probably just use the group named after the user. This does make it harder to share with *other* users, so you may still end up wanting a UMASK of `002` even with this setup.

# <a href="#ownership-and-permissions-of-config" class="toc-anchor">¶</a> Ownership and permissions of /config

Don’t forget that your `/config` volume will *also* need to have correct ownership and permissions, usually the daemon’s user and that user’s group like `sonarr:sonarr` and a umask of `022` or `077` so *only* that user has access. In a single user setup, this would of course be the one user you’ve chosen.

# <a href="#consistent-and-well-planned-paths" class="toc-anchor">¶</a> Consistent and well planned paths

> Many folks find <a href="https://trash-guides.info/hardlinks" class="is-external-link">TRaSH's Hardlink Tutorial</a> helpful and easier to understand than this guide. This guide is more conceptual in nature while TRaSH's tutorial walks you through the process.

The easiest and most important detail is to create unified path definitions across all the containers.

If you’re wondering why hard links aren’t working or why a simple move is taking far longer than it should, this section explains it. The paths you use on the *inside* matter. Because of how Docker’s volumes work, passing in two volumes such as the commonly suggested `/tv`, `/movies`, and `/downloads` makes them look like two different file systems, even if they are a single file system outside the container. This means hard links won’t work *and* instead of an instant/atomic move, a slower and more IO intensive copy+delete is used. If you have multiple download clients because you’re using torrents and usenet, having a single `/downloads` path means they’ll be mixed up. Because the Radarr in one container will ask the NZBGet in its own container where files are, using the same path in both means it will all just work. If you don’t, you’d need to fix it with a remote path map.

So pick *one* path layout and use it for all of them. It's suggested to use `/data`, but there are other common names like `/shared`, `/media` or `/dvr`. Keeping this the same on the outside *and* inside will make your setup simpler: one path to remember or if integrating Docker and native software. For example, Synology might use `/Volume1/data` and unRAID might use `/mnt/user/data` on the outside, but `/data` on the inside is fine.

It is also important to remember that you’ll need to setup or re-configure paths in the software running *inside* these Docker containers. If you change the paths for your download client, you’ll need to edit its settings to match and likely update existing torrents. If you change your library path, you’ll need to change those settings in Sonarr, Radarr, Lidarr, Plex, etc.

## <a href="#examples" class="toc-anchor">¶</a> Examples

What matters here is the general structure, not the names. You are free to pick folder names that make sense to you. And there are other ways of arranging things too. For example, you’re not likely to download and run into conflicts of identical releases between usenet and torrents, so you *could* put both in `/data/downloads/{movies|books|music|tv}` folders. Downloads don’t even have to be sorted into subfolders either, since movies, music and tv will rarely conflict.

This example `data` folder has subfolders for torrents and usenet and each of these have subfolders for tv, movie and music downloads to keep things neat. The `media` folder has nicely named `tv`, `movies`, `books`, and `music` subfolders. This `media` folder is your library and what you’d pass to Plex, Kodi, Emby, Jellyfin, etc.

For the below example `data` is equivalent to the host path `/host/data` and the docker path `/data`

``` prismjs
    data
    ├── torrents
    │  ├── movies
    │  ├── music
    |  ├── books
    │  └── tv
    ├── usenet
    │  ├── movies
    │  ├── music
    │  ├── books
    │  └── tv
    └── media
        ├── movies
        ├── music
        ├── books
        └── tv
```

The path for each Docker container can be as specific as needed while still maintaining the correct structure:

### <a href="#torrents" class="toc-anchor">¶</a> Torrents

``` prismjs
    data
    └── torrents
        ├── movies
        ├── music
        ├── books
        └── tv
```

Torrents only needs access to torrent files, so pass it `-v /host/data/torrents:/data/torrents`. In the torrent software settings, you’ll need to reconfigure paths and you can sort into subfolders like`/data/torrents/{tv|books|movies|music}`.

### <a href="#usenet" class="toc-anchor">¶</a> Usenet

``` prismjs
    data
    └── usenet
        ├── movies
        ├── music
        └── tv
```

Usenet only needs access to usenet files, so pass it `-v /host/data/usenet:/data/usenet`. In the usenet software settings, you’ll need to reconfigure paths and you can sort into subfolders like`/data/usenet/{tv|movies|music}`.

### <a href="#media-server" class="toc-anchor">¶</a> Media Server

``` prismjs
    data
    └── media
        ├── movies
        ├── music
        └── tv
```

Plex/Emby only needs access to your media library, so pass `-v /host/data/media:/data/media`, which can have any number of subfolders like `movies`, `kids movies`, `tv`, `documentary tv` and/or `music` as sub folders.

### <a href="#sonarr-radarr-and-lidarr" class="toc-anchor">¶</a> Sonarr, Radarr and Lidarr

``` prismjs
    data
    ├── torrents
    │  ├── movies
    │  ├── music
    │  └── tv
    ├── usenet
    │  ├── movies
    │  ├── music
    │  └── tv
    └── media
        ├── movies
        ├── music
        └── tv
```

Sonarr, Radarr and Lidarr get everything using `-v /host/data:/data` because the *download* folder(s) and *media* folder will look like and *be* one file system. Hard links will work and moves will be atomic, instead of copy + delete.

## <a href="#issues" class="toc-anchor">¶</a> Issues

There are a couple minor issues with not following the Docker image’s suggested paths.

The biggest is that volumes defined in the `dockerfile` will get created if they’re not specified, this means they’ll pile up as you delete and re-create the containers. If they end up with data in them, they can consume space unexpectedly and likely in an unsuitable place. You can find a [cleanup command](#prune-docker) in the helpful commands section below. This could also be mitigated by passing in an empty folder for all the volumes you don’t want to use, like `/data/empty:/movies` and `/data/empty:/downloads`. Maybe even put a file named `DO NOT USE THIS FOLDER` inside, to remind yourself.

Another problem is that some images are pre-configured to use the documented volumes, so you’ll need to change settings in the software inside the Docker container. Thankfully, since configuration persists outside the container this is a one time issue. You might also pick a path like `/data` or `/media` which some images already define for a specific use. It shouldn’t be a problem, but will be a little more confusing when combined with the previous issues. In the end, it is worth it for working hard links and fast moves. The consistency and simplicity are welcome side effects as well.

If you use the latest version of the abandoned <a href="https://github.com/Sperryfreak01/RadarrSync" class="is-external-link">RadarrSync</a> to synchronize two Radarr instances, it *depends* on mapping the *same* path inside to a different path on the outside, for example `/movies` for one instance would point at `/data/media/movies` and the other at `/data/media/movies4k`. This breaks *everything* you’ve read above. There is no good solution, you either use the old version which isn’t as good, do your mapping in a way that is ugly and breaks hard links or just don’t use it at all.

# <a href="#running-containers-using" class="toc-anchor">¶</a> Running containers using

## <a href="#docker-compose" class="toc-anchor">¶</a> Docker Compose

This is the best option for most users, it lets you control and configure many containers and their interdependence in one file. A good starting place is Docker’s own <a href="https://docs.docker.com/compose/gettingstarted/" class="is-external-link">Get started with Docker Compose</a>. You can use <a href="https://composerize.com" class="is-external-link">composerize</a> or [ghcr.io/red5d/docker-autocompose](#get-docker-compose) to convert `docker run` commands into a single `docker-compose.yml` file.

> The below is *not* a complete working example! The containers only have PID, UID, UMASK and example paths defined to keep it simple.

``` prismjs
    # sonarr
    Sonarr:
        image: ghcr.io/hotio/sonarr
        volumes:
            - /path/to/config/sonarr:/config
            - /host/data:/data
        environment:
            - PUID=111
            - PGID=321
            - UMASK=002

    # deluge
    Deluge:
        image: binhex/arch-delugevpn
        volumes:
            - /path/to/config/deluge:/config
            - /host/data/torrents:/data/torrents
        environment:
            - PUID=222
            - PGID=321
            - UMASK=002

    # SABnzbd
    SABnzbd:
        image: ghcr.io/hotio/sabnzbd
        volumes:
            - /path/to/config/sabnzbd:/config
            - /host/data/usenet:/data/usenet
        environment:
            - PUID=333
            - PGID=321
            - UMASK=002

    # plex
    Plex:
        image: ghcr.io/hotio/plex
        volumes:
            - /path/to/config/plex:/config
            - /host/data/media:/data/media

        environment:
            - PUID=444
            - PGID=321
            - UMASK=002
```

### <a href="#update-all-images-and-containers" class="toc-anchor">¶</a> Update all images and containers

``` prismjs
    docker-compose pull
    docker-compose up -d
```

### <a href="#update-individual-image-and-container" class="toc-anchor">¶</a> Update individual image and container

``` prismjs
    docker-compose pull NAME
    docker-compose up -d NAME
```

## <a href="#docker-run" class="toc-anchor">¶</a> docker run

> Like the Docker Compose example above, the following `docker run` commands are stripped down to *only* the PUID, PGID, UMASK and volumes in order to act as an obvious example.

``` prismjs
    # sonarr
    docker run -v /path/to/config/sonarr:/config \
               -v /host/data:/data \
               -e PUID=111 -e PGID=321 -e UMASK=002 \
               ghcr.io/hotio/sonarr

    # deluge
    docker run -v /path/to/config/deluge:/config \
               -v /host/data/torrents:/data/torrents \
               -e PUID=222 -e PGID=321 -e UMASK=002 \
               binhex/arch-delugevpn

    # SABnzbd
    docker run -v /path/to/config/sabnzbd:/config \
               -v /host/data/usenet:/data/usenet \
               -e PUID=333 -e PGID=321 -e UMASK=002 \
               ghcr.io/hotio/sabnzbd

    # plex
    docker run -v /path/to/config/plex:/config \
               -v /host/data/media:/data/media \
               -e PUID=444 -e PGID=321 -e UMASK=002 \
               ghcr.io/hotio/plex
```

## <a href="#systemd" class="toc-anchor">¶</a> Systemd

For maintaining a few Docker containers just using systemd is an option. It standardizes control and makes dependencies simpler for both native and Docker services. The generic example below can be adapted to any container by adjusting or adding the various values and options.

``` prismjs
    # /etc/systemd/system/thing.service
    [Unit]
    Description=Thing
    Requires=docker.service
    After=network.target docker.service

    [Service]
    ExecStart=/usr/bin/docker run --rm \
                              --name=thing \
                              -v /path/to/config/thing:/config \
                              -v /host/data:/data
                              -e PUID=111 -e PGID=321 -e UMASK=002 \
                              nobody/thing

    ExecStop=/usr/bin/docker stop -t 30 thing

    [Install]
    WantedBy=default.target
```

# <a href="#helpful-commands" class="toc-anchor">¶</a> Helpful commands

## <a href="#list-running-containers" class="toc-anchor">¶</a> List running containers

``` prismjs
    docker ps
```

## <a href="#shell-inside-a-container" class="toc-anchor">¶</a> Shell *inside* a container

Exec into a container will typically log you in as root

``` prismjs
    docker exec -it CONTAINER_NAME /bin/bash
```

Once inside, you can switch users with

``` prismjs
    su - <username>
```

To exec in as a specific user, add `-u` as an argument and pass the username or id

``` prismjs
    docker exec -u USER -it CONTAINER_NAME /bin/bash
```

### <a href="#examples-as-specific-users" class="toc-anchor">¶</a> Examples as Specific Users

#### <a href="#lsio-radarr" class="toc-anchor">¶</a> LSIO Radarr

``` prismjs
    docker exec -u abc -it radarr bash
```

#### <a href="#hotio-sonarr" class="toc-anchor">¶</a> Hotio Sonarr

``` prismjs
    docker exec -u hotio -it sonarr bash
```

For more information, see the <a href="https://docs.docker.com/engine/reference/commandline/exec/" class="is-external-link">docker exec</a> documentation.

## <a href="#prune-docker" class="toc-anchor">¶</a> Prune Docker

``` prismjs
    docker system prune --all --volumes
```

> Remove unused containers, networks, volumes, images and build cache. As the WARNING this command gives says, this will remove all of the previously mentioned items for anything not in use by a running container. In a correctly configured environment, this is fine. But be aware and proceed cautiously the first time. See the <a href="https://docs.docker.com/engine/reference/commandline/system_prune/" class="is-external-link">Docker system prune</a> documentation for more details.

## <a href="#get-docker-run-command" class="toc-anchor">¶</a> Get docker run command

Getting the `docker run` command from GUI managers can be hard, this Docker image makes it easy for a running container (<a href="https://stackoverflow.com/questions/32758793/how-to-show-the-run-command-of-a-docker-container" class="is-external-link">source</a>).

``` prismjs
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock assaflavie/runlike CONTAINER_NAME
```

## <a href="#get-docker-compose" class="toc-anchor">¶</a> Get docker-compose

> Additionally, you may check out <a href="https://trash-guides.info/compose/" class="is-external-link">TRaSH's Guide for docker-compose</a>

Getting a `docker-compose.yml` from running instances is possible with <a href="https://github.com/Red5d/docker-autocompose" class="is-external-link">docker-autocompose</a>, in case you’ve already started your containers with `docker run` or `docker create` and want to change to `docker-compose` style. It is also great for sharing your settings with others, since it doesn’t matter what management software you’re using. The last argument(s) are your container names and you can pass in as many as needed at the same time. The first container name is required, more are optional. You can see container names in the **NAMES** column of `docker ps`, they're usually set by you or might be generated based on the image like `binhex-qbittorrent`. It is *not* the image name, like `binhex/arch-qbittorrentvpn`.

``` prismjs
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/red5d/docker-autocompose $CONTAINER_NAME $ANOTHER_CONTAINER_NAME ... $ONE_MORE_CONTAINER_NAME
```

For some users this could be:

``` prismjs
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/red5d/docker-autocompose lidarr prowlarr radarr readarr sonarr qbittorrent
```

## <a href="#troubleshoot-networking" class="toc-anchor">¶</a> Troubleshoot networking

Most Docker images don’t have many useful tools in them for troubleshooting, but you can <a href="https://hub.docker.com/r/nicolaka/netshoot" class="is-external-link">attach a network troubleshooting type image</a> to an existing container to help with that.

``` prismjs
    docker run -it --rm --network container:CONTAINER_NAME nicolaka/netshoot
```

## <a href="#recursively-chown-user-and-group" class="toc-anchor">¶</a> Recursively chown user and group

``` prismjs
    chown -R user:group /some/path/here
```

## <a href="#recursively-chmod-to-775664" class="toc-anchor">¶</a> Recursively chmod to 775/664

``` prismjs
    chmod -R a=,a+rX,u+w,g+w /some/path/here
              ^  ^    ^   ^ adds write to group
              |  |    | adds write to user
              |  | adds read to all and execute to all folders (which controls access)
              | sets all to `000`
```

## <a href="#find-uidgid-for-user" class="toc-anchor">¶</a> Find UID/GID for user

``` prismjs
    id <username>
```

## <a href="#examine-files-for-hard-links" class="toc-anchor">¶</a> Examine files for hard links

``` prismjs
    ls -alhi
    42207934 -rw-r--r--  2 user group    0 Sep 11 11:55 # hardlinked
    42207936 -rw-r--r--  1 user group    0 Sep 11 11:55 # no hardlinks
    42207934 -rw-r--r--  2 user group    0 Sep 11 11:55 # original

    stat original
      File: original
      Size: 0               Blocks: 0          IO Block: 4096   regular empty file
    Device: 803h/2051d      Inode: 42207934    Links: 2
    Access: (0644/-rw-r--r--)  Uid: ( 1000/ user)   Gid: ( 1001/ group)
    Access: 2020-09-11 11:55:43.803327144 -0500
    Modify: 2020-09-11 11:55:43.803327144 -0500
    Change: 2020-09-11 11:55:49.706660476 -0500
     Birth: 2020-09-11 11:55:43.803327144 -0500
```

# <a href="#interesting-docker-images" class="toc-anchor">¶</a> Interesting Docker Images

- <a href="https://github.com/rasmunk/docker-volume-sshfs" class="is-external-link">rasmunk/sshfs</a>
- <a href="https://hotio.dev/" class="is-external-link">hotio’s</a> The documentation and Dockerfile don’t make any poor path suggestions. Images are automatically updated 2x in 1 hour if upstream changes are found. Hotio also builds our Pull Requests (except Sonarr) which may be useful for testing.
  - <a href="https://hotio.dev/containers/sonarr" class="is-external-link">sonarr</a>
  - <a href="https://hotio.dev/containers/radarr" class="is-external-link">radarr</a>
  - <a href="https://hotio.dev/containers/lidarr" class="is-external-link">lidarr</a>
  - <a href="https://hotio.dev/containers/readarr" class="is-external-link">readarr</a>
  - <a href="https://hotio.dev/containers/prowlarr" class="is-external-link">prowlarr</a> for usenet and torrent tracker searching
  - <a href="https://hotio.dev/containers/qbittorrent/" class="is-external-link">qbittorrent</a>
  - <a href="https://hotio.dev/containers/nzbget/" class="is-external-link">NZBGet</a>
  - <a href="https://hotio.dev/containers/sabnzbd/" class="is-external-link">SABnzbd</a>
  - <a href="https://hotio.dev/containers/qflood/" class="is-external-link">qflood</a>
  - <a href="https://hotio.dev/containers/overseerr/" class="is-external-link">overseerr</a> for requesting media
  - <a href="https://hotio.dev/containers/jackett" class="is-external-link">jackett</a> for torrent tracker searching
  - <a href="https://hotio.dev/containers/nzbhydra2" class="is-external-link">nzbhydra2</a> for usenet indexer searching
  - <a href="https://hotio.dev/containers/bazarr" class="is-external-link">bazarr</a> for subtitles
  - <a href="https://hotio.dev/pullio/" class="is-external-link">pullio</a> for auto updating containers
  - <a href="https://hotio.dev/containers/unpackerr" class="is-external-link">unpackerr</a> is useful for packed torrent extraction across a variety of torrent clients where unpacking is lacking or missing entirely.
- <a href="https://hub.docker.com/u/linuxserver" class="is-external-link">linuxserver.io</a> images have images for a *lot* of software and they’re well maintained. However, avoid their 'suggested (optional)' paths.
  - <a href="https://hub.docker.com/r/linuxserver/swag" class="is-external-link">SWAG Proxy</a>
  - <a href="https://hub.docker.com/r/linuxserver/qbittorrent/" class="is-external-link">qbittorrent</a>
  - <a href="https://hub.docker.com/r/linuxserver/deluge/" class="is-external-link">deluge</a>
  - <a href="https://hub.docker.com/r/linuxserver/rutorrent/" class="is-external-link">rtorrent</a>
  - <a href="https://hub.docker.com/r/linuxserver/sabnzbd/" class="is-external-link">SABnzbd</a>
  - <a href="https://hub.docker.com/r/linuxserver/nzbget/" class="is-external-link">NZBGet</a>
  - <a href="https://hub.docker.com/r/linuxserver/sonarr/" class="is-external-link">sonarr</a>
  - <a href="https://hub.docker.com/r/linuxserver/radarr/" class="is-external-link">radarr</a>
  - <a href="https://hub.docker.com/r/linuxserver/lidarr/" class="is-external-link">lidarr</a>
- <a href="https://hub.docker.com/u/binhex" class="is-external-link">binhex</a> another popular maintainer
  - <a href="https://hub.docker.com/r/binhex/arch-qbittorrentvpn/" class="is-external-link">qbittorrent</a>
  - <a href="https://hub.docker.com/r/binhex/arch-delugevpn/" class="is-external-link">deluge</a>
  - <a href="https://hub.docker.com/r/binhex/arch-rtorrentvpn/" class="is-external-link">rtorrent</a>
  - <a href="https://hub.docker.com/r/binhex/arch-sabnzbd/" class="is-external-link">SABnzbd</a>
  - <a href="https://hub.docker.com/r/binhex/arch-nzbget/" class="is-external-link">NZBGet</a>
  - <a href="https://hub.docker.com/r/binhex/arch-sonarr/" class="is-external-link">sonarr</a>
  - <a href="https://hub.docker.com/r/binhex/arch-radarr/" class="is-external-link">radarr</a>
  - <a href="https://hub.docker.com/r/binhex/arch-lidarr/" class="is-external-link">lidarr</a>

## <a href="#all-in-one-solutions" class="toc-anchor">¶</a> All-in-One Solutions

- <a href="https://github.com/Luctia/ezarr" class="is-external-link">This is a GitHub repository</a> aimed at beginners who want to use Docker for their Servarr stack. It is basically a ready-to-go collection of files and only requires you to run two things to get the entire thing online. It removes the hassle around user management and permissions on the host device and features some other applications like PleX.

# <a href="#custom-docker-network-and-dns" class="toc-anchor">¶</a> Custom Docker Network and DNS

One interesting feature of a <a href="https://docs.docker.com/network/network-tutorial-standalone/#use-user-defined-bridge-networks" class="is-external-link">custom Docker network</a> is that it gets its own DNS server. If you create a bridge network for your containers, you can use their hostnames in your configuration. For example, if you `docker run --network=isolated --hostname=deluge binhex/arch-deluge` and `docker run --network=isolated --hostname=radarr binhex/arch-radarr`, you can then configure the Download Client in Radarr to point at just `deluge` and it'll work *and* communicate on its own private network. Which means if you wanted to be even more secure, you could *stop* forwarding that port too. If you put your reverse proxy container on the same network, you can even stop forwarding the web interface ports and make them even more secure.

## <a href="#using-internal-domain-for-container-communication" class="toc-anchor">¶</a> Using .internal Domain for Container Communication

**For more reliable container-to-container communication, especially when using VPN containers, it's recommended to use the `.internal` domain suffix.**

Docker's built-in DNS automatically resolves container names with the `.internal` suffix to their internal IP addresses. This is particularly useful when:

- Using VPN containers (like Hotio's VPN feature) where network routing can be complex
- Containers need to communicate across different network configurations
- You want to ensure DNS resolution works reliably regardless of network setup

**Example:**

Instead of using just the container name:

``` prismjs
# Less reliable
QBITTORRENT_HOST=qbittorrent
```

Use the `.internal` suffix:

``` prismjs
# More reliable, especially with VPN
QBITTORRENT_HOST=qbittorrent.internal
```

This works with any container name in your Docker setup. If your qBittorrent container is named `qbittorrent`, other containers can reach it at `qbittorrent.internal` without any additional configuration.

> **Note**: This is especially important when using <a href="https://hotio.dev/containers/qbittorrent/" class="is-external-link">Hotio's VPN feature</a> or any VPN container setup, as it ensures reliable DNS resolution even when routing traffic through VPN tunnels.

# <a href="#common-problems" class="toc-anchor">¶</a> Common Problems

## <a href="#correct-outside-paths-incorrect-inside-paths" class="toc-anchor">¶</a> Correct *outside* paths, incorrect *inside* paths

Many people read this and think they understand, but they end up seeing the outside path correctly to something like `/data/usenet`, but then they miss the point and set the *inside* path to `/downloads` still.

- Good:
  - `/host/data/usenet:/data/usenet`
  - `/data/media:/data/media`
- Bad:
  - `/host/data:/downloads`
  - `/host/data:/media`
  - `/data/downloads:/data`

## <a href="#running-docker-containers-as-root-or-changing-users-around" class="toc-anchor">¶</a> Running Docker containers as root or changing users around

If you find yourself running your containers as `root:root`, you’re doing something wrong. If you’re not passing in a UID and GID, you’ll be using whatever the default is for the image and *that* will be unlikely to line up with a reasonable user on your system. And if you’re changing the user and group your Docker containers are running as, you’ll probably end up with permissions issues on folders like the `/config` folder which will likely have files and folders in them that got created the first time with the UID/GID you used the first time.

## <a href="#running-docker-containers-with-umask-000" class="toc-anchor">¶</a> Running Docker containers with umask 000

If you find yourself setting a UMASK of `000` (which is 777 for folders and 666 for files), you’re *also* doing something wrong. It leaves your files and folders read/write to *everyone*, which is poor Linux hygiene.

# <a href="#getting-help" class="toc-anchor">¶</a> Getting Help

## <a href="#chat-support-discord" class="toc-anchor">¶</a> Chat Support (Discord)

- <a href="https://discord.sonarr.tv/" class="is-external-link">Sonarr Discord</a>
- <a href="https://radarr.video/discord" class="is-external-link">Radarr Discord</a>

## <a href="#forum-support-reddit" class="toc-anchor">¶</a> Forum Support (Reddit)

- <a href="http://reddit.com/r/sonarr" class="is-external-link">/r/sonarr</a>
- <a href="http://reddit.com/r/radarr" class="is-external-link">/r/radarr</a>


