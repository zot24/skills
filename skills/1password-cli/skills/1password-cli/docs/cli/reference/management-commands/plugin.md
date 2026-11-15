> Source: https://www.1password.dev/cli/reference/management-commands/plugin/



Management commands


# plugin


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_79deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#plugin-clear" class="link">plugin clear</a>: Clear shell plugin configuration
- <a href="#plugin-init" class="link">plugin init</a>: Configure a shell plugin
- <a href="#plugin-inspect" class="link">plugin inspect</a>: Inspect your existing shell plugin configurations
- <a href="#plugin-list" class="link">plugin list</a>: List all available shell plugins
- <a href="#plugin-run" class="link">plugin run</a>: Provision credentials from 1Password and run this command

## <a href="#plugin-clear" class="anchor-link" aria-label="Navigate to header: plugin clear"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">plugin clear</span>


``` shiki
op plugin clear <plugin-executable> [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_h9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
       --all     Clear all configurations for this plugin that apply to this directory
                  and/or terminal session, including the global default.
   -f, --force   Apply immediately without asking for confirmation.
```


- Terminal session default
- Directory default, from the current directory to `$HOME`
- Global default


## <a href="#plugin-init" class="anchor-link" aria-label="Navigate to header: plugin init"></a><span id="_R_t9deehkd74t9_" class="cursor-pointer">plugin init</span>


``` shiki
op plugin init [ <plugin-executable> ] [flags]
```


#### <a href="#configure-your-default-credentials" class="anchor-link" aria-label="Navigate to header: Configure your default credentials"></a><span id="_R_179deehkd74t9_" class="cursor-pointer">Configure your default credentials</span>


``` shiki
echo "source ~/.config/op/plugins.sh" >> ~/.bashrc && source ~/.bashrc
```


#### <a href="#configuration-options" class="anchor-link" aria-label="Navigate to header: Configuration options"></a><span id="_R_1f9deehkd74t9_" class="cursor-pointer">Configuration options</span>


- “Prompt me for each new terminal session” only configures the credentials for the current terminal session. Once you exit the terminal, your default is removed.
- “Use automatically when in this directory or subdirectories” makes your credentials the default in the current directory and all its subdirectories, as long as no other directory-specific defaults are set in them. A terminal-session default takes precedence over a directory-specific one.
- “Use as global default on my system” sets the credentials as the default in all terminal sessions and directories. A directory-specific default takes precedence over a global one.

## <a href="#plugin-inspect" class="anchor-link" aria-label="Navigate to header: plugin inspect"></a><span id="_R_1l9deehkd74t9_" class="cursor-pointer">plugin inspect</span>


``` shiki
op plugin inspect [ <plugin-executable> ] [flags]
```


## <a href="#plugin-list" class="anchor-link" aria-label="Navigate to header: plugin list"></a><span id="_R_1v9deehkd74t9_" class="cursor-pointer">plugin list</span>


``` shiki
op plugin list [flags]
```


## <a href="#plugin-run" class="anchor-link" aria-label="Navigate to header: plugin run"></a><span id="_R_279deehkd74t9_" class="cursor-pointer">plugin run</span>


``` shiki
op plugin run <command>... [flags]
```


Was this page helpful?


