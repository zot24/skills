---
name: portainerctl
description: Expert on portainerctl — Portainer's official command-line interface for driving Portainer Business Edition over its REST API. Use when the user wants to manage Portainer from the terminal or CI/CD — authenticate with an API token, manage environments/endpoints and environment groups, deploy or manage Compose/Swarm/Kubernetes stacks, run GitOps deployments, control containers/images/volumes/networks, manage edge stacks/groups/jobs, users/teams/RBAC, registries, webhooks, backups, licensing, or observability. Triggers on mentions of portainerctl, Portainer CLI, manage Portainer from terminal, deploy stack via CLI, Portainer environments/endpoints, Portainer GitOps, Portainer automation, Portainer API token.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# portainerctl — Portainer's Official CLI

`portainerctl` is a full-featured Go CLI for **Portainer Business Edition 2.39.1** that drives the complete Portainer REST API from the terminal — ideal for scripting and CI/CD GitOps workflows.

## Overview

- **Full BE API surface** — environments, stacks, containers, Kubernetes workloads, edge compute, users/teams/RBAC, registries, GitOps, webhooks, backups, licensing, observability.
- **Token auth + contexts** — authenticate with a Portainer **API token (PAT)**; store multiple servers as named **contexts** (kubeconfig-style) in `~/.portainerctl/config.yaml`.
- **Scriptable output** — global `-o table|json|yaml` flag on every command; pipe JSON to `jq`.
- **CI-friendly** — `PORTAINERCTL_URL` / `PORTAINERCTL_TOKEN` / `PORTAINERCTL_INSECURE` env vars override the config file.
- **Deploy from file or Git** — Compose, Swarm, and Kubernetes stacks, plus edge stacks, locally or via GitOps.
- **Passthroughs** — Docker CLI and `kubectl` passthrough against managed environments.

## Quick Start

```bash
# Install (Linux amd64)
curl -L https://github.com/portainer/portainerctl/releases/latest/download/portainerctl_linux_amd64.tar.gz | tar xz
sudo mv portainerctl /usr/local/bin/

# Authenticate (stores a named context)
portainerctl config add-context --name prod \
  --url https://portainer.example.com --token pt_yourpattoken
portainerctl config use-context prod

# List environments, then deploy a Compose stack to env 2
portainerctl env list
portainerctl stack deploy-compose --name myapp --env 2 --file docker-compose.yml
```

## Core Concepts

- **API token + contexts** — auth is a Portainer PAT; contexts (name + url + token + insecure) live in `~/.portainerctl/config.yaml`. Env vars override the active context for CI. See [configuration](docs/configuration.md).
- **Environments** — every resource command targets an environment (Docker/Swarm/K8s/Edge host) with `--env <id>`; groups and tags organize them. See [environments](docs/environments.md).
- **Stacks & GitOps** — deploy Compose/Swarm/K8s stacks from a `--file` or a Git `--repo`; `redeploy` pulls the latest from Git. See [stacks](docs/stacks.md).
- **Output** — global `-o table|json|yaml`; list commands return arrays of objects, get/inspect return raw API objects. See [configuration](docs/configuration.md).

## Documentation

- **[Installation & Build](docs/installation.md)** — binary download, build from source, GoReleaser, supported Portainer version
- **[Configuration, Auth & Output](docs/configuration.md)** — contexts, API tokens, env-var overrides, `-o` formats
- **[Environments & Groups](docs/environments.md)** — environments, environment groups, tags, snapshots
- **[Stacks, Deploy & GitOps](docs/stacks.md)** — deploy-compose/swarm/k8s, deploy-git, lifecycle, gitops utils, templates
- **[Docker Resources](docs/docker-resources.md)** — containers, images, volumes, networks, docker CLI passthrough
- **[Kubernetes & Helm](docs/kubernetes.md)** — API wrappers, Helm, kubectl passthrough (`--`, `--raw`)
- **[Edge Compute](docs/edge.md)** — edge stacks, groups, jobs, configs, update schedules
- **[Users, Teams, RBAC & Registries](docs/users-teams-rbac.md)** — users, teams, roles, resource controls, registries, webhooks
- **[Administration](docs/administration.md)** — licenses, backups, settings, system, observability, activity logs, cloud, policies, support
- **[Upstream README](docs/readme-upstream.md)** — full cached command reference

## Common Workflows

- **GitOps deploy in CI**: export `PORTAINERCTL_URL`/`PORTAINERCTL_TOKEN` → `portainerctl stack deploy-git --name app --env 2 --repo <url> --branch main --path docker-compose.yml`; later `stack redeploy <id>` pulls latest.
- **Audit environments**: `portainerctl env list -o json | jq '.[] | select(.status == "up")'`.
- **Roll out to edge fleet**: `portainerctl edge-group create --name "Stores" --dynamic --tags 3,4` → `portainerctl edge-stack deploy --name app --file docker-compose.yml --groups 1`.

## Upstream Sources

- **Repository**: https://github.com/portainer/portainerctl (default branch `develop`)
- **Releases**: https://github.com/portainer/portainerctl/releases
- **Portainer docs (background)**: https://docs.portainer.io/

## Sync & Update

When user runs `sync`: fetch the latest `README.md` from `portainer/portainerctl` (branch `develop`) plus the `cmd/*.go` references, and refresh the cached `docs/` files. When user runs `diff`: compare current docs/ vs upstream.
