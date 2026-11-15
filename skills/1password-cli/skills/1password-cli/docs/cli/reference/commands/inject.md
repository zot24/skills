> Source: https://www.1password.dev/cli/reference/commands/inject/



General commands


# inject


``` shiki
op inject [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_59deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
    --file-mode filemode   Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)
-f, --force                Do not prompt for confirmation.
-i, --in-file string       The filename of a template file to inject.
-o, --out-file string      Write the injected template to a file instead of stdout.
```


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


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


