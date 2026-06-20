<!-- Source: https://github.com/portainer/portainerctl/blob/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md (Containers, Images, Volumes, Networks, Docker CLI passthrough)

# Docker Resources (Containers, Images, Volumes, Networks)

These commands operate on Docker/Swarm environments. They all require `--env <id>` to select the target environment.

## Containers

```bash
portainerctl container list --env 2
portainerctl container list --env 2 --all          # include stopped containers
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

## Images

```bash
portainerctl image list --env 2
portainerctl image list --env 2 -o json
portainerctl image inspect <id> --env 2
portainerctl image pull --env 2 --image nginx:latest
portainerctl image remove <id> --env 2
portainerctl image update-check --env 2
```

## Volumes

```bash
portainerctl volume list --env 2
portainerctl volume inspect <name> --env 2
portainerctl volume create myvolume --env 2
portainerctl volume create myvolume --env 2 --driver local
portainerctl volume remove myvolume --env 2
```

## Networks

```bash
portainerctl network list --env 2
portainerctl network inspect <id> --env 2
portainerctl network create mynet --env 2 --driver bridge
portainerctl network remove <id> --env 2
```

## Docker CLI passthrough

Run arbitrary Docker CLI commands against an environment via Portainer (requires the `docker` CLI installed locally):

```bash
portainerctl docker --env 2 -- ps -a
portainerctl docker --env 2 -- images
portainerctl docker --env 2 -- inspect mycontainer
portainerctl docker --env 2 -- stats --no-stream
```
