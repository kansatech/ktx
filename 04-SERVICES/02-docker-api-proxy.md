# Restricted Docker API Proxy

> **Purpose:** Allow Traefik discovery without handing an internet-facing process host control.

Mount `/var/run/docker.sock` only into `ktx-dockerapi-01`, never into Traefik or a site container.

The API proxy should permit only discovery/event reads Traefik requires, such as container/network listing/inspection and events. Deny mutation operations: create/start/stop/exec/build/delete/network changes.

It joins only `ktx-control`, publishes no host port, and listens internally for Traefik.

A read-only filesystem mount of `docker.sock` does **not** magically make Docker's API read-only. The restriction must happen at the API/proxy layer.
