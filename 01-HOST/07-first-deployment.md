# First Deployment Order

> **Purpose:** Bring a blank KTX host online in dependency order.

1. Create `ktx-control` and `ktx-management`.
2. Deploy `ktx-dockerapi-01`.
3. Deploy `ktx-proxy-01`.
4. Deploy `ktx-percona-01`.
5. Deploy `ktx-mail-01`.
6. Deploy `ktx-log-01`.
7. Deploy `ktx-ssh-01`.
8. Deploy `ktx-backup-01`.
9. Deploy monitoring/utilities.
10. Create first `ktx-site-<slug>` network.
11. Attach only required shared services.
12. Deploy first site.
13. Configure DNS.
14. Verify HTTPS/app/DB/mail/SSH/logs.
15. Verify backup.
16. Perform a test restore.
