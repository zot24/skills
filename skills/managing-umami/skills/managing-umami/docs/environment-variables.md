<!-- Source: https://docs.umami.is/docs/environment-variables -->

# Environment Variables

## Runtime Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `APP_SECRET` | Random string for securing auth tokens | Required |
| `DATABASE_URL` | Database connection string | Required |
| `CLIENT_IP_HEADER` | HTTP header for client IP behind proxies | — |
| `COLLECT_API_ENDPOINT` | Custom metrics endpoint path | `/api/send` |
| `CORS_MAX_AGE` | CORS preflight duration (seconds) | 86400 |
| `DEBUG` | Console logging areas (`umami:auth`, `umami:clickhouse`, `umami:kafka`) | — |
| `DISABLE_BOT_CHECK` | Disable bot exclusion from stats | false |
| `DISABLE_LOGIN` | Disable login page | false |
| `DISABLE_UPDATES` | Disable version update checks | false |
| `DISABLE_TELEMETRY` | Opt out of anonymous telemetry | false |
| `ENABLE_TEST_CONSOLE` | Enable test page at `{host}/console` | false |
| `FAVICON_URL` | Website icon service URL | `icons.duckduckgo.com` |
| `GEO_DATABASE_URL` | MaxMind-compatible GeoIP database URL | — |
| `HOSTNAME` / `PORT` | Specific hostname and port binding | System defaults |
| `IGNORE_IP` | Comma-delimited IPs/CIDR ranges to exclude | — |
| `LOG_QUERY` | Log database queries to console | false |
| `PRIVATE_MODE` | Disable all external network calls | false |
| `REMOVE_TRAILING_SLASH` | Remove trailing slashes from URLs | false |
| `TRACKER_SCRIPT_NAME` | Custom tracker script name (bypass ad blockers) | `script.js` |
| `SKIP_LOCATION_HEADERS` | Force local geo database over CDN headers | false |

## Build Time Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `ALLOWED_FRAME_URLS` | Space-delimited URLs allowed to iframe Umami | — |
| `BASE_PATH` | Subdirectory path for hosting | — |
| `DATABASE_TYPE` | Database type for Docker builds | `postgresql` |
| `FORCE_SSL` | Send HSTS response header | false |
| `SKIP_DB_CHECK` | Skip database check during build | false |
| `SKIP_DB_MIGRATION` | Skip Prisma migration during build | false |

## API Client Variables

### Self-Hosted
| Variable | Description |
|----------|-------------|
| `UMAMI_API_CLIENT_USER_ID` | UUID of the user making API calls |
| `UMAMI_API_CLIENT_SECRET` | Random string matching `APP_SECRET` |
| `UMAMI_API_CLIENT_ENDPOINT` | API endpoint URL (e.g., `https://your-server/api/`) |

### Umami Cloud
| Variable | Description |
|----------|-------------|
| `UMAMI_API_KEY` | API key from Umami Cloud |
| `UMAMI_API_CLIENT_ENDPOINT` | API endpoint URL |
