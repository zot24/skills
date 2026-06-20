<!-- Source: https://github.com/portainer/portainerctl/blob/develop/README.md -->
> Source: https://github.com/portainer/portainerctl/blob/develop/README.md (Licenses, Backups, Settings, System, Observability, Activity Logs, Cloud/KaaS, Policies, Support)

# Administration, Backups, Licensing & Observability

Server-wide administrative commands. Several of these (licensing, observability, cloud credentials, policies) are **Business Edition** features and return 403 on CE.

## Licenses

```bash
portainerctl license info
portainerctl license list
portainerctl license add --key pt_XXXXXXXXXX
portainerctl license remove --keys pt_XXXXXXXXXX,pt_YYYYYYYYYY
```

## Backups

```bash
portainerctl backup create
portainerctl backup create --password mysecret --output portainer-backup.tar.gz
portainerctl backup s3-settings
portainerctl backup s3-status
portainerctl backup s3-execute        # trigger an S3 backup now
```

## Settings

```bash
portainerctl settings get
portainerctl settings get -o yaml
portainerctl settings public                                    # public (unauthenticated) settings
portainerctl settings update --patch '{"EnableEdgeComputeFeatures": true}'
portainerctl settings ssl
portainerctl settings experimental
```

## System

```bash
portainerctl system status
portainerctl system info
portainerctl system version
portainerctl system nodes
```

## Observability / Alerting

```bash
portainerctl observability alerts
portainerctl observability rules
portainerctl observability settings
portainerctl observability connectivity
```

## Activity Logs

```bash
portainerctl activity auth-logs
portainerctl activity auth-logs -o json
portainerctl activity logs
portainerctl activity auth-logs-csv > auth.csv
portainerctl activity logs-csv > activity.csv
```

## Cloud / KaaS

```bash
portainerctl cloud credentials
portainerctl cloud credential <id>
portainerctl cloud delete-credential <id>
portainerctl cloud info amazon --credential 1
portainerctl cloud git-credentials
```

## Policies

```bash
portainerctl policy list
portainerctl policy get <id>
portainerctl policy templates
portainerctl policy metadata
portainerctl policy delete <id>
```

## Support

```bash
portainerctl support download
portainerctl support debug-log enable
portainerctl support debug-log disable
```
