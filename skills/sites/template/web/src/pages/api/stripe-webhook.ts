// Stripe webhook: verify the signature, then fulfil. Point the endpoint at /api/stripe-webhook
// and subscribe to checkout.session.completed (plus invoice.* for subscriptions).
import type { APIRoute } from 'astro';
import { env } from 'cloudflare:workers';
import Stripe from 'stripe';
import { sendEmail } from '../../lib/email';

export const prerender = false;

export const POST: APIRoute = async ({ request }) => {
  if (!env.STRIPE_SECRET_KEY || !env.STRIPE_WEBHOOK_SECRET) return new Response(null, { status: 503 });

  const stripe = new Stripe(env.STRIPE_SECRET_KEY, { httpClient: Stripe.createFetchHttpClient() });
  const signature = request.headers.get('stripe-signature') ?? '';
  let event: Stripe.Event;
  try {
    event = await stripe.webhooks.constructEventAsync(
      await request.text(),
      signature,
      env.STRIPE_WEBHOOK_SECRET,
      undefined,
      Stripe.createSubtleCryptoProvider(),
    );
  } catch {
    return new Response('Bad signature', { status: 400 });
  }

  switch (event.type) {
    case 'checkout.session.completed': {
      const session = event.data.object;
      // Fulfil here: provisioning, a row in D1. Must be idempotent: Stripe retries.
      console.log('paid', session.id, session.metadata?.plan, session.amount_total, session.currency);
      const to = session.customer_details?.email;
      if (to) {
        await sendEmail({
          to,
          subject: 'Thanks, you are in',
          html: '<p>Thanks for your purchase. Reply to this email if you need anything.</p>',
          idempotencyKey: `checkout/${event.id}`,
        });
      }
      break;
    }
  }
  return new Response(null, { status: 200 });
};
