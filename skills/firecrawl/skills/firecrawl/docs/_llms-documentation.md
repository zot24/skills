> Source: https://docs.firecrawl.dev/_llms/fr/v2/documentation.md

# Firecrawl Docs: French v2 Documentation

## Documentation

### Prise en main

- [Introduction](https://docs.firecrawl.dev/fr/introduction.md): Recherchez sur le web, extrayez n’importe quelle page et interagissez avec elle, le tout via une seule API.
- [CLI](https://docs.firecrawl.dev/fr/sdks/cli.md): Les skills Firecrawl permettent simplement aux agents IA comme Claude Code, Antigravity et OpenCode d’utiliser Firecrawl via la CLI.
- [Créer avec l’IA](https://docs.firecrawl.dev/fr/ai-onboarding.md): Tout ce dont vous avez besoin pour intégrer votre agent IA à Firecrawl.
- [Guide avancé de scraping](https://docs.firecrawl.dev/fr/advanced-scraping-guide.md): Configurez les options de scraping, les actions du navigateur, le crawl, la cartographie et le point de terminaison de l'agent grâce à l’ensemble de la surface de l’API Firecrawl.

#### MCP

- [Premiers pas](https://docs.firecrawl.dev/fr/mcp-server.md): Configurez Firecrawl MCP avec un accès sans clé, une connexion à un compte ou une clé API.
- [Premiers pas](https://docs.firecrawl.dev/fr/mcp-server.md): Configurez Firecrawl MCP avec un accès sans clé, une connexion à un compte ou une clé API.
- [Pour les agents](https://docs.firecrawl.dev/fr/mcp-server/keyless.md): Les agents peuvent démarrer immédiatement, sans clé API. Ajoutez une clé API pour accéder à davantage d’utilisation.
- [Pour les humains](https://docs.firecrawl.dev/fr/mcp-server/oauth.md): Connectez-vous via votre Browser.

#### Offres et facturation

- [Facturation](https://docs.firecrawl.dev/fr/billing.md): Fonctionnement de la facturation, des crédits et des offres Firecrawl
- [Limites de débit](https://docs.firecrawl.dev/fr/rate-limits.md): Limites de débit selon les forfaits et les requêtes API
- [Crédits partenaires](https://docs.firecrawl.dev/fr/partner-credits.md): Comment fonctionnent les crédits partenaires Firecrawl, notamment les conditions d’éligibilité, leur expiration et les limites de l’offre

#### Entreprise

- [Enterprise](https://docs.firecrawl.dev/fr/enterprise.md): Offres Enterprise, sécurité et fonctionnalités de Firecrawl à grande échelle
- [Restrictions d’adresses IP](https://docs.firecrawl.dev/fr/features/ip-restrictions.md): Restreignez les clés API de votre équipe à une liste d’autorisation d’adresses IP ou de plages CIDR, afin qu’elles ne fonctionnent que depuis des réseaux approuvés. Contrôle appliqué côté serveur.
- [Restrictions de clé](https://docs.firecrawl.dev/fr/features/key-restrictions.md): Verrouillez une clé API individuelle sur des formats de sortie et des points de terminaison spécifiques. Appliqué côté serveur, sans possibilité pour une requête de passer outre.
- [Protection contre les menaces](https://docs.firecrawl.dev/fr/features/threat-protection.md): Bloquez les requêtes vers des URL à risque sur tous les points de terminaison, à l’aide d’une politique contrôlée par votre organisation. Appliquée côté serveur.
- [Journalisation d’audit SIEM](https://docs.firecrawl.dev/fr/features/siem.md): Envoyez un événement d’audit structuré à votre SIEM pour chaque extraction effectuée par votre équipe, en commençant par Microsoft Sentinel. Livraison côté serveur.

### Points de terminaison de base

- [Interact après le scraping](https://docs.firecrawl.dev/fr/features/interact.md): Interagissez avec une page que vous avez récupérée à l’aide d’un prompt ou en exécutant du code.

#### Recherche

- [Recherche](https://docs.firecrawl.dev/fr/features/search.md): Recherchez sur le web et obtenez le contenu complet des résultats
- [Extraits de recherche](https://docs.firecrawl.dev/fr/features/search-highlights.md): Renvoyez des passages pertinents pour la query au lieu de simples descriptions de sites web
- [Index de recherche](https://docs.firecrawl.dev/fr/features/research.md): Recherchez des articles, lisez des passages d'articles et trouvez des travaux connexes
- [Index Developer](https://docs.firecrawl.dev/fr/features/developer.md): Recherchez des tickets, des pull requests fusionnées, des README de dépôts et des sites de documentation sélectionnés

#### Extraction

- [Scrape](https://docs.firecrawl.dev/fr/features/scrape.md): Transformez n'importe quelle URL en données propres
- [Scraping plus rapide](https://docs.firecrawl.dev/fr/features/fast-scraping.md): Accélérez vos scrapes de 500 % grâce au paramètre maxAge
- [Scrape par lots](https://docs.firecrawl.dev/fr/features/batch-scrape.md): Scraper plusieurs URL en une seule tâche par lots
- [Mode JSON - Résultat structuré](https://docs.firecrawl.dev/fr/features/llm-extract.md): Extraire des données structurées à partir de pages via des LLM
- [Suivi des modifications](https://docs.firecrawl.dev/fr/features/change-tracking.md): Détecter et surveiller les changements dans le contenu web entre les extractions
- [Mode avancé](https://docs.firecrawl.dev/fr/features/enhanced-mode.md): Utilisez des proxies avancés pour un scraping fiable sur des sites complexes
- [Mode de verrouillage](https://docs.firecrawl.dev/fr/features/lockdown.md): Mode de scraping sur cache uniquement pour la conformité et les environnements isolés du réseau. Aucun trafic sortant.
- [Masquage des données personnelles identifiables (PII)](https://docs.firecrawl.dev/fr/features/pii-redaction.md): Masquer les données personnelles identifiables dans les sorties de scrape et de parse
- [Proxys](https://docs.firecrawl.dev/fr/features/proxies.md): Découvrez les types de proxy, les emplacements et la façon dont Firecrawl sélectionne des proxy pour vos requêtes.
- [Analyse de documents](https://docs.firecrawl.dev/fr/features/document-parsing.md): Découvrez les capacités d'analyse de documents.

#### Suivi

- [Monitoring](https://docs.firecrawl.dev/fr/features/monitoring.md): Programmez des vérifications récurrentes, détectez les changements et recevez des notifications par webhook ou e-mail
- [surveillance de page](https://docs.firecrawl.dev/fr/features/monitoring-page.md): Surveillez des URL connues et recevez des alertes en cas de modifications significatives des pages
- [Surveillance de site web](https://docs.firecrawl.dev/fr/features/monitoring-website.md): Planifier le crawl d’un site web et détecter les modifications sur chaque page découverte
- [Surveillance à l'échelle de l'ensemble du web](https://docs.firecrawl.dev/fr/features/monitoring-web-scale.md): Exécutez des recherches web en continu et recevez une alerte lorsque de nouveaux résultats correspondants apparaissent

### Plus

- [Parse](https://docs.firecrawl.dev/fr/features/parse.md): Convertissez des documents — PDF, Word, Excel, PowerPoint et bien d’autres — en markdown propre, contenu de chaque page, blocs de mise en page et JSON structuré
- [Cartographier](https://docs.firecrawl.dev/fr/features/map.md): Indiquez un site web et récupérez toutes ses URL — ultra rapide
- [Crawl](https://docs.firecrawl.dev/fr/features/crawl.md): Crawler récursivement un site web et obtenir le contenu de chaque page

### Démarrages rapides

- [Go](https://docs.firecrawl.dev/fr/quickstarts/go.md): Premiers pas avec Firecrawl en Go. Extrayez, recherchez et interagissez avec des données web à l’aide de l’API REST.
- [Rust](https://docs.firecrawl.dev/fr/quickstarts/rust.md): Découvrez Firecrawl en Rust. Effectuez des recherches, scrapez et interagissez avec les données du Web à l’aide du SDK officiel.
- [Elixir](https://docs.firecrawl.dev/fr/quickstarts/elixir.md): Découvrez Firecrawl en Elixir. Effectuez des recherches, du scraping et interagissez avec les données web à l’aide du SDK officiel.

#### Node.js

- [Node.js](https://docs.firecrawl.dev/fr/quickstarts/nodejs.md): Découvrez Firecrawl en Node.js. Scrapez, recherchez et interagissez avec les données web à l’aide du SDK officiel.
- [Next.js](https://docs.firecrawl.dev/fr/quickstarts/nextjs.md): Utilisez Firecrawl avec Next.js pour extraire, rechercher et interagir avec des données web dans votre application React.
- [Express](https://docs.firecrawl.dev/fr/quickstarts/express.md): Utilisez Firecrawl avec Express pour créer des API de scraping web et de recherche.
- [NestJS](https://docs.firecrawl.dev/fr/quickstarts/nestjs.md): Utilisez Firecrawl avec NestJS pour créer des services de scraping web structuré et de recherche.
- [Fastify](https://docs.firecrawl.dev/fr/quickstarts/fastify.md): Utilisez Firecrawl avec Fastify pour créer des API de scraping web et de recherche haute performance.
- [Hono](https://docs.firecrawl.dev/fr/quickstarts/hono.md): Utilisez Firecrawl avec Hono pour créer des API légères de scraping web et de recherche qui fonctionnent partout.
- [Bun](https://docs.firecrawl.dev/fr/quickstarts/bun.md): Utilisez Firecrawl avec Bun pour créer des serveurs rapides de scraping web et de recherche.
- [Remix](https://docs.firecrawl.dev/fr/quickstarts/remix.md): Utilisez Firecrawl avec Remix pour extraire, rechercher et interagir avec les données du web dans votre application React full-stack.
- [Nuxt](https://docs.firecrawl.dev/fr/quickstarts/nuxt.md): Utilisez Firecrawl avec Nuxt pour extraire, faire des recherches et interagir avec les données du Web dans votre application Vue.
- [SvelteKit](https://docs.firecrawl.dev/fr/quickstarts/sveltekit.md): Utilisez Firecrawl avec SvelteKit pour extraire, rechercher et interagir avec des données web dans votre application Svelte.
- [Astro](https://docs.firecrawl.dev/fr/quickstarts/astro.md): Utilisez Firecrawl avec Astro pour extraire, rechercher et interagir avec des données web sur votre site riche en contenu.
- [Mastra](https://docs.firecrawl.dev/fr/quickstarts/mastra.md): Connectez Firecrawl aux outils Mastra pour permettre à vos agents et workflows de rechercher et de faire du scraping de données web en temps réel.

#### Serverless

- [Cloudflare Workers](https://docs.firecrawl.dev/fr/quickstarts/cloudflare-workers.md): Utilisez Firecrawl avec Cloudflare Workers pour rechercher, extraire et interagir avec des données du Web en périphérie.
- [Fonctions Vercel](https://docs.firecrawl.dev/fr/quickstarts/vercel-functions.md): Utilisez Firecrawl avec les fonctions Vercel pour rechercher, extraire et interagir avec des données web dans des déploiements serverless.
- [Vercel Marketplace](https://docs.firecrawl.dev/fr/quickstarts/vercel-marketplace.md): Installez Firecrawl depuis le Vercel Marketplace, associez-le à un projet et utilisez la variable FIRECRAWL_API_KEY injectée dans votre application Vercel.
- [AWS Lambda](https://docs.firecrawl.dev/fr/quickstarts/aws-lambda.md): Utilisez Firecrawl avec AWS Lambda pour rechercher, extraire et interagir avec des données web dans des fonctions sans serveur.
- [Fonctions Edge de Supabase](https://docs.firecrawl.dev/fr/quickstarts/supabase-edge-functions.md): Utilisez Firecrawl avec les fonctions Edge de Supabase pour rechercher, scraper et interagir avec des données web à l’edge.
- [Deno Deploy](https://docs.firecrawl.dev/fr/quickstarts/deno-deploy.md): Utilisez Firecrawl avec Deno Deploy pour rechercher, extraire et interagir avec des données web en périphérie.

#### PHP

- [PHP](https://docs.firecrawl.dev/fr/quickstarts/php.md): Découvrez Firecrawl en PHP. Extrayez, recherchez et interagissez avec des données web à l’aide de l’API REST.
- [Laravel](https://docs.firecrawl.dev/fr/quickstarts/laravel.md): Utilisez Firecrawl avec Laravel pour rechercher, extraire et interagir avec des données web via l’API REST.

#### Ruby

- [Ruby](https://docs.firecrawl.dev/fr/quickstarts/ruby.md): Premiers pas avec Firecrawl en Ruby. Recherchez, extrayez et interagissez avec des données web à l’aide de l’API REST.
- [Rails](https://docs.firecrawl.dev/fr/quickstarts/rails.md): Utilisez Firecrawl avec Ruby on Rails pour effectuer des recherches, scraper des données et interagir avec des données web à l’aide de l’API REST.

#### Python

- [Python](https://docs.firecrawl.dev/fr/quickstarts/python.md): Découvrez Firecrawl en Python. Scrapez, recherchez et interagissez avec les données web à l’aide du SDK officiel.
- [FastAPI](https://docs.firecrawl.dev/fr/quickstarts/fastapi.md): Utilisez Firecrawl avec FastAPI pour créer des API asynchrones de scraping web et de recherche en Python.
- [Django](https://docs.firecrawl.dev/fr/quickstarts/django.md): Utilisez Firecrawl avec Django pour extraire, rechercher et interagir avec des données du web dans votre application Python.
- [Flask](https://docs.firecrawl.dev/fr/quickstarts/flask.md): Utilisez Firecrawl avec Flask pour créer des API de scraping web et de recherche en Python.

#### Java

- [Java](https://docs.firecrawl.dev/fr/quickstarts/java.md): Démarrez avec Firecrawl en Java. Recherchez, scrapez et interagissez avec les données du Web à l’aide du SDK officiel.
- [Spring Boot](https://docs.firecrawl.dev/fr/quickstarts/spring-boot.md): Utilisez Firecrawl avec Spring Boot pour rechercher, scraper et interagir avec des données web grâce au SDK Java officiel.

#### .NET

- [.NET](https://docs.firecrawl.dev/fr/quickstarts/dotnet.md): Commencez avec Firecrawl en .NET. Scrapez, recherchez et interagissez avec les données du Web à l’aide de l’API REST.
- [ASP.NET Core](https://docs.firecrawl.dev/fr/quickstarts/aspnet-core.md): Utilisez Firecrawl avec ASP.NET Core pour rechercher, scraper et interagir avec les données du Web via l’API REST.

### Guides développeur

- [Modèles full stack](https://docs.firecrawl.dev/fr/developer-guides/examples.md): Découvrez des exemples concrets et des tutoriels pour Firecrawl

#### Guides d'utilisation

- [Choisir l’extracteur de données](https://docs.firecrawl.dev/fr/developer-guides/usage-guides/choosing-the-data-extractor.md): Comparer /agent, /extract et /scrape (mode JSON) pour sélectionner l’outil le plus adapté à l’extraction de données structurées
- [Vérifier la fraîcheur et l’activité](https://docs.firecrawl.dev/fr/developer-guides/usage-guides/verifying-freshness-and-liveness.md): Comprendre la différence entre la fraîcheur du contenu et l’actualité de l’état représenté par une page

#### SDKs et frameworks LLM

- [OpenAI](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/openai.md): Utilisez Firecrawl avec OpenAI pour le scraping web et des workflows d’IA
- [Anthropic](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/anthropic.md): Utilisez Firecrawl avec Claude pour le web scraping et des workflows d’IA
- [Gemini](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/gemini.md): Utilisez Firecrawl avec Gemini de Google pour le scraping web et des workflows d’IA
- [Agent Development Kit (ADK)](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/google-adk.md): Intégrez Firecrawl à l’ADK de Google via le Model Context Protocol (MCP) pour des workflows d’agents avancés
- [Vercel AI SDK](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/vercel-ai-sdk.md): Outils Firecrawl pour Vercel AI SDK. Web scraping, recherche, Interact et crawl pour les applications d'IA.
- [LangChain](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/langchain.md): Utilisez Firecrawl avec LangChain pour le scraping web et des workflows d’IA
- [LangGraph](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/langgraph.md): Intégrer Firecrawl à LangGraph pour créer des workflows d’agents
- [LlamaIndex](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/llamaindex.md): Utiliser Firecrawl avec LlamaIndex pour des applications RAG
- [Mastra](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/mastra.md): Utilisez Firecrawl avec Mastra pour créer des workflows d’IA
- [ElevenAgents](https://docs.firecrawl.dev/fr/developer-guides/llm-sdks-and-frameworks/elevenagents.md): Donnez aux agents vocaux et conversationnels ElevenLabs un accès au web en temps réel avec Firecrawl

#### Guides pratiques

- [Créer un assistant de recherche IA avec Firecrawl et l’AI SDK](https://docs.firecrawl.dev/fr/developer-guides/cookbooks/ai-research-assistant-cookbook.md): Créez un assistant de recherche complet alimenté par l’IA, avec des fonctions de scraping et de recherche web
- [Créer un générateur de charte graphique de marque avec Firecrawl](https://docs.firecrawl.dev/fr/developer-guides/cookbooks/brand-style-guide-generator-cookbook.md): Générez des chartes graphiques de marque professionnelles au format PDF en extrayant les systèmes de design de n'importe quel site web à l'aide du format de branding de Firecrawl

#### Intégrations

- [Intégrations](https://docs.firecrawl.dev/fr/integrations.md): Ajoutez la recherche web, le scraping et les interactions de Firecrawl aux agents de codage, créateurs d’applications, frameworks et plateformes d’automatisation que vous utilisez déjà
- [Agent Hermes](https://docs.firecrawl.dev/fr/integrations/hermes.md): Utilisez Firecrawl comme backend par défaut pour la recherche web et l’extraction dans Hermes Agent
- [Replit](https://docs.firecrawl.dev/fr/integrations/replit.md): Connecteur Replit officiel pour la recherche sur le web, le scraping et l’interaction avec le Browser de Firecrawl
- [Lovable](https://docs.firecrawl.dev/fr/integrations/lovable.md): Connectez Firecrawl à vos applications Lovable pour le scraping et le crawling web en temps réel
- [LangChain](https://docs.firecrawl.dev/fr/integrations/langchain.md): Utilisez Firecrawl dans LangChain comme chargeur de documents ou comme outil d’agent.
- [LlamaIndex](https://docs.firecrawl.dev/fr/integrations/llamaindex.md): Firecrawl s’intègre à LlamaIndex en tant que lecteur de documents.
- [CrewAI](https://docs.firecrawl.dev/fr/integrations/crewai.md): Découvrez comment utiliser Firecrawl avec CrewAI
- [Camel AI](https://docs.firecrawl.dev/fr/integrations/camelai.md): Firecrawl s’intègre à Camel AI comme chargeur de données.
- [Praison AI](https://docs.firecrawl.dev/fr/integrations/praison.md): Scrapez le web avec Firecrawl comme outil Praison AI
- [Dify](https://docs.firecrawl.dev/fr/integrations/dify.md): Plugin officiel Firecrawl pour les workflows Dify, avec synchronisation de sites web avec la base de connaissances
- [Langflow](https://docs.firecrawl.dev/fr/integrations/langflow.md): Découvrez comment utiliser Firecrawl avec Langflow
- [Flowise](https://docs.firecrawl.dev/fr/integrations/flowise.md): Apprenez à utiliser Firecrawl avec Flowise
- [Zapier](https://docs.firecrawl.dev/fr/integrations/zapier.md): Tutoriels officiels et modèles d’intégration Zapier pour automatiser avec Firecrawl
- [Make](https://docs.firecrawl.dev/fr/integrations/make.md): Intégration officielle de Firecrawl à Make et automatisation des workflows
- [n8n](https://docs.firecrawl.dev/fr/integrations/n8n.md): Découvrez comment utiliser Firecrawl avec n8n pour automatiser le scraping web grâce à ce guide complet, étape par étape.
- [Pipedream](https://docs.firecrawl.dev/fr/integrations/pipedream.md): Ajoutez des étapes Firecrawl de scrape, crawl, recherche, cartographie et extraction aux workflows Pipedream
- [Composio](https://docs.firecrawl.dev/fr/integrations/composio.md): Utilisez les outils Firecrawl dans les workflows d’agents Composio
- [SourceSync.ai](https://docs.firecrawl.dev/fr/integrations/sourcesyncai.md): Firecrawl s’intègre à SourceSync.ai pour le web scraping.

### Webhooks

- [Vue d’ensemble](https://docs.firecrawl.dev/fr/webhooks/overview.md): Notifications en temps réel pour vos opérations Firecrawl
- [Types d’événements](https://docs.firecrawl.dev/fr/webhooks/events.md): Référence des événements webhook
- [Sécurité](https://docs.firecrawl.dev/fr/webhooks/security.md): Vérifiez l’authenticité des webhooks
- [Tests](https://docs.firecrawl.dev/fr/webhooks/testing.md): Tester et déboguer des webhooks

### Cas d'utilisation

- [Cas d’utilisation](https://docs.firecrawl.dev/fr/use-cases/overview.md): Transformez les données web en fonctionnalités puissantes pour vos applications
- [Plateformes d’IA](https://docs.firecrawl.dev/fr/use-cases/ai-platforms.md): Alimentez des assistants IA et permettez à vos clients de créer des applications IA
- [Enrichissement de leads](https://docs.firecrawl.dev/fr/use-cases/lead-enrichment.md): Extraire et filtrer des leads à partir de sites web pour alimenter votre pipeline commercial
- [Plateformes SEO](https://docs.firecrawl.dev/fr/use-cases/seo-platforms.md): Optimiser les sites web pour les assistants IA et les moteurs de recherche
- [Recherche approfondie](https://docs.firecrawl.dev/fr/use-cases/deep-research.md): Créez des outils de recherche agentique avec des capacités avancées de recherche sur le web

#### Voir plus

- [Produit et e-commerce](https://docs.firecrawl.dev/fr/use-cases/product-ecommerce.md): Surveillez les prix et suivez les stocks sur les sites d’e-commerce
- [Génération de contenu](https://docs.firecrawl.dev/fr/use-cases/content-generation.md): Générez du contenu IA à partir de données de sites web, d’images et d’actualités
- [Développeurs & MCP](https://docs.firecrawl.dev/fr/use-cases/developers-mcp.md): Créez des intégrations puissantes avec la prise en charge du Model Context Protocol
- [Investissement & Finance](https://docs.firecrawl.dev/fr/use-cases/investment-finance.md): Suivez les entreprises et extrayez des informations financières à partir de données web
- [Veille concurrentielle](https://docs.firecrawl.dev/fr/use-cases/competitive-intelligence.md): Surveillez les sites des concurrents et suivez les évolutions en temps réel
- [Migration de données](https://docs.firecrawl.dev/fr/use-cases/data-migration.md): Transférez efficacement des données web entre plates-formes et systèmes
- [Observabilité et supervision](https://docs.firecrawl.dev/fr/use-cases/observability.md): Surveillez les sites web, suivez la disponibilité et détectez les changements en temps réel

### Autres

- [Vue d’ensemble](https://docs.firecrawl.dev/fr/dashboard.md): Vue d’ensemble du dashboard Firecrawl et de ses principales fonctionnalités
- [Déboguer Firecrawl avec Ask](https://docs.firecrawl.dev/fr/features/ask.md): Déboguez une tâche ayant échoué ou tout problème d'intégration Firecrawl avec une API de support agentique

### Contribuer

- [Open source ou Firecrawl Cloud](https://docs.firecrawl.dev/fr/contributing/open-source-or-cloud.md): Choisissez entre l’auto-hébergement de Firecrawl pour garder le contrôle de votre infrastructure et Firecrawl Cloud pour le chemin géré le plus rapide vers la production.
- [Exécuter Firecrawl localement pour le développement](https://docs.firecrawl.dev/fr/contributing/guide.md): Configurez l’environnement de développement de l’API Firecrawl, vérifiez un scrape local et exécutez le harnais de test fourni avec le code source avant de contribuer.
- [Auto-hébergement de Firecrawl](https://docs.firecrawl.dev/fr/contributing/self-host.md): Auto-hébergez Firecrawl avec Docker Compose, vérifiez un scrape local, comprenez les limites de la version open source et préparez la pile pour la production.
