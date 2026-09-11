# Docker Engine Installation

> **Purpose:** Install the supported engine consistently and avoid logging/firewall surprises.

Docker currently supports Ubuntu 24.04 LTS. Use Docker's official APT repository.

## Remove conflicts
```bash
sudo apt remove -y docker.io docker-compose docker-compose-v2 docker-doc docker-buildx podman-docker containerd runc || true
```

## Repository + install
```bash
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
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
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
```

## Logging
Docker recommends the `local` driver for ordinary non-Kubernetes hosts because it rotates by default. Use `/etc/docker/daemon.json`:
```json
{
  "log-driver": "local",
  "log-opts": {"max-size":"20m","max-file":"5"},
  "live-restore": true
}
```
Validate/restart Docker, then recreate old containers later if you want them to adopt a changed logging driver.

## Base networks
```bash
sudo docker network create ktx-control
sudo docker network create ktx-management
```

## Docker group
Treat membership as root-equivalent. On prod, `sudo docker ...` is preferable to broadly granting Docker group access.

## Important firewall fact
Docker documents that published ports can bypass expected UFW/firewalld behavior. Minimize published ports and use provider firewall + `DOCKER-USER` policy where needed.
