> Source: https://docs.firecrawl.dev/_llms/zh.md

# Firecrawl Docs: Chinese

## Chinese

- [Chinese / v2 (202 pages)](https://docs.firecrawl.dev/_llms/zh/v2.md): Documentation for Chinese / v2.

### v1

#### 文档

##### 快速开始

- [介绍](https://docs.firecrawl.dev/zh/introduction.md): 通过一个 API 即可进行网页搜索、抓取任意页面并与之交互。
- [开始使用](https://docs.firecrawl.dev/zh/mcp-server.md): 通过免密钥访问、账户登录或 API 密钥设置 Firecrawl MCP。
- [从 v1 迁移到 v2](https://docs.firecrawl.dev/zh/migrate-to-v2.md): 关键变更、对应关系，以及升级到 v2 的前后示例片段。
- [高级抓取指南](https://docs.firecrawl.dev/zh/advanced-scraping-guide.md): 通过 Firecrawl 的完整 API 接口配置抓取选项、浏览器 actions、爬取、映射以及 代理 端点。

###### 套餐与计费

- [计费](https://docs.firecrawl.dev/zh/billing.md): Firecrawl 的计费、额度和方案如何运作
- [速率限制](https://docs.firecrawl.dev/zh/rate-limits.md): 不同定价方案与 API 请求的速率限制
- [合作伙伴额度](https://docs.firecrawl.dev/zh/partner-credits.md): Firecrawl 合作伙伴额度的运作方式，包括适用资格、到期时间和套餐限制

###### 企业版

- [Enterprise](https://docs.firecrawl.dev/zh/enterprise.md): 适用于 Firecrawl 大规模使用场景的 Enterprise 计划、安全性和功能
- [IP 限制](https://docs.firecrawl.dev/zh/features/ip-restrictions.md): 将你团队的 API 密钥限制为仅可从已批准的 IP 地址或 CIDR 范围允许列表所在网络使用。由服务器端强制执行。
- [密钥限制](https://docs.firecrawl.dev/zh/features/key-restrictions.md): 将单个 API 密钥限制为只能使用特定的输出格式和端点。限制在服务器端强制执行，请求无法覆盖。
- [威胁防护](https://docs.firecrawl.dev/zh/features/threat-protection.md): 通过由您的组织控制的策略，在所有端点上封禁对高风险 URL 的请求，并在服务端强制执行。
- [SIEM 审计日志](https://docs.firecrawl.dev/zh/features/siem.md): 将团队每次执行 scrape 时产生的结构化审计事件流式传输到您自己的 SIEM，首先支持 Microsoft Sentinel。由服务器端推送。

##### 标准功能

- [爬取](https://docs.firecrawl.dev/zh/features/crawl.md): 递归爬取网站并获取每个页面的内容
- [Map](https://docs.firecrawl.dev/zh/features/map.md): 输入网站即可极快获取其所有 URL
- [搜索](https://docs.firecrawl.dev/zh/features/search.md): 搜索网络并获取结果的完整内容

###### 抓取

- [抓取](https://docs.firecrawl.dev/zh/features/scrape.md): 将任意 URL 转换为干净的数据
- [更快的抓取](https://docs.firecrawl.dev/zh/features/fast-scraping.md): 使用 maxAge（缓存）参数将抓取速度提升 500%
- [批量抓取](https://docs.firecrawl.dev/zh/features/batch-scrape.md): 通过单个批处理作业抓取多个 URL
- [JSON 模式 - 结构化结果](https://docs.firecrawl.dev/zh/features/llm-extract.md): 通过 LLMs 从页面提取结构化数据
- [变更追踪](https://docs.firecrawl.dev/zh/features/change-tracking.md): 在多次抓取之间检测和监控网页内容变更
- [增强模式](https://docs.firecrawl.dev/zh/features/enhanced-mode.md): 针对复杂网站使用增强代理，实现可靠抓取
- [代理](https://docs.firecrawl.dev/zh/features/proxies.md): 了解代理类型、位置，以及 Firecrawl 如何为你的请求选择代理。

##### 智能体功能

- [FIRE-1 代理（测试版）](https://docs.firecrawl.dev/zh/agents/fire-1.md): 支持在网页上进行智能导航与交互的 AI 代理

##### Webhook 回调

- [概览](https://docs.firecrawl.dev/zh/webhooks/overview.md): 为你的 Firecrawl 操作提供实时通知
- [事件类型](https://docs.firecrawl.dev/zh/webhooks/events.md): Webhook 事件参考
- [安全](https://docs.firecrawl.dev/zh/webhooks/security.md): 验证 Webhook 的真实性
- [测试](https://docs.firecrawl.dev/zh/webhooks/testing.md): 对 webhook 进行测试与调试

##### Dashboard

- [概览](https://docs.firecrawl.dev/zh/dashboard.md): Firecrawl Dashboard 及其主要功能概览

#### SDK

##### 概览

- [概览](https://docs.firecrawl.dev/zh/sdks/overview.md): Firecrawl SDK 是对 Firecrawl API 的封装，帮助你轻松搜索、抓取并与网页交互。

##### 官方

- [Python](https://docs.firecrawl.dev/zh/sdks/python.md): Firecrawl Python SDK 是 Firecrawl API 的封装，帮助你轻松将网站转换为 Markdown。
- [Node](https://docs.firecrawl.dev/zh/sdks/node.md): 使用 Firecrawl Node SDK，从网站抓取、爬取并提取结构化数据。
- [Go](https://docs.firecrawl.dev/zh/sdks/go.md): Firecrawl Go SDK 是对 Firecrawl API 的封装，可帮助你轻松将网站转换为 Markdown。
- [Java](https://docs.firecrawl.dev/zh/sdks/java.md): Firecrawl Java SDK 是对 Firecrawl API 的封装，帮助你轻松将网站转换为 Markdown。
- [Ruby](https://docs.firecrawl.dev/zh/sdks/ruby.md): Firecrawl Ruby SDK 是对 Firecrawl API 的封装，帮助你轻松将网站转换为 Markdown。
- [Rust](https://docs.firecrawl.dev/zh/sdks/rust.md): Firecrawl Rust SDK 是对 Firecrawl API 的封装，可帮助你轻松将网站转换为 Markdown。
- [.NET](https://docs.firecrawl.dev/zh/sdks/dotnet.md): Firecrawl .NET SDK 是对 Firecrawl API 的封装，帮助你轻松将网站转换为 Markdown。
- [PHP](https://docs.firecrawl.dev/zh/sdks/php.md): Firecrawl PHP SDK 是对 Firecrawl API 的封装，可帮助你轻松将网站转换为 markdown。
- [Elixir](https://docs.firecrawl.dev/zh/sdks/elixir.md): Firecrawl Elixir SDK 是 Firecrawl API v2 的自动生成客户端，基于 Req 和 NimbleOptions 构建。

## OpenAPI Specs

- [v2-openapi](/zh/api-reference/v2-openapi.json)
- [webhooks-openapi](/zh/api-reference/webhooks-openapi.json)

## Optional

- [沙盒](https://firecrawl.dev/playground)
- [博客](https://firecrawl.dev/blog)
- [社区](https://community.firecrawl.dev/)
- [更新日志](https://firecrawl.dev/changelog)
- [集成](https://www.firecrawl.dev/app)
