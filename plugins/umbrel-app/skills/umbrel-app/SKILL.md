---
name: umbrel-app
description: Expert Umbrel app developer. Use when the user wants to create, package, validate, test, debug, or submit apps for umbrelOS. Triggers on mentions of Umbrel apps, umbrelOS, app packaging, or Docker-to-Umbrel conversion.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Umbrel App Development Skill

You are an expert at developing, packaging, testing, and submitting apps for umbrelOS. This skill covers the complete lifecycle of Umbrel app development.

## Core Capabilities

1. **Scaffold** - Create new apps from scratch with proper structure
2. **Validate** - Check apps for 20+ common issues
3. **Convert** - Transform Docker Compose apps to Umbrel format
4. **PR Generation** - Create submission-ready PR content
5. **Debug** - Troubleshoot installation and runtime issues

---

## 1. APP SCAFFOLDING

When creating a new app, gather:
- **App name**: Human-readable (e.g., "BTC RPC Explorer")
- **App ID**: Lowercase with dashes (e.g., "btc-rpc-explorer")
- **Category**: `files`, `finance`, `media`, `networking`, `social`, `automation`, `developer`, `gaming`
- **Docker image**: Repository and tag
- **Port**: Web UI port
- **Dependencies**: Required apps (bitcoin, lightning, electrs)

### Directory Structure

```
<app-id>/
├── docker-compose.yml
├── umbrel-app.yml
└── exports.sh
```

### docker-compose.yml Template

```yaml
version: "3.7"

services:
  app_proxy:
    environment:
      APP_HOST: <app-id>_web_1
      APP_PORT: <port>
      # PROXY_AUTH_ADD: "false"  # Disable auth
      # PROXY_AUTH_WHITELIST: "/api/*"  # Protect only these
      # PROXY_AUTH_BLACKLIST: "/admin/*"  # Unprotect these

  web:
    image: <image>:<tag>@sha256:<digest>
    restart: on-failure
    stop_grace_period: 1m
    volumes:
      - ${APP_DATA_DIR}/data:/data
    environment:
      PORT: <port>
```

### umbrel-app.yml Template

```yaml
manifestVersion: 1
id: <app-id>
category: <category>
name: <App Name>
version: "1.0.0"
tagline: <Short description>
description: >-
  <Detailed description>
releaseNotes: >-
  Initial release.
developer: <Developer Name>
website: <https://example.com>
dependencies: []
repo: <https://github.com/user/repo>
support: <https://github.com/user/repo/issues>
port: <port>
gallery:
  - 1.jpg
  - 2.jpg
  - 3.jpg
path: ""
defaultUsername: ""
defaultPassword: ""
submitter: <Your Name>
submission: https://github.com/getumbrel/umbrel-apps/pull/XXX
```

### exports.sh Template

```bash
# Export environment variables for other apps
# export APP_<APP_ID_UPPERCASE>_VARIABLE="value"
```

---

## 2. VALIDATION CHECKLIST

### File Structure
- [ ] `docker-compose.yml` exists
- [ ] `umbrel-app.yml` exists
- [ ] `exports.sh` exists

### docker-compose.yml
- [ ] Version is "3.7"
- [ ] `app_proxy` service with `APP_HOST` and `APP_PORT`
- [ ] Image uses SHA256 digest (`@sha256:`)
- [ ] `restart: on-failure` set
- [ ] `stop_grace_period` set
- [ ] Volumes use `${APP_DATA_DIR}`
- [ ] No hardcoded IPs

### umbrel-app.yml
- [ ] `manifestVersion` is 1 or 1.1
- [ ] `id` is lowercase alphanumeric with dashes
- [ ] `id` matches directory name
- [ ] Valid `category`
- [ ] `version` follows semver
- [ ] `port` matches docker-compose
- [ ] `gallery` has 3-5 images
- [ ] `submitter` present

### Critical Issues
- Image without SHA256 digest
- Missing `app_proxy` service
- Wrong `APP_HOST` format
- Port mismatch
- Hardcoded secrets

---

## 3. DOCKER-TO-UMBREL CONVERSION

### Environment Variable Mapping

