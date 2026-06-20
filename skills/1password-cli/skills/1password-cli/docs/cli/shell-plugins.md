<!-- Source: https://www.1password.dev/cli/shell-plugins/ -->

# 1Password Shell Plugins: Secure CLI Authentication

## Overview

1Password Shell Plugins enable secure authentication for third-party command-line tools using biometric verification. Rather than manually entering credentials or storing them in plaintext, users can leverage their fingerprint, Apple Watch, or system authentication to unlock CLI access.

> "Your CLI credentials are stored in your 1Password account, so you never have to manually enter your credentials or store them in plaintext."

## Supported Shells

Shell plugins are compatible with:
- Bash
- Zsh
- fish

## How It Works

Use the `op plugin` command to set up and manage shell plugins:

```shell
op plugin init <tool>     # Configure a plugin for a CLI (e.g. op plugin init aws)
op plugin run -- <cmd>     # Run a command through a configured plugin
op plugin list             # List configured plugins
op plugin clear            # Clear stored plugin credentials
op plugin inspect <tool>   # Inspect a plugin's configuration
```

After running `op plugin init <tool>`, 1Password adds an alias to a plugins file (typically `~/.config/op/plugins.sh`) and prompts you to source it from your shell profile:

```shell
source ~/.config/op/plugins.sh
```

Once configured, running the tool (e.g. `aws s3 ls`) prompts 1Password to inject the stored credential after biometric unlock, scoped to the directory or globally as chosen during init.

## Available Integrations

The platform supports 80+ third-party CLI tools across multiple categories:

**Cloud & Infrastructure:** AWS, AWS CDK Toolkit, Eksctl, AWS SAM CLI, DigitalOcean, Hetzner Cloud, Linode, Vultr, Scaleway, Cloudflare Workers

**DevOps & CI/CD:** Terraform, Pulumi, Argo CD, CircleCI, GitHub, GitLab, Gitea, HashiCorp Vault

**Databases:** PostgreSQL, MySQL, MongoDB Atlas, InfluxDB, Snowflake, YugabyteDB, Vertica

**Development Tools:** Cargo, Homebrew, Kaggle, HuggingFace, Snyk, Sentry, Claude Code, OpenAI, OpenAI Codex

**Additional Services:** Stripe, Twilio, Okta, Vercel, Heroku, Databricks, Ngrok, Datadog, Sourcegraph, Zapier, Zendesk, and many more

See the full list at https://www.1password.dev/cli/shell-plugins/ (each tool has its own setup page, e.g. `/cli/shell-plugins/aws`).

## Building Custom Plugins

For unlisted tools, you can build and contribute a custom shell plugin. See the contribution guide at `/cli/shell-plugins/contribute/`.

## Security

CLI credentials are encrypted in your 1Password account; the plugin only injects them into the tool's process after authentication. See `/cli/shell-plugins/security/` for details.
