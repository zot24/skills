<!-- Source: https://docs.immich.app/install/environment-variables -->

# Immich Environment Variables

## Docker Compose Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `IMMICH_VERSION` | Image tags | `v2` |
| `UPLOAD_LOCATION` | Host path for uploads | — |
| `DB_DATA_LOCATION` | Host path for Postgres database | — |

These variables are used by `docker-compose.yml` and do NOT affect containers directly.

## General Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `TZ` | Timezone (IANA identifier) | — |
| `IMMICH_ENV` | Environment setting | `production` |
| `IMMICH_LOG_LEVEL` | Log verbosity level | `log` |
| `IMMICH_LOG_FORMAT` | Output format (`console`, `json`) | `console` |
| `IMMICH_MEDIA_LOCATION` | Media path inside container (do not modify) | `/data` |
| `IMMICH_CONFIG_FILE` | Config file path | — |
| `NO_COLOR` | Disable color-coded logs | `false` |
| `CPU_CORES` | Available CPU cores | auto-detected |
| `IMMICH_TRUSTED_PROXIES` | Comma-separated trusted proxy IPs | — |
| `IMMICH_ALLOW_SETUP` | Enable admin signup endpoint | `true` |

## Ports Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `IMMICH_HOST` | Listening host | `0.0.0.0` |
| `IMMICH_PORT` | Listening port | `2283` (server), `3003` (ML) |

## Database Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DB_URL` | Database connection URL | — |
| `DB_HOSTNAME` | Database host | `database` |
| `DB_PORT` | Database port | `5432` |
| `DB_USERNAME` | Database user | `postgres` |
| `DB_PASSWORD` | Database password | `postgres` |
| `DB_DATABASE_NAME` | Database name | `immich` |
| `DB_SSL_MODE` | SSL connection mode | — |
| `DB_VECTOR_EXTENSION` | Vector extension type | auto-detected |
| `DB_SKIP_MIGRATIONS` | Skip migrations on startup | `false` |
| `DB_STORAGE_TYPE` | IO optimization (`SSD`, `HDD`) | `SSD` |

`DB_URL` format: `postgresql://user:password@host:port/database`
When `DB_URL` is set, other database variables are ignored.

## Redis Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `REDIS_URL` | Redis connection URL | — |
| `REDIS_SOCKET` | Redis socket path | — |
| `REDIS_HOSTNAME` | Redis host | `redis` |
| `REDIS_PORT` | Redis port | `6379` |
| `REDIS_USERNAME` | Redis username | — |
| `REDIS_PASSWORD` | Redis password | — |
| `REDIS_DBINDEX` | Redis database index | `0` |

## Machine Learning Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `MACHINE_LEARNING_MODEL_TTL` | Model unload inactivity time (seconds) | `300` |
| `MACHINE_LEARNING_MODEL_TTL_POLL_S` | TTL check interval (seconds) | `10` |
| `MACHINE_LEARNING_CACHE_FOLDER` | Model download directory | `/cache` |
| `MACHINE_LEARNING_REQUEST_THREADS` | Request thread pool count | CPU core count |
| `MACHINE_LEARNING_MODEL_INTER_OP_THREADS` | Parallel model operations | `1` |
| `MACHINE_LEARNING_MODEL_INTRA_OP_THREADS` | Threads per operation | `2` |
| `MACHINE_LEARNING_WORKERS` | Worker process count | `1` |
| `MACHINE_LEARNING_WORKER_TIMEOUT` | Worker unresponsiveness limit | `120` |
| `MACHINE_LEARNING_DEVICE_IDS` | GPU device IDs | `0` |
| `MACHINE_LEARNING_ANN` | ARM-NN hardware acceleration | `True` |
| `MACHINE_LEARNING_RKNN` | RKNN hardware acceleration | `True` |
| `MACHINE_LEARNING_OPENVINO_PRECISION` | OpenVINO precision mode | `FP32` |

### Model Preloading

| Variable | Description |
|----------|-------------|
| `MACHINE_LEARNING_PRELOAD__CLIP__TEXTUAL` | CLIP textual models to preload |
| `MACHINE_LEARNING_PRELOAD__CLIP__VISUAL` | CLIP visual models to preload |
| `MACHINE_LEARNING_PRELOAD__FACIAL_RECOGNITION__RECOGNITION` | Recognition models to preload |
| `MACHINE_LEARNING_PRELOAD__FACIAL_RECOGNITION__DETECTION` | Detection models to preload |
| `MACHINE_LEARNING_PRELOAD__OCR__RECOGNITION` | OCR recognition models to preload |
| `MACHINE_LEARNING_PRELOAD__OCR__DETECTION` | OCR detection models to preload |

## Secrets (Docker Secrets / Systemd Credentials)

| Regular Variable | File Variable |
|------------------|---------------|
| `DB_HOSTNAME` | `DB_HOSTNAME_FILE` |
| `DB_DATABASE_NAME` | `DB_DATABASE_NAME_FILE` |
| `DB_USERNAME` | `DB_USERNAME_FILE` |
| `DB_PASSWORD` | `DB_PASSWORD_FILE` |
| `DB_URL` | `DB_URL_FILE` |
| `REDIS_PASSWORD` | `REDIS_PASSWORD_FILE` |

## Important Notes

- Environment variable changes require recreating containers: `docker compose up -d` or `docker compose up -d --force-recreate`
- Do not modify `IMMICH_MEDIA_LOCATION` — use `UPLOAD_LOCATION` instead for host paths
- `DB_PASSWORD` should use alphanumeric characters only (no special characters)
