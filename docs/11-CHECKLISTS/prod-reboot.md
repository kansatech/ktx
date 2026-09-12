# Production Reboot Checklist

- [ ] Host admin SSH/provider console available
- [ ] `ktx-host-check` clean before reboot
- [ ] Disk/memory sane
- [ ] No known workload restore/migration in progress
- [ ] Recovery/backup status acceptable according to template packs
- [ ] Reboot
- [ ] Reconnect on 2222
- [ ] `ktx-host-check`
- [ ] Docker workloads present
- [ ] Representative web route works
- [ ] Representative SSH route works
- [ ] rsyslog receiving
- [ ] Monitoring/alerts clear
