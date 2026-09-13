# Production Reboot Checklist

- [ ] Provider console/recovery access available
- [ ] `/srv/ktx/bin/host-check` clean before reboot
- [ ] Backups/current change state known
- [ ] Reboot host
- [ ] `ssh ktx@SERVER` works through SSHPiper
- [ ] `/srv/ktx/bin/host-check` clean after reboot
- [ ] Public web routes checked
- [ ] Representative workload SSH route checked if applicable
