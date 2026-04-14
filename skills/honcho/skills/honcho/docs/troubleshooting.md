<!-- Source: https://docs.honcho.dev/v3/contributing/troubleshooting -->

# Troubleshooting

## Startup Problems

**Missing LLM clients:** The server validates API keys at startup. Configure `LLM_GEMINI_API_KEY`, `LLM_ANTHROPIC_API_KEY`, and `LLM_OPENAI_API_KEY` for default operations, or adjust `.env`/`config.toml` to match available providers.

**JWT authentication:** If `AUTH_USE_AUTH=true`, generate and set `AUTH_JWT_SECRET` using the provided script, or disable authentication locally.

## Runtime Errors

**Database connectivity:** Primary culprit for "unexpected error" on every request. Health endpoint doesn't verify database status. Key diagnostics:
- Ensure PostgreSQL is running with correct `DB_CONNECTION_URI`
- Run migrations: `uv run alembic upgrade head`
- Enable pgvector: `CREATE EXTENSION IF NOT EXISTS vector;`

**Deriver processing failures:**
- Verify deriver process is running
- Check database connectivity from deriver
- Confirm LLM API key availability
- Adjust `DERIVER_WORKERS` for message volume
- Check `REPRESENTATION_BATCH_MAX_TOKENS` settings

## Provider-Specific Issues

**OpenRouter/custom providers:** Match model name formats (e.g., `anthropic/claude-haiku-4-5`), verify endpoint URLs, confirm tool calling support.

**Thinking budget errors:** Only Anthropic models support extended thinking. Set `THINKING_BUDGET_TOKENS` to `0` for all other providers.

**vLLM/Ollama:** Use `host.docker.internal` in Docker instead of `localhost`.

## Database & Infrastructure

- Connection URIs require `postgresql+psycopg` prefix
- Redis caching is optional; failures gracefully fall back to in-memory
- Docker build requires BuildKit (`DOCKER_BUILDKIT=1`)
- Linux: AppArmor/SELinux may block; volume mounts may need `:z` permissions
