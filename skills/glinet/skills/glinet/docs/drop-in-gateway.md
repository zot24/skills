> Source: https://docs.gl-inet.com/router/en/4/interface_guide/drop-in_gateway


<a href="#drop-in-gateway" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="#cautions" class="md-nav__link">Cautions</a>

<a href="../igmp_snooping/" class="md-nav__link"><span class="md-ellipsis"> IGMP Snooping </span></a>

<a href="../hardware_acceleration/" class="md-nav__link"><span class="md-ellipsis"> Hardware Acceleration </span></a>

<a href="../network_acceleration/" class="md-nav__link"><span class="md-ellipsis"> Network Acceleration </span></a>

<a href="../nat_settings/" class="md-nav__link"><span class="md-ellipsis"> NAT Settings </span></a>


<a href="../../video_library/" class="md-nav__link"><span class="md-ellipsis"> Video Library </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../community/" class="md-nav__link"><span class="md-ellipsis"> Community </span></a>


<a href="#cautions" class="md-nav__link">Cautions</a>


# Drop-in Gateway<a href="#drop-in-gateway" class="headerlink" title="Permanent link">¶</a>

On the left side of the web Admin Panel, go to **NETWORK** -\> **Drop-in Gateway**.

Drop-in Gateway is an extension function that enables capability expansion for an existing primary router without replacing or reconfiguring it. By connecting the GL.iNet router to the primary router via an Ethernet cable, users can add advanced network features onto the existing network infrastructure, for example:

- Filter advertisements via AdGuard Home
- Enable VPN client
- Use encrypted DNS

It is recommended to use a higher-performance router or security gateway with ample memory (e.g., GL-MT2500, GL-MT5000) and install additional traffic forwarding and control tools as required.

## Network Topology<a href="#network-topology" class="headerlink" title="Permanent link">¶</a>

Drop-in Gateway operates as an intermediate network system, routing data traffic from client devices through the GL.iNet router for processing before transmitting it via the primary router. During this process, it not only preserves existing network settings (e.g., SSID and password) to ensure uninterrupted connectivity for all connected devices, but also allows you to manage network traffic for all or specific client devices as needed.

<img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/drop-in_gateway_mode_topology.svg" class="glboxshadow gl-60-desktop" alt="drop-in gateway mode typology" />

The diagram above consists of two types of lines: gray lines, and green lines marked with three arrows, each labeled with a corresponding number.

1.  **Gray lines** illustrate the physical connection topology: client devices (e.g., computer, laptop) connect to the primary router, and the primary router's LAN port links to the WAN port of the GL.iNet router (with Drop-in Gateway enabled) via an Ethernet cable.

2.  **Green lines** depict the sequential data transmission path when Drop-in Gateway is active, with the numbered arrows indicating the traffic flow order:

    1.  Traffic from client devices is first routed to the primary router;

    2.  The primary router forwards the traffic to the GL.iNet router for processing (e.g., ad filtering, VPN encryption);

    3.  After processing, the traffic is sent back to the primary router, which then either delivers the final data to the original client devices or routes it out to the Internet.

## Setup<a href="#setup" class="headerlink" title="Permanent link">¶</a>

There are two deployment modes for different application scenarios: All client devices are networked through Drop-in Gateway, or only specific client devices are networked through Drop-in Gateway.

In the following example, the gateway address of the primary router is `192.168.1.1`.

### All devices are networked through Drop-in Gateway<a href="#all-devices-are-networked-through-drop-in-gateway" class="headerlink" title="Permanent link">¶</a>

1.  Connect the LAN port of the primary router to the WAN port of the GL.iNet router via an ethernet cable.

2.  Log in to the web admin panel of your GL.iNet router, enable Drop-in Gateway, and the system will automatically generate the corresponding configuration parameters.

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/drop-in_gateway_all_device_enabled.png" class="glboxshadow" alt="drop-in gateway generated settings" />

    - The **IP Address** refers to the WAN IP address of your GL.iNet router, which is dynamically assigned by the primary router. This WAN IP can be viewed in the Ethernet section of the [INTERNET](../internet_ethernet/) page.

    - The **Gateway** and **DNS Server 1** fields are automatically filled with the IP address of the primary router by default. If these parameters are incorrectly configured, you can manually adjust them as needed.

    Write down the IP address here, as you will use it in the following steps.

    Select the first configuration method and click **Apply**.

