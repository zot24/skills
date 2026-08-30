---
name: apprise-api
description: Expert at the Apprise API (caronc/apprise-api) — the self-hosted, containerized notification gateway that fans one HTTP request out to 100+ services (Discord, Slack, Telegram, ntfy, Gotify, email, SMS, Matrix, Pushover). Use when deploying the caronc/apprise container, writing docker-compose or Kubernetes manifests for it, saving stateful configuration keys, building Apprise notification URLs, tagging and routing notifications, sending attachments, mapping third-party webhook payloads, or tuning APPRISE_* environment variables. Triggers on mentions of apprise, apprise-api, appriseit, caronc/apprise, notification gateway, /notify endpoint, apprise:// URLs.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Apprise API

You are an expert at deploying, configuring, and driving the **Apprise API** — a lightweight
container that exposes the Apprise notification library over HTTP.

## Overview

- **One gateway, 100+ services** — a single `POST` fans out to Discord, Slack, Telegram, ntfy, Gotify, email, SMS, Matrix, and more
- **Two modes** — *stateless* (URLs in the request) and *stateful* (URLs saved under a `{KEY}`)
- **Universal URL syntax** — every service is a URL: `discord://webhook_id/webhook_token`
- **Tag routing** — group URLs by tag, then notify a subset with AND/OR tag expressions
- **Attachments** — multipart upload, remote HTTP URL, or a JSON `{url, filename}` object
- **Webhook payload mapping** — remap third-party JSON fields into `title`/`body` with `?:field=`
- **Ops-ready** — `/status` health check, `/metrics` for Prometheus, read-only rootless containers

## Quick Start

```bash
docker run --name apprise -p 8000:8000 \
  -v ./config:/config -v ./attach:/attach \
  -e APPRISE_STATEFUL_MODE=simple -e APPRISE_ADMIN=y \
  -d caronc/apprise:latest

# Stateless — URLs travel with the request
curl -X POST -d 'urls=discord://id/token' -d 'body=Deploy finished' \
  http://localhost:8000/notify

# Stateful — save once under a key, then notify by key
curl -X POST -d 'urls=discord://id/token' -d 'urls=mailto://user:pass@gmail.com' \
  http://localhost:8000/add/my-alerts
curl -X POST -d 'body=Deploy finished' http://localhost:8000/notify/my-alerts
```

## Core Concepts

**Stateless vs stateful.** Stateless (`/notify`) keeps credentials in the caller and stores
nothing. Stateful (`/add/{KEY}` then `/notify/{KEY}`) keeps credentials on the server, so
callers only need a key. `APPRISE_STATEFUL_MODE` selects `hash` (default), `simple`, or
`disabled`; `APPRISE_CONFIG_LOCK=yes` freezes saved config for read-only production use.

**Keys.** 1–128 chars, alphanumeric plus `_` and `-`. Treat a key as a secret on any shared
or internet-facing server. Default key is `apprise` (`APPRISE_DEFAULT_CONFIG_ID`).

**Tags.** `TagA, TagB` is OR; `TagA TagB` (or `TagA+TagB`) is AND; combine as
`TagA TagC, TagB`. Pass `tag=` on `/notify/{KEY}` to route to a subset of saved URLs.

## Endpoints

| Path | Method | Purpose |
| --- | --- | --- |
| `/status` | GET | Health check — `200` healthy, `417` degraded |
| `/notify` | POST | Stateless notify — `urls`, `body`, `title`, `type`, `format`, `attach` |
| `/add/{KEY}` | POST | Save config — `urls` or `config` + `format` (text/yaml) |
| `/get/{KEY}` | POST | Read config back (alias `/cfg/{KEY}`) |
| `/del/{KEY}` | POST | Delete saved config |
| `/notify/{KEY}` | POST | Notify a saved config — adds `tag` |
| `/json/urls/{KEY}` | GET | List saved URLs and tags as JSON |
| `/details` | GET | All supported service URLs (`Accept: application/json`) |
| `/metrics` | GET | Prometheus metrics |

## Documentation

