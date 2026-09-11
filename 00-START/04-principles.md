# Operating Principles

> **Purpose:** Rules for edge cases not explicitly covered elsewhere.

- Prefer replacement over hand-repair of containers.
- If deletion of a container loses something important, persistence is wrong.
- Image tag is part of site configuration.
- No `latest` on prod.
- One customer's compromise should not expose another customer's files or credentials.
- Shared services authenticate/authorize per site where practical.
- The host is infrastructure, not a convenient place for app dependencies.
- A tested restore procedure matters more than a pretty backup dashboard.
- Logs must be useful but bounded.
- Measure before scaling.
- Change one platform layer at a time.
- Document every site exception in its manifest.
