> Source: https://docs.gl-inet.com/router/en/4/interface_guide/wireguard_client


<a href="#set-up-wireguard-client-on-glinet-routers" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/gl-inet/docs4.x" class="md-source" data-md-component="source" title="Go to repository"></a>


gl-inet/docs4.x


<a href="../../faq/" class="md-nav__link"><span class="md-ellipsis"> FAQ </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../tutorials/" class="md-nav__link"><span class="md-ellipsis"> Tutorials </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../" class="md-nav__link"><span class="md-ellipsis"> Interface Guide </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../wireguard_server/" class="md-nav__link"><span class="md-ellipsis"> WireGuard Server </span></a>

<a href="../tor/" class="md-nav__link"><span class="md-ellipsis"> Tor </span></a>


<a href="../../video_library/" class="md-nav__link"><span class="md-ellipsis"> Video Library </span></a> <span class="md-nav__icon md-icon"></span>


<a href="../../community/" class="md-nav__link"><span class="md-ellipsis"> Community </span></a>


# Set Up WireGuard Client on GL.iNet Routers<a href="#set-up-wireguard-client-on-glinet-routers" class="headerlink" title="Permanent link">¶</a>

**Note**: This guide applies to firmware v4.7 and later. For earlier versions, please refer [here](../wireguard_client_v4.6/).

------------------------------------------------------------------------

WireGuard® is an extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography. It aims to be faster, simpler, leaner, and more useful than IPsec, while avoiding the massive headache. It intends to be considerably more performant than OpenVPN.

To set up WireGuard client on a GL.iNet router, watch this video or refer to the steps below.


# An error occurred.


Unable to execute JavaScript.


------------------------------------------------------------------------

Before you start, ensure you have an active subscription with a VPN service provider that supports WireGuard manual configuration. Click <a href="https://www.gl-inet.com/solutions/vpn/" target="_blank">here</a> to check the WireGuard providers compatible with GL.iNet.

Generally, you need to visit the official website of the VPN service provider you subscribed first, obtain the configuration file, and upload it to the router to set it as a WireGuard client. If you don't know how to get the configuration file, refer to [this link](../../tutorials/how_to_get_configuration_files_from_wireguard_service_providers/) or contact their support.

You can set up a WireGuard client via the web Admin Panel or [mobile app](../../faq/mobile_app/).

- **The mobile app** integrates some WireGuard service providers, such as AzireVPN, Mullvad VPN, OVPN, StrongVPN, PIA VPN, etc., which means you can easily set it up by simply entering the login credentials of the WireGuard service you subscribed to. Open the app and follow the on-screen instructions to set up.

- **The web Admin Panel** not only integrates some WireGuard service providers, but also provides an entry for manual configuration. You can either enter the credentials of your subscribed WireGuard service for quick setup, or manually upload a configuration file to complete the setup.

Below are steps to set up via the web admin panel. Select the corresponding WireGuard service provider below to quickly locate the step-by-step instructions.

