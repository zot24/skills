# Apprise API

Expert skill for deploying, configuring, and using the [Apprise API](https://github.com/caronc/apprise-api) —
a lightweight, self-hosted notification gateway that turns one HTTP request into notifications
across 100+ services.

## Features

- **Deployment** — Docker, Docker Compose, and hardened rootless Kubernetes manifests
- **Configuration** — every `APPRISE_*` environment variable, TEXT and YAML config formats
- **Stateless & stateful** — send URLs inline, or save them under a `{KEY}` and notify by key
- **Notification URLs** — universal URL syntax and the full supported-services catalogue
- **Tag routing** — AND/OR tag expressions to notify a subset of a saved configuration
- **Attachments** — multipart uploads, remote HTTP URLs, and JSON `{url, filename}` objects
- **Webhook mapping** — remap third-party JSON payloads onto `title`/`body` with `?:field=`
- **Operations** — `/status` health checks, `/metrics` for Prometheus, response-code triage

## Commands

```bash
/apprise-api:apprise-api deploy            # Docker / Compose / Kubernetes setup
/apprise-api:apprise-api configure         # APPRISE_* environment variables
/apprise-api:apprise-api notify            # Build a notification request
/apprise-api:apprise-api key my-alerts     # Manage a stateful configuration key
/apprise-api:apprise-api url discord       # Build an Apprise service URL
/apprise-api:apprise-api tags              # Tag routing expressions
/apprise-api:apprise-api attach            # Send attachments
/apprise-api:apprise-api webhook           # Map a third-party webhook payload
/apprise-api:apprise-api troubleshoot 424  # Diagnose a response code
/apprise-api:apprise-api sync              # Refresh cached upstream docs
```

## Quick Start

```bash
docker run --name apprise -p 8000:8000 \
  -v ./config:/config -v ./attach:/attach \
  -e APPRISE_STATEFUL_MODE=simple -e APPRISE_ADMIN=y \
  -d caronc/apprise:latest

curl -X POST -d 'urls=discord://webhook_id/webhook_token' \
  -d 'body=Hello from Apprise' http://localhost:8000/notify
```

## Documentation Sync

Upstream docs are cached under `skills/apprise-api/docs/` and refreshed by CI (bi-weekly)
or on demand:

```bash
.github/workflows/scripts/sync-skill.sh skills/apprise-api          # sync
.github/workflows/scripts/sync-skill.sh skills/apprise-api --force  # ignore freshness
.github/workflows/scripts/sync-skill.sh skills/apprise-api --dry-run
./skills/apprise-api/discover-pages.sh                              # find new upstream pages
./skills/apprise-api/discover-pages.sh --auto-add                   # and track them
```

Sources are pulled as raw Markdown from `caronc/apprise-docs` (`locales/en/`) rather than
scraped from the rendered site, so syncs stay stable and diffable.

## Upstream Sources

- **Repository**: https://github.com/caronc/apprise-api
- **Documentation**: https://appriseit.com/api/
- **Docs source**: https://github.com/caronc/apprise-docs
- **Core library**: https://github.com/caronc/apprise
- **Container image**: https://hub.docker.com/r/caronc/apprise
