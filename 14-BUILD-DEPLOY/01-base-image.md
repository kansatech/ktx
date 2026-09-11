# Build `ktx/base`

> **Purpose:** Produce the Ubuntu 24.04 foundation inherited by KTX core images.

## Files

```text
templates/images/base/Dockerfile
```

## Build

```bash
export KTX_RELEASE=2026.09.10-r2
cd /srv/ktx/platform/templates/images/base
sudo docker build --pull -t ktx/base:${KTX_RELEASE} .
```

## Verify

```bash
sudo docker run --rm ktx/base:${KTX_RELEASE} bash -lc '
  cat /etc/os-release
  getent hosts example.com
  curl --version
'
```

## Record package inventory

```bash
sudo docker run --rm ktx/base:${KTX_RELEASE} \
  dpkg-query -W -f='${Package}\t${Version}\n' \
  | sort > /srv/ktx/releases/${KTX_RELEASE}-base-packages.txt
```

## Child-image rule

Rebuilding `ktx/base` does **not** update already-built child images. Rebuild every child image that should receive the new base packages, then follow the build -> dev -> prod promotion lifecycle.
