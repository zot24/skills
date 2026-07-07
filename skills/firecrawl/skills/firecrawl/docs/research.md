> Source: https://docs.firecrawl.dev/features/research.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Research Index

> Search papers, read paper passages, find related work, and search across related GitHub repos

Firecrawl Research is a purpose-built index for scientific and engineering research agents. It exposes a research-specific toolset for searching papers, inspecting paper metadata, reading relevant full-text passages, discovering related papers through structural expansion, and searching over research-related GitHub repos.

* Find papers by topic, method, benchmark, author, or category
* Inspect canonical paper metadata and source ids
* Read the passages in one paper that answer a specific question
* Expand from strong seed papers to related papers, citers, or references
* Search GitHub history and READMEs for implementation notes, bugs, and design discussions


  To give your agent access to the Research Index, we strongly recommend using our [CLI](/sdks/cli) or [MCP](/mcp-server), combined with our [**dedicated research skill**](https://github.com/firecrawl/skills/blob/main/skills/firecrawl-research-index/SKILL.md), which you can install with:

  ```bash
  npx skills add firecrawl/skills@firecrawl-research-index
  ```


<div className="firecrawl-cta-box">
  <div style={{ display: "flex", alignItems: "flex-start", gap: "8px", marginBottom: "8px" }}>
    <Icon icon="sack-dollar" color="#ff4d00" size={22} />

    <div className="firecrawl-cta-title" style={{ margin: 0 }}>
      <span style={{ color: "#ff4d00" }}>Bounty: 5,000 credit reward</span>
      <span style={{ fontWeight: 400 }}> for solid feedback on /search/research (GitHub)</span>
    </div>
  </div>

  <p className="firecrawl-cta-description">
    To qualify, complete a high-signal interview (thoughtful, concrete use cases, etc) with our Firecrawl Feedback Assistant. Only takes a few minutes, can be stopped at any time, and is both human/agent-friendly (just paste the link into your agentic harness!).
  </p>

  <a href={"https://www.firecrawl.dev/interview?study=20260629-fri-github-usage&src=" + (props.src || "docs-research")} className="firecrawl-cta-btn-primary firecrawl-cta-btn-inline">
    Start the interview
  </a>

  <p className="firecrawl-cta-description" style={{ fontSize: "12px", fontStyle: "italic", margin: "12px 0 0 0" }}>
    Include your email to be eligible. Interviews are reviewed for quality at the end of each week.
  </p>
</div>

## Endpoints

| Task                              | Endpoint                                                                                      |
| --------------------------------- | --------------------------------------------------------------------------------------------- |
| Search papers                     | [`GET /search/research/papers`](/api-reference/endpoint/research-search-papers)               |
| Inspect metadata or read passages | [`GET /search/research/papers/{id}`](/api-reference/endpoint/research-paper)                  |
| Find related papers               | [`GET /search/research/papers/{id}/similar`](/api-reference/endpoint/research-related-papers) |
| Search GitHub history             | [`GET /search/research/github`](/api-reference/endpoint/research-github-search)               |

## Search papers

Search paper abstracts with a natural-language query. The response returns ranked papers with canonical `paperId`, preferred `primaryId`, source ids, title, abstract, score, and optional ranking signals.

<CodeGroup>
  ```bash cURL
  # No API key needed to get started; add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s "https://api.firecrawl.dev/v2/search/research/papers?query=diffusion%20image%20synthesis&k=20"
  ```

  ```bash CLI
  firecrawl research search-papers "diffusion image synthesis" --limit 20
  ```

  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started; add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  result = firecrawl.v2.search_papers("diffusion image synthesis", k=20)
  print(result)
  ```

  ```js Node
  import { Firecrawl } from "firecrawl";

  const firecrawl = new Firecrawl({
    // No API key needed to get started; add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const result = await firecrawl.research.searchPapers("diffusion image synthesis", {
    k: 20,
  });
  console.log(result);
  ```
</CodeGroup>

Optional filters:

* `authors`: author substring filter; all filters must match
* `categories`: paper category filter, such as `cs.LG`
* `from`: inclusive created/updated lower bound, `YYYY-MM-DD`
* `to`: inclusive created/updated upper bound, `YYYY-MM-DD`

## Inspect a paper

Use a canonical `paperId` or a source-specific `primaryId`.

<CodeGroup>
  ```bash cURL
  # No API key needed to get started; add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s "https://api.firecrawl.dev/v2/search/research/papers/arxiv:1706.03762"
  ```

  ```bash CLI
  firecrawl research inspect-paper arxiv:1706.03762
  ```

  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started; add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  paper = firecrawl.v2.inspect_paper("arxiv:1706.03762")
  print(paper)
  ```

  ```js Node
  import { Firecrawl } from "firecrawl";

  const firecrawl = new Firecrawl({
    // No API key needed to get started; add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const paper = await firecrawl.research.getPaper("arxiv:1706.03762");
  console.log(paper);
  ```
</CodeGroup>

## Read paper passages

Add `query` to the same paper path to retrieve the top full-text passages for a question. This is useful for verifying whether a candidate paper actually contains a method, dataset, constraint, or result before you include it.

<CodeGroup>
  ```bash cURL
  # No API key needed to get started; add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s "https://api.firecrawl.dev/v2/search/research/papers/arxiv:1706.03762?query=what%20is%20the%20attention%20mechanism&k=4"
  ```

  ```bash CLI
  firecrawl research read-paper arxiv:1706.03762 --question "What is the attention mechanism?" --limit 4
  ```

  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started; add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  passages = firecrawl.v2.read_paper(
      "arxiv:1706.03762",
      "What is the attention mechanism?",
      k=4,
  )
  print(passages)
  ```

  ```js Node
  import { Firecrawl } from "firecrawl";

  const firecrawl = new Firecrawl({
    // No API key needed to get started; add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const passages = await firecrawl.research.getPaper("arxiv:1706.03762", {
    query: "What is the attention mechanism?",
    k: 4,
  });
  console.log(passages);
  ```
</CodeGroup>

## Find related papers

Expand from one or more seed papers through semantic expansion and rank the candidates against a natural-language `intent`.

<CodeGroup>
  ```bash cURL
  # No API key needed to get started; add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s "https://api.firecrawl.dev/v2/search/research/papers/arxiv:1706.03762/similar?intent=efficient%20transformers&mode=similar&k=20"
  ```

  ```bash CLI
  firecrawl research related-papers arxiv:1706.03762 --intent "efficient transformers" --limit 20
  ```

  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started; add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  papers = firecrawl.v2.related_papers(
      "arxiv:1706.03762",
      "efficient transformers",
      mode="similar",
      k=20,
  )
  print(papers)
  ```

  ```js Node
  import { Firecrawl } from "firecrawl";

  const firecrawl = new Firecrawl({
    // No API key needed to get started; add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const papers = await firecrawl.research.similarPapers("arxiv:1706.03762", {
    intent: "efficient transformers",
    mode: "similar",
    k: 20,
  });
  console.log(papers);
  ```
</CodeGroup>

Modes:

* `similar`: co-citation and bibliographic-coupling neighborhood
* `citers`: papers that cite the seed
* `references`: papers cited by the seed

## Search GitHub history

Search GitHub issues, pull requests, discussions, and repository READMEs for implementation details and engineering prior art.

<CodeGroup>
  ```bash cURL
  # No API key needed to get started; add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s "https://api.firecrawl.dev/v2/search/research/github?query=flash%20attention%20implementation%20notes&k=10"
  ```

  ```bash CLI
  firecrawl research search-github "flash attention implementation notes" --limit 10
  ```

  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(
    # No API key needed to get started; add one for higher rate limits:
    # api_key="fc-YOUR-API-KEY",
  )

  results = firecrawl.v2.search_github("flash attention implementation notes", k=10)
  print(results)
  ```

  ```js Node
  import { Firecrawl } from "firecrawl";

  const firecrawl = new Firecrawl({
    // No API key needed to get started; add one for higher rate limits:
    // apiKey: "fc-YOUR-API-KEY",
  });

  const results = await firecrawl.research.searchGithub(
    "flash attention implementation notes",
    { k: 10 },
  );
  console.log(results);
  ```
</CodeGroup>

GitHub results include repository, URL, issue/PR metadata when available, snippet, and matched markdown content when available.
