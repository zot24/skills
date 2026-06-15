> Source: https://docs.gl-inet.com/router/en/4/interface_guide/dns


<a href="#dns" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="#manual-dns" class="md-nav__link"><span class="md-ellipsis"> Manual DNS </span></a>

<a href="#dns-proxy" class="md-nav__link"><span class="md-ellipsis"> DNS Proxy </span></a>

<a href="#edit-hosts" class="md-nav__link"><span class="md-ellipsis"> Edit Hosts </span></a>

<a href="../ethernet_port/" class="md-nav__link"><span class="md-ellipsis"> Ethernet Port </span></a>

<a href="../network_mode/" class="md-nav__link"><span class="md-ellipsis"> Network Mode </span></a>

<a href="../ipv6/" class="md-nav__link"><span class="md-ellipsis"> IPv6 </span></a>

<a href="../mac_address/" class="md-nav__link"><span class="md-ellipsis"> MAC Address </span></a>

<a href="../drop-in_gateway/" class="md-nav__link"><span class="md-ellipsis"> Drop-in Gateway </span></a>

<a href="../igmp_snooping/" class="md-nav__link"><span class="md-ellipsis"> IGMP Snooping </span></a>

<a href="../hardware_acceleration/" class="md-nav__link"><span class="md-ellipsis"> Hardware Acceleration </span></a>

<a href="../network_acceleration/" class="md-nav__link"><span class="md-ellipsis"> Network Acceleration </span></a>

<a href="../nat_settings/" class="md-nav__link"><span class="md-ellipsis"> NAT Settings </span></a>


<a href="../../video_library/" class="md-nav__link"><span class="md-ellipsis"> Video Library </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../community/" class="md-nav__link"><span class="md-ellipsis"> Community </span></a>


<a href="#manual-dns" class="md-nav__link"><span class="md-ellipsis"> Manual DNS </span></a>

<a href="#dns-proxy" class="md-nav__link"><span class="md-ellipsis"> DNS Proxy </span></a>

<a href="#edit-hosts" class="md-nav__link"><span class="md-ellipsis"> Edit Hosts </span></a>


# DNS<a href="#dns" class="headerlink" title="Permanent link">¶</a>

On the left side of the web Admin Panel, go to **NETWORK** -\> **DNS**.

The DNS settings on your router control how domain names are translated into IP addresses. This page lets you use the DNS server(s) automatically obtained from upstream devices, or set custom ones, and configure DNS priorities.

If you set custom DNS server(s), any DNS queries will be resolved through the specified one(s), instead of the DNS servers obtained through individual network interfaces. Otherwise, you will use the DNS settings configured for each interface.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/dns_page.png" class="glboxshadow" alt="dns" />

- **DNS Rebinding Attack Protection:** Turning on this option may cause private DNS lookup failure. If your network has a captive portal please disable this option.

- **Override DNS Settings for All Clients:** If enabled, your router will override unencrypted DNS settings for all clients.

- **Allow Custom DNS to Override VPN DNS:** If enabled, once you have set custom DNS, packets transmitted through the VPN tunnel will be resolved using the custom DNS override instead of the DNS server settings from the VPN connections.

## DNS Server Settings<a href="#dns-server-settings" class="headerlink" title="Permanent link">¶</a>

There are four modes: Automatic, Encrypted DNS, Manual DNS, and DNS Proxy.

### Automatic<a href="#automatic" class="headerlink" title="Permanent link">¶</a>

In this mode, the router will automatically use the DNS server provided by the upstream device (e.g., ISP modem, primary router), or the DNS settings corresponding to each network interface.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/dns_auto.png" class="glboxshadow" alt="automatic" />

### Encrypted DNS<a href="#encrypted-dns" class="headerlink" title="Permanent link">¶</a>

Please refer to the instructions below according to your firmware version.


For firmware v4.8 and earlier

Four encryption types are available: DNS over TLS, DNSCrypt-Proxy, DNS over HTTPS, and Oblivious DNS over HTTPS.

Please select the **Encryption Type** first. The remaining options will change according to your selection.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/encrypted_types.png" class="glboxshadow" alt="encrypted dns types" />

