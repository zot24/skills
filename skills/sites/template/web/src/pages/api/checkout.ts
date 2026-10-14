// Checkout Session for plans without a Payment Link (dynamic prices, quantities, metadata).
// Rules: sites skill, docs/stripe.md, and the official stripe-best-practices skill.
import type { APIRoute } from 'astro';
import { env } from 'cloudflare:workers';
import Stripe from 'stripe';
import { getPlans } from '../../lib/site';

export const prerender = false;

export const POST: APIRoute = async ({ request, site, redirect }) => {
  if (!env.STRIPE_SECRET_KEY) return new Response('Checkout is not configured', { status: 503 });

  const form = await request.formData();
  const plan = (await getPlans()).find((p) => p.id === form.get('plan'));
  if (!plan?.stripePriceId) return new Response('Unknown plan', { status: 400 });

  const stripe = new Stripe(env.STRIPE_SECRET_KEY, { httpClient: Stripe.createFetchHttpClient() });
  const session = await stripe.checkout.sessions.create({
    mode: plan.interval === 'once' ? 'payment' : 'subscription',
    line_items: [{ price: plan.stripePriceId, quantity: 1 }],
    success_url: `${site!.origin}/thanks?session_id={CHECKOUT_SESSION_ID}`,
    cancel_url: `${site!.origin}/#pricing`,
    metadata: { site: site!.hostname, plan: plan.id },
  });
  return redirect(session.url!, 303);
};
