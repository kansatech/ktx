# Host Administrator SSH Troubleshooting

Expected final path:

```text
client -> TCP 22 -> SSHPiper -> route "ktx" -> ktx@127.0.0.1:2222 -> OpenSSH
```

If network SSH is broken, use the VPS/provider/VM console first. Do not weaken authentication as the first response.

## Check listeners

```bash
sudo ss -lntp | grep -E ':(22|2222)\b'
```

Expected final state:

- `sshpiperd` owns public TCP 22;
- `sshd` owns `127.0.0.1:2222` only;
- there is no `0.0.0.0:2222` or `[::]:2222` listener.

If port 22 reports Ubuntu `sshd`/`systemd` instead of `sshpiperd`, the SSHPiper cutover has not completed.

## Ubuntu 24.04 `ssh.socket`

Ubuntu 24.04 commonly uses systemd socket activation for OpenSSH. KTX's final state deliberately disables that socket and lets `ssh.service` bind directly to loopback.

Check:

```bash
sudo systemctl status ssh.socket ssh.service --no-pager
```

Final KTX state:

```text
ssh.socket    inactive/disabled
ssh.service   active
```

If a failed/older cutover leaves `ssh.socket` listening publicly on 22, use provider console and follow the current `ktx-init secure-ssh` procedure rather than manually exposing another management port.

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

The route needs:

- downstream `authorized_keys` containing your workstation key(s);
- an `id_rsa` mapping private key;
- the corresponding mapping public key in `/home/ktx/.ssh/authorized_keys`;
- `known_hosts` containing the loopback OpenSSH host identity.

These are two separate authentication hops.

## Test loopback OpenSSH from console

```bash
nc -vz 127.0.0.1 2222
sudo sshd -t
sudo sshd -T -C user=ktx,host=localhost,addr=127.0.0.1 | \
  grep -E '^(port|listenaddress|passwordauthentication|pubkeyauthentication|permitrootlogin)'
```

Expected: port 2222, loopback-only, public-key authentication enabled, password authentication disabled, root login disabled.

## Check your workstation key fingerprint

On the client:

```bash
ssh-keygen -lf ~/.ssh/id_ed25519_ktx.pub
```

On Windows CMD, if necessary:

```cmd
ssh-keygen -lf %USERPROFILE%\.ssh\id_ed25519_ktx.pub
```

Compare that key with the `ktx` route's downstream `authorized_keys`. For workload routes, remember that your workstation key does **not** also have to be the upstream key; SSHPiper normally uses the route mapping key for the upstream hop.

## If SSHPiper is missing or broken

From provider console:

```bash
sudo /srv/ktx/bin/ktx-install-native sshpiper
sudo /srv/ktx/bin/ktx-apply-host
sudo systemctl restart sshpiper
```

Inspect logs before repeatedly restarting it.

Provider console is the break-glass route; there is intentionally no second public SSH port.
