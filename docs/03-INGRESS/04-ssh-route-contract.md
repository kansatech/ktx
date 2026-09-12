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

This is the important part.

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
sudo ktx-ssh-route init clienta site 172.28.4.2 2222
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

`root` routes are prohibited. The external login `ktx` is reserved for the Host Core route to `ktx@127.0.0.1:2222`.

## Authorize a workstation/customer key

From a public-key file:

```bash
sudo ktx-ssh-route authorize clienta /path/to/customer-key.pub
```

Or pipe a key through stdin:

```bash
cat /path/to/customer-key.pub | sudo ktx-ssh-route authorize clienta -
```

## Trust the upstream host key

`known_hosts` tells SSHPiper which SSH host identity is valid for the upstream hop. The previously documented `known_hosts-line.txt` is not a special KTX file; it is simply one or more lines in normal OpenSSH `known_hosts` format.

Prefer deriving this from the workload's persisted SSH host-key material. If you intentionally use `ssh-keyscan`, validate the fingerprint independently before trusting it.

Temporary-file form:

```bash
ssh-keyscan -p 2222 172.28.4.2 > known_hosts-line.txt
sudo ktx-ssh-route trust clienta known_hosts-line.txt
rm known_hosts-line.txt
```

Or directly through stdin:

```bash
ssh-keyscan -p 2222 172.28.4.2 | sudo ktx-ssh-route trust clienta -
```

## Inspect

```bash
sudo ktx-ssh-route show clienta
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
sudo ktx-ssh-route revoke clienta /path/to/customer-key.pub
sudo ktx-ssh-route remove clienta
```

The reserved `ktx` Host Core route cannot be removed with the normal helper.

## Do I restart SSHPiper after editing a route?

No. The working-directory route files are evaluated for new connections. Adding/removing an authorized key, changing the upstream target, or changing `known_hosts` does not require an SSHPiper restart.

Restart SSHPiper only when changing/upgrading the SSHPiper daemon, plugin, listener, systemd unit, or other daemon-level configuration. A daemon restart can interrupt active proxied SSH sessions.
