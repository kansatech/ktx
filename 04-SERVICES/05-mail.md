# Mail Relay Operation

> **Purpose:** Trace and route outbound mail through approved providers.

Apps know only the internal KTX relay. The relay knows external providers.

Use sender-dependent relay/auth maps when domains use different providers.

Abuse controls should include per-site identity/credentials where practical, allowed sender restrictions, upstream provider limits, and monitoring of queue spikes.

Useful commands inside the relay:
```bash
postqueue -p
postcat -q QUEUEID
postsuper -d QUEUEID
```
Do not wipe a queue before understanding why it grew.

If a compromised site is sending mail, disable that site's relay permission first, inspect the queue, then follow incident response.
