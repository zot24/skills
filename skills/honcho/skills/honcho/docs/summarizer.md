<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/summarizer -->

# Summarizer

## Overview

Honcho implements conversation summarization to efficiently prime context windows. The approach combines recent messages with compressed LLM-generated summaries of older content, addressing three key requirements: exhaustiveness, dynamic sizing, and performance.

## Summary Creation

Honcho leverages its asynchronous task queue to generate summaries without adding latency to user requests. Two configurable summary types exist:

- **Short summaries**: Triggered every 20 messages (1000 token limit)
- **Long summaries**: Triggered every 60 messages (4000 token limit)

Each summary type receives the prior summary of their type plus every message after that summary, enabling recursive compression that preserves recent conversation details while covering the entire dialogue.

## Summary Retrieval

The `get_context` method retrieves summaries with two parameters:

1. `summary`: Boolean flag (default: true) to include summaries
2. `tokens`: Maximum token budget for context

Honcho allocates 60% of the context size for recent messages and 40% for the summary. Without a token limit specified, the system automatically retrieves sufficient context for complete conversation coverage.

## Context Trade-offs

Several scenarios prevent exhaustive context:

- When final messages exceed the token limit
- When summaries alone surpass available tokens
- When recent messages fill the context window

For these cases, provide a reasonable token limit. For guaranteed exhaustiveness, omit the token parameter. For recent messages only, disable summaries and set an appropriate token count.

**Note**: Summaries generate asynchronously, so immediate availability isn't guaranteed after batch uploads.
