# Install a New KTX Host

This is the single authoritative fresh-host procedure for KTX Host Core. The documents under `docs/` explain architecture, lifecycle, operations, recovery, and module contracts; they intentionally do not repeat the package-install sequence.

KTX currently targets a fresh **Ubuntu 24.04 LTS** host.

## Before you start

Have provider/VM console access available and keep the original console/session open until the final SSHPiper-backed SSH login is proven.

Choose the hostname/environment, for example:

```text
ktx-build-26   build
ktx-dev-26     dev
ktx-prod-26    prod
```

## 1. Manually create the KTX administrator

KTX deliberately does **not** create administrator identities. From the initial provider/root console:

```bash
apt update
apt install -y git ca-certificates sudo
adduser ktx
usermod -aG sudo ktx
```

`adduser` prompts you for the local `ktx` password. Keep that password: after SSH becomes key-only it is still the normal password used by `sudo`.

Root will not be a KTX SSH login.

Create `/srv/ktx` for the `ktx` administrator and clone Host Core as that user:

```bash
install -d -o ktx -g ktx -m 0755 /srv/ktx
sudo -u ktx git clone https://github.com/Kansatech/ktx.git /srv/ktx
cd /srv/ktx
sudo -u ktx ./bin/ktx-validate-repo
```

For dev/prod, check out the exact Host Core tag you intend to deploy before continuing.

## 2. Bootstrap the host

Example:

```bash
sudo ./bin/ktx-init bootstrap --hostname ktx-build-26 --env build
```

`bootstrap` validates the already-existing `ktx` account and sudo membership, then in one pass:

- installs the normal Host Core prerequisites (including Midnight Commander, because civilized servers have `mc`);
- creates the local `/srv/ktx` runtime layout;
- sets the hostname and UTC;
- disables root SSH;
- temporarily permits password SSH **only** for `ktx` on public TCP 22;
- enables time synchronization and host logging.

It does not create `ktx`, change its password, or create another administrator.

## 3. Prove password SSH, install your key, then prove key SSH

From a **second terminal on your workstation**:

```bash
ssh ktx@SERVER
```

Use the `ktx` password created in step 1. Leave your provider/root console and any working SSH session open.

If you need a workstation key:

```bash
ssh-keygen -t ed25519 -a 64
```

### Linux/macOS with ssh-copy-id

```bash
ssh-copy-id ktx@SERVER
```

### Windows/OpenSSH without ssh-copy-id

For the normal key:

```powershell
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub | ssh ktx@SERVER "umask 077; mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys"
```

For a specifically named key such as `id_ed25519_ktx`:

```powershell
Get-Content $env:USERPROFILE\.ssh\id_ed25519_ktx.pub | ssh ktx@SERVER "umask 077; mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys"
```

Now explicitly prove the key in another new connection. If it is a named key:

```powershell
ssh ktx@SERVER -i $env:USERPROFILE\.ssh\id_ed25519_ktx
```

**Do not continue until a new SSH session works with the public key.**

## 4. Put all public SSH through SSHPiper

From the still-open `ktx` session or provider console:

```bash
sudo /srv/ktx/bin/ktx-init secure-ssh
```

The final SSH path becomes:

```text
Internet :22
    -> native SSHPiper
        -> username ktx
            -> ktx@127.0.0.1:2222
                -> native OpenSSH
```

The command:

- installs the pinned SSHPiper release and systemd unit;
- creates the reserved `ktx` SSHPiper route;
- uses your proven workstation public key(s) for the **client -> SSHPiper** authentication hop;
- generates a separate SSHPiper mapping key for the **SSHPiper -> OpenSSH** hop and authorizes it for `ktx`;
- preserves the existing OpenSSH Ed25519 host identity on public TCP 22;
- disables Ubuntu's `ssh.socket` activation for the final KTX state;
- binds native OpenSSH directly to **127.0.0.1:2222 only**;
- disables SSH password authentication;
- starts SSHPiper as the only public TCP 22 listener.

There is no public port 2222.

**Keep the old session/console open.** From another terminal prove the final path:

```bash
ssh ktx@SERVER
```

or, for your named key:

```powershell
ssh ktx@SERVER -i $env:USERPROFILE\.ssh\id_ed25519_ktx
```

On the server, the final listeners should look conceptually like:

```text
:22                sshpiperd
127.0.0.1:2222     sshd
```

Verify if desired:

```bash
sudo ss -lntp | grep -E ':(22|2222)\b'
sudo systemctl status ssh sshpiper --no-pager
```

## 5. Finish Host Core

Only after the final `ssh ktx@SERVER` path works:

```bash
sudo /srv/ktx/bin/ktx-init finish --acme-email you@example.com
```

`finish` installs/configures:

- Docker Engine + Compose plugin from Docker's official Ubuntu repository;
- pinned native Traefik;
- native rsyslog receiver/log rotation;
- KTX command symlinks;
- UFW baseline;
- Traefik ACME state/configuration.

The public Host Core baseline is:

```text
22/tcp   SSHPiper
80/tcp   Traefik HTTP/ACME -> HTTPS
443/tcp  Traefik HTTPS
```

Native OpenSSH `2222/tcp` exists only on `127.0.0.1` and is not a public firewall rule.

## 6. Verify

```bash
sudo ktx-host-check
sudo ufw status verbose
sudo docker version
sudo docker compose version
sudo systemctl --no-pager --full status ssh sshpiper docker traefik rsyslog
```

From your workstation:

```bash
ssh ktx@SERVER
```

The host is now ready for independent KTX module repositories under `/srv/ktx/images/`.

## Re-running setup

The phases are intentionally explicit. Do not rerun `bootstrap` on an established host just to update it. Host Core updates follow `docs/04-LIFECYCLE/`.
