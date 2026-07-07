> Source: https://www.1password.dev/cli/secrets-scripts/



Load secrets


# Load secrets into scripts


Copy page


Copy page


1.  <a href="#use-op-run-to-pass-environment-variables-from-a-1password-environment-beta" class="link">Use <code>op run</code> to pass environment variables from a 1Password Environment</a>
2.  <a href="#use-op-run-to-pass-secrets-using-secret-references" class="link">Use <code>op run</code> to load secrets into the environment.</a>
3.  <a href="#use-op-read-to-read-secrets" class="link">Use <code>op read</code> to read secrets.</a>
4.  <a href="#use-op-inject-to-load-secrets-into-a-config-file" class="link">Use <code>op inject</code> to load secrets into a config file.</a>
5.  <a href="#use-op-plugin-run-to-load-secrets-using-a-shell-plugin" class="link">Use <code>op plugin run</code> to load secrets using a shell plugin.</a>


## Building an integration or automated workflow?


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI.</a>
3.  Store the secrets you need for your script in your 1Password account.

## 


<a href="#use-op-run-to-pass-environment-variables-from-a-1password-environment-beta" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#use-op-run-to-pass-secrets-using-secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#use-op-read-to-read-secrets" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#directly-in-your-script" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
#!/bin/bash

docker login -u "$(op read op://prod/docker/username)" -p "$(op read op://prod/docker/password)"
```


### 


<a href="#with-environment-variables" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
#!/bin/bash

export AWS_SECRET_ACCESS_KEY="$(op read op://prod/aws/secret-key)"
export AWS_ACCESS_KEY_ID="$(op read op://prod/aws/access-key-id)"
aws sts get-caller-identity
```


## 


<a href="#use-op-inject-to-load-secrets-into-a-config-file" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#use-op-plugin-run-to-load-secrets-using-a-shell-plugin" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
#!/bin/bash

op plugin run -- aws sts get-caller-identity
```


``` shiki
#!/bin/bash

alias aws="op plugin run -- aws"
aws sts get-caller-identity
```


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/scripts" class="link">Example CLI scripts</a>
- <a href="/cli/secret-references" class="link">Get started with secret references</a>
- <a href="/cli/secrets-environment-variables" class="link">Load secrets into the environment</a>
- <a href="/cli/secrets-config-files" class="link">Load secrets into config files</a>
- <a href="/cli/shell-plugins" class="link">Use 1Password Shell Plugins to securely authenticate third-party CLIs</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure your developer secrets</a>


Was this page helpful?


<a href="/cli/secrets-config-files" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Inject secrets into config files</span></a><a href="/cli/secret-references" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Use secret references with 1Password CLI</span></a>


