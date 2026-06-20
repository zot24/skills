<!-- Source: https://www.1password.dev/connect/cli/ -->

# Use 1Password CLI with a Connect Server

You can leverage 1Password CLI alongside a Connect server to provision and retrieve secrets from the command line. This is the recommended authentication method for self-hosted production infrastructure.

## Prerequisites

To get started, you'll need:

* An active 1Password subscription
* A deployed 1Password Connect server
* Network access from your production environment to the Connect server
* 1Password CLI installed in your production environment
* Two environment variables configured: `OP_CONNECT_HOST` and `OP_CONNECT_TOKEN`

## Configuration

```shell
export OP_CONNECT_HOST=<your-connect-host-url>:8080
export OP_CONNECT_TOKEN=<your-connect-token>
```

The presence of `OP_CONNECT_HOST` and `OP_CONNECT_TOKEN` directs 1Password CLI to authenticate through your Connect server. These variables take precedence over a service account token.

## Supported Commands

These CLI commands work with Connect servers:

* `op run`
* `op inject`
* `op read`
* `op item get --format json`

Connect supports secret references only (not 1Password Environments).

## CI/CD Integration

1Password CLI integrates with CI pipelines through secret references, substituting actual secret values with structured references in infrastructure-as-code tooling and CI configs.

### GitLab CI Example

```yaml
services:
- mysql

variables:
  MYSQL_DATABASE: op://prod/mysql/database
  MYSQL_USERNAME: op://prod/mysql/username
  MYSQL_PASSWORD: op://prod/mysql/password
  OP_CONNECT_HOST: <Connect host URL>:8080
  OP_CONNECT_TOKEN: token

connect:
  image: mysql
  script:
  - echo "SELECT 'OK';" | mysql --user="$MYSQL_USERNAME" --password="$MYSQL_PASSWORD" --host=mysql "$MYSQL_DATABASE"
```

## Additional Resources

* [Secret references](/cli/secret-references/)
* [Load secrets into the environment](/cli/secrets-environment-variables/)
* [Load secrets into config files](/cli/secrets-config-files/)
