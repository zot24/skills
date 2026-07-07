> Source: https://www.1password.dev/cli/environment-variables/



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Concepts


1Password CLI environment variables


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Concepts


# 1Password CLI environment variables


Copy page


Copy page


| Environment variable          | Description                                                                                                                                                                                                                                                                                                                      |
|-------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `OP_ACCOUNT`                  | Specifies a default 1Password account to execute commands. Accepts an <a href="/cli/use-multiple-accounts#find-an-account-sign-in-address-or-id" class="link">account sign-in address or ID</a>. An account specified with the `--account` flag takes precedence.                                                                |
| `OP_BIOMETRIC_UNLOCK_ENABLED` | Toggles the <a href="/cli/app-integration#optional-set-the-biometric-unlock-environment-variable" class="link">1Password app integration</a> on or off. Options: `true`, `false`.                                                                                                                                                |
| `OP_CACHE`                    | Toggles the option to <a href="/cli/reference#cache-item-and-vault-information" class="link">store and use cached information</a> on or off. Options: `true`, `false`. Default: `true`.                                                                                                                                          |
| `OP_CONFIG_DIR`               | Specifies a <a href="/cli/config-directories" class="link">configuration directory</a> to read and write to. A directory specified with the `--config` flag takes precedence.                                                                                                                                                    |
| `OP_CONNECT_HOST`             | Sets a <a href="/connect/cli" class="link">Connect server instance host URL</a> to use with 1Password CLI.                                                                                                                                                                                                                       |
| `OP_CONNECT_TOKEN`            | Sets a <a href="/connect/cli" class="link">Connect server token</a> to use with 1Password CLI.                                                                                                                                                                                                                                   |
| `OP_DEBUG`                    | Toggles debug mode on or off. Options: `true`, `false`. Default: `false`.                                                                                                                                                                                                                                                        |
| `OP_FORMAT`                   | Sets the output format for 1Password CLI commands. Options: `human-readable`, `json`. Default: `human-readable`.                                                                                                                                                                                                                 |
| `OP_INCLUDE_ARCHIVE`          | Allows items in the archive to be retrieved with <a href="/cli/reference/management-commands/item#item-get" class="link"><code>op item get</code></a> and <a href="/cli/reference/management-commands/document#document-get" class="link"><code>op document get</code></a> commands. Options: `true`, `false`. Default: `false`. |
| `OP_ISO_TIMESTAMPS`           | Toggles the option to format timestamps according to ISO 8601 and RFC 3339 standards on or off. Options: `true`, `false`. Default: `false`.                                                                                                                                                                                      |
| `OP_RUN_NO_MASKING`           | Toggles masking off for the output of <a href="/cli/reference/commands/run" class="link"><code>op run</code></a>.                                                                                                                                                                                                                |
| `OP_SESSION`                  | Stores a session token when you <a href="/cli/sign-in-manually" class="link">sign in to 1Password CLI manually</a>.                                                                                                                                                                                                              |
| `OP_SERVICE_ACCOUNT_TOKEN`    | Configures 1Password CLI to <a href="/service-accounts/use-with-1password-cli" class="link">authenticate with a service account</a>.                                                                                                                                                                                             |


Was this page helpful?


<a href="/cli/reference/commands/whoami" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">whoami</span></a><a href="/cli/item-fields" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Item fields</span></a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


