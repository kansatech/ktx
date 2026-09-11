# Database Problems

> **Purpose:** Separate DNS/network/auth/query/resource causes.

Inside site:
```bash
getent hosts ktx-percona-01
```
If it does not resolve, inspect network membership.

Then verify TCP 3306 and authenticate using **site credentials**, not root.

Common causes: wrong secret, wrong DB name, grants, Percona unhealthy, restored schema without matching grants, slow/locked queries, full disk, IO pressure.

Do not restart Percona as the first diagnostic step; it interrupts every DB-backed site and destroys useful transient state.
