# Host SSH Administration

> **Purpose:** Keep infrastructure access independent from customer SSH.

Recommended production pattern:
- SSHPiper owns public 22.
- Host sshd listens on 2222.
- Firewall allows 2222 only from trusted administrator addresses/private management.
- Key authentication only; root login disabled.

Example drop-in `/etc/ssh/sshd_config.d/10-ktx.conf`:
```text
Port 2222
PermitRootLogin no
PasswordAuthentication no
KbdInteractiveAuthentication no
PubkeyAuthentication yes
X11Forwarding no
```

Validate before reload:
```bash
sudo sshd -t
sudo systemctl reload ssh
```
Test a second connection before closing the first.

SSHPiper *can* route your admin username back to host sshd, but that makes the gateway a dependency for host recovery. Keep separate admin access unless you consciously accept that coupling.
