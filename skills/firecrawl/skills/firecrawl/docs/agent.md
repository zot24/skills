> Source: https://docs.firecrawl.dev/features/agent



More


# Agent


Gather data wherever it lives on the web.


- For **a single known URL**, <a href="/features/llm-extract" class="link">JSON mode on <code>/scrape</code></a> is cheaper and synchronous.
- Full comparison: <a href="/developer-guides/usage-guides/choosing-the-data-extractor" class="link">Choosing the Data Extractor</a>.


- **No URLs Required**: Just describe what you need via `prompt` parameter. URLs are optional
- **Deep Web Search**: Autonomously searches and navigates deep into sites to find your data
- **Reliable and Accurate**: Works with a wide variety of queries and use cases
- **Faster**: Processes multiple sources in parallel for quicker results


## Try it in the Playground


## <a href="#using-/agent" class="anchor-link" aria-label="Navigate to header: Using /agent"></a><span id="_R_f9crmhkd74t9_" class="cursor-pointer">Using `/agent`</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl
from pydantic import BaseModel, Field
from typing import List, Optional

app = Firecrawl(api_key="fc-YOUR_API_KEY")

class Founder(BaseModel):
    name: str = Field(description="Full name of the founder")
    role: Optional[str] = Field(None, description="Role or position")
    background: Optional[str] = Field(None, description="Professional background")

class FoundersSchema(BaseModel):
    founders: List[Founder] = Field(description="List of founders")

result = app.agent(
    prompt="Find the founders of Firecrawl",
    schema=FoundersSchema,
    model="spark-2",
    max_credits=100
)

print(result.data)
```


``` shiki
import { Firecrawl } from 'firecrawl';
import { z } from 'zod';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

const result = await firecrawl.agent({
  prompt: "Find the founders of Firecrawl",
  schema: z.object({
    founders: z.array(z.object({
      name: z.string().describe("Full name of the founder"),
      role: z.string().describe("Role or position").optional(),
      background: z.string().describe("Professional background").optional()
    })).describe("List of founders")
  }),
  model: "spark-2",
  maxCredits: 100
});

console.log(result.data);
```


``` shiki
curl -X POST "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Find the founders of Firecrawl",
    "model": "spark-2",
    "maxCredits": 100,
    "schema": {
      "type": "object",
      "properties": {
        "founders": {
          "type": "array",
          "description": "List of founders",
          "items": {
            "type": "object",
            "properties": {
              "name": { "type": "string", "description": "Full name" },
              "role": { "type": "string", "description": "Role or position" },
              "background": { "type": "string", "description": "Professional background" }
            },
            "required": ["name"]
          }
        }
      },
      "required": ["founders"]
    }
  }'
```


### <a href="#response" class="anchor-link" aria-label="Navigate to header: Response"></a><span id="_R_l9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Response</span>


``` shiki
{
  "success": true,
  "status": "completed",
  "data": {
    "founders": [
      {
        "name": "Eric Ciarla",
        "role": "Co-founder",
        "background": "Previously at Mendable"
      },
      {
        "name": "Nicolas Camara",
        "role": "Co-founder",
        "background": "Previously at Mendable"
      },
      {
        "name": "Caleb Peffer",
        "role": "Co-founder",
        "background": "Previously at Mendable"
      }
    ]
  },
  "expiresAt": "2024-12-15T00:00:00.000Z",
  "creditsUsed": 15
}
```


## <a href="#providing-urls-optional" class="anchor-link" aria-label="Navigate to header: Providing URLs (Optional)"></a><span id="_R_p9crmhkd74t9_" class="cursor-pointer">Providing URLs (Optional)</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

result = app.agent(
    urls=["https://docs.firecrawl.dev", "https://firecrawl.dev/pricing"],
    prompt="Compare the features and pricing information from these pages"
)

print(result.data)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

const result = await firecrawl.agent({
  urls: ["https://docs.firecrawl.dev", "https://firecrawl.dev/pricing"],
  prompt: "Compare the features and pricing information from these pages"
});

console.log(result.data);
```


``` shiki
curl -X POST "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "urls": [
      "https://docs.firecrawl.dev",
      "https://firecrawl.dev/pricing"
    ],
    "prompt": "Compare the features and pricing information from these pages"
  }'
```


## <a href="#choosing-a-location" class="anchor-link" aria-label="Navigate to header: Choosing a location"></a><span id="_R_v9crmhkd74t9_" class="cursor-pointer">Choosing a location</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

result = app.agent(
    prompt="Find the current price of the Nintendo Switch 2 at major German retailers",
    location={"country": "DE"}
)

print(result.data)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

const result = await firecrawl.agent({
  prompt: "Find the current price of the Nintendo Switch 2 at major German retailers",
  location: { country: "DE" }
});

console.log(result.data);
```


``` shiki
curl -X POST "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Find the current price of the Nintendo Switch 2 at major German retailers",
    "location": { "country": "DE" }
  }'
```


## <a href="#safe-search" class="anchor-link" aria-label="Navigate to header: Safe search"></a><span id="_R_1b9crmhkd74t9_" class="cursor-pointer">Safe search</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

# Needs an SDK release with safe support (pending)
result = app.agent(
    prompt="Find age-appropriate science museums in Chicago",
    safe=True
)

print(result.data)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

// Needs an SDK release with safe support (pending)
const result = await firecrawl.agent({
  prompt: "Find age-appropriate science museums in Chicago",
  safe: true
});

console.log(result.data);
```


