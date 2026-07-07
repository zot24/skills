> Source: https://www.1password.dev/connect/cli/



Connect server


# Use 1Password CLI with a Connect server


Copy page


Copy page


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>.
- <a href="/connect/get-started#step-2-deploy-1password-connect-server" class="link">Deploy 1Password Connect</a>.
- Make a Connect server accessible to your production environment.
- <a href="/cli/install-server" class="link">Install 1Password CLI in your production environment.</a>
- Set the `OP_CONNECT_HOST` and `OP_CONNECT_TOKEN` environment variables to a Connect server’s credentials in your production environment.

## 


<a href="#get-started" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/reference/commands/run" class="link"><code>op run</code></a>
- <a href="/cli/reference/commands/inject" class="link"><code>op inject</code></a>
- <a href="/cli/reference/commands/read" class="link"><code>op read</code></a>
- <a href="/cli/reference/management-commands/item#item-get" class="link"><code>op item get --format json</code></a>


## 


<a href="#continuous-integration-ci-environments" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#gitlab-ci-example" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
services:
- mysql

variables:
  # Configure mysql service (https://hub.docker.com/_/mysql/)
  MYSQL_DATABASE: op://prod/mysql/database
  MYSQL_USERNAME: op://prod/mysql/username
  MYSQL_PASSWORD: op://prod/mysql/password

connect:
  image: mysql
  script:
  - echo "SELECT 'OK';" | op run -- mysql --user="$MYSQL_USERNAME" --password="$MYSQL_PASSWORD" --host=mysql "$MYSQL_DATABASE"
```


``` shiki
services:
- mysql

variables:
  # Configure mysql service (https://hub.docker.com/_/mysql/)
  MYSQL_DATABASE: op://prod/mysql/database
  MYSQL_USERNAME: op://prod/mysql/username
  MYSQL_PASSWORD: op://prod/mysql/password
  # Configure 1Password CLI to use Connect
  OP_CONNECT_HOST: <Connect host URL>:8080
  OP_CONNECT_TOKEN: token

connect:
  image: mysql
  script:
  - echo "SELECT 'OK';" | mysql --user="$MYSQL_USERNAME" --password="$MYSQL_PASSWORD" --host=mysql "$MYSQL_DATABASE"
```


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/secrets-environment-variables" class="link">Load secrets into the environment</a>
- <a href="/cli/secrets-config-files" class="link">Load secrets into config files</a>
- <a href="/get-started/secure-deployment" class="link">Workflow: Secure your deployments</a>
- <a href="/get-started/build-integrations" class="link">Workflow: Build integrations with 1Password</a>


Was this page helpful?


<a href="/connect/server-configuration" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Configuration</span></a><a href="/connect/sdks/languages/golang" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Go</span></a>


