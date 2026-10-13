// Send from the site's own address through Resend's REST API (no SDK needed on the Worker).
// RESEND_API_KEY is a sending-only key for this domain (docs/email.md in the sites skill).
import { env } from 'cloudflare:workers';
import { getSite } from './site';

interface Mail {
  to: string | string[];
  subject: string;
  html: string;
  text?: string;
  replyTo?: string;
  /** Same key, same email: Resend drops repeats for 24 hours. Derive it from the event that sent it. */
  idempotencyKey?: string;
}

export async function sendEmail(mail: Mail): Promise<{ id: string } | null> {
  if (!env.RESEND_API_KEY) return null;
  const site = await getSite();
  const res = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${env.RESEND_API_KEY}`,
      'Content-Type': 'application/json',
      ...(mail.idempotencyKey ? { 'Idempotency-Key': mail.idempotencyKey } : {}),
    },
    body: JSON.stringify({
      from: `${site.name} <${site.email}>`,
      to: mail.to,
      subject: mail.subject,
      html: mail.html,
      text: mail.text,
      reply_to: mail.replyTo ?? site.email,
    }),
  });
  if (!res.ok) throw new Error(`Resend ${res.status}: ${await res.text()}`);
  return res.json();
}
