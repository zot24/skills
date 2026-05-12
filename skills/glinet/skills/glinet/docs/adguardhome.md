> Source: https://docs.gl-inet.com/router/en/4/interface_guide/adguardhome


<a href="#adguard-home" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../parental_control/" class="md-nav__link"><span class="md-ellipsis"> Parental Control </span></a>

<a href="../zerotier/" class="md-nav__link"><span class="md-ellipsis"> ZeroTier </span></a>

<a href="../tailscale/" class="md-nav__link"><span class="md-ellipsis"> Tailscale </span></a>

<a href="../esim_management/" class="md-nav__link"><span class="md-ellipsis"> eSIM Management </span></a>


<a href="../../video_library/" class="md-nav__link"><span class="md-ellipsis"> Video Library </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../community/" class="md-nav__link"><span class="md-ellipsis"> Community </span></a>


# AdGuard Home<a href="#adguard-home" class="headerlink" title="Permanent link">¶</a>

AdGuard Home is a network-wide software for blocking ads and tracking. Once set up, it covers all devices on your home network with no need for additional client-side software.

## Supported Models<a href="#supported-models" class="headerlink" title="Permanent link">¶</a>

Supported Models

- GL-E5800 (Mudi 7)
- GL-MT5000 (Brume 3)
- GL-MT3600BE (Beryl 7)
- GL-BE6500 (Flint 3e)
- GL-BE9300 (Flint 3)
- GL-BE3600 (Slate 7)
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
- GL-AP1300 (Cirrus)
- GL-S1300 (Convexa-S)

Unsupported Models

- GL-SFT1200 (Opal)
- GL-MT1300 (Beryl)
- GL-E750/E750V2 (Mudi)
- GL-AR750S (Slate)
- GL-XE300 (Puli)
- GL-X750 (Spitz)
- GL-MT300N-V2 (Mango)
- GL-AR300M Series (Shadow)
- GL-B1300 (Convexa-B)
- GL-X300B (Collie)

## Setup<a href="#setup" class="headerlink" title="Permanent link">¶</a>

Log in to the router's web Admin Panel and go to **APPLICATIONS** -\> **AdGuard Home**.

Toggle the switch to enable AdGuard Home and click **Apply**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/adguard_home/apply.png" class="glboxshadow" alt="adguard home apply" />

- AdGuard Home Handle Client Requests: If this option is enabled, DNS queries from client devices will be handled directly by AdGuard Home. AdGuard Home will show DNS query logs by clients, but this will cause VPN policies based on domain not to work.

This page displays statistics such as the DNS queries, blocked domains, etc, which is through the API provided by AdGuard Home.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/adguard_home/adguardhome_web_panel.png" class="glboxshadow" alt="adguard home web panel" />

Then please click **Settings Page**.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/adguard_home/settings_page.png" class="glboxshadow" alt="adguard home started" />

It will be re-directed to the AdGuard Home's official settings page, where you can perform advanced configuration for the filter rules, etc.

<img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/adguard_home/adguardhome_dashboard.png" class="glboxshadow" alt="adguard home settings" />

If you have any questions, please visit <a href="https://adguard.com/en/support.html" target="_blank">Adguard Home Support Center</a> for further assistance.

------------------------------------------------------------------------


Back to top


