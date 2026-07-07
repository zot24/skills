> Source: https://www.1password.dev/cli/reference/commands/signin/



General commands


# signin


Copy page


Copy page


``` shiki
op signin [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
-f, --force   Ignore warnings and print raw output from this command.
    --raw     Only return the session token.
```


1.  Open the 1Password app.
2.  Navigate to **Settings** \> **Security** and turn on Touch ID, Windows Hello, or a Linux system authentication option.
3.  Navigate to **Developer** \> **Settings** and select **Integrate with 1Password CLI**.


1.  The account specified with the `--account` flag.
2.  The account specified by the `OP_ACCOUNT` environment variable.
3.  The account you most recently signed in to with `op signin` in any terminal window.


### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
eval $(op signin --account acme.1password.com)
```


Was this page helpful?


<a href="/cli/reference/commands/run" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">run</span></a><a href="/cli/reference/commands/signout" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">signout</span></a>


