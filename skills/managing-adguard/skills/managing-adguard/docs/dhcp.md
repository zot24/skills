<!-- Source: https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP -->

[Skip to content](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#start-of-content)

You signed in with another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP) to refresh your session.You signed out in another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP) to refresh your session.You switched accounts on another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP) to refresh your session.Dismiss alert

{{ message }}

[AdguardTeam](https://github.com/AdguardTeam)/ **[AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)** Public

- [Notifications](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome) You must be signed in to change notification settings
- [Fork\\
2.3k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)
- [Star\\
33.6k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)


# DHCP

[Jump to bottom](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#wiki-pages-box)

Stanislav Chzhen edited this page on Apr 18, 2023Apr 18, 2023
·
[11 revisions](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP/_history)

# AdGuard Home - DHCP server

[Permalink: AdGuard Home - DHCP server](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#adguard-home---dhcp-server)

- [Prerequisites](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#prereq)
- [Default options](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#default)
- [Configuration](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#config)  - [The `dhcp.dhcpv4.options` array field](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#config-4)
  - [DHCPv6 options](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#config-6)
- [Automatic hosts](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#autohosts)
- [Stored leases](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#storedleases)

AdGuard Home can be used as a DHCP server. This page describes how to do that.

## [Prerequisites](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP\#prereq)

[Permalink: Prerequisites](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#prerequisites)

1. Make sure that you run an OS on which AdGuard Home supports DHCP. We
currently don't support DHCP on Windows.

2. Make sure that your machine has a static IP address.


## [Default options](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP\#default)

[Permalink: Default options](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#default-options)

By default, AdGuard Home will set itself as the DNS server for the DHCP clients.
The default lease time is 24 hours.

## [Configuration](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP\#config)

[Permalink: Configuration](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#configuration)

See the DHCP section in the [configuration](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration) article for the overview of the DHCP
configuration options. There are several configuration parameters for DHCP that
can't be set via the AdGuard Home administrator dashboard. Those are described
below.

### [The `dhcp.dhcpv4.options` array field](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP\#config-4)

[Permalink: The dhcp.dhcpv4.options array field](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#the-dhcpdhcpv4options-array-field)

The `options` field is used to explicitly specify the values for DHCP options
and modify the response. In accordance with _Section 4.3.1_ of [RFC\\
2131](https://datatracker.ietf.org/doc/html/rfc2131), these options override the default options' values set by
Adguard Home and requested by a client. Which means that if you want to set
custom DNS server addresses using option `6` (Domain Name Server), you may want
also add Adguard Home's own addresses there. Otherwise, AdGuard Home's
filtering won't work for the DHCP clients who receive these DNS server
addresses.

Any option begins with an option _code_ written as decimal integer. See [RFC\\
2132](https://datatracker.ietf.org/doc/html/rfc2132) for the actual DHCP option codes and allowed lengths. The code
is followed by an option's _type_ and _value_. Currently the following _types_
are supported:

- `bool` (since **v0.107.12**) accepts a human-readable form of a boolean
value, and has the length of 1 octet.

For example:



```
'options':
- '19 bool 0'     # Disable IP forwarding for hosts.
- '20 bool t'     # Enable non-local source routing for hosts.
- '27 bool F'     # Disable ahoming for hosts.
- '30 bool true'  # Enable mask supplying for supporting hosts.
- '36 bool False' # Make the hosts use RFC 894 for ethernet encapsulation.
```

- `del` (since **v0.107.12**) is a no-value option and is used to
unconditionally remove options from the server's responses (which may lead
to weird behaviors, use with caution).

Since the list of options is interpreted sequentially from first to last,
the subsequent option may override the previous ones. So this:



```
'options':
- '19 bool T'
- '19 del'
- '20 del'
- '20 bool F'
```

instructs to remove the option `19`, and to set the option `20` to `false`.

- `dur` (since **v0.107.12**) accepts a human-readable form of a duration in
range \[0 – 4294967296 seconds (about 136 days)\] and has a length of _4_
octets, just like a 32-bit unsigned integer.

Here is the example of setting the MTU aging timeout to 10 minutes:



```
'options':
- '24 dur 10m'
```

- `hex` accepts a sequence of hexadecimal numbers of an arbitrary length.

Here is the example of setting the plateau table for path MTU timeouts:



```
'options':
- '25 hex 0044012801FC03EE05D407D211001FE645FA'
```

- `ip` accepts an IPv4 address and has a length of _4_ octets, just like an
IPv4 itself.

Here is the example of setting a broadcast address option:



```
'options':
- '28 ip 192.168.0.255'
```

- `ips` (since **v0.106.0**) accepts a comma-separated list if IPv4 addresses.
It has an arbitrary length, but is always a multiple of _4_ octets.

Here is the example of setting the domain name servers to `1.2.3.4` and
`1.2.3.5`:



```
'options':
- '6 ips 1.2.3.4,1.2.3.5'
```

- `text` (since **v0.106.0**) accepts an arbitrary UTF-8 encoded string and
has a length of encoded text.

Here is the example of setting the path to configuration file for WPAD:



```
'options':
- '252 text http://server.domain/proxyconfig.pac'
```

- `u8` (since **v0.107.12**) accepts a decimal number in range \[0 – 255\] and
takes _1_ octet, just like an unsigned 8-bit integer.

Here is the example of setting the TTL for Internet Protocol:



```
'options':
- '23 u8 64'
```

- `u16` (since **v0.107.12**) accepts a decimal number in range \[0 – 65535\]
and takes _2_ octets, just like an unsigned 16-bit integer.

Here is the example of setting the maximum datagram reassembly size to 576
bytes:



```
'options':
- '22 u16 576'
```

**NOTE:** Thoroughly check that the option format and value are valid for the
chosen type in accordance with [RFC 2132](https://datatracker.ietf.org/doc/html/rfc2132) or others. AdGuard Home does
not perform any option-specific validations.

Currently there is a set of options listed in _Appendix A_ of [RFC\\
2131](https://datatracker.ietf.org/doc/html/rfc2131) with the default values chosen according to the documents
mentioned there:

| Option | Value |
| --- | --- |
| IP Forwarding | Disabled |
| Non-Local Source Routing | Disabled |
| Maximum Datagram Reassembly Size | 576 bytes |
| Default IP Time-to-live | 64 seconds |
| Path MTU Aging Timeout Option | 10 minutes |
| Path MTU Plateau Table | See [Table 7.1 in RFC 1191](https://datatracker.ietf.org/doc/html/rfc1191#section-7.1) |
| Interface MTU | 576 bytes |
| All subnets are local | False |
| Perform Mask Discovery | False |
| Mask Supplier | False |
| Perform Router Discovery | True |
| Router Solicitation Address | 224.0.0.2 |
| Broadcast Address | 255.255.255.255 |
| Use Trailer Encapsulation | False |
| ARP Cache Timeout | 1 minute |
| Ethernet Encapsulation version | RFC 894 |
| Default TCP TTL | 60 seconds |
| TCP Keepalive Interval | 2 hours |
| Put TCP Keepalive Garbage | True |
| Routers | `gateway_ip` from configuration |
| Subnet Mask | `subnet_mask` from configuration |

Some of these values may appear obsolete or may cause issues with some DHCP
client implementations among the many existing. In accordance with [RFC\\
2131](https://datatracker.ietf.org/doc/html/rfc2131) the options, when not explicitly configured, are only returned
if requested by client within the option `55` (Parameter Request List).

### [DHCPv6 options](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP\#config-6)

[Permalink: DHCPv6 options](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#dhcpv6-options)

The option `dhcp.dhcpv6.ra_slaac_only`, if `true`, sends RA packets forcing the
clients to use SLAAC. The DHCPv6 server won't be started in this case.

The option `dhcp.dhcpv6.ra_allow_slaac`, if `true`, sends RA packets allowing
the clients to choose between SLAAC and DHCPv6.

## [Automatic hosts](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP\#autohosts)

[Permalink: Automatic hosts](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#automatic-hosts)

Machines in the network can be reached more easily using the hostnames they send
in the DHCP requests with a configurable top-level domain (TLD). By default,
the TLD is `lan`. For example, if you have a machine called “workstation” in
the network, and it sends a DHCP request with option 12 set to `workstation`,
you can reach it over HTTP on the host `http://workstation.lan`.

You can also set a custom TLD or domain name using the `dns.local_domain_name`
field in the [configuration](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration) file.

## [Stored leases](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP\#storedleases)

[Permalink: Stored leases](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#stored-leases)

DHCP leases stored in `data/leases.json`. The file format is not stable and
may change in the future releases.

## Guides

[Permalink: Guides](https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#guides)

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