<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/dreaming -->

# Dreaming

## Core Concept

"Dreaming" functions as an autonomous consolidation mechanism that refines peer representations by reasoning over existing conclusions. The system operates in two specialized phases:

### Deduction Phase
This stage performs logical inference to identify knowledge updates, logical implications, contradictions, and peer card updates. For example, it recognizes when employment changes from "Company A" to "Company B" and removes outdated information.

### Induction Phase
This stage identifies behavioral patterns across multiple conclusions, including tendencies, preferences, personality traits, and correlations. Importantly, patterns require evidence from at least two source conclusions before confirmation.

## Activation Triggers

Dreams activate automatically when three conditions align:
- At least 50 new conclusions exist since the last dream
- A minimum 8-hour interval has elapsed
- Dreaming is enabled in workspace/session configuration

The system includes an idle timeout (default 60 minutes) that waits for user inactivity before execution, preventing consolidation during active conversations.

## Operational Scope

Dreams operate at the peer representation level -- specifically a (workspace, observer, observed) tuple. This scoping prevents consolidation from spanning across workspaces or different observer-observed pairs.

## Safety Mechanisms

The system prevents redundant processing through concurrent dream prevention, duplicate pending dream elimination, and automatic cancellation when new messages arrive.

## Configuration Options

Dreaming can be disabled at workspace or session levels through configuration, and automatically disables if reasoning itself is disabled.
