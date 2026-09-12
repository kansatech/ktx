# Install Docker Engine

Use Docker's official Ubuntu APT repository. Docker currently supports Ubuntu 24.04 LTS.

## Remove conflicting packages

```bash
sudo apt remove -y docker.io docker-compose docker-compose-v2 docker-doc \
  docker-buildx podman-docker containerd runc || true
```

## Add Docker repository

```bash
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin
```

## Configure daemon

Copy the tracked Host Core baseline `/srv/ktx/host/docker/daemon.json` to `/etc/docker/daemon.json`.

The baseline uses Docker's rotating `local` logging driver and live restore:

```bash
sudo install -d -m 0755 /etc/docker
sudo install -o root -g root -m 0644 /srv/ktx/host/docker/daemon.json /etc/docker/daemon.json
```

Baseline contents:

```json
{
  "log-driver": "local",
  "log-opts": {
    "max-size": "20m",
    "max-file": "5"
  },
  "live-restore": true
}
```

Validate and restart:

```bash
sudo dockerd --validate --config-file=/etc/docker/daemon.json
sudo systemctl enable --now docker
sudo systemctl restart docker
```

Verify:

```bash
sudo docker version
sudo docker compose version
sudo docker info
```

## Docker group

Membership in the `docker` group is effectively root-equivalent. KTX administrators should normally use `sudo docker ...` rather than granting casual group membership.

## Firewall warning

Docker documents that published container ports can bypass UFW/firewalld expectations. KTX Core therefore assumes workload template packs do **not** publish public host ports as their normal ingress mechanism. Native Traefik and SSHPiper own public ingress.

Source: https://docs.docker.com/engine/install/ubuntu/
