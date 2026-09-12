# Install Native SSHPiper

SSHPiper owns public TCP 22 for workload/customer SSH. Host administrator OpenSSH remains separate on TCP 2222.

## Release rule

SSHPiper is built and verified on `ktx-build-26`. Dev/prod install the exact promoted `sshpiperd` and `workingdir` binaries from the approved Host Core release artifacts.

## 1. Create service account

```bash
sudo useradd --system --home /nonexistent --shell /usr/sbin/nologin sshpiper || true
```

## 2. Initialize and permission KTX paths

```bash
sudo /srv/ktx/bin/ktx-init-layout

sudo chown -R sshpiper:sshpiper /srv/ktx/config/sshpiper
sudo chmod 0700 /srv/ktx/config/sshpiper /srv/ktx/config/sshpiper/routes

sudo chown -R sshpiper:sshpiper /srv/ktx/secrets/sshpiper
sudo chmod 0700 /srv/ktx/secrets/sshpiper

sudo install -d -o root -g root -m 0755 /usr/local/libexec/sshpiper
```

## 3. Install promoted binaries

```bash
RELEASE=2026.09.11-r2

cd "/srv/ktx/releases/${RELEASE}"
sha256sum -c SHA256SUMS

sudo install -o root -g root -m 0755   artifacts/sshpiperd   /usr/local/libexec/sshpiper/sshpiperd

sudo install -o root -g root -m 0755   artifacts/workingdir   /usr/local/libexec/sshpiper/workingdir
```

## 4. Apply tracked Host Core files

```bash
sudo /srv/ktx/bin/ktx-apply-host
```

The tracked systemd service reads routes from:

```text
/srv/ktx/config/sshpiper/routes
```

and keeps its server private key in:

```text
/srv/ktx/secrets/sshpiper/server_key
```

## 5. Start

```bash
sudo systemctl enable --now sshpiper
sudo systemctl status sshpiper --no-pager
```

The service runs as `sshpiper` and receives only `CAP_NET_BIND_SERVICE` for TCP 22.

## 6. Verify

```bash
sudo ss -lntp | grep ':22 '
sudo journalctl -u sshpiper -n 100 --no-pager
```

With no route directories, customer logins are denied. That is expected.

## Route model

Each external login is:

```text
/srv/ktx/config/sshpiper/routes/<login>/
```

Use `ktx-ssh-route` instead of hand-building route directories.

Sources:
- https://github.com/tg123/sshpiper
- https://pkg.go.dev/github.com/tg123/sshpiper/plugin/workingdir