``` shiki
curl -X POST "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Find age-appropriate science museums in Chicago",
    "safe": true
  }'
```


## <a href="#job-status-and-completion" class="anchor-link" aria-label="Navigate to header: Job Status and Completion"></a><span id="_R_1n9crmhkd74t9_" class="cursor-pointer">Job Status and Completion</span>


- **Default method**: `agent()` waits and returns final results
- **Start then poll**: Use `start_agent` (Python) or `startAgent` (Node) to get a Job ID immediately, then poll with `get_agent_status` / `getAgentStatus`
- **Push instead of poll**: Pass a `webhook` when you start the job to receive <a href="/webhooks/events#agent-events" class="link">agent events</a> as the run progresses and finishes


Job results are available via the API for 24 hours after completion. After this period, you can still view your agent history and results in the <a href="https://www.firecrawl.dev/app/logs" class="link" target="_blank" rel="noreferrer">activity logs</a>.


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

# Start an agent job
agent_job = app.start_agent(
    prompt="Find the founders of Firecrawl"
)

# Check the status
status = app.get_agent_status(agent_job.id)

print(status)
# Example output:
# status='completed'
# success=True
# data={ ... }
# expires_at=datetime.datetime(...)
# credits_used=15
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

// Start an agent job
const started = await firecrawl.startAgent({
  prompt: "Find the founders of Firecrawl"
});

// Check the status
if (started.id) {
  const status = await firecrawl.getAgentStatus(started.id);
  console.log(status.status, status.data);
}
```


``` shiki
curl -X GET "https://api.firecrawl.dev/v2/agent/<jobId>" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"
```


### <a href="#possible-states" class="anchor-link" aria-label="Navigate to header: Possible States"></a><span id="_R_219crmhkd74t9_" class="cursor-pointer">Possible States</span>


| Status | Description |
|----|----|
| `processing` | The agent is still working on your request |
| `completed` | Extraction finished successfully |
| `failed` | An error occurred during extraction, the run reached its `maxCredits` limit (see <a href="#handling-credit-limit-stops" class="link">Handling credit-limit stops</a>), or the job was cancelled (cancelled jobs report `failed` with a cancellation error message) |


#### <a href="#pending-example" class="anchor-link" aria-label="Navigate to header: Pending Example"></a><span id="_R_279crmhkd74t9_" class="cursor-pointer">Pending Example</span>


``` shiki
{
  "success": true,
  "status": "processing",
  "expiresAt": "2024-12-15T00:00:00.000Z"
}
```


#### <a href="#completed-example" class="anchor-link" aria-label="Navigate to header: Completed Example"></a><span id="_R_2b9crmhkd74t9_" class="cursor-pointer">Completed Example</span>


``` shiki
{
  "success": true,
  "status": "completed",
  "data": {
    "founders": [
      {
        "name": "Eric Ciarla",
        "role": "Co-founder"
      },
      {
        "name": "Nicolas Camara",
        "role": "Co-founder"
      },
      {
        "name": "Caleb Peffer",
        "role": "Co-founder"
      }
    ]
  },
  "expiresAt": "2024-12-15T00:00:00.000Z",
  "creditsUsed": 15
}
```


## <a href="#handling-credit-limit-stops" class="anchor-link" aria-label="Navigate to header: Handling credit-limit stops"></a><span id="_R_2f9crmhkd74t9_" class="cursor-pointer">Handling credit-limit stops</span>


| Field | Type | Description |
|----|----|----|
| `stopReason` | string | Why the run stopped early. Currently only `credit_limit_reached`. |
| `partial` | any | Best-effort JSON recovered from the incomplete run. It can be missing rows or fields. |
| `partialSchemaValid` | boolean | Only present when the request included a `schema`. Whether `partial` validates against it. |
| `message` | string | A short note on what is incomplete, when available. |


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl
from pydantic import BaseModel
from typing import List

app = Firecrawl(api_key="fc-YOUR_API_KEY")

class Company(BaseModel):
    name: str
    website: str

class CompaniesSchema(BaseModel):
    companies: List[Company]

result = app.agent(
    prompt="Find every company in the YC W24 batch that builds developer tools",
    schema=CompaniesSchema,
    max_credits=100
)

if result.status == "completed":
    print(result.data)
elif result.status == "failed" and result.stop_reason == "credit_limit_reached":
    # `data` is never set on a failed run. `partial` is best-effort and may be missing.
    if result.partial is not None:
        if result.partial_schema_valid is not True:
            print("The partial result does not match the schema yet.")
        print(result.message, result.partial)

    # Continue the same thread. The agent picks up from the incomplete result.
    # The follow-up inherits the schema but not max_credits, so set a budget.
    follow_up = app.agent(
        thread_id=result.thread_id,
        prompt="Continue and finish the list.",
        max_credits=200
    )
    print(follow_up.status, follow_up.data)
else:
    print(result.error)
```


``` shiki
import { Firecrawl } from 'firecrawl';
import { z } from 'zod';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

const result = await firecrawl.agent({
  prompt: "Find every company in the YC W24 batch that builds developer tools",
  schema: z.object({
    companies: z.array(z.object({
      name: z.string(),
      website: z.string()
    }))
  }),
  maxCredits: 100
});

if (result.status === "completed") {
  console.log(result.data);
} else if (result.status === "failed" && result.stopReason === "credit_limit_reached") {
  // `data` is never set on a failed run. `partial` is best-effort and may be missing.
  if (result.partial !== undefined) {
    if (result.partialSchemaValid !== true) {
      console.warn("The partial result does not match the schema yet.");
    }
    console.log(result.message, result.partial);
  }

  // Continue the same thread. The agent picks up from the incomplete result.
  // The follow-up inherits the schema but not maxCredits, so set a budget.
  const followUp = await firecrawl.agent({
    threadId: result.threadId,
    prompt: "Continue and finish the list.",
    maxCredits: 200
  });
  console.log(followUp.status, followUp.data);
} else {
  console.error(result.error);
}
```


