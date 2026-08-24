# model-router — board-first RoutingDecision

Folded from the former house skill `model-router`. Not a separate plugin. Instance bins
(status-board scripts, pin files, policy files) stay out of this skill; the **names** are
generic: status board, pin file, entitled kinds/models.

## Input

- `task_class` or free-text goal
- project (optional)
- risk / need for freshness (rare)

## Steps

1. Read the **status board**. Collect herdr kinds with status `available`, and entitled model ids.
2. Read the **pin file**. Map role → preferred kind / model slot.
3. Intersect: pin ∩ entitled. If the pin kind is missing, use documented fallbacks, then the
   first available judgement kind.
4. Reviewer: prefer a different vendor than the author when both are entitled
   ([staffing](staffing.md)).
5. Emit `RoutingDecision` and copy it into the dispatch spec
   ([dispatch](dispatch.md)).

```yaml
RoutingDecision:
  plane: herdr|inline|...
  kind: claude|kimi|grok|pi|...
  model: <id or null>
  role: developer_judgment
  reason:
    - pin developer_judgment_kind=<kind>
    - <kind> entitled on the status board
  what_not:
    - no product-repo edits from the tower
  sources: [board, pins]
```

## Rules

- Never mark market-only models `available`.
- No web/API freshness unless the entitled set cannot serve the task and the caller needs it.
- If nothing fits: say so; suggest install/login; do not invent kinds.
- Probe the model inside a kind after start; do not invent. Record NOT DETERMINED if unknown.
  See [herdr-fleet](herdr-fleet.md).
