> Source: https://docs.gl-inet.com/router/en/4/interface_guide/firewall


<a href="#firewall" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../port_forwarding/" class="md-nav__link"><span class="md-ellipsis"> Port Forwarding </span></a>

<a href="../multi-wan/" class="md-nav__link"><span class="md-ellipsis"> Multi-WAN </span></a>

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


# Firewall<a href="#firewall" class="headerlink" title="Permanent link">¶</a>

This guide applies to firmware v4.5 and earlier.

Since v4.6, the Firewall page has been split. The Port Forwarding and DMZ features have been moved to the [Port Forwarding](../port_forwarding/). The Open Ports feature has been moved to the [Security](../security/).

------------------------------------------------------------------------

On the left side of the web Admin Panel, go to **NETWORK** -\> **Firewall**.

The Firewall page allows you to set firewall rules like **Port Forwarding**, **Open Ports on Router** and **DMZ**.

## Port Forwards<a href="#port-forwards" class="headerlink" title="Permanent link">¶</a>

Port Forwarding lets remote computers connect to a local computer or server behind the router's firewall in the LAN (such as web servers, FTP servers).

To set up port forwarding, click the **Port Forwards** tab, then click **Add**.

<img src="https://static.gl-inet.com/docs/router/en/4/tutorials/firewall/firewall.png" class="glboxshadow" alt="firewall page" />

In the pop-up window, add a new port forward rule, and click **Apply**.

<img src="https://static.gl-inet.com/docs/router/en/4/tutorials/firewall/add_new_port_forward_rule.png" class="glboxshadow" alt="add new port forward rule" />

**Name:** The name of the rule.

**Protocol:** The protocol used, you can choose TCP, UDP, or both TCP and UDP.

**External Zone:** The options for external zone are `WAN`, `wgclient`, `wgserver`, `ovpnclient`, `ovpnserver`.

**External Port:** The numbers of external ports. You can enter a specific port number here.

**Internal Zone:** The options for internal zone are `WAN`, `wgclient`, `wgserver`, `ovpnclient`, `ovpnserver`.

**Internal IP:** The IP address assigned by the router to the device which needs to be accessed remotely.

**Internal Port:** The internal port number of the device. You can enter a specific port number. Leave it blank if it is same as the external port.

**Enable:** Enable or disable the rule.

## Open Ports on Router<a href="#open-ports-on-router" class="headerlink" title="Permanent link">¶</a>

The router's services, such as web and FTP, requires their respective ports to be opened on the router in order to be publicly reachable.

To open a port, switch to the **Open Ports on Router** tab, then click **Add**.

<img src="https://static.gl-inet.com/docs/router/en/4/tutorials/firewall/open_ports_on_router.png" class="glboxshadow" alt="open Ports on router" />

In the pop-up window, open a new port and click **Apply**.

<img src="https://static.gl-inet.com/docs/router/en/4/tutorials/firewall/add_new_open_port.png" class="glboxshadow" alt="open Ports on router" />

**Name:** The name of the rule which can be specified by the user.

**Protocol:** The protocol used, you can choose TCP, UDP, or both TCP and UDP.

**Port:** The port number that you want to open.

**Enable:** Enable or disable the rule.

## DMZ<a href="#dmz" class="headerlink" title="Permanent link">¶</a>

DMZ lets you to expose one computer to the Internet, so all inbound packets will be redirected to this computer.

Toggle on **Enable DMZ**. Select the internal IP address of your host device which is going to receive all the inbound packets.

<img src="https://static.gl-inet.com/docs/router/en/4/tutorials/firewall/dmz.png" class="glboxshadow" alt="Port Forwards" />

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a> or <a href="https://www.gl-inet.com/contacts/" target="_blank">Contact us</a>.


Back to top


