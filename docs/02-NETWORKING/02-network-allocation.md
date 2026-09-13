# Allocate and Remove Workload Networks

Use `/srv/ktx/bin/net`. It reads `KTX_DOCKER_POOL` from `/srv/ktx/config/host.conf`, allocates the next free `/28`, creates a Docker bridge, and records it in `/srv/ktx/config/networks.tsv`.

## Create

```bash
sudo /srv/ktx/bin/net create example
```

Example output:

```text
name:       ktx-net-example
subnet:     172.28.0.0/28
gateway:    172.28.0.1
primary:    172.28.0.2
bridge:     ktx0000
```

A module then attaches its primary container with the recorded static IP.

## Show

```bash
sudo /srv/ktx/bin/net show example
```

## List

```bash
sudo /srv/ktx/bin/net list
```

## Remove

Only after the workload has been removed:

```bash
sudo /srv/ktx/bin/net remove example
```

The tool refuses to remove a Docker network with attached containers.

## Registry is source-of-truth metadata

Back up:

```text
/srv/ktx/config/networks.tsv
```

If the registry is lost but Docker still exists, it can be reconstructed manually from `docker network inspect`. During a complete host rebuild, the registry lets networks be recreated with the same addresses before workloads are restored.

## Registry safety and recovery

Mutations are serialized with a host lock. The tool rejects malformed/duplicate
rows and a changed address pool rather than silently ignoring them. If Docker
creation fails, no row is saved. If saving a new row fails, the tool attempts to
remove that new empty network. Failed removal does not free its registry entry.
Review any interrupted operation against `docker network inspect` before retrying.

After a rebuild, `create` deliberately refuses to reallocate an existing row.
From the console, recreate **only a missing** network with the exact values from
`net show`. Example for the first recorded allocation:

```bash
sudo /srv/ktx/bin/net show example
sudo docker network inspect ktx-net-example
```

If Docker reports it is absent and the registry values match this example:

```bash
sudo docker network create --driver bridge \
  --subnet 172.28.0.0/28 --gateway 172.28.0.1 \
  --opt com.docker.network.bridge.name=ktx0000 ktx-net-example
```

The registry is retained unchanged. Reattach workloads only after verifying the
network. For other rows, use their recorded values, including the bridge name.
Do not delete an allocation row to get a different address. If an interrupted
removal left a stale row, keep its address reserved until you have verified that
no routes or workloads still use it, then repair the registry from a protected
backup or by a reviewed edit with no allocator running.
