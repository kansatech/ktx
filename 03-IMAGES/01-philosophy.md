# Image Philosophy

> **Purpose:** Own reproducible build recipes without reimplementing upstream software.

A KTX-owned image means the Dockerfile/build context and version pinning are yours. It does not mean writing Apache, PHP, Traefik, or Percona yourself.

Use Ubuntu 24.04 LTS as the normal KTX base for compatibility and operational consistency. Alpine's smaller disk footprint is not worth introducing musl/runtime differences for this platform.

Never make a permanent prod fix with `docker exec apt install ...`. Experiment there if necessary, then move the change into the Dockerfile, rebuild, test, promote, and recreate.

Recommended hierarchy:
```text
ubuntu:24.04
  -> ktx/base
       -> ktx/web-php85
       -> ktx/percona84
       -> ktx/proxy
       -> ktx/mail
       -> ktx/log
       -> ktx/backup
       -> ktx/ssh
```
