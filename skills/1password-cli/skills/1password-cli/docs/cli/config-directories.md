> Source: https://www.1password.dev/cli/config-directories/



Install


# How 1Password CLI detects configuration directories


Copy page


Copy page


- `${XDG_CONFIG_HOME}/op` when `${XDG_CONFIG_HOME}` is set
- `~/.config/op` when `${XDG_CONFIG_HOME}` is not set


1.  A directory specified with `--config`
2.  A directory set with the `OP_CONFIG_DIR` environment variable.
3.  `~/.op` (following <a href="https://github.com/mitchellh/go-homedir" class="link" target="_blank" rel="noreferrer">go-homedir</a> to determine the home directory)
4.  `${XDG_CONFIG_HOME}/.op`
5.  `~/.config/op` (following <a href="https://github.com/mitchellh/go-homedir" class="link" target="_blank" rel="noreferrer">go-homedir</a> to determine the home directory)
6.  `${XDG_CONFIG_HOME}/op`


Was this page helpful?


<a href="/cli/install-server" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Install on a server</span></a><a href="/cli/app-integration" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Sign in using the app</span></a>


