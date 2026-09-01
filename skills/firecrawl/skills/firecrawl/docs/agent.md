> Source: https://docs.firecrawl.dev/features/agent



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="https://firecrawl.dev" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">Firecrawl Docs home page</span><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=c45b3c967c19a39190e76fe8e9c2ed5a" class="nav-logo w-auto relative object-contain shrink-0 block dark:hidden h-6" alt="light logo" /><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=3fee4abe033bd3c26e8ad92043a91c17" class="nav-logo w-auto relative object-contain shrink-0 hidden dark:block h-6" alt="dark logo" /></a>


Search...


More


Agent


<a href="/introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor] hover:text-primary dark:hover:text-primary-light text-gray-800 dark:text-gray-200" data-active="true" aria-current="location">Documentation</a>


<a href="/sdks/overview" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">SDKs</a>


<a href="/api-reference/v2-introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">API Reference</a>


<a href="/ai-onboarding" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">Build with AI</a>


More


# Agent


Gather data wherever it lives on the web.


- For **a single known URL**, <a href="/features/llm-extract" class="link">JSON mode on <code>/scrape</code></a> is cheaper and synchronous.
- Full comparison: <a href="/developer-guides/usage-guides/choosing-the-data-extractor" class="link">Choosing the Data Extractor</a>.


<a href="" class="link firecrawl-cta-btn-primary firecrawl-cta-btn-inline" target="_blank" rel="noreferrer"><span data-as="p">Start the interview</span></a>


- **No URLs Required**: Just describe what you need via `prompt` parameter. URLs are optional
- **Deep Web Search**: Autonomously searches and navigates deep into sites to find your data
- **Reliable and Accurate**: Works with a wide variety of queries and use cases
- **Faster**: Processes multiple sources in parallel for quicker results


## Try it in the Playground


## 


<a href="#using-/agent" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


### 


<a href="#response" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#providing-urls-optional" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#job-status-and-completion" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


### 


<a href="#possible-states" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Status       | Description                                                                                                                      |
|--------------|----------------------------------------------------------------------------------------------------------------------------------|
| `processing` | The agent is still working on your request                                                                                       |
| `completed`  | Extraction finished successfully                                                                                                 |
| `failed`     | An error occurred during extraction, or the job was cancelled (cancelled jobs report `failed` with a cancellation error message) |


#### 


<a href="#pending-example" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "status": "processing",
  "expiresAt": "2024-12-15T00:00:00.000Z"
}
```


#### 


<a href="#completed-example" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#listing-agent-runs" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#following-a-run-in-progress" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Surface       | What you get                                                                                                                                                                                                           | Best for                                                            |
|---------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------|
| Trace polling | Full detail: every event the run has emitted so far, including tool calls, reasoning summaries, progress phases, and artifact changes                                                                                  | Building your own progress UI, or debugging what a run actually did |
| Webhooks      | Push delivery, coarse-grained: the five agent lifecycle events (`agent.started`, `agent.action`, `agent.completed`, `agent.failed`, `agent.cancelled`). See <a href="/webhooks/events" class="link">webhook events</a> | Reacting to a run finishing without holding a poll loop open        |
| Live view     | A human-watchable view of the agent’s browser. Request the trace with `?liveView=true` and each entry in `activeBrowserSessions` carries a `liveViewUrl`                                                               | Watching a run navigate in real time                                |


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


## 


<a href="#execution-traces-and-snapshots" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#getting-the-agent’s-source-data" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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

## 


<a href="#share-agent-runs" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#model-selection" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#spark-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- Lowest cost per run
- Fastest run time
- Accuracy comparable to the former Spark 1 flagship
- The only model with a reasoning budget: pass `effort` (`low`, `medium`, or `high`) to control how hard it thinks

### 


<a href="#specifying-a-model" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#parameters" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Parameter               | Type    | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|-------------------------|---------|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `prompt`                | string  | **Yes**  | Natural language description of the data you want to extract (max 10,000 characters)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `model`                 | string  | No       | Defaults to `spark-2`, the model every run executes on. Spark 1 models are deprecated and route to `spark-2`                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `effort`                | string  | No       | Reasoning budget: `low`, `medium`, or `high`. Every run executes on `spark-2`, so `effort` can be sent with or without `model`                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `urls`                  | array   | No       | Optional list of URLs to focus the extraction                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `schema`                | object  | No       | Optional JSON schema for structured output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `strictConstrainToURLs` | boolean | No       | If `true`, the agent only visits the URLs provided in the `urls` array                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `webhook`               | object  | No       | Webhook to receive agent lifecycle events (`agent.started`, `agent.action`, `agent.completed`, `agent.failed`, `agent.cancelled`). See the <a href="/api-reference/endpoint/webhook-agent-started" class="link">webhook payloads</a>                                                                                                                                                                                                                                                                                                                    |
| `maxCredits`            | number  | No       | Maximum number of credits to spend on this agent task. Defaults to **2,500** if not set. The dashboard supports values up to **2,500**; for higher limits, set `maxCredits` via the API (values above 2,500 are always treated as paid requests). If the limit is reached, the job fails and **no data is returned**. Failed runs are not billed: credits used for AI reasoning are never charged on failure, any credits used for tool calls during the run (scraping, search, mapping, etc.) are refunded, and the response reports `creditsUsed: 0`. |


## 


<a href="#agent-vs-extract-what’s-improved" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Feature           | Agent (New) | Extract  |
|-------------------|-------------|----------|
| URLs Required     | No          | Yes      |
| Speed             | Faster      | Standard |
| Cost              | Lower       | Standard |
| Reliability       | Higher      | Standard |
| Query Flexibility | High        | Moderate |


## 


<a href="#example-use-cases" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Research**: “Find the top 5 AI startups and their funding amounts”
- **Competitive Analysis**: “Compare pricing plans between Slack and Microsoft Teams”
- **Data Gathering**: “Extract contact information from company websites”
- **Content Summarization**: “Summarize the latest blog posts about web scraping”

## 


<a href="#csv-upload-in-agent-playground" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#troubleshooting-with-ask" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/support/ask \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "my agent returned incomplete results"
  }'
```


## 


<a href="#api-reference" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#pricing" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#how-agent-pricing-works" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Simple extractions** (like contact info from a single page) typically use fewer credits and cost less
- **Complex research tasks** (like competitive analysis across multiple domains) use more credits but reflect the total effort involved
- **Transparent usage** shows you exactly how many credits each request consumed
- **Credit conversion** automatically converts agent credit usage to credits for easy billing


### 


<a href="#parallel-agents-pricing" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#getting-started" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#managing-costs" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Start with free runs**: Use your 5 daily free requests to understand pricing
- **Set a `maxCredits` parameter**: Limit your spending by setting a maximum number of credits you’re willing to spend. The dashboard caps this at 2,500 credits; to set a higher limit, use the `maxCredits` parameter directly via the API (note: values above 2,500 are always billed as paid requests)
- **Optimize prompts**: More specific prompts often use fewer credits
- **Break large tasks into smaller runs**: A single agent run returns roughly 150-200 rows of structured data. For large extraction jobs, split by category, region, or URL batch (3-5 URLs per run) and merge the results. This also keeps each run well under the `maxCredits` limit.
- **Monitor usage**: Track your consumption through the dashboard
- **Set expectations**: Complex multi-domain research will use more credits than simple single-page extractions


> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/agent.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/agent" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


