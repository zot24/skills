> Source: https://docs.gl-inet.com/router/en/4/interface_guide/clients


<a href="#clients" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="#remove-offline-clients" class="md-nav__link">Remove Offline Clients</a>


<a href="../../video_library/" class="md-nav__link"><span class="md-ellipsis"> Video Library </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../community/" class="md-nav__link"><span class="md-ellipsis"> Community </span></a>


<a href="#remove-offline-clients" class="md-nav__link">Remove Offline Clients</a>


# Clients<a href="#clients" class="headerlink" title="Permanent link">¶</a>

On the left side of the web Admin Panel, go to **CLIENTS**.

The Clients page displays information about connected devices, including device name, connection type, IP address, MAC address, speed, and traffic, arranged left to right.

## Device Name<a href="#device-name" class="headerlink" title="Permanent link">¶</a>

The first column displays the device name and device type, which depends on the hostname of the device operator.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/device_name.png" class="glboxshadow" alt="device name" />

To modify the device name and type, click the three-dot icon in the Action column, and in the drop-down menu, click **Modify**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/modify.png" class="glboxshadow" alt="modify" />

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/modify_client_device.png" class="glboxshadow" alt="modify client device" />

## Connection Type<a href="#connection-type" class="headerlink" title="Permanent link">¶</a>

The blue icon on the right side of the device name represents the connection type/method of device.

It indicates how the device is connected to the network - whether via Wi-Fi or an ethernet cable.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/connection_type.png" class="glboxshadow" alt="connection type" />

## IP and MAC Address<a href="#ip-and-mac-address" class="headerlink" title="Permanent link">¶</a>

The second column lists the IP and MAC addresses of the connected device.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/ip_mac.png" class="glboxshadow" alt="ip and mac" />

Many devices use randomized MAC addresses. If the connected devices use randomized MAC addresses, the following prompt will appear.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/randomized_mac.png" class="glboxshadow" alt="random mac prompt" />

**Note**: The rule here is that if the second character of the MAC address is 2, 6, A or E(Ignore case), it is considered a randomized MAC address. However, some devices may use a different rule to generate a randomized MAC address, so this detection method may not be accurate.

## Speed<a href="#speed" class="headerlink" title="Permanent link">¶</a>

The third column displays the internet speed of the connected device.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/speed.png" class="glboxshadow" alt="speed" />

The speed here is the average speed over 3 minutes.

- Open the current page for 10 seconds, the average speed of the last 10 seconds is displayed.
- Open the current page for 30 seconds, the average speed of the last 30 seconds is displayed.
- Open the current page for 60 seconds, the average speed of the last 60 seconds is displayed.
- Open current page for 3 minutes, the average rate of the last 3 minutes is displayed.
- Open current page for 10 minutes, the average rate of the last 3 minutes is displayed.

## Traffic<a href="#traffic" class="headerlink" title="Permanent link">¶</a>

The fourth column displays the internet traffic of the connected device.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/traffic.png" class="glboxshadow" alt="traffic" />

## Reserved IP<a href="#reserved-ip" class="headerlink" title="Permanent link">¶</a>

In the fifth column, you can reserve IP address for a certain connected device with just one click.

This feature is available as of v4.8.

When you specify a reserved IP address for a client within the LAN, the client always receives the same IP address each time it accesses the router's DHCP server.

You can assign reserved IP addresses to computers or servers that require permanent IP settings.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/reserved_ip.png" class="glboxshadow" alt="reserved ip" />

## Blocklist<a href="#blocklist" class="headerlink" title="Permanent link">¶</a>

In the sixth column, you can block specific connected devices with just one click.

The access control rule is Blocklist by default, and you can switch it to Allowlist from the top if needed.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/blocklist.jpg" class="glboxshadow" alt="blocklist" />

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/blocklist_allowlist.jpg" class="glboxshadow" alt="access control" />

- **Blocklist**: Devices with MAC addresses on the blocklist list are not allowed to connect to this router.

