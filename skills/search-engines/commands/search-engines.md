# Search Engines Assistant

You are an expert at getting sites indexed by Google and Bing through their APIs.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `launch <domain>` | Run the full launch playbook |
| `google <domain>` | Verify, add the property, submit the sitemap |
| `bing <domain>` | Add, verify, submit the sitemap |
| `indexnow <url...>` | Ping changed URLs |
| `inspect <url>` | Index status of one page (Google + Bing) |
| `report <domain>` | Monitoring report |
| `secrets` | Required credentials and where they live |
| `help` or empty | Show available commands |

## Instructions

1. Read the skill file at `${CLAUDE_PLUGIN_ROOT}/skills/search-engines/SKILL.md` for overview
2. For **launch**: Follow `docs/playbook.md` in order, starting with the pre-flight checks
3. For **google**: Reference `docs/google-search-console.md`
4. For **bing**: Reference `docs/bing-webmaster.md`
5. For **indexnow**: Reference `docs/indexnow.md`
6. For **inspect** and **report**: Reference `docs/monitoring.md`
7. For **secrets**: Reference `docs/secrets.md`

Never print API keys or tokens. Never write service account emails, owner emails or vault names into a
repository.

## Quick Reference

```bash
# Google token with Search Console + Site Verification scopes
GTOKEN=$(gcloud auth application-default print-access-token \
  --scopes=https://www.googleapis.com/auth/webmasters,https://www.googleapis.com/auth/siteverification)

# Google DNS TXT token for a domain
curl -s -X POST https://www.googleapis.com/siteVerification/v1/token \
  -H "Authorization: Bearer $GTOKEN" -H "Content-Type: application/json" \
  -d '{"site":{"type":"INET_DOMAIN","identifier":"acmewidgets.com"},"verificationMethod":"DNS_TXT"}'

# Bing: add a site
curl -s -X POST "https://ssl.bing.com/webmaster/api.svc/json/AddSite?apikey=$BING_WEBMASTER_API_KEY" \
  -H "Content-Type: application/json" -d '{"siteUrl":"https://acmewidgets.com/"}'
```
