<!-- Source: https://github.com/portainer/portainerctl/blob/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md (Edge Stacks/Groups/Jobs/Configurations/Update Schedules)

# Edge Compute

Portainer **Edge** manages remote agents over a tunnel. Edge resources are deployed to **edge groups** (collections of edge environments, static or dynamic by tag) rather than a single environment. Edge compute is a **Business Edition** feature.

## Edge Stacks

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

## Edge Groups

```bash
portainerctl edge-group list
portainerctl edge-group list -o yaml
portainerctl edge-group get <id>
portainerctl edge-group create --name "Factory Floor" --dynamic --tags 3,4
portainerctl edge-group delete <id>
```

## Edge Jobs

Scheduled scripts (cron) that run on edge agents.

```bash
portainerctl edge-job list
portainerctl edge-job get <id>
portainerctl edge-job create --name cleanup --cron "0 2 * * *" --file cleanup.sh --groups 1
portainerctl edge-job delete <id>
portainerctl edge-job tasks <id>
```

## Edge Configurations

```bash
portainerctl edge-config list
portainerctl edge-config get <id>
portainerctl edge-config delete <id>
```

## Edge Update Schedules

Roll out agent updates to edge fleets on a schedule.

```bash
portainerctl edge-update list
portainerctl edge-update get <id>
portainerctl edge-update active
portainerctl edge-update agent-versions
portainerctl edge-update delete <id>
```
