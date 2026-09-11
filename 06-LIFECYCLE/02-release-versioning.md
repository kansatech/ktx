# Release Versioning

> **Purpose:** Make every running runtime traceable.

Use immutable tags such as `2026.09.10-r1`. Any changed bytes require a new release number.

Release manifest records source commit, build UTC time, base/runtime versions, image IDs, archive SHA256 values, and human change summary.

Every site manifest records its expected image tag.
