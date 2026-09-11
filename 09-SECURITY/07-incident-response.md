# Incident Response

> **Purpose:** Give suspected compromise a repeatable sequence.

1. Contain affected site/service.
2. Preserve logs, files, metadata, process/network evidence as appropriate.
3. Determine scope: site files only? DB/mail? shared infra? host/Docker?
4. Revoke external access matching scope.
5. Rotate credentials matching plausible exposure.
6. Prefer clean trusted runtime + known-good app over “disinfecting” an unknown container.
7. Restore/clean data.
8. Patch root cause before reopening.
9. Monitor closely.
10. Document and update controls/playbook.

If host/kernel/Docker control plane may be compromised, rebuild the host from trusted artifacts rather than trusting container-level cleanup.
