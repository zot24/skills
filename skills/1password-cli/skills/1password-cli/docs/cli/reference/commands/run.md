> Source: https://www.1password.dev/cli/reference/commands/run/



General commands


# run


Copy page


Copy page


``` shiki
op run -- <command> <command>... [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--env-file stringArray   Enable Dotenv integration with specific Dotenv files to
                         parse. For example: --env-file=.env.
--no-masking             Disable masking of secrets on stdout and stderr.
```


#### 


<a href="#load-secrets-using-secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


#### 


<a href="#load-variables-from-environments-beta" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op run --environment <environment-uuid> -- printenv
```


#### 


<a href="#environment-variable-precedence" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  1Password Environments (—environment)
2.  Environment files (—env-file)
3.  Shell environment variables


### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


<a href="/cli/reference/commands/read" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">read</span></a><a href="/cli/reference/commands/signin" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">signin</span></a>


