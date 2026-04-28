> Source: https://docs.firecrawl.dev/quickstarts/fastapi.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# FastAPI

> Use Firecrawl with FastAPI to build async web scraping and search APIs in Python.

## Prerequisites

* Python 3.8+
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)

## Setup

```bash
pip install fastapi uvicorn firecrawl-py
```

Add your API key to `.env`:

```bash
FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

## Create the API

Create `main.py`:

```python
import os
from fastapi import FastAPI
from pydantic import BaseModel
from firecrawl import Firecrawl

app = FastAPI()
firecrawl = Firecrawl(api_key=os.environ["FIRECRAWL_API_KEY"])


class SearchRequest(BaseModel):
    query: str
    limit: int = 5


class ScrapeRequest(BaseModel):
    url: str


class InteractRequest(BaseModel):
    scrape_id: str
    prompt: str


@app.post("/search")
async def search(req: SearchRequest):
    results = firecrawl.search(req.query, limit=req.limit)
    return [{"title": r.title, "url": r.url} for r in results.web]


@app.post("/scrape")
async def scrape(req: ScrapeRequest):
    result = firecrawl.scrape(req.url)
    return {"markdown": result.markdown, "metadata": result.metadata}


@app.post("/interact/start")
async def interact_start(req: ScrapeRequest):
    result = firecrawl.scrape(req.url, formats=["markdown"])
    return {"scrape_id": result.metadata.scrape_id}


@app.post("/interact")
async def interact(req: InteractRequest):
    response = firecrawl.interact(req.scrape_id, prompt=req.prompt)
    return {"output": response.output}


@app.post("/interact/stop")
async def interact_stop(req: InteractRequest):
    firecrawl.stop_interaction(req.scrape_id)
    return {"status": "stopped"}
```

## Run it

```bash
uvicorn main:app --reload
```

## Test it

```bash
# Search the web
curl -X POST http://localhost:8000/search \
  -H "Content-Type: application/json" \
  -d '{"query": "firecrawl web scraping", "limit": 5}'

# Scrape a page
curl -X POST http://localhost:8000/scrape \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com"}'

# Start an interactive session, then send prompts
curl -X POST http://localhost:8000/interact/start \
  -H "Content-Type: application/json" \
  -d '{"url": "https://www.amazon.com"}'
```

FastAPI auto-generates interactive docs at `http://localhost:8000/docs`.

## Async variant

For better concurrency under load, use `AsyncFirecrawl`:

```python
from firecrawl import AsyncFirecrawl

async_firecrawl = AsyncFirecrawl(api_key=os.environ["FIRECRAWL_API_KEY"])

@app.post("/scrape-async")
async def scrape_async(req: ScrapeRequest):
    result = await async_firecrawl.scrape(req.url)
    return {"markdown": result.markdown}
```

## Next steps


    All scrape options including formats, actions, and proxies


    Search the web and get full page content


    Click, fill forms, and extract dynamic content


    Full SDK reference with crawl, map, async, and more


