<!-- Source: https://github.com/portainer/portainerctl/blob/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md (Kubernetes, Helm Chart Templates)

# Kubernetes & Helm

Kubernetes commands target a Kubernetes environment with `--env <id>`. There are three layers: built-in Portainer API wrappers (no `kubectl` needed), a lightweight `kubectl` passthrough, and a full `--raw` passthrough that requires `kubectl` installed locally.

## Built-in API wrappers (no kubectl required)

```bash
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
```

## Helm

```bash
portainerctl kubectl helm list --env 4
portainerctl kubectl helm list --env 4 --namespace production
portainerctl kubectl helm history myrelease --env 4 --namespace production
portainerctl kubectl helm rollback myrelease --env 4 --namespace production --revision 3
portainerctl kubectl helm delete myrelease --env 4 --namespace production
```

## kubectl passthrough (no local kubectl)

Basic `get` / `describe` / `delete` without `kubectl` installed:

```bash
portainerctl kubectl --env 4 -- get pods -n default
portainerctl kubectl --env 4 -- get deployments -n production
portainerctl kubectl --env 4 -- describe service myservice -n default
```

## Full kubectl passthrough (`--raw`, requires local kubectl)

```bash
portainerctl kubectl --env 4 --raw -- get pods -n default
portainerctl kubectl --env 4 --raw -- apply -f manifest.yaml
portainerctl kubectl --env 4 --raw -- rollout restart deployment/myapp -n production
```

## Helm Chart Templates

```bash
portainerctl helm list
portainerctl helm repos --user <id>
```
