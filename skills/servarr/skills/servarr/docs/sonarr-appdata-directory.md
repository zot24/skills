> Source: https://wiki.servarr.com/sonarr/appdata-directory



> Below are the default paths for the application data directory

> All instances of `$USER` are placeholders for the user the application is running under.

# <a href="#windows" class="toc-anchor">¶</a> Windows

`C:\ProgramData\Sonarr`

# <a href="#linux" class="toc-anchor">¶</a> Linux

Unless otherwise specified Sonarr will store it's application data in the home folder of the user Sonarr is running under `/home/$USER/.config/Sonarr` or `~/.config/Sonarr`

> For apt repo based installs, it defaults to `/var/lib/Sonarr`

# <a href="#macos-osx" class="toc-anchor">¶</a> MacOS (OSX)

`/Users/$USER/.config/Sonarr` or `~/.config/Sonarr`

# <a href="#synology" class="toc-anchor">¶</a> Synology

If you are using the SynoCommunity package for Sonarr, this is where you should expect to find your appdata. If you are using Docker on your Synology NAS, look below in the Docker section.

## <a href="#dsm-7-and-above" class="toc-anchor">¶</a> DSM 7 and above

`/volume1/@appdata/nzbdrone/.config/Sonarr`

## <a href="#dsm-6-and-below" class="toc-anchor">¶</a> DSM 6 and below

`/volume1/@appstore/nzbdrone/.config/Sonarr`

> The SynoCommunity still uses the original package name `nzbdrone` for the underlying package name

# <a href="#qnap" class="toc-anchor">¶</a> QNAP

`/share/MD0_DATA/homes/admin/.config/Sonarr`

`/share/CACHEDEV1_DATA/Sonarr_CONFIG`

# <a href="#docker" class="toc-anchor">¶</a> Docker

`/config`

- This will vary based on where the user maps `/config` to on their host system

# <a href="#arguments" class="toc-anchor">¶</a> Arguments

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On Windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On Windows this would be `/nobrowser`


