> Source: https://docs.gl-inet.com/router/en/4/interface_guide/wireless


<a href="#wireless" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../video_library/" class="md-nav__link"><span class="md-ellipsis"> Video Library </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../downloads/" class="md-nav__link"><span class="md-ellipsis"> Downloads </span></a>


# Wireless<a href="#wireless" class="headerlink" title="Permanent link">¶</a>

The content on this page is based on firmware version v4.9.x. If your device is running a different firmware version, use the selector below to switch to the corresponding guide.


- [Firmware v4.8 and earlier](../wireless_v4.8/)


------------------------------------------------------------------------

On the left side of the web Admin Panel, go to **WIRELESS**.

The Wireless page lets you configure various Wi-Fi networks, including MLO Wi-Fi (available on selected models), Main Network, Guest Network and IoT Network. The supported Wi-Fi bands vary by model.

## Multi-Link Operation (MLO)<a href="#multi-link-operation-mlo" class="headerlink" title="Permanent link">¶</a>

Supported Models

- GL-BE14000 (Flint 4)
- GL-BE10000 (Slate 7 Pro)
- GL-MT3600BE (Beryl 7)
- GL-BE6500 (Flint 3e)
- GL-BE9300 (Flint 3)
- GL-BE3600 (Slate 7)

Unsupported Models

- GL-MG1300 (Mango 2)
- GL-E5800 (Mudi 7)
- GL-MT5000 (Brume 3)
- GL-X2000 (Spitz Plus)
- GL-B3000 (Marble)
- GL-MT6000 (Flint2)
- GL-AX1800 (Flint)
- GL-X3000 (Spitz AX)
- GL-XE3000 (Puli AX)
- GL-MT3000 (Beryl AX)
- GL-AXT1800 (Slate AX)
- GL-A1300 (Slate Plus)
- GL-MT2500/GL-MT2500A (Brume 2)
- GL-SFT1200 (Opal)
- GL-MT1300 (Beryl)
- GL-E750/E750V2 (Mudi)
- GL-AR750S (Slate)
- GL-XE300 (Puli)
- GL-X750 (Spitz)
- GL-MT300N-V2 (Mango)
- GL-AR300M Series (Shadow)
- GL-AP1300 (Cirrus)
- GL-S1300 (Convexa-S)
- GL-B1300 (Convexa-B)
- GL-X300B (Collie)

MLO (Multi-Link Operation) is one of the core features of Wi-Fi 7 (802.11be), designed to improve network performance, significantly reduce latency, and enhance connection stability by utilizing multiple frequency bands simultaneously such as 2.4 GHz, 5 GHz, and 6 GHz.

Wi-Fi 7 clients are recommended to connect to MLO Wi-Fi, which greatly improves network throughput and reliability via multi-band connections.

Click **Add** to set up an MLO Wi-Fi network, then click **Apply**. Note that the available Wi-Fi bands vary by model.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/mlo1.png" class="glboxshadow" alt="mlo1" />

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/mlo2.png" class="glboxshadow" alt="mlo2" />

- Wi-Fi Band: Select at least two radio bands.
- Wi-Fi Security: If the 6 GHz band is selected, WPA3-SAE is the only available option and recommended. It works best with most MLO-supported devices.
- Enable Randomized BSSID: When the 6 GHz band is selected, the 6 GHz BSSID of the MLO Wi-Fi will be synchronized with the Main Wi-Fi.

Once enabled, the page appears as shown below.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/mlo3.png" class="glboxshadow" alt="mlo3" />

## Main Network<a href="#main-network" class="headerlink" title="Permanent link">¶</a>

The Main Network is your primary Wi-Fi network, supporting simultaneous broadcasts across different radio bands, all enabled by default. You can configure separate settings for each band, such as the Wi-Fi SSID, security mode, password, randomized BSSID, TX power, bandwidth, and channel.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/main.png" class="glboxshadow" alt="main" />

Click the gear icon on the right to view or modify Wi-Fi settings for each band.

**Note**: The available Wi-Fi bands vary by model.

- 6 GHz

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/main_6g.png" class="glboxshadow" alt="main 6g" />

- 5 GHz

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/main_5g.png" class="glboxshadow" alt="main 5g" />

- 2.4 GHz

  <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/main_2.4g.png" class="glboxshadow" alt="main 5g" />

## Guest Network<a href="#guest-network" class="headerlink" title="Permanent link">¶</a>

The Guest Network is a dedicated Wi-Fi network for visitors, with all bands disabled by default. You can enable and configure basic network settings for each band, such as the Wi-Fi SSID, security mode, password, and enable randomized BSSID.

Click **Add** to set up a Guest Wi-Fi network, then click **Apply**.

**Note**: The available Wi-Fi bands vary by model.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/guest1.png" class="glboxshadow" alt="guest1" />

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/guest2.png" class="glboxshadow" alt="guest2" />

Once enabled, the page appears as shown below.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/guest3.png" class="glboxshadow" alt="guest3" />

## IoT Network<a href="#iot-network" class="headerlink" title="Permanent link">¶</a>

The IoT Network is a dedicated Wi-Fi network for smart devices, with all bands disabled by default. You can enable and configure basic network settings for each band, such as the Wi-Fi SSID, security mode, password, and enable randomized BSSID.

Click **Add** to set up an IoT Wi-Fi network, then click **Apply**.

**Note**: IoT network does not include the 6 GHz band, and the available Wi-Fi bands vary by model.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/iot1.png" class="glboxshadow" alt="iot1" />

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/iot2.png" class="glboxshadow" alt="iot2" />

Once enabled, the page appears as shown below.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireless_v4.9/iot3.png" class="glboxshadow" alt="iot3" />

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a>.

Was this page helpful?


Thanks for your feedback!


Thanks for your feedback! We will use it to improve this page.


Back to top


