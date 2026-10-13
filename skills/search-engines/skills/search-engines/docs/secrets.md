<!-- Authored for this skill. Not synced from upstream. -->

# Secrets

Same rules as the `cloudflare-domains` skill: credentials come from the agents' 1Password vault, the
vault name comes from `OP_VAULT` (written `<vault>` below), and nothing private goes into a repo —
no vault names, no service account emails, no owner emails, no keys.

| Item | Field | Env var | Notes |
|---|---|---|---|
| `google-search` | `credential` (JSON) | `GOOGLE_SA_JSON` | Service account key, written to a temp file for `GOOGLE_APPLICATION_CREDENTIALS` |
| `google-search` | `client_email` | `SA_EMAIL` | |
| `google-search` | `owner_email` | `GSC_OWNER_EMAIL` | Owner's Google account, added as property owner |
| `bing-webmaster` | `credential` | `BING_WEBMASTER_API_KEY` | One key per Bing user |

If an item is missing, stop and ask the owner to add it. Never ask for a key in chat.

## Varlock

```bash
# @plugin(@varlock/1password-plugin)
# @initOp(token=$OP_SERVICE_ACCOUNT_TOKEN)
# ---
# @required @sensitive
GOOGLE_SA_JSON=op("op://<vault>/google-search/credential")
SA_EMAIL=op("op://<vault>/google-search/client_email")
# @sensitive
GSC_OWNER_EMAIL=op("op://<vault>/google-search/owner_email")
# @required @sensitive
BING_WEBMASTER_API_KEY=op("op://<vault>/bing-webmaster/credential")
```

Keep the vault name out of a committed schema: point `<vault>` at an env-provided value or keep this
schema in an uncommitted `.env.schema.local`.

## Service account key on disk

```bash
umask 077
SA_FILE=$(mktemp)
printf '%s' "$GOOGLE_SA_JSON" > "$SA_FILE"
export GOOGLE_APPLICATION_CREDENTIALS="$SA_FILE"
# ... calls ...
rm -f "$SA_FILE"
```

## Fallback: op CLI

```bash
op read "op://$OP_VAULT/google-search/credential" > "$SA_FILE"
export BING_WEBMASTER_API_KEY=$(op read "op://$OP_VAULT/bing-webmaster/credential")
```