**API server**
- **[Introduction](docs/api-introduction.md)** — what the API is and when to use it
- **[Deployment](docs/deployment.md)** — Docker, Compose, Kubernetes, hardening, reverse proxy
- **[API Usage](docs/usage.md)** — stateless and stateful request walkthroughs
- **[Endpoints](docs/endpoints.md)** — compact endpoint and payload reference
- **[Integrations](docs/integrations.md)** — webhook payload mapping, third-party senders
- **[Environment Variables](docs/environment-variables.md)** — every `APPRISE_*` setting
- **[Response Codes](docs/response-codes.md)** — 200/204/400/405/424/431/500 meanings
- **[OpenAPI](docs/openapi.md)** — Swagger spec and how to serve it
- **[Reference Index](docs/reference-index.md)** — reference-section map
- **[Upstream README](docs/readme-upstream.md)** — full caronc/apprise-api README

**Notification URLs & config**
- **[Universal URL Syntax](docs/universal-syntax.md)** — how Apprise URLs are structured
- **[Configuration](docs/configuration.md)** — TEXT vs YAML config files and tagging
- **[Supported Services](docs/services.md)** — service catalogue index
- **[apprise:// scheme](docs/apprise-url-scheme.md)** — point the CLI/library at this API
- **[Tag Matching](docs/tag-matching.md)** — AND/OR tag expression rules
- **[Attachments](docs/attachments.md)** — file, URL, and JSON attachment forms
- **[Formatting](docs/formatting.md)** — text, markdown, and HTML bodies

**Getting started & CLI**
- **[Getting Started](docs/getting-started.md)** — Apprise fundamentals
- **[Installation](docs/getting-started-installation.md)** — installing Apprise itself
- **[Quick Start](docs/getting-started-quick-start.md)** — first notification
- **[CLI](docs/cli.md)** / **[CLI Usage](docs/cli-usage.md)** — `apprise` command arguments
- **[CLI Persistent Storage](docs/cli-persistent-storage.md)** — CLI-side state

**Troubleshooting**
- **[Q&A Index](docs/qa.md)** — troubleshooting map
- **[Error Lookup](docs/error-lookup.md)** — diagnosing failed notifications
- **[Special Characters](docs/special-characters.md)** — escaping credentials in URLs
- **[Data Overflow](docs/data-overflow.md)** — message truncation and splitting
- **[Formatting Issues](docs/qa-formatting-issues.md)** — body renders wrong
- **[Resource Usage](docs/qa-resource-usage.md)** — memory/worker tuning
- **[PyInstaller](docs/qa-pyinstaller.md)** — bundling Apprise into a binary

**Guides**
- **[Guides Index](docs/guides.md)** · **[Home Assistant](docs/guide-home-assistant.md)** · **[Fail2Ban](docs/guide-fail2ban.md)**

## Common Workflows

**Stand up a hardened stack** — read `docs/deployment.md`, mount `/config`, `/attach`,
`/plugin`, set `APPRISE_STATEFUL_MODE`, `APPRISE_WORKER_COUNT`, and `TZ`, then verify with
`curl -f http://host:8000/status`.

**Lock down a production server** — set `APPRISE_CONFIG_LOCK=yes` and `APPRISE_API_ONLY=yes`,
restrict plugins with `APPRISE_ALLOW_SERVICES` / `APPRISE_DENY_SERVICES`, and put basic auth
or mTLS on a reverse proxy in front (see `docs/deployment.md`).

**Accept a third-party webhook** — map the sender's fields onto Apprise's with the `:` prefix:
`POST /notify/{KEY}?:subject=title&:payload=body`. Dot and bracket notation reach nested
values (`?:event.title=title`). See `docs/integrations.md`.

**Debug a failing notification** — check the response code against `docs/response-codes.md`
(`424` means partial failure), then `docs/error-lookup.md`, and confirm URL escaping in
`docs/special-characters.md`.

## Upstream Sources

- **Repository**: https://github.com/caronc/apprise-api
- **Documentation**: https://appriseit.com/api/
- **Docs source**: https://github.com/caronc/apprise-docs (`locales/en/`)
- **Core library**: https://github.com/caronc/apprise

## Sync & Update

When user runs `sync`: run `.github/workflows/scripts/sync-skill.sh skills/apprise-api` to
refetch every source in `sync.json` into `docs/`.
When user runs `diff`: run the same script with `--dry-run` to report upstream drift without
writing.
