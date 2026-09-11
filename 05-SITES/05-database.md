# Site Database

> **Purpose:** Keep application credentials scoped to one schema.

Default database/user: `<slug>_app` with a long unique password.

Grant only that database. Avoid global privileges unless a documented app requirement demands them.

Inside the site, connect to `ktx-percona-01:3306`.

Before irreversible migrations: fresh dump, record app/image version, test on dev, deploy, verify, retain rollback data.
