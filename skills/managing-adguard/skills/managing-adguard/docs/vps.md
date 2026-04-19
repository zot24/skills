<!-- Source: https://github.com/AdguardTeam/AdGuardHome/wiki/VPS -->

[Skip to content](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS#start-of-content)

You signed in with another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS) to refresh your session.You signed out in another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS) to refresh your session.You switched accounts on another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS) to refresh your session.Dismiss alert

{{ message }}

[AdguardTeam](https://github.com/AdguardTeam)/ **[AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)** Public

- [Notifications](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome) You must be signed in to change notification settings
- [Fork\\
2.3k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)
- [Star\\
33.6k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)


# VPS

[Jump to bottom](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS#wiki-pages-box)

Ainar Garipov edited this page on Feb 26, 2024Feb 26, 2024
·
[16 revisions](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS/_history)

# How to install and run AdGuard Home on a virtual private server (VPS)

[Permalink: How to install and run AdGuard Home on a virtual private server (VPS)](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS#how-to-install-and-run-adguard-home-on-a-virtual-private-server-vps)

Warning

This article is outdated. See [_Getting started_](https://adguard-dns.io/kb/adguard-home/getting-started/) and [_Running securely_](https://adguard-dns.io/kb/adguard-home/running-securely/) in our Knowledge Base.

To run AdGuard Home on a VPS, you need a server with Debian 8 or 9, x64 or x32.

> Among possible solutions are [Vultr](https://www.vultr.com/), [1&1](https://www.1and1.co.uk/dynamic-cloud-server#configure-server), [Cloudways](https://www.cloudways.com/), [HostGator](https://hostgator.com/), [Digital Ocean](https://www.digitalocean.com/), [Bytemark](https://www.bytemark.co.uk/cloud-hosting/) and many more. AdGuard is not affiliated with any of these or other VPS services.

## Initial installation

[Permalink: Initial installation](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS#initial-installation)

First let's ensure that your VPS has necessary minimal requirements, run this as root:

```
apt-get install sudo nano bind9-host
```

Go to [AdGuard Home page](https://github.com/AdguardTeam/AdGuardHome#installation) and download binaries for your architecture (64-bit Linux in this example).

To download AdGuard Home and unpack it execute following commands:

```
wget https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz
tar xvf AdGuardHome_linux_amd64.tar.gz
```

You can find out the directory where you've unpacked it to by running these commands:

```
cd AdGuardHome
pwd
```

Run `sudo ./AdGuardHome -s install` to install AdGuard Home as a system service.

Here are the other commands you might need to control the service.

- `AdGuardHome -s uninstall` \- uninstalls the AdGuard Home service.
- `AdGuardHome -s start` \- starts the service.
- `AdGuardHome -s stop` \- stops the service.
- `AdGuardHome -s restart` \- restarts the service.
- `AdGuardHome -s status` \- shows the current service status.

You can verify that it's working properly by running this command:

```
host doubleclick.net 127.0.0.1
```

If everything works correctly, you will get this output:

```
Using domain server:
Name: 127.0.0.1
Address: 127.0.0.1#53
Aliases:

Host doubleclick.net not found: 3(NXDOMAIN)
```

## Visit the web interface

[Permalink: Visit the web interface](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS#visit-the-web-interface)

You can access your AdGuard Home web interface on port 3000 by typing this in your browser — `http://1.2.3.4:3000/`

Replace 1.2.3.4 with the IP address of your VPS.

## Configure your devices to use your AdGuard Home

[Permalink: Configure your devices to use your AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS#configure-your-devices-to-use-your-adguard-home)

Now, once you've established that AdGuard Home works on your VPS, you can use it on your machine by changing system DNS settings to use your VPS's public IP address.

## Guides

[Permalink: Guides](https://github.com/AdguardTeam/AdGuardHome/wiki/VPS#guides)

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