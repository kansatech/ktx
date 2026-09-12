# Host Threat Model

KTX Core is designed to reduce the chance that compromise of one hosted workload becomes host compromise.

Primary host threats:

- vulnerable public Traefik or SSHPiper;
- stolen administrator SSH key;
- Docker daemon/API access;
- kernel/container escape;
- malicious or compromised workload attempting lateral/host access;
- accidental public port publishing;
- poisoned Host Core artifact/supply chain;
- destructive administrator mistake;
- disk/resource exhaustion.

Important boundary: Docker containers share the host kernel. Workload isolation is materially better than one shared PHP process tree, but is not the same as separate hypervisors/VMs against kernel escape vulnerabilities.
