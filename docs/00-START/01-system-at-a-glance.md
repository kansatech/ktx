# System at a Glance

KTX Host Core is the native infrastructure layer underneath separately versioned container modules.

```text
                         Internet
                            |
                 +----------+----------+
                 |                     |
               80/443                  22
                 |                     |
          native Traefik        native SSHPiper
                 |                     |
          workload routes       +------+----------------+
                                |                       |
                              ktx                  workload users
                                |                       |
                         127.0.0.1:2222           private container IP
                                |
                         native OpenSSH
```

The host itself is administered as:

```bash
ssh ktx@SERVER
```

There is no special public admin SSH port. SSHPiper routes the unique username `ktx` back to loopback OpenSSH. Root SSH is disabled.

Docker workloads receive deterministic private networks and do not normally publish public ports. Native Traefik and SSHPiper route into those private addresses.

Fresh installation is defined only by [`INSTALL.md`](../../INSTALL.md).
