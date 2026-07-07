> Source: https://wiki.servarr.com/lidarr/appdata-directory



> Below are the default paths for the application data directory

> All instances of `$USER` are placeholders for the user the application is running under.

# <a href="#windows" class="toc-anchor">¶</a> Windows

`%ProgramData%\Lidarr`

# <a href="#linux" class="toc-anchor">¶</a> Linux

Unless otherwise specified Lidarr will store it's application data in the home folder of the user Lidarr is running under `/home/$USER/.config/Lidarr` or `~/.config/Lidarr`

The installation instructions specify `/var/lib/lidarr`

# <a href="#macos-osx" class="toc-anchor">¶</a> MacOS (OSX)

`/Users/$USER/Library/Application Support/Lidarr` or `~/Library/Application Support/Lidarr`

# <a href="#synology" class="toc-anchor">¶</a> Synology

`/usr/local/Lidarr/var/.config/Lidarr`

`/volume1/@appstore/Lidarr/var/.config/Lidarr`

# <a href="#qnap" class="toc-anchor">¶</a> QNAP

`/share/MD0_DATA/homes/admin/.config/Lidarr`

`/share/CACHEDEV1_DATA/Lidarr_CONFIG`

# <a href="#docker" class="toc-anchor">¶</a> Docker

`/config`

- This will vary based on where the user maps `/config` to on their host system

# <a href="#arguments" class="toc-anchor">¶</a> Arguments

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when running more than one instance. On Windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On Windows this would be `/nobrowser`


