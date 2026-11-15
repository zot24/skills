> Source: https://www.1password.dev/cli/install-server/



Install


# Install 1Password CLI on a server


``` shiki
ARCH="amd64"; \
    OP_VERSION="v$(curl https://app-updates.agilebits.com/check/1/0/CLI2/en/2.0.0/N -s | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')"; \
    curl -sSfo op.zip \
    https://cache.agilebits.com/dist/1P/op2/pkg/"$OP_VERSION"/op_linux_"$ARCH"_"$OP_VERSION".zip \
    && unzip -od /usr/local/bin/ op.zip \
    && rm op.zip
```


``` shiki
docker pull 1password/op:2
```


``` shiki
COPY --from=1password/op:2 /usr/local/bin/op /usr/local/bin/op
```


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_f9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/get-started/#step-1-install-1password-cli" class="link">Install 1Password CLI on your machine</a>


Was this page helpful?


