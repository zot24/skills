<!-- Authored for this skill. Not synced from upstream. -->

# Token and secrets

## The API token

One account-scoped token covers the whole playbook. Create it with these permissions
(names as the token screen shows them; see [create-api-token](create-api-token.md)):

| Scope | Permission | Used for |
|---|---|---|
| Account | Registrar: Domains — Edit | search, check, register |
| Account | Cloudflare Tunnel — Edit | public hostnames on an existing tunnel |
| Account | Email Routing Addresses — Edit | destination addresses |
| Account | Workers Scripts — Edit | `wrangler deploy` with custom domains |
| Zone | Zone — Read | zone ID lookup |
| Zone | DNS — Edit | records, www placeholder, tunnel CNAMEs |
| Zone | Zone Settings — Edit | Always Use HTTPS, DNSSEC |
| Zone | Single Redirect — Edit | www → apex |
| Zone | Zone WAF — Edit | locking paths on self-hosted hostnames |
| Zone | Email Routing Rules — Edit | forwarding rules |
| Zone | Workers Routes — Edit | custom domains |

If a call returns `9109` / `10000` (unauthorized), the token is missing a permission from this table —
say which one; never widen to a Global API Key.

## Where it lives

Credentials live in one shared 1Password vault that the owner fills for agents. Agents read only that
vault, through a service account token. Its name is the owner's private configuration: take it from
`OP_VAULT` in the environment (or the agent's own memory), never write it into a repo. Below, `<vault>`
stands for it. Expected items:

| Item | Field | Env var |
|---|---|---|
| `cloudflare` | `credential` | `CLOUDFLARE_API_TOKEN` |
| `cloudflare` | `account_id` | `CLOUDFLARE_ACCOUNT_ID` |

If an item is missing, stop and ask the owner to add it to the vault. Never create credentials or ask
for them in chat.

## Varlock (preferred)

In the site repo's `.env.schema`:

```bash
# @plugin(@varlock/1password-plugin)
# @initOp(token=$OP_SERVICE_ACCOUNT_TOKEN)
# ---

# @type=opServiceAccountToken
OP_SERVICE_ACCOUNT_TOKEN=

# @required @sensitive
CLOUDFLARE_API_TOKEN=op("op://<vault>/cloudflare/credential")

# @required
CLOUDFLARE_ACCOUNT_ID=op("op://<vault>/cloudflare/account_id")
```

Replace `<vault>` locally; quote the reference when the vault name has spaces. If the schema is
committed, keep the vault name out of it: commit it with `<vault>` replaced by a vault ID only if the
owner agrees, otherwise keep `.env.schema` local. Run anything that needs the token through
Varlock so values never land in shell history or logs:

```bash
npx varlock load                        # validates; sensitive values are redacted
npx varlock run -- wrangler deploy
npx varlock run -- bash -c 'curl -s "$CF/zones?name=acmewidgets.com" -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN"'
```

## 1Password CLI (fallback)

When the repo has no `.env.schema` yet, use `op` directly (see the `1password-cli` skill):

```bash
export OP_SERVICE_ACCOUNT_TOKEN=...      # provided by the environment, never typed into chat
op run --env-file=<(printf 'CLOUDFLARE_API_TOKEN="op://$OP_VAULT/cloudflare/credential"\n') -- wrangler whoami
```
