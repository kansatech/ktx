# Secrets

> **Purpose:** Keep credentials out of images, Git, command history, and unrelated containers.

Root layout:
```text
/srv/ktx/secrets/infrastructure/
/srv/ktx/secrets/sites/<slug>/
```

Rules:
- never bake a secret into an image layer
- never commit real `.env` secrets
- never use Docker build args for secrets
- mount only into containers that need them
- prefer read-only secret mounts
- unique DB password per site
- scope mail/DNS/API credentials as narrowly as providers allow
- rotate credentials after relevant compromise

Protect root:
```bash
sudo chown -R root:root /srv/ktx/secrets
sudo chmod 0700 /srv/ktx/secrets
```

If restic backs up secrets into an encrypted repository, keep the restic repository password separately/offline. An encrypted backup with a lost key is merely a very durable collection of random bytes.