``` shiki
# 1. Poll the run. A credit stop reports "status": "failed" with "stopReason": "credit_limit_reached".
curl -X GET "https://api.firecrawl.dev/v2/agent/<jobId>" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"

# 2. Continue the same thread to finish the work.
curl -X POST "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "threadId": "<threadId from the failed run>",
    "prompt": "Continue and finish the list.",
    "maxCredits": 200
  }'
```


#### <a href="#credit-limit-example" class="anchor-link" aria-label="Navigate to header: Credit-limit Example"></a><span id="_R_2v9crmhkd74t9_" class="cursor-pointer">Credit-limit Example</span>


``` shiki
{
  "success": true,
  "status": "failed",
  "error": "Agent reached max credits",
  "stopReason": "credit_limit_reached",
  "partial": {
    "companies": [
      { "name": "Acme", "website": "https://acme.dev" },
      { "name": "Globex" }
    ]
  },
  "partialSchemaValid": false,
  "message": "Credit limit reached; this result is incomplete.",
  "threadId": "0199bbbb-0000-7000-8000-000000000000",
  "threadTurn": 1,
  "expiresAt": "2024-12-15T00:00:00.000Z",
  "creditsUsed": 0
}
```


## <a href="#listing-agent-runs" class="anchor-link" aria-label="Navigate to header: Listing agent runs"></a><span id="_R_379crmhkd74t9_" class="cursor-pointer">Listing agent runs</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

# List your most recent agent runs
page = app.list_agents()

for run in page.agents:
    print(run.id, run.status, run.target_hint)

# Fetch the next page using the cursor from `next`
if page.next:
    before = int(page.next.split("before=")[-1])
    older = app.list_agents(before=before)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

// List your most recent agent runs
const page = await firecrawl.listAgents();

for (const run of page.agents ?? []) {
  console.log(run.id, run.status, run.targetHint);
}

// Fetch the next page using the cursor from `next`
if (page.next) {
  const before = Number(new URL(page.next).searchParams.get("before"));
  const older = await firecrawl.listAgents({ before });
}
```


``` shiki
curl -X GET "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"

# Fetch the next page (unix ms timestamp from the previous page's `next` URL)
curl -X GET "https://api.firecrawl.dev/v2/agent?before=1756600000000" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"
```


## <a href="#following-a-run-in-progress" class="anchor-link" aria-label="Navigate to header: Following a run in progress"></a><span id="_R_3f9crmhkd74t9_" class="cursor-pointer">Following a run in progress</span>


| Surface | What you get | Best for |
|----|----|----|
| Trace polling | Full detail: every event the run has emitted so far, including tool calls, reasoning summaries, progress phases, and artifact changes | Building your own progress UI, or debugging what a run actually did |
| Webhooks | Push delivery, coarse-grained: the five agent lifecycle events (`agent.started`, `agent.action`, `agent.completed`, `agent.failed`, `agent.cancelled`). See <a href="/webhooks/events" class="link">webhook events</a> | Reacting to a run finishing without holding a poll loop open |
| Live view | A human-watchable view of the agent’s browser. Request the trace with `?liveView=true` and each entry in `activeBrowserSessions` carries a `liveViewUrl` | Watching a run navigate in real time |


Python


Node


cURL


``` shiki
import time
from collections import defaultdict

from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

agent_job = app.start_agent(prompt="Find the founders of Firecrawl")
seen = set()
finished = False
quiet_polls = 0

while True:
    trace = app.get_agent_trace(agent_job.id)

    # producer_sequence is monotonic per emitting agent, so group first.
    by_agent = defaultdict(list)
    for event in trace.events or []:
        by_agent[event.agent.id].append(event)

    new_events = 0
    for agent_id, events in by_agent.items():
        for event in sorted(events, key=lambda e: e.producer_sequence):
            if event.event_id not in seen:
                seen.add(event.event_id)
                new_events += 1
                print(agent_id, event.producer_sequence, event.type)

    if not finished:
        finished = app.get_agent_status(agent_job.id).status != "processing"
    elif new_events:
        quiet_polls = 0
    else:
        # Tail window: events can land for a moment after the run finishes.
        quiet_polls += 1
        if quiet_polls == 3:
            break

    time.sleep(5)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

const started = await firecrawl.startAgent({ prompt: "Find the founders of Firecrawl" });
const seen = new Set();
let finished = false;
let quietPolls = 0;

