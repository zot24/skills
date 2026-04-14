<!-- Source: https://docs.honcho.dev/v3/guides/gmail -->

# Gmail Integration

## Overview

The Gmail integration enables loading email threads into Honcho, transforming conversations into sessions with participants as peers.

## Data Mapping

| Gmail Element | Honcho Element | Purpose |
|---|---|---|
| Gmail account | Workspace | Container for all email data |
| Email participant | Peer | Deduplicated conversation participant |
| Email thread | Session | Complete thread with all participants |
| Individual email | Message | Timestamped message from sender |

## Key Features

- **Peer Deduplication**: Email addresses normalize to URL-safe peer IDs (e.g., `alice@example.com` becomes `alice-example-com`)
- **Participant Extraction**: Captures senders, recipients, CC, and BCC addresses
- **Quoted Reply Stripping**: Removes redundant quoted text
- **Timestamp Preservation**: Original email timestamps via `created_at`

## Setup

1. Create a Google Cloud project with Gmail API enabled
2. Configure OAuth consent screen
3. Generate OAuth credentials (Desktop app type)
4. Download `client_secret_*.json` file
5. Install: `google-api-python-client`, `google-auth-oauthlib`, `honcho-ai`

## Usage

**Preview import:**
```bash
python honcho_gmail.py --dry-run --max-threads 5
```

**Load emails:**
```bash
export HONCHO_API_KEY=your_key
python honcho_gmail.py --workspace gmail-inbox --max-threads 20
```

**Filter options**: Support Gmail search syntax like `from:alice@example.com`, `label INBOX`, or `after:2024/01/01 has:attachment`

## Post-Import Querying

```python
honcho = Honcho(workspace_id="gmail-inbox", api_key=os.environ["HONCHO_API_KEY"])
alice = honcho.peer("alice-example-com")
alice.chat("What action items has Alice mentioned?")
```
