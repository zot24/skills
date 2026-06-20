<!-- Source: https://raw.githubusercontent.com/portainer/portainerctl/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md

# portainerctl

A full-featured CLI for **Portainer Business Edition 2.39.1**.

Covers the complete Portainer BE API: environments, stacks, containers, Kubernetes workloads, edge compute, users, teams, RBAC, registries, GitOps, webhooks, backups, licensing, observability, and more.

---

## Installation

### Download a binary (recommended)

Grab the latest release for your platform from the [Releases](https://github.com/portainer/portainerctl/releases) page.

```bash
# Linux amd64
curl -L https://github.com/portainer/portainerctl/releases/latest/download/portainerctl_linux_amd64.tar.gz | tar xz
sudo mv portainerctl /usr/local/bin/
```

### Build from source

Requires Go 1.22+.

```bash
git clone https://github.com/portainer/portainerctl.git
cd portainerctl
go mod tidy
go build -o portainerctl .
```

---

## Configuration

### Add a context

```bash
portainerctl config add-context \
  --name prod \
  --url https://portainer.example.com \
  --token pt_yourpattoken

# For self-signed TLS
portainerctl config add-context \
  --name lab \
  --url https://192.168.1.100:9443 \
  --token pt_yourpattoken \
  --insecure
```

### Switch contexts

```bash
portainerctl config get-contexts
portainerctl config use-context prod
```

### Environment variable overrides

These override the config file — useful for scripting and CI:

```bash
export PORTAINERCTL_URL=https://portainer.example.com
export PORTAINERCTL_TOKEN=pt_yourpattoken
export PORTAINERCTL_INSECURE=true   # optional, for self-signed TLS
```

---

## Output format

All commands support a global `-o` / `--output` flag:

| Flag | Description |
|------|-------------|
| `-o table` | Human-readable table (default) |
| `-o json` | JSON output |
| `-o yaml` | YAML output |

```bash
# Default table output
portainerctl env list

# JSON — pipe to jq for filtering
portainerctl env list -o json
portainerctl env list -o json | jq '.[] | select(.status == "up")'
portainerctl stack get 5 -o json | jq '.git_config.url'

# YAML
portainerctl env list -o yaml
portainerctl user list -o yaml
```

List commands in `json` and `yaml` mode return an array of objects with lowercased, underscore-separated keys matching the table column names. Get and inspect commands return the full raw API response object.

---

## Command Reference

### Environments

```bash
portainerctl env list
portainerctl env list -o json
portainerctl env get <id>
portainerctl env snapshot <id>
portainerctl env snapshot-all
portainerctl env delete <id>
portainerctl env delete-bulk --ids 3,7,12
portainerctl env settings <id>
portainerctl env settings <id> --patch '{"DisableTrustOnFirstConnect": true}'
portainerctl env registries <id>
portainerctl env agent-versions
portainerctl env relations

portainerctl env-group list
portainerctl env-group get <id>
portainerctl env-group create --name "Production"
portainerctl env-group delete <id>
portainerctl env-group add-env <group-id> <env-id>
portainerctl env-group remove-env <group-id> <env-id>
```

### Stacks

```bash
portainerctl stack list
portainerctl stack list --env 2
portainerctl stack list -o json
portainerctl stack get <id>
portainerctl stack get-by-name myapp
portainerctl stack file <id>

# Deploy
portainerctl stack deploy-compose --name myapp --env 2 --file docker-compose.yml
portainerctl stack deploy-swarm   --name myapp --env 2 --file docker-stack.yml
portainerctl stack deploy-git     --name myapp --env 2 --repo https://github.com/org/repo --branch main --path docker-compose.yml
portainerctl stack deploy-k8s     --name myapp --env 4 --file manifest.yaml
portainerctl stack deploy-k8s-git --name myapp --env 4 --repo https://github.com/org/repo --branch main --path manifest.yaml

# Lifecycle
portainerctl stack start <id>
portainerctl stack stop <id>
portainerctl stack redeploy <id>      # pull latest from Git
portainerctl stack delete <id> --env 2
portainerctl stack image-status <id>
```

### Containers (Docker/Swarm environments)

```bash
portainerctl container list --env 2
portainerctl container list --env 2 --all
portainerctl container list --env 2 -o json
portainerctl container inspect <container-id> --env 2
portainerctl container logs <container-id> --env 2 --tail 200
portainerctl container logs <container-id> --env 2 --timestamps
portainerctl container start   <container-id> --env 2
portainerctl container stop    <container-id> --env 2 --timeout 30
portainerctl container restart <container-id> --env 2
portainerctl container kill    <container-id> --env 2 --signal SIGTERM
portainerctl container remove  <container-id> --env 2 --force --volumes
portainerctl container stats   <container-id> --env 2
portainerctl container top     <container-id> --env 2
portainerctl container image-status <container-id> --env 2
```

### Images

```bash
portainerctl image list --env 2
portainerctl image list --env 2 -o json
portainerctl image inspect <id> --env 2
portainerctl image pull --env 2 --image nginx:latest
portainerctl image remove <id> --env 2
portainerctl image update-check --env 2
```

### Volumes

```bash
portainerctl volume list --env 2
portainerctl volume inspect <n> --env 2
portainerctl volume create myvolume --env 2
portainerctl volume create myvolume --env 2 --driver local
portainerctl volume remove myvolume --env 2
```

### Networks

```bash
portainerctl network list --env 2
portainerctl network inspect <id> --env 2
portainerctl network create mynet --env 2 --driver bridge
portainerctl network remove <id> --env 2
```

### Kubernetes

```bash
# Built-in Portainer API wrappers (no kubectl required)
portainerctl kubectl namespaces list --env 4
portainerctl kubectl namespaces list --env 4 -o yaml
portainerctl kubectl namespaces get default --env 4
portainerctl kubectl applications list --env 4
portainerctl kubectl applications list --env 4 --namespace production
portainerctl kubectl applications restart default Deployment myapp --env 4
portainerctl kubectl services list --env 4
portainerctl kubectl ingresses list --env 4
portainerctl kubectl secrets list --env 4
portainerctl kubectl configmaps list --env 4
portainerctl kubectl volumes list --env 4
portainerctl kubectl nodes limits --env 4
portainerctl kubectl nodes metrics --env 4
portainerctl kubectl nodes drain worker-01 --env 4
portainerctl kubectl dashboard --env 4

# Helm
portainerctl kubectl helm list --env 4
portainerctl kubectl helm list --env 4 --namespace production
portainerctl kubectl helm history myrelease --env 4 --namespace production
portainerctl kubectl helm rollback myrelease --env 4 --namespace production --revision 3
portainerctl kubectl helm delete myrelease --env 4 --namespace production

# kubectl passthrough — basic get/describe/delete without kubectl installed
portainerctl kubectl --env 4 -- get pods -n default
portainerctl kubectl --env 4 -- get deployments -n production
portainerctl kubectl --env 4 -- describe service myservice -n default

# Full kubectl passthrough — requires kubectl installed locally
portainerctl kubectl --env 4 --raw -- get pods -n default
portainerctl kubectl --env 4 --raw -- apply -f manifest.yaml
portainerctl kubectl --env 4 --raw -- rollout restart deployment/myapp -n production
```

### Docker CLI passthrough

```bash
# Requires docker CLI installed locally
portainerctl docker --env 2 -- ps -a
portainerctl docker --env 2 -- images
portainerctl docker --env 2 -- inspect mycontainer
portainerctl docker --env 2 -- stats --no-stream
```

### Users

```bash
portainerctl user list
portainerctl user list -o json
portainerctl user get <id>
portainerctl user me
portainerctl user create --username alice --password secret --role 2
portainerctl user passwd <id> --password newpassword
portainerctl user delete <id>
portainerctl user memberships <id>
portainerctl user tokens <id>
portainerctl user create-token <id> --description "CI pipeline"
portainerctl user delete-token <user-id> <key-id>
portainerctl user namespaces <id>
portainerctl user git-credentials <id>
```

### Teams

```bash
portainerctl team list
portainerctl team list -o yaml
portainerctl team get <id>
portainerctl team create --name "Platform Engineering"
portainerctl team delete <id>
portainerctl team memberships <id>

portainerctl team-membership list
portainerctl team-membership add --team 2 --user 5 --role 2
portainerctl team-membership remove <membership-id>
```

### RBAC

```bash
portainerctl role list
portainerctl role list -o json

portainerctl resource-control create --body '{"ResourceID":"abc","Type":"container","Users":[1],"Teams":[],"Public":false}'
portainerctl resource-control update <id> --body '{"Public":true}'
portainerctl resource-control delete <id>
```

### Registries

```bash
portainerctl registry list
portainerctl registry list -o json
portainerctl registry get <id>
portainerctl registry create --name myregistry --url registry.example.com --user admin --pass secret --type 3
portainerctl registry delete <id>
portainerctl registry repositories <id> myrepo/myimage
portainerctl registry ping --url registry.example.com --user admin --pass secret
```

### Webhooks

```bash
portainerctl webhook list
portainerctl webhook list -o json
portainerctl webhook create --resource <service-id> --env 2 --type 1
portainerctl webhook delete <id>
```

### Tags

```bash
portainerctl tag list
portainerctl tag create --name production
portainerctl tag delete <id>
```

### Edge Stacks

```bash
portainerctl edge-stack list
portainerctl edge-stack list -o json
portainerctl edge-stack get <id>
portainerctl edge-stack file <id>
portainerctl edge-stack deploy --name myapp --file docker-compose.yml --groups 1,2
portainerctl edge-stack deploy-git --name myapp --repo https://github.com/org/repo --branch main --path docker-compose.yml --groups 1
portainerctl edge-stack delete <id>
portainerctl edge-stack status <id>
```

### Edge Groups

```bash
portainerctl edge-group list
portainerctl edge-group list -o yaml
portainerctl edge-group get <id>
portainerctl edge-group create --name "Factory Floor" --dynamic --tags 3,4
portainerctl edge-group delete <id>
```

### Edge Jobs

```bash
portainerctl edge-job list
portainerctl edge-job get <id>
portainerctl edge-job create --name cleanup --cron "0 2 * * *" --file cleanup.sh --groups 1
portainerctl edge-job delete <id>
portainerctl edge-job tasks <id>
```

### Edge Configurations

```bash
portainerctl edge-config list
portainerctl edge-config get <id>
portainerctl edge-config delete <id>
```

### Edge Update Schedules

```bash
portainerctl edge-update list
portainerctl edge-update get <id>
portainerctl edge-update active
portainerctl edge-update agent-versions
portainerctl edge-update delete <id>
```

### Licenses

```bash
portainerctl license info
portainerctl license list
portainerctl license add --key pt_XXXXXXXXXX
portainerctl license remove --keys pt_XXXXXXXXXX,pt_YYYYYYYYYY
```

### Backups

```bash
portainerctl backup create
portainerctl backup create --password mysecret --output portainer-backup.tar.gz
portainerctl backup s3-settings
portainerctl backup s3-status
portainerctl backup s3-execute
```

### Settings

```bash
portainerctl settings get
portainerctl settings get -o yaml
portainerctl settings public
portainerctl settings update --patch '{"EnableEdgeComputeFeatures": true}'
portainerctl settings ssl
portainerctl settings experimental
```

### System

```bash
portainerctl system status
portainerctl system info
portainerctl system version
portainerctl system nodes
```

### Observability / Alerting

```bash
portainerctl observability alerts
portainerctl observability rules
portainerctl observability settings
portainerctl observability connectivity
```

### Activity Logs

```bash
portainerctl activity auth-logs
portainerctl activity auth-logs -o json
portainerctl activity logs
portainerctl activity auth-logs-csv > auth.csv
portainerctl activity logs-csv > activity.csv
```

### Custom Templates

```bash
portainerctl template list
portainerctl template get <id>
portainerctl template file <id>
portainerctl template create --title "My App" --file docker-compose.yml --type 2
portainerctl template delete <id>
```

### GitOps Utilities

```bash
portainerctl gitops refs --url https://github.com/org/repo
portainerctl gitops search --url https://github.com/org/repo --ref refs/heads/main
portainerctl gitops preview --url https://github.com/org/repo --ref refs/heads/main --file docker-compose.yml
```

### Cloud / KaaS

```bash
portainerctl cloud credentials
portainerctl cloud credential <id>
portainerctl cloud delete-credential <id>
portainerctl cloud info amazon --credential 1
portainerctl cloud git-credentials
```

### Policies

```bash
portainerctl policy list
portainerctl policy get <id>
portainerctl policy templates
portainerctl policy metadata
portainerctl policy delete <id>
```

### Helm Chart Templates

```bash
portainerctl helm list
portainerctl helm repos --user <id>
```

### Support

```bash
portainerctl support download
portainerctl support debug-log enable
portainerctl support debug-log disable
```

---

## Output format detail

The `-o` / `--output` flag is global and works on every command:

```bash
# Pipe JSON to jq
portainerctl env list -o json | jq '.[] | {id: .id, name: .name, status: .status}'
portainerctl stack list -o json | jq '.[] | select(.type == "compose")'
portainerctl user list -o json | jq '.[] | select(.role == "admin")'

# Save YAML for review or diffing
portainerctl env list -o yaml > environments.yaml
portainerctl stack list -o yaml > stacks.yaml
```

---

## Building release binaries

Requires [GoReleaser](https://goreleaser.com/) installed.

```bash
# Local snapshot build (no GitHub token needed)
goreleaser release --snapshot --clean

# Tagged release — handled automatically by the included GitHub Actions workflow
git tag v0.1.0
git push origin v0.1.0
```

The workflow at `.github/workflows/release.yml` produces signed binaries for Linux, macOS, and Windows on amd64, arm64, and armv7 on every tag push.

---

## Supported Portainer version

Portainer Business Edition **2.39.1** (`portaineree`).

The CLI targets this version specifically. BE-only endpoints (licensing, RBAC roles, edge compute, policies, observability, cloud credentials) will return 403 on CE installs.

---

## License

MIT