for (;;) {
  const trace = await firecrawl.getAgentTrace(started.id);

  // producerSequence is monotonic per emitting agent, so group first.
  const byAgent = new Map();
  for (const event of trace.events ?? []) {
    const bucket = byAgent.get(event.agent.id) ?? [];
    bucket.push(event);
    byAgent.set(event.agent.id, bucket);
  }

  let newEvents = 0;
  for (const [agentId, events] of byAgent) {
    for (const event of events.sort((a, b) => a.producerSequence - b.producerSequence)) {
      if (seen.has(event.eventId)) continue;
      seen.add(event.eventId);
      newEvents++;
      console.log(agentId, event.producerSequence, event.type);
    }
  }

  if (!finished) {
    finished = (await firecrawl.getAgentStatus(started.id)).status !== "processing";
  } else if (newEvents) {
    quietPolls = 0;
  } else {
    // Tail window: events can land for a moment after the run finishes.
    if (++quietPolls === 3) break;
  }

  await new Promise((resolve) => setTimeout(resolve, 5000));
}
```


``` shiki
# Print only the events you haven't seen yet, and keep polling through a short
# tail window after the run finishes.
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
: > "$tmp/seen.txt"
finished=0
quiet=0

while [ "$quiet" -lt 3 ]; do
  curl -s "https://api.firecrawl.dev/v2/agent/JOB_ID/trace" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  | jq -r '.events | group_by(.agent.id)[] | sort_by(.producerSequence)[]
           | "\(.eventId) \(.agent.id) \(.producerSequence) \(.type)"' > "$tmp/poll.txt"

  new=$(grep -vxF -f "$tmp/seen.txt" "$tmp/poll.txt")
  [ -n "$new" ] && echo "$new"
  cp "$tmp/poll.txt" "$tmp/seen.txt"

  if [ "$finished" = 0 ]; then
    status=$(curl -s "https://api.firecrawl.dev/v2/agent/JOB_ID" \
      -H "Authorization: Bearer $FIRECRAWL_API_KEY" | jq -r '.status')
    [ "$status" = "processing" ] || finished=1
  elif [ -n "$new" ]; then
    quiet=0
  else
    quiet=$((quiet + 1))
  fi

  sleep 5
done
```


## <a href="#execution-traces-and-snapshots" class="anchor-link" aria-label="Navigate to header: Execution Traces and Snapshots"></a><span id="_R_3p9crmhkd74t9_" class="cursor-pointer">Execution Traces and Snapshots</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

# Execution trace of a run: ordered events (tool calls, reasoning, artifacts)
trace = app.get_agent_trace("JOB_ID")

for event in trace.events or []:
    print(event.type)

# Include currently active browser sessions while the run is in flight
live = app.get_agent_trace("JOB_ID", live_view=True)
for session in live.active_browser_sessions or []:
    print(session.live_view_url)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

// Execution trace of a run: ordered events (tool calls, reasoning, artifacts)
const trace = await firecrawl.getAgentTrace("JOB_ID");

for (const event of trace.events ?? []) {
  console.log(event.type);
}

// Include currently active browser sessions while the run is in flight
const live = await firecrawl.getAgentTrace("JOB_ID", { liveView: true });
console.log(live.activeBrowserSessions);
```


``` shiki
curl "https://api.firecrawl.dev/v2/agent/JOB_ID/trace" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"

# Include currently active browser sessions while the run is in flight
curl "https://api.firecrawl.dev/v2/agent/JOB_ID/trace?liveView=true" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"
```


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

# artifact.updated trace events reference snapshot content by snapshotId
snapshot = app.get_agent_snapshot("JOB_ID", "SNAPSHOT_ID")

print(snapshot.snapshot)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

// artifact.updated trace events reference snapshot content by snapshotId
const snapshot = await firecrawl.getAgentSnapshot("JOB_ID", "SNAPSHOT_ID");

console.log(snapshot.snapshot);
```


``` shiki
curl "https://api.firecrawl.dev/v2/agent/JOB_ID/snapshots/SNAPSHOT_ID" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"
```


Traces and snapshots are recorded on Spark 2 runs, which is every new run; jobs started on Spark 1 models before their retirement do not have them. See the <a href="/api-reference/endpoint/agent-trace" class="link">trace</a> and <a href="/api-reference/endpoint/agent-snapshot" class="link">snapshot</a> API references for the full event schema, and the <a href="/api-reference/errors#agent" class="link">Agent errors</a> catalog for the failures these endpoints return.


## <a href="#getting-the-agent’s-source-data" class="anchor-link" aria-label="Navigate to header: Getting the agent’s source data"></a><span id="_R_459crmhkd74t9_" class="cursor-pointer">Getting the agent’s source data</span>


Python


Node


cURL


``` shiki
import json

from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

trace = app.get_agent_trace("JOB_ID")

for event in trace.events or []:
    if event.type != "artifact.updated":
        continue

    kind = event.artifact.kind
    if kind not in ("markdown", "html", "json"):
        continue

    snapshot = app.get_agent_snapshot("JOB_ID", event.artifact.snapshot_id)

    # markdown, html, and text snapshots are the content itself.
    # json snapshots are JSON-encoded, so decode those.
    content = json.loads(snapshot.snapshot) if kind == "json" else snapshot.snapshot

    print(kind, event.artifact.path, content)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

const trace = await firecrawl.getAgentTrace("JOB_ID");

