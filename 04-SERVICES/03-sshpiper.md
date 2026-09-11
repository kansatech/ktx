# SSHPiper Operation

> **Purpose:** Add/remove customer SSH without assigning a host port per site.

Persistent root: `/srv/ktx/data/ssh-01/workingdir` mounted as `/var/sshpiper`.

For external login `clienta`, create `/var/sshpiper/clienta/` with routing/auth files. `sshpiper_upstream` points to `site@ktx-web-clienta-01:2222`.

External username chooses the route; upstream username can remain the standard `site` account.

Use public-key auth and strict upstream host-key validation. Persist upstream site sshd host keys and gateway known_hosts.

Disable a customer's SSH by revoking/removing the downstream authorized key or route; no Docker port change is required.
