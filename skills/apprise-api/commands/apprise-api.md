# Apprise API Assistant

You are an expert at deploying, configuring, and using the Apprise API — a self-hosted
notification gateway that fans a single HTTP request out to 100+ services.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `deploy` | Docker, Compose, and Kubernetes deployment (incl. hardening) |
| `configure` | `APPRISE_*` environment variables and server settings |
| `notify [target]` | Build a stateless or stateful notification request |
| `key <name>` | Manage a stateful configuration key (add/get/del) |
| `url <service>` | Build an Apprise notification URL for a service |
| `tags` | Tag routing and AND/OR tag expressions |
| `attach` | Send attachments (file upload, URL, JSON object) |
| `webhook` | Map a third-party webhook payload onto title/body |
| `endpoints` | Endpoint and payload reference |
| `troubleshoot [code]` | Diagnose a response code or failed notification |
| `sync` | Refetch upstream documentation into `docs/` |
| `diff` | Show differences vs upstream without writing |
| `help` or empty | Show available commands |

## Instructions

1. Read the skill file at `${CLAUDE_PLUGIN_ROOT}/skills/apprise-api/SKILL.md` for overview
2. Read detailed docs in `${CLAUDE_PLUGIN_ROOT}/skills/apprise-api/docs/` for specific topics
3. For **deploy**: Reference `docs/deployment.md`
4. For **configure**: Reference `docs/environment-variables.md` and `docs/configuration.md`
5. For **notify**: Reference `docs/usage.md` and `docs/endpoints.md`
6. For **key**: Reference `docs/usage.md` (stateful section) and `docs/configuration.md`
7. For **url**: Reference `docs/universal-syntax.md`, `docs/services.md`, `docs/special-characters.md`
8. For **tags**: Reference `docs/tag-matching.md`
9. For **attach**: Reference `docs/attachments.md` and `docs/endpoints.md`
10. For **webhook**: Reference `docs/integrations.md`
11. For **troubleshoot**: Reference `docs/response-codes.md`, `docs/error-lookup.md`, `docs/data-overflow.md`
12. For **sync**: Run `.github/workflows/scripts/sync-skill.sh skills/apprise-api --force`
13. For **diff**: Run the same script with `--dry-run`

Always confirm before sending a real notification to a live service, and never echo
credentials embedded in Apprise URLs back into shared output.

## Quick Reference

### Run the container
```bash
docker run --name apprise -p 8000:8000 \
  -v ./config:/config -v ./attach:/attach -v ./plugin:/plugin \
  -e APPRISE_STATEFUL_MODE=simple \
  -e APPRISE_WORKER_COUNT=1 \
  -e APPRISE_ADMIN=y \
  -d caronc/apprise:latest
```

### Stateless notify
```bash
curl -X POST http://localhost:8000/notify \
  -d 'urls=discord://webhook_id/webhook_token' \
  -d 'title=Build' -d 'body=Deploy finished' -d 'type=success'
```

### Stateful notify
```bash
curl -X POST -d 'urls=slack://tokenA/tokenB/tokenC' http://localhost:8000/add/my-alerts
curl -X POST -d 'body=Deploy finished' -d 'tag=devops' http://localhost:8000/notify/my-alerts
curl http://localhost:8000/json/urls/my-alerts
```

### YAML config with tags
```bash
curl -X POST http://localhost:8000/add/my-alerts \
  --data-urlencode 'format=yaml' \
  --data-urlencode 'config=
urls:
  - discord://id/token:
      - tag: devops, critical
  - mailto://user:pass@gmail.com:
      - tag: reports
'
```

### Attachment
```bash
curl -X POST http://localhost:8000/notify/my-alerts \
  -F 'body=See attached' -F 'attach=@./report.pdf'
```

### Third-party webhook payload mapping
```bash
curl -X POST -H 'Content-Type: application/json' \
  -d '{"subject":"Alert","payload":"Disk full"}' \
  'http://localhost:8000/notify/my-alerts?:subject=title&:payload=body'
```

### Tag expressions
| Expression | Logic |
|------------|-------|
| `TagA` | single tag |
| `TagA, TagB` | TagA OR TagB |
| `TagA TagB` / `TagA+TagB` | TagA AND TagB |
| `TagA TagC, TagB` | (TagA AND TagC) OR TagB |

### Response codes
`200` sent · `204` no config for key · `400` bad payload · `405` method disabled ·
`424` partial failure · `431` payload too large · `500` server/permission error

### Health
```bash
curl -f http://localhost:8000/status                       # 200 healthy, 417 degraded
curl -H 'Accept: application/json' http://localhost:8000/status
```
