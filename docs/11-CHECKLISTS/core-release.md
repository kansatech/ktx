# Host Core Release Checklist

- [ ] Working tree understood/clean
- [ ] Host Core version changed intentionally
- [ ] `host/versions.env` pins reviewed
- [ ] `ktx-validate-repo` passes
- [ ] Shell/Python validation passes
- [ ] Native version changes tested on build
- [ ] SSH `ktx` route tested if SSH-related changes exist
- [ ] Traefik route/ACME tested if web-ingress changes exist
- [ ] Docker/network tests pass if affected
- [ ] Reboot test performed when host-service ordering changed
- [ ] Immutable Git tag created
- [ ] Exact tag passes dev
- [ ] Exact same tag deployed to prod
- [ ] Only affected services restarted
- [ ] External post-deploy verification complete
