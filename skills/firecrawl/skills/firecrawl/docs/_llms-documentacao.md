> Source: https://docs.firecrawl.dev/_llms/pt-br/v2/documentacao.md

# Firecrawl Docs: Brazilian Portuguese v2 Documentação

## Documentação

### Primeiros passos

- [Introdução](https://docs.firecrawl.dev/pt-BR/introduction.md): Faça uma busca na web, faça scraping de qualquer página e interaja com ela, tudo por meio de uma única API.
- [CLI](https://docs.firecrawl.dev/pt-BR/sdks/cli.md): As skills do Firecrawl são uma forma simples de agentes de IA, como Claude Code, Antigravity e OpenCode, usarem o Firecrawl via CLI.
- [Desenvolva com IA](https://docs.firecrawl.dev/pt-BR/ai-onboarding.md): Tudo o que você precisa para conectar seu agente de IA ao Firecrawl.
- [Guia Avançado de Scraping](https://docs.firecrawl.dev/pt-BR/advanced-scraping-guide.md): Configure opções de scraping, ações do navegador, rastreamento, map e o endpoint do agente em toda a API do Firecrawl.

#### MCP

- [Primeiros passos](https://docs.firecrawl.dev/pt-BR/mcp-server.md): Configure o Firecrawl MCP com acesso sem chave, login na conta ou uma chave de API.
- [Primeiros passos](https://docs.firecrawl.dev/pt-BR/mcp-server.md): Configure o Firecrawl MCP com acesso sem chave, login na conta ou uma chave de API.
- [Para agentes](https://docs.firecrawl.dev/pt-BR/mcp-server/keyless.md): Agentes podem começar instantaneamente, sem necessidade de chave de API. Adicione uma chave de API para aumentar o uso.
- [Para humanos](https://docs.firecrawl.dev/pt-BR/mcp-server/oauth.md): Faça login pelo navegador.

#### Planos e cobrança

- [Cobrança](https://docs.firecrawl.dev/pt-BR/billing.md): Como funcionam cobrança, créditos e planos do Firecrawl
- [Limites de taxa](https://docs.firecrawl.dev/pt-BR/rate-limits.md): Limites de taxa para diferentes planos e solicitações à API
- [Créditos de parceiro](https://docs.firecrawl.dev/pt-BR/partner-credits.md): Como funcionam os créditos de parceiro da Firecrawl, incluindo elegibilidade, validade e limites do plano

#### Enterprise

- [Enterprise](https://docs.firecrawl.dev/pt-BR/enterprise.md): Planos Enterprise, segurança e recursos do Firecrawl em escala
- [Restrições de IP](https://docs.firecrawl.dev/pt-BR/features/ip-restrictions.md): Restrinja as chaves de API da sua equipe a uma lista de permissões de endereços IP ou intervalos CIDR, para que funcionem apenas em redes aprovadas. Aplicado no servidor.
- [Restrições de chave](https://docs.firecrawl.dev/pt-BR/features/key-restrictions.md): Restrinja uma chave de API individual a endpoints e formatos de resultado específicos. Aplicado no servidor, sem possibilidade de uma requisição sobrescrever isso.
- [Proteção contra ameaças](https://docs.firecrawl.dev/pt-BR/features/threat-protection.md): Bloqueie requests para URLs arriscadas em todos os endpoints usando uma política controlada pela sua organização. Aplicado no servidor.
- [Registro de auditoria do SIEM](https://docs.firecrawl.dev/pt-BR/features/siem.md): Envie um evento de auditoria estruturado ao seu SIEM para cada scraping realizado pela sua equipe, começando pelo Microsoft Sentinel. Entrega no lado do servidor.

### Endpoints principais

- [Interaja após o scraping](https://docs.firecrawl.dev/pt-BR/features/interact.md): Interaja com uma página que você obteve usando prompts ou executando código.

#### Busca

- [Busca](https://docs.firecrawl.dev/pt-BR/features/search.md): Pesquise na web e obtenha o conteúdo completo dos resultados
- [Destaques da Busca](https://docs.firecrawl.dev/pt-BR/features/search-highlights.md): Retorne trechos relevantes para a query em vez de descrições simples de sites
- [Índice de research](https://docs.firecrawl.dev/pt-BR/features/research.md): Busque artigos, leia trechos de artigos e encontre trabalhos relacionados
- [Índice para desenvolvedores](https://docs.firecrawl.dev/pt-BR/features/developer.md): Pesquise issues, pull requests mesclados, READMEs de repositórios e sites de documentação selecionados

#### Scraping

- [Scraping](https://docs.firecrawl.dev/pt-BR/features/scrape.md): Transforme qualquer URL em dados limpos
- [Raspagem mais rápida](https://docs.firecrawl.dev/pt-BR/features/fast-scraping.md): Acelere suas raspagens em 500% com o parâmetro maxAge
- [Raspagem em lote](https://docs.firecrawl.dev/pt-BR/features/batch-scrape.md): Raspe várias URLs em uma única tarefa em lote
- [Modo JSON - Resultado Estruturado](https://docs.firecrawl.dev/pt-BR/features/llm-extract.md): Extraia dados estruturados de páginas com LLMs
- [Rastreio de mudanças](https://docs.firecrawl.dev/pt-BR/features/change-tracking.md): Detecte e monitore mudanças em conteúdo da web entre scrapes
- [Modo Aprimorado](https://docs.firecrawl.dev/pt-BR/features/enhanced-mode.md): Use proxies aprimorados para scraping confiável em sites complexos
- [Modo Lockdown](https://docs.firecrawl.dev/pt-BR/features/lockdown.md): Modo de scraping somente com cache para conformidade e ambientes isolados da rede. Sem tráfego de saída.
- [Ocultação de PII](https://docs.firecrawl.dev/pt-BR/features/pii-redaction.md): Oculte informações de identificação pessoal nos resultados de scraping e parse
- [Proxies](https://docs.firecrawl.dev/pt-BR/features/proxies.md): Saiba mais sobre tipos de proxy, regiões e como o Firecrawl seleciona proxies para suas requisições.
- [Processamento de Documentos](https://docs.firecrawl.dev/pt-BR/features/document-parsing.md): Saiba mais sobre os recursos de processamento de documentos.

#### Monitor

- [Monitoramento](https://docs.firecrawl.dev/pt-BR/features/monitoring.md): Agende verificações recorrentes, detecte mudanças e receba notificações por webhook ou e-mail
- [Monitoramento de páginas](https://docs.firecrawl.dev/pt-BR/features/monitoring-page.md): Monitore URLs conhecidas e receba alertas sobre mudanças relevantes nas páginas
- [Monitoramento de site](https://docs.firecrawl.dev/pt-BR/features/monitoring-website.md): Rastreie um site em intervalos programados e detecte mudanças em todas as páginas descobertas
- [Monitoramento em escala de toda a web](https://docs.firecrawl.dev/pt-BR/features/monitoring-web-scale.md): Execute buscas na web contínuas e receba alertas quando novos resultados correspondentes aparecerem

### Mais

- [Parse](https://docs.firecrawl.dev/pt-BR/features/parse.md): Transforme documentos — PDFs, Word, Excel, PowerPoint e muito mais — em markdown limpo, conteúdo por página, blocos de layout e JSON estruturado
- [Mapa](https://docs.firecrawl.dev/pt-BR/features/map.md): Insira um site e obtenha todas as URLs dele — extremamente rápido
- [Crawlear](https://docs.firecrawl.dev/pt-BR/features/crawl.md): Rastreie recursivamente um site e obtenha conteúdo de cada página

### Guias de início rápido

- [Go](https://docs.firecrawl.dev/pt-BR/quickstarts/go.md): Comece a usar o Firecrawl em Go. Faça scraping, realize buscas e interaja com dados da web usando a API REST.
- [Rust](https://docs.firecrawl.dev/pt-BR/quickstarts/rust.md): Comece a usar o Firecrawl com Rust. Pesquise, faça scraping e interaja com dados da web usando o SDK oficial.
- [Elixir](https://docs.firecrawl.dev/pt-BR/quickstarts/elixir.md): Comece a usar o Firecrawl com Elixir. Pesquise, faça scraping e interaja com dados da web usando o SDK oficial.

#### Node.js

- [Node.js](https://docs.firecrawl.dev/pt-BR/quickstarts/nodejs.md): Comece a usar o Firecrawl com Node.js. Faça scraping, realize buscas e interaja com dados da web usando o SDK oficial.
- [Next.js](https://docs.firecrawl.dev/pt-BR/quickstarts/nextjs.md): Use o Firecrawl com Next.js para fazer scraping, buscar e interagir com dados da web em sua aplicação React.
- [Express](https://docs.firecrawl.dev/pt-BR/quickstarts/express.md): Use o Firecrawl com Express para criar APIs de scraping e busca na web.
- [NestJS](https://docs.firecrawl.dev/pt-BR/quickstarts/nestjs.md): Use o Firecrawl com NestJS para criar serviços estruturados de scraping e busca na web.
- [Fastify](https://docs.firecrawl.dev/pt-BR/quickstarts/fastify.md): Use Firecrawl com Fastify para criar APIs de scraping da web e busca de alto desempenho.
- [Hono](https://docs.firecrawl.dev/pt-BR/quickstarts/hono.md): Use o Firecrawl com Hono para criar APIs leves de scraping e busca na web que funcionam em qualquer lugar.
- [Bun](https://docs.firecrawl.dev/pt-BR/quickstarts/bun.md): Use Firecrawl com Bun para criar servidores rápidos de scraping e busca na web.
- [Remix](https://docs.firecrawl.dev/pt-BR/quickstarts/remix.md): Use o Firecrawl com Remix para fazer scraping, realizar buscas e interagir com dados da web no seu app React full-stack.
- [Nuxt](https://docs.firecrawl.dev/pt-BR/quickstarts/nuxt.md): Use o Firecrawl com Nuxt para fazer scraping, pesquisar e interagir com dados da web na sua aplicação Vue.
- [SvelteKit](https://docs.firecrawl.dev/pt-BR/quickstarts/sveltekit.md): Use o Firecrawl com SvelteKit para fazer scraping, realizar buscas e interagir com dados da web na sua aplicação Svelte.
- [Astro](https://docs.firecrawl.dev/pt-BR/quickstarts/astro.md): Use o Firecrawl com Astro para fazer scraping, realizar buscas e interagir com dados da web no seu site focado em conteúdo.
- [Mastra](https://docs.firecrawl.dev/pt-BR/quickstarts/mastra.md): Integre o Firecrawl às ferramentas do Mastra para que seus agentes e fluxos de trabalho possam fazer buscas e scraping de dados da web em tempo real.

#### Serverless

- [Cloudflare Workers](https://docs.firecrawl.dev/pt-BR/quickstarts/cloudflare-workers.md): Use o Firecrawl com Cloudflare Workers para buscar, fazer scraping e interagir com dados da web na edge.
- [Vercel Functions](https://docs.firecrawl.dev/pt-BR/quickstarts/vercel-functions.md): Use o Firecrawl com Vercel Functions para buscar, fazer scraping e interagir com dados da web em implantações serverless.
- [Marketplace da Vercel](https://docs.firecrawl.dev/pt-BR/quickstarts/vercel-marketplace.md): Instale o Firecrawl pelo Marketplace da Vercel, vincule-o a um projeto e use a `FIRECRAWL_API_KEY` injetada no seu app na Vercel.
- [AWS Lambda](https://docs.firecrawl.dev/pt-BR/quickstarts/aws-lambda.md): Use o Firecrawl com AWS Lambda para buscar, fazer scraping e interagir com dados da web em funções serverless.
- [Supabase Edge Functions](https://docs.firecrawl.dev/pt-BR/quickstarts/supabase-edge-functions.md): Use o Firecrawl com Supabase Edge Functions para fazer busca, scraping e interagir com dados web na edge.
- [Deno Deploy](https://docs.firecrawl.dev/pt-BR/quickstarts/deno-deploy.md): Use o Firecrawl com o Deno Deploy para buscar, fazer scraping e interagir com dados da web na edge.

#### PHP

- [PHP](https://docs.firecrawl.dev/pt-BR/quickstarts/php.md): Comece a usar o Firecrawl em PHP. Faça scraping, buscas e interaja com dados da web usando a API REST.
- [Laravel](https://docs.firecrawl.dev/pt-BR/quickstarts/laravel.md): Use o Firecrawl com Laravel para fazer busca, scraping e interagir com dados da web usando a API REST.

#### Ruby

- [Ruby](https://docs.firecrawl.dev/pt-BR/quickstarts/ruby.md): Comece a usar o Firecrawl em Ruby. Faça buscas, scraping e interaja com dados da web usando a API REST.
- [Rails](https://docs.firecrawl.dev/pt-BR/quickstarts/rails.md): Use o Firecrawl com Ruby on Rails para fazer buscas, scraping e interagir com dados da web usando a API REST.

#### Python

- [Python](https://docs.firecrawl.dev/pt-BR/quickstarts/python.md): Comece a usar o Firecrawl em Python. Faça scraping, busque e interaja com dados da web usando o SDK oficial.
- [FastAPI](https://docs.firecrawl.dev/pt-BR/quickstarts/fastapi.md): Use o Firecrawl com FastAPI para criar APIs assíncronas de scraping e busca na web em Python.
- [Django](https://docs.firecrawl.dev/pt-BR/quickstarts/django.md): Use o Firecrawl com Django para fazer scraping, busca e interagir com dados da web no seu aplicativo web em Python.
- [Flask](https://docs.firecrawl.dev/pt-BR/quickstarts/flask.md): Use o Firecrawl com Flask para criar APIs de scraping e busca na web em Python.

#### Java

- [Java](https://docs.firecrawl.dev/pt-BR/quickstarts/java.md): Comece a usar o Firecrawl com Java. Faça buscas, scraping e interaja com dados da web usando o SDK oficial.
- [Spring Boot](https://docs.firecrawl.dev/pt-BR/quickstarts/spring-boot.md): Use o Firecrawl com Spring Boot para realizar buscas, fazer scraping e interagir com dados da web usando o SDK Java oficial.

#### .NET

- [.NET](https://docs.firecrawl.dev/pt-BR/quickstarts/dotnet.md): Comece a usar o Firecrawl com .NET. Faça scraping, buscas e interaja com dados da web usando a API REST.
- [ASP.NET Core](https://docs.firecrawl.dev/pt-BR/quickstarts/aspnet-core.md): Use o Firecrawl com ASP.NET Core para realizar buscas, scraping e interagir com dados da web usando a API REST.

### Guias para desenvolvedores

- [Modelos Full Stack](https://docs.firecrawl.dev/pt-BR/developer-guides/examples.md): Explore exemplos práticos e tutoriais do Firecrawl

#### Guias de uso

- [Escolhendo o Extrator de Dados](https://docs.firecrawl.dev/pt-BR/developer-guides/usage-guides/choosing-the-data-extractor.md): Compare /agent, /extract e /scrape (modo JSON) para escolher a ferramenta ideal para extrair dados estruturados
- [Verificando Atualidade e Disponibilidade](https://docs.firecrawl.dev/pt-BR/developer-guides/usage-guides/verifying-freshness-and-liveness.md): Entenda a diferença entre a atualidade do conteúdo e se o estado representado por uma página ainda é válido

#### SDKs e frameworks de LLM

- [OpenAI](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/openai.md): Use o Firecrawl com o OpenAI para web scraping + fluxos de IA
- [Anthropic](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/anthropic.md): Use o Firecrawl com o Claude para scraping da web + fluxos de IA
- [Gemini](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/gemini.md): Use o Firecrawl com o Gemini, da Google, para web scraping e fluxos de trabalho de IA
- [Agent Development Kit (ADK)](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/google-adk.md): Integre o Firecrawl ao ADK do Google usando o MCP para fluxos de trabalho de agentes avançados
- [Vercel AI SDK](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/vercel-ai-sdk.md): Ferramentas Firecrawl para o Vercel AI SDK. Web scraping, busca, interagir e rastreamento para aplicações de IA.
- [LangChain](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/langchain.md): Use o Firecrawl com o LangChain para web scraping e fluxos de IA
- [LangGraph](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/langgraph.md): Integre o Firecrawl ao LangGraph para criar fluxos de trabalho de agentes
- [LlamaIndex](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/llamaindex.md): Use o Firecrawl com o LlamaIndex em aplicações de RAG
- [Mastra](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/mastra.md): Use o Firecrawl com o Mastra para criar workflows de IA
- [ElevenAgents](https://docs.firecrawl.dev/pt-BR/developer-guides/llm-sdks-and-frameworks/elevenagents.md): Dê aos agentes de voz e chat do ElevenLabs acesso à web em tempo real com o Firecrawl

#### Guias práticos

- [Criando um Assistente de Pesquisa com IA usando Firecrawl e AI SDK](https://docs.firecrawl.dev/pt-BR/developer-guides/cookbooks/ai-research-assistant-cookbook.md): Crie um assistente de pesquisa com IA completo, com recursos de scraping e busca na web
- [Criando um Gerador de Guia de Estilo de Marca com Firecrawl](https://docs.firecrawl.dev/pt-BR/developer-guides/cookbooks/brand-style-guide-generator-cookbook.md): Gere guias de estilo de marca profissionais em PDF extraindo sistemas de design de qualquer site com o formato de branding do Firecrawl

#### Integrações

- [Integrações](https://docs.firecrawl.dev/pt-BR/integrations.md): Adicione a busca na web, o scraping e a interação do Firecrawl aos agentes de programação, criadores de aplicativos, frameworks e plataformas de automação que você já usa
- [Agente Hermes](https://docs.firecrawl.dev/pt-BR/integrations/hermes.md): Use o Firecrawl como backend padrão de busca na web e extração no Agente Hermes
- [Replit](https://docs.firecrawl.dev/pt-BR/integrations/replit.md): Conector oficial do Replit para busca na web, scraping e interação com o navegador do Firecrawl
- [Lovable](https://docs.firecrawl.dev/pt-BR/integrations/lovable.md): Conecte o Firecrawl a aplicativos do Lovable para scraping e rastreamento da web em tempo real
- [LangChain](https://docs.firecrawl.dev/pt-BR/integrations/langchain.md): Use o Firecrawl no LangChain como carregador de documentos ou como ferramenta de agente.
- [LlamaIndex](https://docs.firecrawl.dev/pt-BR/integrations/llamaindex.md): O Firecrawl integra-se ao LlamaIndex como leitor de documentos.
- [CrewAI](https://docs.firecrawl.dev/pt-BR/integrations/crewai.md): Saiba como usar o Firecrawl com o CrewAI
- [Camel AI](https://docs.firecrawl.dev/pt-BR/integrations/camelai.md): O Firecrawl integra-se ao Camel AI como carregador de dados.
- [Praison AI](https://docs.firecrawl.dev/pt-BR/integrations/praison.md): Faça scraping da web com o Firecrawl como ferramenta do Praison AI
- [Dify](https://docs.firecrawl.dev/pt-BR/integrations/dify.md): Plugin oficial do Firecrawl para fluxos de trabalho do Dify, com sincronização de sites para bases de conhecimento
- [Langflow](https://docs.firecrawl.dev/pt-BR/integrations/langflow.md): Aprenda a usar o Firecrawl no Langflow
- [Flowise](https://docs.firecrawl.dev/pt-BR/integrations/flowise.md): Aprenda a usar o Firecrawl no Flowise
- [Zapier](https://docs.firecrawl.dev/pt-BR/integrations/zapier.md): Tutoriais oficiais e modelos de integração do Zapier para automação com o Firecrawl
- [Make](https://docs.firecrawl.dev/pt-BR/integrations/make.md): Integração oficial e automação de fluxos de trabalho do Firecrawl para o Make
- [n8n](https://docs.firecrawl.dev/pt-BR/integrations/n8n.md): Aprenda a usar o Firecrawl com o n8n para automatizar o scraping da web com este guia passo a passo completo.
- [Pipedream](https://docs.firecrawl.dev/pt-BR/integrations/pipedream.md): Adicione etapas de scraping, rastreamento, busca, mapeamento e extração do Firecrawl aos fluxos de trabalho do Pipedream
- [Composio](https://docs.firecrawl.dev/pt-BR/integrations/composio.md): Use as ferramentas do Firecrawl em fluxos de trabalho de agentes do Composio
- [SourceSync.ai](https://docs.firecrawl.dev/pt-BR/integrations/sourcesyncai.md): O Firecrawl integra-se ao SourceSync.ai para recursos de raspagem da web.

### Webhooks

- [Visão geral](https://docs.firecrawl.dev/pt-BR/webhooks/overview.md): Notificações em tempo real para suas operações no Firecrawl
- [Tipos de eventos](https://docs.firecrawl.dev/pt-BR/webhooks/events.md): Referência de eventos de webhook
- [Segurança](https://docs.firecrawl.dev/pt-BR/webhooks/security.md): Verifique a autenticidade de webhooks
- [Testes](https://docs.firecrawl.dev/pt-BR/webhooks/testing.md): Testar e depurar webhooks

### Casos de uso

- [Casos de uso](https://docs.firecrawl.dev/pt-BR/use-cases/overview.md): Transforme dados da web em recursos poderosos para seus aplicativos
- [Plataformas de IA](https://docs.firecrawl.dev/pt-BR/use-cases/ai-platforms.md): Potencialize assistentes de IA e permita que clientes criem apps de IA
- [Enriquecimento de Leads](https://docs.firecrawl.dev/pt-BR/use-cases/lead-enrichment.md): Extraia e filtre leads de sites para impulsionar seu pipeline de vendas
- [Plataformas de SEO](https://docs.firecrawl.dev/pt-BR/use-cases/seo-platforms.md): Otimize sites para assistentes de IA e mecanismos de busca
- [Pesquisa avançada](https://docs.firecrawl.dev/pt-BR/use-cases/deep-research.md): Crie ferramentas de pesquisa agentes com recursos de busca profunda na web

#### Ver mais

- [Produto e e-commerce](https://docs.firecrawl.dev/pt-BR/use-cases/product-ecommerce.md): Monitore preços e acompanhe o estoque em sites de e-commerce
- [Geração de Conteúdo](https://docs.firecrawl.dev/pt-BR/use-cases/content-generation.md): Gere conteúdo com IA a partir de dados de sites, imagens e notícias
- [Desenvolvedores & MCP](https://docs.firecrawl.dev/pt-BR/use-cases/developers-mcp.md): Crie integrações poderosas com suporte ao Model Context Protocol
- [Investimentos e Finanças](https://docs.firecrawl.dev/pt-BR/use-cases/investment-finance.md): Acompanhe empresas e extraia insights financeiros a partir de dados da web
- [Inteligência Competitiva](https://docs.firecrawl.dev/pt-BR/use-cases/competitive-intelligence.md): Monitore sites de concorrentes e acompanhe mudanças em tempo real
- [Migração de Dados](https://docs.firecrawl.dev/pt-BR/use-cases/data-migration.md): Transfira dados da web com eficiência entre plataformas e sistemas
- [Observabilidade e Monitoramento](https://docs.firecrawl.dev/pt-BR/use-cases/observability.md): Monitore sites, acompanhe a disponibilidade e detecte mudanças em tempo real

### Outros

- [Visão geral](https://docs.firecrawl.dev/pt-BR/dashboard.md): Visão geral do painel do Firecrawl e seus principais recursos
- [Depure o Firecrawl com o Ask](https://docs.firecrawl.dev/pt-BR/features/ask.md): Depure um job com falha ou qualquer problema de integração com o Firecrawl usando uma API de suporte orientada por agentes

### Como contribuir

- [Código aberto ou Firecrawl Cloud](https://docs.firecrawl.dev/pt-BR/contributing/open-source-or-cloud.md): Escolha entre hospedar o Firecrawl por conta própria para controlar a infraestrutura ou usar o Firecrawl Cloud como o caminho gerenciado mais rápido para produção.
- [Execute o Firecrawl localmente para desenvolvimento](https://docs.firecrawl.dev/pt-BR/contributing/guide.md): Configure o ambiente de desenvolvimento da API do Firecrawl, verifique um scraping local e execute o conjunto de testes do código-fonte antes de contribuir.
- [Auto-hospedagem do Firecrawl](https://docs.firecrawl.dev/pt-BR/contributing/self-host.md): Hospede o Firecrawl por conta própria com Docker Compose, verifique um scraping local, entenda as limitações do código aberto e prepare a stack para produção.
