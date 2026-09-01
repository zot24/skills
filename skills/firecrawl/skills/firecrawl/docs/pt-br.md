> Source: https://docs.firecrawl.dev/_llms/pt-br.md

# Firecrawl Docs: Brazilian Portuguese

## Brazilian Portuguese

- [Brazilian Portuguese / v2 (202 pages)](https://docs.firecrawl.dev/_llms/pt-br/v2.md): Documentation for Brazilian Portuguese / v2.

### v1

#### Documentação

##### Primeiros passos

- [Introdução](https://docs.firecrawl.dev/pt-BR/introduction.md): Faça uma busca na web, faça scraping de qualquer página e interaja com ela, tudo por meio de uma única API.
- [Primeiros passos](https://docs.firecrawl.dev/pt-BR/mcp-server.md): Configure o Firecrawl MCP com acesso sem chave, login na conta ou uma chave de API.
- [Migração da v1 para a v2](https://docs.firecrawl.dev/pt-BR/migrate-to-v2.md): Principais mudanças, mapeamentos e exemplos de antes e depois para atualizar sua integração para a v2.
- [Guia Avançado de Scraping](https://docs.firecrawl.dev/pt-BR/advanced-scraping-guide.md): Configure opções de scraping, ações do navegador, rastreamento, map e o endpoint do agente em toda a API do Firecrawl.

###### Planos e cobrança

- [Cobrança](https://docs.firecrawl.dev/pt-BR/billing.md): Como funcionam cobrança, créditos e planos do Firecrawl
- [Limites de taxa](https://docs.firecrawl.dev/pt-BR/rate-limits.md): Limites de taxa para diferentes planos e solicitações à API
- [Créditos de parceiro](https://docs.firecrawl.dev/pt-BR/partner-credits.md): Como funcionam os créditos de parceiro da Firecrawl, incluindo elegibilidade, validade e limites do plano

###### Enterprise

- [Enterprise](https://docs.firecrawl.dev/pt-BR/enterprise.md): Planos Enterprise, segurança e recursos do Firecrawl em escala
- [Restrições de IP](https://docs.firecrawl.dev/pt-BR/features/ip-restrictions.md): Restrinja as chaves de API da sua equipe a uma lista de permissões de endereços IP ou intervalos CIDR, para que funcionem apenas em redes aprovadas. Aplicado no servidor.
- [Restrições de chave](https://docs.firecrawl.dev/pt-BR/features/key-restrictions.md): Restrinja uma chave de API individual a endpoints e formatos de resultado específicos. Aplicado no servidor, sem possibilidade de uma requisição sobrescrever isso.
- [Proteção contra ameaças](https://docs.firecrawl.dev/pt-BR/features/threat-protection.md): Bloqueie requests para URLs arriscadas em todos os endpoints usando uma política controlada pela sua organização. Aplicado no servidor.
- [Registro de auditoria do SIEM](https://docs.firecrawl.dev/pt-BR/features/siem.md): Envie um evento de auditoria estruturado ao seu SIEM para cada scraping realizado pela sua equipe, começando pelo Microsoft Sentinel. Entrega no lado do servidor.

##### Recursos padrão

- [Crawlear](https://docs.firecrawl.dev/pt-BR/features/crawl.md): Rastreie recursivamente um site e obtenha conteúdo de cada página
- [Mapa](https://docs.firecrawl.dev/pt-BR/features/map.md): Insira um site e obtenha todas as URLs dele — extremamente rápido
- [Busca](https://docs.firecrawl.dev/pt-BR/features/search.md): Pesquise na web e obtenha o conteúdo completo dos resultados

###### Raspagem

- [Scraping](https://docs.firecrawl.dev/pt-BR/features/scrape.md): Transforme qualquer URL em dados limpos
- [Raspagem mais rápida](https://docs.firecrawl.dev/pt-BR/features/fast-scraping.md): Acelere suas raspagens em 500% com o parâmetro maxAge
- [Raspagem em lote](https://docs.firecrawl.dev/pt-BR/features/batch-scrape.md): Raspe várias URLs em uma única tarefa em lote
- [Modo JSON - Resultado Estruturado](https://docs.firecrawl.dev/pt-BR/features/llm-extract.md): Extraia dados estruturados de páginas com LLMs
- [Rastreio de mudanças](https://docs.firecrawl.dev/pt-BR/features/change-tracking.md): Detecte e monitore mudanças em conteúdo da web entre scrapes
- [Modo Aprimorado](https://docs.firecrawl.dev/pt-BR/features/enhanced-mode.md): Use proxies aprimorados para scraping confiável em sites complexos
- [Proxies](https://docs.firecrawl.dev/pt-BR/features/proxies.md): Saiba mais sobre tipos de proxy, regiões e como o Firecrawl seleciona proxies para suas requisições.

##### Recursos de agente

- [Agente FIRE-1 (Beta)](https://docs.firecrawl.dev/pt-BR/agents/fire-1.md): Agente de IA que possibilita navegação e interação inteligentes com páginas da web

##### Webhooks

- [Visão geral](https://docs.firecrawl.dev/pt-BR/webhooks/overview.md): Notificações em tempo real para suas operações no Firecrawl
- [Tipos de eventos](https://docs.firecrawl.dev/pt-BR/webhooks/events.md): Referência de eventos de webhook
- [Segurança](https://docs.firecrawl.dev/pt-BR/webhooks/security.md): Verifique a autenticidade de webhooks
- [Testes](https://docs.firecrawl.dev/pt-BR/webhooks/testing.md): Testar e depurar webhooks

##### Painel

- [Visão geral](https://docs.firecrawl.dev/pt-BR/dashboard.md): Visão geral do painel do Firecrawl e seus principais recursos

#### SDKs

##### Geral

- [Visão geral](https://docs.firecrawl.dev/pt-BR/sdks/overview.md): Os SDKs do Firecrawl são camadas/encapsulamentos da API do Firecrawl para ajudar você a buscar, fazer scraping e interagir com a web com facilidade.

##### Oficial

- [Python](https://docs.firecrawl.dev/pt-BR/sdks/python.md): O Firecrawl SDK Python é um encapsulador da Firecrawl API que ajuda você a transformar sites em Markdown com facilidade.
- [Node](https://docs.firecrawl.dev/pt-BR/sdks/node.md): Faça scraping, rastreamento e extração de dados estruturados em sites usando o Firecrawl SDK de Node.
- [Go](https://docs.firecrawl.dev/pt-BR/sdks/go.md): O SDK Go do Firecrawl é um wrapper da API do Firecrawl para ajudar você a transformar sites em markdown com facilidade.
- [Java](https://docs.firecrawl.dev/pt-BR/sdks/java.md): O SDK Java do Firecrawl é um wrapper da API do Firecrawl para ajudar você a transformar sites em markdown com facilidade.
- [Ruby](https://docs.firecrawl.dev/pt-BR/sdks/ruby.md): O SDK Ruby do Firecrawl é um wrapper da API do Firecrawl que ajuda você a converter sites em markdown com facilidade.
- [Rust](https://docs.firecrawl.dev/pt-BR/sdks/rust.md): O SDK do Firecrawl para Rust é um wrapper da API do Firecrawl para ajudar você a converter sites em markdown com facilidade.
- [.NET](https://docs.firecrawl.dev/pt-BR/sdks/dotnet.md): O SDK .NET do Firecrawl é um wrapper da API do Firecrawl para ajudar você a transformar sites em markdown com facilidade.
- [PHP](https://docs.firecrawl.dev/pt-BR/sdks/php.md): O SDK PHP do Firecrawl é um wrapper da API do Firecrawl para ajudar você a converter websites em markdown com facilidade.
- [Elixir](https://docs.firecrawl.dev/pt-BR/sdks/elixir.md): O SDK Elixir do Firecrawl é um cliente gerado automaticamente para a API v2 do Firecrawl, desenvolvido com Req e NimbleOptions.

## OpenAPI Specs

- [v2-openapi](/pt-BR/api-reference/v2-openapi.json)
- [webhooks-openapi](/pt-BR/api-reference/webhooks-openapi.json)

## Optional

- [Playground](https://firecrawl.dev/playground)
- [Blog](https://firecrawl.dev/blog)
- [Comunidade](https://community.firecrawl.dev/)
- [Registro de alterações](https://firecrawl.dev/changelog)
- [Integrações](https://www.firecrawl.dev/app)
