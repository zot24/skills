> Source: https://www.1password.dev/cli/reference/commands/run/



General commands


# run


``` shiki
op run -- <command> <command>... [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_59deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--env-file stringArray   Enable Dotenv integration with specific Dotenv files to
                         parse. For example: --env-file=.env.
--environment strings    Load environment variables from one or more 1Password
                         Environments by ID. If the same secret exists in 
                         multiple Environments, the last one takes precedence.
  -h, --help             Help for run
--no-masking             Disable masking of secrets on stdout and stderr.
```


#### <a href="#load-secrets-using-secret-references" class="anchor-link" aria-label="Navigate to header: Load secrets using secret references"></a><span id="_R_h9deehkd74t9_" class="cursor-pointer">Load secrets using secret references</span>


#### <a href="#load-variables-from-environments" class="anchor-link" aria-label="Navigate to header: Load variables from Environments"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">Load variables from Environments</span>


``` shiki
op run --environment <environment-uuid> -- printenv
```


#### <a href="#environment-variable-precedence" class="anchor-link" aria-label="Navigate to header: Environment variable precedence"></a><span id="_R_159deehkd74t9_" class="cursor-pointer">Environment variable precedence</span>


1.  1Password Environments (—environment)
2.  Environment files (—env-file)
3.  Shell environment variables


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_1f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
export DB_PASSWORD="op://app-prod/db/password"
```


``` shiki
op run -- printenv DB_PASSWORD
<concealed by 1Password>
```


``` shiki
op run --no-masking -- printenv DB_PASSWORD
fX6nWkhANeyGE27SQGhYQ
```


``` shiki
echo "DB_PASSWORD=op://app-dev/db/password" > .env
```


``` shiki
op run --env-file="./.env" -- printenv DB_PASSWORD
password
```


``` shiki
cat .env
DB_USERNAME = op://$APP_ENV/db/username
DB_PASSWORD = op://$APP_ENV/db/password
```


``` shiki
export APP_ENV="dev"
op run --env-file="./.env" -- printenv DB_PASSWORD
dev
```


``` shiki
export APP_ENV="prod"
op run --env-file="./.env" -- printenv DB_PASSWORD
prod
```


Was this page helpful?


