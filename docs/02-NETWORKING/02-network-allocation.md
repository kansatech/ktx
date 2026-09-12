# Allocate and Remove Workload Networks

Use `ktx-net`. It reads `KTX_DOCKER_POOL` from `/srv/ktx/config/host.conf`, allocates the next free `/28`, creates a Docker bridge, and records it in `/srv/ktx/config/networks.tsv`.

## Create

```bash
sudo ktx-net create example
```

Example output:

```text
name:       ktx-net-example
subnet:     172.28.0.0/28
gateway:    172.28.0.1
primary_ip: 172.28.0.2
bridge:     ktx0000
```

A template pack then attaches its primary container with the recorded static IP.

## Show

```bash
sudo ktx-net show example
```

## List

```bash
sudo ktx-net list
```

## Remove

Only after the workload has been removed:

```bash
sudo ktx-net remove example
```

The tool refuses to remove a Docker network with attached containers.

## Registry is source-of-truth metadata

Back up:

```text
/srv/ktx/config/networks.tsv
```

If the registry is lost but Docker still exists, it can be reconstructed manually from `docker network inspect`. During a complete host rebuild, the registry lets networks be recreated with the same addresses before workloads are restored.