- **Allowlist**: Only devices with specific MAC addresses are allowed to connect, suitable for IoT devices and enterprise network management.

To create a Blocklist, you can upload a block list in excel form at **(1)**, or input MAC addresses manually at **(2)**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/create_blocklist.png" class="glboxshadow" alt="create blocklist" />

**Method 1. Import Clients**

In the Access Control page, click on **Import Clients**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/import_clients.png" class="glboxshadow" alt="import clients" />

Click on **Download Import Template**, and you will download an XLS worksheet named "mac-template.csv".

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/download_template.png" class="glboxshadow" alt="download template" />

Open the file, import the MAC addresses and save.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/importcsv.jpg" class="glboxshadow gl-80-desktop" alt="import csv" />

Select the saved file or drag it to the upload area.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/dragcsv.jpg" class="glboxshadow gl-80-desktop" alt="upload csv" />

Once the upload is successful, click **Import** to complete the batch import of MAC addresses.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/upload_successful.png" class="glboxshadow" alt="upload successful" />

**Method 2. Input Manually**

In the Access Control page, manually input the MAC address of the devices you want to block, and click **Apply**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/input_mac_manually.png" class="glboxshadow" alt="input mac manually" />

**Note**: Blocking client is based on the MAC address of the device. If the blocked device uses different MAC address next time, it can still be able to connect to router.

## Sort<a href="#sort" class="headerlink" title="Permanent link">¶</a>

The current sort type is displayed in the upper right corner, and you can switch to other sort types.

The default sort type is as follows:

- The self device is always on top.
- In the online client section, the later the device is connected, the higher it appears in the list.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/sort.png" class="glboxshadow" alt="sort" />

## Action<a href="#action" class="headerlink" title="Permanent link">¶</a>

### Client Details<a href="#client-details" class="headerlink" title="Permanent link">¶</a>

If you need to view the details of the client device, click the three-dot icon in the rightmost Action column and then click the **View Details** in the drop-down menu.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/details.png" class="glboxshadow" alt="view details" />

You can see all the information about the client device in the opened subpage, including all IPv6 addresses of the device if any.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/client_detail.png" class="glboxshadow" alt="client details" />

### Modify<a href="#modify" class="headerlink" title="Permanent link">¶</a>

Click the three-dot icon in the Action column, and in the drop-down menu, click **Modify**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/modify.png" class="glboxshadow" alt="modify" />

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/modify_client_device.png" class="glboxshadow" alt="modify client device" />

### Limit Speed<a href="#limit-speed" class="headerlink" title="Permanent link">¶</a>

Click the three-dot icon in the Action column, and in the drop-down menu, click **Limit Speed**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/limit_speed.png" class="glboxshadow" alt="limit speed" />

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/clients_limit_speed_settings.png" class="glboxshadow" alt="limit speed settings" />

If a client has been applied speed limitation, its up arrow and down arrow of speed will turn yellow.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/limit_speed.jpg" class="glboxshadow" alt="limited speed" />

Click the three-dot icon in the Action column to disable speed limit.

### Use VPN Tunnel<a href="#use-vpn-tunnel" class="headerlink" title="Permanent link">¶</a>

**Note**: This option is available as of firmware v4.8 and will only appear in the Action menu if a MAC-based policy is configured.

Add a client to the VPN tunnel list with MAC-based policy. If you need to make detailed adjustments to the tunnels, go to the VPN Dashboard for management.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/use-vpn-tunnel.png" class="glboxshadow" alt="use vpn tunnel" />

## Remove Offline Clients<a href="#remove-offline-clients" class="headerlink" title="Permanent link">¶</a>

In the offline clients section, you can click **Delete All** at the top right to delete all offline clients.

If you want to remove specific client, click the three-dot icon in the Action column, and in the drop-down menu, click **Remove Client**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/clients/remove_offline.png" class="glboxshadow" alt="remove offline clients" />

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a> or <a href="https://www.gl-inet.com/contacts/" target="_blank">Contact us</a>.


Back to top


