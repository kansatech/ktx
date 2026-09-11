# SSH Hardening

> **Purpose:** Treat host, gateway, and site SSH as different trust levels.

Host: highest privilege, separate restricted path/port, key only, root disabled.

Gateway: internet-facing router, current SSHPiper, public-key downstream auth, strict upstream host keys, no Docker socket or site file mounts beyond routing state.

Site: `site` user, no sudo/root, key only, private internal port, only own files.