3.  Log in to the web admin panel of your primary router.

    GL.iNet

    If your primary router is GL.iNet and it runs firmware v4.2 and above, follow the steps below.

    Log in to the web Admin Panel -\> NETWORK -\> LAN -\> DHCP Server -\> Advanced

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/glinet/lan_advanced.png" class="glboxshadow" alt="glinet lan advanced" />

    Fill in the DHCP Gateway as the IP Address in step 2, etc, `192.168.1.23`, then click **Apply**.

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/glinet/tips_dhcp_gateway.png" class="glboxshadow" alt="glinet lan, dhcp gateway" />

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/glinet/lan_dhcp_gateway.png" class="glboxshadow" alt="glinet lan, dhcp gateway" />

    TP-Link

    If your primary router is TP-Link, follow the steps below (Taking TP-LINK Archer C3150 as an example).

    Log in to the TP-Link admin page, navigate to **Advanced** -\> **Network** -\> **DHCP Server**, then disable the **DHCP**.

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/tplink/tplink_disable_dhcp_1.png" class="glboxshadow" alt="tplink admin, disable dhcp" />

    Then click **Save**.

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/tplink/tplink_disable_dhcp_2.png" class="glboxshadow" alt="tplink admin, disable dhcp" />

    Linksys

    If your primary router is Linksys, follow the steps below (Taking Linksys WHW01 as an example)

    Log in to the Linksys admin page, navigate to **Router Settings** -\> **Connectivity**.

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/linksys/linksys_connectivity.png" class="glboxshadow" alt="linksys admin, connectivity" />

    Click the tab **Local Network**, disable the **DHCP Server**, then click **OK**.

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/linksys/linksys_disable_dhcp.png" class="glboxshadow" alt="linksys admin, local network, disable dhcp" />

    It will show a warning. Click **OK**.

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/linksys/linksys_apply_changes.png" class="glboxshadow" alt="linksys admin, apply changes" />

    Others

    Please log in to the primary router's admin panel to disable its DHCP server. You may refer to the corresponding manufacturer's user manual, or consult their support.

4.  Go back to the GL.iNet router and set up features like [AdGuard Home](../adguardhome/), [encrypted DNS](../dns/), [WireGuard Client](../wireguard_client/) and [OpenVPN Client](../openvpn_client/).

### Specific devices are networked through Drop-in Gateway<a href="#specific-devices-are-networked-through-drop-in-gateway" class="headerlink" title="Permanent link">¶</a>

1.  Connect the LAN port of the primary router to the WAN port of the GL.iNet router via an ethernet cable.

2.  Log in to the web admin panel of your GL.iNet router, enable Drop-in Gateway, and the system will automatically generate the corresponding configuration parameters.

    <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/drop-in_gateway_some_device_enabled.png" class="glboxshadow" alt="drop-in gateway generated settings" />

    - The **IP Address** refers to the WAN IP address of your GL.iNet router, which is dynamically assigned by the primary router. This WAN IP can be viewed in the Ethernet section of the [INTERNET](../internet_ethernet/) page.

    - The **Gateway** and **DNS Server 1** fields are automatically filled with the IP address of the primary router by default. If these parameters are incorrectly configured, you can manually adjust them as needed.

    Write down the IP address here, as you will use it in the following steps.

    Select the second configuration method and click **Apply**.

