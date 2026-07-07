> Source: https://raw.githubusercontent.com/wiki/AdguardTeam/AdGuardHome/VPS.md

 # How to install and run AdGuard Home on a virtual private server (VPS)

 >  [!WARNING]
 >  This article is outdated.  See [*Getting started*][kb-start] and [*Running securely*][kb-sec] in our Knowledge Base.

[kb-sec]:   https://adguard-dns.io/kb/adguard-home/running-securely/
[kb-start]: https://adguard-dns.io/kb/adguard-home/getting-started/



To run AdGuard Home on a VPS, you need a server with Debian 8 or 9, x64 or x32.

>Among possible solutions are [Vultr](https://www.vultr.com/), [1&1](https://www.1and1.co.uk/dynamic-cloud-server#configure-server), [Cloudways](https://www.cloudways.com/), [HostGator](https://hostgator.com/), [Digital Ocean](https://www.digitalocean.com/), [Bytemark](https://www.bytemark.co.uk/cloud-hosting/) and many more. AdGuard is not affiliated with any of these or other VPS services.

## Initial installation

First let's ensure that your VPS has necessary minimal requirements, run this as root:
```sh
apt-get install sudo nano bind9-host
```

Go to [AdGuard Home page](https://github.com/AdguardTeam/AdGuardHome#installation) and download binaries for your architecture (64-bit Linux in this example).

To download AdGuard Home and unpack it execute following commands:
```sh
wget https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz
tar xvf AdGuardHome_linux_amd64.tar.gz
```

You can find out the directory where you've unpacked it to by running these commands:
```sh
cd AdGuardHome
pwd
```

Run `sudo ./AdGuardHome -s install` to install AdGuard Home as a system service.

Here are the other commands you might need to control the service.

* `AdGuardHome -s uninstall` - uninstalls the AdGuard Home service.
* `AdGuardHome -s start` - starts the service.
* `AdGuardHome -s stop` - stops the service.
* `AdGuardHome -s restart` - restarts the service.
* `AdGuardHome -s status` - shows the current service status.

You can verify that it's working properly by running this command:
```sh
host doubleclick.net 127.0.0.1
```

If everything works correctly, you will get this output:
```none
Using domain server:
Name: 127.0.0.1
Address: 127.0.0.1#53
Aliases:

Host doubleclick.net not found: 3(NXDOMAIN)
```

## Visit the web interface
You can access your AdGuard Home web interface on port 3000 by typing this in your browser — `http://1.2.3.4:3000/`

Replace 1.2.3.4 with the IP address of your VPS.

## Configure your devices to use your AdGuard Home

Now, once you've established that AdGuard Home works on your VPS, you can use it on your machine by changing system DNS settings to use your VPS's public IP address.
