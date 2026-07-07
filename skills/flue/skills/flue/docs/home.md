> Source: https://flueframework.com



<a href="/blog/flue-1-0-beta/" class="group mb-5 inline-flex items-center gap-2 text-sm font-medium text-gray-600 transition-colors hover:text-gray-950"><span>1.0 Beta — Read the announcement</span> <span class="transition-transform group-hover:translate-x-1">→</span></a>

# The Open Agent Framework

Build durable AI agents and workflows with Flue's programmable TypeScript harness. Write once, deploy anywhere, use any LLM.


Watch Video


``` astro-code
import { defineAgent } from '@flue/runtime';
import { local } from '@flue/runtime/node';
import triage from '../skills/triage/SKILL.md' with { type: 'skill' };
import verify from '../skills/verify/SKILL.md' with { type: 'skill' };
import { replyToIssue } from '../tools/github.ts';

// Expose (and protect) your agents to the world:
export const route = (c, next) => next();

// Give agents the autonomy to solve complex tasks:
const instructions = `
Triage a bug report end-to-end: reproduce the bug,
diagnose the root cause, verify whether the behavior is
intentional, and attempt a fix.`;

// Compose the context your agent needs to do real work,
// complete with virtual, local, or remote container sandbox.
export default defineAgent(() => ({
  model:   'anthropic/claude-sonnet-4-6',
  tools:   [replyToIssue],
  skills:  [triage, verify],
  sandbox: local(),
  instructions,
}));
```


## Powered by Pi, the open agent harness.

Flue is powered by Pi, the trusted agent harness used by OpenClaw and millions worldwide. Pi gives you the tools you need to unlock real agent autonomy, moving beyond simple chatbots.

Pi is the core of our open tech stack including <a href="https://durablestreams.com/" class="text-gray-700 underline decoration-gray-300 underline-offset-2 transition-colors hover:text-gray-950">Durable Streams</a>, <a href="https://vite.dev/" class="text-gray-700 underline decoration-gray-300 underline-offset-2 transition-colors hover:text-gray-950">Vite</a>, and a flexible <a href="https://flueframework.com/docs/guide/sandboxes/#remote-sandboxes" class="text-gray-700 underline decoration-gray-300 underline-offset-2 transition-colors hover:text-gray-950">Sandbox API</a>. Deploy Flue anywhere with confidence.


## Durability. Recovery. It's all handled for you.

Agents can’t die when the server goes down. Flue records every session in a durable stream, then safely resumes interrupted work when the runtime comes back online. Run one agent or a multi-agent swarm on the same durable foundation.

- Accepted work is never lost
- Interrupted sessions resume automatically
- Clients reconnect without starting over


\[disrupt\]


## Bring the stack you already love.

<a href="/docs/ecosystem/" class="group mt-3 inline-flex items-center gap-2 text-lg font-normal text-gray-600 transition-colors hover:text-gray-950">Explore our ecosystem <span class="transition-transform group-hover:translate-x-1">→</span></a>


