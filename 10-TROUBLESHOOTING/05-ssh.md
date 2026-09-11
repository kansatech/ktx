# SSH Problems

> **Purpose:** Separate edge auth, routing, network and upstream sshd failures.

Check: public TCP 22/banner -> SSHPiper username directory -> customer authorized key -> `sshpiper_upstream` -> site network membership -> strict `known_hosts` -> site sshd 2222 -> internal `site` account/key.

Production host admin access is separate, so a customer gateway failure should not lock you out of `ktx-prod-26`.
