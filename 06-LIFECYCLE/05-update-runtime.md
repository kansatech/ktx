# Update Apache / Ubuntu Packages / Composer

> **Purpose:** Patch the standard runtime as one controlled image change.

Change build context, make a new release, run Apache config test + runtime health tests, import to dev, promote exact image, recreate prod in batches.

Container OS packages do not become patched merely because the host was patched. Rebuild child images when base package security fixes need to reach containers.

Do not run unattended-upgrades inside normal KTX containers; runtime mutation defeats reproducibility.
