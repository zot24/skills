<!-- Authored for this skill. Not synced from upstream.
     Based on the synced Cloudflare pages: cloudflare-ai-bot-policies.md,
     cloudflare-managed-robots-txt.md, cloudflare-ai-bots-reference.md. -->

# AI crawlers

GEO starts with letting the right bots in. Two layers decide that, and they must agree:

1. **Cloudflare AI bot policies** — enforced at the edge (Security Settings → Configure AI bot
   policies, or AI Crawl Control per crawler).
2. **robots.txt** — a published preference, voluntary for the crawler.

A site can have perfect content and still be invisible to ChatGPT because the edge blocks
`OAI-SearchBot`. Check the edge first.

## The three behaviours

| Behaviour | What it does | Examples (user agent) | Landing page default |
|---|---|---|---|
| **Search** | Indexes pages to answer questions later, with citations | `OAI-SearchBot`, `Claude-SearchBot`, `PerplexityBot`, `Applebot`, `bingbot`, `Googlebot` | **Allow** |
| **Agent** | Fetches a page live for a person's question | `ChatGPT-User`, `Claude-User`, `Perplexity-User`, `DuckAssistBot`, `MistralAI-User`, `meta-externalfetcher` | **Allow** |
| **Training** | Collects content to train models | `GPTBot`, `ClaudeBot`, `CCBot`, `Google-Extended`, `Applebot-Extended`, `meta-externalagent`, `Bytespider`, `Amazonbot` | **Allow** for marketing pages, **owner's call** for paid or original content |

Why allow training on a landing page: models that trained on the brand's own description answer
"what is Acme?" correctly without a live fetch. The content is marketing; its value is in being
repeated. A site that sells its content (courses, research, data) should block training.

Since 2026-09-15, Cloudflare's defaults for **new** domains block Training and Agent bots on pages it
detects as showing ads, and allow Search. Landing pages without ads stay open, but set every policy
explicitly so the result does not depend on detection.

## Set the edge policy

Dashboard: domain → Security → Settings → **Configure AI bot policies**:

- Search: **Allow**
- Agent: **Allow**
- Training: **Allow** (or **Block** when the owner chose to)

Then AI Crawl Control → Crawlers: confirm no individual crawler from the Search and Agent rows above
is set to Block. Blocking in AI Crawl Control writes a WAF custom rule; look for it under Security →
WAF → Custom rules when a bot is blocked and the policy says allow.

These settings have no documented public API yet. Ask the owner to set them, or drive the dashboard
with a browser tool when one is available, and record the result in the site brief.

## robots.txt groups

When the owner blocks training, add the groups to the generated `robots.txt` (see
[technical-seo](technical-seo.md)) so the preference is public:

```txt
User-agent: *
Content-Signal: search=yes, ai-input=yes, ai-train=no
Allow: /

User-agent: GPTBot
User-agent: ClaudeBot
User-agent: CCBot
User-agent: Google-Extended
User-agent: Applebot-Extended
User-agent: meta-externalagent
User-agent: Bytespider
Disallow: /

Sitemap: https://acmewidgets.com/sitemap-index.xml
```

When training is allowed, keep the plain `User-agent: * / Allow: /` file and, optionally,
`Content-Signal: search=yes, ai-input=yes, ai-train=yes`.

Never block `Googlebot` or `bingbot`: blocking `Google-Extended` stops Gemini training without
touching Google Search.

If Cloudflare's **managed robots.txt** is on, it prepends its own groups — which may disallow
training bots the owner wanted to allow. Turn it off when the site serves its own `robots.txt`, or
make the two agree.

## Verify

```bash
curl -s https://acmewidgets.com/robots.txt
for ua in OAI-SearchBot ChatGPT-User Claude-SearchBot Claude-User PerplexityBot GPTBot ClaudeBot; do
  printf '%-18s %s\n' "$ua" "$(curl -s -o /dev/null -w '%{http_code}' -A "$ua" https://acmewidgets.com/)"
done
```

A spoofed user agent is not a verified bot, so a 200 here proves only that no user-agent rule blocks
it. The real signal is AI Crawl Control → Crawlers showing allowed requests from those operators a few
days after launch.

## Measure AI traffic

Visitors from AI answers arrive with referrers such as `chatgpt.com`, `perplexity.ai`, `claude.ai`,
`copilot.microsoft.com` and `gemini.google.com`. In Umami, filter the Referrers report on those
domains or create a segment for them. Bing Webmaster Tools has an AI Performance report for Copilot
citations (dashboard only).
