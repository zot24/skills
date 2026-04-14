<!-- Source: https://docs.honcho.dev/v3/contributing/configuration -->

# Configuration Guide

## Overview

Honcho applies configuration settings through a priority hierarchy: environment variables override `.env` files, which override `config.toml` files, which override built-in defaults.

## Configuration Loading Priority

1. **Environment variables** (highest precedence)
2. **`.env` file**
3. **`config.toml` file**
4. **Built-in defaults** (lowest precedence)

### Getting Started

```bash
cp .env.template .env
cp config.toml.example config.toml
```

## Environment Variable Naming

- Section-level: `{SECTION}_{KEY}` (e.g., `DB_CONNECTION_URI`)
- App-level: `{KEY}` (e.g., `LOG_LEVEL`)
- Nested: `{SECTION}__{NESTED}__{KEY}` with double underscores

## LLM Configuration

### Model Tiers

| Tier | Examples | Purpose |
|------|----------|---------|
| **Light** | Gemini 2.5 Flash, GLM-4.7-Flash | High-volume tasks (deriver, summary) |
| **Medium** | Claude Haiku 4.5, Grok 4.1 Fast | Balanced reasoning (dialectic middle levels) |
| **Heavy** | Claude Sonnet 4, GLM-5 | Complex tasks (dream, max reasoning) |

### Provider Types

| Provider | Connection Target | API Variable |
|----------|-------------------|--------------|
| `custom` | OpenAI-compatible endpoints | `LLM_OPENAI_COMPATIBLE_API_KEY` |
| `vllm` | vLLM self-hosted | `LLM_VLLM_API_KEY` |
| `google` | Google Gemini | `LLM_GEMINI_API_KEY` |
| `anthropic` | Anthropic Claude | `LLM_ANTHROPIC_API_KEY` |
| `openai` | OpenAI | `LLM_OPENAI_API_KEY` |
| `groq` | Groq | `LLM_GROQ_API_KEY` |

### Example: OpenRouter with Tiers

```bash
LLM_OPENAI_COMPATIBLE_BASE_URL=https://openrouter.ai/api/v1
LLM_OPENAI_COMPATIBLE_API_KEY=sk-or-v1-...

DERIVER_PROVIDER=custom
DERIVER_MODEL=google/gemini-2.5-flash-lite
SUMMARY_PROVIDER=custom
SUMMARY_MODEL=google/gemini-2.5-flash

DIALECTIC_LEVELS__medium__PROVIDER=custom
DIALECTIC_LEVELS__medium__MODEL=anthropic/claude-haiku-4-5

DREAM_PROVIDER=custom
DREAM_MODEL=anthropic/claude-sonnet-4-20250514
```

### Self-Hosted (vLLM/Ollama)

```bash
# vLLM
LLM_VLLM_BASE_URL=http://localhost:8000/v1
DERIVER_PROVIDER=vllm

# Ollama
LLM_OPENAI_COMPATIBLE_BASE_URL=http://localhost:11434/v1
DERIVER_PROVIDER=custom
```

### Thinking Budget (Anthropic Only)

```bash
DERIVER_THINKING_BUDGET_TOKENS=1024
DREAM_THINKING_BUDGET_TOKENS=8192
DIALECTIC_LEVELS__max__THINKING_BUDGET_TOKENS=2048
```

## Feature Configuration

### Dialectic API

```bash
DIALECTIC_MAX_OUTPUT_TOKENS=8192
DIALECTIC_MAX_INPUT_TOKENS=100000
DIALECTIC_HISTORY_TOKEN_LIMIT=8192
```

### Deriver

```bash
DERIVER_ENABLED=true
DERIVER_PROVIDER=google
DERIVER_MODEL=gemini-2.5-flash-lite
DERIVER_WORKERS=1
```

### Summary

```bash
SUMMARY_ENABLED=true
SUMMARY_MAX_TOKENS_SHORT=1000
SUMMARY_MAX_TOKENS_LONG=4000
SUMMARY_MESSAGES_PER_SHORT_SUMMARY=20
```

### Dream

```bash
DREAM_ENABLED=true
DREAM_IDLE_TIMEOUT_MINUTES=60
DREAM_MIN_HOURS_BETWEEN_DREAMS=8
```

## Core Settings

```bash
LOG_LEVEL=INFO
SESSION_OBSERVERS_LIMIT=10
GET_CONTEXT_MAX_TOKENS=100000
MAX_MESSAGE_SIZE=25000
```

## Database

```bash
DB_CONNECTION_URI=postgresql+psycopg://postgres:postgres@localhost:5432/postgres
DB_POOL_SIZE=10
DB_MAX_OVERFLOW=20
```

## Authentication

```bash
AUTH_USE_AUTH=false
AUTH_JWT_SECRET=your-super-secret-jwt-key
```

## Cache (Redis, Optional)

```bash
CACHE_ENABLED=false
CACHE_URL=redis://localhost:6379/0
CACHE_DEFAULT_TTL_SECONDS=300
```

## Vector Store

```bash
VECTOR_STORE_TYPE=pgvector
VECTOR_STORE_DIMENSIONS=1536
```

## Monitoring

```bash
METRICS_ENABLED=false
SENTRY_ENABLED=false
TELEMETRY_ENABLED=false
```

## Database Migrations

```bash
uv run alembic current
uv run alembic upgrade head
uv run alembic downgrade <rev>
```
