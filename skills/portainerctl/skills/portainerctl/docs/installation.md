<!-- Source: https://github.com/portainer/portainerctl/blob/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md (Installation, Building release binaries, Supported Portainer version)

# Installation & Build

`portainerctl` is a full-featured CLI for **Portainer Business Edition 2.39.1**, written in Go. It talks to a Portainer server over its REST API.

## Download a binary (recommended)

Grab the latest release for your platform from the [Releases](https://github.com/portainer/portainerctl/releases) page.

```bash
# Linux amd64
curl -L https://github.com/portainer/portainerctl/releases/latest/download/portainerctl_linux_amd64.tar.gz | tar xz
sudo mv portainerctl /usr/local/bin/
```

The release workflow publishes signed binaries for **Linux, macOS, and Windows** on **amd64, arm64, and armv7** on every tag push.

## Build from source

Requires **Go 1.22+**.

```bash
git clone https://github.com/portainer/portainerctl.git
cd portainerctl
go mod tidy
go build -o portainerctl .
```

## Building release binaries

Requires [GoReleaser](https://goreleaser.com/) installed.

```bash
# Local snapshot build (no GitHub token needed)
goreleaser release --snapshot --clean

# Tagged release — handled automatically by the included GitHub Actions workflow
git tag v0.1.0
git push origin v0.1.0
```

The workflow at `.github/workflows/release.yml` produces signed binaries for Linux, macOS, and Windows on amd64, arm64, and armv7 on every tag push.

## Supported Portainer version

Portainer Business Edition **2.39.1** (`portaineree`).

The CLI targets this version specifically. **BE-only endpoints** (licensing, RBAC roles, edge compute, policies, observability, cloud credentials) will return **403 on CE installs**.

## License

MIT.