- **For DNS over TLS (DoT)**, please choose a DNS provider from **Control D**, **NextDNS**, and **Cloudflare**.

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/encrypted_tls.png" class="glboxshadow" alt="dns over tls" />

- **For the other three (i.e., DNSCrypt-Proxy, DNS over HTTPS, and Oblivious DNS over HTTPS)**, please select at least one DNS server from the repository.

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/dnscrypt-proxy.png" class="glboxshadow" alt="dnscrypt-proxy" />


For firmware v4.9 and later

In addition to Control D, NextDNS and Cloudflare, more DNS providers are now available for Encrypted DNS mode, including **Quad9**, **CleanBrowsing**, **AdGuard DNS**, **Google DNS**, and **OpenDNS**. You can also specify an encrypted DNS server manually as needed.

Select the **DNS Provider** first. The remaining options will change according to your selection.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/dns_providers.png" class="glboxshadow" alt="encrypted dns providers" />

- If you select a specific DNS provider (e.g., NextDNS), please choose an encryption type from **DNS over TLS (DoT)**, **DNS over HTTPS (DoH)**, and **DNS over QUIC (DoQ)**. Note that the DNS over QUIC (DoQ) was introduced in firmware v4.9 and is only available when using Control D, NextDNS, or AdGuard DNS as the DNS provider.

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/nextdns.png" class="glboxshadow" alt="nextdns" />

- If you select **Manual** as the DNS provider, please choose an encryption type from **DNS over TLS (DoT)**, **DNS over HTTPS (DoH)**, **DNS over QUIC (DoQ)**, **Oblivious DNS over HTTPS**, and **DNSCrypt**.

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/encrypted_manual1.png" class="glboxshadow" alt="encrypted manual1" />

  Next, click **Add a Server** to add at least one DNS server. You can directly enter the URL or stamp format of the encrypted DNS. For a list of public servers, please refer to <a href="https://dnscrypt.info/public-servers" target="_blank">https://dnscrypt.info/public-servers</a>.

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/encrypted_manual2.png" class="glboxshadow" alt="encrypted manual2" />


#### Encryption Type Comparison<a href="#encryption-type-comparison" class="headerlink" title="Permanent link">¶</a>

1.  **DNS over TLS (DoT)**

    Encrypts DNS queries via dedicated TLS port. It isolates DNS traffic from regular web traffic and is easy to identify by network operators.

2.  **DNS over HTTPS (DoH)**

    Transmits DNS data inside standard HTTPS traffic. It blends DNS requests with normal web traffic for strong privacy and bypasses simple traffic filtering.

3.  **DNS over QUIC (DoQ)**

    Encapsulates DNS over QUIC protocol. It features low latency, fast reconnection and stable performance on unstable networks.

4.  **Oblivious DNS over HTTPS (ODoH)**

    An enhanced version of DoH. It separates user IP from DNS queries, preventing both server and network providers from tracking your browsing activity.

5.  **DNSCrypt**

    A mature encryption protocol for DNS. It authenticates and encrypts DNS traffic, focusing on anti-tampering and compatibility with legacy network environments.

### Manual DNS<a href="#manual-dns" class="headerlink" title="Permanent link">¶</a>

In this mode, you can customize your router's DNS server. Select at least one DNS Server for your router from the drop-down list.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/manual_dns.png" class="glboxshadow" alt="manual dns" />

### DNS Proxy<a href="#dns-proxy" class="headerlink" title="Permanent link">¶</a>

In this mode, the router will route all LAN DNS queries to the proxy server address you specify (e.g., 8.8.8.8#53). This might be useful if you are running another DNS server or Pi-hole on your network.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/dns_proxy.png" class="glboxshadow" alt="dns proxy" />

## Edit Hosts<a href="#edit-hosts" class="headerlink" title="Permanent link">¶</a>

You can click the **Edit Hosts** button at the top right to customize static host rules.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/edit_hosts1.png" class="glboxshadow" alt="edit hosts1" />

The router prioritizes these host rules when resolving requests from connected clients.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/edit_hosts2.png" class="glboxshadow" alt="edit hosts2" />

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a> or <a href="https://www.gl-inet.com/contacts/" target="_blank">Contact us</a>.


Back to top


