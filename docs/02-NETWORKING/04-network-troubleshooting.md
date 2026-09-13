# Network Troubleshooting

## Inventory

```bash
sudo /srv/ktx/bin/net list
sudo docker network ls
sudo docker network inspect ktx-net-example
ip route | grep 172.28
```

## Can host reach primary workload?

```bash
curl -v http://172.28.4.2:8080/
nc -vz 172.28.4.2 2222
```

Use the actual ports declared by the template.

## Common failures

**No route to host:** Docker network missing, wrong subnet registry, container not attached, or host firewall/routing issue.

**Connection refused:** route is fine; nothing is listening on that container IP/port.

**Works from host but not Traefik:** inspect the generated dynamic routing file and Traefik logs.

**Works from host but not SSHPiper:** inspect the route directory, downstream key, mapping key, and known_hosts.

Never fix a routing mistake by publishing the container port publicly "just to see if it works" on prod.
