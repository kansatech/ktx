# Rollback

> **Purpose:** Return to a prior runtime without pretending data changes reverse themselves.

If only runtime changed: set previous immutable image tag, recreate, verify.

If application/schema changed, runtime rollback may not reverse DB migrations or generated data. Use the pre-change file/database backup and app-specific rollback plan.

Keep prior images/releases until the rollback window expires. Record failed release, symptoms, rollback release, any restored data, and root cause.
