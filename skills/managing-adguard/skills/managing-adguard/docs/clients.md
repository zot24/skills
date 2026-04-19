<!-- Source: https://github.com/AdguardTeam/AdGuardHome/wiki/Clients -->

[Skip to content](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#start-of-content)

You signed in with another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients) to refresh your session.You signed out in another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients) to refresh your session.You switched accounts on another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients) to refresh your session.Dismiss alert

{{ message }}

[AdguardTeam](https://github.com/AdguardTeam)/ **[AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)** Public

- [Notifications](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome) You must be signed in to change notification settings
- [Fork\\
2.3k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)
- [Star\\
33.6k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)


# Clients

[Jump to bottom](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#wiki-pages-box)

Ainar Garipov edited this page on Nov 16, 2022Nov 16, 2022
·
[11 revisions](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients/_history)

# AdGuard Home - Configuring clients

[Permalink: AdGuard Home - Configuring clients](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#adguard-home---configuring-clients)

AdGuard Home allows flexible configuration for devices that are connected to it.
On a basic level, you may just want to be able to distinguish them and see
friendly names instead of naked IP addresses. Additionally, AdGuard Home allows
you applying different rules depending on the client.

- [Friendly names](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#friendlynames)
- [Persistent clients](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#newclient)  - [Identifying clients](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#idclient)
  - [Settings](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#clientsettings)
- [Per-client blocking](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#perclientblocking)

## [Friendly names](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients\#friendlynames)

[Permalink: Friendly names](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#friendly-names)

AdGuard Home tries to automatically collect some basic information about the
device that's connecting to it.

Here is what it tries to do in order to figure out the client's hostname:

1. inspects the hosts files (for example, `/etc/hosts`) and uses hostnames
found there to identify clients;

2. makes reverse DNS lookups;

3. inspects the system ARP table;

4. for public IP addresses it also makes [WHOIS](https://en.wikipedia.org/wiki/WHOIS) queries in order to
find out the client's location and the company the IP belongs to;

5. for IP addresses leased by AdGuard Home's DHCP server it obtains the
hostname from leases.


If the only thing you need is to see friendly names in AdGuard Home stats then
editing the hosts file may be the easiest way to achieve this. Please note that
you may need to restart AdGuard Home to apply the changes.

![](https://github.com/AdguardTeam/AdGuardHome/wiki/images/top-clients-names.png)

Since **v0.107.7** runtime clients sources can be disabled via the
[`clients.runtime_sources`](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file) object of the configuration file.

## [Persistent clients](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients\#newclient)

[Permalink: Persistent clients](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#persistent-clients)

If you want more than just to see the client names, you may want to configure
each client manually. If that's the case, head to the “Settings → Clients
settings” page and click the "Add client" button there.

![](https://github.com/AdguardTeam/AdGuardHome/wiki/images/new-client.png)

### [Identifying clients](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients\#idclient)

[Permalink: Identifying clients](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#identifying-clients)

First of all, you need to decide how you would like to identify the client.
There are several options to do this.

1. **IP address.** For instance, `192.168.0.1`. This is the easiest way to do
this, but it may be not good enough if the IP address changes too often.

2. **CIDR range.** For instance, `192.168.0.1/24`. Allows attributing a whole
range of IP addresses (in the example it is `192.168.0.*`) to the same
client.

3. **MAC address.** Using MAC as a client identifier is **only** possible when
AdGuard Home works as the network's [DHCP server](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP).

4. **ClientIDs.** Special identifiers that can be used with some encrypted DNS
protocols. [See below](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#clientid).


#### [ClientID](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients\#clientid)

[Permalink: ClientID](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#clientid)

ClientIDs are identifiers that can be used with the following DNS protocols:
DNS-over-HTTPS, DNS-over-TLS, and DNS-over-QUIC. To use this identifier,
clients should perform queries using a special domain name or URL. For example:

- AdGuard Home has the domain name `example.org`.

- In AdGuard Home you add a persistent client with the ClientID `my-client`.

- On the client device you can now configure:
  - **DNS-over-HTTPS:**`https://example.org/dns-query/my-client`.

    Since **v0.108.0-b.18:**`https://my-client.example.org/dns-query`
    (requires a [wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate)). **NOTE:** The URL ClientID
    has higher priority than the server-name ClientID. If you use both,
    only the URL ClientID is used.

  - **DNS-over-QUIC:**`quic://my-client.example.org` (requires a [wildcard\\
    certificate](https://en.wikipedia.org/wiki/Wildcard_certificate)).

  - **DNS-over-TLS:**`tls://my-client.example.org` (requires a [wildcard\\
    certificate](https://en.wikipedia.org/wiki/Wildcard_certificate)).

Note that the TLS certificate must be valid **both** for `*.example.org` **and**`example.org`.

### [Settings](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients\#clientsettings)

[Permalink: Settings](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#settings)

Each client can be configured individually. You may choose what to block, what
settings should be used, or you could even configure a completely different set
of upstream DNS servers to be used for this client.

![](https://github.com/AdguardTeam/AdGuardHome/wiki/images/client-settings.png)

## [Per-client blocking](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients\#perclientblocking)

[Permalink: Per-client blocking](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#per-client-blocking)

There are two ways of how you can configure blocking on the per-client basis.
Both of them are based on using AdGuard blocklist rules syntax for the rules
you're adding to "Custom filtering rules".

### `client` rules

[Permalink: client rules](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#client-rules)

The first one is using the `client` modifier. This way you can limit the rule
to a particular client or clients.

Examples:

- `@@||*^$client=127.0.0.1`: Unblock everything for localhost.

- `||example.org^$client='Frank\'s laptop'`: Block `example.org` for the
client named `Frank's laptop` only. Note that quote (`'`) in the name must
be escaped.

- `||example.org^$client=192.168.0.0/24`: Block `example.org` for all clients
with the IP addresses in the range `192.168.0.0-192.168.0.255`.


You can find more `client` examples in the [article](https://github.com/AdguardTeam/AdGuardHome/wiki/Hosts-Blocklists#client)
about the filtering rules syntax.

### `ctag` rules

[Permalink: ctag rules](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#ctag-rules)

The second way is to use another modifier called `ctag`. When you create a new
client, tags can be assigned to it. These tags can then be used in the
filtering rules.

Examples:

- `||example.org^$ctag=device_pc|device_phone`: Block `example.org` for
clients tagged as `device_pc` or `device_phone`.

- `||example.org^$ctag=~device_phone`: Block `example.org` for all clients
except those tagged as `device_phone`.


You can find more `ctag` examples as well as the full list of tags in the
[article](https://github.com/AdguardTeam/AdGuardHome/wiki/Hosts-Blocklists#ctag) about the filtering rules syntax.

## Guides

[Permalink: Guides](https://github.com/AdguardTeam/AdGuardHome/wiki/Clients#guides)

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