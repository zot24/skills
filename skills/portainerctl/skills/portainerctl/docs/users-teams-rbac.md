<!-- Source: https://github.com/portainer/portainerctl/blob/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md (Users, Teams, RBAC, Registries, Webhooks)

# Users, Teams, RBAC, Registries & Webhooks

Portainer access control combines **users**, **teams**, **roles** (RBAC), and **resource controls**. RBAC roles and resource controls are **Business Edition** features.

## Users

```bash
portainerctl user list
portainerctl user list -o json
portainerctl user get <id>
portainerctl user me                                  # the authenticated user
portainerctl user create --username alice --password secret --role 2
portainerctl user passwd <id> --password newpassword
portainerctl user delete <id>
portainerctl user memberships <id>                    # team memberships
portainerctl user tokens <id>                         # API tokens (PATs)
portainerctl user create-token <id> --description "CI pipeline"
portainerctl user delete-token <user-id> <key-id>
portainerctl user namespaces <id>                     # accessible k8s namespaces
portainerctl user git-credentials <id>
```

`--role`: `1` = admin, `2` = standard user (Portainer role IDs).

## Teams

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

`--role` on a membership: `1` = team leader, `2` = member.

## RBAC

```bash
portainerctl role list
portainerctl role list -o json

# Resource controls grant users/teams access to a specific resource
portainerctl resource-control create --body '{"ResourceID":"abc","Type":"container","Users":[1],"Teams":[],"Public":false}'
portainerctl resource-control update <id> --body '{"Public":true}'
portainerctl resource-control delete <id>
```

## Registries

```bash
portainerctl registry list
portainerctl registry list -o json
portainerctl registry get <id>
portainerctl registry create --name myregistry --url registry.example.com --user admin --pass secret --type 3
portainerctl registry delete <id>
portainerctl registry repositories <id> myrepo/myimage
portainerctl registry ping --url registry.example.com --user admin --pass secret
```

`--type` selects the registry kind (e.g. custom, Docker Hub, Quay, ECR, GitLab, Azure — `3` is a common custom registry value).

## Webhooks

Trigger redeploys/service updates via an HTTP webhook URL.

```bash
portainerctl webhook list
portainerctl webhook list -o json
portainerctl webhook create --resource <service-id> --env 2 --type 1
portainerctl webhook delete <id>
```
