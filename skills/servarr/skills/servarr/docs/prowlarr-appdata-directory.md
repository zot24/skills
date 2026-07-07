> Source: https://wiki.servarr.com/prowlarr/appdata-directory



> Below are the default paths for the application data directory

> All instances of `$USER` are placeholders for the user the application is running under.

# <a href="#windows" class="toc-anchor">¶</a> Windows

- `C:\ProgramData\Prowlarr`

# <a href="#linux" class="toc-anchor">¶</a> Linux

Unless otherwise specified Prowlarr will store it's application data in the home folder of the user Prowlarr is running under

- `/home/$USER/.config/Prowlarr`
- `~/.config/Prowlarr`

The installation instructions specify `/var/lib/prowlarr`

# <a href="#macos-osx" class="toc-anchor">¶</a> MacOS (OSX)

- `~/Library/Application Support/Prowlarr`
- `/Users/$USER/.config/Prowlarr`
- `~/.config/Prowlarr`

# <a href="#synology" class="toc-anchor">¶</a> Synology

- `/usr/local/Prowlarr/var/.config/Prowlarr`
- `/volume1/@appstore/Prowlarr/var/.config/Prowlarr`

# <a href="#qnap" class="toc-anchor">¶</a> QNAP

- `/share/MD0_DATA/homes/admin/.config/Prowlarr`
- `/share/CACHEDEV1_DATA/Prowlarr_CONFIG`

# <a href="#docker" class="toc-anchor">¶</a> Docker

- `/config`
- This will vary based on where the user maps `/config` to on their host system

# <a href="#arguments" class="toc-anchor">¶</a> Arguments

- The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On Windows this would be `/data=`
- The `-nobrowser` argument refrains from launching/opening the browser on startup. On Windows this would be `/nobrowser`


