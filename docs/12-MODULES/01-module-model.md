# Module Model

A KTX module owns one reusable workload/runtime family.

It should answer:

- how the Docker image is built;
- what image name/version it produces;
- how a container instance is configured;
- what persistent data it owns;
- what secrets it needs;
- what private ports it exposes;
- whether it requests Host Core web/SSH ingress;
- how it is updated;
- how it is backed up/restored;
- how it is monitored and troubleshot.

Host Core remains ignorant of the application itself.

## Examples

`ktx-webphp85` might produce a PHP/Apache site runtime.

`ktx-percona84` might produce a Percona 8.4 database runtime.

Both consume the same Host Core network/ingress conventions but have entirely separate repositories and release histories.
