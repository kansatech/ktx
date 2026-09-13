# Install KTX Host Core

This is the only fresh-host setup procedure. Use a fresh **Ubuntu 24.04 LTS** host
(x86_64 or arm64) and a checkout directly at `/srv/ktx`. This release candidate
still needs the Linux acceptance checks in [RC-REVIEW.md](RC-REVIEW.md).

Before starting, the **`ktx` account already exists**, belongs to `sudo`, has home
`/home/ktx`, and has a local password for sudo. KTX does not create or reset it.
Have a working provider/VM console and keep it open throughout installation.
Allow public TCP 22 at the provider firewall; add 80/443 before finishing.

Examples use reserved names/addresses. Replace `SERVER` with the host's address;
replace `host.example.invalid` and `admin@example.com` with your intended values.

## 1. Clone and bootstrap — on the server console

Only Git and its HTTPS trust store are needed before cloning. All remaining host
packages are installed once by bootstrap. Run these commands from an existing
sudo-capable console account:

```bash
sudo apt-get update
sudo apt-get install -y git ca-certificates
sudo install -d -o ktx -g ktx -m 0755 /srv/ktx
sudo -u ktx git clone https://github.com/Kansatech/ktx.git /srv/ktx
cd /srv/ktx
```

For a release deployment, select the reviewed release tag as `ktx` before running
its scripts. Do not deploy an arbitrary moving branch on production.

```bash
sudo ./bin/init bootstrap --hostname host.example.invalid --env build
sudo -u ktx ./bin/validate-repo
```

Use `build`, `dev`, or `prod` for the environment. Bootstrap installs Ubuntu
prerequisites, creates ignored runtime directories, sets hostname/UTC, enables
Chrony/rsyslog, and temporarily permits password or public-key SSH **only for
`ktx`**. It backs up the original SSH configuration, installs a complete KTX
policy, disables socket activation, and runs OpenSSH directly on TCP 22.

The scripts print each phase and leave package/service errors visible. For
source inspection, read [bin/init](bin/init); it does not download and execute
an installer script.

## 2. Install and prove your key — from your workstation

If needed, create an Ed25519 key on your workstation; keep the private key there:

```bash
ssh-keygen -t ed25519 -a 64
```

On Linux/macOS, install the public key using the temporary `ktx` password:

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub ktx@SERVER
```

On Windows PowerShell:

```powershell
Get-Content "$HOME/.ssh/id_ed25519.pub" | ssh ktx@SERVER "umask 077; mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys"
```

Now prove a **new public-key-only connection**, with password fallback disabled.
This command works in Bash and PowerShell; adjust the identity path if needed:

```bash
ssh -i "$HOME/.ssh/id_ed25519" -o IdentitiesOnly=yes -o PreferredAuthentications=publickey -o PasswordAuthentication=no -o KbdInteractiveAuthentication=no -o HostKeyAlgorithms=ssh-ed25519 ktx@SERVER
```

A private-key passphrase prompt is normal. An account-password prompt is not
proof of key authentication. Do not proceed until this connection works.
If the host identity differs from a previously cached key, compare the console's
`sudo ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub` with the client warning
before changing the workstation's known_hosts entry.

## 3. Cut over SSH — on the server, keeping console access

```bash
sudo /srv/ktx/bin/init secure-ssh
```

The command installs the pinned SSHPiper binary/plugin, creates the reserved
`ktx` route, copies the proven caller keys, and authorizes a separate mapping key
for the loopback hop. It tests that mapping key against temporary loopback
OpenSSH **before** changing public SSH. SSHPiper retains the Ed25519 host identity.

When prompted, repeat the key-only workstation command from step 2 in another
terminal. After that new login succeeds, type **`VERIFIED` in the terminal running
cutover** within 180 seconds. A failed check, interruption, or timeout attempts
to restore the previous OpenSSH policy on public 22. Keep the console available:
a power failure or forced process kill cannot be recovered by a shell trap.

The confirmed state is:

```text
public TCP 22 -> SSHPiper -> login ktx -> native OpenSSH at 127.0.0.1:2222
```

Only SSHPiper listens publicly on 22. Native OpenSSH is key-only, root SSH is
disabled, and `ssh.socket` is masked/inactive. TCP 2222 is never opened publicly.

## 4. Finish and verify — on the server

Before allocating networks, check that the default `172.28.0.0/16` pool does not
overlap your LAN, VPN, provider routes, or Docker networks. If it does, edit
`KTX_DOCKER_POOL` in `/srv/ktx/config/host.conf` now (private IPv4, /16 through /28).
Do not change the pool after allocation.

```bash
sudo /srv/ktx/bin/init finish --acme-email admin@example.com
sudo /srv/ktx/bin/host-check
sudo ufw status verbose
sudo docker version
sudo docker compose version
sudo systemctl --no-pager --full status ssh sshpiper docker traefik rsyslog
```

Finish applies UFW before starting the syslog receiver/web ingress, installs
Docker CE/Compose and pinned Traefik, and configures service permissions, ACME,
and log rotation. It preserves an existing Traefik static file on retry and
refuses to silently overwrite a different Docker configuration or remove
conflicting container packages. It does not add `ktx` to the Docker group.

Review all existing UFW/provider rules: the public baseline is **22, 80, 443/TCP**.
Syslog TCP 514 is allowed only from the chosen pool arriving on KTX bridges;
there is no public rule for 2222 or 514. Docker-published ports can bypass UFW,
so ordinary modules must not publish host ports. Verify IPv4 and, when enabled,
IPv6 from outside the host.

Prove a new workstation SSH login again, then rehearse a reboot using the
[reboot checklist](docs/11-CHECKLISTS/prod-reboot.md). The host can then accept
independent module repositories under `/srv/ktx/images/`.

## Retries, updates, and recovery

Completed phases refuse to run again. A failed `secure-ssh` or `finish` can be
retried after correcting its reported error. Inspect incomplete bootstrap from
the console before retrying. Do not delete completion files just to rerun setup.

Use [lifecycle instructions](docs/04-LIFECYCLE/01-core-release-lifecycle.md) for
updates, [SSH troubleshooting](docs/08-TROUBLESHOOTING/01-host-admin-ssh.md) for
access problems, and [recovery](docs/07-RECOVERY/03-full-host-rebuild.md) for rebuilds.
