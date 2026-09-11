# Common Commands

> **Purpose:** A crib sheet for the commands future-you will not remember.

```bash
# containers
docker ps
docker ps -a
docker stats
docker logs --tail=200 NAME
docker inspect NAME
docker exec -it NAME bash

# networks
docker network ls
docker network inspect ktx-site-example
docker network connect ktx-site-example NAME
docker network disconnect ktx-site-example NAME

# images
docker image ls
docker image inspect IMAGE
docker system df

# compose
docker compose config
docker compose up -d
docker compose up -d --force-recreate
docker compose down
docker compose logs --tail=200

# host
ss -lntup
df -h
df -i
free -h
journalctl -u docker --since today
```
