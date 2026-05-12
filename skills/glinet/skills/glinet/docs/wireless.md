> Source: https://docs.gl-inet.com/router/en/4/interface_guide/wireless


<a href="#wireless" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../video_library/" class="md-nav__link"><span class="md-ellipsis"> Video Library </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../community/" class="md-nav__link"><span class="md-ellipsis"> Community </span></a>


# Wireless<a href="#wireless" class="headerlink" title="Permanent link">¶</a>

On the left side of the web Admin Panel, go to **WIRELESS**.

The Wireless page supports configuring separate Wi-Fi networks, including 2.4 GHz, 5 GHz, 6 GHz, and MLO Wi-Fi (availability varies by model). Each band can be set up as a Main Wi‑Fi or Guest Wi‑Fi network for flexible wireless management.

**Note**: Some models do not support 5 GHz Wi-Fi, such as GL-MT300N-V2 (Mango) and GL-X300B (Collie); some have no Wi‑Fi function, such as GL-MT5000 (Brume 3) and GL-MT2500/GL-MT2500A (Brume 2).

## MLO Wi-Fi<a href="#mlo-wi-fi" class="headerlink" title="Permanent link">¶</a>

| Supported Models         |     |
|:-------------------------|:---:|
| Slate 7 Pro (GL-BE10000) |  √  |
| Beryl 7 (GL-MT3600BE)    |  √  |
| Flint 3e (GL-BE6500)     |  √  |
| Flint 3 (GL-BE9300)      |  √  |
| Slate 7 (GL-BE3600)      |  √  |

MLO (Multi-Link Operation) is one of the core features of Wi-Fi 7 (802.11be), designed to improve network performance, significantly reduce latency, and enhance connection stability by utilizing multiple frequency bands simultaneously such as 2.4 GHz, 5 GHz, and 6 GHz.

Click on the tabs below to learn about MLO Main Wi-Fi and MLO Guest Wi-Fi settings.


MLO Wi-FiMLO Guest Wi-Fi


The MLO Main Wi-Fi allows you to configure multiple settings, including enabling/disabling Wi-Fi, selecting radio bands (at least two), enabling/disabling randomized BSSID, setting the Wi-Fi name (SSID), Wi-Fi security, Wi-Fi password, and SSID visibility.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/main_wifi_mlo.png" class="glboxshadow" alt="MLO Main Wi-Fi" />

- If the MLO Wi-Fi radio bands include 6 GHz, the MLO Wi-Fi BSSID will synchronize when the 6GHz Wi-Fi BSSID changes.

- The default Wi-Fi security for MLO Wi-Fi is WPA3-SAE, which is suitable for most devices that support MLO.


The MLO Guest Wi-Fi allows you to configure simplified settings, including enabling/disabling Wi-Fi, selecting radio bands (at least two), setting the Wi-Fi name (SSID), Wi-Fi security, password, and SSID visibility.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/guest_wifi_mlo.png" class="glboxshadow" alt="MLO Guest Wi-Fi" />


## 6 GHz Wi-Fi<a href="#6-ghz-wi-fi" class="headerlink" title="Permanent link">¶</a>

| Supported Models         |     |
|:-------------------------|:---:|
| Slate 7 Pro (GL-BE10000) |  √  |
| Mudi 7 (GL-E5800)        |  √  |
| Flint 3 (GL-BE9300)      |  √  |

The 6 GHz Wi-Fi provides faster, more stable wireless connectivity with reduced congestion compared to 2.4 GHz and 5 GHz bands.

Click on the tabs below to learn about 6 GHz Main Wi-Fi and 6 GHz Guest Wi-Fi settings.


6 GHz Wi-Fi6 GHz Guest Wi-Fi


The 6 GHz Main Wi-Fi allows you to configure multiple settings, including enabling/disabling Wi-Fi, setting TX power, enabling/disabling randomized BSSID, setting the Wi-Fi name (SSID), Wi-Fi security, Wi-Fi password, SSID visibility, Wi-Fi mode, bandwidth, and channel.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/main_wifi_6g.png" class="glboxshadow" alt="6G Main Wi-Fi" />

- Enable PSC: When PSC (Preferred Scanning Channel) is enabled, only channels with higher connectivity will be reserved to ensure 6 GHz device connections.


The 6 GHz Guest Wi-Fi allows you to configure simplified settings, including enabling/disabling Wi-Fi, setting the Wi-Fi name (SSID), Wi-Fi security, password, and SSID visibility.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/guest_wifi_6g.png" class="glboxshadow" alt="6G Guest Wi-Fi" />


## 5 GHz Wi-Fi<a href="#5-ghz-wi-fi" class="headerlink" title="Permanent link">¶</a>

Click on the tabs below to learn about 5 GHz Main Wi-Fi and 5 GHz Guest Wi-Fi settings.


5 GHz Wi-Fi5 GHz Guest Wi-Fi


