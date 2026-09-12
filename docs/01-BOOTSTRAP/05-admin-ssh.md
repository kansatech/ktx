# Administrator OpenSSH

The host's own sshd is deliberately separate from public customer/workload SSH ingress.

## Production baseline

Host sshd listens on TCP 2222.

Create `/etc/ssh/sshd_config.d/10-ktx-admin.conf`:

```text
Port 2222
PermitRootLogin no
PasswordAuthentication no
KbdInteractiveAuthentication no
PubkeyAuthentication yes
X11Forwarding no
AllowAgentForwarding no
```

Add your administrator public key to the normal host user before disabling password authentication.

Validate:

```bash
sudo sshd -t
sudo systemctl reload ssh
```

**Open a second terminal and verify key login on port 2222 before closing the original session.**

Example:

```bash
ssh -p 2222 ktxadmin@ktx-prod-26
```

## Firewall

Prod should restrict TCP 2222 to trusted source CIDRs at the VPS/provider firewall and UFW when practical. If your source address is dynamic, key-only SSH remains mandatory and you should consider a private management VPN later.

## Why host sshd is not routed through SSHPiper

KTX deliberately keeps recovery administration independent. A failed or compromised SSHPiper service should not be able to remove the host admin path.
