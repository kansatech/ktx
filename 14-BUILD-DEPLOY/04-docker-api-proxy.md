# Build and Deploy `ktx-dockerapi-01`

> **Purpose:** Give Traefik the Docker metadata it needs without giving Traefik a raw Docker socket.

## Build

```bash
export KTX_RELEASE=2026.09.10-r2
cd /srv/ktx/platform/templates/images/dockerapi
sudo docker build \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  -t ktx/dockerapi:${KTX_RELEASE} .
```

The image runs nginx and only forwards an allowlist of **GET/HEAD** Docker API paths used for discovery/events. Mutation methods are denied.

## Deploy

```bash
sudo mkdir -p /srv/ktx/containers/ktx-dockerapi-01
sudo cp /srv/ktx/platform/templates/containers/dockerapi/compose.yml.example \
  /srv/ktx/containers/ktx-dockerapi-01/compose.yml

sudo docker network inspect ktx-control >/dev/null || sudo docker network create ktx-control

cd /srv/ktx/containers/ktx-dockerapi-01
sudo docker compose up -d
```

## Verify read access

From another temporary container on `ktx-control`:

```bash
sudo docker run --rm --network ktx-control curlimages/curl:8.12.1 \
  -fsS http://ktx-dockerapi-01:2375/_ping
```

Expected: `OK`.

## Verify mutation is blocked

A POST should be rejected:

```bash
sudo docker run --rm --network ktx-control curlimages/curl:8.12.1 \
  -i -X POST http://ktx-dockerapi-01:2375/containers/create
```

Expect 403/405, not a created container.

## If a Traefik upgrade needs another read endpoint

Do **not** open the whole Docker API. Check the dockerapi access/error log, determine the exact GET endpoint needed, add that path to the nginx allowlist on build, test on dev, then promote the updated image.

The socket itself remains a privileged object. Only this small internal container receives it.
