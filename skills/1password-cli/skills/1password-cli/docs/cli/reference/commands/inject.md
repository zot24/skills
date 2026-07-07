> Source: https://www.1password.dev/cli/reference/commands/inject/



General commands


# inject


Copy page


Copy page


``` shiki
op inject [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
    --file-mode filemode   Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)
-f, --force                Do not prompt for confirmation.
-i, --in-file string       The filename of a template file to inject.
-o, --out-file string      Write the injected template to a file instead of stdout.
```


### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
echo "db_password: {{ op://app-prod/db/password }}" | op inject
db_password: fX6nWkhANeyGE27SQGhYQ
```


``` shiki
cat config.yml.tpl
db_password: {{ op://app-prod/db/password }}
```


``` shiki
op inject -i config.yml.tpl -o config.yml && cat config.yml
db_password: fX6nWkhANeyGE27SQGhYQ
```


``` shiki
echo "db_url: postgres://{{ op://lcl/db/user }}:{{ op://lcl/db/pw }}@{{ op://lcl/db/host }}:{{ op://lcl/db/port }}/{{ op://my-app-prd/db/db }}" | op inject
db_url: postgres://admin:admin@127.0.0.1:5432/my-app"
```


``` shiki
echo "db_password: op://$env/db/password" | env=prod op inject
db_password: fX6nWkhANeyGE27SQGhYQ
```


Was this page helpful?


<a href="/cli/reference/commands/completion" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">completion</span></a><a href="/cli/reference/commands/read" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">read</span></a>


