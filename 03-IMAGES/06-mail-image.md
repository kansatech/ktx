# Mail Relay Image

> **Purpose:** Centralize outbound SMTP provider configuration.

`ktx-mail-01` runs Postfix and is **not** a public inbound mail server.

Applications use one internal endpoint, such as `ktx-mail-01:25` or an authenticated internal submission port.

Postfix supports a global `relayhost` plus sender-dependent relay host and SASL maps, so different sender domains can use different upstream providers while applications remain unaware of provider credentials.

Security baseline:
- no public SMTP mapping
- only join site networks that need mail
- prefer per-site internal credentials/accountability if practical
- restrict allowed sender identities
- provider/rate limits to contain compromised sites
- no password logging

Dev mail should be restricted to safe recipients/test relays.
