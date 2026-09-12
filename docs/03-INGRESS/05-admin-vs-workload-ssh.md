# Host and Workload SSH Through One SSHPiper

KTX deliberately uses one public SSH listener:

```text
public :22 -> SSHPiper
```

Routing is by username.

## Host administrator

```bash
ssh ktx@host
```

Route:

```text
ktx -> ktx@127.0.0.1:2222
```

The host's native OpenSSH is key-only and bound to loopback. It is not reachable directly from the network.

## Workload customer

```bash
ssh clienta@host
```

Example route:

```text
clienta -> site@172.28.4.2:2222
```

## Why the `ktx` name matters

It is intentionally uncommon and reserved for Host Core administration. A module must never register a workload SSHPiper route named `ktx`.

## Recovery implication

Because SSHPiper sits in front of host SSH, an SSHPiper failure can block normal network administration. Keep VPS/provider console/recovery access working. Troubleshooting instructions are in `docs/08-TROUBLESHOOTING/01-host-admin-ssh.md`.

## Add another administrator key

After the SSHPiper cutover, public clients authenticate to the `ktx` **SSHPiper route**, not directly to OpenSSH. Put a new public key in a temporary file on the server and authorize it with:

```bash
sudo ktx-ssh-route authorize ktx /path/to/new-key.pub
```

Do not replace the route's `id_rsa`; that is SSHPiper's upstream mapping key, not your workstation key.
