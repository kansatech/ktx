# Mail Problems

> **Purpose:** Trace site -> relay -> provider -> recipient.

1. Site resolves/connects `ktx-mail-01`.
2. Internal auth/sender policy succeeds.
3. Find Postfix message/queue ID.
4. Inspect relay log.
5. Verify upstream SASL/TLS acceptance.
6. Verify provider accepted recipient.
7. Then inspect spam/quarantine/bounce.

Common: provider password expired, sender not mapped, provider rejects From/envelope sender, TLS/SASL mismatch, compromised site throttled.
