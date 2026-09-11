# Web Container Hardening

> **Purpose:** Reduce what a compromised site can do.

Baseline:
- no privileged mode
- no Docker socket/devices/host root mount
- bounded memory/PIDs
- internal high ports where practical
- site-only mounts
- read-only secret mounts
- no sudo/root login for customer
- update via image replacement

After compatibility testing consider `no-new-privileges`, dropping unused capabilities, and a read-only container root with tmpfs for runtime paths.

WordPress self-updates require writable code/plugin paths. Decide your policy deliberately rather than marking everything read-only and discovering it during plugin day.
