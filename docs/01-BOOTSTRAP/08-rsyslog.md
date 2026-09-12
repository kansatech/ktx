# Native rsyslog Receiver

KTX uses Ubuntu's native rsyslog daemon for low-overhead workload log collection.

## 1. Initialize layout

```bash
sudo /srv/ktx/bin/ktx-init-layout
sudo install -d -m 0750 -o syslog -g adm /srv/ktx/logs/remote
```

## 2. Apply tracked Host Core receiver files

```bash
sudo /srv/ktx/bin/ktx-apply-host
```

This links:

```text
/etc/rsyslog.d/30-ktx-remote.conf -> /srv/ktx/host/rsyslog/30-ktx-remote.conf
/etc/logrotate.d/ktx-remote       -> /srv/ktx/host/logrotate/ktx-remote
```

Validate and restart:

```bash
sudo rsyslogd -N1
sudo systemctl restart rsyslog
```

## Workload contract

A module sends syslog TCP to its Docker bridge gateway:

```text
<workload subnet>.1:514/TCP
```

Example:

```text
172.28.4.0/28 -> 172.28.4.1:514
```

Logs land under:

```text
/srv/ktx/logs/remote/<hostname>/<program>.log
```

## Verify

```bash
sudo ss -lntp | grep ':514 '
sudo journalctl -u rsyslog -n 50 --no-pager
sudo logrotate -d /etc/logrotate.d/ktx-remote
```

Provider firewall must never expose TCP 514 publicly.
