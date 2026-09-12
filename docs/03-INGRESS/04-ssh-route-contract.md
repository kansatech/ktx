# SSH Route Contract

Public workload SSH uses one external username per route and native SSHPiper on TCP 22.

Example:

```text
ssh clienta@ssh.example.net
        |
        v
native SSHPiper
        |
        v
site@172.28.4.2:2222
```

## Initialize route

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

`id_rsa` is the mapping key SSHPiper uses to authenticate to the upstream SSH server. The current workingdir plugin specifically expects this filename.

The command prints the mapping public key. The future template pack must install that public key in the upstream account's `authorized_keys`.

## Authorize a customer key

```bash
sudo ktx-ssh-route authorize clienta /path/to/customer-key.pub
```

## Trust upstream host key

Prefer obtaining the host key directly from the template's persisted SSH host-key material. If you intentionally use `ssh-keyscan`, validate the fingerprint independently before trusting it.

```bash
sudo ktx-ssh-route trust clienta /path/to/known_hosts-line.txt
```

## Test

```bash
ssh clienta@PUBLIC_HOST
```

## Remove/revoke

```bash
sudo ktx-ssh-route revoke clienta /path/to/customer-key.pub
sudo ktx-ssh-route remove clienta
```

Changes to route files are read on new connections; normal route edits do not require restarting SSHPiper.
