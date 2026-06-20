<!-- Source: https://www.1password.dev/cli/secrets-config-files/ -->

# Load Secrets Into Config Files

1Password CLI enables automatic secret injection into configuration files using secret references, allowing you to maintain plaintext-free configs in source control while keeping them synchronized across development and production environments.

## Prerequisites

Before implementing this approach, you'll need:

1. An active 1Password account
2. 1Password CLI installed on your system
3. Secrets stored within your 1Password vault

## Obtaining Secret References

You can retrieve secret references through multiple methods:

- The 1Password desktop application
- 1Password for VS Code extension
- 1Password CLI using `op item get`
- Manual creation following the syntax rules

## Template Configuration

Replace plaintext secrets with secret references in your config files. For example, transform this:

```yaml
database:
    host: http://localhost
    port: 5432
    username: mysql-user
    password: piG1rX5P1QMF6J5k7u7sNb
```

Into a templated version:

```yaml
database:
    host: http://localhost
    port: 5432
    username: op://prod/mysql/username
    password: op://prod/mysql/password
```

## Secret Injection

Use the `op inject` command to resolve secret references:

```zsh
op inject -i config.yml.tpl -o config.yml
```

> **Important:** Delete the resolved output file once it's no longer needed.

## Environment-Specific Configurations

Leverage environment variables in templates for multi-environment deployments:

```yaml
database:
    username: op://$APP_ENV/mysql/username
    password: op://$APP_ENV/mysql/password
```

Then inject with the appropriate environment:

```shell
APP_ENV=prod op inject -i config.yml.tpl -o config.yml
```

## Production Implementation

For production environments, deploy 1Password Connect Server and configure CLI with `OP_CONNECT_HOST` and `OP_CONNECT_TOKEN` environment variables. Compatible commands include `op run`, `op inject`, `op read`, and `op item get`.
