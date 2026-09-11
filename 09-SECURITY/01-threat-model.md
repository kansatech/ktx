# Threat Model

> **Purpose:** State what the isolation design is trying to contain.

Primary threats: compromised WordPress/plugin/app, stolen customer key, brute force, leaked secrets, vulnerable proxy/shared service, malicious uploads/code execution, destructive admin error, ransomware, supply-chain compromise.

A compromised site should not automatically reveal other site files/DB credentials, Docker control, host root, Vaultwarden, backups, or other customer SSH.

Containers share the host kernel. This is much stronger isolation than a shared Apache/PHP account model, but not equivalent to independent VMs against every kernel/container escape. Patch host/Docker and minimize privilege.
