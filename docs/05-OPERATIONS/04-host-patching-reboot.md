# Host Patching and Reboot

Ubuntu 24.04 includes unattended-upgrades support. KTX permits automatic security package installation but prefers controlled production reboots.

## Check

```bash
sudo apt update
apt list --upgradable
test -f /var/run/reboot-required && cat /var/run/reboot-required
```

## Before prod reboot

Confirm:

```bash
sudo ktx-host-check
sudo docker ps
sudo docker network ls
sudo ss -lntup
df -h
free -h
```

Also confirm current workload/backups according to their separate template packs.

## Reboot

```bash
sudo reboot
```

## After reconnecting on admin port 2222

```bash
sudo ktx-host-check
sudo docker ps
sudo ktx-net list
```

Then test one known public web route and one public SSH route if those services are enabled.

Source: https://documentation.ubuntu.com/security/security-updates/