| Original | Umbrel Variable |
|----------|-----------------|
| Bitcoin RPC host | `$APP_BITCOIN_NODE_IP` |
| Bitcoin RPC port | `$APP_BITCOIN_RPC_PORT` |
| Bitcoin RPC user | `$APP_BITCOIN_RPC_USER` |
| Bitcoin RPC pass | `$APP_BITCOIN_RPC_PASS` |
| LND host | `$APP_LIGHTNING_NODE_IP` |
| LND gRPC port | `$APP_LIGHTNING_NODE_GRPC_PORT` |
| LND REST port | `$APP_LIGHTNING_NODE_REST_PORT` |
| Electrum host | `$APP_ELECTRS_NODE_IP` |
| Electrum port | `$APP_ELECTRS_NODE_PORT` |
| Tor proxy | `$TOR_PROXY_IP:$TOR_PROXY_PORT` |

### Get Image Digest

```bash
docker pull <image>:<tag>
docker inspect --format='{{index .RepoDigests 0}}' <image>:<tag>
```

---

## 4. PR SUBMISSION

### Required Assets
- 256x256 SVG icon (no rounded corners)
- 3-5 gallery images at 1440x900px PNG

### PR Template

```markdown
# App Submission

### App name
<Name>

### 256x256 SVG icon
<!-- Upload here -->

### Gallery images (1440x900 PNG)
<!-- Upload 3-5 screenshots -->

### Tested on:
- [ ] Raspberry Pi 4/5
- [ ] x86 hardware
- [ ] Linux VM
- [ ] Umbrel Home
- [ ] umbrel-dev

### Checklist
- [ ] docker-compose.yml includes app_proxy
- [ ] Docker images use SHA256 digests
- [ ] umbrel-app.yml complete
- [ ] Icon is 256x256 SVG
- [ ] 3-5 gallery images
- [ ] Persistent data uses ${APP_DATA_DIR}
```

---

## 5. COMMUNITY APP STORES

Community App Stores allow you to distribute apps without submitting to the official Umbrel App Store.

### Creating a Community App Store

1. Use the template: https://github.com/getumbrel/umbrel-community-app-store
2. Create `umbrel-app-store.yml`:
```yaml
id: "mystore"  # Unique prefix for all apps
name: "My Store"  # Displays as "My Store Community App Store"
```
3. App folders must be prefixed with store ID: `mystore-myapp/`

### CRITICAL: Icon & Gallery Handling

**Icons DO NOT work from the app folder in community stores!**

Umbrel tries to fetch icons from the official gallery repo, causing broken icons.
See: https://github.com/getumbrel/umbrel/issues/1998

**Workaround:** Use a separate gallery repository with full URLs.

#### Step 1: Create Gallery Repository

Create a repo like `username/umbrel-apps-gallery`:
```
umbrel-apps-gallery/
└── mystore-myapp/
    ├── icon.png      # 256x256 PNG (or SVG)
    ├── 1.jpg         # 1440x900 gallery image
    ├── 2.jpg
    └── 3.jpg
```

#### Step 2: Add `icon:` Field to umbrel-app.yml

```yaml
manifestVersion: 1
id: mystore-myapp
name: My App
icon: https://raw.githubusercontent.com/username/umbrel-apps-gallery/main/mystore-myapp/icon.png
category: automation
# ... rest of manifest
gallery:
  - https://raw.githubusercontent.com/username/umbrel-apps-gallery/main/mystore-myapp/1.jpg
  - https://raw.githubusercontent.com/username/umbrel-apps-gallery/main/mystore-myapp/2.jpg
  - https://raw.githubusercontent.com/username/umbrel-apps-gallery/main/mystore-myapp/3.jpg
```