The 5 GHz Main Wi-Fi allows you to configure multiple settings, including enabling/disabling Wi-Fi, setting TX power, enabling/disabling randomized BSSID, setting the Wi-Fi name (SSID), Wi-Fi security, Wi-Fi password, SSID visibility, Wi-Fi mode, bandwidth, and channel.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/main_wifi_5g.jpg" class="glboxshadow" alt="5G Main Wi-Fi" />


The 5 GHz Guest Wi-Fi allows you to configure simplified settings, including enabling/disabling Wi-Fi, setting the Wi-Fi name (SSID), Wi-Fi security, password, and SSID visibility.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/guest_wifi_5g.png" class="glboxshadow" alt="5G Guest Wi-Fi" />


## 2.4 GHz Wi-Fi<a href="#24-ghz-wi-fi" class="headerlink" title="Permanent link">¶</a>

Click on the tabs below to learn about 2.4 GHz Main Wi-Fi and 2.4 GHz Guest Wi-Fi settings.


2.4 GHz Wi-Fi2.4 GHz Guest Wi-Fi


The 2.4 GHz Main Wi-Fi allows you to configure multiple settings, including enabling/disabling Wi-Fi, setting TX power, enabling/disabling randomized BSSID, setting the Wi-Fi name (SSID), Wi-Fi security, Wi-Fi password, SSID visibility, Wi-Fi mode, bandwidth, and channel.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/main_wifi_2.4g.png" class="glboxshadow" alt="2.4G Main Wi-Fi" />


The 2.4 GHz Guest Wi-Fi allows you to configure simplified settings, including enabling/disabling Wi-Fi, setting the Wi-Fi name (SSID), Wi-Fi security, password, and SSID visibility.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/guest_wifi_2.4g.png" class="glboxshadow" alt="2.4G Guest Wi-Fi" />


## General Wi-Fi Settings<a href="#general-wi-fi-settings" class="headerlink" title="Permanent link">¶</a>

- Hover your cursor over the QR code icon next to the Wi-Fi SSID to display its Wi‑Fi QR code. You can scan it with your phone or tablet to connect to the corresponding Wi‑Fi network quickly.

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/wifi_ssid_qr_code.png" class="glboxshadow" alt="wifi qr code" />

- **Randomized BSSID**: This feature is enabled by default. It aims to prevent the client vendors from collecting nearby Wi-Fi BSSIDs and client devices' GPS coordinates to their servers. Click [here](#randomized-bssid) for more details.

- The **Bandwidth** and **Channel** cannot be modified when the router acts as a [repeater](../internet_repeater/), as they follow that of the repeated network.

- When **Channel** is set to **Auto**, the router's Wi-Fi will not automatically switch to the DFS channel.

- When switching the Channel to a DFS one from non-DFS channel, a caution will appear as follows.

  <img src="https://static.gl-inet.com/docs/router/en/4/tutorials/wireless/switch_to_dfs_caution.png" class="glboxshadow" alt="dfs channel caution" />

- When the **Bandwidth** is set to **160 MHz** (Only available on some models), the Wi-Fi will always use the DFS channel, even if you choose a non-DFS channel or Auto for Channel settings.

## Randomized BSSID<a href="#randomized-bssid" class="headerlink" title="Permanent link">¶</a>

Randomized BSSID has been available since firmware v4.6. It aims to prevent the client vendors from collecting nearby Wi-Fi BSSIDs and client devices' GPS coordinates to their servers.

**How Client Vendors Collect Location Data**

Client vendors usually collect the geographical location data of Wi-Fi access points by leveraging their unique BSSIDs to locate devices. When client devices (e.g., mobile phones, computers) scan or connect to a router:

- If other devices are within the router’s Wi-Fi signal coverage, their location and movement trajectories may be exposed.

- If a device uses GPS for positioning, it periodically uploads nearby Wi-Fi BSSIDs and corresponding GPS coordinates to the vendor’s server.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless/randomized-bssid-new.jpg" class="glboxshadow" alt="randomized bssid" />

**Security Risks of Crowdsourced Tracking**

Even devices without GPS (or with GPS disabled) can estimate their location by querying visible BSSID info. However, this crowd-sourced location tracking system has security vulnerabilities. Attackers can use it to accumulate a global database of Wi-Fi access point locations and continuously track the movement trajectories of devices, posing a threat to user privacy and security.

**How Randomized BSSID Protects Your Privacy**

To address these vulnerabilities, GL-iNet routers implement the Randomized BSSID feature as a privacy safeguard.

In the router’s web admin panel, go to WIRELESS -\> 5GHz Wi-Fi or 2.4GHz Wi-Fi, the BSSID option is enabled by default.

With this setting, the device uses a randomly generated BSSID and renews it each time it boots. If you disable the random BSSID, the router reverts to using the real MAC address.

**Note**: For Guest Wi-Fi, the BSSID remains consistent with the Main Wi-Fi BSSID within the same frequency band.

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a>.


Back to top


