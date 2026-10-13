// Secrets set with `wrangler secret put` (values from 1Password via Varlock).
// `pnpm types` regenerates worker-configuration.d.ts from wrangler.jsonc.
declare namespace Cloudflare {
  interface Env {
    STRIPE_SECRET_KEY?: string;
    STRIPE_WEBHOOK_SECRET?: string;
    RESEND_API_KEY?: string;
  }
}

interface ImportMetaEnv {
  readonly PUBLIC_UMAMI_HOST: string;
  readonly PUBLIC_UMAMI_WEBSITE_ID: string;
  readonly PUBLIC_DEPLOY_ENV: 'production' | 'preview';
}

interface Window {
  umami?: { track: (event: string, data?: Record<string, unknown>) => void };
}
