---
description: Verify error tracking is working correctly
---

Verify that `gh-issue-tracker` is properly configured and working in this project.

## 1. Check configuration

- Verify `GITHUB_TOKEN` is set in environment (check `.env`, `.env.local`, or hosting platform)
- Verify `GITHUB_REPO` is set and in `owner/repo` format
- Verify `init()` is called at app startup (check `instrumentation.ts` or app entry point)
- Verify `enabled` is not set to `false`

## 2. Check GitHub token permissions

```bash
# Test token has Issues access
gh api repos/${GITHUB_REPO}/issues?per_page=1 --jq length
```

If this returns a number, the token works. If it returns an error, check token permissions.

## 3. Trigger a test error

### Next.js

Add a temporary test route or throw in an existing page:

```ts
// In any server component or API route:
throw new Error('gh-issue-tracker test error — safe to close')
```

### Express / Node.js

```ts
import { captureException, flush } from 'gh-issue-tracker'
captureException(new Error('gh-issue-tracker test error — safe to close'))
await flush()
console.log('Test error sent!')
```

## 4. Verify issue creation

```bash
# Check for the test issue
gh issue list --repo ${GITHUB_REPO} --label "error-report" --state open --limit 5
```

You should see an issue titled `[Error] Error: gh-issue-tracker test error — safe to close`.

## 5. Verify deduplication

Trigger the same error again. Then check:

```bash
# The issue count should NOT increase — the existing issue should have a reaction added
gh issue list --repo ${GITHUB_REPO} --label "error-report" --state open --limit 5
```

The existing issue should have a thumbs-up reaction, not a new duplicate issue.

## 6. Clean up

Close the test issue:

```bash
gh issue list --repo ${GITHUB_REPO} --label "error-report" --state open \
  --json number,title --jq '.[] | select(.title | contains("test error")) | .number' \
  | xargs -I {} gh issue close {} --comment "Test error — verified tracking works"
```

## Common problems

| Symptom | Check |
|---------|-------|
| No issue created | Is `GITHUB_TOKEN` set? Is `enabled: true`? Check server logs for `[error-tracker]` messages. |
| 403 error | Token lacks `Issues: read/write` permission on the target repo |
| Duplicate issues | Error messages may contain dynamic values (timestamps, IDs). The fingerprint uses the first 100 chars of the message. |
| Rate limited | More than 10 errors/minute. Check `rateLimitPerMinute` config. |
