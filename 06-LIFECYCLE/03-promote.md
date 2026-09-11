# Promote Image Bundles

> **Purpose:** Move exact images without requiring a private registry.

Build exports compressed `docker save` archives + `SHA256SUMS` + manifest.

Transfer with authenticated `rsync/scp`, verify checksum at every receiving host, then `docker load` the archive.

Prod receives the same release directory dev received. Do not transfer the Dockerfile to prod and rebuild it there.
