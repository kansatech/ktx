# Host and Workload SSH Through One SSHPiper

KTX uses one public SSH listener:

```text
public :22 -> native SSHPiper
```

Routing is by username.

## Host administrator

The `ktx` account is created manually before Host Core is installed. KTX validates and secures it; KTX does not create it.

```bash
ssh ktx@host
```

Route:

```text
ktx -> ktx@127.0.0.1:2222
```

The host's native OpenSSH becomes key-only during `secure-ssh` and is then bound only to `127.0.0.1`. Ubuntu `ssh.socket` activation is disabled in the final KTX state so the `ssh.service` daemon itself owns only the loopback listener.

## Workload customer

```bash
ssh clienta@host
```

Example route:

```text
clienta -> site@172.28.4.2:2222
```

A workload route has two key relationships: the caller's public key authenticates to SSHPiper, and the route's generated mapping key authenticates SSHPiper to the upstream account. See [SSH Route Contract](04-ssh-route-contract.md).

## Why the `ktx` name matters

It is intentionally uncommon and reserved for Host Core administration. A module must never register a workload SSHPiper route named `ktx`. `root` SSH routes are prohibited.

## Recovery implication

Because SSHPiper sits in front of host SSH, an SSHPiper failure can block normal network administration. Keep VPS/provider/VM console access working. Troubleshooting instructions are in `docs/08-TROUBLESHOOTING/01-host-admin-ssh.md`.

## Add another administrator workstation key

After the SSHPiper cutover, public clients authenticate to the **`ktx` SSHPiper route**, not directly to loopback OpenSSH. Put the new public key in a temporary file on the server and authorize it with:

```bash
sudo ktx-ssh-route authorize ktx /path/to/new-key.pub
```

Or:

```bash
cat /path/to/new-key.pub | sudo ktx-ssh-route authorize ktx -
```

Do not replace the route's `id_rsa`; that is SSHPiper's upstream mapping key, not a workstation key.

No SSHPiper restart is required when changing route `authorized_keys`.
