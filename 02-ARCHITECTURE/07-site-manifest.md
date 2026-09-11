# Site Manifest

> **Purpose:** Make intended state readable without inspecting Docker internals.

Every site has `/srv/ktx/sites/<slug>/manifest.yml` recording:
- slug/container
- runtime image/tag
- domains
- Docker network
- DB name/user (never password)
- SSH enabled/external login
- mail enabled
- memory/PID limits
- special runtime/config exceptions
- backup tier/notes

During disaster recovery, manifests answer “what should exist?” before Docker state exists.
