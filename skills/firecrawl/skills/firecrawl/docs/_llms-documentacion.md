> Source: https://docs.firecrawl.dev/_llms/es/v2/documentacion.md

# Firecrawl Docs: Spanish v2 Documentación

## Documentación

### Primeros pasos

- [Introducción](https://docs.firecrawl.dev/es/introduction.md): Busca en la web, haz scraping de cualquier página e interactúa con ella, todo desde una sola API.
- [CLI](https://docs.firecrawl.dev/es/sdks/cli.md): Las skills de Firecrawl son una forma sencilla de que agentes de IA como Claude Code, Antigravity y OpenCode usen Firecrawl a través de la CLI.
- [Desarrolla con IA](https://docs.firecrawl.dev/es/ai-onboarding.md): Todo lo que necesitas para integrar tu agente de IA con Firecrawl.
- [Guía avanzada de scraping](https://docs.firecrawl.dev/es/advanced-scraping-guide.md): Configura opciones de scraping, acciones del navegador, rastreo, mapeo y el endpoint del agente con todas las capacidades de la API de Firecrawl.

#### MCP

- [Primeros pasos](https://docs.firecrawl.dev/es/mcp-server.md): Configura Firecrawl MCP con acceso sin clave, inicio de sesión en la cuenta o una clave de API.
- [Primeros pasos](https://docs.firecrawl.dev/es/mcp-server.md): Configura Firecrawl MCP con acceso sin clave, inicio de sesión en la cuenta o una clave de API.
- [Para agentes](https://docs.firecrawl.dev/es/mcp-server/keyless.md): Los agentes pueden empezar a usarlo al instante, sin necesidad de una clave de API. Añade una clave de API para acceder a más capacidad de uso.
- [Para personas](https://docs.firecrawl.dev/es/mcp-server/oauth.md): Inicia sesión desde tu navegador.

#### Planes y facturación

- [Facturación](https://docs.firecrawl.dev/es/billing.md): Cómo funcionan la facturación, los créditos y los planes en Firecrawl
- [Límites de tasa](https://docs.firecrawl.dev/es/rate-limits.md): Límites de tasa para distintos planes y solicitudes de API
- [Créditos de socio](https://docs.firecrawl.dev/es/partner-credits.md): Cómo funcionan los créditos de socio de Firecrawl, incluidos los requisitos, la caducidad y los límites del plan

#### Enterprise

- [Enterprise](https://docs.firecrawl.dev/es/enterprise.md): Planes Enterprise, seguridad y funciones de Firecrawl a gran escala
- [Restricciones de IP](https://docs.firecrawl.dev/es/features/ip-restrictions.md): Restringe las claves de API de tu equipo a una lista de permitido de direcciones IP o rangos CIDR, para que solo funcionen desde redes aprobadas. Aplicadas en el servidor.
- [Restricciones de claves](https://docs.firecrawl.dev/es/features/key-restrictions.md): Restringe una clave de API individual a formatos de salida y endpoints específicos. Se aplica del lado del servidor, sin que una solicitud pueda omitirlo.
- [Protección contra amenazas](https://docs.firecrawl.dev/es/features/threat-protection.md): Bloquea solicitudes a URL riesgosas en todos los endpoints mediante una política controlada por tu organización. Se aplica en el servidor.
- [Registro de auditoría SIEM](https://docs.firecrawl.dev/es/features/siem.md): Envía un evento de auditoría estructurado a tu propio SIEM por cada scraping que realiza tu equipo, comenzando con Microsoft Sentinel. Entrega del lado del servidor.

### Endpoints principales

- [Interact tras el scraping](https://docs.firecrawl.dev/es/features/interact.md): Interactúa con una página que has obtenido mediante prompts o ejecutando código.

#### Búsqueda

- [Búsqueda](https://docs.firecrawl.dev/es/features/search.md): Busca en la web y obtén el contenido completo de los resultados
- [Highlights de búsqueda](https://docs.firecrawl.dev/es/features/search-highlights.md): Devuelve pasajes relevantes para la consulta en lugar de descripciones simples del sitio web
- [Índice de investigación](https://docs.firecrawl.dev/es/features/research.md): Busca artículos, lee pasajes de artículos y encuentra trabajos relacionados
- [Índice para desarrolladores](https://docs.firecrawl.dev/es/features/developer.md): Busca issues, pull requests fusionadas, archivos README de repositorios y sitios de documentación seleccionados

#### Scraping

- [scraping](https://docs.firecrawl.dev/es/features/scrape.md): Convierte cualquier URL en datos limpios
- [Scraping más rápido](https://docs.firecrawl.dev/es/features/fast-scraping.md): Acelera tus scrapes un 500% con el parámetro maxAge
- [Raspado en lote](https://docs.firecrawl.dev/es/features/batch-scrape.md): Raspar múltiples URL en un solo trabajo por lotes
- [Modo JSON - Resultado estructurado](https://docs.firecrawl.dev/es/features/llm-extract.md): Extrae datos estructurados de páginas mediante LLM
- [Seguimiento de cambios](https://docs.firecrawl.dev/es/features/change-tracking.md): Detecta y supervisa cambios en el contenido web entre ejecuciones de scraping
- [Modo mejorado](https://docs.firecrawl.dev/es/features/enhanced-mode.md): Usa proxies mejorados para realizar scraping fiable en sitios complejos
- [Modo de bloqueo](https://docs.firecrawl.dev/es/features/lockdown.md): Modo de scraping solo desde caché para cumplimiento normativo y entornos con aislamiento de red. Sin tráfico saliente.
- [Redacción de PII](https://docs.firecrawl.dev/es/features/pii-redaction.md): Oculta la información de identificación personal en la salida de scraping y procesado
- [Proxies](https://docs.firecrawl.dev/es/features/proxies.md): Conoce los tipos de proxy, las ubicaciones y cómo Firecrawl selecciona proxies para tus solicitudes.
- [Análisis de documentos](https://docs.firecrawl.dev/es/features/document-parsing.md): Conoce las capacidades de análisis de documentos.

#### Monitorización

- [Monitoreo](https://docs.firecrawl.dev/es/features/monitoring.md): Programa comprobaciones periódicas, detecta cambios y recibe notificaciones por webhook o correo electrónico
- [Supervisión de páginas](https://docs.firecrawl.dev/es/features/monitoring-page.md): Supervisa URLs conocidas y recibe alertas cuando haya cambios significativos en la página
- [Supervisión de sitios web](https://docs.firecrawl.dev/es/features/monitoring-website.md): Rastrea un sitio web de forma programada y detecta cambios en todas las páginas descubiertas
- [Monitorización a escala de toda la web](https://docs.firecrawl.dev/es/features/monitoring-web-scale.md): Ejecuta búsquedas web siempre activas y envía alertas cuando aparezcan nuevos resultados coincidentes

### Más

- [Procesar](https://docs.firecrawl.dev/es/features/parse.md): Convierte documentos — PDF, Word, Excel, PowerPoint y más — en markdown limpio, contenido por página, bloques de diseño y JSON estructurado
- [Mapa](https://docs.firecrawl.dev/es/features/map.md): Introduce un sitio web y obtén todas las URLs del sitio — extremadamente rápido
- [Rastrear](https://docs.firecrawl.dev/es/features/crawl.md): Rastrea recursivamente un sitio web y obtén contenido de cada página

### Inicios rápidos

- [Go](https://docs.firecrawl.dev/es/quickstarts/go.md): Empieza a utilizar Firecrawl en Go. Haz scraping, busca e interactúa con datos web utilizando la API REST.
- [Rust](https://docs.firecrawl.dev/es/quickstarts/rust.md): Empieza a usar Firecrawl en Rust. Busca, haz scraping e interactúa con datos web con el SDK oficial.
- [Elixir](https://docs.firecrawl.dev/es/quickstarts/elixir.md): Comienza a utilizar Firecrawl en Elixir. Busca, haz scraping e interactúa con datos web con el SDK oficial.

#### Node.js

- [Node.js](https://docs.firecrawl.dev/es/quickstarts/nodejs.md): Empieza a utilizar Firecrawl en Node.js. Haz scraping, busca e interactúa con datos web utilizando el SDK oficial.
- [Next.js](https://docs.firecrawl.dev/es/quickstarts/nextjs.md): Usa Firecrawl con Next.js para hacer scraping, buscar e interactuar con datos web en tu aplicación React.
- [Express](https://docs.firecrawl.dev/es/quickstarts/express.md): Usa Firecrawl con Express para crear APIs de scraping web y búsqueda.
- [NestJS](https://docs.firecrawl.dev/es/quickstarts/nestjs.md): Usa Firecrawl con NestJS para crear servicios estructurados de scraping web y búsqueda.
- [Fastify](https://docs.firecrawl.dev/es/quickstarts/fastify.md): Usa Firecrawl con Fastify para crear APIs de scraping web y búsqueda de alto rendimiento.
- [Hono](https://docs.firecrawl.dev/es/quickstarts/hono.md): Usa Firecrawl con Hono para crear API ligeras de scraping web y búsqueda que funcionan en cualquier lugar.
- [Bun](https://docs.firecrawl.dev/es/quickstarts/bun.md): Usa Firecrawl con Bun para crear rápidamente servidores de scraping web y búsqueda.
- [Remix](https://docs.firecrawl.dev/es/quickstarts/remix.md): Usa Firecrawl con Remix para hacer scraping, buscar e interactuar con datos de la web en tu aplicación full-stack de React.
- [Nuxt](https://docs.firecrawl.dev/es/quickstarts/nuxt.md): Usa Firecrawl con Nuxt para hacer scraping, buscar e interactuar con datos web en tu aplicación de Vue.
- [SvelteKit](https://docs.firecrawl.dev/es/quickstarts/sveltekit.md): Usa Firecrawl con SvelteKit para hacer scraping, buscar e interactuar con datos web en tu aplicación Svelte.
- [Astro](https://docs.firecrawl.dev/es/quickstarts/astro.md): Usa Firecrawl con Astro para hacer scraping, buscar e interactuar con datos web en tu sitio enfocado en el contenido.
- [Mastra](https://docs.firecrawl.dev/es/quickstarts/mastra.md): Conecta Firecrawl con las herramientas de Mastra para que tus agentes y flujos de trabajo puedan buscar y hacer scraping de datos web en tiempo real.

#### Serverless

- [Cloudflare Workers](https://docs.firecrawl.dev/es/quickstarts/cloudflare-workers.md): Usa Firecrawl con Cloudflare Workers para buscar, hacer scraping e interactuar con datos web en el edge.
- [Funciones de Vercel](https://docs.firecrawl.dev/es/quickstarts/vercel-functions.md): Usa Firecrawl con Funciones de Vercel para buscar, hacer scraping e interactuar con datos web en despliegues serverless.
- [Vercel Marketplace](https://docs.firecrawl.dev/es/quickstarts/vercel-marketplace.md): Instala Firecrawl desde Vercel Marketplace, vincúlalo a un proyecto y usa la `FIRECRAWL_API_KEY` inyectada en tu aplicación de Vercel.
- [AWS Lambda](https://docs.firecrawl.dev/es/quickstarts/aws-lambda.md): Usa Firecrawl con AWS Lambda para buscar, hacer scraping e interactuar con datos web en funciones sin servidor.
- [Supabase Edge Functions](https://docs.firecrawl.dev/es/quickstarts/supabase-edge-functions.md): Usa Firecrawl con Supabase Edge Functions para buscar, hacer scraping e interactuar con datos web desde el edge.
- [Deno Deploy](https://docs.firecrawl.dev/es/quickstarts/deno-deploy.md): Usa Firecrawl con Deno Deploy para buscar, hacer scraping e interactuar con datos web en el edge.

#### PHP

- [PHP](https://docs.firecrawl.dev/es/quickstarts/php.md): Empieza a utilizar Firecrawl en PHP. Realiza scraping, busca e interactúa con datos web mediante la API REST.
- [Laravel](https://docs.firecrawl.dev/es/quickstarts/laravel.md): Usa Firecrawl con Laravel para buscar, hacer scraping e interactuar con datos web mediante la API REST.

#### Ruby

- [Ruby](https://docs.firecrawl.dev/es/quickstarts/ruby.md): Empieza a usar Firecrawl en Ruby. Busca, haz scraping e interactúa con datos web mediante la API REST.
- [Rails](https://docs.firecrawl.dev/es/quickstarts/rails.md): Usa Firecrawl con Ruby on Rails para buscar, hacer scraping e interactuar con datos de la web mediante la API REST.

#### Python

- [Python](https://docs.firecrawl.dev/es/quickstarts/python.md): Empieza a utilizar Firecrawl en Python. Realiza scraping, búsquedas e interactúa con datos web con el SDK oficial.
- [FastAPI](https://docs.firecrawl.dev/es/quickstarts/fastapi.md): Usa Firecrawl con FastAPI para crear APIs asíncronas de scraping y búsqueda web en Python.
- [Django](https://docs.firecrawl.dev/es/quickstarts/django.md): Usa Firecrawl con Django para hacer scraping, buscar e interactuar con datos web en tu aplicación web en Python.
- [Flask](https://docs.firecrawl.dev/es/quickstarts/flask.md): Usa Firecrawl con Flask para crear APIs de scraping y búsqueda web en Python.

#### Java

- [Java](https://docs.firecrawl.dev/es/quickstarts/java.md): Comienza a usar Firecrawl en Java. Busca, haz scraping e interactúa con datos web utilizando el SDK oficial.
- [Spring Boot](https://docs.firecrawl.dev/es/quickstarts/spring-boot.md): Usa Firecrawl con Spring Boot para buscar, hacer scraping e interactuar con datos web con el SDK oficial de Java.

#### .NET

- [.NET](https://docs.firecrawl.dev/es/quickstarts/dotnet.md): Comienza a utilizar Firecrawl en .NET. Realiza scraping, búsquedas e interactúa con datos web con la API REST.
- [ASP.NET Core](https://docs.firecrawl.dev/es/quickstarts/aspnet-core.md): Usa Firecrawl con ASP.NET Core para buscar, hacer scraping e interactuar con datos web mediante la API REST.

### Guías para desarrolladores

- [Plantillas Full‑Stack](https://docs.firecrawl.dev/es/developer-guides/examples.md): Explora ejemplos reales y tutoriales de Firecrawl

#### Guías de uso

- [Cómo elegir el extractor de datos](https://docs.firecrawl.dev/es/developer-guides/usage-guides/choosing-the-data-extractor.md): Compara /agent, /extract y /scrape (modo JSON) para escoger la herramienta adecuada para extraer datos estructurados
- [Verificación de actualidad y vigencia](https://docs.firecrawl.dev/es/developer-guides/usage-guides/verifying-freshness-and-liveness.md): Comprende la diferencia entre la actualidad del contenido y si el estado representado por una página sigue vigente

#### SDKs y frameworks para LLM

- [OpenAI](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/openai.md): Usa Firecrawl con OpenAI para scraping web y flujos de trabajo de IA
- [Anthropic](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/anthropic.md): Usa Firecrawl con Claude para scraping web y flujos de trabajo de IA
- [Gemini](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/gemini.md): Usa Firecrawl con Gemini de Google para scraping web y flujos de trabajo con IA
- [Kit de desarrollo de agentes (ADK)](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/google-adk.md): Integra Firecrawl con el ADK de Google mediante MCP para flujos de trabajo avanzados de agentes
- [Vercel AI SDK](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/vercel-ai-sdk.md): Herramientas de Firecrawl para Vercel AI SDK. Web scraping, búsqueda, interacción y rastreo para aplicaciones de IA.
- [LangChain](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/langchain.md): Usa Firecrawl con LangChain para scraping web y flujos de trabajo de IA
- [LangGraph](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/langgraph.md): Integra Firecrawl con LangGraph para crear flujos de trabajo de agentes
- [LlamaIndex](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/llamaindex.md): Usa Firecrawl con LlamaIndex para aplicaciones RAG
- [Mastra](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/mastra.md): Usa Firecrawl con Mastra para crear flujos de trabajo de IA
- [ElevenAgents](https://docs.firecrawl.dev/es/developer-guides/llm-sdks-and-frameworks/elevenagents.md): Dales a los agentes de voz y chat de ElevenLabs acceso a la web en tiempo real con Firecrawl

#### Cookbooks

- [Cómo crear un asistente de investigación con IA usando Firecrawl y el AI SDK](https://docs.firecrawl.dev/es/developer-guides/cookbooks/ai-research-assistant-cookbook.md): Crea un asistente de investigación completo con IA con capacidades de web scraping y búsqueda
- [Crear un generador de guías de estilo de marca con Firecrawl](https://docs.firecrawl.dev/es/developer-guides/cookbooks/brand-style-guide-generator-cookbook.md): Genera guías de estilo de marca profesionales en PDF extrayendo sistemas de diseño de cualquier sitio web usando el formato de branding de Firecrawl

#### Integraciones

- [Integraciones](https://docs.firecrawl.dev/es/integrations.md): Añade la búsqueda web, el scraping y la interacción de Firecrawl a los agentes de programación, creadores de aplicaciones, frameworks y plataformas de automatización que ya usas
- [Hermes Agent](https://docs.firecrawl.dev/es/integrations/hermes.md): Usa Firecrawl como backend predeterminado de búsqueda web y extracción en Hermes Agent
- [Replit](https://docs.firecrawl.dev/es/integrations/replit.md): Conector oficial de Replit para la búsqueda web, el scraping y la interacción con el navegador de Firecrawl
- [Lovable](https://docs.firecrawl.dev/es/integrations/lovable.md): Conecta Firecrawl con aplicaciones de Lovable para realizar scraping y rastreo web en tiempo real
- [LangChain](https://docs.firecrawl.dev/es/integrations/langchain.md): Usa Firecrawl en LangChain como cargador de documentos o herramienta de agente.
- [LlamaIndex](https://docs.firecrawl.dev/es/integrations/llamaindex.md): Firecrawl se integra con LlamaIndex como lector de documentos.
- [CrewAI](https://docs.firecrawl.dev/es/integrations/crewai.md): Aprende a usar Firecrawl con CrewAI
- [Camel AI](https://docs.firecrawl.dev/es/integrations/camelai.md): Firecrawl se integra con Camel AI como cargador de datos.
- [Praison AI](https://docs.firecrawl.dev/es/integrations/praison.md): Haz scraping web con Firecrawl como herramienta de Praison AI
- [Dify](https://docs.firecrawl.dev/es/integrations/dify.md): Plugin oficial de Firecrawl para flujos de trabajo de Dify y sincronización de sitios web con bases de conocimientos
- [Langflow](https://docs.firecrawl.dev/es/integrations/langflow.md): Aprende a usar Firecrawl en Langflow
- [Flowise](https://docs.firecrawl.dev/es/integrations/flowise.md): Aprende a usar Firecrawl con Flowise
- [Zapier](https://docs.firecrawl.dev/es/integrations/zapier.md): Tutoriales oficiales y plantillas de integración de Zapier para automatizar con Firecrawl
- [Make](https://docs.firecrawl.dev/es/integrations/make.md): Integración oficial y automatización de flujos de trabajo para Firecrawl y Make
- [n8n](https://docs.firecrawl.dev/es/integrations/n8n.md): Aprende a usar Firecrawl con n8n para automatizar el scraping web con esta guía completa paso a paso.
- [Pipedream](https://docs.firecrawl.dev/es/integrations/pipedream.md): Añade pasos de scraping, crawl, search, map y extracción de Firecrawl a los flujos de trabajo de Pipedream
- [Composio](https://docs.firecrawl.dev/es/integrations/composio.md): Usa las herramientas de Firecrawl en los flujos de trabajo de agentes de Composio
- [SourceSync.ai](https://docs.firecrawl.dev/es/integrations/sourcesyncai.md): Firecrawl se integra con SourceSync.ai para funciones de web scraping.

### Webhooks

- [Descripción general](https://docs.firecrawl.dev/es/webhooks/overview.md): Notificaciones en tiempo real para tus operaciones de Firecrawl
- [Tipos de eventos](https://docs.firecrawl.dev/es/webhooks/events.md): Referencia de eventos de webhook
- [Seguridad](https://docs.firecrawl.dev/es/webhooks/security.md): Verificar la autenticidad de los webhooks
- [Pruebas](https://docs.firecrawl.dev/es/webhooks/testing.md): Probar y depurar webhooks

### Casos de uso

- [Casos de uso](https://docs.firecrawl.dev/es/use-cases/overview.md): Convierte datos web en funciones potentes para tus aplicaciones
- [Plataformas de IA](https://docs.firecrawl.dev/es/use-cases/ai-platforms.md): Impulse asistentes de IA y permita que los clientes creen aplicaciones de IA
- [Enriquecimiento de leads](https://docs.firecrawl.dev/es/use-cases/lead-enrichment.md): Extrae y filtra leads de sitios web para impulsar tu pipeline de ventas
- [Plataformas SEO](https://docs.firecrawl.dev/es/use-cases/seo-platforms.md): Optimiza sitios web para asistentes de IA y motores de búsqueda
- [Investigación profunda](https://docs.firecrawl.dev/es/use-cases/deep-research.md): Crea herramientas de investigación con agentes y capacidades de búsqueda avanzada en la web

#### Ver más

- [Producto y comercio electrónico](https://docs.firecrawl.dev/es/use-cases/product-ecommerce.md): Supervisa precios y controla el inventario en sitios de comercio electrónico
- [Generación de contenido](https://docs.firecrawl.dev/es/use-cases/content-generation.md): Genera contenido con IA a partir de datos web, imágenes y noticias
- [Desarrolladores y MCP](https://docs.firecrawl.dev/es/use-cases/developers-mcp.md): Crea integraciones potentes con compatibilidad con Model Context Protocol
- [Inversión y finanzas](https://docs.firecrawl.dev/es/use-cases/investment-finance.md): Seguir empresas y extraer información financiera a partir de datos web
- [Inteligencia competitiva](https://docs.firecrawl.dev/es/use-cases/competitive-intelligence.md): Supervisa los sitios web de la competencia y detecta cambios en tiempo real
- [Migración de datos](https://docs.firecrawl.dev/es/use-cases/data-migration.md): Transfiere datos web de forma eficiente entre plataformas y sistemas
- [Observabilidad y monitoreo](https://docs.firecrawl.dev/es/use-cases/observability.md): Supervisa sitios web, controla la disponibilidad y detecta cambios en tiempo real

### Otros

- [Descripción general](https://docs.firecrawl.dev/es/dashboard.md): Descripción general del panel de control de Firecrawl y sus funciones clave
- [Depura Firecrawl con Ask](https://docs.firecrawl.dev/es/features/ask.md): Depura un trabajo fallido o cualquier problema de integración de Firecrawl con una API de soporte con agentes

### Contribuciones

- [Código abierto o Firecrawl Cloud](https://docs.firecrawl.dev/es/contributing/open-source-or-cloud.md): Elige entre alojar Firecrawl por tu cuenta para controlar la infraestructura y Firecrawl Cloud para llegar a producción por la vía gestionada más rápida.
- [Ejecutar Firecrawl localmente para desarrollo](https://docs.firecrawl.dev/es/contributing/guide.md): Configura el entorno de desarrollo de la API de Firecrawl, verifica un scraping local y ejecuta el conjunto de pruebas del repositorio antes de contribuir.
- [Autoalojamiento de Firecrawl](https://docs.firecrawl.dev/es/contributing/self-host.md): Autoaloja Firecrawl con Docker Compose, verifica un scraping local, comprende las limitaciones del código abierto y prepara la infraestructura para producción.
