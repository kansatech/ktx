# Build and Deploy `ktx-log-01` (rsyslog)

> **Purpose:** Receive TCP syslog from site/infrastructure containers and keep bounded, searchable files under `/srv/ktx/logs`.

## Build

```bash
export KTX_RELEASE=2026.09.10-r2
cd /srv/ktx/platform/templates/images/log
sudo docker build \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  -t ktx/log:${KTX_RELEASE} .
```

## Persistent log path

```bash
sudo mkdir -p /srv/ktx/logs
sudo mkdir -p /srv/ktx/containers/ktx-log-01
sudo cp /srv/ktx/platform/templates/rsyslog/receiver.conf.example \
  /srv/ktx/containers/ktx-log-01/10-ktx-receiver.conf
sudo cp /srv/ktx/platform/templates/containers/log/compose.yml.example \
  /srv/ktx/containers/ktx-log-01/compose.yml
```

## Start

```bash
cd /srv/ktx/containers/ktx-log-01
sudo docker compose up -d
sudo /srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh
```

No host port is published. Sites reach TCP 514 only because `ktx-log-01` joins their private network.

## Verify receiver

```bash
sudo docker exec ktx-log-01 rsyslogd -N1
sudo docker logs --tail=100 ktx-log-01
```

From a site container:

```bash
logger --tcp --server ktx-log-01 --port 514 'KTX log test'
```

Then confirm the message appeared beneath `/srv/ktx/logs`.

## Rotation

The persistent files live on the host, so install the supplied host logrotate policy:

```bash
sudo cp /srv/ktx/platform/templates/host/logrotate-ktx.example /etc/logrotate.d/ktx
sudo logrotate -d /etc/logrotate.d/ktx
```

After the dry run looks correct, normal host logrotate handles daily retention. The example keeps 30 compressed rotations; change that deliberately if your volume/retention needs differ. Check disk growth weekly.

### Source

https://docs.rsyslog.com/doc/configuration/modules/imtcp.html
