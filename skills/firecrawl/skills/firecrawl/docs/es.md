> Source: https://docs.firecrawl.dev/_llms/es.md

# Firecrawl Docs: Spanish

## Spanish

- [Spanish / v2 (202 pages)](https://docs.firecrawl.dev/_llms/es/v2.md): Documentation for Spanish / v2.

### v1

#### Documentación

##### Primeros pasos

- [Introducción](https://docs.firecrawl.dev/es/introduction.md): Busca en la web, haz scraping de cualquier página e interactúa con ella, todo desde una sola API.
- [Primeros pasos](https://docs.firecrawl.dev/es/mcp-server.md): Configura Firecrawl MCP con acceso sin clave, inicio de sesión en la cuenta o una clave de API.
- [Migración de v1 a v2](https://docs.firecrawl.dev/es/migrate-to-v2.md): Cambios clave, correspondencias y ejemplos de antes y después para actualizar tu integración a v2.
- [Guía avanzada de scraping](https://docs.firecrawl.dev/es/advanced-scraping-guide.md): Configura opciones de scraping, acciones del navegador, rastreo, mapeo y el endpoint del agente con todas las capacidades de la API de Firecrawl.

###### Planes y facturación

- [Facturación](https://docs.firecrawl.dev/es/billing.md): Cómo funcionan la facturación, los créditos y los planes en Firecrawl
- [Límites de tasa](https://docs.firecrawl.dev/es/rate-limits.md): Límites de tasa para distintos planes y solicitudes de API
- [Créditos de socio](https://docs.firecrawl.dev/es/partner-credits.md): Cómo funcionan los créditos de socio de Firecrawl, incluidos los requisitos, la caducidad y los límites del plan

###### Enterprise

- [Enterprise](https://docs.firecrawl.dev/es/enterprise.md): Planes Enterprise, seguridad y funciones de Firecrawl a gran escala
- [Restricciones de IP](https://docs.firecrawl.dev/es/features/ip-restrictions.md): Restringe las claves de API de tu equipo a una lista de permitido de direcciones IP o rangos CIDR, para que solo funcionen desde redes aprobadas. Aplicadas en el servidor.
- [Restricciones de claves](https://docs.firecrawl.dev/es/features/key-restrictions.md): Restringe una clave de API individual a formatos de salida y endpoints específicos. Se aplica del lado del servidor, sin que una solicitud pueda omitirlo.
- [Protección contra amenazas](https://docs.firecrawl.dev/es/features/threat-protection.md): Bloquea solicitudes a URL riesgosas en todos los endpoints mediante una política controlada por tu organización. Se aplica en el servidor.
- [Registro de auditoría SIEM](https://docs.firecrawl.dev/es/features/siem.md): Envía un evento de auditoría estructurado a tu propio SIEM por cada scraping que realiza tu equipo, comenzando con Microsoft Sentinel. Entrega del lado del servidor.

##### Características estándar

- [Rastrear](https://docs.firecrawl.dev/es/features/crawl.md): Rastrea recursivamente un sitio web y obtén contenido de cada página
- [Mapa](https://docs.firecrawl.dev/es/features/map.md): Introduce un sitio web y obtén todas las URLs del sitio — extremadamente rápido
- [Búsqueda](https://docs.firecrawl.dev/es/features/search.md): Busca en la web y obtén el contenido completo de los resultados

###### Extracción

- [scraping](https://docs.firecrawl.dev/es/features/scrape.md): Convierte cualquier URL en datos limpios
- [Scraping más rápido](https://docs.firecrawl.dev/es/features/fast-scraping.md): Acelera tus scrapes un 500% con el parámetro maxAge
- [Raspado en lote](https://docs.firecrawl.dev/es/features/batch-scrape.md): Raspar múltiples URL en un solo trabajo por lotes
- [Modo JSON - Resultado estructurado](https://docs.firecrawl.dev/es/features/llm-extract.md): Extrae datos estructurados de páginas mediante LLM
- [Seguimiento de cambios](https://docs.firecrawl.dev/es/features/change-tracking.md): Detecta y supervisa cambios en el contenido web entre ejecuciones de scraping
- [Modo mejorado](https://docs.firecrawl.dev/es/features/enhanced-mode.md): Usa proxies mejorados para realizar scraping fiable en sitios complejos
- [Proxies](https://docs.firecrawl.dev/es/features/proxies.md): Conoce los tipos de proxy, las ubicaciones y cómo Firecrawl selecciona proxies para tus solicitudes.

##### Funciones del agente

- [Agente FIRE-1 (Beta)](https://docs.firecrawl.dev/es/agents/fire-1.md): Agente de IA que permite la navegación y la interacción inteligentes con páginas web

##### Webhooks

- [Descripción general](https://docs.firecrawl.dev/es/webhooks/overview.md): Notificaciones en tiempo real para tus operaciones de Firecrawl
- [Tipos de eventos](https://docs.firecrawl.dev/es/webhooks/events.md): Referencia de eventos de webhook
- [Seguridad](https://docs.firecrawl.dev/es/webhooks/security.md): Verificar la autenticidad de los webhooks
- [Pruebas](https://docs.firecrawl.dev/es/webhooks/testing.md): Probar y depurar webhooks

##### Panel de control

- [Descripción general](https://docs.firecrawl.dev/es/dashboard.md): Descripción general del panel de control de Firecrawl y sus funciones clave

#### SDKs

##### General

- [Descripción general](https://docs.firecrawl.dev/es/sdks/overview.md): Los SDK de Firecrawl son contenedores de la API de Firecrawl que te ayudan a buscar, hacer scraping e interactuar con la web con facilidad.

##### Oficial

- [Python](https://docs.firecrawl.dev/es/sdks/python.md): El SDK de Python de Firecrawl es un envoltorio de la API de Firecrawl que te ayuda a convertir sitios web en Markdown fácilmente.
- [Node](https://docs.firecrawl.dev/es/sdks/node.md): Realiza scraping, rastrea y extrae datos estructurados de sitios web con el SDK de Firecrawl para Node.js.
- [Go](https://docs.firecrawl.dev/es/sdks/go.md): El SDK de Firecrawl para Go es un wrapper de la API de Firecrawl que te permite convertir sitios web en Markdown fácilmente.
- [Java](https://docs.firecrawl.dev/es/sdks/java.md): El SDK de Java de Firecrawl es una biblioteca que envuelve la API de Firecrawl para que puedas convertir fácilmente sitios web en markdown.
- [Ruby](https://docs.firecrawl.dev/es/sdks/ruby.md): El SDK de Ruby de Firecrawl es un wrapper de la API de Firecrawl que te permite convertir sitios web en Markdown fácilmente.
- [Rust](https://docs.firecrawl.dev/es/sdks/rust.md): El SDK de Rust de Firecrawl es un envoltorio para la API de Firecrawl que te permite convertir sitios web a markdown fácilmente.
- [.NET](https://docs.firecrawl.dev/es/sdks/dotnet.md): El SDK de Firecrawl para .NET es un wrapper de la API de Firecrawl que te permite convertir sitios web en markdown fácilmente.
- [PHP](https://docs.firecrawl.dev/es/sdks/php.md): El SDK de PHP de Firecrawl es un wrapper de la API de Firecrawl que te ayuda a convertir sitios web en markdown fácilmente.
- [Elixir](https://docs.firecrawl.dev/es/sdks/elixir.md): El SDK de Firecrawl para Elixir es un cliente autogenerado para la API v2 de Firecrawl, desarrollado con Req y NimbleOptions.

## OpenAPI Specs

- [v2-openapi](/es/api-reference/v2-openapi.json)
- [webhooks-openapi](/es/api-reference/webhooks-openapi.json)

## Optional

- [Playground](https://firecrawl.dev/playground)
- [Blog](https://firecrawl.dev/blog)
- [Comunidad](https://community.firecrawl.dev/)
- [Registro de cambios](https://firecrawl.dev/changelog)
- [Integraciones](https://www.firecrawl.dev/app)
