> Source: https://docs.gl-inet.com/router/en/4/interface_guide/vpn_dashboard_v4.8


<a href="#vpn-dashboard-firmware-v48" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../vpn_dashboard_v4.9/" class="md-nav__link"><span class="md-ellipsis"> VPN Dashboard (v4.9) </span></a>

<a href="../openvpn_client/" class="md-nav__link"><span class="md-ellipsis"> OpenVPN Client </span></a>

<a href="../openvpn_server/" class="md-nav__link"><span class="md-ellipsis"> OpenVPN Server </span></a>

<a href="../wireguard_client/" class="md-nav__link"><span class="md-ellipsis"> WireGuard Client </span></a>

<a href="../wireguard_server/" class="md-nav__link"><span class="md-ellipsis"> WireGuard Server </span></a>

<a href="../tor/" class="md-nav__link"><span class="md-ellipsis"> Tor </span></a>


<a href="../../video_library/" class="md-nav__link"><span class="md-ellipsis"> Video Library </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../community/" class="md-nav__link"><span class="md-ellipsis"> Community </span></a>


# VPN Dashboard (Firmware v4.8)<a href="#vpn-dashboard-firmware-v48" class="headerlink" title="Permanent link">¶</a>

On the left side of the web Admin Panel, go to **VPN** -\> **VPN Dashboard**.

The VPN dashboard displays VPN connection details, such as tunnel rules, server address, traffic statistics, client virtual IP, and connection log, and allows users to configure advanced settings such as the VPN Kill Switch, IP Masquerading, and MTU.

You can also activate multiple VPN connections for multi-tunnel scenarios.

## Setup Wizard<a href="#setup-wizard" class="headerlink" title="Permanent link">¶</a>

Click the book icon in the upper left and follow the VPN Setup Wizard to complete the VPN configuration quickly.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/vpn_wizard_1.png" class="glboxshadow" alt="vpn wizard 1" />

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/vpn_wizard_2.png" class="glboxshadow" alt="vpn wizard 2" />

**Note**: The VPN Setup Wizard is only for the integrated VPN services, including AzireVPN, Hide.me, IPVanish, Mullvad, NordVPN, PIA and Surfshark. For other VPN services, skip the wizard and go to <a href="../openvpn_client/" target="_blank">OpenVPN Client</a> or <a href="../wireguard_client/" target="_blank">WireGuard Client</a> to set up VPN manually.

Here's an example with **Hide.me**. Log in with Hide.me credentials.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/vpn_login.png" class="glboxshadow" alt="vpn login" />

Select a VPN server and click **Apply**. This is the server you will connect to via this VPN tunnel, and your public IP address will appear to be from the selected server's location.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/select_server.png" class="glboxshadow" alt="select server" />

It will connect automatically. Once connected successfully, go to the VPN Dashboard and you will see a VPN Tunnel has been enabled.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/connected.png" class="glboxshadow" alt="vpn connected" />

It displays the currently used VPN protocol (e.g., WireGuard), the configuration file, server address, server listen port, traffic statistics, and client virtual IP. Users can view the connection log in the bottom right.

All connected clients will access the Internet via this VPN tunnel.