for (const event of trace.events ?? []) {
  if (event.type !== "artifact.updated") continue;

  const kind = event.artifact.kind;
  if (!["markdown", "html", "json"].includes(kind)) continue;

  const snapshot = await firecrawl.getAgentSnapshot("JOB_ID", event.artifact.snapshotId);

  // markdown, html, and text snapshots are the content itself.
  // json snapshots are JSON-encoded, so decode those.
  const content = kind === "json" ? JSON.parse(snapshot.snapshot) : snapshot.snapshot;

  console.log(kind, event.artifact.path, content);
}
```


``` shiki
# Fetch every markdown, html, or json artifact the run wrote.
curl -s "https://api.firecrawl.dev/v2/agent/JOB_ID/trace" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
| jq -r '.events[]
         | select(.type == "artifact.updated")
         | select(.artifact.kind == "markdown" or .artifact.kind == "html" or .artifact.kind == "json")
         | "\(.artifact.kind) \(.artifact.snapshotId)"' \
| while read -r kind snapshot_id; do
    body=$(curl -s "https://api.firecrawl.dev/v2/agent/JOB_ID/snapshots/$snapshot_id" \
      -H "Authorization: Bearer $FIRECRAWL_API_KEY")

    # markdown and html snapshots are the content itself; json is JSON-encoded.
    if [ "$kind" = "json" ]; then
      printf '%s' "$body" | jq -r '.snapshot | fromjson'
    else
      printf '%s' "$body" | jq -r '.snapshot'
    fi
  done
```


- **Artifacts are the run’s output, not a page-by-page archive.** What a run writes to an artifact depends on how it works through your prompt, so treat the artifact set as what that particular run produced rather than a guaranteed record of every page it opened.
- **Tool results carry the rest.** Each `tool_call.finished` event includes a `result` field holding what that tool returned, which is where content that never became an artifact shows up.

## <a href="#share-agent-runs" class="anchor-link" aria-label="Navigate to header: Share agent runs"></a><span id="_R_4h9crmhkd74t9_" class="cursor-pointer">Share agent runs</span>


## <a href="#model-selection" class="anchor-link" aria-label="Navigate to header: Model Selection"></a><span id="_R_4l9crmhkd74t9_" class="cursor-pointer">Model Selection</span>


### <a href="#spark-2" class="anchor-link" aria-label="Navigate to header: Spark 2"></a><span id="_R_4r9crmhkd74t9_" class="cursor-pointer">Spark 2</span>


- Lowest cost per run
- Fastest run time
- Accuracy comparable to the former Spark 1 flagship
- The only model with a reasoning budget: pass `effort` (`low`, `medium`, or `high`) to control how hard it thinks

### <a href="#specifying-a-model" class="anchor-link" aria-label="Navigate to header: Specifying a Model"></a><span id="_R_539crmhkd74t9_" class="cursor-pointer">Specifying a Model</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

# Spark 2 is the default — every run executes on it
result = app.agent(
    prompt="Find the pricing of Firecrawl",
    model="spark-2"
)

# Deprecated: Spark 1 model names are still accepted, but route to "spark-2".

print(result.data)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

// Spark 2 is the default — every run executes on it
const result = await firecrawl.agent({
  prompt: "Find the pricing of Firecrawl",
  model: "spark-2"
});

// Deprecated: Spark 1 model names are still accepted, but route to "spark-2".

console.log(result.data);
```


``` shiki
# Spark 2 is the default — every run executes on it
curl -X POST "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Find the pricing of Firecrawl",
    "model": "spark-2"
  }'

# Deprecated: Spark 1 model names are still accepted, but route to "spark-2".
```


## <a href="#use-your-connected-alexandria-tools" class="anchor-link" aria-label="Navigate to header: Use your connected Alexandria tools"></a><span id="_R_599crmhkd74t9_" class="cursor-pointer">Use your connected Alexandria tools</span>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

result = app.agent(
    prompt="Find recent podcast episodes about AI agents and who appeared on them",
    exchange={
        "enabled": True,
        # Up to 5 provider slugs. Leave out to let the agent use every provider.
        "toolkits": ["particle"],
    },
)

print(result.data)
if result.exchange:
    print(result.exchange.paid_calls, result.exchange.credits_used)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

const result = await firecrawl.agent({
  prompt: "Find recent podcast episodes about AI agents and who appeared on them",
  exchange: {
    enabled: true,
    // Up to 5 provider slugs. Leave out to let the agent use every provider.
    toolkits: ["particle"]
  }
});

console.log(result.data);
console.log(result.exchange?.paidCalls, result.exchange?.creditsUsed);
```


``` shiki
curl -X POST "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Find recent podcast episodes about AI agents and who appeared on them",
    "exchange": {
      "enabled": true,
      "toolkits": ["particle"]
    }
  }'
