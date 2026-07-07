> Source: https://wiki.servarr.com/lidarr/installation



# <a href="#by-platform" class="toc-anchor">¶</a> By Platform

<a href="/lidarr/installation/windows" class="is-internal-link is-valid-page"><em></em></a>    <a href="/lidarr/installation/linux" class="is-internal-link is-valid-page"><em></em></a>    <a href="/lidarr/installation/macos" class="is-internal-link is-valid-page"><em></em></a>    <a href="/lidarr/installation/freebsd" class="is-internal-link is-valid-page"><em></em></a>    <a href="/lidarr/installation/docker" class="is-internal-link is-valid-page"><em></em></a>

# <a href="#recommended-guides" class="toc-anchor">¶</a> Recommended Guides

- <a href="/lidarr/installation/reverse-proxy" class="is-internal-link is-valid-page">Setup Reverse Proxy <em>Complete guide for reverse proxy setup with Nginx or Apache</em></a>

# <a href="#post-install-configuration" class="toc-anchor">¶</a> Post-install configuration

Small configuration tweaks that apply regardless of platform. For installation itself, use the platform links above.

## <a href="#disable-browser-on-startup" class="toc-anchor">¶</a> Disable browser-on-startup

By default Lidarr opens a browser window to its UI when it starts. Three ways to turn that off (pick whichever fits your setup):

- **Settings UI:** on most platforms, Settings → General has a **Launch Browser on Start** checkbox. Uncheck it and save. The checkbox isn't present on every platform (notably headless server builds), in which case use one of the options below.
- **Command-line flag:** add `-nobrowser` (Linux/macOS) or `/nobrowser` (Windows) to the Lidarr invocation. For systemd services, add the flag to the `ExecStart=` line in the unit file; for Windows services, edit the service command via `sc config` or directly in the registry. Docker containers never open a browser, so this flag is irrelevant there.
- **Config file:** stop Lidarr, open `config.xml` in the <a href="/lidarr/appdata-directory" class="is-internal-link is-valid-page">AppData directory</a>, and set `<LaunchBrowser>False</LaunchBrowser>`. Start Lidarr.

Pick one. They don't stack.


