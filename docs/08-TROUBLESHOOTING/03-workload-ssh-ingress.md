# Workload SSH Ingress Troubleshooting

Expected path:

```text
workstation -> public TCP 22 -> SSHPiper -> private workload SSH
```

## 1. Prove SSHPiper owns public 22

On the host:

```bash
sudo ss -lntp | grep ':22'
sudo systemctl status sshpiper --no-pager
```

If Ubuntu OpenSSH owns public port 22, the Host Core SSH cutover is incomplete; fix Host Core before debugging a workload route.

## 2. Inspect the route

```bash
sudo /srv/ktx/bin/ssh-route show clienta
```

Confirm the upstream target is correct.

## 3. Understand the two keys

**Downstream:** the workstation/client public key belongs in:

```text
/srv/ktx/config/sshpiper/routes/clienta/authorized_keys
```

**Upstream:** the route's generated `id_rsa.pub` belongs in the upstream SSH account's `authorized_keys`.

Do not copy the workstation private key to the upstream workload.

## 4. Check private reachability

```bash
nc -vz 172.28.4.2 2222
```

Use the actual route address/port.

## 5. Check upstream host trust

The route `known_hosts` must match the SSH host key presented by the private workload address. If the workload was rebuilt with a new host key, update it deliberately after validating the new fingerprint.

## 6. Client debug

```bash
ssh -vvv clienta@PUBLIC_HOST
```

A `Permission denied (publickey)` can occur on either hop. SSHPiper logs help distinguish downstream-key rejection from failure authenticating to the upstream workload.

## Route changes

Normal edits to route files are used by new connections without restarting SSHPiper.
