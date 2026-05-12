> Source: https://docs.gl-inet.com/router/en/4/interface_guide/network_mode


<a href="#network-mode" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../ipv6/" class="md-nav__link"><span class="md-ellipsis"> IPv6 </span></a>

<a href="../mac_address/" class="md-nav__link"><span class="md-ellipsis"> MAC Address </span></a>

<a href="../drop-in_gateway/" class="md-nav__link"><span class="md-ellipsis"> Drop-in Gateway </span></a>

<a href="../igmp_snooping/" class="md-nav__link"><span class="md-ellipsis"> IGMP Snooping </span></a>

<a href="../hardware_acceleration/" class="md-nav__link"><span class="md-ellipsis"> Hardware Acceleration </span></a>

<a href="../network_acceleration/" class="md-nav__link"><span class="md-ellipsis"> Network Acceleration </span></a>

<a href="../nat_settings/" class="md-nav__link"><span class="md-ellipsis"> NAT Settings </span></a>


<a href="../../video_library/" class="md-nav__link"><span class="md-ellipsis"> Video Library </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../community/" class="md-nav__link"><span class="md-ellipsis"> Community </span></a>


# Network Mode<a href="#network-mode" class="headerlink" title="Permanent link">¶</a>

On the left side of the web Admin Panel, go to **NETWORK** -\> **Network Mode**.

Network mode refers to the various operational roles and functions that a router can assume to meet different network deployment needs. These modes are tailored to scenarios ranging from home Wi-Fi coverage to enterprise-level multi-link networking, with each mode disabling or enabling specific router features to optimize performance.


Note

1.  When you change the router's network mode, you may need to reconnect all client devices.

2.  **When your router is in Access Point / WDS / Bridge mode, you will not be able to access the web admin panel using the original LAN IP address.** Instead, you need to log in to the upstream router to find the IP address it has assigned to this router, then use this IP address to access the web admin panel. If you do not have access to the upstream router, press and hold the reset button for 4 seconds to revert it to the default Router mode.

3.  **In Non-Router mode, the following features will be unavailable**: Access Control (Allowlist and Blocklist), AstroWarp, VPN, AdGuard Home, Parental Control, ZeroTier, Tailscale, Port Forwarding, Multi-WAN, DHCP Server, Address Reservation, Guest Network, DNS, Port Management, IPv6, Drop-in Gateway, IGMP Snooping, Network Acceleration, NAT Settings.


## For models with Wi-Fi<a href="#for-models-with-wi-fi" class="headerlink" title="Permanent link">¶</a>

Except for specific models, most GL.iNet wireless routers have Wi-Fi functionality.

Models with Wi-Fi functionality usually support four network modes: Router, Access Point, Extender, and WDS modes. Note that some models do not support WDS mode.

<img src="https://static.gl-inet.com/docs/router/en/4/tutorials/network_mode/network_mode_page.png" class="glboxshadow" alt="network mode" />

- **Router**: This is the default operational mode for most home and small office routers, designed to create a private local area network and act as a dedicated gateway between the public internet and connected devices.

  In Router Mode, the device enables core functions including NAT, DHCP, and a built-in firewall. It connects to an upstream line such as broadband fiber, automatically assigns private IP addresses to connected devices, and provides network security for the entire private network.

  ------------------------------------------------------------------------

- **Access Point**: This mode enables a router to connect to a wired network via a LAN cable and broadcast wireless signals, expanding Wi-Fi coverage in large spaces to allow more devices to access the network.

  In Access Point mode, the router disables its NAT and DHCP functions, operating purely as a wireless signal transmitter and switch rather than a standalone gateway.

  After switching to Access Point mode, you will not be able to access the web admin panel using the original LAN IP address. Instead, you need to log in to the upstream router to find the IP address it has assigned to this AP, then use this IP address to access the web admin panel. If you do not have access to the upstream router, press and hold the reset button for 4 seconds to revert it to the default Router mode.

  ------------------------------------------------------------------------

- **Extender**: This mode is designed to extend the Wi-Fi coverage of an existing wireless network and eliminate signal dead zones in areas with poor connectivity.

  It enables the router to wirelessly receive signals from the main router, amplify them, and retransmit the boosted signal. Unlike Access Point mode, it requires no wired connection to the main router, but it may lead to bandwidth halving, as the device has to handle simultaneous signal reception and transmission.

  In Extender mode, you will still be able to access the web admin panel using its original LAN IP address.

  ------------------------------------------------------------------------

- **WDS**: Wireless Distribution System (WDS) mode is similar to Extender mode as it extends Wi-Fi coverage wirelessly, but it supports wireless bridging between multiple compatible routers. It is recommended for wireless network expansion when the upstream router has WDS functionality.

  This mode is ideal for scenarios like covering multi-story buildings or small office campuses where multiple routers need to work together to form a unified wireless network. Unlike Extender mode, which only transmits signals from one main router to a single extender, WDS mode allows interconnected routers to both send and receive signals, enabling seamless coverage across larger areas with multiple signal nodes.

  After switching to WDS mode, you will not be able to access the web admin panel using the original LAN IP address. Instead, you need to log in to the upstream router to find the IP address it has assigned to this WDS router, then use this IP address to access the web admin panel. If you do not have access to the upstream router, press and hold the reset button for 4 seconds to revert it to the default Router mode.

## For models without Wi-Fi<a href="#for-models-without-wi-fi" class="headerlink" title="Permanent link">¶</a>

GL-MT2500/GL-MT2500A does not support Access Point, Extender, or WDS modes, as it lacks Wi-Fi functionality. But it supports Router mode and Bridge mode.

<img src="https://static.gl-inet.com/docs/router/en/4/tutorials/network_mode/network_mode_page_mt2500.png" class="glboxshadow" alt="network mode of gl-mt2500" />

- **Router**: This is the default operational mode for most home and small office routers, designed to create a private local area network (LAN) and act as a dedicated gateway between the public internet and connected devices.

  In Router Mode, the device enables core functions including NAT, DHCP, and a built-in firewall. It connects to an upstream line such as broadband fiber, automatically assigns private IP addresses to connected devices, and provides network security for the entire private network.

  ------------------------------------------------------------------------

- **Bridge**: Allows the router to connect to a wired network and function as a bridge between network devices.

  In this mode, the router essentially operates as a switch, forwarding data between connected devices without performing NAT, firewall, or DHCP services. This enables seamless communication between devices on the same network by acting as a simple connection point rather than a network gateway.

  After switching to Bridge mode, you will not be able to access the web admin panel using the original LAN IP address. Instead, you need to log in to the upstream router to find the IP address it has assigned to this Bridge router, then use this IP address to access the web admin panel. If you do not have access to the upstream router, press and hold the reset button for 4 seconds to revert it to the default Router mode.

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a> or <a href="https://www.gl-inet.com/contacts/" target="_blank">Contact us</a>.


Back to top


