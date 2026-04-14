<!-- Source: https://docs.honcho.dev/v3/guides/granola -->

# Granola Meeting Import

## Overview

Import Granola meeting data into Honcho, enabling agents to access queryable memories of meetings and participants.

## Quick Start

```bash
pip install honcho-ai httpx
export HONCHO_API_KEY="your-key-from-app.honcho.dev"
python honcho_granola.py
```

## Data Mapping

| Granola | Honcho | Details |
|---------|--------|---------|
| Your account | Workspace (`granola`) | Single workspace for all meetings |
| Meeting participant | Peer | Email-based ID for cross-meeting deduplication |
| Individual meeting | Session (`meeting-{id}`) | One session per meeting |
| Transcript turns | Messages with attribution | Full speaker attribution for two-person calls |
| Meeting summary | Message from note creator | Multi-person calls use summaries |

## Key Design Decisions

- **Email-Based Peer Identification**: Normalized email addresses as peer IDs (e.g., `alice-example-com`)
- **Automatic Creator Detection**: Identifies note creator via Granola's "(note creator)" marker
- **Two-Person Call Attribution**: Full speaker attribution with merged consecutive turns
- **Multi-Person Call Summaries**: Uses Granola's summary for multi-person meetings
- **Interactive Mode Selection**: Choose import approach per meeting

## Querying Imported Meetings

```python
from honcho import Honcho

honcho = Honcho(workspace_id="granola", api_key=os.environ["HONCHO_API_KEY"])
alice = honcho.peer("alice-example-com")
print(alice.chat("What is Alice working on?"))
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Granola OAuth fails | Requires paid Granola plan (Pro+). Clear cached token and retry. |
| Missing transcripts | Free tier lacks transcript access. Falls back to summary content. |
| 500 errors from Honcho | Check for null bytes or control characters. |
| Rate limiting | Script processes sequentially with delays. |
