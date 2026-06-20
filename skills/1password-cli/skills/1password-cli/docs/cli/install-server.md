<!-- Source: https://www.1password.dev/cli/install-server/ -->

# Install 1Password CLI on a Server

For headless servers and CI runners, install 1Password CLI directly and authenticate with a service account token (`OP_SERVICE_ACCOUNT_TOKEN`) or a Connect server (`OP_CONNECT_HOST` / `OP_CONNECT_TOKEN`).

## Installation Methods

### Linux Installation

For Linux `amd64` systems, use this command to install 1Password CLI:

```shell
ARCH="amd64"; \
    OP_VERSION="v$(curl https://app-updates.agilebits.com/check/1/0/CLI2/en/2.0.0/N -s | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')"; \
    curl -sSfo op.zip \
    https://cache.agilebits.com/dist/1P/op2/pkg/"$OP_VERSION"/op_linux_"$ARCH"_"$OP_VERSION".zip \
    && unzip -od /usr/local/bin/ op.zip \
    && rm op.zip
```

### Docker Installation

Pull the official 1Password CLI 2 Docker image:

```shell
docker pull 1password/op:2
```

To integrate the CLI into a Dockerfile:

```dockerfile
COPY --from=1password/op:2 /usr/local/bin/op /usr/local/bin/op
```

## Additional Resources

- [Install 1Password CLI on your machine](/cli/get-started/#step-1-install-1password-cli)
- [Use service accounts with 1Password CLI](/service-accounts/use-with-1password-cli/)
- [Use 1Password CLI with a Connect server](/connect/cli/)
