# Build and Deploy `ktx-ssh-01` (SSHPiper)

> **Purpose:** Route one public TCP 22 endpoint to private site sshd instances by external username.

## Version

Pin a tagged SSHPiper v1 release. The working-directory plugin is the routing model used here.

Example:

```bash
export SSHPIPER_VERSION=v1.5.4
export KTX_RELEASE=2026.09.10-r2
```

## Build

```bash
cd /srv/ktx/platform/templates/images/sshpiper
sudo docker build \
  --build-arg SSHPIPER_VERSION=${SSHPIPER_VERSION} \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  -t ktx/sshpiper:${KTX_RELEASE} .
```

Verify:

```bash
sudo docker run --rm ktx/sshpiper:${KTX_RELEASE} --help
```

## Persistent working directory

```bash
sudo mkdir -p /srv/ktx/data/ssh-01/{workingdir,hostkeys}
sudo chown -R 10001:10001 /srv/ktx/data/ssh-01
sudo chmod 0700 /srv/ktx/data/ssh-01/workingdir /srv/ktx/data/ssh-01/hostkeys
```

Copy Compose:

```bash
sudo mkdir -p /srv/ktx/containers/ktx-ssh-01
sudo cp /srv/ktx/platform/templates/containers/sshpiper/compose.yml.example \
  /srv/ktx/containers/ktx-ssh-01/compose.yml
```

## Add route for site `example`

```bash
sudo mkdir -p /srv/ktx/data/ssh-01/workingdir/example
sudo chown 10001:10001 /srv/ktx/data/ssh-01/workingdir/example
sudo chmod 0700 /srv/ktx/data/ssh-01/workingdir/example
```

Create:

```text
/srv/ktx/data/ssh-01/workingdir/example/sshpiper_upstream
```

containing:

```text
site@ktx-web-example-01:2222
```

Put the customer's public key in:

```text
.../example/authorized_keys
```

Generate the SSHPiper server host key once and persist it:

```bash
sudo -u '#10001' ssh-keygen -q -t ed25519 -N '' \
  -f /srv/ktx/data/ssh-01/hostkeys/ssh_host_ed25519_key
```

Generate a gateway-to-upstream RSA key (the workingdir plugin expects `id_rsa`):

```bash
sudo -u '#10001' ssh-keygen -q -t rsa -b 3072 -N '' \
  -f /srv/ktx/data/ssh-01/workingdir/example/id_rsa
```

Install its `.pub` key in the site's internal `site` account authorized-keys file:

```bash
sudo cp /srv/ktx/data/ssh-01/workingdir/example/id_rsa.pub /tmp/example-sshpiper.pub
sudo sh -c 'cat /tmp/example-sshpiper.pub >> /srv/ktx/sites/example/ssh/authorized_keys'
sudo chmod 0644 /srv/ktx/sites/example/ssh/authorized_keys
sudo rm -f /tmp/example-sshpiper.pub
```

Create `known_hosts` from the **persistent site SSH host key**, not by blindly accepting whichever machine answers today.

## Start

```bash
cd /srv/ktx/containers/ktx-ssh-01
sudo docker compose up -d
sudo /srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh
```

## Verify

```bash
ssh -vv example@YOUR_SSH_HOST
```

The external login selects the route; upstream login remains `site`.

## Production host administration

Keep host administration separate (for example restricted TCP 2222 on host sshd). Do not make SSHPiper the only route to the host itself.

### Sources

- https://github.com/tg123/sshpiper
- https://pkg.go.dev/github.com/tg123/sshpiper/plugin/workingdir
