import { defineCollection } from 'astro:content';
import { file } from 'astro/loaders';
import { z } from 'astro/zod';

// One source of truth for facts that appear in copy, JSON-LD and llms.txt.
// Every factual string has a row in the copy spec's claim register.
const site = defineCollection({
  loader: file('src/content/site.json'),
  schema: z.object({
    name: z.string(),
    tagline: z.string(),
    description: z.string().max(160),
    email: z.email(),
    sameAs: z.array(z.url()).default([]),
    conversion: z.object({ label: z.string(), href: z.string(), event: z.string() }),
  }),
});

const plans = defineCollection({
  loader: file('src/content/plans.json'),
  schema: z.object({
    name: z.string(),
    price: z.number(),
    currency: z.string().length(3),
    interval: z.enum(['once', 'month', 'year']),
    features: z.array(z.string()),
    // Fixed price: a Stripe Payment Link. Dynamic price: leave empty and use /api/checkout.
    paymentLink: z.url().optional(),
    stripePriceId: z.string().optional(),
  }),
});

export const collections = { site, plans };
