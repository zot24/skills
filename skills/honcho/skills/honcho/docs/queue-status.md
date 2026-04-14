<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/queue-status -->

# Queue Status

## Overview

Honcho provides utilities to monitor the status of asynchronous reasoning processes. When messages are stored, background processes trigger to reason about conversations and generate insights.

## Checking Queue Status

### Python
```python
from honcho import Honcho
honcho = Honcho()

status = honcho.queue_status()
```

### TypeScript
```typescript
import { Honcho } from '@honcho-ai/sdk';

const honcho = new Honcho({});

const status = await honcho.queueStatus();
```

## Output Structure

### Python Response
```python
class QueueStatus(BaseModel):
    completed_work_units: int
    in_progress_work_units: int
    pending_work_units: int
    total_work_units: int
    sessions: Optional[Dict[str, Sessions]] = None
```

### TypeScript Response
```typescript
Promise<{
    totalWorkUnits: number
    completedWorkUnits: number
    inProgressWorkUnits: number
    pendingWorkUnits: number
    sessions?: Record<string, QueueStatus.Sessions>
}>
```

## Work Units

A "work unit" combines sender identity, session, and observer parameters. Key characteristics:

- Tasks within the same work unit process sequentially
- Multiple work units process in parallel
- Additional work units generate for observers with `observe_others=True`

## Tracked Task Types

| Task Type | Purpose |
|-----------|---------|
| **representation** | Memory formation and observation extraction |
| **summary** | Session summarization at configurable intervals |
| **dream** | Memory consolidation and improvement |

## Scoping Parameters

Both client and session-level methods accept optional filtering:

```python
queue_status(
    observer_id: str | None = None,
    sender_id: str | None = None,
    session_id: str | None = None,
)
```

## Important Considerations

Do not wait for the queue to be empty. The queue is a continuous processing system -- new messages may arrive at any time. Use queue status for observability and debugging, not synchronization. Completed counts reflect items since the last cleanup cycle, not lifetime totals.