3.  Set the gateway and DNS on the device that you want to use the Drop-in Gateway feature as the IP address in Drop-in Gateway page.

    Windows

    Here is an example of Windows 11, Windows 10 is similar. Make sure your PC is connected to the primary router. It is assumed here that your computer is connected to the primary router via a network cable, and the setup is similar if you connect via Wi-Fi.

    1.  Open Settings.

    2.  Click on **Network & Internet**.

    3.  Click the **Ethernet** tab.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/windows/windwos11_ethernet.png" class="glboxshadow" alt="windows 11 ethernet" />

    4.  You will find the IP address of this PC. Under the "IP assignment" section, click the **Edit** button.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/windows/windwos11_ethernet_ip_assignment_edit.png" class="glboxshadow" alt="windows 11 ethernet edit" />

    5.  Select the **Manual** option. Turn on the **IPv4 toggle** switch.

    6.  Set the **IP address** as the IP address you see in step d, **Subnet mask** set as `255.255.255.0`, both **Gateway** and **Preferred DNS** set as the IP address in Drop-in Gateway page.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/windows/windwos11_ethernet_edit_ip_settings.png" class="glboxshadow" alt="windows 11 ethernet edit" />

    7.  Click the **Save** button.

    Android

    Here is an example of Samsung S21. Make sure your smartphone is connected to the primary router.

    1.  Open Settings, click on Connections.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/android/settings_connections.jpg" class="glboxshadow" alt="settings connections" />

    2.  Click on Wi-Fi.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/android/connections_wifi.jpg" class="glboxshadow" alt="connection wifi" />

    3.  Click the cog icon of the current SSID.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/android/wifi_cog.jpg" class="glboxshadow" alt="wifi setting" />

    4.  Click **View more**.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/android/wifi_view_more.jpg" class="glboxshadow" alt="wifi settings, view more" />

    5.  Click **IP settings**, choose **Static**.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/android/wifi_ip_settings.jpg" class="glboxshadow" alt="ip settings" />

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/android/ip_settings_static.jpg" class="glboxshadow" alt="IP settings, static" />

    6.  Set the **Gateway** and **DNS 1** as the IP address in Drop-in Gateway page, then click **Save**.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/android/set_gateway.jpg" class="glboxshadow" alt="set gateway and dns ip" />

    iOS

    Here is an example of iOS 16.3 on iPhone 8. Make sure your smartphone is connected to the primary router.

    1.  Open Settings, click Wi-Fi.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/iphone/setting_wifi.jpg" class="glboxshadow gl-60-desktop" alt="settings wifi" />

    2.  Click the SSID.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/iphone/wifi_list.jpg" class="glboxshadow gl-60-desktop" alt="settings wifi" />

    3.  Scroll down and you will find the **Configure IP** is **Automatic**. Write down the **IP Address** and **Subnet Mask** for the next step.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/iphone/ipv4.jpg" class="glboxshadow gl-60-desktop" alt="wifi ipv4" />

    4.  Change **Configure IP** to **Manual**, set the **IP Address** and **Subnet Mask** to the same as you obtained in the previous step, and set the **Router** as the IP address displayed on the Drop-in Gateway page, then click **Save**.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/iphone/set_ipv4.jpg" class="glboxshadow gl-60-desktop" alt="wifi ipv4 manual" />

    5.  Click **Configure DNS** and change it to **Manual**. Click **Add Server**, set the DNS server IP address to the IP address displayed on the Drop-in Gateway page, then click **Save**.

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/iphone/dns.jpg" class="glboxshadow gl-60-desktop" alt="wifi dns" />

        <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/drop-in_gateway/iphone/set_dns.jpg" class="glboxshadow gl-60-desktop" alt="wifi set dns" />

4.  Back to the GL.iNet router's web Admin Panel and set up features as needed, such as [AdGuard Home](../adguardhome/), [encrypted DNS](../dns/), [WireGuard Client](../wireguard_client/) and [OpenVPN Client](../openvpn_client/).

## Cautions<a href="#cautions" class="headerlink" title="Permanent link">¶</a>

1.  Enabling Drop-in Gateway increases network latency.

2.  When Drop-in Gateway is enabled, data transmission between selected LAN devices is also routed through the drop-in gateway. Bandwidth between the primary router and drop-in gateway therefore impacts overall LAN bandwidth.

------------------------------------------------------------------------

Related Article:

- [How to set up drop-in gateway on a GL.iNet router](../../tutorials/how_to_set_up_drop_in_gateway/)

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a> or <a href="https://www.gl-inet.com/contacts/" target="_blank">Contact us</a>.


Back to top


