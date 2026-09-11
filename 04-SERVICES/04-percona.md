# Percona Operation

> **Purpose:** Provision databases without cross-customer credentials.

For site `example`:
```sql
CREATE DATABASE example_app CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER 'example_app'@'%' IDENTIFIED BY 'LONG_RANDOM_SECRET';
GRANT ALL PRIVILEGES ON example_app.* TO 'example_app'@'%';
```
Adjust collation for application compatibility when needed.

Application contract:
```text
DB_HOST=ktx-percona-01
DB_PORT=3306
DB_NAME=example_app
DB_USER=example_app
```
Password comes from the site secret mount.

Never put root/admin credentials in a site container. Never make sites use a dev host mapping such as 33601 internally.

Enable useful slow-query logging with bounded rotation. Before destructive migrations, take a fresh logical dump and test representative migrations on dev.
