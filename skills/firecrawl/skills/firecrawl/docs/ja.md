> Source: https://docs.firecrawl.dev/_llms/ja.md

# Firecrawl Docs: Japanese

## Japanese

- [Japanese / v2 (202 pages)](https://docs.firecrawl.dev/_llms/ja/v2.md): Documentation for Japanese / v2.

### v1

#### ドキュメント

##### はじめに

- [はじめに](https://docs.firecrawl.dev/ja/introduction.md): ウェブを検索し、あらゆるページをスクレイピングして操作できます、すべてを1つのAPIで。
- [はじめに](https://docs.firecrawl.dev/ja/mcp-server.md): キーレスアクセス、アカウントへのサインイン、またはAPIキーを使用してFirecrawl MCPを設定します。
- [v1 → v2 移行](https://docs.firecrawl.dev/ja/migrate-to-v2.md): v2 へのアップグレードに必要な主要な変更点、マッピング、ビフォー・アフターのスニペット。
- [高度なスクレイピングガイド](https://docs.firecrawl.dev/ja/advanced-scraping-guide.md): Firecrawl の API 全体で、スクレイピングオプション、ブラウザ アクション、クロール、マップ、エージェントエンドポイントを構成します。

###### プランと課金

- [課金](https://docs.firecrawl.dev/ja/billing.md): Firecrawl の課金、クレジット、プランの仕組み
- [レート制限](https://docs.firecrawl.dev/ja/rate-limits.md): 料金プラン別およびAPIリクエストのレート制限
- [パートナークレジット](https://docs.firecrawl.dev/ja/partner-credits.md): 対象条件、有効期限、プランごとの上限など、Firecrawlのパートナークレジットの仕組み

###### エンタープライズ

- [Enterprise](https://docs.firecrawl.dev/ja/enterprise.md): 大規模な Firecrawl 向けの Enterprise プラン、セキュリティ、機能
- [IP制限](https://docs.firecrawl.dev/ja/features/ip-restrictions.md): チームのAPIキーをIPアドレスまたはCIDR範囲の許可リストに制限し、承認済みネットワークからのみ利用できるようにします。サーバー側で適用されます。
- [キー制限](https://docs.firecrawl.dev/ja/features/key-restrictions.md): 個別のAPIキーを特定の出力フォーマットとエンドポイントに限定します。サーバー側で強制されるため、リクエストで上書きすることはできません。
- [脅威保護](https://docs.firecrawl.dev/ja/features/threat-protection.md): 組織が管理するポリシーを使って、すべてのエンドポイントで危険な URL へのリクエストをブロックします。サーバー側で適用されます。
- [SIEM 監査ログ](https://docs.firecrawl.dev/ja/features/siem.md): チームが実行するすべてのスクレイピングについて、構造化された監査イベントを自社の SIEM にストリーミングします。Microsoft Sentinel から順次対応し、サーバー側で配信されます。

##### 基本機能

- [クロール](https://docs.firecrawl.dev/ja/features/crawl.md): ウェブサイトを再帰的にクロールし、各ページからコンテンツを取得します
- [Map](https://docs.firecrawl.dev/ja/features/map.md): ウェブサイトを入力すると、サイト内のすべてのURLを超高速で取得
- [検索](https://docs.firecrawl.dev/ja/features/search.md): ウェブを検索し、結果から完全なコンテンツを取得

###### スクレイピング

- [スクレイピング](https://docs.firecrawl.dev/ja/features/scrape.md): あらゆるURLをクリーンなデータに変換
- [スクレイピングを高速化](https://docs.firecrawl.dev/ja/features/fast-scraping.md): maxAge（キャッシュ）パラメータでスクレイプを最大5倍高速化
- [バッチスクレイピング](https://docs.firecrawl.dev/ja/features/batch-scrape.md): 単一のバッチジョブで複数のURLをスクレイピングする
- [JSONモード - 構造化結果](https://docs.firecrawl.dev/ja/features/llm-extract.md): LLMでページから構造化データを抽出する
- [変更追跡](https://docs.firecrawl.dev/ja/features/change-tracking.md): スクレイプ間でのウェブコンテンツの変更を検出・監視する
- [Enhanced Mode](https://docs.firecrawl.dev/ja/features/enhanced-mode.md): 強化プロキシを使用して、複雑なサイトを安定してスクレイピングする
- [プロキシ](https://docs.firecrawl.dev/ja/features/proxies.md): プロキシの種類やロケーション、Firecrawl がリクエストに対してプロキシを選択する方法について解説します。

##### エージェント機能

- [FIRE-1 エージェント（ベータ）](https://docs.firecrawl.dev/ja/agents/fire-1.md): ウェブページを知的にナビゲートし、対話できる AI エージェント

##### ウェブフック

- [概要](https://docs.firecrawl.dev/ja/webhooks/overview.md): Firecrawl のオペレーションに対するリアルタイム通知
- [イベントタイプ](https://docs.firecrawl.dev/ja/webhooks/events.md): Webhook イベントリファレンス
- [セキュリティ](https://docs.firecrawl.dev/ja/webhooks/security.md): Webhook の正当性を検証する
- [テスト](https://docs.firecrawl.dev/ja/webhooks/testing.md): Webhook のテストとデバッグ

##### ダッシュボード

- [概要](https://docs.firecrawl.dev/ja/dashboard.md): Firecrawlダッシュボードとその主要機能の概要

#### SDK

##### 概要

- [概要](https://docs.firecrawl.dev/ja/sdks/overview.md): Firecrawl SDKは、Firecrawl APIを包むラッパーで、Webの検索、スクレイピング、Interactを手軽に行えます。

##### 公式

- [Python](https://docs.firecrawl.dev/ja/sdks/python.md): Firecrawl Python SDK は、Firecrawl API のラッパーで、ウェブサイトを手軽に Markdown に変換できます。
- [Node](https://docs.firecrawl.dev/ja/sdks/node.md): Firecrawl Node SDK を使って、Web サイトをスクレイピング、クロールし、構造化データを抽出します。
- [Go](https://docs.firecrawl.dev/ja/sdks/go.md): Firecrawl Go SDK は、Web サイトを簡単に Markdown に変換するための Firecrawl API のラッパーです。
- [Java](https://docs.firecrawl.dev/ja/sdks/java.md): Firecrawl Java SDK は、Web サイトを簡単に Markdown に変換するための Firecrawl API のラッパーです。
- [Ruby](https://docs.firecrawl.dev/ja/sdks/ruby.md): Firecrawl Ruby SDK は、Web サイトを簡単に Markdown に変換できるようにする、Firecrawl API のラッパーです。
- [Rust](https://docs.firecrawl.dev/ja/sdks/rust.md): Firecrawl Rust SDK は、Web サイトを簡単に Markdown に変換できる Firecrawl API のラッパーです。
- [.NET](https://docs.firecrawl.dev/ja/sdks/dotnet.md): Firecrawl .NET SDK は、Firecrawl API のラッパーで、Web サイトを簡単に Markdown に変換できます。
- [PHP](https://docs.firecrawl.dev/ja/sdks/php.md): Firecrawl PHP SDK は、Web サイトを簡単に Markdown に変換できる Firecrawl API のラッパーです。
- [Elixir](https://docs.firecrawl.dev/ja/sdks/elixir.md): Firecrawl Elixir SDK は、Req と NimbleOptions を使用して構築された、Firecrawl API v2 向けの自動生成クライアントです。

## OpenAPI Specs

- [v2-openapi](/ja/api-reference/v2-openapi.json)
- [webhooks-openapi](/ja/api-reference/webhooks-openapi.json)

## Optional

- [プレイグラウンド](https://firecrawl.dev/playground)
- [ブログ](https://firecrawl.dev/blog)
- [コミュニティ](https://community.firecrawl.dev/)
- [変更履歴](https://firecrawl.dev/changelog)
- [インテグレーション](https://www.firecrawl.dev/app)
