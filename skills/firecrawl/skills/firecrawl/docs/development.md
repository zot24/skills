> Source: https://docs.firecrawl.dev/mcp-server/development.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Develop Firecrawl MCP

> Build, test, and contribute to the Firecrawl MCP server.

## Prerequisites

* [Git](https://git-scm.com/downloads)
* Node.js 22 or newer
* npm, included with Node.js

Confirm the Node.js version before installing dependencies:

```bash theme={null}
node --version
```

## Clone and test the server

```bash theme={null}
git clone https://github.com/firecrawl/firecrawl-mcp-server.git
cd firecrawl-mcp-server
npm install
npm run build
npm test
```

Run the linter before submitting a change:

```bash theme={null}
npm run lint
```

## Contributing

1. Fork the [Firecrawl MCP server repository](https://github.com/firecrawl/firecrawl-mcp-server).
2. Clone your fork and create a feature branch.
3. Run `npm run lint` and `npm test`.
4. Submit a pull request with the behavior and verification evidence.

## Thanks to contributors

Thanks to [@vrknetha](https://github.com/vrknetha), [@cawstudios](https://caw.tech) for the initial implementation!

Thanks to MCP.so and Klavis AI for hosting and [@gstarwd](https://github.com/gstarwd), [@xiangkaiz](https://github.com/xiangkaiz) and [@zihaolin96](https://github.com/zihaolin96) for integrating our server.

## License

MIT License - see LICENSE file for details
