> Source: https://www.1password.dev/cli/environment-variables/



Concepts


# 1Password CLI environment variables


Copy page


Copy page


| Environment variable | Description |
|----|----|
| `OP_ACCOUNT` | Specifies a default 1Password account to execute commands. Accepts an <a href="/cli/use-multiple-accounts#find-an-account-sign-in-address-or-id" class="link">account sign-in address or ID</a>. An account specified with the `--account` flag takes precedence. |
| `OP_BIOMETRIC_UNLOCK_ENABLED` | Toggles the <a href="/cli/app-integration#optional-set-the-biometric-unlock-environment-variable" class="link">1Password app integration</a> on or off. Options: `true`, `false`. |
| `OP_CACHE` | Toggles the option to <a href="/cli/reference#cache-item-and-vault-information" class="link">store and use cached information</a> on or off. Options: `true`, `false`. Default: `true`. |
| `OP_CONFIG_DIR` | Specifies a <a href="/cli/config-directories" class="link">configuration directory</a> to read and write to. A directory specified with the `--config` flag takes precedence. |
| `OP_CONNECT_HOST` | Sets a <a href="/connect/cli" class="link">Connect server instance host URL</a> to use with 1Password CLI. |
| `OP_CONNECT_TOKEN` | Sets a <a href="/connect/cli" class="link">Connect server token</a> to use with 1Password CLI. |
| `OP_DEBUG` | Toggles debug mode on or off. Options: `true`, `false`. Default: `false`. |
| `OP_FORMAT` | Sets the output format for 1Password CLI commands. Options: `human-readable`, `json`. Default: `human-readable`. |
| `OP_INCLUDE_ARCHIVE` | Allows items in the archive to be retrieved with <a href="/cli/reference/management-commands/item#item-get" class="link"><code>op item get</code></a> and <a href="/cli/reference/management-commands/document#document-get" class="link"><code>op document get</code></a> commands. Options: `true`, `false`. Default: `false`. |
| `OP_ISO_TIMESTAMPS` | Toggles the option to format timestamps according to ISO 8601 and RFC 3339 standards on or off. Options: `true`, `false`. Default: `false`. |
| `OP_RUN_NO_MASKING` | Toggles masking off for the output of <a href="/cli/reference/commands/run" class="link"><code>op run</code></a>. |
| `OP_SESSION` | Stores a session token when you <a href="/cli/sign-in-manually" class="link">sign in to 1Password CLI manually</a>. |
| `OP_SERVICE_ACCOUNT_TOKEN` | Configures 1Password CLI to <a href="/service-accounts/use-with-1password-cli" class="link">authenticate with a service account</a>. |


Was this page helpful?


<a href="/cli/reference/commands/whoami" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">whoami</span></a><a href="/cli/item-fields" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Item fields</span></a>


