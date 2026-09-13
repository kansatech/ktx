# SSH Route Contract

Public workload SSH uses one external username per route and native SSHPiper on TCP 22.

Example:

```text
workstation
    -> ssh clienta@host
        -> SSHPiper :22
            -> site@172.28.4.2:2222
```

## There are two separate SSH key relationships

### 1. Workstation -> SSHPiper

The customer's/workstation's public key is stored in the route's:

```text
authorized_keys
```

That proves the caller is allowed to use external login `clienta`.

### 2. SSHPiper -> upstream SSH server

SSHPiper uses the route's separate mapping private key:

```text
id_rsa
```

The corresponding `id_rsa.pub` must be installed in the **upstream account's** `authorized_keys`.

Your workstation private key is not copied into the workload and should not be shared with SSHPiper.

## Initialize a route

```bash
sudo /srv/ktx/bin/ssh-route init clienta site 172.28.4.2 2222
```

The helper creates:

```text
/srv/ktx/config/sshpiper/routes/clienta/
├── sshpiper_upstream
├── id_rsa
├── id_rsa.pub
├── authorized_keys
└── known_hosts
```

The command prints the mapping public key. Install that printed public key in the upstream `site` account's `authorized_keys`. A module's instance-creation procedure should automate this when possible.

Login and upstream-user names must match `[a-z_][-a-z0-9_]{0,31}`. Dots, uppercase names, path components, and `root` are rejected. Workload routes may not target loopback or the host `ktx` account. The external login `ktx` is reserved for the Host Core route to `ktx@127.0.0.1:2222`.

## Authorize a workstation/customer key

Supply one or more plain public-key lines. Authorized-key options and SSH certificates are rejected: this helper does not implement their restrictions at the proxy. Keys are identified by their key bytes; changing a comment does not bypass revocation.

From a public-key file:

```bash
sudo /srv/ktx/bin/ssh-route authorize clienta /path/to/customer-key.pub
```

Or pipe a key through stdin:

```bash
cat /path/to/customer-key.pub | sudo /srv/ktx/bin/ssh-route authorize clienta -
```

## Trust the upstream host key

`known_hosts` pins the upstream SSH server's host identity. Use the persisted
workload host public key when available. When using `ssh-keyscan`, stage the
result and compare its fingerprint through an independent trusted channel
(such as the workload console) **before** installing it:

```bash
scan=$(mktemp)
ssh-keyscan -p 2222 172.28.4.2 > "$scan"
ssh-keygen -lf "$scan"
# Stop here and compare with the upstream console's host-key fingerprint.
```

Only after the fingerprints match:

```bash
sudo /srv/ktx/bin/ssh-route trust clienta "$scan"
rm -- "$scan"
```

The input uses ordinary known_hosts lines with the literal target address:
`[172.28.4.2]:2222`, or an unbracketed IPv4 address for port 22. Hashed names,
wildcards, and certificate-authority markers are outside this helper's contract.
`trust` replaces that route's pinned host-key set. Stdin (`-`) is also accepted
for input already verified independently; scanning alone does not establish trust.

## Inspect

```bash
sudo /srv/ktx/bin/ssh-route show clienta
```

This shows the upstream target, authorized-key count, known-host count, and mapping public key.

## Test

```bash
ssh clienta@PUBLIC_HOST
```

For troubleshooting from a workstation:

```bash
ssh -vvv clienta@PUBLIC_HOST
```

## Remove or revoke

```bash
sudo /srv/ktx/bin/ssh-route revoke clienta /path/to/customer-key.pub
sudo /srv/ktx/bin/ssh-route remove clienta
```

The reserved `ktx` Host Core route cannot be removed, and the helper refuses to revoke its last caller key. Existing connections are unaffected by revocation/removal; terminate them separately if incident response requires it.

## Do I restart SSHPiper after editing a route?

No. The working-directory route files are evaluated for new connections. Adding/removing an authorized key, changing the upstream target, or changing `known_hosts` does not require an SSHPiper restart.

Restart SSHPiper only when changing/upgrading the SSHPiper daemon, plugin, listener, systemd unit, or other daemon-level configuration. A daemon restart can interrupt active proxied SSH sessions.
