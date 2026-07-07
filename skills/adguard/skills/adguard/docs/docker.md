> Source: https://raw.githubusercontent.com/wiki/AdguardTeam/AdGuardHome/Docker.md

 #  AdGuard Home - Docker

&nbsp;
<p align="center">
    <img src="https://cdn.adguard.com/public/Adguard/Common/adguard_home.svg" width="300px" alt="AdGuard Home" />
</p>
<h3 align="center">Privacy protection center for you and your devices</h3>
<p align="center">
    Free and open source, powerful network-wide ads & trackers blocking DNS server.
</p>
<br/>
<p align="center">
    <img src="https://cdn.adguard.com/public/Adguard/Common/adguard_home.gif" width="800"/>
</p>

 *  [Introduction](#introduction)
 *  [Quick start](#quickstart)
 *  [Update to a newer version](#update)
 *  [Running development builds](#unstable)
 *  [Additional configuration](#configuration)
 *  [DHCP server](#dhcp)
 *  [`resolved`](#resolved-daemon)



##  <a href="#introduction" id="introduction" name="introduction">Introduction</a>

AdGuard Home is a network-wide software for blocking ads and tracking.  After
you set it up, it'll cover *all* your home devices, and you won't need any
client-side software for that.  Learn more on our [official Github
repository][agh].

[agh]: https://github.com/AdguardTeam/AdGuardHome



##  <a href="#quickstart" id="quickstart" name="quickstart">Quick start</a>

   ###  Pull the Docker image

This command will pull the latest stable version:

```sh
docker pull adguard/adguardhome
```

   ###  Create directories for persistent configuration and data

The image exposes two volumes for data and configuration persistence.  You
should create a **data** directory on a suitable volume on your host system,
e.g. `/my/own/workdir`, and a **configuration** directory on a suitable volume
on your host system, e.g. `/my/own/confdir`.

   ###  Create and run the container

Use the following command to create a new container and run AdGuard Home:

```sh
docker run --name adguardhome\
    --restart unless-stopped\
    -v /my/own/workdir:/opt/adguardhome/work\
    -v /my/own/confdir:/opt/adguardhome/conf\
    -p 53:53/tcp -p 53:53/udp\
    -p 67:67/udp -p 68:68/udp\
    -p 80:80/tcp -p 443:443/tcp -p 443:443/udp -p 3000:3000/tcp\
    -p 853:853/tcp\
    -p 853:853/udp\
    -p 5443:5443/tcp -p 5443:5443/udp\
    -p 6060:6060/tcp\
    -d adguard/adguardhome
```

Now you can open the browser and navigate to http://127.0.0.1:3000/ to control
your AdGuard Home service.

Don't forget to use your own **data** and **config** directories!

Port mappings you might need:

 *  `-p 53:53/tcp -p 53:53/udp`: plain DNS.

 *  `-p 67:67/udp -p 68:68/tcp -p 68:68/udp`: add if you intend to use AdGuard
    Home as a DHCP server.

 *  `-p 80:80/tcp -p 443:443/tcp -p 443:443/udp -p 3000:3000/tcp`: add if you
    are going to use AdGuard Home's admin panel as well as run AdGuard Home as
    an [HTTPS/DNS-over-HTTPS][enc] server.

 *  `-p 853:853/tcp`: add if you are going to run AdGuard Home as
    a [DNS-over-TLS][enc] server.

 *  `-p 853:853/udp`: add if you are going to run AdGuard Home as a
    [DNS-over-QUIC][enc] server.

 *  `-p 5443:5443/tcp -p 5443:5443/udp`: add if you are going to run AdGuard
    Home as a [DNSCrypt] server.

 *  `-p 6060:6060/tcp`: debugging profiles.

   ###  Client IPs

If you want AdGuardHome to see the original client IPs as opposed to something
like `172.17.0.1`, you should add `--network host` to the list of options.

   ###  Control the container

 *  Start: `docker start adguardhome`

 *  Stop: `docker stop adguardhome`

 *  Remove: `docker rm adguardhome`

[DNSCrypt]: https://github.com/AdguardTeam/AdGuardHome/wiki/DNSCrypt
[enc]:      https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption



##  <a href="#update" id="update" name="update">Update to a newer version</a>

1.  Pull the new version from Docker Hub:

    ```sh
    docker pull adguard/adguardhome
    ```

2.  Stop and remove currently running container (assuming the container is named
    `adguardhome`):

    ```sh
    docker stop adguardhome
    docker rm adguardhome
    ```

3.  Create and start the container using the new image using the command from
    the previous section.



##  <a href="#unstable" id="unstable" name="unstable">Running development builds</a>

If you want to be on the bleeding edge, you might want to run the image from the
`edge` or `beta` tags.  In order to use it, simply replace `adguard/adguardhome`
with `adguard/adguardhome:edge` or `adguard/adguardhome:beta` in every command
from the quick start.  For example:

```sh
docker pull adguard/adguardhome:edge
```



## <a href="#configuration" id="configuration" name="configuration">Additional configuration</a>

Upon the first run, a file with the default values named `AdGuardHome.yaml` is
created.  You can modify the file while your AdGuard Home container is not
running.  Otherwise, any changes to the file will be lost because the running
program will overwrite them.

The settings are stored in the [YAML] format.  The documentation describing all
configurable parameters and their values is available on [this page][conf].

   ###  `HEALTHCHECK`

**Between v0.107.27 and v0.107.33,** the image used Docker-provided healthcheck
mechanism.  It was causing many issues and has been removed **in v0.107.34.**
See issues [#5711], [#5713], and discussion [#5939].

If you need a healthcheck mechanism, it's better to create your own image
tailored for your configuration.  Implementations may use the special domain
name `healthcheck.adguardhome.test.`, expecting it to resolve into NODATA
answer.  It imposes restrictions on usage of this particular name, so specifying
it within the `blocked_hosts` array under the `dns` section of configuration
file will break the healthcheck.  The `allowed_clients` and `disallowed_clients`
properties should allow the healthcheck client IP as well.

[#5711]: https://github.com/AdguardTeam/AdGuardHome/issues/5711
[#5713]: https://github.com/AdguardTeam/AdGuardHome/issues/5713
[#5939]: https://github.com/AdguardTeam/AdGuardHome/discussions/5939
[YAML]:  https://yaml.org
[conf]:  https://github.com/AdguardTeam/Adguardhome/wiki/Configuration



##  <a href="#dhcp" id="dhcp" name="dhcp">DHCP server</a>

If you want to use AdGuardHome's DHCP server, you should pass `--network host`
argument when creating the container:

```sh
docker run --name adguardhome --network host ...
```

This option instructs Docker to use the host's network rather than
a docker-bridged network.  Note that port mapping with `-p` is not necessary in
this case.

A note from the Docker documentation:

 >  The host networking driver only works on Linux hosts, and is not supported on
 >  Docker Desktop for Mac, Docker Desktop for Windows, or Docker EE for Windows
 >  Server.



##  <a href="#resolved-daemon" id="resolved-daemon" name="resolved-daemon">`resolved`</a>

If you try to run AdGuardHome on a system where the `resolved` daemon is
started, docker will fail to bind on port 53, because `resolved` daemon is
listening on `127.0.0.53:53`.  Here's how you can disable `DNSStubListener` on
your machine:

1.  Deactivate `DNSStubListener` and update the DNS server address.  Create
    a new file, `/etc/systemd/resolved.conf.d/adguardhome.conf` (creating
    the `/etc/systemd/resolved.conf.d` directory if needed) and add the
    following content to it:

    ```service
    [Resolve]
    DNS=127.0.0.1
    DNSStubListener=no
    ```

    Specifying `127.0.0.1` as the DNS server address is necessary because
    otherwise the nameserver will be `127.0.0.53` which doesn't work without
    `DNSStubListener`.

2.  Activate a new `resolv.conf` file:

    ```sh
    mv /etc/resolv.conf /etc/resolv.conf.backup
    ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
    ```

3.  Stop `DNSStubListener`:

    ```sh
    systemctl reload-or-restart systemd-resolved
    ```
