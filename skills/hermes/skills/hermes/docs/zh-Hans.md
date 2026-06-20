> Source: https://hermes-agent.nousresearch.com/docs/zh-Hans/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">跳到主要内容</a>


# Hermes Agent


由 <a href="https://nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Research</a> 构建的自我改进 AI 智能体。唯一内置学习循环的智能体——它从经验中创建技能，在使用过程中持续改进，主动提示自身持久化知识，并在会话间不断深化对你的建模。


<a href="/docs/zh-Hans/getting-started/installation" style="display:inline-block;padding:0.6rem 1.2rem;background-color:#FFD700;color:#07070d;border-radius:8px;font-weight:600;text-decoration:none"></a>

快速开始 →

<a href="https://github.com/NousResearch/hermes-agent" style="display:inline-block;padding:0.6rem 1.2rem;border:1px solid rgba(255,215,0,0.2);border-radius:8px;text-decoration:none"></a>

在 GitHub 上查看


## 安装<a href="#安装" class="hash-link" aria-label="安装的直接链接" translate="no" title="安装的直接链接">​</a>

**Linux / macOS / WSL2**


``` prism-code
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
```


**Windows（原生，PowerShell）** — *早期测试版，[详情 →](/docs/zh-Hans/user-guide/windows-native)*


``` prism-code
iex (irm https://hermes-agent.nousresearch.com/install.ps1)
```


**Android（Termux）** — 与 Linux 相同的 curl 一行命令；安装程序会自动检测 Termux。

请参阅完整的 **[安装指南](/docs/zh-Hans/getting-started/installation)**，了解安装程序的具体操作、按用户与 root 的目录布局以及 Windows 相关说明。

## Hermes Agent 是什么？<a href="#hermes-agent-是什么" class="hash-link" aria-label="Hermes Agent 是什么？的直接链接" translate="no" title="Hermes Agent 是什么？的直接链接">​</a>

它不是绑定在 IDE 上的编程副驾驶，也不是对单一 API 的聊天机器人封装。它是一个**自主智能体**，运行时间越长，能力越强。它可以部署在任何地方——5 美元的 VPS、GPU 集群，或者闲置时几乎零成本的 serverless 基础设施（Daytona、Modal）。在 Telegram 上与它对话，同时让它在你从未亲自 SSH 登录的云端虚拟机上工作。它不依赖你的本地电脑。

## 快速链接<a href="#快速链接" class="hash-link" aria-label="快速链接的直接链接" translate="no" title="快速链接的直接链接">​</a>

|                                                                                    |                                                                    |
|------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| 🚀 **[安装](/docs/zh-Hans/getting-started/installation)**                          | 在 Linux、macOS、WSL2 或原生 Windows（早期测试版）上 60 秒完成安装 |
| 📖 **[快速入门教程](/docs/zh-Hans/getting-started/quickstart)**                    | 第一次对话及值得尝试的核心功能                                     |
| 🗺️ **[学习路径](/docs/zh-Hans/getting-started/learning-path)**                     | 根据你的经验水平找到合适的文档                                     |
| ⚙️ **[配置](/docs/zh-Hans/user-guide/configuration)**                              | 配置文件、提供商、模型及选项                                       |
| 💬 **[消息网关](/docs/zh-Hans/user-guide/messaging)**                              | 配置 Telegram、Discord、Slack、WhatsApp、Teams 等平台              |
| 🔧 **[工具与工具集](/docs/zh-Hans/user-guide/features/tools)**                     | 70+ 内置工具及其配置方式                                           |
| 🧠 **[记忆系统](/docs/zh-Hans/user-guide/features/memory)**                        | 跨会话持续增长的持久记忆                                           |
| 📚 **[技能系统](/docs/zh-Hans/user-guide/features/skills)**                        | 智能体创建并复用的程序性记忆                                       |
| 🔌 **[MCP 集成](/docs/zh-Hans/user-guide/features/mcp)**                           | 连接 MCP 服务器、过滤其工具，并安全扩展 Hermes                     |
| 🧭 **[在 Hermes 中使用 MCP](/docs/zh-Hans/guides/use-mcp-with-hermes)**            | 实用的 MCP 配置模式、示例与教程                                    |
| 🎙️ **[语音模式](/docs/zh-Hans/user-guide/features/voice-mode)**                    | 在 CLI、Telegram、Discord 及 Discord 语音频道中进行实时语音交互    |
| 🗣️ **[在 Hermes 中使用语音模式](/docs/zh-Hans/guides/use-voice-mode-with-hermes)** | Hermes 语音工作流的实操配置与使用模式                              |
| 🎭 **[个性与 SOUL.md](/docs/zh-Hans/user-guide/features/personality)**             | 通过全局 SOUL.md 定义 Hermes 的默认风格                            |
| 📄 **[上下文文件](/docs/zh-Hans/user-guide/features/context-files)**               | 影响每次对话的项目上下文文件                                       |
| 🔒 **[安全](/docs/zh-Hans/user-guide/security)**                                   | 命令审批、授权与容器隔离                                           |
| 💡 **[技巧与最佳实践](/docs/zh-Hans/guides/tips)**                                 | 快速上手，充分发挥 Hermes 的潜力                                   |
| 🏗️ **[架构](/docs/zh-Hans/developer-guide/architecture)**                          | 底层工作原理                                                       |
| ❓ **[常见问题与故障排查](/docs/zh-Hans/reference/faq)**                           | 常见问题及解决方案                                                 |

