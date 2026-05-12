> Source: https://docs.gl-inet.com/router/en/4/interface_guide/multi-wan


<a href="#multi-wan" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="#multi-wan-method" class="md-nav__link">Multi-WAN Method</a>

<a href="#usage-scenarios" class="md-nav__link">Usage Scenarios</a>

<a href="../lan/" class="md-nav__link"><span class="md-ellipsis"> LAN </span></a>

<a href="../guest_network/" class="md-nav__link"><span class="md-ellipsis"> Guest Network </span></a>

<a href="../dns/" class="md-nav__link"><span class="md-ellipsis"> DNS </span></a>

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


<a href="#multi-wan-method" class="md-nav__link">Multi-WAN Method</a>

<a href="#usage-scenarios" class="md-nav__link">Usage Scenarios</a>


# Multi-WAN<a href="#multi-wan" class="headerlink" title="Permanent link">¶</a>


# An error occurred.


Unable to execute JavaScript.


On the left side of the web Admin Panel, go to **NETWORK** -\> **Multi-WAN**.

You can configure the router with multiple Internet access methods, so that when one type of Internet access is not available, it can automatically switch to another type of Internet access in a short time. Or use multiple Internet access methods at the same time, assigning the network connection to different connection methods in a certain ratio.

GL.iNet routers can be connected to the Internet in multiple ways, such as [Ethernet](../internet_ethernet/), [Repeater](../internet_repeater/), [Tethering](../internet_tethering/), [Cellular](../internet_cellular/).


Note

1.  Models lacking Wi-Fi functionality (e.g., GL-MT2500/GL-MT2500A) only support Ethernet, Tethering, and Cellular network access.

2.  Models lacking USB port (e.g., GL-B3000) only support Ethernet and Repeater network access.

3.  Some models support [Dual-Ethernet WAN](../dual-ethernet_wan/), which will have an additional Ethernet interface on the user interface.


## Interface Status Track<a href="#interface-status-track" class="headerlink" title="Permanent link">¶</a>

GL.iNet routers support up to 5 virtual network interfaces, though the exact number may vary by model. For example, GL-MT6000 has **Ethernet 1**, **Ethernet 2**, **Repeater**, **Tethering** and **Cellular**, each serving distinct network functions in software-defined configurations.

The routers use **ping** or **httping** (only for v4.3 and earlier) command to track the status of the connection to the destination IP, to determine if the interface is available.

If the interface is available, a green dot will be displayed on the left side, otherwise it is gray.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/multi-wan/interface_status_track_1.jpg" class="glboxshadow" alt="interface status track 1" />

### Status Track Settings<a href="#status-track-settings" class="headerlink" title="Permanent link">¶</a>

Click the cog icon to access the status track settings of each network interface.

For example, this is the status tracking setting for Ethernet interface, and the same applies to other interfaces.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/multi-wan/interface_status_track_2.png" class="glboxshadow" alt="interface status track 2" />

- **Enable Interface Status Track**: It is enabled by default. You can disable the interface status tracking, as a result the router will determine the interface status by the physical status (such as whether the network cable is plugged in or not).

- **Detection Mode**: This feature was introduced as Low Data Mode in v4.5 and renamed Detection Mode in v4.7. Three modes are available: Normal Mode, Low Data Mode, and Strict Mode.

  Normal mode is used by default, low data mode traces only when an interface network error occurs, and strict mode determines the interface status only based on the results of a detect command from a public ip.

  You can use Low Data Mode when you are on a limited data plan. However, one drawback is that reconnecting after a network disconnection may be slightly slower compared to the normal mode, and only the cellular interface will be turned on by default.

- **Track Command**: ping command is used to track the status of the connection to the destination IP, to determine if the interface is available. For firmware v4.3 and earlier, there is also httping command available.

- **IPv4 Track IP**: You can customize the IPv4 Track IP here.


Note

