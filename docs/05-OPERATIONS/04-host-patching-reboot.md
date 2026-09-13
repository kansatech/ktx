# Host Patching and Reboot

Before patching/rebooting production:

```bash
sudo /srv/ktx/bin/host-check
sudo docker ps
sudo df -h
sudo free -h
```

Confirm provider console/recovery access is available because normal network administration goes through SSHPiper.

Patch the host using the normal Ubuntu package lifecycle. Docker Engine and pinned native Traefik/SSHPiper updates follow their Host Core lifecycle documents rather than being casually replaced during unrelated maintenance.

After reboot:

```bash
ssh ktx@SERVER
sudo /srv/ktx/bin/host-check
```

Verify in order:

1. SSHPiper public port 22;
2. `ktx` route to loopback OpenSSH;
3. Docker;
4. Traefik 80/443;
5. rsyslog;
6. workload modules.
