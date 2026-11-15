> Source: https://www.1password.dev/cli/reference/commands/signin/



General commands


# signin


``` shiki
op signin [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_59deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


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


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
eval $(op signin --account acme.1password.com)
```


Was this page helpful?


