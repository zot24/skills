> Source: https://flueframework.com/docs/sdk/workflows



# client.workflows


Last updated Jun 20, 2026 <a href="/docs/sdk/workflows/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## `client.workflows.invoke(...)`

``` astro-code
invoke(name: string, options: WorkflowInvokeOptions & { wait: 'result' }): Promise<WorkflowWaitResult>;
invoke(name: string, options?: WorkflowInvokeOptions): Promise<WorkflowInvokeResult>;
```

Starts a workflow run and returns its ID.

``` astro-code
const run = await client.workflows.invoke('summarize', {
  input: { text: 'Summarize this document.' },
});

console.log(run.runId); // "run_01JX..."
```

If the workflow exports `runs` middleware, use the returned `runId` with [`client.runs`](/docs/sdk/runs/) to stream events, fetch events, or retrieve run metadata.

Pass `wait: 'result'` to hold the request open until the run finishes and resolve with its terminal result:

``` astro-code
const run = await client.workflows.invoke('summarize', {
  input: { text: 'Summarize this document.' },
  wait: 'result',
});

console.log(run.result); // the workflow's return value
```

### `WorkflowInvokeOptions`

| Field | Type | Default | Description |
|----|----|----|----|
| `input` | `unknown` | — | Workflow-defined input. |
| `wait` | `'result'` | — | Wait for the run to finish and resolve with its terminal result. |
| `signal` | `AbortSignal` | — | Cancel the HTTP request. |

### `WorkflowInvokeResult`

``` astro-code
interface WorkflowInvokeResult {
  runId: string;
}
```

`runId` is the server-generated workflow run ID.

### `WorkflowWaitResult`

``` astro-code
interface WorkflowWaitResult {
  runId: string;
  result: unknown;
}
```

Returned when `wait: 'result'` is passed.


## Docs Navigation

Current page: [client.workflows](/docs/sdk/workflows/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


