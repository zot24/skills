---
description: Set up gh-issue-tracker in the current project
---

Set up `gh-issue-tracker` error tracking in this project. Follow these steps:

## 1. Detect framework

Determine the project's framework by checking:
- `next.config.*` or `app/` directory → **Next.js App Router**
- `express` in `package.json` dependencies → **Express**
- Otherwise → **Generic Node.js**

## 2. Determine architecture (ASK THE USER)

Ask: **"Do you need to capture client-side (browser) errors, or only server-side errors?"**

- **Server-only** (APIs, backend, scripts): Just `init()` + `captureException()`. Simplest setup.
- **Server + Client** (web apps with UI): Requires a proxy endpoint so the GitHub token stays server-side. Error boundaries in the browser POST to the proxy. NEVER expose `GITHUB_TOKEN` to the browser.

## 3. Install the package

```bash
npm install gh-issue-tracker
```

(Use the project's package manager: pnpm, yarn, or npm)

## 4. Configure environment variables

Add to `.env` (or `.env.local` for Next.js):

```env
GITHUB_TOKEN=<GitHub PAT with Issues read/write permission>
GITHUB_REPO=<owner/repo where issues should be created>
```

For client+server architecture, also add:
```env
ALLOWED_ORIGINS=https://myapp.com
```

Ensure `.env` is in `.gitignore`. Verify `GITHUB_TOKEN` does NOT have a `NEXT_PUBLIC_` prefix.

## 5. Framework-specific setup

### Next.js App Router

**Always do:**
1. Create `instrumentation.ts` at project root — see `examples/nextjs-instrumentation/`

**If capturing client errors (server + client architecture):**
2. Install `zod` if not present: `npm install zod`
3. Create `app/api/errors/capture/route.ts` — see `examples/nextjs-error-proxy/`
4. Create `app/error.tsx` and `app/global-error.tsx` — see `examples/nextjs-error-boundaries/`
5. Set `ALLOWED_ORIGINS` env var for production

### Express

1. Import and call `init()` at app startup
2. Add error handler middleware after all routes
3. See `examples/express-middleware/` for the complete pattern

### Generic Node.js

1. Import and call `init()` at the top of your entry point
2. Wrap critical code in try/catch, call `captureException()` in catch
3. Call `await flush()` before process exits

## 6. Security check

Verify before deploying:
- [ ] Token uses fine-grained PAT scoped to Issues only on the target repo
- [ ] Token env var is NOT prefixed with `NEXT_PUBLIC_` or `VITE_`
- [ ] `.env` is in `.gitignore`
- [ ] If using a proxy, it has origin allowlist and rate limiting
- [ ] For private repos, consider the proxy pattern to isolate the token

## 7. Verify

1. Start the application
2. Trigger a test error (both server-side and client-side if applicable)
3. Check the GitHub repository's Issues tab for a new issue with the `error-report` label
4. Trigger the same error again — verify it adds a reaction instead of creating a duplicate