Some old firmware, such as v4.3, provide settings such as **Track Interval**, **Change to Failure Condition** and **Change to Available Condition**. These settings have been removed since v4.5 and replaced with Detection Mode and Sensitivity Options.


### Sensitivity Options<a href="#sensitivity-options" class="headerlink" title="Permanent link">¶</a>

This feature is available since v4.5.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/multi-wan/sensitivity_options.jpg" class="glboxshadow" alt="Sensitivity Options" />

This sensitivity determines the time interval for Internet status detection.

- If the network is stable and in scenarios such as watching videos or live streams, playing games, users are recommended to use high sensitivity for quick switching in case of network disconnection.
- If the network is unstable and downloading cached files, users are recommended to use low sensitivity to prevent constant network switching and discovering unsuccessful connections.

**Tips**: Switching to high sensitivity may lead to network disconnection, please adjust it with caution.

## Multi-WAN Method<a href="#multi-wan-method" class="headerlink" title="Permanent link">¶</a>

There are two methods: **Failover** and **Load Balance**. Failover is enabled by default when there are multi-wan connections.

**Failover** and **Load Balance** are mutually exclusive and you can only use one of them.

### Failover<a href="#failover" class="headerlink" title="Permanent link">¶</a>

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/multi-wan/failover.png" class="glboxshadow" alt="multi-wan failover" />

You can set the priority of each interface, when the interface being used fails, the router will automatically switch to another available highest priority interface.

For example, if the router has been set up with two types of Internet access, **Ethernet** and **Repeater**, and the priority of of Ethernet is 1, the priority of Repeater is 2, the priority of Ethernet is higher than Repeater, so the router will use the Ethernet to access Internet. If you unpluged the ethernet cable, the Ethernet interface will become unavailable, then the router will automatically switch to Repeater interface to access Internet.

Once the Ethernet connection is restored, the router will automatically switch back to the Ethernet to access Internet as it has higher priority.

### Load Balance<a href="#load-balance" class="headerlink" title="Permanent link">¶</a>

Use multiple network interfaces at the same time to increase the total bandwidth of the router.

The load ratio here is the ratio between each network interface, and the system will assign interfaces to deal with new connections based on the set load ratio.

For example, if the router is connected to four networks (Ethernet, Repeater, Tethering and Cellular) at the same time, and all four network interfaces are available to access the Internet, then enabling Load Balance and setting 1:1:1:1 means that the four network interfaces will load the network bandwidth averagely, as the system will assign these four interfaces to new connections based on the set load ratio 1:1:1:1.

You can also customize the load ratio. If the Ethernet bandwidth is 200 Mbps, the Repeater Wi-Fi bandwidth is 100 Mbps, and no Tethering or Cellular connections are active, you can set the load ratios to 2 for Ethernet, 1 for Repeater, and 0 for Tethering/Cellular. The system will then distribute new connections between these interfaces based on the configured ratio of 2:1, meaning the Ethernet interface will handle approximately twice as many connections as the Repeater interface. Compared with the Failover mode, this optimizes the overall throughput efficiency by balancing the load across available interface.

**Note:** Alive connections or traffic are not ensured to match the load ratio. It is closer to this ratio if it has been used for a longer time.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/multi-wan/load_balance.png" class="glboxshadow" alt="multi-wan load balance" />

## Usage Scenarios<a href="#usage-scenarios" class="headerlink" title="Permanent link">¶</a>

- The store's cashier system uses a wired connection to the Internet, while Repeater to Wi-Fi in neighboring stores (or inserting a SIM card to enable cellular network) as a backup Internet access method to prevent mobile payments from being made when the network cable is unavailable.

- Router Repeater to public Wi-Fi, but the network speed is not fast enough, then you can use Mobile Tethering to do load balance at the same time to improve the overall bandwidth.

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a> or <a href="https://www.gl-inet.com/contacts/" target="_blank">Contact us</a>.


Back to top


