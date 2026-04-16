---
name: github-issue-management
description: Manage GitHub Issues created by gh-issue-tracker. Covers label setup, project board configuration, triage workflows, issue cleanup, and monitoring error volume.
type: project
version: 1.0.0
triggers:
  - "manage error issues"
  - "setup error labels"
  - "triage errors"
  - "cleanup error issues"
  - "error issue management"
  - "organize error reports"
---

# GitHub Issue Management Skill

Manage, triage, and monitor GitHub Issues created by `gh-issue-tracker`.

## Label Taxonomy

### Auto-created labels (by the tracker)

| Label | Purpose |
|-------|---------|
| `error-report` | Applied to every issue created by the tracker |
| `fingerprint:<12-char-hex>` | Unique error identity for dedup searches |

### Recommended additional labels

Create these manually or via `gh label create`:

```bash
# Environment labels
gh label create "env:production" --color "d73a4a" --description "Error from production"
gh label create "env:staging" --color "fbca04" --description "Error from staging"
gh label create "env:development" --color "0e8a16" --description "Error from development"

# Triage labels
gh label create "triaged" --color "5319e7" --description "Error has been reviewed"
gh label create "wontfix-error" --color "ffffff" --description "Known/expected error, will not fix"
gh label create "high-frequency" --color "d93f0b" --description "Error occurring frequently"

# Source labels (for multi-app repos)
gh label create "source:api" --color "1d76db" --description "Error from API server"
gh label create "source:web" --color "0075ca" --description "Error from web app"
gh label create "source:worker" --color "006b75" --description "Error from background worker"
```

## Filtering Issues

### Common gh CLI queries

```bash
# All open error reports
gh issue list --label "error-report" --state open

# Errors from production only
gh issue list --label "error-report,env:production"

# Find a specific error by fingerprint
gh issue list --label "fingerprint:abc123def456" --state all

# Untriaged errors (has error-report but NOT triaged)
gh issue list --label "error-report" --state open | grep -v "triaged"

# Recent error reports (last 7 days)
gh issue list --label "error-report" --state open --json number,title,createdAt \
  --jq '.[] | select(.createdAt > (now - 604800 | strftime("%Y-%m-%dT%H:%M:%SZ")))'

# Count open errors
gh issue list --label "error-report" --state open --json number --jq length
```

## Monitoring Error Volume

### Reaction count = occurrence count

Each time a duplicate error occurs, the tracker adds a thumbs-up reaction to the existing issue. The reaction count indicates how frequently the error occurs.

```bash
# Get error issues with reaction counts (most reacted first)
gh issue list --label "error-report" --state open --json number,title,reactionGroups \
  --jq 'sort_by(-(.reactionGroups[] | select(.content == "THUMBS_UP") | .totalCount // 0)) | .[] | "\(.number)\t\(.reactionGroups[] | select(.content == "THUMBS_UP") | .totalCount // 0)\t\(.title)"'

# Simple version: list issues sorted by reaction count
gh api "repos/{owner}/{repo}/issues?labels=error-report&state=open&sort=reactions-+1&direction=desc&per_page=20" \
  --jq '.[] | "#\(.number) [\(.reactions["+1"]) hits] \(.title)"'
```

## GitHub Project Board Setup

Create a project board for error triage:

```bash
# Create project (GitHub CLI v2+)
gh project create --title "Error Triage" --owner @me

# Recommended columns/status values:
# - New          → Freshly created error reports
# - Triaged      → Reviewed, assigned priority
# - In Progress  → Someone is working on the fix
# - Resolved     → Fix deployed
# - Won't Fix    → Known/expected, no action needed
```

### Automation suggestions

1. **Auto-add new errors to project**: Use GitHub Actions to add issues with `error-report` label to the project board.
2. **Auto-close stale errors**: Close error issues that haven't recurred in 30+ days.
3. **Weekly digest**: Use GitHub Actions scheduled workflow to post a summary of error volume.

## Bulk Operations

### Close stale error issues

```bash
# Close error reports older than 30 days with no recent activity
gh issue list --label "error-report" --state open --json number,updatedAt \
  --jq '.[] | select(.updatedAt < (now - 2592000 | strftime("%Y-%m-%dT%H:%M:%SZ"))) | .number' \
  | xargs -I {} gh issue close {} --comment "Auto-closed: no recurrence in 30+ days. Will reopen if the error recurs."
```

### Remove old fingerprint labels

Fingerprint labels accumulate over time. Clean up labels for closed issues:

```bash
# List fingerprint labels with no open issues
gh label list --json name --jq '.[] | select(.name | startswith("fingerprint:")) | .name' \
  | while read label; do
    count=$(gh issue list --label "$label" --state open --json number --jq length)
    if [ "$count" = "0" ]; then
      echo "Unused: $label"
      # Uncomment to delete: gh label delete "$label" --yes
    fi
  done
```

## Triage Workflow

1. **Review new errors**: `gh issue list --label "error-report" --state open` (filter out `triaged`)
2. **Assess severity**: Check reaction count (frequency), environment, and stack trace
3. **Label**: Add `triaged`, environment label, and priority label
4. **Assign**: Assign to the relevant team member
5. **Track**: Move to "In Progress" on project board
6. **Resolve**: Close issue when fix is deployed. If the error recurs, the tracker will reopen it automatically.
