> Source: https://docs.firecrawl.dev/webhooks/security.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Security

> Verify webhook authenticity

Verify that every webhook request actually came from Firecrawl by checking its HMAC-SHA256 signature. This stops attackers from spoofing payloads and lets you trust the data before acting on it.

## Secret Key

Your webhook secret is available in the [Advanced tab](https://www.firecrawl.dev/app/settings?tab=advanced) of your account settings. Each account has a unique secret used to sign all webhook requests.


  Keep your webhook secret secure and never expose it publicly. If you believe your secret has been compromised, regenerate it immediately from your account settings.


## Signature Verification

Each webhook request includes an `X-Firecrawl-Signature` header:

```
X-Firecrawl-Signature: sha256=abc123def456...
```

### How to Verify

1. Extract the signature from the `X-Firecrawl-Signature` header
2. Get the raw request body (before parsing)
3. Compute HMAC-SHA256 using your secret key
4. Compare signatures using a timing-safe function

### Implementation

<CodeGroup>
  ```js Node/Express
  import crypto from 'crypto';
  import express from 'express';

  const app = express();

  // Use raw body parser for signature verification
  app.use('/webhook/firecrawl', express.raw({ type: 'application/json' }));

  app.post('/webhook/firecrawl', (req, res) => {
    const signature = req.get('X-Firecrawl-Signature');
    const webhookSecret = process.env.FIRECRAWL_WEBHOOK_SECRET;

    if (!signature || !webhookSecret) {
      return res.status(401).send('Unauthorized');
    }

    // Extract hash from signature header
    const [algorithm, hash] = signature.split('=');
    if (algorithm !== 'sha256') {
      return res.status(401).send('Invalid signature algorithm');
    }

    // Compute expected signature
    const expectedSignature = crypto
      .createHmac('sha256', webhookSecret)
      .update(req.body)
      .digest('hex');

    // Verify signature using timing-safe comparison
    if (!crypto.timingSafeEqual(Buffer.from(hash, 'hex'), Buffer.from(expectedSignature, 'hex'))) {
      return res.status(401).send('Invalid signature');
    }

    // Parse and process verified webhook
    const event = JSON.parse(req.body);
    console.log('Verified Firecrawl webhook:', event);

    res.status(200).send('ok');
  });

  app.listen(3000, () => console.log('Listening on 3000'));
  ```

  ```python Python/Flask
  import hmac
  import hashlib
  from flask import Flask, request, abort

  app = Flask(__name__)

  WEBHOOK_SECRET = 'your-webhook-secret-here'  # Get from Firecrawl dashboard

  @app.post('/webhook/firecrawl')
  def webhook():
      signature = request.headers.get('X-Firecrawl-Signature')

      if not signature:
          abort(401, 'Missing signature header')

      # Extract hash from signature header
      try:
          algorithm, hash_value = signature.split('=', 1)
          if algorithm != 'sha256':
              abort(401, 'Invalid signature algorithm')
      except ValueError:
          abort(401, 'Invalid signature format')

      # Compute expected signature
      expected_signature = hmac.new(
          WEBHOOK_SECRET.encode('utf-8'),
          request.data,
          hashlib.sha256
      ).hexdigest()

      # Verify signature using timing-safe comparison
      if not hmac.compare_digest(hash_value, expected_signature):
          abort(401, 'Invalid signature')

      # Parse and process verified webhook
      event = request.get_json(force=True)
      print('Verified Firecrawl webhook:', event)

      return 'ok', 200

  if __name__ == '__main__':
      app.run(port=3000)
  ```
</CodeGroup>

## Best Practices

* **Verify every request.** Always check the signature before processing a webhook payload. Reject any request that fails verification with a `401` status.
* **Use timing-safe comparisons.** Standard string comparison can leak timing information. Use `crypto.timingSafeEqual()` in Node.js or `hmac.compare_digest()` in Python.
* **Serve your endpoint over HTTPS.** This ensures webhook payloads are encrypted in transit.
