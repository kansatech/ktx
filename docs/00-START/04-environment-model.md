# Environment Model

The three hosts have the same conceptual layout but different permissions and purposes.

| Capability | build | dev | prod |
|---|---|---|---|
| Compile SSHPiper | Yes | No | No |
| Download upstream release artifacts | Yes | Only to troubleshoot | No during normal deployment |
| Test new Host Core release | First-pass | Full integration | No; consumes approved release |
| Traefik | Installed | Installed | Installed |
| SSHPiper | Installed/testable | Installed/testable | Installed/public if offered |
| Real Let's Encrypt | Normally no | Only test domains if needed | Yes |
| Host admin SSH | 2222 | 2222 | 2222, restricted |
| Public workload data | No | Sanitized/test only | Yes |
| Docker debug/private host port mappings | Allowed when documented | Allowed on trusted interfaces | Avoid/deny |

The environment-specific documents in `09-ENVIRONMENTS/` contain the exceptions. Core files do not hide environment behavior behind clever `IF ENV=...` shell branches.
