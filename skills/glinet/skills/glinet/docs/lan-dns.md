> Source: https://docs.gl-inet.com/router/en/4/interface_guide/dns


<a href="#dns" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="#edit-hosts" class="md-nav__link">Edit Hosts</a>

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


<a href="#edit-hosts" class="md-nav__link">Edit Hosts</a>


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

In this mode, four encryption type are available:

- DNS over TLS
- DNSCrypt-Proxy
- DNS over HTTPS
- Oblivious DNS over HTTPS

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/encrypted_types.png" class="glboxshadow" alt="encrypted dns types" />

For DNS over TLS, select a DNS provider among Control D, NextDNS, and Cloudflare.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/encrypted_tls.png" class="glboxshadow" alt="dns over tls" />

For the other three (i.e., DNSCrypt-Proxy, DNS over HTTPS, and Oblivious DNS over HTTPS), select at least one DNS Server from the repository.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/dnscrypt-proxy.png" class="glboxshadow" alt="dnscrypt-proxy" />

### Manual DNS<a href="#manual-dns" class="headerlink" title="Permanent link">¶</a>

In this mode, you can customize your router's DNS server. Select at least one DNS Server for your router from the drop-down list.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/manual_dns.png" class="glboxshadow" alt="manual dns" />

### DNS Proxy<a href="#dns-proxy" class="headerlink" title="Permanent link">¶</a>

In this mode, the router will route all LAN DNS queries to the proxy server address you specify (e.g., 8.8.8.8#53). This might be useful if you are running another DNS server or Pi-hole on your network.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/dns_proxy.png" class="glboxshadow" alt="dns proxy" />

## Edit Hosts<a href="#edit-hosts" class="headerlink" title="Permanent link">¶</a>

Requests from clients will be resolved preferentially using the static DNS rules you write in Hosts.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/dns/edit_hosts.png" class="glboxshadow" alt="hosts" />

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a> or <a href="https://www.gl-inet.com/contacts/" target="_blank">Contact us</a>.


Back to top