**Key points:**
- Use full raw GitHub URLs for `icon:` and `gallery:` fields
- PNG works fine (doesn't have to be SVG)
- The `icon:` field is NOT in the official template but IS required for community stores

### Adding Community Store to Umbrel

```bash
# Via UI: App Store → Community App Stores → Add URL
# Via CLI:
ssh umbrel@umbrel.local
sudo ~/umbrel/scripts/repo add https://github.com/username/umbrel-apps.git
sudo ~/umbrel/scripts/repo update
```

---

## 6. DEBUGGING

### Common Issues

**App won't install:**
- Invalid YAML syntax
- Image not available for architecture
- Missing dependencies
- Port conflict

**Bad Gateway:**
- Wrong `APP_HOST`
- Wrong `APP_PORT`
- App not fully started

**Data not persisting:**
- Volumes not mounted
- Wrong path (not `${APP_DATA_DIR}`)

### Debug Commands

```bash
# SSH into Umbrel
ssh umbrel@umbrel.local

# View logs
docker logs <container-name>
umbreld client apps.logs --appId <app-id>

# Enter container
docker exec -it <container-name> /bin/sh

# Check app data
ls -la ~/umbrel/app-data/<app-id>/

# Restart/Reinstall
umbreld client apps.restart.mutate --appId <app-id>
umbreld client apps.uninstall.mutate --appId <app-id>
umbreld client apps.install.mutate --appId <app-id>
```

---

## 7. TESTING

### Dev Environment

```bash
# Clone and start
git clone https://github.com/getumbrel/umbrel.git
cd umbrel && npm run dev

# Copy app
rsync -av <app-id>/ umbrel@umbrel-dev.local:/home/umbrel/umbrel/app-stores/getumbrel-umbrel-apps-github-53f74447/<app-id>/

# Install
npm run dev client -- apps.install.mutate -- --appId <app-id>
```

### Physical Device

```bash
rsync -av <app-id>/ umbrel@umbrel.local:/home/umbrel/umbrel/app-stores/getumbrel-umbrel-apps-github-53f74447/<app-id>/
ssh umbrel@umbrel.local
umbreld client apps.install.mutate --appId <app-id>
```

---

## Available Environment Variables

**System:** `$DEVICE_HOSTNAME`, `$DEVICE_DOMAIN_NAME`

**Tor:** `$TOR_PROXY_IP`, `$TOR_PROXY_PORT`

**App:** `$APP_HIDDEN_SERVICE`, `$APP_PASSWORD`, `$APP_SEED`, `$APP_DATA_DIR`

**Bitcoin:** `$APP_BITCOIN_NODE_IP`, `$APP_BITCOIN_RPC_PORT`, `$APP_BITCOIN_RPC_USER`, `$APP_BITCOIN_RPC_PASS`, `$APP_BITCOIN_DATA_DIR`

**Lightning:** `$APP_LIGHTNING_NODE_IP`, `$APP_LIGHTNING_NODE_GRPC_PORT`, `$APP_LIGHTNING_NODE_REST_PORT`, `$APP_LIGHTNING_NODE_DATA_DIR`

**Electrs:** `$APP_ELECTRS_NODE_IP`, `$APP_ELECTRS_NODE_PORT`

---

## Valid Categories

`files`, `finance`, `media`, `networking`, `social`, `automation`, `developer`, `gaming`

---

## 8. SYNC & UPDATE

This skill should stay synchronized with the official Umbrel documentation.

### Upstream Source

```
https://raw.githubusercontent.com/getumbrel/umbrel-apps/master/README.md
```

### Sync Command

When user runs `sync`:

1. Use WebFetch to get the latest README from the URL above
2. Extract and compare key sections:
   - Dockerfile requirements
   - Directory structure
   - docker-compose.yml format
   - umbrel-app.yml manifest fields
   - Environment variables
   - Testing procedures
   - Submission requirements
3. Identify any differences from current skill
4. Update this SKILL.md file with new/changed information
5. Report changes to user

### Diff Command

When user runs `diff`:

1. Fetch the upstream documentation
2. Compare against current skill content
3. Report differences WITHOUT making changes
4. Highlight:
   - New requirements added upstream
   - Changed configurations or fields
   - Deprecated features
   - New environment variables
   - Updated commands

### Key Sections to Monitor

| Section | What to Check |
|---------|---------------|
| Dockerfile | Best practices, multi-arch support |
| docker-compose.yml | app_proxy config, version, services |
| umbrel-app.yml | Manifest fields, manifestVersion |
| Environment Variables | New vars, deprecated vars |
| Testing | Commands, dev environment setup |
| Submission | PR requirements, assets |

### Last Sync Info

Store sync metadata in the skill when updating:
- Last sync date
- Upstream commit/version if available
- Changes made