```


| Field | What it does |
|----|----|
| `enabled` | Lets the agent call providers. Defaults to `true` once you send `exchange`, so an empty object also turns them on. Send `false` to turn them off for one turn of a thread. |
| `toolkits` | Up to 5 provider slugs, such as `["apollo"]`. The agent uses only those. Empty or left out means every provider your team can use. |
| `maxCalls` | The most provider calls the agent may make in one turn, from 1 to 30. Defaults to 16. |
| `requireApproval` | Stops the turn before any paid provider call and ends it with a `pendingApproval` for you to answer. Needs `mode: "chat"` on the same request. Defaults to `false`. |
| `approve`, `decline` | Answer the previous turn’s `pendingApproval` on the next turn of the thread. See <a href="#approve-paid-calls-before-they-run" class="link">Approve paid calls before they run</a>. |
| `onTermsRequired` | What to do when a provider needs data terms your team hasn’t accepted. See <a href="#data-providers-that-need-terms" class="link">Data providers that need terms</a>. |


### <a href="#follow-up-turns" class="anchor-link" aria-label="Navigate to header: Follow-up turns"></a><span id="_R_5l9crmhkd74t9_" class="cursor-pointer">Follow-up turns</span>


### <a href="#approve-paid-calls-before-they-run" class="anchor-link" aria-label="Navigate to header: Approve paid calls before they run"></a><span id="_R_5p9crmhkd74t9_" class="cursor-pointer">Approve paid calls before they run</span>


- `exchange.approve: { "approvalId": "<pendingApproval.id>" }` runs the calls. Add `callIds` to run only some of them, or `always: true` to stop asking for the rest of the thread.
- `exchange.decline: { "approvalId": "<pendingApproval.id>" }` skips them, and the agent answers without them.


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

# requireApproval needs chat mode on every request that sends it.
first = app.agent(
    prompt="Find the head of engineering at Firecrawl and a verified work email",
    mode="chat",
    exchange={"enabled": True, "toolkits": ["apollo"], "requireApproval": True},
)

approval = first.pending_approval
if approval is None or approval.is_terms:
    print(first.data or first.message)
else:
    for call in approval.calls or []:
        print(call.provider, call.capability, call.credits_estimate)

    # Answer on the next turn of the same thread. Sending requireApproval again
    # keeps later paid calls waiting for approval too.
    result = app.agent(
        thread_id=first.thread_id,
        prompt="Approved, go ahead.",
        mode="chat",
        exchange={"requireApproval": True, "approve": {"approvalId": approval.id}},
        # To refuse instead: exchange={"decline": {"approvalId": approval.id}}
    )
    print(result.data or result.message)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

// requireApproval needs chat mode on every request that sends it.
const first = await firecrawl.agent({
  prompt: "Find the head of engineering at Firecrawl and a verified work email",
  mode: "chat",
  exchange: { enabled: true, toolkits: ["apollo"], requireApproval: true }
});

const approval = first.pendingApproval;
if (!approval || approval.kind === "terms") {
  console.log(first.data ?? first.message);
} else {
  for (const call of approval.calls) {
    console.log(call.provider, call.capability, call.creditsEstimate);
  }

  // Answer on the next turn of the same thread. Sending requireApproval again
  // keeps later paid calls waiting for approval too.
  const result = await firecrawl.agent({
    threadId: first.threadId,
    prompt: "Approved, go ahead.",
    mode: "chat",
    exchange: { requireApproval: true, approve: { approvalId: approval.id } }
    // To refuse instead: exchange: { decline: { approvalId: approval.id } }
  });
  console.log(result.data ?? result.message);
}
```


``` shiki
# 1. Start a run that asks before any paid provider call.
curl -X POST "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Find the head of engineering at Firecrawl and a verified work email",
    "mode": "chat",
    "exchange": { "enabled": true, "toolkits": ["apollo"], "requireApproval": true }
  }'

# 2. Poll the run. When it ends with a pendingApproval, read its id and calls.
curl -X GET "https://api.firecrawl.dev/v2/agent/<jobId>" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"

# 3. Approve on the next turn of the same thread, or send
#    "decline": { "approvalId": "<pendingApproval.id>" } instead.
curl -X POST "https://api.firecrawl.dev/v2/agent" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "threadId": "<threadId from the first run>",
    "prompt": "Approved, go ahead.",
    "mode": "chat",
    "exchange": {
      "requireApproval": true,
      "approve": { "approvalId": "<pendingApproval.id>" }
    }
  }'
```


## <a href="#data-providers-that-need-terms" class="anchor-link" aria-label="Navigate to header: Data providers that need terms"></a><span id="_R_639crmhkd74t9_" class="cursor-pointer">Data providers that need terms</span>


| `onTermsRequired` | What happens |
|----|----|
| `skip` (default) | The run answers with accepted providers only and never blocks. `exchange.skippedProviders` lists the gated providers that would have helped. |
| `ask` | The same as `skip`. The run also ends with `exchange.requiresAction` and a `pendingApproval` of `kind: "terms"`, so you can ask your user, accept, and continue the thread. |


### <a href="#response-fields" class="anchor-link" aria-label="Navigate to header: Response fields"></a><span id="_R_6d9crmhkd74t9_" class="cursor-pointer">Response fields</span>


- `skippedProviders` (any mode): one entry per gated provider that would have helped, with `provider`, `name`, `capability`, `adds` (what it would have added), `reason: "terms_required"`, `version` (the terms version) and `termsUrl` (where to accept in the dashboard).
- `requiresAction` (`ask` only): `type: "accept_terms"`, an `approvalId` and a `providers` list. `approvalId` is always present. It’s the id of the `terms` pending approval you answer when you continue the thread. Each provider carries the exact `show` (`terms/show`) and `accept` (`terms/accept`) calls to make. Each provider’s `digest` (and `accept.options.digest`) is always present and can be `null`, meaning the catalog didn’t publish one. In that case, run `terms/show` first and send the digest it returns.


``` shiki
{
  "status": "completed",
  "exchange": {
    "enabled": true,
    "onTermsRequired": "ask",
    "paidCalls": 0,
    "creditsUsed": null,
    "skippedProviders": [
      {
        "provider": "apollo",
        "name": "Apollo",
        "capability": "people/search",
        "adds": "verified work emails and direct phone numbers",
        "reason": "terms_required",
        "version": "F-1.0.0",
        "termsUrl": "https://www.firecrawl.dev/app/alexandria/apollo"
      }
    ],
    "requiresAction": {
      "type": "accept_terms",
      "approvalId": "0199aaaa-0000-7000-8000-000000000000",
      "providers": [
        {
          "provider": "apollo",
          "name": "Apollo",
          "capability": "people/search",
          "version": "F-1.0.0",
          "digest": "<sha256>",
          "url": "https://www.firecrawl.dev/app/alexandria/apollo",
          "show": { "provider": "firecrawl", "capability": "terms/show", "options": { "provider": "apollo" } },
          "accept": {
            "provider": "firecrawl",
            "capability": "terms/accept",
            "options": { "provider": "apollo", "version": "F-1.0.0", "digest": "<sha256>", "confirmed": true }
          }
        }
      ]
    }
  },
  "pendingApproval": {
    "id": "0199aaaa-0000-7000-8000-000000000000",
    "kind": "terms",
    "reason": "Apollo could add verified work emails and direct phone numbers.",
    "calls": [],
    "terms": [{ "provider": "apollo", "name": "Apollo", "version": "F-1.0.0", "digest": "<sha256>", "url": "https://www.firecrawl.dev/app/alexandria/apollo" }],
    "resolution": null
  }
}
```


