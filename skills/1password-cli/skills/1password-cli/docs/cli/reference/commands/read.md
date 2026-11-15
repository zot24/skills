> Source: https://www.1password.dev/cli/reference/commands/read/



General commands


# read


``` shiki
op read <reference> [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_79deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
    --file-mode filemode   Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)
-f, --force                Do not prompt for confirmation.
-n, --no-newline           Do not print a new line after the secret.
-o, --out-file string      Write the secret to a file instead of stdout.
```


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_b9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op read op://app-prod/db/password
```


``` shiki
op read "op://app-prod/db/one-time password?attribute=otp"
```


``` shiki
op read "op://app-prod/ssh key/private key?ssh-format=openssh"
```


``` shiki
op read --out-file ./key.pem op://app-prod/server/ssh/key.pem
```


``` shiki
op read --out-file ./config.yml op://app-prod/server/config.yml
```


``` shiki
docker login -u $(op read op://prod/docker/username) -p $(op read op://prod/docker/password)
```


Was this page helpful?


