<!-- Authored for this skill. Not synced from upstream.
     Sources: https://learn.microsoft.com/en-us/bingwebmaster/ (getting-access, api-protocols) and
     the IWebmasterApi reference at
     https://learn.microsoft.com/en-us/dotnet/api/microsoft.bing.webmaster.api.interfaces.iwebmasterapi -->

# Bing Webmaster Tools

Bing feeds Bing, DuckDuckGo, Yahoo, Ecosia and the Copilot / ChatGPT search layers, so it matters for
GEO as much as for SEO.

## Auth

One API key per Bing user, valid for every site that user owns. One-time owner setup: Bing Webmaster
Tools → Settings → API access → Generate API key. Store it in the vault as `BING_WEBMASTER_API_KEY`
(see [secrets](secrets.md)).

The JSON endpoint takes the key as a query parameter. Never echo the full URL in logs.

```bash
BW=https://ssl.bing.com/webmaster/api.svc/json
K="apikey=$BING_WEBMASTER_API_KEY"
SITE=https://acmewidgets.com/
```

Microsoft retired the SOAP and POX endpoints on 2026-08-31. The JSON endpoint below is the one the
method pages document. If it starts returning 404s, check the Bing Webmaster docs for the REST
replacement before anything else.

Errors come back as HTTP 400 with `{"ErrorCode":3,"Message":"InvalidApiKey"}`.

## 1. Add the site

```bash
curl -s -X POST "$BW/AddSite?$K" -H "Content-Type: application/json" -d "{\"siteUrl\":\"$SITE\"}"
curl -s "$BW/GetUserSites?$K" | jq ".d[] | select(.Url==\"$SITE\")"
# → { Url, IsVerified, AuthenticationCode, DnsVerificationCode }
```

## 2. Verify

Pick one method, in this order:

1. **DNS CNAME** — no deploy needed. Add a CNAME on the zone named after `DnsVerificationCode`,
   pointing at `verify.bing.com`, **DNS only** (not proxied). Use the `cloudflare-domains` skill.
2. **File** — when DNS is out of reach, ship `public/BingSiteAuth.xml`:
   ```xml
   <?xml version="1.0"?>
   <users><user>AUTHENTICATION_CODE</user></users>
   ```
3. **Meta tag** — `<meta name="msvalidate.01" content="AUTHENTICATION_CODE">` in the base layout.

Then:

```bash
curl -s -X POST "$BW/VerifySite?$K" -H "Content-Type: application/json" -d "{\"siteUrl\":\"$SITE\"}"
```

`{"d":true}` means verified. Keep the record, file or tag in place afterwards.

If the owner's Bing account is linked to Google, **Import from Google Search Console** in the Bing
dashboard does steps 1–3 in one click for sites already in Search Console. That is a dashboard-only
action; offer it, do not depend on it.

## 3. Sitemap

```bash
curl -s -X POST "$BW/SubmitFeed?$K" -H "Content-Type: application/json" \
  -d "{\"siteUrl\":\"$SITE\",\"feedUrl\":\"https://acmewidgets.com/sitemap-index.xml\"}"
curl -s "$BW/GetFeeds?$K&siteUrl=$SITE" | jq
```

## 4. Push new URLs

IndexNow (see [indexnow](indexnow.md)) covers this for every engine. The Bing-only route has a daily
quota:

```bash
curl -s "$BW/GetUrlSubmissionQuota?$K&siteUrl=$SITE" | jq
curl -s -X POST "$BW/SubmitUrlBatch?$K" -H "Content-Type: application/json" -d "{
  \"siteUrl\": \"$SITE\",
  \"urlList\": [\"https://acmewidgets.com/\", \"https://acmewidgets.com/pricing\"]
}"
```

## Checks

```bash
curl -s "$BW/GetCrawlIssues?$K&siteUrl=$SITE" | jq
curl -s "$BW/GetQueryStats?$K&siteUrl=$SITE" | jq '.d[:20]'
curl -s "$BW/GetUrlInfo?$K&siteUrl=$SITE&url=https://acmewidgets.com/pricing" | jq
```