## 核心功能<a href="#核心功能" class="hash-link" aria-label="核心功能的直接链接" translate="no" title="核心功能的直接链接">​</a>

- **闭环学习循环** — 智能体管理的记忆，配合定期提示、自主技能创建、使用中的技能自我改进、基于 FTS5 的跨会话召回与 LLM 摘要，以及 <a href="https://github.com/plastic-labs/honcho" target="_blank" rel="noopener noreferrer">Honcho</a> 辩证式用户建模
- **随处运行，不限于本地** — 6 种终端后端：本地、Docker、SSH、Daytona、Singularity、Modal。Daytona 和 Modal 提供 serverless 持久化——环境闲置时休眠，几乎零成本
- **在你所在的地方** — CLI、Telegram、Discord、Slack、WhatsApp、Signal、Matrix、Mattermost、Email、SMS、DingTalk、Feishu、WeCom、Weixin、QQ Bot、Yuanbao、BlueBubbles、Home Assistant、Microsoft Teams、Google Chat 等——通过一个网关支持 20+ 平台
- **由模型训练者构建** — 由 <a href="https://nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Research</a> 创建，该实验室是 Hermes、Nomos 和 Psyche 背后的团队。支持 <a href="https://portal.nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Portal</a>、<a href="https://openrouter.ai" target="_blank" rel="noopener noreferrer">OpenRouter</a>、OpenAI 或任意端点
- **定时自动化** — 内置 cron，可向任意平台投递
- **委托与并行** — 派生隔离的子智能体以并行处理多个工作流。通过 `execute_code` 实现程序化工具调用，将多步骤流水线压缩为单次推理调用
- **开放标准技能** — 兼容 <a href="https://agentskills.io" target="_blank" rel="noopener noreferrer">agentskills.io</a>。技能可移植、可共享，并通过 Skills Hub 接受社区贡献
- **完整的 Web 控制** — 搜索、提取、浏览、视觉、图像生成、TTS
- **MCP 支持** — 连接任意 MCP 服务器以扩展工具能力
- **研究就绪** — 批处理、轨迹导出、基于 Atropos 的 RL 训练。由 <a href="https://nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Research</a> 构建——该实验室是 Hermes、Nomos 和 Psyche 模型背后的团队

## 面向 LLM 和编程智能体<a href="#面向-llm-和编程智能体" class="hash-link" aria-label="面向 LLM 和编程智能体的直接链接" translate="no" title="面向 LLM 和编程智能体的直接链接">​</a>

本文档的机器可读入口：

- **<a href="/docs/zh-Hans/assets/files/llms-c03199c2b1721b8eb2141fff54dcfad5.txt" target="_blank"><code>/llms.txt</code></a>** — 每个文档页面的精选索引，附简短描述。约 17 KB，可安全加载到 LLM 上下文中。
- **<a href="/docs/zh-Hans/assets/files/llms-full-0fe36c343c4249932fd0fcdf54924bc6.txt" target="_blank"><code>/llms-full.txt</code></a>** — 所有文档页面拼接为单一 markdown 文件，支持一次性摄取。约 1.8 MB。

两个文件同样可通过 `/docs/llms.txt` 和 `/docs/llms-full.txt` 访问。每次部署时全新生成。


