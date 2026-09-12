# Host Administrator SSH Troubleshooting

Expected path:

```text
client -> TCP 22 -> SSHPiper -> route "ktx" -> ktx@127.0.0.1:2222 -> OpenSSH
```

If network SSH is broken, use the VPS/provider console first. Do not weaken SSH authentication as a first response.

## Check listeners

```bash
sudo ss -lntp | grep -E ':(22|2222) '
```

Expected:

- SSHPiper on public `:22`;
- OpenSSH on `127.0.0.1:2222` only.

## Check services

```bash
sudo systemctl status ssh sshpiper --no-pager
sudo journalctl -u sshpiper -n 100 --no-pager
sudo journalctl -u ssh -n 100 --no-pager
```

## Check the reserved route

```bash
sudo ktx-ssh-route show ktx
```

Upstream must be:

```text
ktx@127.0.0.1:2222
```

Confirm the route has downstream `authorized_keys`, an `id_rsa` mapping key, and `known_hosts`.

## Test the loopback OpenSSH service from provider console

```bash
nc -vz 127.0.0.1 2222
sudo sshd -t
sudo sshd -T -C user=ktx,host=localhost,addr=127.0.0.1 | grep -E '^(port|listenaddress|passwordauthentication|pubkeyauthentication|permitrootlogin)'
```

Expected policy is port 2222, loopback-only, public-key authentication enabled, password authentication disabled, and root login disabled.

## If SSHPiper is broken

Fix/reinstall the pinned native SSHPiper release using:

```bash
sudo /srv/ktx/bin/ktx-install-native sshpiper
sudo systemctl restart sshpiper
```

Provider console is the break-glass route; there is intentionally no second public SSH port.
