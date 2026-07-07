> Source: https://www.1password.dev/cli/reference/commands/read/



General commands


# read


Copy page


Copy page


``` shiki
op read <reference> [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
    --file-mode filemode   Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)
-f, --force                Do not prompt for confirmation.
-n, --no-newline           Do not print a new line after the secret.
-o, --out-file string      Write the secret to a file instead of stdout.
```


### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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
docker login -u $(op read op://prod/docker/username) -p $(op read op://prod/docker/password)
```


Was this page helpful?


<a href="/cli/reference/commands/inject" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">inject</span></a><a href="/cli/reference/commands/run" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">run</span></a>


