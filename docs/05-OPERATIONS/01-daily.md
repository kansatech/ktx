# Daily Checks

Automate alerts where convenient, but these are the useful host questions:

```bash
sudo ktx-host-check
sudo docker ps
sudo docker stats --no-stream
free -h
df -h
sudo ufw status
```

Review:

- Traefik/SSHPiper/sshd/Docker/rsyslog active;
- unexpected stopped/restarting workloads;
- disk >80%;
- repeated OOM events;
- certificate or ingress failures;
- SSH authentication anomalies;
- host security/reboot-required state.
