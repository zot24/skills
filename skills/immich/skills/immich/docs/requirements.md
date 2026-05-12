> Source: https://docs.immich.app/install/requirements



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_m5m7">Skip to main content</a>


On this page


# Requirements


Hardware and software requirements for Immich:

## Hardware<a href="#hardware" class="hash-link" aria-label="Direct link to Hardware" translate="no" title="Direct link to Hardware">​</a>

- **OS**: Recommended Linux or \*nix 64-bit operating system (Ubuntu, Debian, etc).
  - Non-Linux OSes tend to provide a poor Docker experience and are strongly discouraged. Our ability to assist with setup or troubleshooting on non-Linux OSes will be severely reduced. If you still want to try to use a non-Linux OS, you can set it up as follows:
    - Windows: <a href="https://docs.docker.com/desktop/install/windows-install/" target="_blank" rel="noopener noreferrer">Docker Desktop on Windows</a> or <a href="https://docs.docker.com/desktop/wsl/" target="_blank" rel="noopener noreferrer">WSL 2</a>.
    - macOS: <a href="https://docs.docker.com/desktop/install/mac-install/" target="_blank" rel="noopener noreferrer">Docker Desktop on Mac</a>.
  - Immich runs well in a virtualized environment when running in a full virtual machine. The use of Docker in LXC containers is <a href="https://pve.proxmox.com/wiki/Linux_Container" target="_blank" rel="noopener noreferrer">not recommended</a>, but may be possible for advanced users. If you have issues, we recommend that you switch to a supported VM deployment.
- **RAM**: Minimum 6GB, recommended 8GB.
- **CPU**: Minimum 2 cores, recommended 4 cores.
  - Immich runs on the `amd64` and `arm64` platforms. Since `v2.6`, the machine learning container on `amd64` requires the `>= x86-64-v2` <a href="https://en.wikipedia.org/wiki/X86-64#Microarchitecture_levels" target="_blank" rel="noopener noreferrer">microarchitecture level</a>. Most CPUs released since ~2012 support this microarchitecture. If you are using a virtual machine, ensure you have selected a <a href="https://pve.proxmox.com/pve-docs/chapter-qm.html#_qemu_cpu_types" target="_blank" rel="noopener noreferrer">supported microarchitecture</a>.
- **Storage**: Recommended Unix-compatible filesystem (EXT4, ZFS, APFS, etc.) with support for user/group ownership and permissions.
  - The generation of thumbnails and transcoded video can increase the size of the photo library by 10-20% on average.


For a smooth experience, especially during asset upload, Immich requires at least 6GB of RAM. For systems with only 4GB of RAM, Immich can be run with machine learning features disabled.


Good performance and a stable connection to the Postgres database is critical to a smooth Immich experience. The Postgres database files are typically between 1-3 GB in size. For this reason, the Postgres database (`DB_DATA_LOCATION`) should ideally use local SSD storage, and never a network share of any kind. Additionally, if Docker resource limits are used, the Postgres database requires at least 2GB of RAM. Windows users may run into issues with non-Unix-compatible filesystems, see below for more details.


## Software<a href="#software" class="hash-link" aria-label="Direct link to Software" translate="no" title="Direct link to Software">​</a>

Immich requires <a href="https://docs.docker.com/get-started/get-docker/" target="_blank" rel="noopener noreferrer"><strong>Docker</strong></a> with the **Docker Compose plugin**:

- **Docker Engine**: This CLI variant is designed for Linux servers (or Windows via WSL2).
- **Docker Desktop**: This GUI variant is **not recommended** for Linux, but is available for Windows or macOS.

The Compose plugin will be installed by both Docker Engine and Desktop by following the linked installation guides; it can also be <a href="https://docs.docker.com/compose/install/" target="_blank" rel="noopener noreferrer">separately installed</a>.


Immich requires the command `docker compose`; the similarly named `docker-compose` is <a href="https://docs.docker.com/retired/#docker-compose-v1-replaced-by-compose-v2" target="_blank" rel="noopener noreferrer">deprecated</a> and is no longer supported by Immich.


### Special requirements for Windows users<a href="#special-requirements-for-windows-users" class="hash-link" aria-label="Direct link to Special requirements for Windows users" translate="no" title="Direct link to Special requirements for Windows users">​</a>

Database storage on Windows systems


The Immich Postgres database (`DB_DATA_LOCATION`) must be located on a filesystem that supports user/group ownership and permissions (EXT2/3/4, ZFS, APFS, BTRFS, XFS, etc.). It will not work on any filesystem formatted in NTFS or ex/FAT/32. It will not work in WSL (Windows Subsystem for Linux) when using a mounted host directory (commonly under `/mnt`). If this is an issue, you can change the bind mount to a Docker volume instead as follows:

Make the following change to `.env`:


``` prism-code
- DB_DATA_LOCATION=./postgres
+ DB_DATA_LOCATION=pgdata
```


Add the following line to the bottom of `docker-compose.yml`:


``` prism-code
volumes:
  model-cache:
+ pgdata:
```


- <a href="#hardware" class="table-of-contents__link toc-highlight">Hardware</a>
- <a href="#software" class="table-of-contents__link toc-highlight">Software</a>
  - <a href="#special-requirements-for-windows-users" class="table-of-contents__link toc-highlight">Special requirements for Windows users</a>