### <a href="#accept-then-continue" class="anchor-link" aria-label="Navigate to header: Accept, then continue"></a><span id="_R_6l9crmhkd74t9_" class="cursor-pointer">Accept, then continue</span>


1.  Show your user the terms. Run the provider’s `show` call through <a href="/features/alexandria" class="link"><code>/v2/scrape</code></a> with `alexandria`.
2.  Only if the user explicitly agrees, run its `accept` call the same way. If `accept.options.digest` is `null`, use the digest `terms/show` returned:


``` shiki
curl -X POST https://api.firecrawl.dev/v2/scrape \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "alexandria": {
      "provider": "firecrawl",
      "capability": "terms/accept",
      "options": { "provider": "apollo", "version": "F-1.0.0", "digest": "<sha256>", "confirmed": true }
    }
  }'
```


3.  Continue the same thread with `exchange.approve`. The offer is accepted as a whole, and `callIds` and `always` are ignored on it. The next turn uses those providers to fill the gap the previous answer named, rather than re-running everything.


``` shiki
curl -X POST https://api.firecrawl.dev/v2/agent \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "threadId": "<threadId from the previous run>",
    "prompt": "Continue with Apollo.",
    "exchange": {
      "approve": { "approvalId": "0199aaaa-0000-7000-8000-000000000000" }
    }
  }'
```


## <a href="#zero-data-retention-zdr" class="anchor-link" aria-label="Navigate to header: Zero Data Retention (ZDR)"></a><span id="_R_759crmhkd74t9_" class="cursor-pointer">Zero Data Retention (ZDR)</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/agent \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -d '{
    "prompt": "Find the pricing plans of firecrawl.dev",
    "zeroDataRetention": true
  }'
