# Monthly Checks

> **Purpose:** Prove recoverability and security, not just uptime.

- perform one targeted restore test
- run an appropriate restic repository check
- review host security/package state
- review KTX image updates available
- review administrator/customer SSH keys
- review retired users/databases/sites
- review backup retention
- review RAM/swap/disk headroom
- review firewall/provider rules
- verify playbook still matches reality

Quarterly or after major changes, rehearse broader disaster recovery on dev/disposable infrastructure.
