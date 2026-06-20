<!-- Source: https://github.com/portainer/portainerctl/blob/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md (Environments)

# Environments & Environment Groups

In Portainer, an **environment** (formerly "endpoint") is a Docker host, Swarm cluster, Kubernetes cluster, or Edge agent that Portainer manages. Most resource commands target an environment with the `--env <id>` flag. **Environment groups** (formerly "endpoint groups") let you organize environments for access control.

## Environments

```bash
portainerctl env list
portainerctl env list -o json
portainerctl env get <id>
portainerctl env snapshot <id>            # trigger a fresh snapshot of one environment
portainerctl env snapshot-all             # snapshot all environments
portainerctl env delete <id>
portainerctl env delete-bulk --ids 3,7,12
portainerctl env settings <id>
portainerctl env settings <id> --patch '{"DisableTrustOnFirstConnect": true}'
portainerctl env registries <id>          # registries available to this environment
portainerctl env agent-versions           # agent versions across environments
portainerctl env relations                # environment-to-group/tag relations
```

## Environment Groups

```bash
portainerctl env-group list
portainerctl env-group get <id>
portainerctl env-group create --name "Production"
portainerctl env-group delete <id>
portainerctl env-group add-env <group-id> <env-id>
portainerctl env-group remove-env <group-id> <env-id>
```

## Tags

Tags label environments and drive dynamic Edge groups.

```bash
portainerctl tag list
portainerctl tag create --name production
portainerctl tag delete <id>
```
