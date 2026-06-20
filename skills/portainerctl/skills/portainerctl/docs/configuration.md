<!-- Source: https://github.com/portainer/portainerctl/blob/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md (Configuration, Output format) and cmd/config.go / internal/config/config.go

# Configuration, Authentication & Output

`portainerctl` authenticates with a **Portainer API token (PAT)** and stores connection details in named **contexts** (similar to kubeconfig).

## Config file

- Location: `~/.portainerctl/config.yaml` (directory created with mode `0700`).
- Format: YAML with a `current-context` key and a list of `contexts`, each holding `name`, `url`, `token`, and `insecure`.
- Run `portainerctl config view` to print the config file path.

## Contexts

```bash
# Add or update a named context
portainerctl config add-context \
  --name prod \
  --url https://portainer.example.com \
  --token pt_yourpattoken

# For self-signed TLS, skip certificate verification
portainerctl config add-context \
  --name lab \
  --url https://192.168.1.100:9443 \
  --token pt_yourpattoken \
  --insecure
```

The first context added automatically becomes the current context.

```bash
portainerctl config get-contexts        # list all contexts (* marks active)
portainerctl config use-context prod     # switch the active context
portainerctl config delete-context lab   # remove a context
portainerctl config view                 # print path to config file
```

### add-context flags

| Flag | Description |
|------|-------------|
| `--name` | Context name (required) |
| `--url` | Portainer server URL, e.g. `https://portainer.example.com` (required) |
| `--token` | API token / PAT (required) |
| `--insecure` | Skip TLS certificate verification (self-signed certs) |

## Environment variable overrides

These override the config file — ideal for scripting and CI. When `PORTAINERCTL_URL` is set, the CLI uses these instead of the active context:

```bash
export PORTAINERCTL_URL=https://portainer.example.com
export PORTAINERCTL_TOKEN=pt_yourpattoken
export PORTAINERCTL_INSECURE=true   # optional, for self-signed TLS
```

## Output format

Every command supports a global `-o` / `--output` flag:

| Flag | Description |
|------|-------------|
| `-o table` | Human-readable table (default) |
| `-o json` | JSON output |
| `-o yaml` | YAML output |

```bash
portainerctl env list                # default table output
portainerctl env list -o json        # JSON
portainerctl env list -o json | jq '.[] | select(.status == "up")'
portainerctl stack get 5 -o json | jq '.git_config.url'
portainerctl env list -o yaml        # YAML
```

List commands in `json`/`yaml` mode return an array of objects with lowercased, underscore-separated keys matching the table column names. Get and inspect commands return the full raw API response object.

```bash
# Pipe JSON to jq
portainerctl env list -o json | jq '.[] | {id: .id, name: .name, status: .status}'
portainerctl stack list -o json | jq '.[] | select(.type == "compose")'
portainerctl user list -o json | jq '.[] | select(.role == "admin")'

# Save YAML for review or diffing
portainerctl env list -o yaml > environments.yaml
portainerctl stack list -o yaml > stacks.yaml
```
