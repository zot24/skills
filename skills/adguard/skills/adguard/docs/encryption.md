> Source: https://raw.githubusercontent.com/wiki/AdguardTeam/AdGuardHome/Encryption.md

 #  AdGuard Home – Encryption

 >  [!WARNING]
 >  This article is outdated.  See the [up-to-date version][kb-article] in our Knowledge Base.

[kb-article]: https://adguard-dns.io/kb/adguard-home/encryption/

We are proud to say that AdGuard Home supports all modern DNS encryption
protocols **out-of-the-box**:

 *  [DNS-over-HTTPS](https://en.wikipedia.org/wiki/DNS_over_HTTPS)
 *  [DNS-over-TLS](https://en.wikipedia.org/wiki/DNS_over_TLS)
 *  [DNS-over-QUIC](https://datatracker.ietf.org/doc/html/rfc9250)

 >  AdGuard Home also supports [DNSCrypt](https://dnscrypt.info/) (both
 >  client-side and server-side).  [Read this](DNSCrypt) to learn about
 >  configuring AdGuard Home as a DNSCrypt server.

In this guide we will explain how to setup your own "Secure DNS" server with
AdGuard Home.

1.  [Install AdGuard Home on your server](#install)
1.  [Register a domain name](#register)
1.  [Get an SSL certificate](#certificate)
     *  [Using CertBot](#certbot)
         *  [Get a certificate using DNS challenge](#certbot-dnschallenge)
     *  [Using Lego](#lego)
1.  [Configure AdGuard Home](#configure-home)
1.  [Using with reverse proxy](#reverse-proxy)
     *  [Nginx](#nginx)
     *  [Cloudflare CDN](#cf-cdn)
     *  [Other Headers](#other-hdrs)
1.  [Configure your devices](#configure-devices)
     *  [Android](#android)
     *  [iOS](#ios)
     *  [Windows](#windows)
     *  [MacOS](#macos)
     *  [Other implementations](#other-imps)



##  <a href="#install" id="install" name="install">Install AdGuard Home on your server</a>

It does not make much sense to configure DNS encryption inside of your own local
network.  The purpose of securing your DNS traffic is to secure it from
third-parties that might be analyzing or modifying it.  For instance, from your
ISP.

It means that you will need a server with a public dedicated IP address.  There
are plenty of cheap cloud servers providers: [DigitalOcean][digital-ocean],
[Vultr][vultr], [Linode][linode], etc.  Just choose one, create a cloud server
there, and [install AdGuard Home](Getting-Started) on your server.



[digital-ocean]: https://digitalocean.com
[vultr]:         https://vultr.com
[linode]:        https://www.linode.com



##  <a href="#register" id="register" name="register">Register a domain name</a>

First of all, you need a domain name.  If you have never registered one, here is
a [simple instruction][domain-name-register] that will help you with that.



[domain-name-register]: https://www.pcworld.com/article/241722/web-apps/how-to-register-your-own-domain-name.html



##  <a href="#certificate" id="certificate" name="certificate">Get an SSL certificate</a>

Both `DNS-over-HTTPS` and `DNS-over-TLS` are based on [TLS
encryption][tls-wikipedia] so in order to use them, you will need to acquire an
SSL certificate.

An SSL certificate can be bought from a "Certificate Authority" (CA), a company
trusted by browsers and operating systems to enroll SSL certificates for
domains.

Alternatively, you can get the certificate for free from ["Let's Encrypt"
CA][letsencrypt], a free certificate authority developed by the Internet
Security Research Group (ISRG).

In this guide I'll explain how to get a certificate from them.

   ###  <a href="#certbot" id="certbot" name="certbot">Using CertBot</a>

Certbot is an easy-to-use client that fetches a certificate from Let’s Encrypt.

1.  Go to [certbot.eff.org][certbot] and choose "None of the above"
    software and your operating system.
1.  Follow the installation instructions, and stop there – don't get to the "Get
    Started" section.

  ####  <a href="#certbot-dnschallenge" id="certbot-dnschallenge" name="certbot-dnschallenge">Get a certificate using DNS challenge</a>

You have just got a domain name so I suppose using DNS challenge will be the
easiest way to get a certificate.

Run this command and follow the certbot's instructions:

```sh
sudo certbot certonly --manual --preferred-challenges=dns --preferred-chain="ISRG Root X1"
```

In the end you'll get two files:

 *  `fullchain.pem` – your PEM-encoded SSL certificate.
 
 *  `privkey.pem` – your PEM-encoded private key.

Both will be necessary to configure AdGuard Home.

 >  You will need to use the very same procedure to renew the existing
 >  certificate.

   ###  <a href="#lego" id="lego" name="lego">Using Lego</a>

There's also a really nice and easy-to-use alternative to CertBot called
[lego][lego-source].

1.  Install it using [an appropriate method][lego-install].
1.  Choose your DNS provider from [the list][lego-provider]
    and follow the instruction to obtain a certificate.

Also, here's [a simple script][legoagh] that you can use to automate
certificates generation and renewal.

[tls-wikipedia]: https://en.wikipedia.org/wiki/Transport_Layer_Security
[letsencrypt]:   https://letsencrypt.org
[certbot]:       https://certbot.eff.org
[lego-source]:   https://go-acme.github.io/lego
[lego-install]:  https://go-acme.github.io/lego/installation
[lego-provider]: https://go-acme.github.io/lego/dns
[legoagh]:       https://github.com/ameshkov/legoagh



##  <a href="#configure-home" id="configure-home" name="configure-home">Configure AdGuard Home</a>

1.  Open AdGuard Home web interface and go to settings.
1.  Scroll down to the "Encryption" settings.
 
![][encryption-screenshot]
 
3.  Copy/paste the contents of the `fullchain.pem` file to "Certificates".
3.  Copy/paste the contents of the `privkey.pem` file to "Private key".
3.  Enter your domain name to "Server name".
3.  Click "Save settings".



[encryption-screenshot]: https://user-images.githubusercontent.com/5947035/53301027-2a0c2b80-385f-11e9-81f3-bcc63de4eef1.png



##  <a href="#reverse-proxy" id="reverse-proxy" name="reverse-proxy">Using with reverse proxy</a>

We already have a [guide][reverse-proxy-faq] on configuring a reverse proxy
server for accessing AdGuard Home web UI.

Since v0.107.0 AdGuard Home is able to restrict DNS-over-HTTPS requests which
came from the proxy server not included into "trusted" list.  By default, it's
configured to accept requests from IPv4 and IPv6 loopback addresses.

To enable AdGuard Home to handle DNS-over-HTTPS requests from a reverse proxy
server, set the `trusted_proxies` setting in `AdGuardHome.yaml` to the IP
address of the proxy server.  If you have several proxy servers, you can use a
CIDR instead of a simple IP address.

   ###  <a href="#nginx" id="nginx" name="nginx">Nginx reverse proxy</a>

To configure AdGuard Home for accepting requests from Nginx reverse proxy
server, make sure that the reverse proxy server itself is configured correctly.

The `nginx.conf` file should contain the appropriate directives to add the
supported forwarding headers to the request which are `X-Real-IP` or
`X-Forwarded-For`.  This may be achieved with `ngx_http_realip_module` which is
explained [here][ngx-http-realip-module].  In short, the module takes real IP
address of the client and writes it to the HTTP request's header.  The AdGuard
Home will receive and interpret the value of this header as real client's
address.  The address of the reverse proxy server will be received too and also
checked against the "trusted" proxies list.

Another header you might want to proxy is the `Host` header, which is required
to make AdGuard Home recognize requests from clients that have a ClientID in
their hostnames.

For example, if the configuration of the reverse proxy server contains the
following directives:

```nginx
location /dns-query {
   # …
   proxy_set_header Host $host;
   proxy_set_header X-Real-IP '1.2.3.4';
   proxy_bind 192.168.1.2;
   # …
}
```

AdGuard Home will get the `192.168.1.2` as the address of your proxy server and
check it against the `trusted_proxies`.  The `1.2.3.4` will be controlled by
access settings in case the proxy is "trusted".

   ###  <a href="#cf-cdn" id="cf-cdn" name="cf-cdn">Cloudflare CDN</a>

The Cloudflare's content delivery network acts as the reverse proxy appending
its [own headers][cloudflare-headers] to the forwarded requests, which are
`CF-Connecting-IP` and `True-Client-IP`.  These are also supported by AdGuard
Home so the reverse proxy servers' [addresses][cloudflare-addresses] may be
inserted into `trusted_proxies` list directly.  An official Cloudflare's
reference on restoring the original visitor's IP may be found
[here][cloudflare-real-ip].

   ###  <a href="#other-hdrs" id="other-hdrs" name="other-hdrs">Other Headers</a>

Other HTTP headers may be supported by AdGuard Home in the future.  However, any
headers-related feature requests should first be tried to be resolved by
configuring the reverse proxy itself.

For example, to modify the [HTTP Strict Transport Security][hsts] mechanism to
include the experimental `preload` directive, something like the following piece
of configuration might be used:

```nginx
location /dns-query {
   # …
   add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
   # …
}
```



[reverse-proxy-faq]:      https://github.com/AdguardTeam/AdGuardHome/wiki/FAQ#how-to-configure-a-reverse-proxy-server-for-adguard-home
[ngx-http-realip-module]: https://nginx.org/en/docs/http/ngx_http_realip_module.html
[cloudflare-headers]:     https://support.cloudflare.com/hc/en-us/articles/200170986
[cloudflare-addresses]:   https://www.cloudflare.com/ips
[cloudflare-real-ip]:     https://support.cloudflare.com/hc/en-us/articles/200170786
[hsts]:                   https://datatracker.ietf.org/doc/html/rfc6797



##  <a href="#configure-devices" id="configure-devices" name="configure-devices">Configure your devices</a>

   ###  <a href="#android" id="android" name="android">Android</a>

 *  Android 9 supports `DNS-over-TLS` natively. To configure it, go to Settings
    → Network & internet → Advanced → Private DNS and enter your domain name
    there.
    
 *  [AdGuard for Android][ag-for-android] supports `DNS-over-HTTPS`,
    `DNS-over-TLS`, `DNSCrypt` and `DNS-over-QUIC`.

 *  [Intra][intra] adds `DNS-over-HTTPS` support to Android.

   ###  <a href="#ios" id="ios" name="ios">iOS</a>

 *  iOS 14 and higher support `DNS-over-TLS` and `DNS-over-HTTPS` natively via
    configuration profiles. In order to make things easier, AdGuard Home can
    generate these configuration profiles for you.  Just head to "Setup Guide" →
    "DNS Privacy" and scroll to iOS.

 *  [AdGuard for iOS][ag-for-ios] supports `DNS-over-HTTPS`, `DNS-over-TLS`,
    `DNSCrypt` and `DNS-over-QUIC`.

 *  [DNSCloak][dnscloak] supports `DNS-over-HTTPS` but in order to configure it
    to use your own server, you'll need to generate a [DNS Stamp][stamps] for
    it.

   ###  <a href="#windows" id="windows" name="windows">Windows</a>

 *  Windows 10 Build 19628 and higher support `DNS-over-HTTPS` natively.

 *  [AdGuard for Windows][ag-for-windows] supports `DNS-over-HTTPS`,
    `DNS-over-TLS`, `DNSCrypt` and `DNS-over-QUIC`.

   ###  <a href="#macos" id="macos" name="macos">MacOS</a>

 *  MacOS Big Sur and higher support `DNS-over-TLS` and `DNS-over-HTTPS`
    natively via configuration profiles. In order to make things easier, AdGuard
    Home can generate these configuration profiles for you. Just head to "Setup
    Guide" → "DNS Privacy" and scroll to iOS.

   ###  <a href="#other-imps" id="other-imps" name="other-imps">Other implementations</a>

 *  AdGuard Home itself can be a secure DNS client on any platform.

 *  [dnsproxy][ag-dnsproxy] supports all known secure DNS protocols.

 *  [dnscrypt-proxy][dnscrypt-proxy] supports `DNS-over-HTTPS`.

 *  [Mozilla Firefox][firefox] supports `DNS-over-HTTPS`.

You can find more implementations [here][dnscrypt-imps1] and
[here][dnscrypt-imps2].



[ag-for-android]: https://adguard.com/en/adguard-android/overview.html
[intra]:          https://getintra.org
[ag-for-ios]:     https://adguard.com/en/adguard-ios/overview.html
[dnscloak]:       https://itunes.apple.com/app/id1452162351
[stamps]:         https://dnscrypt.info/stamps
[ag-for-windows]: https://adguard.com/en/adguard-windows/overview.html
[ag-dnsproxy]:    https://github.com/AdguardTeam/dnsproxy
[dnscrypt-proxy]: https://github.com/jedisct1/dnscrypt-proxy
[firefox]:        https://www.mozilla.org/firefox
[dnscrypt-imps1]: https://dnscrypt.info/implementations
[dnscrypt-imps2]: https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Clients
