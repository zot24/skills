# portainerctl Skill

Expert knowledge about [portainerctl](https://github.com/portainer/portainerctl) — Portainer's official, full-featured CLI for driving **Portainer Business Edition** over its REST API from the terminal and CI/CD.

## What This Skill Covers

- **Install & build**: download a release binary, build from source (Go 1.22+), supported Portainer version (BE 2.39.1)
- **Auth & configuration**: API token (PAT) auth, named **contexts** in `~/.portainerctl/config.yaml`, `PORTAINERCTL_*` env-var overrides for CI, global `-o table|json|yaml` output
- **Environments**: environments/endpoints, environment groups, tags, snapshots (`--env <id>` targeting)
- **Stacks & GitOps**: deploy Compose/Swarm/Kubernetes stacks from a file or Git repo, lifecycle (start/stop/redeploy), GitOps utilities, custom templates
- **Docker resources**: containers, images, volumes, networks, and `docker` CLI passthrough
- **Kubernetes & Helm**: built-in API wrappers, Helm management, `kubectl` passthrough (`--` and full `--raw`)
- **Edge compute**: edge stacks, groups, jobs, configurations, update schedules
- **Access control**: users, teams, RBAC roles, resource controls, registries, webhooks
- **Administration**: licenses, backups (incl. S3), settings, system, observability/alerting, activity logs, cloud/KaaS, policies, support bundles

## Usage

```
/portainerctl help                  # Show available commands
/portainerctl install               # Install / build the CLI
/portainerctl auth                  # Authenticate & manage contexts
/portainerctl environment groups    # Environments & groups
/portainerctl stack deploy          # Deploy a stack (file or Git/GitOps)
/portainerctl deploy                # GitOps / file deploy walkthrough
/portainerctl docker containers     # Containers / images / volumes / networks
/portainerctl kubernetes            # Kubernetes & Helm
/portainerctl edge                  # Edge stacks / groups / jobs
/portainerctl access users          # Users / teams / RBAC / registries
/portainerctl admin backups         # Backups / licensing / settings / observability
/portainerctl sync                  # Update docs from upstream
```

## Documentation Sources

The canonical command reference is the upstream `README.md`, cached at `skills/portainerctl/docs/readme-upstream.md` and synced from the GitHub repo (branch `develop`). Topical docs under `skills/portainerctl/docs/` (installation, configuration, environments, stacks, docker-resources, kubernetes, edge, users-teams-rbac, administration) are curated from the README command reference and the `cmd/*.go` command definitions.

## Sync

```bash
# Sync the cached upstream README
.github/workflows/scripts/sync-skill.sh skills/portainerctl --force
```

The topical docs/ files are hand-curated; refresh them when the upstream README's command reference changes.

## Upstream

- **Repository**: https://github.com/portainer/portainerctl (default branch `develop`)
- **Releases**: https://github.com/portainer/portainerctl/releases
- **Portainer docs (background concepts)**: https://docs.portainer.io/
