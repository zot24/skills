> Source: https://www.1password.dev/cli/install-server/



Install


# Install 1Password CLI on a server


Copy page


Copy page


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


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI on your machine</a>
- <a href="/get-started/developer-quickstart" class="link">Developer quickstart</a>


Was this page helpful?


<a href="/cli/verify" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Verify installer</span></a><a href="/cli/config-directories" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Set configuration directories</span></a>


