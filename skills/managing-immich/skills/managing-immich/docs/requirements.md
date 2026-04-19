<!-- Source: https://docs.immich.app/install/requirements -->

# Immich Installation Requirements

## Hardware Requirements

### Operating System
- Recommended: Linux or *nix 64-bit operating system (Ubuntu, Debian, etc)
- Non-Linux systems provide poor Docker experiences and receive limited support
- Windows users may utilize Docker Desktop or WSL 2
- macOS users can use Docker Desktop for Mac
- Docker in LXC containers is not recommended; full virtual machines are preferred

### Memory
- Minimum: 6GB RAM
- Recommended: 8GB RAM
- Systems with only 4GB can run Immich with machine learning features disabled

### Processor
- Minimum: 2 cores
- Recommended: 4 cores
- Supports `amd64` and `arm64` platforms
- The machine learning container on amd64 requires >= x86-64-v2 microarchitecture level (most CPUs from ~2012 onward)

### Storage
- Use Unix-compatible filesystems: EXT4, ZFS, APFS, etc.
- Filesystem must support user/group ownership and permissions
- Thumbnails and transcoded video can increase library size by 10-20%
- PostgreSQL database requires local SSD storage (1-3GB typical)
- Never use network shares for database storage

## Software Requirements

### Docker
- Docker Engine for Linux servers or Windows via WSL2
- Docker Desktop available for Windows/macOS (not recommended for Linux)
- Requires Docker Compose plugin (not deprecated `docker-compose`)

## Windows-Specific Considerations

The PostgreSQL database must reside on a filesystem supporting ownership/permissions (EXT2/3/4, ZFS, APFS, BTRFS, XFS). NTFS, exFAT, and FAT32 are incompatible. WSL mounted directories under `/mnt` don't work; Docker volumes are an alternative solution.
