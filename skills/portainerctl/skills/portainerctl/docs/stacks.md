<!-- Source: https://github.com/portainer/portainerctl/blob/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md (Stacks, GitOps Utilities, Custom Templates)

# Stacks, Deploy & GitOps

A **stack** is a Compose/Swarm/Kubernetes application Portainer deploys and manages on an environment. Stacks can be deployed from a local file or from a Git repository (GitOps).

## Inspect

```bash
portainerctl stack list
portainerctl stack list --env 2
portainerctl stack list -o json
portainerctl stack get <id>
portainerctl stack get-by-name myapp
portainerctl stack file <id>            # print the stack's compose/manifest file
```

## Deploy

```bash
# From a local file
portainerctl stack deploy-compose --name myapp --env 2 --file docker-compose.yml
portainerctl stack deploy-swarm   --name myapp --env 2 --file docker-stack.yml
portainerctl stack deploy-k8s     --name myapp --env 4 --file manifest.yaml

# From a Git repository (GitOps)
portainerctl stack deploy-git     --name myapp --env 2 --repo https://github.com/org/repo --branch main --path docker-compose.yml
portainerctl stack deploy-k8s-git --name myapp --env 4 --repo https://github.com/org/repo --branch main --path manifest.yaml
```

## Lifecycle

```bash
portainerctl stack start <id>
portainerctl stack stop <id>
portainerctl stack redeploy <id>        # pull latest from Git and redeploy
portainerctl stack delete <id> --env 2
portainerctl stack image-status <id>    # whether images are up to date
```

## GitOps Utilities

Inspect Git repositories before deploying a Git-backed stack:

```bash
portainerctl gitops refs --url https://github.com/org/repo
portainerctl gitops search --url https://github.com/org/repo --ref refs/heads/main
portainerctl gitops preview --url https://github.com/org/repo --ref refs/heads/main --file docker-compose.yml
```

## Custom Templates

App templates that pre-fill stack deployments.

```bash
portainerctl template list
portainerctl template get <id>
portainerctl template file <id>
portainerctl template create --title "My App" --file docker-compose.yml --type 2
portainerctl template delete <id>
```
