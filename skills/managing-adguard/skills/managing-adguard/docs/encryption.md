<!-- Source: https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption -->

[Skip to content](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#start-of-content)

You signed in with another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption) to refresh your session.You signed out in another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption) to refresh your session.You switched accounts on another tab or window. [Reload](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption) to refresh your session.Dismiss alert

{{ message }}

[AdguardTeam](https://github.com/AdguardTeam)/ **[AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)** Public

- [Notifications](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome) You must be signed in to change notification settings
- [Fork\\
2.3k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)
- [Star\\
33.6k](https://github.com/login?return_to=%2FAdguardTeam%2FAdGuardHome)


# Encryption

[Jump to bottom](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#wiki-pages-box)

Eugene Burkov edited this page on Mar 3Mar 3, 2026
·
[18 revisions](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption/_history)

# AdGuard Home – Encryption

[Permalink: AdGuard Home – Encryption](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#adguard-home--encryption)

Warning

This article is outdated. See the [up-to-date version](https://adguard-dns.io/kb/adguard-home/encryption/) in our Knowledge Base.

We are proud to say that AdGuard Home supports all modern DNS encryption
protocols **out-of-the-box**:

- [DNS-over-HTTPS](https://en.wikipedia.org/wiki/DNS_over_HTTPS)
- [DNS-over-TLS](https://en.wikipedia.org/wiki/DNS_over_TLS)
- [DNS-over-QUIC](https://datatracker.ietf.org/doc/html/rfc9250)

> AdGuard Home also supports [DNSCrypt](https://dnscrypt.info/) (both
> client-side and server-side). [Read this](https://github.com/AdguardTeam/AdGuardHome/wiki/DNSCrypt) to learn about
> configuring AdGuard Home as a DNSCrypt server.

In this guide we will explain how to setup your own "Secure DNS" server with
AdGuard Home.

1. [Install AdGuard Home on your server](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#install)
2. [Register a domain name](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#register)
3. [Get an SSL certificate](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#certificate)   - [Using CertBot](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#certbot)     - [Get a certificate using DNS challenge](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#certbot-dnschallenge)
   - [Using Lego](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#lego)
4. [Configure AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#configure-home)
5. [Using with reverse proxy](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#reverse-proxy)   - [Nginx](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#nginx)
   - [Cloudflare CDN](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#cf-cdn)
   - [Other Headers](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#other-hdrs)
6. [Configure your devices](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#configure-devices)   - [Android](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#android)
   - [iOS](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#ios)
   - [Windows](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#windows)
   - [MacOS](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#macos)
   - [Other implementations](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#other-imps)

## [Install AdGuard Home on your server](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#install)

[Permalink: Install AdGuard Home on your server](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#install-adguard-home-on-your-server)

It does not make much sense to configure DNS encryption inside of your own local
network. The purpose of securing your DNS traffic is to secure it from
third-parties that might be analyzing or modifying it. For instance, from your
ISP.

It means that you will need a server with a public dedicated IP address. There
are plenty of cheap cloud servers providers: [DigitalOcean](https://digitalocean.com/),
[Vultr](https://vultr.com/), [Linode](https://www.linode.com/), etc. Just choose one, create a cloud server
there, and [install AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Getting-Started) on your server.

## [Register a domain name](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#register)

[Permalink: Register a domain name](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#register-a-domain-name)

First of all, you need a domain name. If you have never registered one, here is
a [simple instruction](https://www.pcworld.com/article/241722/web-apps/how-to-register-your-own-domain-name.html) that will help you with that.

## [Get an SSL certificate](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#certificate)

[Permalink: Get an SSL certificate](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#get-an-ssl-certificate)

Both `DNS-over-HTTPS` and `DNS-over-TLS` are based on [TLS\\
encryption](https://en.wikipedia.org/wiki/Transport_Layer_Security) so in order to use them, you will need to acquire an
SSL certificate.

An SSL certificate can be bought from a "Certificate Authority" (CA), a company
trusted by browsers and operating systems to enroll SSL certificates for
domains.

Alternatively, you can get the certificate for free from ["Let's Encrypt"\\
CA](https://letsencrypt.org/), a free certificate authority developed by the Internet
Security Research Group (ISRG).

In this guide I'll explain how to get a certificate from them.

### [Using CertBot](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#certbot)

[Permalink: Using CertBot](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#using-certbot)

Certbot is an easy-to-use client that fetches a certificate from Let’s Encrypt.

1. Go to [certbot.eff.org](https://certbot.eff.org/) and choose "None of the above"
software and your operating system.
2. Follow the installation instructions, and stop there – don't get to the "Get
Started" section.

#### [Get a certificate using DNS challenge](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#certbot-dnschallenge)

[Permalink: Get a certificate using DNS challenge](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#get-a-certificate-using-dns-challenge)

You have just got a domain name so I suppose using DNS challenge will be the
easiest way to get a certificate.

Run this command and follow the certbot's instructions:

```
sudo certbot certonly --manual --preferred-challenges=dns --preferred-chain="ISRG Root X1"
```

In the end you'll get two files:

- `fullchain.pem` – your PEM-encoded SSL certificate.

- `privkey.pem` – your PEM-encoded private key.


Both will be necessary to configure AdGuard Home.

> You will need to use the very same procedure to renew the existing
> certificate.

### [Using Lego](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#lego)

[Permalink: Using Lego](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#using-lego)

There's also a really nice and easy-to-use alternative to CertBot called
[lego](https://go-acme.github.io/lego).

1. Install it using [an appropriate method](https://go-acme.github.io/lego/installation).
2. Choose your DNS provider from [the list](https://go-acme.github.io/lego/dns)
and follow the instruction to obtain a certificate.

Also, here's [a simple script](https://github.com/ameshkov/legoagh) that you can use to automate
certificates generation and renewal.

## [Configure AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#configure-home)

[Permalink: Configure AdGuard Home](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#configure-adguard-home)

1. Open AdGuard Home web interface and go to settings.
2. Scroll down to the "Encryption" settings.

![](https://user-images.githubusercontent.com/5947035/53301027-2a0c2b80-385f-11e9-81f3-bcc63de4eef1.png)

3. Copy/paste the contents of the `fullchain.pem` file to "Certificates".
4. Copy/paste the contents of the `privkey.pem` file to "Private key".
5. Enter your domain name to "Server name".
6. Click "Save settings".

## [Using with reverse proxy](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#reverse-proxy)

[Permalink: Using with reverse proxy](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#using-with-reverse-proxy)

We already have a [guide](https://github.com/AdguardTeam/AdGuardHome/wiki/FAQ#how-to-configure-a-reverse-proxy-server-for-adguard-home) on configuring a reverse proxy
server for accessing AdGuard Home web UI.

Since v0.107.0 AdGuard Home is able to restrict DNS-over-HTTPS requests which
came from the proxy server not included into "trusted" list. By default, it's
configured to accept requests from IPv4 and IPv6 loopback addresses.

To enable AdGuard Home to handle DNS-over-HTTPS requests from a reverse proxy
server, set the `trusted_proxies` setting in `AdGuardHome.yaml` to the IP
address of the proxy server. If you have several proxy servers, you can use a
CIDR instead of a simple IP address.

### [Nginx reverse proxy](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#nginx)

[Permalink: Nginx reverse proxy](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#nginx-reverse-proxy)

To configure AdGuard Home for accepting requests from Nginx reverse proxy
server, make sure that the reverse proxy server itself is configured correctly.

The `nginx.conf` file should contain the appropriate directives to add the
supported forwarding headers to the request which are `X-Real-IP` or
`X-Forwarded-For`. This may be achieved with `ngx_http_realip_module` which is
explained [here](https://nginx.org/en/docs/http/ngx_http_realip_module.html). In short, the module takes real IP
address of the client and writes it to the HTTP request's header. The AdGuard
Home will receive and interpret the value of this header as real client's
address. The address of the reverse proxy server will be received too and also
checked against the "trusted" proxies list.

Another header you might want to proxy is the `Host` header, which is required
to make AdGuard Home recognize requests from clients that have a ClientID in
their hostnames.

For example, if the configuration of the reverse proxy server contains the
following directives:

```
location /dns-query {
   # …
   proxy_set_header Host $host;
   proxy_set_header X-Real-IP '1.2.3.4';
   proxy_bind 192.168.1.2;
   # …
}
```

AdGuard Home will get the `192.168.1.2` as the address of your proxy server and
check it against the `trusted_proxies`. The `1.2.3.4` will be controlled by
access settings in case the proxy is "trusted".

### [Cloudflare CDN](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#cf-cdn)

[Permalink: Cloudflare CDN](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#cloudflare-cdn)

The Cloudflare's content delivery network acts as the reverse proxy appending
its [own headers](https://support.cloudflare.com/hc/en-us/articles/200170986) to the forwarded requests, which are
`CF-Connecting-IP` and `True-Client-IP`. These are also supported by AdGuard
Home so the reverse proxy servers' [addresses](https://www.cloudflare.com/ips) may be
inserted into `trusted_proxies` list directly. An official Cloudflare's
reference on restoring the original visitor's IP may be found
[here](https://support.cloudflare.com/hc/en-us/articles/200170786).

### [Other Headers](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#other-hdrs)

[Permalink: Other Headers](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#other-headers)

Other HTTP headers may be supported by AdGuard Home in the future. However, any
headers-related feature requests should first be tried to be resolved by
configuring the reverse proxy itself.

For example, to modify the [HTTP Strict Transport Security](https://datatracker.ietf.org/doc/html/rfc6797) mechanism to
include the experimental `preload` directive, something like the following piece
of configuration might be used:

```
location /dns-query {
   # …
   add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
   # …
}
```

## [Configure your devices](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#configure-devices)

[Permalink: Configure your devices](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#configure-your-devices)

### [Android](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#android)

[Permalink: Android](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#android)

- Android 9 supports `DNS-over-TLS` natively. To configure it, go to Settings
→ Network & internet → Advanced → Private DNS and enter your domain name
there.

- [AdGuard for Android](https://adguard.com/en/adguard-android/overview.html) supports `DNS-over-HTTPS`,
`DNS-over-TLS`, `DNSCrypt` and `DNS-over-QUIC`.

- [Intra](https://getintra.org/) adds `DNS-over-HTTPS` support to Android.


### [iOS](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#ios)

[Permalink: iOS](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#ios)

- iOS 14 and higher support `DNS-over-TLS` and `DNS-over-HTTPS` natively via
configuration profiles. In order to make things easier, AdGuard Home can
generate these configuration profiles for you. Just head to "Setup Guide" →
"DNS Privacy" and scroll to iOS.

- [AdGuard for iOS](https://adguard.com/en/adguard-ios/overview.html) supports `DNS-over-HTTPS`, `DNS-over-TLS`,
`DNSCrypt` and `DNS-over-QUIC`.

- [DNSCloak](https://itunes.apple.com/app/id1452162351) supports `DNS-over-HTTPS` but in order to configure it
to use your own server, you'll need to generate a [DNS Stamp](https://dnscrypt.info/stamps) for
it.


### [Windows](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#windows)

[Permalink: Windows](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#windows)

- Windows 10 Build 19628 and higher support `DNS-over-HTTPS` natively.

- [AdGuard for Windows](https://adguard.com/en/adguard-windows/overview.html) supports `DNS-over-HTTPS`,
`DNS-over-TLS`, `DNSCrypt` and `DNS-over-QUIC`.


### [MacOS](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#macos)

[Permalink: MacOS](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#macos)

- MacOS Big Sur and higher support `DNS-over-TLS` and `DNS-over-HTTPS`
natively via configuration profiles. In order to make things easier, AdGuard
Home can generate these configuration profiles for you. Just head to "Setup
Guide" → "DNS Privacy" and scroll to iOS.

### [Other implementations](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption\#other-imps)

[Permalink: Other implementations](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#other-implementations)

- AdGuard Home itself can be a secure DNS client on any platform.

- [dnsproxy](https://github.com/AdguardTeam/dnsproxy) supports all known secure DNS protocols.

- [dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy) supports `DNS-over-HTTPS`.

- [Mozilla Firefox](https://www.mozilla.org/firefox) supports `DNS-over-HTTPS`.


You can find more implementations [here](https://dnscrypt.info/implementations) and
[here](https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Clients).

## Guides

[Permalink: Guides](https://github.com/AdguardTeam/AdGuardHome/wiki/Encryption#guides)

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