- <a href="/docs/ecosystem/deploy/cloudflare/" class="group block" aria-label="Cloudflare"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/cloudflare.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/slack/" class="group block" aria-label="Slack"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/slack.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/github/" class="group block" aria-label="GitHub"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #181717"> <img src="https://svgl.app/library/github_light.svg" class="object-contain h-[61%] w-[61%] brightness-0 invert" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/databases/postgres/" class="group block" aria-label="Postgres"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/postgresql.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/discord/" class="group block" aria-label="Discord"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #5865f2"> <img src="https://svgl.app/library/discord.svg" class="object-contain h-[61%] w-[61%] brightness-0 invert" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/deploy/docker/" class="group block" aria-label="Docker"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/docker.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/stripe/" class="group block" aria-label="Stripe"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #635bff"> <img src="https://svgl.app/library/stripe.svg" class="object-contain h-[61%] w-[61%] brightness-0 invert" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/deploy/aws/" class="group block" aria-label="AWS"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #181717"> <img src="https://svgl.app/library/aws_dark.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/shopify/" class="group block" aria-label="Shopify"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/shopify.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/tooling/braintrust/" class="group block" aria-label="Braintrust"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #2c1fea"> <img src="data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2027%2027%22%3E%3Cpath%20fill%3D%22%23fff%22%20d%3D%22M9.552%200c1.507%200%202.729%201.237%202.729%202.762v2.76c0%201.525-1.222%202.762-2.729%202.762H8.188v1.074h1.364c1.507%200%202.729%201.236%202.729%202.761v2.762c0%201.525-1.222%202.761-2.729%202.761H8.188v1.074h1.364c1.507%200%202.729%201.237%202.729%202.762v2.76c0%201.525-1.222%202.762-2.729%202.762h-2.73c-1.507%200-2.728-1.237-2.728-2.762v-1.917H2.729C1.222%2022.321%200%2021.085%200%2019.56v-2.762c0-1.525%201.223-2.761%202.729-2.761h1.365v-1.074H2.729C1.223%2012.963%200%2011.727%200%2010.202V7.44c0-1.525%201.222-2.761%202.729-2.761h1.365V2.762C4.094%201.237%205.315%200%206.822%200zm9.4%200c1.507%200%202.729%201.237%202.729%202.762v1.917h1.365c1.507%200%202.728%201.237%202.728%202.761v2.762c0%201.525-1.221%202.761-2.728%202.761h-1.365v1.074h1.365c1.507%200%202.728%201.236%202.728%202.761v2.762c0%201.524-1.221%202.761-2.728%202.761h-1.365v1.917c0%201.525-1.222%202.762-2.729%202.762h-2.729c-1.507%200-2.728-1.237-2.728-2.762v-2.76c0-1.525%201.221-2.762%202.728-2.762h1.364v-1.074h-1.364c-1.507%200-2.728-1.236-2.728-2.761v-2.762c0-1.525%201.221-2.761%202.728-2.761h1.364V8.284h-1.364c-1.507%200-2.728-1.237-2.728-2.762v-2.76C13.495%201.237%2014.716%200%2016.223%200z%22%2F%3E%3C%2Fsvg%3E" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/linear/" class="group block" aria-label="Linear"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #181717"> <img src="https://svgl.app/library/linear.svg" class="object-contain h-[61%] w-[61%] brightness-0 invert" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/tooling/sentry/" class="group block" aria-label="Sentry"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/sentry.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/whatsapp/" class="group block" aria-label="WhatsApp"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #25d366"> <img src="https://svgl.app/library/whatsapp-icon.svg" class="object-contain h-[61%] w-[61%] brightness-0 invert" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/deploy/railway/" class="group block" aria-label="Railway"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #181717"> <img src="https://svgl.app/library/railway.svg" class="object-contain h-[61%] w-[61%] brightness-0 invert" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/databases/supabase/" class="group block" aria-label="Supabase"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/supabase.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/notion/" class="group block" aria-label="Notion"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/notion.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/sandboxes/daytona/" class="group block" aria-label="Daytona"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #181717"> </span></a>
- <a href="/docs/ecosystem/deploy/render/" class="group block" aria-label="Render"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/render_black.svg" class="object-contain h-[82%] w-[82%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/sandboxes/vercel/" class="group block" aria-label="Vercel Sandbox"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #181717"> <img src="https://svgl.app/library/vercel.svg" class="object-contain h-[48%] w-[48%] brightness-0 invert" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/telegram/" class="group block" aria-label="Telegram"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/telegram.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/deploy/gitlab-ci/" class="group block" aria-label="GitLab CI/CD"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/gitlab.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/google-chat/" class="group block" aria-label="Google Chat"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/google-chat.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/teams/" class="group block" aria-label="Microsoft Teams"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/microsoft-teams.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/databases/mysql/" class="group block" aria-label="MySQL"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/mysql-icon-light.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/deploy/node/" class="group block" aria-label="Node.js"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/nodejs.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/databases/redis/" class="group block" aria-label="Redis"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/redis.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/sandboxes/e2b/" class="group block" aria-label="E2B"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <span class="text-2xl font-black tracking-[-0.08em] text-gray-950 sm:text-3xl" aria-hidden="true">E2B</span> </span></a>
- <a href="/docs/ecosystem/databases/mongodb/" class="group block" aria-label="MongoDB"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #00ed64"> <img src="https://svgl.app/library/mongodb-icon-light.svg" class="object-contain h-[61%] w-[61%] brightness-0 invert" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/tooling/opentelemetry/" class="group block" aria-label="OpenTelemetry"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20128%20128%22%3E%3Cpath%20fill%3D%22%23f5a800%22%20d%3D%22M67.648%2069.797c-5.246%205.25-5.246%2013.758%200%2019.008%205.25%205.246%2013.758%205.246%2019.004%200%205.25-5.25%205.25-13.758%200-19.008-5.246-5.246-13.754-5.246-19.004%200Zm14.207%2014.219a6.649%206.649%200%200%201-9.41%200%206.65%206.65%200%200%201%200-9.407%206.649%206.649%200%200%201%209.41%200c2.598%202.586%202.598%206.809%200%209.407ZM86.43%203.672l-8.235%208.234a4.17%204.17%200%200%200%200%205.875l32.149%2032.149a4.17%204.17%200%200%200%205.875%200l8.234-8.235c1.61-1.61%201.61-4.261%200-5.87L92.29%203.671a4.159%204.159%200%200%200-5.86%200ZM28.738%20108.895a3.763%203.763%200%200%200%200-5.31l-4.183-4.187a3.768%203.768%200%200%200-5.313%200l-8.644%208.649-.016.012-2.371-2.375c-1.313-1.313-3.45-1.313-4.75%200-1.313%201.312-1.313%203.449%200%204.75l14.246%2014.242a3.353%203.353%200%200%200%204.746%200c1.3-1.313%201.313-3.45%200-4.746l-2.375-2.375.016-.012Zm43.559-81.582L54.004%2045.605c-1.625%201.625-1.625%204.301%200%205.926L65.3%2062.824c7.984-5.746%2019.18-5.035%2026.363%202.153l9.148-9.149c1.622-1.625%201.622-4.297%200-5.922L78.22%2027.313a4.185%204.185%200%200%200-5.922%200ZM60.55%2067.585l-6.672-6.672c-1.563-1.562-4.125-1.562-5.684%200l-23.53%2023.54a4.036%204.036%200%200%200%200%205.687l13.331%2013.332a4.036%204.036%200%200%200%205.688%200l15.132-15.157c-3.199-6.609-2.625-14.593%201.735-20.73Z%22%2F%3E%3C%2Fsvg%3E" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/twilio/" class="group block" aria-label="Twilio"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #f22f46"> <img src="https://svgl.app/library/twilio.svg" class="object-contain h-[61%] w-[61%] brightness-0 invert" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/salesforce-marketing-cloud/" class="group block" aria-label="Salesforce"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/salesforce.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/deploy/sst/" class="group block" aria-label="SST"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/sst.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/channels/resend/" class="group block" aria-label="Resend"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #181717"> <img src="https://svgl.app/library/resend-icon-white.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/deploy/fly/" class="group block" aria-label="Fly.io"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-950/10 shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-600/60 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]" style="background: #ffffff"> <img src="https://svgl.app/library/fly.svg" class="object-contain h-[61%] w-[61%]" loading="lazy" /> </span></a>
- <a href="/docs/ecosystem/" class="group block" aria-label="Explore the full ecosystem"><span class="grid aspect-square place-items-center overflow-hidden rounded-[22%] border border-gray-300 bg-white shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_1px_2px_rgba(17,24,39,0.12),0_4px_10px_rgba(17,24,39,0.1)] transition duration-200 group-hover:scale-105 group-hover:border-blue-500 group-hover:bg-blue-50 group-hover:shadow-[inset_0_1px_0_rgba(255,255,255,0.24),0_2px_3px_rgba(17,24,39,0.14),0_8px_16px_rgba(17,24,39,0.12)]"> </span></a>


Show more


## Features

Build agents that can safely take action, maintain continuity, and connect to the systems where work already happens.


<a href="/docs/concepts/agents/" class="lg:col-span-3 bg-white flex flex-col transition-colors hover:bg-gray-50 [&amp;&gt;div]:transition-colors hover:[&amp;&gt;div]:border-gray-400"></a>


### Agents

Build agents that can keep context across conversations and events as they autonomously work toward a goal.


<a href="/docs/guide/workflows/" class="lg:col-span-3 bg-white flex flex-col transition-colors hover:bg-gray-50 [&amp;&gt;div]:transition-colors hover:[&amp;&gt;div]:border-gray-400"></a>


### Workflows

Run structured automations where your code guides agent reasoning from a clear input to a finished result.


<a href="/docs/guide/sandboxes/" class="lg:col-span-2 border border-gray-300 bg-white p-6 transition-colors hover:border-gray-400 hover:bg-gray-50"></a>

### Sandboxes

Give agents a secure environment where they can use tools, modify files, and autonomously complete real work.

<a href="/docs/guide/durable-execution/" class="lg:col-span-2 border border-gray-300 bg-white p-6 transition-colors hover:border-gray-400 hover:bg-gray-50"></a>

### Durable Execution

Learn how agents preserve progress through failures and restarts with durable recovery for accepted work.

<a href="/docs/guide/subagents/" class="lg:col-span-2 border border-gray-300 bg-white p-6 transition-colors hover:border-gray-400 hover:bg-gray-50"></a>

### Subagents

Define specialized roles for different tasks, then let your agent delegate work to the right expert.

<a href="/docs/guide/tools/" class="lg:col-span-2 border border-gray-300 bg-white p-6 transition-colors hover:border-gray-400 hover:bg-gray-50"></a>

### Tools

Give agents typed actions for calling APIs, querying data, and making controlled changes through your application.

<a href="/docs/guide/skills/" class="lg:col-span-2 border border-gray-300 bg-white p-6 transition-colors hover:border-gray-400 hover:bg-gray-50"></a>

### Skills

Package reusable expertise and workflows that agents can load whenever a task needs specialized guidance.

<a href="/docs/guide/tools/#connect-mcp-tools" class="lg:col-span-2 border border-gray-300 bg-white p-6 transition-colors hover:border-gray-400 hover:bg-gray-50"></a>

### MCP Servers

Connect agents to authenticated tools and services through the open Model Context Protocol ecosystem.

<a href="/docs/guide/observability/" class="lg:col-span-2 border border-gray-300 bg-white p-6 transition-colors hover:border-gray-400 hover:bg-gray-50"></a>

### Observability

Monitor your agents and export telemetry with OpenTelemetry, Braintrust, Sentry, or your own observer.

<a href="/docs/guide/chat/" class="lg:col-span-2 border border-gray-300 bg-white p-6 transition-colors hover:border-gray-400 hover:bg-gray-50"></a>

### Chat

Connect agents to where your work happens across Slack, Teams, Discord, GitHub, and more.

<a href="/docs/getting-started/quickstart/" class="group lg:col-span-2 border border-gray-300 bg-gray-950 p-6 text-white transition-colors hover:bg-gray-800"></a>

### Explore the docs

Learn how to build, run, and deploy production-ready agents with Flue.


