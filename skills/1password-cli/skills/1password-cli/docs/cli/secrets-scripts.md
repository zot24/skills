> Source: https://www.1password.dev/cli/secrets-scripts/



Load secrets


# Load secrets into scripts


1.  <a href="#use-op-run-to-pass-secrets-from-a-1password-environment" class="link">Use <code>op run</code> to pass secrets from a 1Password Environment</a>
2.  <a href="#use-op-run-to-pass-secrets-using-secret-references" class="link">Use <code>op run</code> to load secrets into the environment.</a>
3.  <a href="#use-op-read-to-read-secrets" class="link">Use <code>op read</code> to read secrets.</a>
4.  <a href="#use-op-inject-to-load-secrets-into-a-config-file" class="link">Use <code>op inject</code> to load secrets into a config file.</a>
5.  <a href="#use-op-plugin-run-to-load-secrets-using-a-shell-plugin" class="link">Use <code>op plugin run</code> to load secrets using a shell plugin.</a>


## Building an integration or automated workflow?


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_b9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI.</a>
3.  Store the secrets you need for your script in your 1Password account.

## <a href="#use-op-run-to-pass-secrets-from-a-1password-environment" class="anchor-link" aria-label="Navigate to header: Use op run to pass secrets from a 1Password Environment"></a><span id="_R_h9deehkd74t9_" class="cursor-pointer">Use `op run` to pass secrets from a 1Password Environment</span>


## <a href="#use-op-run-to-pass-secrets-using-secret-references" class="anchor-link" aria-label="Navigate to header: Use op run to pass secrets using secret references"></a><span id="_R_n9deehkd74t9_" class="cursor-pointer">Use `op run` to pass secrets using secret references</span>


## <a href="#use-op-read-to-read-secrets" class="anchor-link" aria-label="Navigate to header: Use op read to read secrets"></a><span id="_R_t9deehkd74t9_" class="cursor-pointer">Use `op read` to read secrets</span>


### <a href="#directly-in-your-script" class="anchor-link" aria-label="Navigate to header: Directly in your script"></a><span id="_R_119deehkd74t9_" class="cursor-pointer">Directly in your script</span>


``` shiki
#!/bin/bash

docker login -u "$(op read op://prod/docker/username)" -p "$(op read op://prod/docker/password)"
```


### <a href="#with-environment-variables" class="anchor-link" aria-label="Navigate to header: With environment variables"></a><span id="_R_199deehkd74t9_" class="cursor-pointer">With environment variables</span>


``` shiki
#!/bin/bash

export AWS_SECRET_ACCESS_KEY="$(op read op://prod/aws/secret-key)"
export AWS_ACCESS_KEY_ID="$(op read op://prod/aws/access-key-id)"
aws sts get-caller-identity
```


## <a href="#use-op-inject-to-load-secrets-into-a-config-file" class="anchor-link" aria-label="Navigate to header: Use op inject to load secrets into a config file"></a><span id="_R_1h9deehkd74t9_" class="cursor-pointer">Use `op inject` to load secrets into a config file</span>


## <a href="#use-op-plugin-run-to-load-secrets-using-a-shell-plugin" class="anchor-link" aria-label="Navigate to header: Use op plugin run to load secrets using a shell plugin"></a><span id="_R_1p9deehkd74t9_" class="cursor-pointer">Use `op plugin run` to load secrets using a shell plugin</span>


``` shiki
#!/bin/bash

op plugin run -- aws sts get-caller-identity
```


``` shiki
#!/bin/bash

alias aws="op plugin run -- aws"
aws sts get-caller-identity
```


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_299deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/scripts/" class="link">Example CLI scripts</a>
- <a href="/cli/secret-references/" class="link">Get started with secret references</a>
- <a href="/cli/secrets-environment-variables/" class="link">Load secrets into the environment</a>
- <a href="/cli/secrets-config-files/" class="link">Load secrets into config files</a>
- <a href="/cli/shell-plugins/" class="link">Use 1Password Shell Plugins to securely authenticate third-party CLIs</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure local development</a>


Was this page helpful?


