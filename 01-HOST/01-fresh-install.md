# Fresh Ubuntu 24.04 Host

> **Purpose:** Turn a clean Ubuntu image into a KTX host before containers are deployed.

## 1. Record facts first
Hostname, management/public IPs, gateway/DNS, trusted admin source IPs, disk layout, and (prod) backup destination.

## 2. Patch base OS
```bash
sudo apt update
sudo apt full-upgrade -y
sudo reboot
```

## 3. Hostname
```bash
sudo hostnamectl set-hostname ktx-prod-26
```
Use the correct environment name.

## 4. Basic host tools
```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg jq git rsync zstd unzip   openssh-server chrony logrotate acl iptables-persistent
```
Do **not** install Apache/PHP/Percona/Composer/Postfix on the host just because containers need them.

## 5. Create KTX root
```bash
sudo mkdir -p /srv/ktx/{platform,containers,sites,data,secrets,backups,releases,logs}
sudo chown root:root /srv/ktx
sudo chmod 0755 /srv/ktx
sudo chmod 0700 /srv/ktx/secrets
```

## 6. Time
```bash
sudo timedatectl set-timezone UTC
systemctl status chrony --no-pager
chronyc tracking
```

## 7. Configure host SSH
Follow `05-host-ssh.md`. Keep the current session open and verify a second session before changing firewall rules.

## 8. Install Docker
Follow `03-docker.md` using Docker's official repository.

## 9. Firewall
Follow `04-firewall.md`. Docker-published ports require deliberate netfilter/provider-firewall thinking; do not assume UFW alone hides them.

## 10. Install platform definitions
Put version-controlled Dockerfiles/config/templates/playbook under `/srv/ktx/platform`. Secrets stay outside Git.

## 11. Environment-specific work
- Build: install compilers/toolchains only here.
- Dev: import a release built on build.
- Prod: import a release already proven on dev, then configure production secrets, ACME, backup and monitoring.

## 12. Acceptance
```bash
hostname
timedatectl
docker version
docker compose version
docker info
df -h
free -h
ss -lntup
```
Then use `11-CHECKLISTS/new-host.md`.
