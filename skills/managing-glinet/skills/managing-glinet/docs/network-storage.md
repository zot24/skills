<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/network_storage -->

# Network Storage

Access via **APPLICATIONS → Network Storage**. Share USB drives, SD cards, or external HDDs across the network.

## Supported Formats
NTFS, FAT32, EXT4

## Sharing Protocols

### Samba (SMB)
1. Enable Samba → Apply
2. Quick Setup Share → create user credentials
3. Select folders/disk to share
4. Set permissions (disable anonymous access)
5. Access: `\\192.168.8.1\share` (Windows) or `smb://192.168.8.1/share` (macOS/Linux)
- Optional: Allow Access Samba from WAN

### WebDAV
1. Enable WebDAV → Apply
2. Select HTTP or HTTPS (self-signed cert)
3. Configure port (default OK, range 1024-65535)
4. Quick Setup Share → create user → select folders
- Optional: Allow Access WebDAV from WAN

### DLNA
Toggle Enable DLNA → Apply. Smart TVs on the network auto-discover the server.

## Client Access

| Platform | Samba | WebDAV |
|----------|-------|--------|
| Windows | File Explorer → Add network location | RaiDrive, Cyberduck |
| macOS | Finder → Go → Connect to Server | Cyberduck, FE File Explorer |
| Android | Cx File Explorer | Cx File Explorer |
| iOS | Native Files app | Documents app |

## Notes
- USB hard drives need external power supply (high consumption)
- Admin panel manages shared folders only; use mobile app for file management
- Models with ≤32MB flash don't support this feature
