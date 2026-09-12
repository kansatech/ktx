# Fresh Ubuntu 24.04 Bootstrap

This starts from a blank Ubuntu 24.04 LTS server.

## Before changing anything

Record:

- intended hostname (`ktx-build-26`, `ktx-dev-26`, or `ktx-prod-26`);
- public/private IPs;
- provider console/recovery access;
- trusted administrator source CIDRs;
- selected KTX Docker private pool (examples use `172.28.0.0/16`);
- GitHub authentication method for `Kansatech/ktx`.

Keep provider-console or existing SSH access available while changing SSH/network/firewall configuration.

## 1. Patch the base OS

```bash
sudo apt update
sudo apt full-upgrade -y
sudo reboot
```

Reconnect.

## 2. Install Git and clone KTX

```bash
sudo apt update
sudo apt install -y git ca-certificates

sudo mkdir -p /srv
sudo git clone https://github.com/Kansatech/ktx.git /srv/ktx
cd /srv/ktx
```

If using GitHub SSH:

```bash
sudo git clone git@github.com:Kansatech/ktx.git /srv/ktx
```

Use the repository's approved release tag for a dev/prod build rather than whatever happens to be current on `main`.

Example:

```bash
sudo git -C /srv/ktx fetch --tags
sudo git -C /srv/ktx checkout --detach v2026.09.11-r2
```

## 3. Initialize ignored local state

```bash
sudo /srv/ktx/bin/ktx-init-layout
```

Edit:

```text
/srv/ktx/config/host.conf
/srv/ktx/config/traefik/traefik.yml
```

for this host.

## 4. Set hostname

Example:

```bash
sudo hostnamectl set-hostname ktx-prod-26
```

Confirm `/etc/hosts` has a sane local hostname entry.

## 5. Install baseline host packages

```bash
sudo apt update
sudo apt install -y   ca-certificates curl gnupg jq git rsync zstd unzip tar   openssh-server chrony rsyslog logrotate ufw acl python3
```

Do not install workload software such as PHP, Apache, MySQL/Percona, Composer, Vaultwarden, or Uptime Kuma on the host.

## 6. Time

```bash
sudo timedatectl set-timezone UTC
systemctl status chrony --no-pager
chronyc tracking
```

## 7. Install/configure Host Core in this order

1. administrator OpenSSH;
2. Docker Engine;
3. KTX helper links/tracked native files:
   ```bash
   sudo /srv/ktx/bin/ktx-apply-host
   ```
4. deterministic Docker network policy;
5. native Traefik;
6. native SSHPiper;
7. native rsyslog receiver;
8. UFW/provider firewall;
9. environment-specific settings.

`ktx-apply-host` links tracked Host Core files into conventional system paths but intentionally does **not** restart services.

## 8. Acceptance

```bash
sudo /srv/ktx/bin/ktx-host-check
```

Then complete `docs/11-CHECKLISTS/new-host.md`.
