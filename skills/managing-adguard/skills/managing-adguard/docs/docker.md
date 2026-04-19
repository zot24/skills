<!-- Source: https://github.com/AdguardTeam/AdGuardHome/wiki/Docker -->

[Skip to content](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#start-of-content)

You signed in with another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker) to refresh your session.You signed out in another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker) to refresh your session.You switched accounts on another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker) to refresh your session.Dismiss alert

{{ message }}

[AdguardTeam](https://github.com/AdguardTeam)/ **[AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)** Public

- [Notifications](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome) You must be signed in to change notification settings
- [Fork\\
2.3k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)
- [Star\\
33.6k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)


# Docker

[Jump to bottom](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#wiki-pages-box)

Eugene Burkov edited this page on Aug 29, 2023Aug 29, 2023
·
[21 revisions](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker/_history)

# AdGuard Home - Docker

[Permalink: AdGuard Home - Docker](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#adguard-home---docker)

![AdGuard Home](https://camo.githubusercontent.com/159e828ae628708b8a20032c19d9359b4193a1d378c502d0033f2c6078bcb56d/68747470733a2f2f63646e2e616467756172642e636f6d2f7075626c69632f416467756172642f436f6d6d6f6e2f616467756172645f686f6d652e737667)

### Privacy protection center for you and your devices

[Permalink: Privacy protection center for you and your devices](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#privacy-protection-center-for-you-and-your-devices)

Free and open source, powerful network-wide ads & trackers blocking DNS server.

![](https://camo.githubusercontent.com/c695c135b7267e556d673622ee98906d3e10aa063e33df2988e3091e85f9bf47/68747470733a2f2f63646e2e616467756172642e636f6d2f7075626c69632f416467756172642f436f6d6d6f6e2f616467756172645f686f6d652e676966)![](https://camo.githubusercontent.com/c695c135b7267e556d673622ee98906d3e10aa063e33df2988e3091e85f9bf47/68747470733a2f2f63646e2e616467756172642e636f6d2f7075626c69632f416467756172642f436f6d6d6f6e2f616467756172645f686f6d652e676966)[Open in new window](https://camo.githubusercontent.com/c695c135b7267e556d673622ee98906d3e10aa063e33df2988e3091e85f9bf47/68747470733a2f2f63646e2e616467756172642e636f6d2f7075626c69632f416467756172642f436f6d6d6f6e2f616467756172645f686f6d652e676966)

- [Introduction](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#introduction)
- [Quick start](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#quickstart)
- [Update to a newer version](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#update)
- [Running development builds](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#unstable)
- [Additional configuration](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#configuration)
- [DHCP server](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#dhcp)
- [`resolved`](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#resolved-daemon)

## [Introduction](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker\#introduction)

[Permalink: Introduction](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#introduction)

AdGuard Home is a network-wide software for blocking ads and tracking. After
you set it up, it'll cover _all_ your home devices, and you won't need any
client-side software for that. Learn more on our [official Github\\
repository](https://github.com/AdguardTeam/AdGuardHome).

## [Quick start](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker\#quickstart)

[Permalink: Quick start](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#quick-start)

### Pull the Docker image

[Permalink: Pull the Docker image](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#pull-the-docker-image)

This command will pull the latest stable version:

```
docker pull adguard/adguardhome
```

### Create directories for persistent configuration and data

[Permalink: Create directories for persistent configuration and data](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#create-directories-for-persistent-configuration-and-data)

The image exposes two volumes for data and configuration persistence. You
should create a **data** directory on a suitable volume on your host system,
e.g. `/my/own/workdir`, and a **configuration** directory on a suitable volume
on your host system, e.g. `/my/own/confdir`.

### Create and run the container

[Permalink: Create and run the container](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#create-and-run-the-container)

Use the following command to create a new container and run AdGuard Home:

```
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

Now you can open the browser and navigate to [http://127.0.0.1:3000/](http://127.0.0.1:3000/) to control
your AdGuard Home service.

Don't forget to use your own **data** and **config** directories!

Port mappings you might need:

- `-p 53:53/tcp -p 53:53/udp`: plain DNS.

- `-p 67:67/udp -p 68:68/tcp -p 68:68/udp`: add if you intend to use AdGuard
Home as a DHCP server.

- `-p 80:80/tcp -p 443:443/tcp -p 443:443/udp -p 3000:3000/tcp`: add if you
are going to use AdGuard Home's admin panel as well as run AdGuard Home as
an [HTTPS/DNS-over-HTTPS](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption) server.

- `-p 853:853/tcp`: add if you are going to run AdGuard Home as
a [DNS-over-TLS](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption) server.

- `-p 853:853/udp`: add if you are going to run AdGuard Home as a
[DNS-over-QUIC](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption) server.

- `-p 5443:5443/tcp -p 5443:5443/udp`: add if you are going to run AdGuard
Home as a [DNSCrypt](https://github.com/AdguardTeam/AdGuardHome/wiki/DNSCrypt) server.

- `-p 6060:6060/tcp`: debugging profiles.


### Client IPs

[Permalink: Client IPs](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#client-ips)

If you want AdGuardHome to see the original client IPs as opposed to something
like `172.17.0.1`, you should add `--network host` to the list of options.

### Control the container

[Permalink: Control the container](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#control-the-container)

- Start: `docker start adguardhome`

- Stop: `docker stop adguardhome`

- Remove: `docker rm adguardhome`


## [Update to a newer version](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker\#update)

[Permalink: Update to a newer version](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#update-to-a-newer-version)

1. Pull the new version from Docker Hub:



```
docker pull adguard/adguardhome
```

2. Stop and remove currently running container (assuming the container is named
`adguardhome`):



```
docker stop adguardhome
docker rm adguardhome
```

3. Create and start the container using the new image using the command from
the previous section.


## [Running development builds](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker\#unstable)

[Permalink: Running development builds](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#running-development-builds)

If you want to be on the bleeding edge, you might want to run the image from the
`edge` or `beta` tags. In order to use it, simply replace `adguard/adguardhome`
with `adguard/adguardhome:edge` or `adguard/adguardhome:beta` in every command
from the quick start. For example:

```
docker pull adguard/adguardhome:edge
```

## [Additional configuration](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker\#configuration)

[Permalink: Additional configuration](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#additional-configuration)

Upon the first run, a file with the default values named `AdGuardHome.yaml` is
created. You can modify the file while your AdGuard Home container is not
running. Otherwise, any changes to the file will be lost because the running
program will overwrite them.

The settings are stored in the [YAML](https://yaml.org/) format. The documentation describing all
configurable parameters and their values is available on [this page](https://github.com/AdguardTeam/Adguardhome/wiki/Configuration).

### `HEALTHCHECK`

[Permalink: HEALTHCHECK](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#healthcheck)

**Between v0.107.27 and v0.107.33,** the image used Docker-provided healthcheck
mechanism. It was causing many issues and has been removed **in v0.107.34.**
See issues [#5711](https://github.com/AdguardTeam/AdGuardHome/issues/5711), [#5713](https://github.com/AdguardTeam/AdGuardHome/issues/5713), and discussion [#5939](https://github.com/AdguardTeam/AdGuardHome/discussions/5939).

If you need a healthcheck mechanism, it's better to create your own image
tailored for your configuration. Implementations may use the special domain
name `healthcheck.adguardhome.test.`, expecting it to resolve into NODATA
answer. It imposes restrictions on usage of this particular name, so specifying
it within the `blocked_hosts` array under the `dns` section of configuration
file will break the healthcheck. The `allowed_clients` and `disallowed_clients`
properties should allow the healthcheck client IP as well.

## [DHCP server](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker\#dhcp)

[Permalink: DHCP server](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#dhcp-server)

If you want to use AdGuardHome's DHCP server, you should pass `--network host`
argument when creating the container:

```
docker run --name adguardhome --network host ...
```

This option instructs Docker to use the host's network rather than
a docker-bridged network. Note that port mapping with `-p` is not necessary in
this case.

A note from the Docker documentation:

> The host networking driver only works on Linux hosts, and is not supported on
> Docker Desktop for Mac, Docker Desktop for Windows, or Docker EE for Windows
> Server.

## [`resolved`](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker\#resolved-daemon)

[Permalink: resolved](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#resolved)

If you try to run AdGuardHome on a system where the `resolved` daemon is
started, docker will fail to bind on port 53, because `resolved` daemon is
listening on `127.0.0.53:53`. Here's how you can disable `DNSStubListener` on
your machine:

1. Deactivate `DNSStubListener` and update the DNS server address. Create
a new file, `/etc/systemd/resolved.conf.d/adguardhome.conf` (creating
the `/etc/systemd/resolved.conf.d` directory if needed) and add the
following content to it:



```
[Resolve]
DNS=127.0.0.1
DNSStubListener=no
```







Specifying `127.0.0.1` as the DNS server address is necessary because
otherwise the nameserver will be `127.0.0.53` which doesn't work without
`DNSStubListener`.

2. Activate a new `resolv.conf` file:



```
mv /etc/resolv.conf /etc/resolv.conf.backup
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
```

3. Stop `DNSStubListener`:



```
systemctl reload-or-restart systemd-resolved
```


## Guides

[Permalink: Guides](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker#guides)

- [Getting Started](https://github.com/AdguardTeam/AdGuardHome/wiki/Getting-Started)  - [FAQ](https://github.com/AdguardTeam/AdGuardHome/wiki/FAQ)
  - [How to write hosts blocklists](https://github.com/AdguardTeam/AdGuardHome/wiki/Hosts-Blocklists)
  - [Comparing AdGuard Home to other solutions](https://github.com/AdguardTeam/AdGuardHome/wiki/Comparison)
- Installation
  - [Supported platforms](https://github.com/AdguardTeam/AdGuardHome/wiki/Platforms)
  - [Docker](https://github.com/AdguardTeam/AdGuardHome/wiki/Docker)
  - [How to install and run AdGuard Home on a Raspberry Pi](https://github.com/AdguardTeam/AdGuardHome/wiki/Raspberry-Pi)
  - [How to install and run AdGuard Home on a virtual private server](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS)
- [Configuration](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration)  - [Configuring AdGuard Home clients](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients)
  - [AdGuard Home as a DoH, DoT, or DoQ server](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption)
  - [AdGuard Home as a DNSCrypt server](https://github.com/AdguardTeam/AdGuardHome/wiki/DNSCrypt)
  - [AdGuard Home as a DHCP server](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP)
- [Verifying releases](https://github.com/AdguardTeam/AdGuardHome/wiki/Verify-Releases)

### Clone this wiki locally

You can’t perform that action at this time.