- [Set Up AzireVPN](#set-up-azirevpn)
- [Set Up Hide.me](#set-up-hideme)
- [Set Up IPVanish](#set-up-ipvanish)
- [Set Up Mullvad](#set-up-mullvad)
- [Set Up NordVPN](#set-up-nordvpn)
- [Set Up PIA (Private Internet Access)](#set-up-pia-private-internet-access)
- [Set up PureVPN](#set-up-purevpn)
- [Set Up Surfshark](#set-up-surfshark)
- [Set Up WireGuard Client Manually (for other providers)](#set-up-wireguard-client-manually-for-other-providers)

## Set Up AzireVPN<a href="#set-up-azirevpn" class="headerlink" title="Permanent link">¶</a>

<a href="https://www.azirevpn.com/aff/9x7wisg4" target="_blank">AzireVPN</a> is privacy-minded VPN service providing secure, modern and robust tunnels such as WireGuard.

Watch this video to set up AzireVPN on GL.iNet routers via the web Admin Panel or mobile app.


# An error occurred.


Unable to execute JavaScript.


Or follow the steps below to set up AzireVPN via web Admin Panel.

In the web Admin Panel, go to **VPN** -\> **WireGuard Client** -\> **AzireVPN**.

1.  Input **Username** and **Password**, then click **Save and Continue**. It will generate configuration files for each server.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_azirevpn/azirevpn1.png" class="glboxshadow" alt="azirevpn login" />

2.  Start a connection.

    Select your preferred server, and click the three-dot icon on the right to start a connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_azirevpn/azirevpn2.png" class="glboxshadow" alt="azirevpn start" />

    Once connected, a green dot will appear next to the configuration file.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_azirevpn/azirevpn3.png" class="glboxshadow" alt="azirevpn connected" />

    And the VPN connection details will be displayed on the **VPN Dashboard**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_azirevpn/azirevpn4.png" class="glboxshadow" alt="azirevpn connection status" />

3.  Update servers.

    You can click **Update Servers** to obtain the latest available server list, avoiding connection failures caused by server maintenance or shutdown.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_azirevpn/azirevpn5.png" class="glboxshadow" alt="azirevpn update servers" />

4.  Edit credentials or logout.

    Click the gear icon to edit your login credentials or log out.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_azirevpn/azirevpn6.png" class="glboxshadow" alt="azirevpn edit credentials or logout" />

5.  Go renew.

    If you click **Go Renew**, you will be re-directed to the official website to renew your subscription.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_azirevpn/azirevpn7.png" class="glboxshadow" alt="azirevpn go renew" />

6.  Delete All.

    You can click **Delete All** to delete all configuration files with one click, and choose whether to delete the private and public keys simultaneously.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_azirevpn/azirevpn8.png" class="glboxshadow" alt="azirevpn delete" />

## Set Up Hide.me<a href="#set-up-hideme" class="headerlink" title="Permanent link">¶</a>

<a href="https://www.hideipvpn.com/" target="_blank">Official Website</a>

In the web Admin Panel, go to **VPN** -\> **WireGuard Client** -\> **Hide.me**.

1.  Input **Username** and **Password**, then click **Save and Continue**. It will generate configuration files for each server.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_hidemevpn/hideme1.png" class="glboxshadow" alt="hideme login" />

2.  Start a connection.

    Select your preferred server, and click the three-dot icon on the right to start a connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_hidemevpn/hideme2.png" class="glboxshadow" alt="hideme start" />

    Once connected, a green dot will appear next to the configuration file.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_hidemevpn/hideme3.png" class="glboxshadow" alt="hideme connected" />

    And the VPN connection details will be displayed on the **VPN Dashboard**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_hidemevpn/hideme4.png" class="glboxshadow" alt="hideme connection status" />

3.  Update servers.

    You can click **Update Servers** to obtain the latest available server list, avoiding connection failures caused by server maintenance or shutdown.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_hidemevpn/hideme5.png" class="glboxshadow" alt="hideme update servers" />

4.  Edit credentials or logout.

    Click the gear icon to edit your login credentials or log out.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_hidemevpn/hideme6.png" class="glboxshadow" alt="hideme edit credentials or logout" />

5.  Delete All.

    You can click **Delete All** to delete all configuration files with one click, and choose whether to delete the private and public keys simultaneously.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_hidemevpn/hideme7.png" class="glboxshadow" alt="hide.me delete" />

## Set Up IPVanish<a href="#set-up-ipvanish" class="headerlink" title="Permanent link">¶</a>

<a href="https://affiliate.ipvanish.com/aff_c?offer_id=1&amp;aff_id=3073" target="_blank">Official Website</a>

In the web Admin Panel, go to **VPN** -\> **WireGuard Client** -\> **IPVanish**.

1.  Input **Username** and **Password**, then click **Save and Continue**. It will generate configuration files for each server.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_ipvanish/ipvanish1.png" class="glboxshadow" alt="ipvanish login" />

2.  Select servers.

    Select the server(s) you want to connect to, and click **Apply**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_ipvanish/ipvanish2.png" class="glboxshadow" alt="ipvanish select servers" />

3.  Start a connection.

    Select your preferred server, and click the three-dot icon on the right to start a connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_ipvanish/ipvanish3.png" class="glboxshadow" alt="ipvanish start" />

    Once connected, a green dot will appear next to the configuration file.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_ipvanish/ipvanish4.png" class="glboxshadow" alt="ipvanish connected" />

    And the VPN connection details will be displayed on the **VPN Dashboard**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_ipvanish/ipvanish5.png" class="glboxshadow" alt="ipvanish connection status" />

4.  Update servers.

    You can click **Update Servers** to obtain the latest available server list, avoiding connection failures caused by server maintenance or shutdown.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_ipvanish/ipvanish6.png" class="glboxshadow" alt="ipvanish update servers" />

5.  Edit credentials or logout.

    Click the gear icon to edit your login credentials or log out.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_ipvanish/ipvanish7.png" class="glboxshadow" alt="ipvanish edit credentials or logout" />

6.  Delete All.

    You can click **Delete All** to delete all configuration files with one click, and choose whether to delete the private and public keys simultaneously.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_ipvanish/ipvanish8.png" class="glboxshadow" alt="ipvanish delete" />

## Set Up Mullvad<a href="#set-up-mullvad" class="headerlink" title="Permanent link">¶</a>

<a href="https://mullvad.net/" target="_blank">Mullvad</a> is a VPN service that helps keep your online activity, identity, and location private.

In the web Admin Panel, go to **VPN** -\> **WireGuard Client** -\> **Mullvad**.

1.  Input **Account**, then click **Save and Continue**. It will generate configuration files for each server.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_mullvad/mullvad1.png" class="glboxshadow" alt="mullvad login" />

2.  Select servers.

    Select the server(s) you want to connect to, and click **Apply**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_mullvad/mullvad2.png" class="glboxshadow" alt="mullvad select server" />

3.  Start a connection.

    Select your preferred server, and click the three-dot icon on the right to start a connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_mullvad/mullvad3.png" class="glboxshadow" alt="mullvad start" />

    Once connected, a green dot will appear next to the configuration file.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_mullvad/mullvad4.png" class="glboxshadow" alt="mullvad connected" />

    And the VPN connection details will be displayed on the **VPN Dashboard**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_mullvad/mullvad5.png" class="glboxshadow" alt="mullvad connection status" />

4.  Update servers.

    You can click **Update Servers** to obtain the latest available server list, avoiding connection failures caused by server maintenance or shutdown.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_mullvad/mullvad6.png" class="glboxshadow" alt="mullvad update servers" />

5.  Edit credentials or logout.

    Click the gear icon to edit your login credentials or log out.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_mullvad/mullvad7.png" class="glboxshadow" alt="mullvad edit credentials or logout" />

6.  Go renew.

    If you click **Go Renew**, you will be re-directed to the official website to renew your subscription.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_mullvad/mullvad8.png" class="glboxshadow" alt="mullvad go renew" />

7.  Delete All.

    You can click **Delete All** to delete all configuration files with one click, and choose whether to delete the private and public keys simultaneously.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_mullvad/mullvad9.png" class="glboxshadow" alt="mullvad delete" />

## Set Up NordVPN<a href="#set-up-nordvpn" class="headerlink" title="Permanent link">¶</a>

<a href="https://go.nordvpn.net/aff_c?offer_id=15&amp;aff_id=12016&amp;url_id=902" target="_blank">NordVPN</a> is an online VPN service that combines speed and security.

1.  Click <a href="https://my.nordaccount.com/" target="_blank">here</a> to log in to your NordVPN web account.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nordvpn_login.png" class="glboxshadow" alt="nordvpn" />

    After logging in to the Nord dashboard, click **NordVPN** in the left menu, find the **Access Token** section, then click **Get Access token**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nord_token1.png" class="glboxshadow" alt="nordvpn token" />

    On the next page, click **Generate new token**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nord_token2.png" class="glboxshadow" alt="nordvpn token" />

    In the pop-up window, select token expiration date, then click **Generate token**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nord_token3.png" class="glboxshadow" alt="nordvpn token" />

    You will then get the access token, as shown below. Copy the token for later use.

    **Note**: The access token is only displayed once. Make sure you copy and use it now. After closing this window, the token will no longer be visible. If you fail to save it, you will need to generate a new one.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nord_token4.png" class="glboxshadow" alt="nordvpn token" />

2.  Log in to the router's web Admin Panel, and go to **VPN** -\> **WireGuard Client** -\> **NordVPN**.

    Input **Token**, then click **Save and Continue**. It will generate configuration files for each server.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nordvpn1.png" class="glboxshadow" alt="nordvpn login" />

3.  Select servers.

    Select the server(s) you want to connect to, and click **Apply**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nordvpn2.png" class="glboxshadow" alt="nordvpn select servers" />

4.  Start a connection.

    Select your preferred server, and click the three-dot icon on the right to start a connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nordvpn3.png" class="glboxshadow" alt="nordvpn start" />

    Once connected, a green dot will appear next to the configuration file.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nordvpn4.png" class="glboxshadow" alt="nordvpn connected" />

    And the VPN connection details will be displayed on the **VPN Dashboard**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nordvpn5.png" class="glboxshadow" alt="nordvpn connection status" />

5.  Update servers.

    You can click **Update Servers** to obtain the latest available server list, avoiding connection failures caused by server maintenance or shutdown.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nordvpn6.png" class="glboxshadow" alt="nordvpn update servers" />

6.  Edit credentials or logout.

    Click the gear icon to edit your login credentials or log out.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nordvpn7.png" class="glboxshadow" alt="nordvpn edit credentials or logout" />

7.  Delete All.

    You can click **Delete All** to delete all configuration files with one click, and choose whether to delete the private and public keys simultaneously.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_nordvpn/nordvpn8.png" class="glboxshadow" alt="nordvpn delete" />

## Set Up PIA (Private Internet Access)<a href="#set-up-pia-private-internet-access" class="headerlink" title="Permanent link">¶</a>

<a href="https://privateinternetaccess.com/offer/GLiNET_71dx4t8bl" target="_blank">Official Website</a>

In the web Admin Panel, go to **VPN** -\> **WireGuard Client** -\> **PIA**.

1.  Input **Username** and **Password**, then click **Save and Continue**. It will generate configuration files for each server.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_pia/pia1.png" class="glboxshadow" alt="pia login" />

2.  Select servers.

    Select the server(s) you want to connect to, and click **Apply**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_pia/pia2.png" class="glboxshadow" alt="pia select servers" />

3.  Start a connection.

    Select your preferred server, and click the three-dot icon on the right to start a connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_pia/pia3.png" class="glboxshadow" alt="pia start" />

    Once connected, a green dot will appear next to the configuration file.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_pia/pia4.png" class="glboxshadow" alt="pia connected" />

    And the VPN connection details will be displayed on the **VPN Dashboard**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_pia/pia5.png" class="glboxshadow" alt="pia connection status" />

4.  Update servers.

    You can click **Update Servers** to obtain the latest available server list, avoiding connection failures caused by server maintenance or shutdown.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_pia/pia6.png" class="glboxshadow" alt="pia update servers" />

5.  Edit credentials or logout.

    Click the gear icon to edit your login credentials or log out.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_pia/pia7.png" class="glboxshadow" alt="pia edit credential or logout" />

6.  Delete All.

    You can click **Delete All** to delete all configuration files with one click, and choose whether to delete the private and public keys simultaneously.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_pia/pia8.png" class="glboxshadow" alt="pia delete" />

## Set Up PureVPN<a href="#set-up-purevpn" class="headerlink" title="Permanent link">¶</a>

<a href="https://billing.purevpn.com/aff.php?aff=35535" target="_blank">Official Website</a>

In the web Admin Panel, go to **VPN** -\> **WireGuard Client** -\> **PureVPN**.

1.  Input **Username** and **Password**, then click **Save and Continue**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_purevpn/purevpn1.png" class="glboxshadow" alt="purevpn login" />

    It will generate all available configuration files.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_purevpn/purevpn2.png" class="glboxshadow" alt="purevpn config files" />

2.  Start a connection.

    Select your preferred server, and click the three-dot icon on the right to start a connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_purevpn/purevpn3.png" class="glboxshadow" alt="purevpn start" />

    Once connected, a green dot will appear next to the configuration file.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_purevpn/purevpn4.png" class="glboxshadow" alt="purevpn connected" />

    And the VPN connection details will be displayed on the **VPN Dashboard**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_purevpn/purevpn5.png" class="glboxshadow" alt="purevpn connection status" />

3.  Update servers.

    You can click **Update Servers** to obtain the latest available server list, avoiding connection failures caused by server maintenance or shutdown.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_purevpn/purevpn6.png" class="glboxshadow" alt="purevpn update servers" />

4.  Edit credentials or logout.

    Click the gear icon to edit your login credentials or log out.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_purevpn/purevpn7.png" class="glboxshadow" alt="purevpn edit credential or logout" />

5.  Delete All.

    You can click **Delete All** to delete all configuration files with one click, and choose whether to delete the private and public keys simultaneously.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_purevpn/purevpn8.png" class="glboxshadow" alt="purevpn delete" />

## Set Up Surfshark<a href="#set-up-surfshark" class="headerlink" title="Permanent link">¶</a>

<a href="https://get.surfshark.net/aff_c?offer_id=926&amp;aff_id=1400" target="_blank">Official Website</a>

In the web Admin Panel, go to **VPN** -\> **WireGuard Client** -\> **Surfshark**.

1.  Input **Username** and **Password**, then click **Save and Continue**. It will generate configuration files for each server.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_surfshark/surfshark1.png" class="glboxshadow" alt="surfshark login" />

2.  Select servers.

    Select the server(s) you want to connect to, and click **Apply**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_surfshark/surfshark2.png" class="glboxshadow" alt="surfshark select servers" />

3.  Start a connection.

    Select your preferred server, and click the three-dot icon on the right to start a connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_surfshark/surfshark3.png" class="glboxshadow" alt="surfshark start" />

    Once connected, a green dot will appear next to the configuration file.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_surfshark/surfshark4.png" class="glboxshadow" alt="surfshark connected" />

    And the VPN connection details will be displayed on the **VPN Dashboard**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_surfshark/surfshark5.png" class="glboxshadow" alt="surfshark connection status" />

4.  Update servers.

    You can click **Update Servers** to obtain the latest available server list, avoiding connection failures caused by server maintenance or shutdown.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_surfshark/surfshark6.png" class="glboxshadow" alt="surfshark update servers" />

5.  Edit credentials or logout.

    Click the gear icon to edit your login credentials or log out.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_surfshark/surfshark7.png" class="glboxshadow" alt="surfshark edit credential or logout" />

6.  Refresh.

    You can click **Refresh** to update the public key when the VPN server cannot be connected.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_surfshark/surfshark8.png" class="glboxshadow" alt="surfshark refresh" />

7.  Delete All.

    You can click **Delete All** to delete all configuration files with one click, and choose whether to delete the private and public keys simultaneously.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_surfshark/surfshark9.png" class="glboxshadow" alt="surfshark delete" />

## Set Up Windscribe<a href="#set-up-windscribe" class="headerlink" title="Permanent link">¶</a>

<a href="https://windscribe.com/yo/1u2h9ndl" target="_blank">Official Website</a>

In the web Admin Panel, go to **VPN** -\> **WireGuard Client** -\> **Windscribe**.

1.  Input **Username** and **Password**, then click **Save and Continue**. It will generate configuration files for each server.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe1.png" class="glboxshadow" alt="windscribe login" />

2.  Select servers.

    Select the server(s) you want to connect to, and click **Apply**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe2.png" class="glboxshadow" alt="windscribe select servers" />

    Then you will get a list of configuration files corresponding to the selected server.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe3.png" class="glboxshadow" alt="windscribe config files" />

3.  Start a connection.

    Select your preferred server, and click the three-dot icon on the right to start a connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe4.png" class="glboxshadow" alt="windscribe start" />

    Once connected, a green dot will appear next to the configuration file.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe5.png" class="glboxshadow" alt="windscribe connected" />

    And the VPN connection details will be displayed on the **VPN Dashboard**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe6.png" class="glboxshadow" alt="windscribe connection status" />

4.  Update servers.

    You can click **Update Servers** to obtain the latest available server list, avoiding connection failures caused by server maintenance or shutdown.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe7.png" class="glboxshadow" alt="windscribe update servers" />

5.  Edit credentials or logout.

    Click the gear icon to edit your login credentials or log out.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe8.png" class="glboxshadow" alt="windscribe edit credential or logout" />

6.  Refresh.

    You can click **Refresh** to update the public key when the VPN server cannot be connected.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe9.png" class="glboxshadow" alt="windscribe refresh" />

7.  Delete All.

    You can click **Delete All** to delete all configuration files with one click, and choose whether to delete the private and public keys simultaneously.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_windscribe/windscribe10.png" class="glboxshadow" alt="windscribe delete" />

## Set Up WireGuard Client Manually (for other providers)<a href="#set-up-wireguard-client-manually-for-other-providers" class="headerlink" title="Permanent link">¶</a>

If you are using another WireGuard service provider, you can download the WireGuard configuration files and follow the steps below to set up the WireGuard Client. If you don't know how to download the configuration files, please refer to [this guide](../../tutorials/how_to_get_configuration_files_from_wireguard_service_providers/) or contact their support.

In the web Admin Panel, go to **VPN** -\> **WireGuard Client**.

1.  Click **Add Manually**.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/add_manually.png" class="glboxshadow" alt="add manually" />

2.  It will create a group on the left sidebar.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/create_a_group.png" class="glboxshadow" alt="add a new group" />

3.  Set a descriptive name for the group (e.g., azirevpn). Then upload a configuration file (supported formats: zip, tar, gz, conf, txt) or manually add configuration details (in text form).

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/set_a_name.png" class="glboxshadow" alt="set the new group name" />

    1.  **Upload a configuration file**.

        Click on the upload area to upload your WireGuard configuration file, then click **Apply**.

        <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/upload_configuration_file.png" class="glboxshadow" alt="upload profile" />

        <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/upload_configuration_file_apply.png" class="glboxshadow" alt="after upload profile" />

    2.  **Manually add configuration**.

        Click on **Manually Add Configuration** at the bottom of the upload area.

        <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/manually_add_configuration.png" class="glboxshadow" alt="add wireguard by text" />

        Set a descriptive name, and paste the configuration into the text box. Then click **Apply**.

        <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/text_mode.png" class="glboxshadow" alt="add wireguard by text" /> <span class="small">(Text Mode)</span>

        If you want to verify each item, you can switch to the Item mode and check the config details. Then click **Apply**.

        <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/item_mode.png" class="glboxshadow" alt="add wireguard by item mode" /> <span class="small">(Item Mode)</span>

4.  Click the three-dot icon on the right side to start the connection.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/start_edit_delete.png" class="glboxshadow" alt="start the profile" />

5.  Once connected, you can check the connection status on the **VPN Dashboard** page.

    <img src="https://static.gl-inet.com/docs/router/en/4/interface_guide/wireguard_client/set_up_wireguard_client/vpn_dashboard_wireguard_status.png" class="glboxshadow" alt="vpn dashboard page" />

## Set Up WireGuard Server on GL.iNet Router<a href="#set-up-wireguard-server-on-glinet-router" class="headerlink" title="Permanent link">¶</a>

Do not want to subscribe to third-party VPN services? You may purchase two GL.iNet routers – set one as WireGuard server and the other as WireGuard server.

This is especially suitable for scenarios where your home network's ISP provides a Public IP, and you want to connect to your home network via VPN when away from home to ensure security and access to internal network resources. This eliminates the cost and hassle of continuously subscribing to commercial VPN services.

For WireGuard server setup, please check [here](../wireguard_server/).

------------------------------------------------------------------------

WireGuard® is a registered trademark of Jason A.Donenfeld.

------------------------------------------------------------------------

Still have questions? Visit our <a href="https://forum.gl-inet.com" target="_blank">Community Forum</a> or <a href="https://www.gl-inet.com/contacts/" target="_blank">Contact us</a>.


Back to top