```


- Follow-up turns are not available with ZDR. A ZDR request that sets `threadId` returns a `400` with `code: "zdr_threads_unsupported"`.
- With `exchange`, a ZDR run only uses <a href="#use-your-connected-alexandria-tools" class="link">Alexandria data provider</a> capabilities that support ZDR.
- The dashboard does not record the steps of a ZDR run, and ZDR runs cannot be shared.


### <a href="#zdr-pricing" class="anchor-link" aria-label="Navigate to header: ZDR pricing"></a><span id="_R_7l9crmhkd74t9_" class="cursor-pointer">ZDR pricing</span>


## <a href="#parameters" class="anchor-link" aria-label="Navigate to header: Parameters"></a><span id="_R_7p9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Parameters</span>


| Parameter | Type | Required | Description |
|----|----|----|----|
| `prompt` | string | **Yes** | Natural language description of the data you want to extract (max 10,000 characters) |
| `model` | string | No | Defaults to `spark-2`, the model every run executes on. Spark 1 models are deprecated and route to `spark-2` |
| `effort` | string | No | Reasoning budget: `low`, `medium`, or `high`. Every run executes on `spark-2`, so `effort` can be sent with or without `model` |
| `urls` | array | No | Optional list of URLs to focus the extraction |
| `schema` | object | No | Optional JSON schema for structured output |
| `strictConstrainToURLs` | boolean | No | If `true`, the agent only visits the URLs provided in the `urls` array |
| `webhook` | object | No | Webhook to receive agent lifecycle events (`agent.started`, `agent.action`, `agent.completed`, `agent.failed`, `agent.cancelled`). See the <a href="/api-reference/endpoint/webhook-agent-started" class="link">webhook payloads</a> |
| `maxCredits` | number | No | Maximum number of credits to spend on this agent task. Defaults to **2,500** if not set. The dashboard supports values up to **2,500**; for higher limits, set `maxCredits` via the API (values above 2,500 are always treated as paid requests). If the limit is reached, the job fails with `stopReason: "credit_limit_reached"` and **no `data` is returned**. The response may include a best-effort `partial`; see <a href="#handling-credit-limit-stops" class="link">Handling credit-limit stops</a>. Failed runs are not billed: credits used for AI reasoning are never charged on failure, any credits used for tool calls during the run (scraping, search, mapping, etc.) are refunded, and the response reports `creditsUsed: 0`. |
| `location` | object | No | `{ country }`: the proxy country for every request the agent makes. The agent cannot change it. See <a href="#choosing-a-location" class="link">Choosing a location</a> |
| `location.country` | string | No | ISO 3166-1 alpha-2 country code, case-insensitive (e.g. `DE`). Special values such as `us-generic` and `us-whitelist` are rejected |
| `safe` | boolean | No | When `true`, every web search in the run filters explicit content (SafeSearch). Scraped and browsed pages are not filtered. See <a href="#safe-search" class="link">Safe search</a> |
| `zeroDataRetention` | boolean | No | Run the agent with <a href="#zero-data-retention-zdr" class="link">Zero Data Retention</a>. Requires Scrape ZDR and Search ZDR to be enabled for your team. Defaults to `false`, unless your team has ZDR forced on |
| `threadId` | string | No | Continue an existing thread: the `threadId` an earlier run returned. Left-out `urls`, `schema`, `effort`, `mode`, `location`, `safe` and `exchange` settings carry over from the previous turn |
| `mode` | string | No | `extract` (default) returns the full structured result in `data` every turn. `chat` lets a follow-up that asks for no new data get a short reply in `message`. Required for `exchange.requireApproval` |
| `exchange` | object | No | Lets the agent call your team’s Alexandria data providers. Without it the run uses the web only. See <a href="#use-your-connected-alexandria-tools" class="link">Use your connected Alexandria tools</a> |
| `exchange.enabled` | boolean | No | Lets the agent call providers. Defaults to `true` once `exchange` is sent |
| `exchange.toolkits` | array | No | Up to 5 provider slugs to pin. Empty or left out means every provider your team can use |
| `exchange.maxCalls` | integer | No | The most provider calls per turn, from 1 to 30. Defaults to 16 |
| `exchange.requireApproval` | boolean | No | Ends the turn with a `pendingApproval` before any paid provider call. Needs `mode: "chat"`. Defaults to `false` |
| `exchange.approve` | object | No | `{ approvalId, callIds?, always? }`: approves the previous turn’s `pendingApproval`. Needs `threadId`. See <a href="#approve-paid-calls-before-they-run" class="link">Approve paid calls before they run</a> |
| `exchange.decline` | object | No | `{ approvalId }`: declines the previous turn’s `pendingApproval`. Needs `threadId` |
| `exchange.onTermsRequired` | string | No | What to do when an Alexandria data provider the agent would use needs terms your team has not accepted: `skip` (default) or `ask`. See <a href="#data-providers-that-need-terms" class="link">Data providers that need terms</a> |


## <a href="#agent-vs-legacy-/extract-what’s-improved" class="anchor-link" aria-label="Navigate to header: Agent vs legacy /extract: What’s Improved"></a><span id="_R_7t9crmhkd74t9_" class="cursor-pointer">Agent vs legacy /extract: What’s Improved</span>


| Feature           | Agent  | Legacy /extract |
|-------------------|--------|-----------------|
| URLs Required     | No     | Yes             |
| Speed             | Faster | Standard        |
| Cost              | Lower  | Standard        |
| Reliability       | Higher | Standard        |
| Query Flexibility | High   | Moderate        |


## <a href="#example-use-cases" class="anchor-link" aria-label="Navigate to header: Example Use Cases"></a><span id="_R_819crmhkd74t9_" class="cursor-pointer">Example Use Cases</span>

- **Research**: “Find the top 5 AI startups and their funding amounts”
- **Competitive Analysis**: “Compare pricing plans between Slack and Microsoft Teams”
- **Data Gathering**: “Extract contact information from company websites”
- **Content Summarization**: “Summarize the latest blog posts about web scraping”

## <a href="#troubleshooting-with-ask" class="anchor-link" aria-label="Navigate to header: Troubleshooting with Ask"></a><span id="_R_859crmhkd74t9_" class="cursor-pointer">Troubleshooting with Ask</span>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/support/ask \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "my agent returned incomplete results"
  }'
```


## <a href="#api-reference" class="anchor-link" aria-label="Navigate to header: API Reference"></a><span id="_R_8d9crmhkd74t9_" class="cursor-pointer">API Reference</span>


## <a href="#pricing" class="anchor-link" aria-label="Navigate to header: Pricing"></a><span id="_R_8j9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Pricing</span>


### <a href="#how-agent-pricing-works" class="anchor-link" aria-label="Navigate to header: How Agent pricing works"></a><span id="_R_8n9crmhkd74t9_" class="cursor-pointer">How Agent pricing works</span>


- **Simple extractions** (like contact info from a single page) typically use fewer credits and cost less
- **Complex research tasks** (like competitive analysis across multiple domains) use more credits but reflect the total effort involved
- **Transparent usage** shows you exactly how many credits each request consumed
- **Credit conversion** automatically converts agent credit usage to credits for easy billing


### <a href="#getting-started" class="anchor-link" aria-label="Navigate to header: Getting started"></a><span id="_R_8v9crmhkd74t9_" class="cursor-pointer">Getting started</span>


### <a href="#managing-costs" class="anchor-link" aria-label="Navigate to header: Managing costs"></a><span id="_R_959crmhkd74t9_" class="cursor-pointer">Managing costs</span>


- **Start with free runs**: Use your 5 daily free requests to understand pricing
- **Set a `maxCredits` parameter**: Limit your spending by setting a maximum number of credits you’re willing to spend. The dashboard caps this at 2,500 credits; to set a higher limit, use the `maxCredits` parameter directly via the API (note: values above 2,500 are always billed as paid requests)
- **Optimize prompts**: More specific prompts often use fewer credits
- **Break large tasks into smaller runs**: A single agent run returns roughly 150-200 rows of structured data. For large extraction jobs, split by category, region, or URL batch (3-5 URLs per run) and merge the results. This also keeps each run well under the `maxCredits` limit.
- **Monitor usage**: Track your consumption through the dashboard
- **Set expectations**: Complex multi-domain research will use more credits than simple single-page extractions


> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/agent.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/agent" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


