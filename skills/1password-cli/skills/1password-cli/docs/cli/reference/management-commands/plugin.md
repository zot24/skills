> Source: https://www.1password.dev/cli/reference/management-commands/plugin/



Management commands


# plugin


Copy page


Copy page


### 


<a href="#subcommands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#plugin-clear" class="link">plugin clear</a>: Clear shell plugin configuration
- <a href="#plugin-init" class="link">plugin init</a>: Configure a shell plugin
- <a href="#plugin-inspect" class="link">plugin inspect</a>: Inspect your existing shell plugin configurations
- <a href="#plugin-list" class="link">plugin list</a>: List all available shell plugins
- <a href="#plugin-run" class="link">plugin run</a>: Provision credentials from 1Password and run this command

## 


<a href="#plugin-clear" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op plugin clear <plugin-executable> [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
      --all     Clear all configurations for this plugin that apply to this directory
                  and/or terminal session, including the global default.
   -f, --force   Apply immediately without asking for confirmation.
```


- Terminal session default
- Directory default, from the current directory to `$HOME`
- Global default


## 


<a href="#plugin-init" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op plugin init [ <plugin-executable> ] [flags]
```


#### 


<a href="#configure-your-default-credentials" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
echo "source ~/.config/op/plugins.sh" >> ~/.bashrc && source ~/.bashrc
```


#### 


<a href="#configuration-options" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- “Prompt me for each new terminal session” only configures the credentials for the current terminal session. Once you exit the terminal, your default is removed.
- “Use automatically when in this directory or subdirectories” makes your credentials the default in the current directory and all its subdirectories, as long as no other directory-specific defaults are set in them. A terminal-session default takes precedence over a directory-specific one.
- “Use as global default on my system” sets the credentials as the default in all terminal sessions and directories. A directory-specific default takes precedence over a global one.

## 


<a href="#plugin-inspect" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op plugin inspect [ <plugin-executable> ] [flags]
```


## 


<a href="#plugin-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op plugin list [flags]
```


## 


<a href="#plugin-run" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op plugin run <command>... [flags]
```


Was this page helpful?


<a href="/cli/reference/management-commands/item" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">item</span></a><a href="/cli/reference/management-commands/service-account" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">service-account</span></a>