If you want to configure VPN policy, please refer to [Policy Mode](#policy-mode).

## VPN Mode<a href="#vpn-mode" class="headerlink" title="Permanent link">¶</a>

On the VPN Dashboard, click the button in the upper right corner to switch VPN modes.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/vpn_mode.png" class="glboxshadow" alt="vpn mode" />

Two modes are available: **Global Mode** and **Policy Mode**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/global_mode.png" class="glboxshadow" alt="vpn mode" />

### Global Mode<a href="#global-mode" class="headerlink" title="Permanent link">¶</a>

In this mode, all traffic is routed through the VPN tunnel, and only one VPN client instance can be activated.

It is ideal for scenarios where all client traffic is routed through a single VPN server, such as unified network security or region‑specific content access.

In the following example, the router connects to an Australian server using the WireGuard protocol. All traffic from connected clients will be routed through this VPN tunnel.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/connected-global-mode.png" class="glboxshadow" alt="connected global mode" />

### Policy Mode<a href="#policy-mode" class="headerlink" title="Permanent link">¶</a>

In this mode, the router can connect to multiple VPN servers, and you can customize routing rules for different clients or traffic destinations.

It is suitable for use cases requiring flexible traffic management, such as routing different traffic to different destinations through multiple VPN servers.

Switch the VPN Mode to Policy Mode, and click **Apply**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/policy_mode.png" class="glboxshadow" alt="policy mode" />

After switching, if the VPN is not enabled, the page displays as below, including three sections: Primary Tunnel, Add Tunnel, and All Other Traffic.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/policy_no_vpn_file.png" class="glboxshadow" alt="policy mode no vpn" />

Click the corresponding section to learn more.

- [Primary Tunnel](#primary-tunnel)
- [Add Tunnel](#add-tunnel)
- [All Other Traffic](#all-other-traffic)

#### Primary Tunnel<a href="#primary-tunnel" class="headerlink" title="Permanent link">¶</a>

The primary tunnel is a <u>preset</u> tunnel in Policy Mode. It has the top priority, and you can modify [tunnel priority](#tunnel-priority) if there is more than one tunnel.

In this tunnel, you can customize the tunnel rule by setting three factors:

1.  **From**: It refers to the traffic source, i.e., the traffic that should be routed via this tunnel.

    Click the greyed-out box to select the traffic source.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/traffic_from_1.png" class="glboxshadow" alt="traffic source" />

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/traffic_from_2.jpg" class="glboxshadow" alt="traffic source" />

    - **All Clients**: If selected, traffic from all devices will match this rule.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/all_clients.jpg" class="glboxshadow" alt="all clients" />

    - **Specified Connection Types**: If selected, traffic from specified connection types (e.g., LAN subnet, Drop-in Gateway, Guest Network) will match this rule.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/specified_connection_types_1.jpg" class="glboxshadow" alt="specified connection" />

      If you have enabled the OpenVPN server or WireGuard server on this router, there will be more options under the Specified Connection Types. This is useful for [VPN Cascading](../../tutorials/how_to_use_vpn_cascading_on_glinet_routers/).

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/specified_connection_types_2.png" class="glboxshadow" alt="specified connection" />

    - **Specified Devices**: If selected, traffic from specified devices (identified by MAC address) will match this rule.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/specified_devices.jpg" class="glboxshadow" alt="specified devices" />

    - **Exclude Specified Devices**: If selected, traffic from specified devices (identified by MAC address) will **NOT** match this rule.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/exclude_devices.jpg" class="glboxshadow" alt="exclude devices" />

2.  **To**: It refers to the traffic destinations.

    Click the greyed-out box to select the traffic destinations.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/traffic_to_1.png" class="glboxshadow" alt="traffic destination" />

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/traffic_to_2.png" class="glboxshadow" alt="traffic destination" />

    - **All Targets**: If selected, traffic matching this rule will be routed to all targets.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/all_targets.png" class="glboxshadow" alt="all targets" />

    - **Specified Domain / IP List**: If selected, traffic matching this rule will be routed to specified domains or IP addresses. You need to enter them manually.

      Please note that specifying a <u>root domain</u> will cover all its subdomains. For example, if you want to specify `archive.ubuntu.com`, `security.ubuntu.com`, and `old-releases.ubuntu.com` in a tunnel, you only need to specify the root domain `ubuntu.com`.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/specified_domain_ip_manual.png" class="glboxshadow" alt="specified domain/IP manual" />

      Or switch the **Input Mode** from Manual to Subscription URL, and input URL Link.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/specified_domain_ip_subscription.png" class="glboxshadow" alt="specified domain/IP subscription" />

      <div class="admonition note">

      Note

      - Specifying a root domain will cover all its subdomains.

      - If you select Subscribe URL, the domain name or IP in the URL is automatically updated every day.

      - Make sure to enter the correct URL. The URL detection will verify the validity of the domain name or IP address. <a href="../../tutorials/how_to_configure_domain_and_ip_filtering_rules_for_glinet_routers_via_an_online_text_file/" target="_blank">Learn More</a>

      </div>

    - **Exclude Specified Domain / IP List**: If selected, traffic matching this rule will **NOT** be routed to specified domains or IP addresses. You need to enter them manually.

      Please note that specifying a <u>root domain</u> will cover all its subdomains. For example, if you want to specify `archive.ubuntu.com`, `security.ubuntu.com`, and `old-releases.ubuntu.com` in a tunnel, you only need to specify the root domain `ubuntu.com`.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/exclude_domain_ip_manual.png" class="glboxshadow" alt="exclude specified domain/IP manual" />

      Or switch the **Input Mode** from Manual to Subscription URL and input URL Link.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/exclude_domain_ip_subscription.png" class="glboxshadow" alt="exclude specified domain/IP subscription" />

      <div class="admonition note">

      Note

      - Specifying a root domain will cover all its subdomains.

      - If you select Subscribe URL, the domain name or IP in the URL is automatically updated every day.

      - Make sure to enter the correct URL. The URL detection will verify the validity of the domain name or IP address. <a href="../../tutorials/how_to_configure_domain_and_ip_filtering_rules_for_glinet_routers_via_an_online_text_file/" target="_blank">Learn More</a>

      </div>

3.  **Via**: It refers to the traffic routing method, i.e., whether to use VPN.

    Click the greyed-out box to select the routing method.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/traffic_via_1.png" class="glboxshadow" alt="via" />

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/traffic_via_2.png" class="glboxshadow" alt="via" />

    - **Use VPN**: If selected, traffic matching this rule will be routed to the selected destinations through VPN.

      To begin with, you need to configure your router as a VPN client. Use the [VPN Setup Wizard](#vpn-setup-wizard) to quickly complete the configuration, or navigate to OpenVPN Client / WireGuard Client in the left sidebar to configure manually.

      Once you set the router as a VPN client, select a VPN configuration file for this tunnel, and click **Apply**.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/use_vpn_2.png" class="glboxshadow" alt="use vpn" />

    - **Not Use VPN**: If selected, traffic matching this rule will be routed to the selected destinations via local WAN instead of the VPN.

      <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/not_use_vpn.png" class="glboxshadow" alt="not use vpn" />

4.  After selecting the traffic source, destination, and routing method, the primary tunnel rule setup is complete.

In the following example, the Primary Tunnel rule is: All clients use the VPN to access specified domains. Their traffic is routed through the Australian server and exits to the selected Internet domains via this tunnel.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/connected-policy-mode.jpg" class="glboxshadow" alt="connected policy mode" />

**Note**: For security, please go to [All Other Traffic](#all-other-traffic) and [Tunnel Options](#tunnel-options) to check other settings before enabling the tunnels.

#### Add Tunnel<a href="#add-tunnel" class="headerlink" title="Permanent link">¶</a>

To create additional tunnels for multiple VPN instances, click **Add Tunnel** below the Primary Tunnel and configure custom rules.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/add_tunnel.jpg" class="glboxshadow" alt="add tunnel" />

Name the tunnel.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/name_tunnel.png" class="glboxshadow" alt="name tunnel" />

You will get one more tunnel on the VPN Dashboard.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/two_tunnels.png" class="glboxshadow" alt="two tunnels" />

You can add more tunnels if needed. Up to 5 tunnels can be created (including the preset primary tunnel).

Customize the tunnel rules by setting the traffic source, destinations and routing method. Please refer to the [Primary Tunnel](#primary-tunnel).

**Note**: For security, please go to [All Other Traffic](#all-other-traffic) and [Tunnel Options](#tunnel-options) to check other settings before enabling the tunnels.

#### All Other Traffic<a href="#all-other-traffic" class="headerlink" title="Permanent link">¶</a>

In Policy Mode, a <u>pre-enabled</u> tunnel is displayed at the bottom of the VPN Dashboard.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/all_other_traffic.png" class="glboxshadow" alt="all other traffic" />

This tunnel controls whether traffic that does not match any of the above VPN tunnel groups can access the Internet. It is enabled by default to ensure normal Internet access for traffic not routed via VPN.

- When enabled, unmatched traffic can still access the Internet.

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.9/all_other_traffic_on.png" class="glboxshadow" alt="all other traffic on" />

- When disabled, only traffic routed via VPN is allowed to access the Internet. All non-VPN traffic and traffic that fails over from VPN connections will be blocked. This option does not override the individual Kill Switch for each VPN tunnel.

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.9/all_other_traffic_off.png" class="glboxshadow" alt="all other traffic off" />

#### Tunnel Priority<a href="#tunnel-priority" class="headerlink" title="Permanent link">¶</a>

By default, the preset Primary Tunnel has the top priority, followed by other manual-added tunnel (if any), then the All Other Traffic tunnel to ensure local network connectivity (via local WAN).

To modify tunnel priority, click **Modify Priority** in the top info bar, or click the **priority label** in the top left of any tunnel (e.g., Priority 1/Priority 2).

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/modify_priority_1.png" class="glboxshadow" alt="modify priority" />

Click and hold the three-line icon on the right to reorder the tunnels, and click **Apply**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/modify_priority_2.png" class="glboxshadow" alt="modify priority" />

**When multiple tunnels are enabled, the router will route traffic in the following order**:

1.  Traffic will first attempt to match the highest-priority tunnel rule. If matched, it will be routed through that tunnel; otherwise, it will try the next priority tunnel, and so on, until it matches the "All Other Traffic" tunnel.

2.  If a VPN tunnel disconnects unexpectedly, the system will determine whether to fail over the traffic to the next priority tunnel based on whether this tunnel's **Kill Switch** is enabled.

    - If the Kill Switch is enabled, traffic will be blocked and will not fail over to the next priority tunnel.
    - If the Kill Switch is disabled, traffic will fail over to the next priority tunnel and attempt to match its tunnel rules.

3.  The **All Other Traffic** tunnel is enabled by default to ensure that traffic not matching the VPN tunnels can still access the Internet.

    - If enabled, it routes unmatched or failover traffic through the local WAN.
    - If disabled, it strengthens the Kill Switch and blocks regular Internet access to prevent IP leaks.

#### Tunnel Options<a href="#tunnel-options" class="headerlink" title="Permanent link">¶</a>

You can configure advanced settings for each VPN tunnel, such as the VPN Kill Switch, IP Masquerading, and MTU.

Click the gear icon next to a tunnel name and select **Options**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/tunnel_options_1.png" class="glboxshadow" alt="tunnel options" />

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/vpn_dashboard/4.8/tunnel_options_2.png" class="glboxshadow" alt="tunnel options" />

- **Kill Switch**: If enabled, traffic matching this VPN tunnel will be blocked if the VPN connection fails unexpectedly. If disabled, such traffic will fail over to the next priority tunnel or local WAN.

- **Services from GL.iNet Use VPN**: If enabled, GoodCloud, DDNS, and rtty services will transmit packets through VPN tunnels. This option is disabled by default, as these services normally require the device's real IP address to work properly.

- **Allow Remote Access the LAN Subnet**: If enabled, remote access to this router and its LAN devices through the VPN will be allowed. It requires the VPN server to advertise a route back to its LAN subnet.

- **IP Masquerading**: If enabled, the source IP addresses of LAN clients will be rewritten to the router's VPN tunnel IP. Disable this only for Site-to-Site setups where the remote peer knows your LAN subnets.

- **MTU**: The MTU value you set for the tunnel will override the MTU settings in the configuration file.

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a> or <a href="https://www.gl-inet.com/contacts/" target="_blank">Contact us</a>.


Back to top


