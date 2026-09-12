# Install a New KTX Host

This is the only installation procedure for KTX Host Core. The documents under `docs/` explain architecture, lifecycle, operations, and recovery; they do not duplicate package-install commands.

## Before you start

You need a fresh **Ubuntu 24.04 LTS** server and its provider console/recovery access. Keep the original session open until the SSH cutover is proven.

Decide the hostname and environment, for example:

```text
ktx-build-26   build
ktx-dev-26     dev
ktx-prod-26    prod
```

## 1. Get the repository

The only packages installed manually are the ones required to clone KTX itself:

```bash
sudo apt update
sudo apt install -y git ca-certificates
sudo git clone https://github.com/Kansatech/ktx.git /srv/ktx
cd /srv/ktx
./bin/ktx-validate-repo
```

For dev/prod, check out the Host Core tag you intend to deploy before running setup.

## 2. Bootstrap the host and create `ktx`

Example production host:

```bash
sudo ./bin/ktx-init bootstrap --hostname ktx-prod-26 --env prod
```

`bootstrap` installs the normal Host Core dependencies in one pass, initializes `/srv/ktx`, sets UTC/hostname, creates the sudo-capable `ktx` account, and temporarily allows **password SSH for `ktx` only** on port 22.

Root SSH is disabled immediately.

The script prompts you to set the local `ktx` password. That password remains useful for `sudo`, but SSH password authentication will be disabled after the next phase.

## 3. Prove the `ktx` account, then install your public key

**From another terminal on your workstation**, first prove the temporary password login:

```bash
ssh ktx@SERVER
```

If you do not already have a key on your workstation:

```bash
ssh-keygen -t ed25519 -a 64
```

On macOS/Linux (or any workstation with `ssh-copy-id`):

```bash
ssh-copy-id ktx@SERVER
```

Then verify that key authentication works:

```bash
ssh ktx@SERVER
```

Do not continue until that login succeeds using your key.

### Windows without `ssh-copy-id`

PowerShell can append your existing public key with:

```powershell
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub | ssh ktx@SERVER "umask 077; mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys"
```

Then reconnect and verify key login.

## 4. Put all public SSH through SSHPiper

From the still-open `ktx` session:

```bash
sudo /srv/ktx/bin/ktx-init secure-ssh
```

This deliberately changes the path to:

```text
Internet :22
    -> SSHPiper
        -> username ktx
            -> ktx@127.0.0.1:2222
                -> native OpenSSH
```

It also:

- installs the pinned SSHPiper release;
- copies the existing OpenSSH host key to SSHPiper so port 22 keeps the same host identity;
- creates the SSHPiper `ktx` route;
- copies your current public key(s) into that downstream route;
- generates the SSHPiper mapping key used to log into the loopback OpenSSH service;
- moves OpenSSH to **127.0.0.1:2222 only**;
- turns SSH password authentication off;
- starts SSHPiper on public port 22.

**Keep your current session open.** Open another terminal and verify the final path:

```bash
ssh ktx@SERVER
```

There is no public admin port 2222. You always connect to port 22 and SSHPiper decides where the username belongs.

## 5. Finish Host Core

After the new SSHPiper-backed `ktx` login works:

```bash
sudo /srv/ktx/bin/ktx-init finish --acme-email you@example.com
```

`finish` installs/configures the remaining Host Core pieces:

- Docker Engine + Compose plugin from Docker's official Ubuntu repository;
- pinned native Traefik;
- native rsyslog receiver and log rotation;
- Host Core helper command symlinks;
- UFW baseline;
- Traefik ACME state/configuration.

The public baseline becomes:

```text
22/tcp   SSHPiper (including host user ktx)
80/tcp   Traefik HTTP/ACME -> HTTPS
443/tcp  Traefik HTTPS
```

OpenSSH `2222/tcp` exists only on `127.0.0.1` and is never opened in the firewall.

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

The phases are intentionally explicit. Do not rerun `bootstrap` on an established production server just to update it. Host Core updates follow the lifecycle under `docs/04-LIFECYCLE/`.
